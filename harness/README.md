# harness —— 数字员工平台（代码）

> 设计文档：[`../document/harness/`](../document/harness/)（01 总体设计 / 02 对抗评审 / 03 协议与数据模型 / 04 落地路线与验收）
> 本目录是 **M0 地基阶段** 的实现。ADR-001：harness 独立部署、独立演进，只通过 `/api/harness/**` 与 portal 交互；本目录不改动 portal 的任何既有逻辑。

## 工具链

| 组件 | 版本 | 说明 |
|---|---|---|
| JDK | 21 (Temurin) | `java -version` |
| Maven | 3.9.9 | `mvn -v` |
| MySQL | 8.x（已验证 8.4.13） | harness 独立库；**不复用** portal 库 |
| Docker | 任意 | 仅用于 `db/verify.sh` 的临时校验实例 |

```bash
mvn -B package          # 编译 + 全部单元测试
mvn -B -o package       # 离线
./db/verify.sh          # 真实 MySQL 8 上跑迁移并断言契约（临时容器，跑完即删）
```

## 模块

| 模块 | 内容 | 状态 |
|---|---|---|
| `harness-db` | Flyway 迁移：`03 §2` 冻结 schema + 治理/种子/修正增量 | ✅ 已在 MySQL 8.4 验证 |
| `harness-protocol` | UUIDv7（RFC 9562）、TCP 帧编解码与命令码表、能力令牌、事件信封与去重指纹、规范化 JSON | ✅ 42 tests |
| `harness-policy` | `能力 ∩ 作用域 ∩ TTL` 决策引擎、自治等级、审批状态机（自然人锚点）、升级路由（2 跳上限）、自动降级 | ✅ 49 tests |
| `harness-platform` | Spring Boot 3：HMAC 身份、Agent 注册与生命周期、授权、事件总线、审批、终端接入、Kill-Switch、审计、看板 API | ✅ 52 tests（真实 MySQL 8.4） |
| `harness-terminal` | 终端运行时：设备身份、绑定码流程、平台客户端、本地拒绝策略、审批验签 | ✅ 17 tests |
| `harness-adapter-portal` | portal 只读同步、规范化镜像、权限串/时间严格解析、脏数据队列 | ✅ 20 tests（双 MySQL 容器） |
| `tools/` | 跨系统契约校验（portal ↔ platform HMAC 互认） | ✅ |
| `db/portal/` | portal 侧仅 3 处 ALTER 的**手工**脚本（禁止自动执行） | ✅ |

### harness-platform 运行

```bash
export HARNESS_DB_URL='jdbc:mysql://127.0.0.1:3306/harness?connectionTimeZone=UTC&forceConnectionTimeZoneToSession=true'
export HARNESS_DB_USER=harness HARNESS_DB_PASSWORD=...
export HARNESS_REDIS_HOST=127.0.0.1
export HARNESS_BOOTSTRAP_SECRET='至少 24 位的随机串'   # 不设置则平台拒绝一切 API 调用
export HARNESS_HUMAN_CLIENT_ID=harness-admin          # 第一个自然人控制台账号
export HARNESS_HUMAN_SECRET='至少 24 位的随机串'
export HARNESS_HUMAN_EMPLOYEE_ID=1                     # portal.employee.id
java -jar harness-platform/target/harness-platform-0.1.0-SNAPSHOT.jar
```

> **没有自然人账号就没有平台**。所有治理动作（授权、审批、Kill-Switch、Agent 生命周期、终端绑定）
> 都要求"调用者是自然人"，判定看的是 `harness_principal.principal_type`（必须是 `human`），
> 不是"有没有 employee_id"。没有 `HARNESS_HUMAN_*` 时这些端点一律 403，这是刻意的。

Flyway 在启动时自动建表并灌入 12 个内置 Agent 模板与 16 个内建能力（V3）。
第一个服务账号由 `harness.bootstrap.secret` 在启动时派生，**迁移文件里不预置任何口令**。

### 已实现的 API（`03 §9` 的 M0 子集）

| 端点 | 谁能调 | 说明 |
|---|---|---|
| `POST /api/harness/event`、`GET /api/harness/event/poll` | 服务账号/终端 | 统一事件入口，去重窗口、内容信任标记 |
| `POST /api/harness/terminal/hello` | 终端 | 注册 + 一次性绑定码（Redis，10min） |
| `POST /api/harness/terminal/bind`、`/{id}/heartbeat`、`/{id}/revoke` | 绑定=人；心跳/吊销=人 | 吊销后下一次请求立即 410（A0-5） |
| `POST /api/harness/agent`、`/{id}/lifecycle`、`/{id}/onboard`、`/{id}/autonomy` | **仅自然人** | 机器账号创建/激活一律 403 |
| `POST /api/harness/grant`、`/{id}/revoke` | **仅自然人** | TTL 上限 24h，超限拒绝而非截短 |
| `POST /api/harness/policy/check` | 服务账号 | 唯一的治理入口，返回 allow/deny/require_approval |
| `GET /api/harness/approval`、`/{id}/decide` | 查询任意；**决定仅自然人** | 申请者所属家族不得自批（R-02） |
| `POST/DELETE /api/harness/killswitch` | **仅自然人** | 5 粒度，理由必填 |
| `GET /api/harness/audit`、`/audit/verify` | 服务账号 | 按 trace 回放 + 哈希链自检 |
| `GET /api/harness/template`、`/agent`、`/terminal` | 服务账号 | 看板数据源 |

### 为什么 protocol 与 policy 不依赖 Spring

`harness-protocol` 会被原样嵌进终端运行时（一份代码，三平台分发），依赖越少，打包与升级越便宜；
`harness-policy` 是治理内核，必须能在没有数据库、没有容器的情况下被单元测试穷举攻击面
（02 的 T-01..T-18 全部落在这一层）。Spring Boot 只出现在 `harness-platform` 与 `harness-adapter-portal`。

## 本批次交付对应 M0 的哪几条

| M0 范围项（04 §2.1） | 本批次状态 |
|---|---|
| 1 平台骨架（Agent 注册、模板、生命周期、审计） | ✅ 全部可用 |
| 2 portal 适配层只读同步 + 规范化镜像 | ✅ 只读同步、物化路径、权限串绑定、脏数据队列 |
| 3 数字员工入职（写 portal 三张表） | ✅ portal 侧 `/api/harness/agent/onboard` 已实现 |
| 4 权限引擎 cap×scope×TTL（含签发/过期/吊销） | ✅ 决策 + 签发 + 吊销 + 过期 + 批量回收 |
| 5 事件总线 v1 + 去重 | ✅ 1000 条同指纹 → 1 行 + 计数（A0-7 实测） |
| 6 终端最小版（注册/绑定/心跳） | ✅ 服务端全部就绪；终端运行时未建 |
| 7 一体化看板 v1 | ✅ 数据 API 就绪（前端未做） |
| 8 审计与可观测 | ✅ 追加式审计 + 哈希链自检 + 按 trace 回放 |

### portal 侧改动（01 §17.3 的目标是 ≤8 处、全部为新增；实际落地 **17 个文件**，其中 8 个是既有文件被修改）

| # | 位置 | 内容 |
|---|---|---|
| 1 | `src/strutsFile/struts-harness.xml`（新） | `/api/harness` 命名空间；每个 URL 段一个 package（`alwaysSelectFullNamespace=true` 的必然要求），独立拦截器栈 |
| 2 | `src/struts.xml`（改 1 行） | 引入上面的配置文件 |
| 3 | `src/com/fuao/fajxc/interceptor/HarnessApiInterceptor.java`（新） | HMAC 服务账号认证：头齐全、client 匹配、时窗、**验签后才占用 nonce**、请求体回填 |
| 4 | `src/com/fuao/fajxc/util/HarnessHmac.java`、`HarnessJson.java`、`HarnessCachedBodyRequest.java`（新） | 签名 / JSON（读+写）/ 请求体可重读（与平台逐字节一致） |
| 5 | `src/com/fuao/fajxc/dao/harness/HarnessAccountDao.java`（新） | `isAI` 判定、权限快照、入职写入 |
| 6 | `src/com/fuao/fajxc/action/harness/HarnessApiAction.java`（新） | `health` / `permission/snapshot` / `agent/onboard` |
| 7 | `src/applicationContext-harness.xml`（新） | 两个 bean，复用既有 `baseDao`/sessionFactory |
| 8 | `WebRoot/WEB-INF/props/harness-api.properties`（新） | clientId/secret/时窗/nonce TTL（默认关闭） |
| 9 | `WebRoot/WEB-INF/web.xml`（改 1 段） | 把 `/api/harness/*` 映射到 struts2 filter，否则整个命名空间 404 |
| 10 | `src/com/fuao/fajxc/vo/Users.java` + `Users.hbm.xml`（改） | 新增 `isAI` 映射 |
| 11 | `src/com/fuao/fajxc/action/LoginAction.java`（改） | **A0-2**：登录页在验证码与口令比对之前拒绝数字员工账号 |
| 12 | `src/com/fuao/fajxc/dao/impl/LoginDaoImpl.java`（改） | **A0-2 兜底**：`isAI` 判定，查询失败时**失败关闭** |
| 13 | `src/com/fuao/fajxc/dao/impl/CommBaseDaoImpl.java`（改） | **A0-2**：凭据查询加 `isAI=0` |
| 14 | `src/com/fuao/fajxc/dao/impl/stockpile/WarehousingDaoImpl.java`（改） | **A0-2**：同上 |
| 15 | `src/com/fuao/fajxc/dao/impl/system/FunctionInfoSystemDaoImpl.java`（改） | **A0-2**：同上 |
| 16 | `src/com/fuao/fajxc/dao/impl/system/RoleSystemDaoImpl.java`（改） | **A0-2**：同上 |
| 17 | `src/com/fuao/fajxc/dao/impl/system/MenuInterceptorImpl.java`（改） | **A0-2**：同上 |
| 18 | `src/com/fuao/fajxc/action/sale/SaleOrderAction.java`（改） | **A0-2**：cookie 凭据路径同样排除数字员工 |
| 19 | `src/applicationContext-login.xml`（改 1 行） | 注入 `harnessAccountDao` |
| 20 | `src/com/fuao/fajxc/action/GlobalVariables.java`（改） | 编码修复 + 死代码清理 |
| 21 | `src/com/fuao/fajxc/vo/Groups.hbm.xml`（改） | `groups` 是 MySQL 8 保留字，加反引号 |

> **与 01 §17.3 的偏差（已知，需设计方确认）**：改动点是 21 处而不是 ≤8 处，且其中 10 处是修改既有文件
> 而不是纯新增。超出部分几乎全部是 **A0-2 的收口**——portal 里有 6 份各自复制的凭据查询，
> 只堵住其中一份就等于没堵。

> 数字员工账号同时持有**随机哨兵口令**：即使 A0-2 的检查被误删，账号仍无法通过口令认证。

### 本批次实现中发现并修复的真实缺陷

| # | 缺陷 | 影响 |
|---|---|---|
| 1 | 鉴权过滤器读取请求体做验签后**未回填**，控制器收到空 body | 所有 POST 接口 400，且现场表现为"客户端没传参"，极难排查 |
| 2 | 平台用 `sha256(secret)` 校验、客户端用明文签名 | 所有合法请求被拒；已在 `HmacSigner.deriveKey` 显式化 |
| 3 | 带前缀的 ID（`appr:`+UUID）写入 `CHAR(36)` | 审批落库失败（E-08） |
| 4 | `content_trust VARCHAR(8)` 装不下 `untrusted` | 第一条外部事件即失败（E-09） |
| 5 | 审计哈希链把纳秒时间戳纳入摘要，而 `DATETIME(3)` 只存毫秒 | 每次自检都报"链断裂"，等于没有自检 |
| 6 | 审计 `outcome` 写入 17 字符而列宽 16 | 策略拒绝路径 500 |
| 7 | 缺 `-parameters` 编译参数 | Spring 按名绑定 JDBC/请求参数在运行期失败 |
| 8 | **跨系统 HMAC 漂移**：平台多哈希了一层 MAC | 两侧测试全绿，但真实调用必然 401；已加 `tools/verify-portal-interop.sh` 持续校验 |
| 9 | 适配器**两个 DataSource**：`@Primary` 让 portal 的工厂方法也拿到了 harness 库 | 镜像写进了 portal 库；已用 `@Qualifier` 显式区分，并有测试断言两个库各连各的 |
| 10 | 适配器漏了 `flyway-mysql` 依赖 | 迁移不执行，镜像表根本不存在 |
| 11 | surefire 默认不匹配 `*IT` | 48+ 个集成测试默认**根本没跑**；已在父 pom 里补 includes |

## 已固化的安全不变量（每条都有测试）

1. **AI 不能给自己授权** —— 审批只能由 `human:*` 决定；申请者的 `owner_employee_id` 不得审批自己 agent 的提权；L4 需两名不同自然人。（`ApprovalStateMachineTest`）
2. **临时提权必然过期** —— 授权 TTL 上限 24h；超限的授权被**拒绝**而不是被悄悄截短。（`PolicyEngineTest`）
3. **授权会二次收敛** —— 令牌签名有效不等于有效：校验第 6 步会拿"当前真实 grant 集合"再收敛一次，撤权即刻生效。（`CapabilityTokenTest`）
4. **有界授权永不升级为全组织授权** —— `Scope.intersect` 在"有界 ∩ 无界"时返回空。（`PolicyEngineTest`）
5. **数据不是指令** —— 事件自带 `content_trust`；不可信内容派生出的工具参数若没有 `source_ref` 一律拒绝。（`PolicyEngineTest`）
6. **上报链不能无限上抛** —— 最多 2 跳 agent，第 3 跳强制转真人（R-06）。（`EscalationRouterTest`）
7. **降低自主性是默认失败响应** —— 熔断即降到 L0；驳回率/失败率/纠正次数/超支均只降不升。（`DegradationPolicyTest`）
8. **幂等由数据库兜底** —— `harness_action.arguments_hash` 唯一索引，重放不重复执行。（`assert_idempotency`）

## 下一批（建议顺序）

1. **注入检测器与 `suspected_injection`**（02 §R-05、03 §4 规则 2）：事件信封里加标记、
   命中即降级为 L0 报告并告警。这是当前唯一还开着的"读到的内容当指令"缺口。
2. **时间解析接入同步流程**（A0-8 / T-14）：`PortalTimeParser` 写好了但没有调用方，
   `scheduleplan.begintime` / `new_task.begintime` 的脏数据目前不会进 `harness_dirty_queue`。
3. **A0-3 自动比对**：适配层的权限解析结果 vs portal 侧 `permission/snapshot` 的自动比对。
4. **终端执行器**：本地策略与审批验签已就位，但还没有真正执行 `fs.read` / `fs.write` /
   `sys.exec` 的命令处理器，也没有 TCP 帧通道（边缘层未实现，平台目前只有 HTTP）。
5. **看板前端**（`document/harness/prototypes/*.html` 已有两版原型可参考）。

## 仓库根目录的 `harness-terminal/`（Rust）= 终端智能体

它是**终端智能体运行时**：收集上下文 → 动手 → 验证 → 循环，带技能（SKILL.md）与 MCP 插件。
详见 `harness-terminal/README.md`。

> 评审时这个工程是编译不过的孤儿（缺 4 个依赖、clap 版本不匹配、直连 MySQL 且硬编码 root 口令），
> 本轮按"终端智能体"重写了。见 `document/harness/06-验收报告.md` §4.2。
>
> 与 `harness/harness-terminal`（Java 设备外壳）的分工：外壳管身份与心跳，智能体管干活；
> **每次工具调用都要过外壳那一份策略**——智能体不是权限主体。
> 两者目前各有一份 `LocalPolicy` 实现（Java / Rust），尚未接线成同一份能力集。

## 文档侧待办

`harness-db/ERRATA.md` 记录了 7 条规格缺陷（E-01..E-07），其中 **E-01 去重窗口粒度** 与 **E-05 帧 MAC 覆盖范围** 需要设计方确认后回写 `03-协议与数据模型.md`。