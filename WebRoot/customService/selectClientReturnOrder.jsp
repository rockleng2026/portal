<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加客户退单记录</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE> BODY {BACKGROUND-COLOR: #ffffff}</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addClientOrder.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;客户退单记录(带*号的为必填项)									
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
								
								   <TR>
										<TD align=right height=30>
											退单编号：
										</TD>
										<TD width="75%" class=category>
											${retundmentlog.clientOrderNum}
											<input type="hidden" id="orderNo" value="${retundmentlog.clientOrderNum}" />
											<input type="hidden" id="tab" value="RefundmentLog">
											<input type="hidden" id="filed" value="approveState">
											<input type="hidden" id="orderName" value="clientOrderNum">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											销售订单编号：
										</TD>
										<TD width="75%" class=category>
											${retundmentlog.saleOrder.saleOrderNo}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											销售人员：
										</TD>
										<TD width="75%" class=category>
											${retundmentlog.employeeByEmpId.name}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											退货人：
										</TD>
										<TD class=category>
											<%=request.getSession().getAttribute("loginName") %>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											退款时间：
										</TD>
										<TD class=category>
										 ${retundmentlog.returnTime}
										</TD>
									</TR>
									
									<tr>
									<td align=right>退款原因：
										</TD>
										<TD class=category>
											${retundmentlog.returnReason}
											</TD>
									</tr>
									<TR>
										
										<TD align=right height=30>
											退款期限：
										</TD>
										<TD class=category>
										 ${retundmentlog.returnLimitTime}
										</TD>
									</TR>
									 <TR>
										<TD align=right height=30>
											帐&nbsp;&nbsp;号：
										</TD>
										<TD width="75%" class=category>
											${retundmentlog.account}
										</TD>
									</TR>
									 <TR>
										<TD align=right height=30>
											退款金额：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${empty retundmentlog.money}">
												未统计
											</c:if>
											<c:if test="${retundmentlog.money>=0}">
												${retundmentlog.money}
											</c:if>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${retundmentlog.approveState==0||retundmentlog.approveState==null}">
													未审核
													</c:if>
													<c:if test="${retundmentlog.approveState==1||retundmentlog.approveState==2}">
													已审核
													</c:if>
													<c:if test="${retundmentlog.approveState==8}">审核进行中</c:if>
										</TD>
									</TR>	
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作:
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${retundmentlog.clientOrderNum}','RefundmentLog','approveState','clientOrderNum')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if>
									 
										<br></TD>

									</TR>
									</c:if>			
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
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
		</FORM>
					<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
</HTML>
