---
name: portal-maintenance
description: 改 portal（公司老 Grails/Struts2 应用）时用。JDK 6 编译、GBK/UTF-8 混编、Struts2 拦截器栈、Spring 单例 action、Hibernate NOT NULL 外键、签名约定、编译部署一条命令，以及故障速查表。
---

# 改 portal 之前先读这个

portal 是 2011 年的老系统（JDK 6 + Tomcat 6 + Struts2 + Hibernate），
harness 只是在旁边加了一个 `/api/harness/**` 命名空间。
**改它之前先读 `document/portal/portal-维护手册.md`**——那里有每一条坑的细节。

## 一条命令

```bash
./harness/tools/portal-dev.sh          # 编译 → 部署 → 重启 Tomcat → 验证
./harness/tools/portal-dev.sh --check  # 只验证
./harness/tools/verify-portal-interop.sh   # 两侧签名实现互验
```

## 十条不能忘的

1. **JDK 6 编译**（`~/tools/zulu6*`）。新 JDK 编出来的 class，Tomcat 6 加载不了。
2. 源码 **GBK/UTF-8 混着**：新文件用 UTF-8 无 BOM；XML 的编码由**声明**决定，与 javac 无关。
3. Java 6 没有：菱形语法、try-with-resources、lambda、String switch。
4. **每个 action 必须显式** `<interceptor-ref name="harnessStack"/>`——不写就是签名闸门失效（安全漏洞）。
5. **一个 URL 段一个 `<package>`**（portal 开了 `alwaysSelectFullNamespace`）。
6. struts XML **要带 DOCTYPE**，否则启动报 "Unable to load config class"。
7. URL **带 `.do`**，扩展名在签名里。
8. **action 是 Spring 单例**：`payload`/`error` 是共享字段，每个方法开头 `clear()`。
9. 写 portal 的表要**放事务里**（`session.beginTransaction()` … `commit()`），
   `users.roles` 这种 NOT NULL 外键必须有值。
10. 部署脚本**不覆盖** `web.xml` / `struts.xml` / `applicationContext.xml` /
    `harness-api.properties`——要改就改部署目录里那份。

## 签名

context 内路径、**不含 query**；密钥 = `hex(sha256(secret))` 的 **ASCII 字节**（不是 hex 解码）。

## 改完

跑 `portal-dev.sh`，把**新的坑**按「现象 → 原因 → 处置」追加到手册第 8 节。
