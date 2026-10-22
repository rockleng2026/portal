<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'chenggong.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
 
  <body>
    <input id="aaa" value="${customer.customerfj }" />
    <img  style="width: 200px;height: 200px" src="<%=request.getContextPath()%>${customer.customerfj }">
    
  </body>
</html>
 <script type="text/javascript">
 /*
  function xzfj(){
  var aa=document.getElementById("aaa").value;
     //window.location.href="download1TaskUpload.do?url="+aa;
 }
 xzfj()
 */
 </script>
