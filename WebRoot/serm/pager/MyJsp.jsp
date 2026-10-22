<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>服务器管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="f6f6f6">
<div  style="color:#3fade0; font-size:50px; font-weight:bold; height:450px; width:100%;line-height:450px; background:url(./serm/images/cumputer.jpg); background-repeat:no-repeat; text-indent:480px; margin-top:50px;">欢迎进入服务器管理系统</div>
</body>
</html>