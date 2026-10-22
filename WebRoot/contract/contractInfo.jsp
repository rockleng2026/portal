<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%String path = request.getContextPath(); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>合同详细信息</title>


</head>
		<BODY >
		
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
											&nbsp;合同详细
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
										<TD width="15%" height=30 align=right>
											合同编号：<input type="hidden" id="orderNo" value="${contract.contractNo }">
											<input type="hidden" id="tab" value="Contract">
											<input type="hidden" id="filed" value="auditState">
											<input type="hidden" id="orderName" value="contractNo">
										</TD>
										<TD width="35%" class=category>
											${contract.contractNo }
										</TD>
										<TD width="15%" height=30 align=right>
											合同名称：
										</TD>
										<TD width="35%" class=category>
											${contract.contractName }
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											签约日期：
										</TD>
										<TD width="35%" class=category>
											${contract.signupTime }
										</TD>
										<TD align=right width="15%" height=30>
											客户名称：
										</TD>
										<TD width="35%" class=category>
											${contract.customer.customerCompany}
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											对方代表：
										</TD>
										<TD width="35%" class=category>
										${contract.customer.realName }
										</TD>
										<TD align=right width="15%" height=30>
											我放代表：
										</TD>
										<TD width="35%" class=category>
											${contract.employeeByEmpId.name}
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											生效日期：
										</TD>
										<TD width="25%" class=category>
											${contract.comeTime }
										</TD>
										<TD align=right width="15%" height=30>
											终止日期：
										</TD>
										<TD width="35%" class=category>
											${contract.endTime}
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right height=30>
										是否开票：
										</td>
								 		 <TD width="25%" class=category>
											<c:if test="${contract.isInvoice =='N' }"> 否</c:if>
											 <c:if test="${contract.isInvoice =='Y' }"> 是</c:if>
										</TD>
									<TD align=right width="15%" height=30>
											合同金额：
										</TD>
										<TD width="35%" class=category>
										${contract.contractMoney}
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											合同状态：
										</TD>
										<TD width="25%" class=category>											
											
												${contract.contractState}	
											
										</TD>
										<TD align=right width="15%" height=30>
											收款期限：
										</TD>
										<TD width="35%" class=category>
											${contract.gatheringTime}											
										</TD>
									</TR>
										<TR>
										<td width="25%" align=right height=30>
									备注：
										</td>
								     <td width="25%" class="category">										
													${contract.remark}	
									</td>
									<TD align=right width="15%" height=30>
											
										</TD>
										<TD width="35%" class=category>
											
										</TD>
									</TR>
										<TR>
										<TD height=30 align=right>
											审核状态
										</TD>
										<TD class=category colspan="3">
											<c:choose>
												  <c:when test="${contract.auditState=='0'}">
												 		未审核
												  </c:when>
												   <c:when test="${contract.auditState=='2'}">
												 		审核未通过
												  </c:when>
												  <c:otherwise>
												    	已审核
												  </c:otherwise>
												  </c:choose>
											
											<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onclick="incepttime('${saleorder.saleOrderNo}')"/>
											</c:if>
										<br></TD>
										
									</TR>
									
									<TR>
										<TD height=30 align=right>
											合同内容
										</TD>
										<TD class=category colspan="3">
									<textarea rows="10" cols="150" name="contractContent" readonly="readonly">${contract.contractContent }</textarea>											
										</TD>
									</TR>
									<TR>
										<TD height=30 align=right>
											合同附件
										</TD>
										<TD class=category colspan="3">
										
										
										
									  <c:if test="${flage=='0'}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>
									   <c:if test="${flage=='1'}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   
									   </c:if>
										<br></TD>
										
									</TR>																													
									
								</TBODY>
							</TABLE>
						</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
					<jsp:include page="uploanContractfile.jsp"></jsp:include>
					<jsp:include page="reviewSubmissions.jsp"></jsp:include>
					
	</BODY>
</HTML>
