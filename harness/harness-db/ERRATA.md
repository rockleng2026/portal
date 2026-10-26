# 规格勘误（ERRATA）—— 03-协议与数据模型.md

> 记录在把 `03-协议与数据模型.md` 转写成可执行 DDL 与代码时发现的规格缺陷。
> 每一条都给出：**现象 → 影响 → 本次采用的修法 → 需要文档方确认的点**。
> 文档修订后，本文件对应条目标记为 CLOSED。
>
> **当前状态（2026-10-26）**：`E-01`、`E-05` 已回写进 `03-协议与数据模型.md`（§2.2 / §3.1 / §3.2 / §10），
> 状态为 **CLOSED**。其余条目代码侧已落地，文档回写待做。

---

## E-01 `harness_event` 引用了不存在的列（阻塞级） — **CLOSED（2026-10-26，已回写 03 §2.2）**

**规格原文（03 §2.2）**

```sql
UNIQUE KEY `uk_fp_window` (`fingerprint`,`event_window`)
```

但整张表的列清单里没有 `event_window`。

**影响**：`event_window` 是去重窗口的另一半。缺这一列，`A0-7`（同指纹灌 1000 条 → 只产生 1 条 + `dedup_count=1000`）在数据库层无法成立；只能靠应用层查询-比对-更新，既慢又有竞态。

**修法**（见 `V1__harness_core_schema.sql`）：

```sql
`event_window` VARCHAR(64) NOT NULL DEFAULT 'none'
  COMMENT 'dedup time-window id'
```

窗口取值由 `LatencyClass` 推导（`harness-protocol` 的 `EventEnvelope.window()`）：realtime → 分钟桶、nearline → 小时桶、batch → 日桶。

**已确认（2026-10-26）**：窗口粒度就是 realtime=1min / nearline=1h / batch=1d。
**已回写 03 §2.2**：列清单补上 `event_window VARCHAR(64) NOT NULL DEFAULT 'none'`，
并新增一张表说明粒度、典型事件与取值形状（`r3421` / `n289744` / `b20537`）。
告警风暴抑制（01 §7.3）与 A2-8 的"100 条同根因告警合并为 1 条 issue"由这个粒度满足；
运维若需要更粗的窗口（例如夜间批处理按小时合并），**改桶大小即可，不改去重语义**。

> 注意：`fingerprint` 的注释原文是 `source+key+hash(window)`，但实现算的是
> `source + businessKey + sha256(canonical(payload))`——payload 的哈希，不是窗口的哈希。
> 窗口单独由 `event_window` 承载。回写时一并改正了这个注释，否则两处会各说各话。

---

## E-02 MySQL 8 不允许 JSON 列带默认值（阻塞级）

**规格原文**：多处写 `JSON DEFAULT NULL`，例如 `budget_quota JSON DEFAULT NULL`、`risk VARCHAR(8) DEFAULT 'R2'`。

**现象**：MySQL 对 JSON 列报 `BLOB/TEXT/GEOMETRY/JSON column can't have a default value`。

**修法**：所有 JSON 列声明为裸 `JSON`（默认即为 NULL），语义不变。同时把混用的 `JSON DEFAULT NULL` 统一为 `JSON NULL`，避免下次有人再写回 `DEFAULT NULL`。

**影响面**：无功能影响，仅 DDL 写法。

---

## E-03 审批没有过期时间，无法自动过期（高）

**规格原文**：`harness_approval` 有 `ttl_seconds INT NOT NULL`，但没有 `expires_at`。

**影响**：01 §8.2 与 04 §8.3 第 4 条要求"超 24h 未处理 → 提醒 + 自动过期"。没有 `expires_at`，系统只能靠应用层比较 `created_at + ttl`，而 `created_at` 本身在原文中也不存在——即审批连"什么时候提交的"都查不到。

**修法**：补 `expires_at DATETIME NOT NULL`（写入时由 `ttl_seconds` 算出）与 `created_at DATETIME NOT NULL`。`harness-policy` 的 `PolicyEngine.buildApprovalRequest()` 是唯一生成这两者的地方，TTL 策略集中在那里，避免多处各写一套。

---

## E-04 问题单状态机缺 `replan`（低）

**现象**：01 §6.2 的状态图含 `replan`，03 §2.3 的 `state` 注释不含。

**修法**：只改注释，未改列（`VARCHAR(24)` 足够）。

---

## E-05 帧 MAC 未覆盖 type/flags/length（中，安全） — **CLOSED（2026-10-26，已回写 03 §3.1/§3.2/§10）**

**规格原文（03 §3.1）**：`应用层再叠加 HMAC-SHA256(seq, nonce, payload)`。

**问题**：签名不含 `type`/`flags`/`length`，则一条合法 `CMD` 帧的 header 可被改写为 `EVENT`/`HEARTBEAT` 而 MAC 仍然有效；`length` 不在签名内则存在截断/拼接空间。

**修法**：`Frame.signedBytes()` 签的是"MAGIC‖VERSION‖TYPE‖FLAGS‖LENGTH‖SEQ‖NONCE‖PAYLOAD"整帧（去掉尾部 32 字节 MAC）。收发两侧共用同一方法，因此线格式仍然自洽；`FrameCodecTest.macCoversTypeAndFlagsSoAFrameCannotBeRelabelled` 固化了这个行为。

**已确认（2026-10-26）**：帧 MAC 覆盖整帧（尾部 32 字节 MAC 除外）。**已回写 03 §3.1**，
并补上了两条配套要求：

* **签名字节必须由收发两侧共用的方法产出**（`Frame.signedBytes()`），不得各写一遍——
  这正是该缺陷最初藏身之处；
* **`VERSION` 不被容忍**：版本号不认识的帧**整帧拒绝并断开连接**，不做"尽力解析"。
  覆盖范围变了，`VERSION` 就是唯一的路标；混合部署会立刻暴露（连接被拒），
  而不是把一条 `CMD` 误读成一条 `EVENT`。

**已回写 03 §10**：帧格式或 MAC 覆盖范围一旦改变，`VERSION` 必须 +1，边缘与终端**同时升级**；
`N-1` 兼容窗口从第二个版本开始有意义，当前 `VERSION=1` 是首个发布版本。

> 代码侧已就位：`FrameCodec` 对不支持的 `VERSION` 抛错而不是猜测，
> `FrameCodecTest.macCoversTypeAndFlagsSoAFrameCannotBeRelabelled` 固化覆盖行为。
> 边缘层尚未实现，因此"同时升级"目前还没有真实的对手方——等边缘层落地时按 §10 执行即可。

---

## E-06 缺 M0 必需但未在 §2 建表的实体（中）

01 与 04 要求、03 §2 未定义的对象，本次以 `V2__harness_governance_schema.sql` 增量补齐：

| 缺失实体 | 依据 | 说明 |
|---|---|---|
| `harness_audit` | 01 §0 P4、§16 | 自主动作可回放的唯一落点；带 `prev_hash`/`entry_hash` 防篡改链 |
| `harness_killswitch` | 04 §8.2 | 5 个粒度；`harness-policy.KillSwitchState` 读取 |
| `harness_agent_template` | 01 §6.3 | 模板市场（内置售前/售后/工程师/助理小C/分析师…） |
| `harness_principal` | 01 §2.3、03 §9 | M2M 服务账号；只存 `secret_hash`，不落 `users.password` |
| `harness_agent_state_log` | 01 §5.1、§12.1 | 入职/停权/降级/退役轨迹，岗位重新设计可回滚 |
| `harness_dirty_queue` | 03 §8.2 | 适配层脏数据不静默丢弃（A0-8） |
| `harness_org_employee` | 03 §8 映射表 | 员工规范化镜像；`is_leave` 原样保留并注明"与直觉相反" |
| `harness_event.last_seen_at` / `last_event_id` | 01 §7.3 | 合并计数的最近命中时间与来源 id |

**未建表但已指定存储位置**：绑定码（TTL 10min，03 §3.5）与 HMAC nonce（TTL 5min，03 §9）按设计走 Redis，不入库。

---

## E-08 `CHAR(36)` 装不下带前缀的 ID（阻塞级）

**现象**：01 §4 的 ID 体系写作 `grant:{uuid7}`、`inc:{uuid7}`、`appr:{uuid7}`，而 03 §2 的列全是
`CHAR(36)`。带前缀的字符串长度 41–42，写入即 `Data too long`。首次写入审批单时暴露。

**修法**：区分"存储形式"与"引用形式"——

| 形式 | 用途 | 例子 |
|---|---|---|
| 裸 UUIDv7（36 字符） | 所有 `CHAR(36)` 列 | `0198f0c2-0000-7000-8000-000000000001` |
| `prefix:` 形式 | 日志、审计 evidence、令牌 claim、API 载荷里的可读引用 | `agent:0198f0c2-…` |

已落在 `harness-protocol` 的 `Ids` 类 javadoc 里，并在 `PolicyEngineTest` 断言长度为 36。

**待确认**：若希望库里也保留前缀，需把相关列改为 `VARCHAR(64)`；建议不改，理由是列宽固定且
下游（令牌、联邦标识）都按裸 UUID 处理。

---

## E-09 `content_trust VARCHAR(8)` 装不下 `untrusted`（阻塞级）

**规格原文**：`content_trust VARCHAR(8) NOT NULL DEFAULT 'trusted' COMMENT 'trusted/untrusted'`。

**现象**：`untrusted` 是 9 个字符，写入第一条来自外部的事件即 `Data too long`；列自己的注释
已经声明了两个取值。

**修法**：`V4__harness_schema_corrections.sql` 扩为 `VARCHAR(16)`。不改 V1 是为了让已执行过
V1–V3 的库与新库收敛到同一 schema。

---

## E-10 审计文本列有长度上限（低，已防御性处理）

`harness_audit.reason VARCHAR(512)`、`harness_approval.decision_note VARCHAR(255)`，而拒绝理由
可能携带完整 scope 描述。事故中因为"理由太长"而写不进审计，比"理由被截断"严重得多。

**修法**：V4 把两列放宽到 1024；写入方（`AuditRepository.bounded`、`ApprovalService`）再做一次
截断，保证"审计写入永不失败"。

---

## E-11 组织镜像必须能表达"坏掉的组织"（中）

**现象**：`harness_org_employee.dept_id` / `workposition_id` 是 `NOT NULL`，但 portal 里确实存在
没有部门或岗位已删除的员工。适配器一遇到这种行就整批失败——脏数据把同步整条卡死。

**修法**：`V5__harness_mirror_allows_broken_links.sql` 把两列改为可空。镜像的职责是**如实反映**
组织现状，"这个员工没有部门"本身就是平台需要的信息（例如升级路由要判断上级是谁），
而不是把这条员工从镜像里抹掉；同时适配器把它写进 `harness_dirty_queue`（A0-8）。

---

## E-12 平台侧的 HMAC 多哈希了一层（高，跨系统漂移）

**现象**：平台与 portal 各实现了一份 HMAC 签名。interop 检查（`harness/tools/verify-portal-interop.sh`）
发现两侧对同一请求算出的签名**不一致**：平台在 MAC 之外又套了一层 SHA-256。

**影响**：两边各自的测试都是绿的，但**任何一次跨系统调用都会 401**。这类缺陷只有在两侧真的对话时才会暴露。

**修法**：按 03 §9 的原文 `sig = HMAC-SHA256(...)` 收敛——去掉平台侧多余的那层哈希，portal 侧
保持按字面实现。同时把 interop 检查固化成脚本，纳入日常构建。

**教训**：跨系统契约必须有"两边对同一输入算出同一结果"的检查，单侧测试无法发现这类漂移。

---

## E-07 命名规范已规避 MySQL 保留字（记录，无需修改）

03 §8.1 要求 harness 库"一律避开 MySQL 保留字"。portal 侧 `groups` 是保留字（`Groups.hbm.xml` 已加反引号修复）。harness 库全部表名以 `harness_` 前缀开头，天然避开 `groups`/`order`/`system`/`usage`。
`db/verify.sh` 的 `assert_reserved_words` 会持续守护这一点。