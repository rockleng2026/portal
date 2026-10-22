<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>servU安装和建ftp帐户</title>
    
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
      align=center height=32>
        <TBODY>
        <TR>
          <TD>&nbsp;当前操作-》<A 
            href="http://www.ebadu.com/manager/notelist.asp">提交问题</A></TD></TR></TBODY></TABLE><BR>
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
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=801 align="center">
        <TBODY>
        <TR>
          <TD width=801>
            <TABLE border=0 cellSpacing=0 cellPadding=5>
              <TBODY>
              <TR>
                <TD height=30 align=middle><STRONG><SPAN class=STYLE1><FONT 
                  size=+2>servU安装和建ftp帐户</FONT></SPAN></STRONG></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/01.jpg" width=689 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/02.jpg" width=692 
                  height=426></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/03.jpg" width=800 
                  height=651></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/04.jpg" width=800 
                  height=540></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/05.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/06.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/07.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/08.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/09.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/10.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/11.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/12.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/13.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/14.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/15.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/16.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/17.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/18.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/19.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/20.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/21.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/22.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/23.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/24.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/25.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/26.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/27.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/28.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/29.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/30.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/31.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/32.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/33.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/34.jpg" width=555 
                  height=447></TD></TR>
              <TR>
                <TD height=30><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/servU/35.jpg" width=555 
                  height=447></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
  </body>
</html>
