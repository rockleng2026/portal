<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>缓存-更新</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
	</head>
	<script type="text/javascript">
		function step()
		{
			window.location.href='<%=request.getContextPath()%>/showOrderaddCDNsaleOrderAction.Action';
		}
	</script>
	<body>
		<table width="100%">
			<tr>
				<td align="center" width="90%">
					<FONT color=#ff0000><h3>CDN订单列表2222</h3></FONT>
				</td>
				<td align="right" width="10%">
					<input id="" name="" type="button" value="添加" onclick="step()">
				</td>
			</tr>
		</table>
		<table width="100%" align="center"  height=30 bgColor=#fff8ed border=1 >
			<tr bgcolor="#c4d8ed">
				<td width="20%">源站域名</td>
				<td width="11%">套餐类型</td>
				<td width="11%">服务状态</td>
				<td width="12%">审核状态</td>
				<td width="12%">申请时间</td>
				<td width="12%">实际价格</td>
				<td width="12%">详细信息</td>
			</tr>
			<c:forEach items="${pages.pageList}"  var="data" varStatus="sid" >
			<tr>
				<td width="20%">${data.cuRealmName }</td>
				<td width="11%">
					<c:if test="${data.setmeal.chargeType=='0' }">免费</c:if>
					<c:if test="${data.setmeal.chargeType=='1' }">赠送</c:if>
					<c:if test="${data.setmeal.chargeType=='2' }">预付费</c:if>
					<c:if test="${data.setmeal.chargeType=='3' }">后付费</c:if>
				</td>
				<td width="11%">
					<c:if test="${data.serverFlag==1 }">开启</c:if>
					<c:if test="${data.serverFlag==2 }">关闭</c:if>
				</td>
				<td width="12%">
					<c:if test="${data.auditingState==0 }">未审核</c:if>
					<c:if test="${data.auditingState==1 }">审核通过</c:if>
					<c:if test="${data.auditingState==2 }">审核未通过</c:if>
					<c:if test="${data.auditingState==8 }">审核中</c:if>
				</td>
				<td width="12%">${data.time }</td>
				<td width="12%">${data.price }</td>
				<td width="12%">
					<a href="showOrderCDNsaleOrderAction.Action?id=${data.id }" >详细信息</a>
				</td>
				</tr>
			</c:forEach>
			<tr >
			<td class=TableDetail1 colspan="9" align="center">
				<p:pages url="showcdnlistCDNsaleOrderAction.Action"/>
			</td>
			</tr>
		</table>
		
	</body>

</html>
