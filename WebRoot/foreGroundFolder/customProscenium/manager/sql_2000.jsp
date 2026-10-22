<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>sql_2000安装</title>
    
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
            <TABLE border=0 cellSpacing=0 cellPadding=5 width="100%">
              <TBODY>
              <TR>
                <TD height=30 align=middle><STRONG><SPAN class=STYLE1><FONT 
                  size=+2>sqlserver2000安装</FONT></SPAN></STRONG></TD></TR>
              <TR>
                <TD>
                  <TABLE border=0 cellSpacing=0 cellPadding=0>
                    <TBODY>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第1步:解压rar的sql2000压缩包到当前路径,点击autorun.exe或者setup.bat进行安装,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image001.jpg" width=710 
                        height=652></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第2步:点击"安装SQL Server 2000 
                        组件",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image003.jpg" width=749 
                        height=556></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                    />第3步:点击"安装数据库服务器",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image005.jpg" width=696 
                        height=534></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第4步:点击"继续",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image007.jpg" width=469 
                        height=308></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第5步:点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image008.jpg" width=557 
                        height=394></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第6步:选择"本地计算机",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image009.jpg" width=541 
                        height=435></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第7步:如果出现如下图的报错,请重启服务器,然后重新安装sql2000,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image010.jpg" width=627 
                        height=433></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image012.jpg" width=541 
                        height=434></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                      />第8步:选中如下图的按钮,点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image013.jpg" width=534 
                        height=431></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                      />第9步:默认,不用修改,点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image014.jpg" width=534 
                        height=390></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第10步:点击"是"继续,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image015.jpg" width=544 
                        height=396></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第11步:选择"服务器和客户端工具",点击"下一步"继续,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image016.jpg" width=543 
                        height=439></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第12步:选中"默认",点击"下一步"继续,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image017.jpg" width=547 
                        height=442></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第13步:修改安装路径,一般安装在非系统盘,D盘或者E盘,如下三张图片:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image018.jpg" width=549 
                        height=398></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image019.jpg" width=533 
                        height=382></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image021.jpg" width=534 
                        height=385></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                    />第14步:选择"使用本地系统账户",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image022.jpg" width=537 
                        height=387></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第15步:选择"混合模式",并输入sa(管理员)密码,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image023.jpg" width=530 
                        height=429></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image024.jpg" width=536 
                        height=434></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第16步:点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image025.jpg" width=529 
                        height=385></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
/>第17步:在"每客户"输入5,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image026.jpg" width=424 
                        height=440></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image027.jpg" width=430 
                        height=439></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第18步:点击"继续"正式进入安装过程,如下面几张图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image028.jpg" width=484 
                        height=163></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image030.jpg" width=760 
                        height=264></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image032.jpg" width=449 
                        height=162></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image033.jpg" width=397 
                        height=165></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image034.jpg" width=439 
                        height=276></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第19步:点击"完成".</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image035.jpg" width=560 
                        height=402></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />
                        <H2>接下来是sql2000的第二部分,sp4补丁包的安装过程:</H2></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第1步:解压sql2ksp4.rar这个压缩包到当前路径,点击setup.bat进行安装,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image036.jpg" width=729 
                        height=367></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第2步:点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image038.jpg" width=560 
                        height=401></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第3步:点击"是",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image039.jpg" width=547 
                        height=409></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第4步:继续点击"是",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image040.jpg" width=551 
                        height=395></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第5步:点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image041.jpg" width=550 
                        height=454></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                        />第6步:选择"我用来登录到自己计算机上的windows账户信息(windows身份验证)",点击"下一步",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image042.jpg" width=548 
                        height=395></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image043.jpg" width=374 
                        height=193></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第7步:勾选"升级microsoft 
                        search 并应用SQL Server 2000 SP4(必须)",点击"继续",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image044.jpg" width=584 
                        height=612></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第8步:点击"确认",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image046.jpg" width=560 
                        height=443></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image047.jpg" width=401 
                        height=179></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" 
                      />第9步:点击"下一步",进入安装过程,如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image048.jpg" width=541 
                        height=395></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image049.jpg" width=525 
                        height=177></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image052.jpg" width=553 
                        height=174></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image054.jpg" width=466 
                        height=170></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image055.jpg" width=485 
                        height=166></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image056.jpg" width=574 
                        height=175></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />第10步:点击"完成",如下图:</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image057.jpg" width=538 
                        height=391></TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" />至此,sql2000全部安装完毕.</TD></TR>
                    <TR>
                      <TD><WIDTH="710" height="652" /><BR></TD></TR>
                    <TR>
                      <TD><IMG src="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/image058.jpg" width=710 
                        height=431></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><!--right end--></TR></TBODY></TABLE></TD></TR><!--mid end--></TABLE></TD></TR></TABLE><!--foot--><LINK 
rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/manager/image/sql2000/base.css">

  </body>
</html>
