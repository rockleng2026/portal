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
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						等级名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;"><input type="text" name="groupName" id="groupName" value="${groups.groupName}" onblur="checkValueByRules('groupName','','groupNameMsg')"/></div>
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="groupNameMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属组
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="text" id="" name="" value="${group.groupName}" style="color: gray" readonly="readonly" />
							<input type="hidden" name="superGroupId" id="superGroupId" value="${group.groupId}" />
							<input type="hidden" name="permissionGrade" id="permissionGrade" value="0" />
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">星级：</td>
					<td align="center" nowrap style="width: 150px" class="bg1">
						<select name="grade" id="grade">
							<option value="5">★★★★★</option>
							<option value="4.5">★★★★☆</option>
							<option value="4">★★★★</option>
							<option value="3.5">★★★☆</option>
							<option value="3">★★★</option>
							<option value="2.5">★★☆</option>
							<option value="2">★★</option>
							<option value="1.5">★☆</option>
							<option value="1" selected="selected">★</option>
							<option value="0.5">☆</option>
						</select>
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
							<input type="button" value="提交" onclick="addGradeGroup('addGradeGroup.do')"/>
							<input type="hidden" value="0" id="groupid" name="groupid"/>
						</c:if>
						<c:if test="${not empty supergroups}">
							<input type="button" value="修改" onclick="addGradeGroup()"/>
							<input type="hidden" value="${groups.groupId}" id="groupid" name="groupid"/>						
						</c:if>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
		
		<script type="text/javascript">
			function addGradeGroup(url)
			{
				var groupname = encodeURI($("#groupName").val());
				var supergroupid = $("#superGroupId").val();
				var permissionGrade = $("#permissionGrade").val();
				var description = encodeURI($("#description").val());
				var grade = $("#grade").val();
				var gid = $("#groupid").val();
				
				$.post(url,{groupid:gid,groupName:groupname,superGroupId:supergroupid,permissionGrade:permissionGrade,grade:grade,description:description},function(data){
					if(data=="1")
					{
						alert("执行新增等级成功");
						window.location.href = "groupListGroup.do?funid=107";
					}
					else
					{
						return ;
					}
				});
			}
		</script>
  </body>
</html>
