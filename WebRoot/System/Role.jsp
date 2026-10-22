<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	</head>

	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="roleListSystemRole.do">角色列表</a>
	</font></div>
	<p align="right">
		<c:forEach items="${option}" var="data1">
							<c:if test="${data1.key==1}">
								<a href="<%=basePath %>System/addRole.jsp">新增角色</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
		</c:forEach>
	</p>
		<div class="conSet">
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 50px" class="bg1">
						角色ID
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						角色名称
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						创建时间
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						操作
					</td>
				</tr>
			<c:forEach items="${rolelist}" var="data">
				<tr>
					<td align="center" nowrap style="width: 10px" class="bg1">${data.roleId}</td>
					<td align="center" nowrap style="width: 100px" class="bg1">${data.roleName}</td>
					<td align="center" nowrap style="width: 200px" class="bg1">${data.createTime}</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
					<a href="rolePermsionSetSystemRole.do?roleid=${data.roleId }">设置权限</a>
						<c:forEach items="${option}" var="data1">
							
							<c:if test="${data1.key==2}">
								<a href="editRoleSystemRole.do?roleid=${data.roleId}">修改</a>
							</c:if>
							<c:if test="${data1.key==3}">
								<a href="javascript:void(0)" onclick="delRole('${data.roleId}')">删除</a>
							</c:if>
							<c:if test="${data1.key==4}">
								<a href="javascript:void(0)">查询</a>
							</c:if>
						</c:forEach>
					</td>
				</tr>		
			</c:forEach>
			</table>
		</div>
		<script type="text/javascript">
			function delRole(id)
			{
				var str = "你确定要删除该角色吗？";
				
				if (window.confirm(str) == true)
				{
					var url = "delRoleSystemRole.do";
					$.post(url,{roleid:id},function (data){
						if(data>0)
						{
							alert("删除成功");
							window.location.href="roleListSystemRole.do?funid=106";
						}
						else
						{
							alert("删除失败");
							return ;
						}
					});
				}
			}
		</script>
	</body>
</html>
