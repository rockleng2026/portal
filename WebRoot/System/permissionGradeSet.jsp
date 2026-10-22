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
	<script type="text/javascript">
	
		window.onload = function()
		{
			var functionIds = "${supergroupid}";
			var permissions = "${usergroupinfo.groupIds}";
			var resources = "${usergroupinfo.resourcePermission}";
			var functionIdArray = functionIds.split(",");
			var permissionArray = permissions.split(",");
			var resourceArray = resources.split(",");
			for(var i=0;i<functionIdArray.length;i++)
			{
				$("input[@name='checkName'][@value='"+functionIdArray[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			for(var j=0;j<permissionArray.length;j++)
			{
				$("input[@name='checkPermissionName'][@value='"+permissionArray[j]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			for(var k=0;k<resourceArray.length;k++)
			{
				$("input[@name='resourceSet'][@value='"+resourceArray[k]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
		};
		
		function selectSuperId(op)
		{
			var fid = op;
			var fids = fid.split(",");
			for(var i=0;i<fids.length;i++)
			{
				$("input[@name='checkName'][@value='"+fids[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
				$("input[@name='checkPermissionName'][@value='"+fids[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
		}
		
		function checkPermissionGrade(userid)
		{
			var userid = userid;
			var groupid = ""; 
			var supergroupid = "";
			var text = "";
			$("input[@name='checkName'][@checked]").each(function(){
				supergroupid +=$(this).val()+",";
			});
			$("input[@name='checkPermissionName'][@checked]").each(function(){
				groupid +=$(this).val()+",";
			});

			var groupPermission = $("#groupPermission").val();
			var resourceSet = "";
			$("input[name='resourceSet'][checked]").each(function(){
				resourceSet += $(this).val()+",";
				text += $(this).get(0).text;
			});
			
			var url = "setPermissionGradeGroup.do";
			$.post(url,{userid:userid,supergroupids:supergroupid,groupid:groupid,resourcePermission:resourceSet},function(data){
				if(data>0)
				{
					alert('权限等级设置成功');
					window.location.href="userListSystem.do?mark=employee";
				}
				else
				{
					alert('权限等级设置失败');
				}
			});
			
		}
	</script>
	<body>
	  <div class="currentlySet" >
	<font size="2">	当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;用户列表&nbsp;>&nbsp;权限等级设置 →  →  → 
		<a href="userListSystem.do?mark=customer" >客户列表</a>&nbsp;/&nbsp;
		<a href="userListSystem.do?mark=employee" >员工列表</a></font>
	</div>
	 <div class="currentlySet" >
	<font size="1" color="blue">&nbsp;&nbsp;&nbsp;&nbsp;
	登录帐号：${user.loginName}  &nbsp;&nbsp;
	上一次登录时间：${user.lastLoginTime}  &nbsp;&nbsp;
	上一次登录IP：${user.lastIpPart}		&nbsp;&nbsp;&nbsp;
	用户类型：<c:if test="${user.mark=='customer'}">客户</c:if><c:if test="${user.mark=='employee'}">员工</c:if>
	</font>  
	</div>
	<form action="" method="get">
		<div class="conSet">
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 50px" class="bg1">
						<font size="4px;">组ID</font>
					</td>
					<td align="center" nowrap style="width: 150px" class="bg1">
						<font size="4px;">组名</font>
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						<font size="4px;">说明</font>
					</td>
				</tr>
	<c:forEach items="${supergrouplist}" var="superdata">
    	<tr>
    		<td align="center" nowrap class="bg0">
    					${superdata.groupId}
    			</td>
    		<td align="left" nowrap class="bg0"> 
    			<input type="checkbox" id="checkName" name="checkName" value="${superdata.groupId }"/> 
    			<font size="4px;" color="#3366CC"> ${superdata.groupName }</font></td>
    		<td align="left" nowrap class="bg0"></td>
    	</tr>
    	<c:forEach items="${grouplist}" var="data">
    	<c:if test="${data.superGroupId==superdata.groupId}">
    	<tr>
    			<td align="center" nowrap class="bg0">
    					${data.groupId}
    			</td>
    			<td align="left" nowrap class="bg0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    				<input type="checkbox" id="checkPermissionName" name="checkPermissionName" value="${data.groupId }" onclick="selectSuperId('${superdata.groupId}')"/>
    				<font size="2.5px;" color="#CC9900">${data.groupName }</font></td>
    			
    			<td align="left" nowrap class="bg0">
    				<c:forEach items="${map}" var="map">
    					<c:if test="${data.grade==map.key}">
    						${map.value}
    					</c:if>
    				</c:forEach>
    			</td>
    	</tr>
    	</c:if>
    	</c:forEach>
    	</c:forEach>
    	<tr>
    		<td align="center" nowrap class="bg0"></td>
    		<td colspan="2" align="center" nowrap class="bg0"><FONT color=#ff0000>注：只有组权限角色为主管级别以上的才需要配置访问资源权限</FONT></td>
    	</tr>
    	<tr>
    		<td  colspan="3" nowrap class="bg0">
    			<table>
    				<tr>
    					<td nowrap class="bg0" width="200" align="center">设置访问资源权限</td>
    					<td nowrap class="bg0">
    					<c:forEach items="${infolist1}" var="info" varStatus="state">
							&nbsp;<input type="checkbox" id="resourceSet" name="resourceSet" value="${info.functionId }" />${info.linkFunctionName }&nbsp;
							<c:if test="${(state.index+1)%3==0}"><br/></c:if>
						</c:forEach>
    					</td>
    				</tr>
    			</table>
    		</td>
    	</tr>
    	<tr>
    		<td align="center" nowrap class="bg0" colspan="3">
    			<input type="button" onclick="checkPermissionGrade('${user.userId}')" value="提交"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			<input type="button" value="重置" onclick="checkcancel()"/>&nbsp;&nbsp;&nbsp;&nbsp;
    		</td>
    	</tr>
			</table>
		</div>
		</form>
	</body>
</html>
