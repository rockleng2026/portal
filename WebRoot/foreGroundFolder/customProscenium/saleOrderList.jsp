<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ page language="java" import="java.util.Date" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0041)http://www.ebadu.com/manager/notelist.asp -->
<HTML>
	<HEAD>
		<TITLE>帮助留言</TITLE>
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description content=进销存>
		<META name=keywords content="进销存">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico" />
		<META name=GENERATOR content="MSHTML 8.00.6001.19154" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
	</HEAD>
	<BODY leftMargin=0 topMargin=0>
		<TABLE border=0 cellSpacing=1 cellPadding=2 width="95%"
			bgColor=#cccccc align=center>
			<TBODY>
				<TR>
					<TD COLSPAN="7">
						&nbsp;当前操作-》订单信息:
					</TD>
					
				</TR>
				<tr>
				
				<td width="9%">订单到期</td><td width="2%" style="background: #DFF0A1;"></td> 
				<td width="12%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单未到期</td><td width="2%" style="background: #FFFFD4;"></td>
				<td width="12%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单快到期</td><td style="background: #FFFFFF;" width="2%"></td>
				<td></td>
				</tr>
			</TBODY>
		</TABLE>
		<BR>
		<TABLE style="MARGIN-TOP: 8px" border=0 cellSpacing=0 cellPadding=0
			width="95%" align=center height=30 bgcolor="#cccccc">
			<TBODY>
				<TR>

					<TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 width=53
						align="center">
						<A href="select1saleOrder.Action?userName=${customer.customerName}&deadline=suoyou">所有订单</A>
					</TD>
					<TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 width=53
						align="center">
						<A href="select1saleOrder.Action?userName=${customer.customerName}&deadline=daoqi">到期订单</A>
					</TD>
					<TD style="BORDER-RIGHT: #ffffff 0px solid" height=13 width=63
						align="center">
						<A href="select1saleOrder.Action?userName=${customer.customerName}&deadline=weidaoqi">未到期订单</A>
					</TD>
					<TD height=13 width=63 align="center">
						<SPAN style="BORDER-RIGHT: #ffffff 0px solid"><A href="select1saleOrder.Action?userName=${customer.customerName}&deadline=kuaidaoqi">

快到期订单</A>
						</SPAN>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<BR>
		<table border="0" align=center cellpadding="2" cellspacing="1"
			width="95%" bgcolor="#CCCCCC">
			<tr bgcolor="#F0F0F0">
				<td width=6% align=center>
					序号
				</td>
				<td width="16%" align="center">
					订单号
				</td>
				<td width="9%" align="center">
					订单类型
				</td>
				<td width="9%" align="center">
					使用情况
				</td>
				<td width="8%" align="center">
					开始时间
				</td>
				<td width="8%" align="center">
					到期时间
					
					
				</td>
				<td width="10%" align="center">
					审核是否通过
				</td>
				<td width="14%" align="center">
					付费情况
				</td>
				<td width=8% align=center>
					详细信息
				</td>
			</tr>
			<c:forEach items="${pages.pageList}" var="data" varStatus="status">
				<c:if test="${(nowDate)>=(data.endTime)}">
					<tr style="background: #DFF0A1;">
				</c:if>
				<c:if test="${(fifteenDate)>=(data.endTime) && (nowDate)<(data.endTime)}">
					<tr style="background: #FFFFFF;">
				</c:if>
				<c:if test="${(nowDate)<(data.endTime) && (fifteenDate)<(data.endTime)}">
					<tr style="background: #FFFFD4;">
				</c:if>
				<td width=6% align=center>
					${status.index+1}
				</td>
				<td width="16%" align="center">
					${data.saleOrderNo}
				</td>
				<td width="9%" align="center">
					${data.allTypeByOrdertype.questionName}
				</td>
				<td width="9%" align="center">
					${data.allTypeByPayStatus.typeName}
				</td>
				<td width="8%" align="center">
					${data.beginTime}
				</td>
				<td width="8%" align="center">
					 ${data.endTime}
					
					
				</td>
				<td width="10%" align="center">
					<c:if test="${data.auditingState==0||data.auditingState==null}">
					未审核
					</c:if>
					<c:if test="${data.auditingState==1 ||data.auditingState==2}">
					审核通过
					</c:if>
					<c:if test="${data.auditingState==8}">审核进行中  </c:if>
				</td>
				<td align="center">
				<c:if test="${(nowDate)>=(data.endTime)}">已到期&nbsp;(过期${data.day}天)</c:if>
				<c:if test="${(fifteenDate)>=(data.endTime) && (nowDate)<(data.endTime)}">快到期&nbsp;(${data.day}天到期)</c:if>
				<c:if test="${(nowDate)<(data.endTime) && (fifteenDate)<(data.endTime)}">未到期&nbsp;(${data.day}天到期)</c:if>
				</td>
				<td width=8% align=center>
					<a href="selectInfosaleOrder.Action?saleOrderNo=${data.saleOrderNo}">详细信息</a>
					
				</td>
				</tr>
			</c:forEach>
			<TR>  	 
				<TD class=category colSpan=14 height=30>
					<p:pages url="select1saleOrder.do?" />
				</TD>
			</tr>
		</table>
		<BR>
	</BODY>
</HTML>
