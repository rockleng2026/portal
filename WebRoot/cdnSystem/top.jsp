<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<div id="header" class="main">
	<div style="float:left;width:90px;">
		<img  src="<%=path%>/cdnSystem/images/logo.png"/>
	</div><div style="float:left; line-height:72px;">CDN管理系统</div><div style="float:left">
		<div style="height:45px;">
		
        
     <table class="xd_z_zi" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="7%" height="26">&nbsp;</td>
            <td width="41%">欢迎<span style=" font-weight:bold; color:#000"><img src="<%=path%>/cdnSystem/images/jt.jpg" width="8" height="12" />${user.userName }</span>&nbsp;&nbsp;当前时间2013-1-9&nbsp;周三下午&nbsp;16:37:04</td>
            <td style="color:#4581bd" width="17%"> <a href="手机短信找回密码.html">修改密码</a>丨<a href="CDN登陆界面.html">退出系统</a></td>
            <td width="15%" align="right"><img src="<%=path%>/cdnSystem/images/bangzhu.jpg" width="77" height="24" /></td>
            <td width="20%" align="left"><img src="<%=path%>/cdnSystem/images/guanyu.jpg" width="65" height="27" /></td>
          </tr>
        </table>
   
        
        
        
        
	  </div>
		<div id="nav" style="background:url('<%=path%>/cdnSystem/images/nav_l.png') no-repeat left; height:27px; padding-left:8px;">
			<div id="xuanxiangka"><ul class="myList">
			    <li><a class="current">首页</a></li>
			    <li><a href="CDN系统配置中心.html">配置中心</a></li>
			    <li><a>统计中心</a></li>
			    <li><a href="CDN系统网页加速频道下拉菜单.html">宽带信息</a></li>
			    <li><a href="cdnSystem/selectUrlCdnSystemAction.Action">实时刷新</a></li>
			    <li><a href="日志下载.html">日志下载</a></li>
			    <li><a href="<%=path%>/cdnSystem/cdnAccount.jsp">我的账户</a></li><li></li></ul></div>
		</div>
	</div>
</div>
