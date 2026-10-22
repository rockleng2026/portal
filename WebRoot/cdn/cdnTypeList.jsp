<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
        request.setCharacterEncoding("UTF-8");
%>

        
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户CDN线路配置列表</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
		<link type="text/css" rel="stylesheet"	href="<%=basePath%>Css/missionuse.css" />
	</head>
	<script type="text/javascript">
function updateTypeName()
{

	$.post("updateTypeNameCDNsaleOrderAction.do",{},function(data){
		if(data==1)
		{
			alert("添加成功");
			location.reload();
		}
	
	});
}
function delTypeName(id)
{
	if(confirm("确定要删除记录吗？")==true)
	{
		$.post("delTypeNameCDNsaleOrderAction.do",{id:id},function(data){
			if(data==1)
			{
				alert("删除成功");
			location.reload();
			}
			else{
				alert("删除失败");
			location.reload();
			}
		});
	}
}
</script>
	<body>
		<table>
		<tr>
			<td colspan="2">
				<input type="button" onclick="updateTypeName()"  value="更新" /> <span style="color:#f00;">*批量更新服务器的数据和本地对接</span>
			</td>
		</tr>
			<tr>
				<td>
					线路名称
				</td>
				<td>
					操作
				</td>
			</tr>
			<c:forEach items="${cdnType}" var="ct">
			<tr>
				<td>
					${ct.typeName }
				</td>
				<td>
					<input type="button"  onclick="delTypeName(${ct.id})" value="删除" />
				</td>
			</tr>
			</c:forEach>
		</table>
	</body>

</html>