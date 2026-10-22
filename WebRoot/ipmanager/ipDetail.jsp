<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
</head>		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>


		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<BODY>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
				<font >审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;上架单详细信息
										</TD>
										<TD align=right>
											&nbsp;<a href="javascript:history.go(-1);">返回</a>
											
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
						<TD>						
						</TD>
						<TD>
	
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="20%" height=30 align=right>
											上架单号：
										</TD>
										<TD width="30%" class=category>
											${oneUps.upNo}
											<input type="hidden" id="orderNo" value="${oneUps.upNo}" />
											<input type="hidden" id="tab" value="UpServer">
											<input type="hidden" id="filed" value="audtitingFlag">
											<input type="hidden" id="orderName" value="upNo">
										</TD>
				
										<TD width="20%" height=30 align=right>
											销售单号：
										</TD>
										<TD width="30%" class=category>
											<a href="infosaleOrder.do?info=info&id=${oneUps.saleOrder.id }" title="点击查看订单详细信息">${oneUps.saleOrder.saleOrderNo}</a>
										</TD>
									</TR>
									<tr>
										<td width="20%" height="30" align="right">
											单位名称：
										</td>
										<td  width="30%" class=category>
											${oneUps.customer.customerCompany }
										</td>
										<td width="20%" height="30" align="right">
											联系人：
										</td>
										<td  width="30%" class=category>
											${oneUps.customer.realName}
										</td>
									</tr>
									
									<TR>
										<TD width="20%" height=30 align=right>
											服务器名称：
										</TD>
										<TD width="30%" class=category>
											${oneUps.product.property.name}
										</TD>
										<TD width="20%" height=30 align=right>
											配置：
										</TD>
										<TD width="30%" class=category>
											<c:forEach items="${sonList}" var="son">
											${son.property.name }|
											</c:forEach>
										</TD>
									</TR>
									
									<TR>
										<TD  width="20%" align=right height=30>
											服务器Ip：
										</TD>
										<TD class=category>
											${oneUps.serverIp}
										</TD>
										<TD  width="20%" align=right height=30>
											机房位置：
										</TD>
										<TD class=category>
											${oneUps.serverLocation}
										</TD>
									</TR>
									
									<TR>
										<TD width="20%" align=right height=30>
											审核状态：
										</TD>
										<TD width="30%" class=category>
											<c:if test="${oneUps.audtitingFlag==0||oneUps.audtitingFlag==null}">
											未审核
											</c:if>
											<c:if test="${oneUps.audtitingFlag==1||oneUps.audtitingFlag==2}">
											已审核
											</c:if>
										</TD>
										<TD width="20%" align=right height=30>
											上架状态：
										</TD>
										<TD width="30%" class=category>
											<c:if test="${oneUps.upFlag==0}">
													未上架
													</c:if>
													<c:if test="${oneUps.upFlag==1}">
													已上架
													</c:if>
										</TD>
									</TR>
									<TR>
										<TD   width="20%"  align=right height=30>
											上架时间：
										</TD>
										<TD  width="30%" class=category>
													<c:set var="birthDate" scope="request" value="${oneUps.uptime}"  />
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
										</TD>
										<TD  width="20%" align=right height=30>
											下架时间：
										</TD>
										<TD  width="30%" class=category>
													<c:set var="birthDate" scope="request" value="${oneUps.downtime}"  />
											<%
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
										</TD>
									</TR>
									
									<TR>
										<TD   width="20%" align=right height=30>
											经手人：
										</TD>
										<TD   width="30%" class=category>
											${oneUps.employee.name}
										</TD>
										<TD  width="20%" align=right height=30>
											维护口令：
										</TD>
										<TD width="30%" class=category>
											${oneUps.maintenancePass}
										</TD>
									</TR>
									<TR>
										<TD  width="20%" align=right height=30>
											带宽数量：
										</TD>
										<TD width="30%" class=category>
											${oneUps.bandwidthAmount}
										</TD>
										<TD width="20%" align=right height=30>
											带宽限制：
										</TD>
										<TD width="30%" class=category>
											${oneUps.bandwidthThrottling}
										</TD>
									</TR>
									<TR>
										<TD height=30 align=right>
											备注：
										</TD>
										<TD class=category >
										${oneUps.temp}
									 </TD>
									 <td height=30 align=right>交换机名称:</td>
									 <td> ${oneUps.jhjname}</td>
									</TR>
									
									<tr>
									  <td height=30 align="right">
									    端口:
									 </td>
									 <td width="30%" class=category>
									   ${oneUps.port}
									 </td>
									 <td align="right">机柜号:</td>
									 <td>${oneUps.jgh}</td>
									</tr>
								
									
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作：
										</TD>
										<TD class=category colspan="3" >
										<c:if test="${mark=='mark'}" >
											<input type="button" value="接收" onClick="incepttime('${oneUps.upNo}','UpServer','audtitingFlag','upNo')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if>
									 
										<br></TD>
										<TD height=30 align=right>
											备注：
										</TD>
										<TD class=category >
										
									 </TD>

									</TR>
									</c:if>
								</TBODY>
							</TABLE>
							
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD>r</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
</HTML>
