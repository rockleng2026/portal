<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
	
	<script type="text/javascript">
	</script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加收款单</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/Css/jquery/validationEngine.jquery.css" type="text/css" media="screen" title="no title" charset="GBK" />
		<script src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js" type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/js/juqery/lib/jquery.validationEngine.js" type="text/javascript"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="updatecharge.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;修改收款单资料(带*号的为必填项)
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
										<TD width="25%" height=30 align=right>销售订单：</TD>
										<TD width="75%" class=category><input type ="hidden" name="chargeNo" value="${charge.chargeNo }">
										<input id ="saleOrderNo"  value="${charge.saleOrder.saleOrderNo }" onclick="returnSome1('getSaleOrderListClientOrder.do?','saleOrderNo','saleOrderNoid','salePerson')">
											<input id="saleOrderNoid" type="hidden" name="saleOrderNo" value="${charge.saleOrder.id}">
											<input id = "isAuditing" type="hidden" name="isAuditing" value="${charge.isAuditing }">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											应付金额：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" onblur="checkValueByRules('accountPayable',['float'],'accountPayableMsg')" id="accountPayable" name="accountPayable" value="${charge.accountPayable }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><font color=#f0000 id="accountPayableMsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											实付金额：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="PaymentAmount" id="PaymentAmount"  onblur="checkValueByRules('PaymentAmount',['float'],'PaymentAmountMsg')" value="${charge.paymentAmount }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="PaymentAmountMsg" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款帐号：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" name="payCode" value="${charge.payCode }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款帐号：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" name="accountNumber" value="${charge.accountNumber}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款帐号：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" name="payerName" value="${charge.payerName}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款员工：
										</TD>
										<TD class=category>
												<input id="emp" value="${charge.employeeByEmpId.name }" onblur="checkValueByRules('emp','','empMsg')" onclick="returnSome('showDialogOutbound.do?mark=employee','emp','empid')">
											   	<input id="empid" name="empID" type="hidden" value="${charge.employeeByEmpId.id }" />
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											收款方式：
										</TD>
										<TD class=category>
										<input type="hidden" id="hiden" value="${charge.defrayMode }">
											<select name="defrayMode"  id="defrayMode">
											<option value="请选择">请选择支付方式</option>
											<option value="现金支付">现金支付</option>
											<option value="银行转账">银行转账</option>
											<option value="邮政">邮政</option>
											<option value="电汇">电汇</option>
											<option value="支票">支票</option>
											<option value="支付宝">支付宝</option>
											<option value="其他"> 其他</option>
											
											</select>
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>

									
									<TR>
										<TD align=right height=30>
											收款日期：
										</TD>
										<TD class=category>
											<INPUT class="validate[custom[date]]"  style="WIDTH: 150px" name="collectionTime"
												onclick="WdatePicker()" value="${charge.collectionTime }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
										</TD>
									</TR>
									
										<TR>
										<TD align=right height=30>
											录入信息日期：
										</TD>
										<TD class=category>
											<INPUT class="validate[custom[date]]"  style="WIDTH: 150px" name="inputTime"
												onclick="WdatePicker()" value="${charge.inputTime }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											<textarea name="remark" cols="50" rows="7" id="remark"></textarea>
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="accMsg3"></FONT>
										</TD>
									</TR>
									<c:if test="${charge.isAuditing eq 0 }">
									<TR>
										<TD align="center" height=30>
											审核：
										</TD>
										<TD class=category>
											<input type="hidden" name="getMoneyName" value="<%=request.getSession().getAttribute("loginName") %>">
											<input type="radio" name="checkchars" value="0" checked/>未审核   
											<input type="radio" name="checkchars" value="1" />审核
										</TD>
									</TR>
									</c:if>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<input type="hidden" name="id" value="${charge.id }">
											<INPUT  class=button type=submit value=" 确认修改 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>a</TD>
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
		<script type="text/javascript">
    window.onload= function chkselect(){
	var s1 = document.getElementById("defrayMode");
	var s2 = document.getElementById("hiden");
	for(i = 0;i<=s1.length;i++){
		if(s1.options[i].value == s2.value){
			s1.options[i].selected = true;
		}
	}
	}
</script>
	</BODY>
</HTML>
