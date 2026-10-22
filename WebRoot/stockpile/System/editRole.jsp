<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="roleListSystemRole.do?funid=106">角色列表</a>&nbsp;>&nbsp;修改角色
	</font></div>
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						角色名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="text" name="roleName" id="roleName" value="${role.roleName}"/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属父级角色
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
						<select name="superId" id="superId">
							
							<c:forEach items="${rolelist}" var="data">
								<c:if test="${data.roleId==role.superId}">
									<option value="${data.roleId }" selected="selected">${data.roleName }</option>
								</c:if>
								<c:if test="${data.roleId!=role.superId}">
									<option value="${data.roleId }">${data.roleName }</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						角色描述
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<textarea rows="4" cols="50" name="roledescription" id="roledescription" value="">${role.roledescription}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left" nowrap style="width: 450px" class="bg1">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="提交" onclick="saveOrUpdate()"/>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
<script type="text/javascript">
	function saveOrUpdate() {
		var rolename = encodeURI($("#roleName").val());
		var superId = $("#superId").val();
		var description = encodeURI($("#roledescription").val());
		var url = "saveOrUpdateSystemRole.do";
		$.post(url, {roleid:${role.roleId},rolename : rolename,superid : superId,desc : description}, function(data) {
			if (data > 0) {
				alert("操作成功提交");
				window.location.href="roleListSystemRole.do";
			}
		});
	}
		</script>
	</body>
</html>
