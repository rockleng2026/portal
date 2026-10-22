<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
	
	<script type="text/javascript">
	</script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>收款单详细信息</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/Css/jquery/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="GBK" />
			<script src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js" type="text/javascript"></script>
			<script src="<%=request.getContextPath()%>/js/juqery/lib/jquery.validationEngine.js" type="text/javascript"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
			<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function updateadpot(obj)
	{
		var id = obj;
		$.ajax({
			  type:"POST",
			  url:"updateAudcharge.do",
			  data:{
				"id":id
			  },
			  success:function(data){
					if(data =="1")
					{
						alert("接收成功!");	
						history.go(0);
					}
					if(data == "2")
					{
						alert("接收失败!");
					}
			}
			});
	}
	function updateVerf(obj)
	{
		var id = obj;
		var soid = $("#soid").val();
		var chid = $("#chid").val();
		$.ajax({
			  type:"POST",
			  url:"updateAudscharge.do",
			  data:{
				"id":id,
				"soid":soid,
				"chid":chid
			  },
			  success:function(data){
				if(data =="1")
				{
					alert("审批成功!");	
					history.go(0);
				}
				if(data == "2")
				{
					alert("审批失败!");
				}
			}
			});
	}
</script>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addcharge.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<font>审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
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
											<input type="hidden" id="chid"  name="chid" value="${charge.id}"/>
										<TD width="25%" height=30 align=right>收款单号：</TD>
										<TD width="75%" class=category>
										${charge.chargeNo}
										<input type="hidden" id="orderNo" value="${charge.chargeNo }"/>
										<input type="hidden" id="tab" value="Charge">
										<input type="hidden" id="filed" value="isAuditing">
										<input type="hidden" id="orderName" value="chargeNo">
										</TD>
									</TR>
									<TR>
											
										<TD width="25%" height=30 align=right>销售订单：</TD>
										<TD width="75%" class=category>
										${charge.orders.soNums}	
										<input type="hidden" id="soid" name="soid" value="${charge.orders.soId}" />
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											应付金额：
										</TD>
										<TD width="75%" class=category>
											${charge.accountPayable }
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											实付金额：
										</TD>
										<TD class=category>
										${charge.paymentAmount }
											
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款帐号：
										</TD>
										<TD class=category>
											${charge.payCode }
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款帐号：
										</TD>
										<TD class=category>
											${charge.accountNumber }
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款员工：
										</TD>
										<TD class=category>
												${charge.employeeByEmpId.name }
											   
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款人姓名：
										</TD>
										<TD class=category>
										<span >${charge.payerName }</span>
											
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											收款方式：
										</TD>
										<TD class=category>
										<span >${charge.defrayMode }</span>
											
										</TD>
									</TR>

									
									<TR>
										<TD align=right height=30>
											收款日期：
										</TD>
										<TD class=category>
											
												${charge.collectionTime }
										</TD>
									</TR>
									
										<TR>
										<TD align=right height=30>
											录入信息日期：
										</TD>
										<TD class=category>
										${charge.inputTime }
										</TD>
										
									</TR>
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
										${charge.remark }
										</TD>
										
									</TR>
									<TR>
										<TD align=right height=30>
											是否审核
										</TD>
										<TD class=category>
										<c:if test="${charge.isAuditing == 0||charge.isAuditing == null}">未审核</c:if>
										<c:if test="${charge.isAuditing == 1||charge.isAuditing == 2}">已审核</c:if>
										<c:if test="${charge.isAuditing ==8}">审核进行中</c:if>
										</TD>
										
									</TR>
									
									<c:if test="${charge.isAuditing != 2}">
									<TR>
										<TD height=30 align=right>
											审核操作:
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="updateadpot('${charge.id}','Charge','isAuditing','chargeNo')"/>
											  </c:if>
											<c:if test="${charge.isAuditing == 8}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="updateVerf('${charge.id}')"></c:if>
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
						<TD><br><br></TD>
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
