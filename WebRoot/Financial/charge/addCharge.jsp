<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	<%String path = request.getContextPath(); %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加收款单</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>

	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function onselectByCode()
	{
		var code = $("#authcode").val();
		alert(code);
		$.ajax({
				type:"POST",
				url:"selectBycodecharge.do",
				data:{"code":code},
				success:function(data){
					if(data=="1")
					{
						
					}
					if(data=="2")
					{
						$("#code").val("请输入正确的验证码");
						return false;
					}
				}
			});
	}
</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
		<FORM  id ="form1" name=form1 action="addcharge.do" method="post">
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
											&nbsp;添加收款单资料(带*号的为必填项)
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
						<TD><br><br></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
											<TR>
										<TD width="25%" height=30 align=right>销售订单：</TD>
										<TD width="75%" class=category>
										<input id ="saleOrderNo"  value="${saleOrder.saleOrderNo }"  onclick="completemission('getSaleOrderListClientOrder.do?auditingState=1&page=charge','')">
											<input id="saleOrderNoid" type="hidden"  name="saleOrderNoid" value="${saleOrder.id}">
											<input id="saleOrderNo" type="hidden"  name="saleOrderNo" value="${saleOrder.id}">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											应付金额：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" onblur="checkValueByRules('accountPayable',['float'],'accountPayableMsg')" id="accountPayable" name="accountPayable" />
											&nbsp;
											<FONT color=#ff0000>*</FONT><font color=#ff0000 id="accountPayableMsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											实付金额：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" id="PaymentAmount" name="PaymentAmount"  onblur="checkValueByRules('PaymentAmount',['float'],'PaymentAmountMsg')" >
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="PaymentAmountMsg" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款帐号：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" name="payCode"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											付款人姓名：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" onblur="checkValueByRules('payerName',['payerName'],'payerName')" id="payerName" name="payerName"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="payerName" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款员工：
										</TD>
										<TD class=category>
										<input id="emp" value="${onedep.employee.name }" onblur="checkValueByRules('emp','','empMsg')" onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="empID" type="hidden" value="${onedep.employee.id }" />
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											收款方式：
										</TD>
										<TD class=category>
											<select id="defrayMode" name="defrayMode" onblur="checkValueByRules('defrayMode','','defrayModeMsg')">
											<option value="">请选择支付方式</option>
											<option value="现金支付">现金支付</option>
											<option value="银行转账">银行转账</option>
											<option value="邮政">邮政</option>
											<option value="电汇">电汇</option>
											<option value="支票">支票</option>
											<option value="支付宝">支付宝</option>
											<option value="其他"> 其他</option>
											
											</select>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="defrayModeMsg"></FONT>
										</TD>
									</TR>
<TR>
										<TD align=right height=30>
											收款帐号：
										</TD>
										<TD class=category>
											<INPUT   style="WIDTH: 300px" name="accountNumber"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											收款日期：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('collectionTime',['birth'],'collectionTimeMsg')"  style="WIDTH: 150px" id="collectionTime" name="collectionTime"
												 onclick="WdatePicker()">
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="collectionTimeMsg"></FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											录入信息日期：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('inputTime',['birth'],'inputTimeMsg')"  style="WIDTH: 150px" id="inputTime" name="inputTime"
												onclick="WdatePicker()"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="inputTimeMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户验证码：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('authcode','','authcodes')"  style="WIDTH: 150px" id="authcode" name="authcode"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 请客户输入验证码<FONT color=#ff0000 id="authcodes"></FONT>&nbsp;&nbsp;<FONT color="red" id="code"></FONT>
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
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT  class=button type=submit  value=" 确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											
										</TD>
									</TR>
								</TBODY>
								<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
							</TABLE>
						</TD>
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
	</BODY>
</HTML>
