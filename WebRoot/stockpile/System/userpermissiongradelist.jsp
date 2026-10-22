<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'userlis.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="Css/admin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/system.js"></script>
	</head>

	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;用户列表 →  →  → 
		<a href="userListSystem.do?mark=customer" >客户列表</a>&nbsp;/&nbsp;
		<a href="userListSystem.do?mark=employee" >员工列表</a>&nbsp;/&nbsp;
		<a href="userPermissionGradeListGr.do" >用户权限等级列表</a></font></div>
		
		<div class="conSet">
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="left" nowrap style="width: 100px" class="bg1">
						用户ID
					</td>
					<td align="left" nowrap style="width: 100px" class="bg1">
						用户帐号
					</td>
					<td align="left" nowrap style="width: 200px" class="bg1">
						上次登录时间
					</td>
					<td align="left" nowrap style="width: 100px" class="bg1">
						管理权限
					</td>
					<td align="left" nowrap style="width: 100px" class="bg1">
						状态
					</td>
					<td align="right" nowrap style="width: 50px" class="bg1">
						操作
					</td>
				</tr>
				<c:forEach items="${usergroupinfolist}" var="data">
				<tr>
					<td align="left" nowrap style="width: 100px" class="bg0">${data.userId }</td>
					<td align="left" nowrap style="width: 100" class="bg0">${data.loginName }</td>
					<td align="left" nowrap style="width: 200px" class="bg0">${data.lastLoginTime }</td>
					<td align="left" nowrap style="width: 100px" class="bg0">${data.roles.roleName }</td>
					<td align="left" nowrap style="width: 100px" class="bg0">
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</body>
</html>
