<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
  <head>
    
  </head>
  
  <body>
 <select name="" style="width: 160px" id="xsel4" onchange="change2()">
									<option value="0">
										-------
									</option>
									<c:forEach items="${list2 }" var="list2">
									
										<option value="${list2.id }">
											${list2.name }
										</option>
										</c:forEach>
								</select>
  </body>
</html>
