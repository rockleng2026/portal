<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>上传附件</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <% String sbh=request.getParameter("sbh");
     %>
  <body>
    <div align="left"><h2>附件上传-<%if(sbh==null){ %>${sbh }<%}else{out.println(sbh);} %></h2></div>
    <form action="addfjcommonaction.do" id="addfj" name="addfj" method="Post">
    <%if(sbh==null){ %>
    <input type='hidden' id="sbh" name="sbh" value="${sbh}"/>
    <%}else{%>
    <input type='hidden' id="sbh" name="sbh" value="<%=sbh %>"/>
    <%} %>
    <input type='hidden' id="mark" name="mark" value="<%=request.getParameter("mark") %>" />
    <input type='hidden' id="formid" name="formid" value="addfj"/>
    </form>
    <jsp:include page="/mission/uploadfiles.jsp"></jsp:include>
    
  </body>
</html>
