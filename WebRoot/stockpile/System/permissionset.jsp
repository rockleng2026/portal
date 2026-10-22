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
	<script type="text/javascript" src="js/permission.js" charset="gbk"></script>
	</head>
	
	<script type="text/javascript">
	
		window.onload = function()
		{
			var functionIds = "${functionIds}";
			var permissions = "${permissions}";
			
			var functionIdArray = functionIds.split(",");
			var permissionArray = permissions.split(",");
			for(var i=0;i<functionIdArray.length;i++)
			{
				$("input[@name='checkName'][@value='"+functionIdArray[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			for(var j=0;j<permissionArray.length;j++)
			{
				$("input[@name='checkPermission'][@value='"+permissionArray[j]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			$("#showOrHiddenDiv1").show();
		};
		
	</script>

	<body>
	  <div class="currentlySet" >
<font size="2">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;用户列表&nbsp;>&nbsp;权限设置 →  →  → 
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
	<table align="center" width="800px" border="0" align="center" cellpadding="3" cellspacing="1" class="space tableBg">
	<tr nowrap class="bg0" hight="40">
		<td style="line-height: 40px;" align="center">
			<font size="3" color="blue">
			<c:forEach items="${superfunctionlist}" var="head">	&nbsp;<a href="javascript:void(0)" onclick="showDiv('${head.functionId}')">${head.linkFunctionName}</a>&nbsp;</c:forEach> 
		</font>
		</td>
	</tr>
	<tr>
		<td align="right" nowrap class="bg0" >
			是否全选<input id=chkall name=chkall type="checkbox" onclick="checkAll('checkName','checkPermission')" />&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
		<form action="" name="role">
			<c:forEach items="${superfunctionlist}" var="dataindex">
		<div id="showOrHiddenDiv${dataindex.functionId}" style="display:none; float: none; width: 800px;">
			<div class="conSet">
				<table width="800px" border="0" align="center" cellpadding="3" cellspacing="1" class="space tableBg">
					<c:forEach items="${superfunctionlist}" var="superdata">
						<c:if test="${superdata.functionId==dataindex.functionId}">
						<tr>
							<td align="left" nowrap class="bg0">
							<input type="checkbox" name="checkName" id="checkName" value="${superdata.functionId}">
							 <font size="4px;" color="#3366CC"> ${superdata.linkFunctionName }</font>
							</td>
							<td align="right" nowrap class="bg0" > </td>
						</tr>
						<c:forEach items="${funcntionlist}" var="data">
							<c:if test="${data.superId==superdata.functionId}">
								<tr>
									<td align="left" nowrap class="bg0">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="checkName" id="checkName" value="${data.functionId}" onclick="selectSuperId('${superdata.functionId}')">
										<font size="2.5px;" color="#CC9900">  ${data.linkFunctionName	}</font>
									</td>
									<td nowrap class="bg0">
										<c:if test="${not empty data.linkFunctionPage }">
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data.functionId }.1" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">添加
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data.functionId }.2" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">编辑
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data.functionId }.3" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">删除
    										<input type="checkbox" id=checkPermission name="checkPermission" value="${data.functionId }.4" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">按条件查询
    										<input type="checkbox" id=checkPermission name="checkPermission" value="${data.functionId }.5" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">审核
    									</c:if>
									</td>
								</tr>
								<c:forEach items="${funcntionlist}" var="data1">
									<c:if test="${data1.superId==data.functionId}">
										<tr>
											<td align="left" nowrap class="bg0">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="checkbox" name="checkName" id="checkName" value="${data1.functionId}" onclick="selectSuperId('${data.functionId},${superdata.functionId}')">
												   ${data1.linkFunctionName }
											</td>
										<td nowrap class="bg0">
										<c:if test="${not empty data1.linkFunctionPage }">
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data1.functionId }.1" onclick="selectSuperId('${data1.functionId},${data.functionId},${superdata.functionId}')">添加
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data1.functionId }.2" onclick="selectSuperId('${data1.functionId},${data.functionId},${superdata.functionId}')">编辑
    										<input type="checkbox" id="checkPermission" name="checkPermission" value="${data1.functionId }.3" onclick="selectSuperId('${data1.functionId},${superdata.functionId},${data.functionId}')">删除
    										<input type="checkbox" id=checkPermission name="checkPermission" value="${data1.functionId }.4" onclick="selectSuperId('${data1.functionId},${data.functionId},${superdata.functionId}')">按条件查询
    										<input type="checkbox" id=checkPermission name="checkPermission" value="${data1.functionId }.5" onclick="selectSuperId('${data1.functionId},${data.functionId},${superdata.functionId}')">审核
    									</c:if>
    									</td>
										</tr>
										<c:forEach items="${funcntionlist}" var="data2">
											<c:if test="${data2.superId==data1.functionId}">
												<tr>
													<td align="left" nowrap class="bg0">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<input type="checkbox" name="checkName" id="checkName" value="${data2.functionId}"  onclick="selectSuperId('${data1.functionId},${data.functionId},${superdata.functionId}')">
														  ${data2.linkFunctionName }
													</td>
													<td nowrap class="bg0">
														<c:if test="${not empty data2.linkFunctionPage }">
    														<input type="checkbox" id="checkPermission" name="checkPermission" value="${data2.functionId }.1" onclick="selectSuperId('${data2.functionId},${data1.functionId},${data.functionId},${superdata.functionId}')">添加
    														<input type="checkbox" id="checkPermission" name="checkPermission" value="${data2.functionId }.2" onclick="selectSuperId('${data2.functionId},${data1.functionId},${data.functionId},${superdata.functionId}')">编辑
    														<input type="checkbox" id="checkPermission" name="checkPermission" value="${data2.functionId }.3" onclick="selectSuperId('${data2.functionId},${data1.functionId},${data.functionId},${superdata.functionId}')">删除
    														<input type="checkbox" id=checkPermission name="checkPermission" value="${data2.functionId }.4" onclick="selectSuperId('${data2.functionId},${data1.functionId},${data.functionId},${superdata.functionId}')">按条件查询
    														<input type="checkbox" id=checkPermission name="checkPermission" value="${data2.functionId }.5" onclick="selectSuperId('${data2.functionId},${data1.functionId},${data.functionId},${superdata.functionId}')">审核
    													</c:if>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>		
</c:forEach>
</form>
		</td>
	</tr>
	<tr nowrap class="bg0">
		<td nowrap class="bg0" align="center">
			<input type="button" onclick="checkFunction(${userId})" value="提交"/>&nbsp;&nbsp;
    		<input type="button" value="重置" onclick="checkcancel()"/>
		</td>
	</tr>
</table>
	</body>
</html>
