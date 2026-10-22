<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ taglib uri="/struts-tags" prefix="s" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<FCK:meta http-equiv="Content-Type" content="text/html; charset=gb2312"  />
<title>站内通讯</title>
<style type="text/css">
* {
font-size:12px;
text-align:center;
}
body {
background:#f0f0f0;
}
#nav {
width:700px;
margin:20px auto 0 auto;
}
#nav li {
display: inline;
list-style-type: none;
}
#nav li a:link,#nav li a:visited {
float:left;
margin-right:2px;
padding:3px 8px 3px 8px;
text-decoration: none;
color:#fff;
background:gray;
border-top:1px solid #fff;
border-right:1px solid #333;
border-bottom:1px solid #333;
border-left:1px solid #fff;
}
#nav li a:hover {
padding:2px 8px 4px 8px;
border-top:1px solid #333;
border-right:1px solid #fff;
border-bottom:1px solid #fff;
border-left:1px solid #333;
}
#nav li a#current {
color:#gray;
}
</style>
</head>
<body>
<ul id="nav">
<li><a href="selmessbyreadflagmessage.do?restypeid=2&readflag=0" target="right" _fcksavedurl="http://www.52css.com/">未读短消息</a></li>
<li><a href="http://localhost:8080/FAJxc/message/customer/sendmessage.jsp" target="right" _fcksavedurl="http://www.52css.com/" id="current">发送短消息</a></li>
<li><a href="http://www.52css.com/" _fcksavedurl="http://www.52css.com/">已发短消息</a></li>
<li><a href="selmessbyreadflagmessage.do?restypeid=2&readflag=1" _fcksavedurl="http://www.52css.com/">已收短消息</a></li>
<li><a href="http://www.52css.com/" _fcksavedurl="http://www.52css.com/">消息草稿箱 </a></li>
</ul>

<iframe id="win" style="border: 0px" frameborder="0" name="right" width="100%" scrolling="yes" 
     src=""></iframe>
</body>
</html>