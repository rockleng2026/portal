<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>到货单信息表</title>

</head>
	<body>
	<FORM name="customerform" action="<c:if test="${data.id !=null}">updateToOrder.do</c:if>
		<c:if test="${data.id==null}">addToOrder.do	</c:if>	" method="post" onsubmit="return checkToOrder()">
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
										<TD width="100%" align=right>
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
						<TD ></TD>
						<TD  width="100%" >
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 width="100%"
								align=center border=1>
								<TBODY>					
								<TR>
										<TD width="100%" height=30 align="center" colspan="4">
											<h1>到货单</h1>
											
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											到货单编号：
										</TD>
										<TD width="25%"  class=category>
										${data.toOrderNum}
										<input type="hidden" id="orderNo" value="${data.toOrderNum}" />
										
											<input type="hidden" id="tab" value="ToOrder">
											<input type="hidden" id="filed" value="toOrderVerify">
											<input type="hidden" id="orderName" value="toOrderNum">
											<input type="hidden" id="price" value="grossmoney">
										</TD>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${data.toOrderVerify==0||data.toOrderVerify==null}">
													未审核
													</c:if>
													<c:if test="${data.toOrderVerify==1||data.toOrderVerify==2}">
													已审核
													</c:if>
													<c:if test="${data.toOrderVerify==3}">审核通过已退货</c:if>
													<c:if test="${data.toOrderVerify==8}">审核进行中</c:if>
										</TD>
									</TR>																				
									<TR>
										<TD width="25%" height=30 align=right>
											订单编号：
										</TD>
										<TD width="25%"  class=category>
										${data.purOrder.purOrderNo}
										</TD>
										<TD width="25%"  height=30 align=right>
										批次编号：
										</TD>
										<TD width="25%"  class=category>
										${data.piciNo}
										</TD>
									</TR>	
				
									<TR>
										<TD width="25%" height=30 align=right>
											到货日期：
										</TD>
										<TD width="25%" class=category>
											${data.totime}
										</TD>
										<TD width="25%" height=30 align=right>
										采购类型：
										</TD>
										<TD width="25%" class=category>
										${data.buytype}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											交货方式：
										</TD>
										<TD width="25%" class=category>
											${data.deliverytType}
										</TD>
										<TD width="25%" height=30 align=right>
										交货日期：
										</TD>
										<TD width="25%" class=category>
										${data.deliveryTime}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											交货人：
										</TD>
										<TD width="25%" class=category>
										${data.deliveryer}
											
										</TD>
										<TD width="25%" height=30 align=right>
										联系电话：
										</TD>
										<TD width="25%" class=category>
										${data.phone}
											
										</TD>
									</TR>
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											交货地址：
										</TD>
										<TD width="25%" class=category >
										${data.deliveryaddress}
											
										</TD>	
									
										<TD width="25%" height=30 align=right>
											供应商地址：
										</TD>
										<TD width="25%" class=category >
											 ${data.supplieraddress}
										</TD>									
									</TR>	
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											是否开票：
										</TD>
										<TD width="25%" class=category>
											<c:if test="${data.isBilling=='on'}">开 </c:if>
											<c:if test="${data.isBilling=='off'}">开 </c:if>
										</TD>
										<TD width="25%" height=30 align=right>
										结款方式：
										</TD>
										<TD width="25%" class=category>
											${data.payType}
										</TD>
									</TR>	
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											约定支付方式：
										</TD>
										<TD width="25%" class=category>
										${data.payAppointType}
											
										</TD>
										<TD width="25%" height=30 align=right>
										运费结算：
										</TD>
										<TD width="25%" class=category>
										${data.paytraffic}
										
										</TD>
									</TR>		
									<TR>
										<TD width="25%" height=30 align=right>
											运单号：
										</TD>
										<TD width="25%" class=category>
										${data.trafficOrdernum}
										
										</TD>
										<TD width="25%" height=30 align=right>
										运单总额：
										</TD>
										<TD width="25%" class=category>
										${data.orderGross}
											
										</TD>
									</TR>
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											物流公司：
										</TD>
										<TD width="25%" class=category>
										${data.trafficcompany}
											
										</TD>
										<TD width="25%" height=30 align=right>
										物流联系人：
										</TD>
										<TD width="25%" class=category>
										${data.trafficLinkman}
											
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											物流电话：
										</TD>
										<TD width="25%" class=category>
										${data.trafficphone}
											
										</TD>
										<TD width="25%" height=30 align=right>
										总金额：
										</TD>
										<TD width="25%" class=category>
										${data.grossmoney}
											
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
										经办部门：
										</TD>
										<TD width="25%"  class=category>
											${data.department.name}
											
										</TD>
										<TD width="25%" height=30 align=right>
										经办人：
										</TD>
										<TD width="25%" class=category>
											${data.employee.name}
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" width="25%" height=30 align=right>
											备注：
										</TD>
										<TD width="25%" class=category colspan="3">
										${data.remark}
										</TD>									
									</TR>
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作：
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${data.toOrderNum}','ToOrder','toOrderVerify','toOrderNum')"/>
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
										<td class=category colspan="4" align="center">采购订单商品明细</td>
									</tr>
									<tr>
									<td colspan="12">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs" width="100%">
									<TR>
										<TD align=center height=30 >
											采购商品：
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
							<c:if test="${not empty data}">
								<c:forEach items="${purorderinfo}" var="data" varStatus="status">
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
										<td class=category colspan="4" align="center">到货单商品明细</td>
									</tr>
									<tr>
									<td width="100%"  colspan="12">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs" width="100%">
									<TR>
										<TD align=center height=30 >
											选择订单中商品：
										</TD>
										<TD align=center height=30 >
											应购数量：
										</TD>
										<TD align=center height=30 >
											实际到货量：
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
							<c:if test="${not empty data}">
								<c:forEach items="${explist}" var="data" varStatus="status">
									<tr id="tr${status.index+1}">
										<td  align=center height=30>
											${data.model.name}
										</td>
										<td  align=center height=30>
											${data.purcount}
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