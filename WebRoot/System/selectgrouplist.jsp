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
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="roleListSystemRole.do">组/成员列表</a>>&nbsp;等级权限列表
	</font></div>
		<div class="conSet">
			<p align="right"><c:forEach items="${option}" var="data1">
							<c:if test="${data1.key==1}">
								<a href="skippageGroup.do?mark=grouppermission&&groupid=${groupid}">新增</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if>
							</c:forEach>
			</p>
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 200px" class="bg1">
						等级名称
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						星级权限
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						创建时间
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						操作
					</td>
				</tr>
			<c:forEach items="${grouplist}" var="data">
				<tr>
					<td align="center" nowrap style="width: 200px" class="bg1"><font color="red">${data.groupName}</font></td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						<c:forEach items="${map}" var="map">
							<c:if test="${data.grade==map.key}">${map.value}</c:if>
						</c:forEach>
					</td>
					<td align="center" nowrap style="width: 200px" class="bg1">${data.startTime}</td>
					<td align="center" nowrap style="width: 200px" class="bg1">
						<c:forEach items="${option}" var="data1">
							<c:if test="${data1.key==3}">
								<a href="javascript:void(0)" onclick="deleteGroups('${data.groupId}')">删除</a>
							</c:if>
						</c:forEach>
					</td>
				</tr>	
			</c:forEach>
			</table>
		</div>

		<script type="text/javascript">
		//删除组成员
		function deleteGroups(gid)
		{
			var str = window.confirm("您确定要删除该等级权限？");
			if(str == true)
			{
				var url = "deleteGroup.do";
				$.post(url,{gid:gid},function(data){
					if(data>0)
					{
						alert("删除成功");
						window.location.href="selectgradelistGroup.do";
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
