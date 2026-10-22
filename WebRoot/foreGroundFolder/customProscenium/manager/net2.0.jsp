<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>.net2.0安装和权限的设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css"/>
<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css"/>
<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css"/>

  </head>
  
  <body>
    <TABLE border=0 cellSpacing=1 cellPadding=2 width="98%" bgColor=#cccccc 
      align=center>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD height=13 align=left><STRONG><FONT 
          size=3>客户自助服务</FONT></STRONG></TD></TR></TBODY></TABLE><BR>
      <TABLE style="MARGIN-TOP: 8px; MARGIN-BOTTOM: 8px" border=0 cellSpacing=1 
      cellPadding=3 width="95%" bgColor=#cccccc align=center height=88>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold" 
          bgColor=#f0f0f0 height=13 colSpan=6 align=left>常见问题</TD></TR>
        <TR bgColor=#f0f0f0>
          <TD bgColor=#f0f0f0 height=13 width="19%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/iis.jsp" 
            target=right>IIS的建立</A> </TD>
          <TD bgColor=#f0f0f0 height=13 width="20%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/sql_2000.jsp" 
            target=right>Mssql2000安装</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="12%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/jc_php.jsp" 
            target=right>PHP配置</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="14%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/mysql.jsp" 
            target=right>Mysql安装</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="22%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/su.jsp" 
            target=right>报错Service Unavailable</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="13%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/serverlogin.jsp" 
            target=right>登陆服务器</A></TD></TR>
        <TR bgColor=#f0f0f0>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/login_aq.jsp" 
            target=right>服务器的基本安全</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/index.jsp" 
            target=right>服务器上默认首页设置</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/pwd.jsp" 
            target=right>服务器修改密码</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/bq.jsp" target=right>Bad 
            Request报错</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/phpadmin.jsp" 
            target=right>网站建立与架设phpmyadmin</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/wfcx.jsp" 
            target=right>域名不能访问</A></TD></TR>
        <TR>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/servU.jsp" 
            target=right>servU安装和建ftp帐户</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/net2.0.jsp" 
            target=right>.net2.0安装和权限的设置</A></TD>
          <TD bgColor=#f0f0f0 height=13 colSpan=4 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/sqlimport.jsp" 
            target=right>如何通过phpmyadmin导入mysql数据库</A></TD></TR></TBODY></TABLE>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=801>
        <TBODY>
        <TR>
          <TD width=801>
            <TABLE border=0 cellSpacing=0 cellPadding=5 align=center>
              <TBODY>
              <TR>
                <TD height=30 align=middle><STRONG><SPAN class=STYLE1><FONT 
                  size=+2>.net2.0安装和权限的设置</FONT></SPAN></STRONG></TD></TR>
              <TR>
                <TD height=30><BR></TD></TR>
              <TR>
                <TD height=30>1.双击asp.net2.0.exe安装程序.</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/00.jpg" width=689 
                height=447></TD></TR>
              <TR>
                <TD height=30>2.点击"下一步"</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/01.jpg" width=692 
                  height=426></TD></TR>
              <TR>
                <TD height=30>3.勾选"我接受许可协议中的条款",点击"安装"</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/02.jpg" width=800 
                  height=651></TD></TR>
              <TR>
                <TD height=30>4.安装过程</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/03.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30>5.点击"完成",结束安装</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/04.jpg" width=554 
                  height=454></TD></TR>
              <TR>
                <TD 
              height=30>6.右键您的站点选择属性,进入下面的界面,选择asp.net这个按钮,下拉菜单选择2.0</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/05.jpg" width=555 
                  height=452></TD></TR>
              <TR>
                <TD 
                  height=30>7.右键您的站点选择权限,进入下面的界面,点击添加,添加一个aspnet权限,然后点击"检查名称",点击"确认"按钮</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/06.jpg" width=571 
                  height=437></TD></TR>
              <TR>
                <TD height=30>8.赋予权限如下图:</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/07.jpg" width=573 
                  height=437></TD></TR>
              <TR>
                <TD height=30>9.点击添加,点击"高级",然后点击"立即查找",选择"NETWORK 
                  SERVICE"这个权限,点击"确认",然后再点击"确认"</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/08.gif" width=554 
                  height=453></TD></TR>
              <TR>
                <TD height=30>10.赋予权限如下图:</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/07.jpg" width=556 
                  height=452></TD></TR>
              <TR>
                <TD height=30>11.选中"NETWORK SERVICE",点击高级</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/09.gif" width=693 
                  height=489></TD></TR>
              <TR>
                <TD height=30>12.赋予权限,勾选两个如下图:点击应用</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/10.gif" width=618 
                  height=468></TD></TR>
              <TR>
                <TD height=30>13.点击"是"</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/11.gif" width=554 
                  height=454></TD></TR>
              <TR>
                <TD height=30>14.点击应用,然后点击"确定"</TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/net2/12.jpg" width=554 
                  height=454></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
  </body>
</html>
