<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
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
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;用户列表 →  →  → 
		&nbsp;
		<a href="userListSystem.do?mark=employee" >员工列表</a></font></div>
		
		<div class="conSet">
		<FORM name=form2 action="useCommodityStockpileDetails.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
						<a href="pageSkipSystem.do?userid=0">新增用户</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;用户列表记录查询
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 50px" class="bg1">
						用户ID
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						用户帐号
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						用户名称
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						所属部门
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						上次登录时间
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						角色权限
					</td >
					<td align="center" nowrap style="width: 100px" class="bg1">
						权限星级等级
					</td>
					<td align="right" nowrap style="width: 50px" class="bg1">
						操作
					</td>
				</tr>
				<c:forEach items="${pages.pageList}" var="data" varStatus="status">
				<tr>
					<td align="center" nowrap style="width: 50px" class="bg0">${status.index+1 }</td>
					<td align="center" nowrap style="width: 100" class="bg0">${data.loginName }</td>
					<td align="center" nowrap style="width: 100" class="bg0">${data.userName }</td>
					<td align="center" nowrap style="width: 100" class="bg0">
						<c:if test="${data.mark=='employee'}">
							<c:forEach items="${emplist}" var="emp">
								<c:if test="${emp.id==data.customerOrEmployeeId}">
									${emp.department.name}
								</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${data.mark=='customer'}">
							客户
						</c:if>
					</td>					
					<td align="center" nowrap style="width: 200px" class="bg0">${data.lastLoginTime }</td>
					<td align="center" nowrap style="width: 100px" class="bg0">${data.roles.roleName }</td>
					<td align="center" nowrap style="width: 100px" class="bg0">
						<c:forEach items="${ugilist}" var="data1">
							<c:if test="${data.userId==data1.key}">
								<c:forEach items="${map}" var="map">
									<c:if test="${map.key==data1.value}">${map.value}</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</td>
					
					<td align="right" nowrap class="bg0">
				<c:if test="${empid==2}">
							<c:if test="${data.userId!=2}">
								<a href="functionlistSystem.do?userid=${data.userId }">权限设置</a>
						<a href="permissionGradeListGroup.do?userid=${data.userId}">权限等级设置</a>
						<a href="pageSkipSystem.do?userid=${data.userId}" >修改</a>
						
						<a href="javascript:delUser('${data.userId}')" >删除</a>
						<a href="javascript:void(0)" onclick="distroy('${data.userId}','${data.status}')">
							
						</a>
							</c:if>
							<c:if test="${data.userId==2}">
								<a href="functionlistSystem.do?userid=${data.userId }">权限设置</a>
						<a href="permissionGradeListGroup.do?userid=${data.userId}">权限等级设置</a>
						<a href="pageSkipSystem.do?userid=${data.userId}" >修改</a>
							</c:if>
				</c:if>
				<c:if test="${empid!=2}">
					<c:if test="${data.userId!=2}">
								<a href="functionlistSystem.do?userid=${data.userId }">权限设置</a>
						<a href="permissionGradeListGroup.do?userid=${data.userId}">权限等级设置</a>
						<a href="permissionworkPosition.do?empid=${data.customerOrEmployeeId}">兼任管理</a>
						<a href="pageSkipSystem.do?userid=${data.userId}" >修改</a>
						<a href="javascript:delUser('${data.userId}')" >删除</a>
						<a href="javascript:void(0)" onclick="distroy('${data.userId}','${data.status}')">
						</a>
					</c:if>
						</c:if>
						
					</td>
				</tr>
				</c:forEach>
				<tr>
									<TD nowrap class="bg0" colSpan=16 height=30 align="right">
								     <p:pages url="userListSystem.do?mark=employee"/>
									</TD>
									</tr>
			</table>
			</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
		</div>
		<script type="text/javascript">
			function delUser(uid)
			{
				var str = window.confirm("您确定要删除该用户？");
				if(str==true)
				{
					 var url = "delUserSystem.do";
					 $.post(url,{uid:uid},function(data){
					 	if(data=="1")
					 	{
					 		alert("删除用户成功");
					 		window.location.href="userListSystem.do?mark=employee";
					 	}
					 	else
					 	{
					 		alert("删除用户失败");
					 		return ;
					 	}
					 });
				}
			}
		</script>
	</body>
</html>
