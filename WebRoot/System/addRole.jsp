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
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="roleListSystemRole.do?funid=106">角色列表</a>&nbsp;>&nbsp;新增角色
	</font></div>
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						角色名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;">&nbsp;<input type="text" name="roleName" id="roleName" value="" onblur="checkRoles()"/></div>	
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="roleNameMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属父级角色
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
						<select name="superId" id="superId">
							<c:forEach items="${rolelist}" var="data">
								<option value="${data.roleId }">${data.roleName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						角色描述
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<textarea rows="4" cols="50" name="roledescription" id="roledescription"></textarea>
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
		var rolename = encodeURI($.trim($("#roleName").val()));
		var superId = $("#superId").val();
		var description = encodeURI($("#roledescription").val());
		if(rolename=="")
		{
			$("#roleNameMsg").html("该项不能为空");
			document.getElementById("roleName").focus();
			return ;
		}
		else
		{
			var url = "saveOrUpdateSystemRole.do";
			$.post(url, {roleid:0,rolename : rolename,superid : superId,desc : description}, function(data) {
				if (data > 0) {
					alert("操作成功提交");
					window.location.href="roleListSystemRole.do";
				}
			});
		}
	}
	
	function checkRoles()
			{
				var value = $("#roleName").val();
				if(value=="")
				{
					$("#roleNameMsg").html("该项不能为空");
					document.getElementById("roleName").focus();
				}
				else
				{
					$("#roleNameMsg").html("");
				}
			}
		</script>
	</body>
</html>
