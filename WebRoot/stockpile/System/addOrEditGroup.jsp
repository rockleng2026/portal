<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addFunction.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="Css/admin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
	<script type="text/javascript" src="js/system.js" charset="gbk"></script>
	<script type="text/javascript" src="js/validators.js" charset="gbk"></script>
  </head>
  
  <body>
    <div class="currentlySet" >
<font size="3">
	<c:if test="${empty info}">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="selectFunctionsSystem.do?funid=103">组/成员列表</a>&nbsp;>&nbsp;新增组/成员
	</c:if>
	<c:if test="${not empty info}">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="selectFunctionsSystem.do?funid=103">组/成员列表</a>&nbsp;>&nbsp;修改组/成员
	</c:if>
		
	</font></div>
		<p align="right"><a href="skippageGroup.do?mark=grouppermission&&groupid=${groupid }">新增权限等级</a>&nbsp;&nbsp;&nbsp;
		<a href="selectgradelistGroup.do?groupid=${groupid }">权限等级列表</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						组/成员名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;"><input type="text" name="groupName" id="groupName" value="${groups.groupName}" onblur="checkValueByRules('groupName','','groupNameMsg')"/></div>
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="groupNameMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属组/成员
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<c:if test="${empty groups}">
							<select id="superGroupId" name="superGroupId">
								<c:forEach items="${superlist}" var="data">
									<c:if test="${data.groupId==groupid}">
										<option value="${data.groupId}" selected="selected">${data.groupName} </option>
									</c:if>
									<c:if test="${data.groupId!=groupid}">
										<option value="${data.groupId}">${data.groupName}</option>
									</c:if>
								</c:forEach>
							</select>
							</c:if>
							<c:if test="${ not empty groups}">
								<select id="superGroupId" name="superGroupId">
								<c:forEach items="${superlist}" var="data">
									<c:if test="${data.groupId==supergroups.groupId}">
										<option value="${data.groupId}" selected="selected">${data.groupName} </option>
									</c:if>
									<c:if test="${data.groupId!=groupid}">
										<option value="${data.groupId}">${data.groupName}</option>
									</c:if>
								</c:forEach>
							</select>
							</c:if>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						权限等级设置
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;">
							<select id="permissionGrade" name="permissionGrade"  onblur="checkpermission()">
								<c:if test="${empty groups}">
								<option value="">请选择</option>
								<c:forEach items="${grouppermissionlist}" var="map">
									<option value="${map.groupId}">${map.groupName}</option>
								</c:forEach>
								</c:if>
								<c:if test="${not empty groups}">
								<c:forEach items="${grouppermissionlist}" var="map1">
									<c:if test="${permission.groupName==map1.groupName}">
									<option value="${map1.groupId}" selected="selected">${map1.groupName}</option>
									</c:if>
									<c:if test="${groups.groupName!=map1.groupName}">
									<option value="${map1.groupId}">${map1.groupName}</option>
									</c:if>
								</c:forEach>
								</c:if>
							</select></div>
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="permissionGradeMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						权限等级描述  
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<textarea rows="4" cols="50" name="description" id="description">${groups.description}  ${groups.permissionGrade}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<c:if test="${empty supergroups}">
							<input type="button" value="提交" onclick="addGroup()"/>
							<input type="hidden" value="0" id="groupid" name="groupid"/>
						</c:if>
						<c:if test="${not empty supergroups}">
							<input type="button" value="修改" onclick="editGroup()"/>
							<input type="hidden" value="${groups.groupId}" id="groupid" name="groupid"/>						
						</c:if>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
		
		<script type="text/javascript">
			function checkpermission()
			{
				var value = $("#permissionGrade").val();
				if(value=="")
				{
					$("#permissionGradeMsg").html("请选择权限等级！");
					document.getElementById("permissionGrade").focus();
				}
				else
				{
					$("#permissionGradeMsg").html("");
				}
			}
		</script>
  </body>
</html>
