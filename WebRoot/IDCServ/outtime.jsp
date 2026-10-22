<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'outtime.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=request.getContextPath() %>/IDCServ/js/jquery.js"></script>
<script type="text/javascript">

 setTimeout("test()",3000);
 
 function test(){
    window.location.href="<%=basePath%>IDCServ/writeAddress.jsp";
 }


</script>


  </head>
  
  <body>
  <jsp:include page="head.jsp"></jsp:include>
     <jsp:include page="left.jsp"></jsp:include>
     <hr/>
    &nbsp;&nbsp;<font style="font-size: 15px;">
           亲！你还没有填写送货地址，三秒钟帮你跳转到填写<a href="<%=basePath%>IDCServ/writeAddress.jsp">增加送货地址</a>页面
   </font>
   
<jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
