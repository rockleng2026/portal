<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>采购退货单信息表</title>
</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
				
					<TR>
					<font >审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD align=right>
											
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>					
								<TR>
										<TD height=30 align="center" colspan="4">
											<h1>采购退货单详信息</h1>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											采购退货单编号：
											<input type="hidden" id="orderNo" value="${returnorder.purReturnNo}" />
											<input type="hidden" id="tab" value="ReturnOrder">
											<input type="hidden" id="filed" value="returnOrderVerify">
											<input type="hidden" id="orderName" value="purReturnNo">
											<input type="hidden" id="price" value="grossmoney">
										</TD>
										<TD width="25%"  class=category>
										${returnorder.purReturnNo}
										</TD>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${returnorder.returnOrderVerify==0||returnorder.returnOrderVerify==null}">
													未审核
													</c:if>
													<c:if test="${returnorder.returnOrderVerify==1||returnorder.returnOrderVerify==2}">
													已审核
													</c:if>
													<c:if test="${returnorder.returnOrderVerify==8}">审核进行中</c:if>
													</TD>
										<!-- 
											<% int j=0; %>
											<c:forEach items="${auditingList}" var="adata">
											<c:if test="${adata.auditingFlag==1}">
											<input type="checkbox" name="aut" id="aut<%=j %>" style="border:0;" onclick="checkClick(<%=j %>,'ReturnOrder','returnOrderVerify','purReturnNo','verifyStateRejection.do?id=${returnorder.id }')" checked="checked" />
											</c:if>
											<c:if test="${adata.auditingFlag==0}">
											<input type="checkbox" name="aut" id="aut<%=j %>" style="border:0;" onclick="checkClick(<%=j %>,'ReturnOrder','returnOrderVerify','purReturnNo','verifyStateRejection.do?id=${returnorder.id }')"  />
											</c:if>
											<font size="1">${adata.department.name }</font>
											<% j++; %>
											</c:forEach>
										</TD>
										-->
									</TR>																									
									<TR>
										<TD width="100" height=30 align=right> 
											退货日期： 
										</TD>
										<TD width="400" class=category>
											${returnorder.returnTime}
										</TD>
										<TD width="100" height=30 align=right>
										采购类型：
										</TD>
										<TD width="400" class=category>
										${returnorder.buytype}
										</TD>
										
									</TR>	
				
									<TR>
										<TD width="25%" height=30 align=right>
											订单编号：
										</TD>
										<TD class=category>
											${returnorder.purOrder.purOrderNo}
										</TD>
										<TD height=30 align=right> 
										到货单编号： 
										</TD>
										<TD class=category>
											${returnorder.toOrder.toOrderNum}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											供应商：
										</TD>
										<TD class=category>
											${returnorder.supplier.supplierName}
										</TD>
										<TD width="25%" height=30 align=right>
											联系人：
										</TD>
										<TD class=category>
											${returnorder.purOrder.purOrderNo}
										</TD>
									</TR>	
									<TR>
										<TD height=30 align=right> 
										联系电话： 
										</TD>
										<TD class=category>
											${returnorder.supplier.mobilePhone}
										</TD>
										<TD height=30 align=right> 
										供应商地址： 
										</TD>
										<td class=category>
										${returnorder.supplier.supplierAddress}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											退货方式：
										</TD>
										<TD class=category>
											${returnorder.returnStyle}
										</TD>
										<TD height=30 align=right>
										退货原因：
										</TD>
										<TD class=category>
										${returnorder.returnReason}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											退货地址：
										</TD>
										<TD class=category>
											${returnorder.toOrder.deliveryaddress}
										</TD>
										<TD height=30 align=right>
											退货期限：
										</TD>
										<TD class=category>
											${returnorder.returnTimeLimit}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											退货说明：
										</TD>
										<TD class=category >
											${returnorder.returnDescription}
										</TD>	
										<TD width="25%" height=30 align=right>
											付款约定：
										</TD>
										<TD class=category >
											${returnorder.payappoint}
										</TD>									
									</TR>	
									
									<TR>
										<TD width="25%" height=30 align=right>
											是否开票：
										</TD>
										<TD class=category>
											<c:if test="${empty returnorder}">
												<input type="radio" name="isBilling" id="isBilling" value="on">开 <input type="radio" name="isBilling" id="isBilling" value="off">不开
											</c:if>
											<c:if test="${not empty returnorder}">
												<c:if test="${returnorder.isBilling=='on'}">
													<input type="radio" name="isBilling" id="isBilling" checked="checked">开
													 <input type="radio" name="isBilling" id="isBilling">不开
												</c:if>
												 <c:if test="${returnorder.isBilling=='off'}">
													<input type="radio" name="isBilling" id="isBilling">开
													 <input type="radio" name="isBilling" id="isBilling" checked="checked">不开
												</c:if>
											</c:if>
											&nbsp;
											<FONT color=#ff0000 id="isBilling1">*</FONT>
										</TD>
										<TD height=30 align=right>
										结款方式：
										</TD>
										<TD class=category>
											${returnorder.payType}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											约定支付方式：
										</TD>
										<TD class=category>
											${returnorder.payAppointType}
										</TD>
										<TD height=30 align=right>
										运费结算：
										</TD>
										<TD class=category>
											${returnorder.paytraffic}
										</TD>
									</TR>		
									<TR>
										<TD width="25%" height=30 align=right>
											运单号：
										</TD>
										<TD class=category>
											${returnorder.trafficOrdernum}
										</TD>
										<TD height=30 align=right>
										运单总额：
										</TD>
										<TD class=category>
											${returnorder.orderGross}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											物流公司：
										</TD>
										<TD class=category>
										${returnorder.trafficcompany}
										</TD>
										<TD height=30 align=right>
										物流联系人：
										</TD>
										<TD class=category>
											${returnorder.trafficLinkman}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											物流电话：
										</TD>
										<TD class=category>
											${returnorder.trafficphone}
										</TD>
										<TD height=30 align=right>
										总金额：
										</TD>
										<TD class=category>
											${returnorder.grossmoney}
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
										经办部门：
										</TD>
										<TD class=category>
											${returnorder.department.name}
										</TD>
										<TD height=30 align=right>
										经办人：
										</TD>
										<TD class=category>
											${returnorder.employee.name}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											备注：
										</TD>
										<TD class=category colspan="3">
											${returnorder.remark}
										</TD>									
									</TR>
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作:
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${returnorder.purReturnNo}','ReturnOrder','returnOrderVerify','purReturnNo')"/>
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
									<tr>
										<td class=category colspan="4" align="center">到货单商品明细</td>
									</tr>
									<tr>
									<td colspan="4">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs" width="100%">
									<TR>
										<TD align=center height=30 >
											到货商品：
										</TD>
										<TD align=center height=30 >
											购买数量：
										</TD>
										<TD align=center height=30>
											单价：
										</TD>
										<TD align=center height=30 >
											折扣：
										</TD>
										<TD align=center height=30 >
											总价：
										</TD>
									</TR>
							<c:if test="${not empty returnorder}">
								<c:forEach items="${explist}" var="data" varStatus="status">
									<tr id="tr${status.index+1}">
										<td  align=center height=30>
											${data.model.name}
										</td>
										<td  align=center height=30>
											${data.count}
										</td>
										<td  align=center height=30>
											${data.price}
										</td>
										<td  align=center height=30>
											${data.discount}
										</td>
										<td  align=center height=30>
											${data.sum}
										</td>
									</tr>
								</c:forEach>
							</c:if>
									</table>
									</td>
									</tr>	
									
									<tr>
										<td class=category colspan="4" align="center">采购退货单商品明细</td>
									</tr>
									<tr>
									<td colspan="4">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs" width="100%">
									<TR>
										<TD align=center height=30 >
											退货商品：
										</TD>
										<TD align=center height=30 >
											退货数量：
										</TD>
										<TD align=center height=30>
											单价：
										</TD>
										<TD align=center height=30 >
											折扣：
										</TD>
										<TD align=center height=30 >
											总价：
										</TD>
									</TR>
							<c:if test="${not empty returnorder}">
								<c:forEach items="${returnorderinfo}" var="data" varStatus="status">
									<tr id="tr${status.index+1}">
										<td  align=center height=30>
											${data.model.name}
										</td>
										<td  align=center height=30>
											${data.count}
										</td>
										<td  align=center height=30>
											${data.returnprice}
										</td>
										<td  align=center height=30>
											${data.discount}
										</td>
										<td  align=center height=30>
											${data.sum}
										</td>
									</tr>
								</c:forEach>
							</c:if>
									</table>
									</td>
									</tr>	
								</TBODY>
							</TABLE>
						</TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</body>
</html>