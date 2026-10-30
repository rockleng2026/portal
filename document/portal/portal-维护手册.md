# portal 维护手册（老系统）

> 这份手册写给**要改 portal 的人**（不管你是人还是助手）。
> 它记的是这个 2011 年的 Grails/Struts2 应用在**改它**的时候真正会绊住人的地方，
> 每一条都对应一次真实的故障或一次真实的坑。
>
> 改完请回来把新的坑补在最后面——**这份手册的价值全在往后累积**。

---

## 0. 一句话说明

portal 是公司的老业务系统（Grails + Struts2 + Hibernate + JDK 6 + Tomcat 6），
harness 只是**在它旁边加了一个命名空间** `/api/harness/**`（HMAC 机器接口），
用来做「数字员工入职」「权限快照」这类事。

**不要动 portal 的老逻辑**。harness 的改动应该落在三个地方：

| 位置 | 放什么 |
|---|---|
| `src/com/fuao/fajxc/action/harness/HarnessApiAction.java` | HTTP 入口（一个方法一个端点） |
| `src/com/fuao/fajxc/dao/harness/HarnessAccountDao.java` | 读 portal 的库、写 portal 的表 |
| `src/com/fuao/fajxc/interceptor/HarnessApiInterceptor.java` | 签名闸门（除非要改认证本身，别动） |

再加上配置文件：

| 位置 | 放什么 |
|---|---|
| `src/strutsFile/struts-harness.xml` | harness 命名空间的 action 映射 |
| `src/applicationContext-harness.xml` | harness 的 Spring bean |
| `WebRoot/WEB-INF/props/harness-api.properties` | 开关、client id、共享密钥（**部署时不覆盖**） |

---

## 1. 环境

| 部件 | 版本 | 在哪 | 说明 |
|---|---|---|---|
| 编译用的 JDK | **JDK 6** | `~/tools/zulu6.22.0.3-jdk6.0.119-linux_x64` | `.classpath` 写的是 Sun JDK 1.6.0_13；新 JDK 编出来的 class Tomcat 6 加载不了 |
| 跑 portal 的 Tomcat | 6.0.45 | `/mnt/data/project/tomcat` | 连接器端口在 `conf/server.xml`（本机是 **18301**） |
| 跑 Tomcat 的 JDK | **JDK 8** | `/home/leng/tools/jdk21` 旁边那套 | Tomcat 6 自己跑在 JDK 8 上；**编译用 6，运行用 8**，两件事 |
| 数据库 | MySQL 8.0 | docker `aios-mysql`，库 `portal20160513` | 老库是 GBK/utf8mb4 混着的 |

编译 / 打包 / 部署一条命令：

```bash
./harness/tools/portal-dev.sh            # 编译 → 部署 → 重启 Tomcat → 验证
./harness/tools/portal-dev.sh --check    # 只验证现在跑着的
```

---

## 2. 编译：六个坑

### 2.1 必须用 JDK 6 编译
```bash
./harness/tools/build-portal.sh --harness   # 只编 harness 相关文件
./harness/tools/build-portal.sh             # 全量（会有已知的失败，见 2.4）
```
用 JDK 21 编出来的 class 是 major 65，Tomcat 6 的 JVM 加载不了，报的是
`UnsupportedClassVersionError`——**看起来像部署没生效，其实是编译版本不对**。

### 2.2 源码是 GBK 和 UTF-8 混着的
`compile-portal.py` 会**逐文件探测编码**并分两轮编译（`-encoding GBK` / `-encoding UTF-8`）。
自己加文件时注意：

* 新文件一律 **UTF-8 无 BOM**；
* 文件里有中文时，用 `-encoding UTF-8` 编；
* **XML 的编码由声明决定**，跟 javac 的 `-encoding` 无关（改 XML 报
  `Invalid byte 1 of 1-byte UTF-8 sequence` 就是这里错了）。

### 2.3 Java 6 的语言限制
不能用：菱形语法 `<>`、try-with-resources、String switch、lambda、多重 catch 里的 rethrow、
`Objects.requireNonNull` 之外的 java.util.Objects 新 API。
JDK 6 的 javac 会直接报语法错，报错信息里带 "source release 1.6"。

### 2.4 已知的编不过的文件（Zulu 6 上）
这些文件用了 Oracle JDK 6 才有、Zulu 6 删掉的 `com.sun.*` 内部类：

```
src/com/fuao/fajxc/serser/service/CabinetContent.java
src/com/fuao/fajxc/dao/cms_rec_part/Rec_PartDaoImpl.java
src/com/fuao/fajxc/action/sale/SaleOrderAction.java
src/com/fuao/fajxc/action/cms_template/TemplateAction.java
src/com/fuao/fajxc/action/basic/EmployeeAction.java
src/com/fuao/fajxc/action/customService/ClientReturnOrderAction.java
src/com/fuao/fajxc/util/HDThumb.java
```

**这不是这次改动造成的**，build-portal.sh 每次都会列出来。**harness 的文件不在这个名单里**
——如果 harness 的文件出现在名单里，说明你引入了对内部类的依赖。

### 2.5 依赖不全
`javax.jms`、`javax.servlet.jsp`、`javax.xml.registry.infomodel` 不在仓库里，
脚本会从 Maven 中央仓库拉到 `target/j2ee`（离线环境要提前拉好）。
`sun.org.mozilla.javascript.*` 之类的内部类**拉不到**，只能靠 Oracle JDK 6。

### 2.6 部署脚本不会覆盖配置文件
`deploy-portal.py` 只覆盖 **class 文件和资源**，并且：

* `web.xml`、`struts.xml`、`applicationContext.xml` **不覆盖**（里面有运维自己的配置）；
* `WEB-INF/props/harness-api.properties` **不覆盖**（共享密钥是运维的）；
* 每次改动前先备份到 `target/deploy-backup/<时间戳>/`。

所以「改了 web.xml 没生效」不是 bug，是设计：**要生效得自己改部署目录里的那份**。

---

## 3. Struts2：四个坑

### 3.1 每个 action 必须显式引用拦截器栈
```xml
<action name="onboard" class="HarnessApiAction" method="onboard">
    <interceptor-ref name="harnessStack"/>
    ...
</action>
```
**只定义不用 = 不生效**。这个包里的 action 不写这一行，就不会跑签名闸门，
**未签名的请求也能进**——这是个安全漏洞，不是风格问题。

### 3.2 一个 URL 段一个 package
portal 开了 `alwaysSelectFullNamespace=true`，命名空间取**最后一个斜杠之前**的部分：
`/api/harness/permission/snapshot` → 命名空间 `/api/harness/permission`、action `snapshot`。
所以 `struts-harness.xml` 里一个 URL 段一个 `<package>`。

### 3.3 XML 要带 Struts 的 DOCTYPE
```xml
<!DOCTYPE struts PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 2.1.7//EN"
    "http://struts.apache.org/dtds/struts-2.1.7.dtd">
```
少了它，Struts 启动时报 "Unable to load config class"。

### 3.4 URL 带 `.do` 扩展名
portal 的每个 action 都带扩展名，harness 的也一样（`/api/harness/agent/onboard.do`）。
**扩展名在签名里**（03 §9），两侧必须一致。

---

## 4. Hibernate + Spring：三个坑

### 4.1 action 是 Spring bean = 单例
`applicationContext-harness.xml` 里 `HarnessApiAction` 是个 bean，**bean 是单例**。
所以 action 里的字段（`payload`、`error`）**在请求之间共享**——上一个请求的答案会漏进
下一个请求的响应（实测：预览的响应里带着上一次入职的 employeeId）。

**每个 action 方法开头先清空**：

```java
payload.clear();
error.clear();
```

### 4.2 NOT NULL 的外键必须有值
`users.roles` 是 NOT NULL。`user.setRoles(null)` 会在 `session.save(user)` 时炸：

```
org.hibernate.PropertyValueException: not-null property references a null or transient value
```

而且**炸之前 employee 行已经 insert 了**（没有事务的话），于是留下「有员工行、没账号」
的半截数据。**写 portal 的表要放在一个事务里**：

```java
org.hibernate.Transaction transaction = session.beginTransaction();
try {
    ...
    session.flush();
    transaction.commit();
} catch (RuntimeException e) {
    transaction.rollback();
    throw e;
}
```

### 4.3 count(\*) 在 MySQL 上是 Long
```java
Integer count = (Integer) session.createQuery("select count(*) from ...").uniqueResult();
// ClassCastException: java.lang.Long cannot be cast to java.lang.Integer
```
读成 `Number`，用 `intValue()` 取值。

---

## 5. 签名（03 §9）

* 签的是 **context 内的路径**（`servletPath + pathInfo`），**不含 query**；
  签了 query 的一方会得到 `BAD_SIGNATURE`。
* 规范串：`METHOD\nPATH\nTIMESTAMP\nNONCE\nhex(sha256(body))`
* 密钥 = **hex(sha256(secret)) 的 ASCII 字节**（64 个字符），
  不是 hex 解码出来的 32 个字节。openssl 那边要写 `key:`（不是 `hexkey:`）。
* 时间戳窗口 300 秒，nonce 记住 300 秒（**单节点内存**的，多节点要粘性会话或上 Redis）。

---

## 6. 故障速查

| 症状 | 多半是 | 怎么办 |
|---|---|---|
| 改完没生效 | 只部署了没重启 Tomcat | `portal-dev.sh` 会重启；类是在应用启动时读的 |
| `UnsupportedClassVersionError` | 用新 JDK 编了 | 用 JDK 6 编（2.1） |
| `Invalid byte 1 of 1-byte UTF-8 sequence` | XML 声明和实际编码不一致 | XML 按**声明**编（2.2） |
| Struts 启动 "Unable to load config class" | 少了 DOCTYPE | 补上（3.3） |
| 未签名请求也返回 200 | action 没引用拦截器栈 | 补 `<interceptor-ref name="harnessStack"/>`（3.1） |
| 请求全 404 | 命名空间/动作名对不上 | 一个 URL 段一个 package（3.2） |
| `BAD_SIGNATURE` | 路径带了 context path 或 query | 只签 context 内路径、不含 query（5） |
| `NOT_YOUR_TERMINAL` / 403 | 平台侧签名用的 client id 不对 | 对 `harness.api.clientId` |
| `PropertyValueException: ... null or transient value` | NOT NULL 外键没给值 | 给默认值，并放进事务（4.1、4.2） |
| `ClassCastException: Long cannot be cast to Integer` | count 的类型 | 读成 Number（4.3） |
| 响应里带着上一次请求的数据 | action 是单例 | 每次请求先 clear（4.1） |
| 改了 `web.xml` / `harness-api.properties` 没生效 | 部署脚本不覆盖它们 | 直接改部署目录里的那份（2.6） |
| 仓库根目录冒出 `D:/log.txt` | portal 的 log4j 配置写的是 Windows 路径（`WebRoot/WEB-INF/props/log4j.properties`），在 Linux 上是相对路径 | 已加进 `.gitignore`；想让它去别处就改那份配置里的 `log4j.appender.R.File` |

---

## 7. 改 portal 的规矩

1. **只改必要的**。portal 的老文件（`EmployeeAction` 等）动一行都可能影响全公司。
2. **新代码放 harness 自己的文件里**（`action/harness/`、`dao/harness/`），
   老文件只在**必须**时改一行，并且写清为什么。
3. **改完跑一遍**：
   ```bash
   ./harness/tools/portal-dev.sh
   ```
   它会编译、部署、重启、并确认 harness 命名空间还在应答（401 = 签名闸门在 ✓）。
4. **签名互操作要再验一次**（两侧实现容易各自跑偏）：
   ```bash
   ./harness/tools/verify-portal-interop.sh
   ```
5. **把新的坑写回这份手册**（第 8 节），并写清「症状 → 原因 → 处置」。
6. **不提交密钥**：`harness-api.properties` 里的 secret 是运维的，在仓库外。

---

## 8. 新发现的坑（往这里追加）

<!-- 每条一行：现象 → 原因 → 处置。写清楚日期和改的文件。 -->

* **2026-10-30**｜现象：数字员工的工号写成了业务键、部位落到了根部门 1。
  原因：portal 的行是**人工调接口**写的，参数手打，`deptId` 写成了 1。
  处置：改成**平台自己去写**（`POST /api/harness/agent/{id}/onboard`），
  部门取数字员工自己的 `dept_id`；工号由 portal 按 `AI+地域+部门+序号` 规则算
  （它才有部门码和序号）；写错的存量行用 `harness/tools/fix-digital-employee-rows.sql` 修。

* **2026-10-30**｜现象：portal 的 harness action 是单例，上一个请求的 `payload`
  漏进了下一个请求的响应。 原因：action 是 Spring bean，字段是共享的。
  处置：每个 action 方法开头 `payload.clear(); error.clear();`（见 4.1）。

* **2026-10-30**｜现象：数字员工入职报 `not-null property references a null ... Users.roles`，
  而且 employee 行已经写进去了、users 行没有。
  原因：`users.roles` 是 NOT NULL，调用方没给角色；没有事务，employee 的 insert 留下了。
  处置：角色用配置 `harness.api.digitalRoleId` 兜底；两行放进一个事务（见 4.2）。
