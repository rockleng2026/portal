<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>CDN订单详细</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
  	详细信息:
    <table width="100%" align="center"   bgColor=#fff8ed border=1>
    	<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">CDN编号</td>
			<td width="30%">${cdnsale.saleOrderNo }</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">申请时间</td>
			<td width="30%">${cdnsale.time }</td>
		</tr>
		
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">IP区间数</td>
			<td width="30%">${cdnsale.IPinterval}
			</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">PV区间数</td>
			<td width="30%">${cdnsale.PVinterval}</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">附件平均数</td>
			<td width="30%">${cdnsale.accessoryfile }
			</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">多数文件大小</td>
			<td width="30%">${cdnsale.mostfile}</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">加速</td>
			<td width="30%">${jiasu }
			</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">备案号</td>
			<td width="30%">${cdnsale.recordsNO}</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">开始运行时间</td>
			<td width="30%">${cdnsale.starttime }</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">结束运行时间</td>
			<td width="30%">${cdnsale.endtime }</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">实际价格</td>
			<td width="30%">${cdnsale.price }元</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">付费类型</td>
			<td width="30%">
				<c:if test="${cdnsale.setmeal.chargeType==0 }">免费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==1 }">赠送</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==2 }">预付费</c:if>
				<c:if test="${cdnsale.setmeal.chargeType==3 }">后付费</c:if>
			</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">服务状态</td>
			<td width="30%">
				<c:if test="${cdnsale.serverFlag==1 }">开启</c:if>
				<c:if test="${cdnsale.serverFlag==2 }">关闭</c:if>
			</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">审核状态</td>
			<td width="30%">
				<c:if test="${cdnsale.auditingState==0 }">未审核</c:if>
				<c:if test="${cdnsale.auditingState==1 }">审核通过</c:if>
				<c:if test="${cdnsale.auditingState==2 }">审核未通过</c:if>
				<c:if test="${cdnsale.auditingState==8 }">审核中</c:if>
			</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">客户域名</td>
			<td width="30%">${cdnsale.cuRealmName }</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">系统域名</td>
			<td width="30%">${cdnsale.syRealmName }</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="right">套餐名</td>
			<td width="30%">${cdnsale.setmeal.name }</td>
			<td width="15%" bgcolor="#c4d8ed" align="right">域名类型</td>
			<td width="30%">${cdnsale.setmeal.realmtype.name }</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="right">套餐描述</td>
			<td width="80%" colspan="3">${cdnsale.setmeal.describe }</td>
		</tr>
		
		<tr>
			<td colspan="4" height="50" align="center">套餐详细</td>
		</tr>
		<tr>
			<td width="25%" bgcolor="#c4d8ed" align="center">名称</td>
			<td width="25%" bgcolor="#c4d8ed" align="center">流量</td>
			<td width="25%" bgcolor="#c4d8ed" align="center">带宽</td>
			<td width="25%" bgcolor="#c4d8ed" align="center">HIT连接数</td>
		</tr>
		<c:forEach items="${property}" var="datapro">
		<tr>
			<td width="25%"  align="center">${datapro.name }</td>
			<td width="25%"  align="center">${datapro.flow }</td>
			<td width="25%"  align="center">${datapro.bandwidth }</td>
			<td width="25%"  align="center">${datapro.hitnum }</td>
		</tr>
		</c:forEach>
	</table>
	<table width="100%" align="center"   bgColor=#fff8ed border=1>
	<tr>
			<td colspan="4" height="50" align="center">套餐详细</td>
		</tr>
		<tr>
			<td width="20%" bgcolor="#c4d8ed" align="center">IP</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">端口</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">IP所在地</td>
			<td width="20%" bgcolor="#c4d8ed" align="center">运营商</td>
		</tr>
		<c:forEach items="${cdnlist}" var="cdnip">
		<tr>
			<td width="20%"  align="center">${cdnip.ip}</td>
			<td width="20%"  align="center">${cdnip.port}</td>
			<td width="20%"  align="center">${cdnip.address}</td>
			<td width="20%"  align="center">${cdnip.tmoblie }</td>
		</tr>
		</c:forEach>
	</table>
	<table width="100%" align="center"   bgColor=#fff8ed border=1>
		<tr>
			<td colspan="3" height="50" align="center">缓存规则</td>
		</tr>
		<tr>
			<td width="15%" bgcolor="#c4d8ed" align="center">是否缓存</td>
			<td width="60%" bgcolor="#c4d8ed" align="center">缓存内容</td>
			<td width="25%" bgcolor="#c4d8ed" align="center">缓存时间</td>
		</tr>
 		<c:if test="${cachelist==null}">
 		<tr>
			<td colspan="3" height="40" align="center">没有缓存规则！！！</td>
		</tr>
 		</c:if>
		<c:forEach items="${cachelist}" var="datacache">
		<tr>
			<td width="15%"  align="center">
				<c:if test="${datacache.cacheflag==1 }">缓存</c:if>
				<c:if test="${datacache.cacheflag==2 }">不缓存</c:if>
			</td>
			<td width="60%"  align="center">${datacache.cachecontent }</td>
			<td width="25%"  align="center">${datacache.contentime }</td>
		</tr>
		</c:forEach>
    </table>
    <table width="100%" align="center"   bgColor=#fff8ed border=1>
		<tr>
			<td colspan="4" height="50" align="center">回源IP</td>
		</tr>
		<tr>
			<td width="30%" bgcolor="#c4d8ed" align="center">运营商</td>
			<td width="30%" bgcolor="#c4d8ed" align="center">大地区</td>
			<td width="40%" bgcolor="#c4d8ed" align="center">回源IP</td>
		</tr>
		<c:if test="${districtlist==null}">
 		<tr>
			<td colspan="4" height="40" align="center">没有回源IP！！！</td>
		</tr>
 		</c:if>
		<c:forEach items="${districtlist}" var="datadis">
		<tr>
			<td width="30%"  align="center">${datadis.tmoblie }</td>
			<td width="30%"  align="center">${datadis.districtName }</td>
			<td width="40%"  align="center">${datadis.ip }</td>
		</tr>
		</c:forEach>
	</table>

  </body>
</html>
