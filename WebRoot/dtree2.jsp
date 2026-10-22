<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dtree.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="StyleSheet" href="Css/dtree.css" type="text/css" />
	<script type="text/javascript" src="js/dtree.js"></script>
  </head>
  
  <body>
<div class="dtree">

	<p><a href="javascript: dd.openAll();">open all</a> | <a href="javascript: dd.closeAll();">close all</a></p>

</div>
	<script type="text/javascript">	
		dd= new dTree('dd');
		dd.add('0','-1','²Ëµ¥¹¦ÄÜÊ÷');
	</script>
	<c:forEach items="${infolist}" var="data" varStatus="status">
		<c:if test="${data.functionId==(data.functionId)}">
			<script>
			dd.add('${data.functionId}','${data.superId}','${data.linkFunctionName}','${data.linkFunctionPage}','','','${data.imagepath}','','');
			</script>
		</c:if>
	</c:forEach>
	<script>document.write(dd);</script>
  </body>
</html>
