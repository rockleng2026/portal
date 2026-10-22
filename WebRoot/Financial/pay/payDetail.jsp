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
<script type="text/javascript">
	<%--退款操作--%>
	function onVerif(temp,empid,pid,cusid)
	{
		var temps = temp;
		var empids = empid;
		var pids = pid;
		var cusids = cusid;
		var bool = window.confirm("你确认审批吗？");
		if(bool == true)
		{
			$.ajax({
				type:"POST",
				url:"updateVerifpay.do",
				data:{
					"temp":temps,
					"empid":empids,
					"payid":pids,
					"cusid":cusids
				},
				success:function(data){
					if(data =="1")
					{
						alert("审批成功!");
						window.location.href = "selectpay.do";
					}
					if(data =="2")
					{
						alert("操作失败!");
					}
				}
			});
		}else
		{
			return false;
		}
		
	}
</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<BODY>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
					<font>审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
					 
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
									
										<TD>
											&nbsp;付款单详细信息
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
										<TD width="25%" height=30 align=right>
											付款单号：
										</TD>
										<TD width="75%" class=category>
											${pmList.payNo}
											<input type="hidden" id="orderNo" value="${pmList.payNo}" />
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
										   审核是否通过：
										</TD>
										<TD class=category>
										<c:if test="${pmList.auditingState==0||pmList.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${pmList.auditingState==1||pmList.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${pmList.auditingState==8}">审核进行中</c:if>
													</TD>
										<!-- 
										<TD class=category>
											<c:if test="${pmList.auditingState==0||pmList.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${pmList.auditingState==1}">
													已审核
													</c:if>
											<% int j=0; %>
											<c:forEach items="${auditingList}" var="adata">
											<c:if test="${adata.auditingFlag==1}">
											<input type="checkbox" name="aut" id="aut<%=j %>" style="border:0;" onclick="checkClick(<%=j %>,'PaymentLog','auditingState','payNo')" checked="checked" />
											</c:if>
											<c:if test="${adata.auditingFlag==0}">
											<input type="checkbox" name="aut" id="aut<%=j %>" style="border:0;" onclick="checkClick(<%=j %>,'PaymentLog','auditingState','payNo')"  />
											</c:if>
											<font style="font-size: 10px" size="1">${adata.department.name }</font>
											<% j++; %>
											</c:forEach>
											
										</TD>
										 -->
									</TR>
									<TR>
										<TD align=right height=30>
											采购订单号：
										</TD>
										<TD class=category>
											${pmList.purOrder.purOrderNo}
											<input type="hidden" id="orderNo" value="${pmList.purOrder.purOrderNo}" />
											<input type="hidden" id="tab" value="PaymentLog">
												<input type="hidden" id="filed" value="auditingState">
												<input type="hidden" id="orderName" value="payNo">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款金额：
										</TD>
										<TD class=category>
											${pmList.paymentAmount}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category>
											${pmList.employee.name}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款时间：
										</TD>
										<TD class=category>
												
											${pmList.time}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											支付方式：
										</TD>
										<TD class=category>
											${pmList.defrayMode}
										</TD>
									</TR>
								
									<TR>
										<TD align=right height=30>
											收款帐号：
										</TD>
										<TD class=category>
											${pmList.account}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款名称：
										</TD>
										<TD class=category>
											${pmList.gatheringName}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											开户行：
										</TD>
										<TD class=category>
											${pmList.bankName}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											${pmList.remark}
										</TD>
									</TR>
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作：
										</TD>
										<TD class=category colspan="3">
										<!-- 业务总监 -->
										<c:if test="${pmList.emps.id==empcheif && pmList.temp=='0'}">
											<input type="button" value="审核0" style="CURSOR:pointer" onClick="onVerif('${pmList.temp}','${pmList.emps.id}','${pmList.id}','${pmList.customer.customerId}');"/>
										</c:if>
										<!-- CEO -->
										<c:if test="${pmList.emps.id==empCEO && pmList.temp=='1'}">
											<input type="button" value="审核1" style="CURSOR:pointer" onClick="onVerif('${pmList.temp}','${pmList.emps.id}','${pmList.id}','${pmList.customer.customerId}');"/>
										</c:if>
										<!-- CFO -->
										<c:if test="${pmList.emps.id==empCFO && pmList.temp=='2'}">
											<input type="button" value="审核2" style="CURSOR:pointer" onClick="onVerif('${pmList.temp}','${pmList.emps.id}','${pmList.id}','${pmList.customer.customerId}');"/>
										</c:if>
										
										
<%--										<c:if test="${mark=='mark'}">--%>
<%--											<input type="button" value="接收" onClick="incepttime('${pmList.payNo}','PaymentLog','auditingState','payNo')"/>--%>
<%--										 </c:if>--%>
<%--											<c:if test="${mark != 'mark'}">--%>
<%--									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>--%>
<%--									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>--%>
<%--									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }--%>
<%--									   </c:if>--%>
<%--									   </c:if>--%>
									 
										<br></TD>

									</TR>
									</c:if>
								</TBODY>
							</TABLE>
										
									<!--循环结束-->
								</TBODY>
							</TABLE>
						
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
</HTML>
