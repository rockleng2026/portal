<%@ page language="java" contentType="text/html; charset=GBK" 	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<body onload="showMessage()">
		<c:if test="${message}">
			<input type="hidden" id="message" value="${message }"/>
		</c:if>
		<table width="100%">
			<tr>
				<td align="center" width="90%">
					<FONT color=#ff0000><h3>CDN订单列表11111</h3></FONT>
				</td>
			</tr>
		</table>
		<table width="100%" align="center"  height=30 bgColor=#fff8ed border=1 >
			<tr bgcolor="#c4d8ed">
				<td width="16%">源站域名</td>
				<td width="8%">客户</td>
				<td width="8%">服务状态</td>
				<td width="16%">审核状态</td>
				<td width="10%">申请时间</td>
				<td width="10%">实际价格</td>
				<td width="9%">详细信息</td>
				<td width="5%">修改</td>
				<td width="5%">删除</td>
			</tr>
			<c:forEach items="${pages.pageList}"  var="data" varStatus="sid" >
			<tr>
				<td width="16%">${data.cuRealmName }</td>
				<td width="8%">
				<a href="customerListSystem.do">${data.customer.customerName }</a>
				</td>
				<td width="8%">
					<c:if test="${data.serverFlag==1 }">开启</c:if>
					<c:if test="${data.serverFlag==2 }">关闭</c:if>
				</td>
				<td width="16%">
					<c:if test="${data.auditingState==0 }">未审核</c:if>
					<c:if test="${data.auditingState==1 }">
						审核通过
					</c:if>
					<c:if test="${data.auditingState==2 }">审核未通过</c:if>
					<c:if test="${data.auditingState==8 }">审核中</c:if>
				</td>
				<td width="10%">${data.time }</td>
				<td width="10%">${data.price }</td>
				<td width="9%">
					<a href="showOrder1CDNsaleOrderAction.do?id=${data.id }" >详细信息</a>
					<!-- <a href="showCustConfiglistCDNsaleOrderAction?id=${data.id }" >配置加速</a> -->
					<a href="cdnRealmNameIPCDNsaleOrderAction.do?cusid=${data.customer.customerId }&realmName=${data.cuRealmName }" >配置加速</a>
				</td>
				<td width="5%">
					<a href="updateCDNsaleOrderAction.do?id=${data.id }" >修改</a>
				</td>
				<td width="5%">
					<input id="" name="" onclick="del(${data.id})" type="button" value="删除"/>
				</td>
				</tr>
			</c:forEach>
			<tr >
			<td class=TableDetail1 colspan="9" align="center">
				<p:pages url="showcdnlist1CDNsaleOrderAction.do"/>
			</td>
			</tr>
		</table>
		
	</body>

</HTML>
	<SCRIPT type="text/javascript">
		function del(id)
		{
			var url="delCDNsaleOrderAction.do";
				$.post(url,{id:id},function(data){
				if(data==1)
				{
					alert("删除成功！！！");
					window.location.href='<%=request.getContextPath() %>/showcdnlist1CDNsaleOrderAction.do';
				}
				else
				{
					alert("删除失败！！！");
				}
			});
		}
	</SCRIPT>
