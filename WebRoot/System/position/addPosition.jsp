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
		<title>新增岗位</title>
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
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="<%=path %>/positionListPosition.do?funid=106">岗位列表</a>&nbsp;>&nbsp;新增岗位
	</font></div>
	<form name="form1" id="form1" action="" method="post">
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						岗位名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
					        <input type="hidden" id="flag" value="${flag }">
					        <input type="hidden" name="position.id" id="positionid" value="${position.id}" />
					        <input type="hidden" name="position.functionIDs" value="${position.functionIDs }"/>
					        <input type="hidden" name="position.permissions" value="${position.permissions }"/>
							<div style="display:inline;">&nbsp;<input type="text" name="position.name" id="name" value="${position.name }" onblur="checkPosition()"/></div>	
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="positionNameMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						职位缩写
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="text" name="position.shortname" id="shortname" value="${position.shortname }" />
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属部门
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
						<select name="position.department.id" id="deptid">
							<c:forEach items="${deptlist}" var="data">
								<option <c:if test="${position.department.id==data.id }">selected</c:if> value="${data.id }">${data.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						岗位描述
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<textarea rows="4" cols="50" name="position.workcontent" id="workcontent">${position.workcontent }</textarea>
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
	</form>
<script type="text/javascript">
	function saveOrUpdate() {
		var name = $("#name").val();
		if(name==""){
			$("#positionNameMsg").html("该项不能为空");
			document.getElementById("name").focus();
			return ;
		}else{
			var flag=$("#flag").val();
			form1.action="<%=path%>/addPosition.do?flag="+flag;
			form1.submit();
		}
	}
	
	function checkPosition()
			{
				var value = $("#name").val();
				if(value=="")
				{
					$("#positionNameMsg").html("该项不能为空");
					document.getElementById("name").focus();
				}
				else
				{
					$("#positionNameMsg").html("");
				}
			}
		</script>
	</body>
</html>
