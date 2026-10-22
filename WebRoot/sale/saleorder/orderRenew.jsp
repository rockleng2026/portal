<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单续费</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		
		<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
	<STYLE>
	BODY {
		BACKGROUND-COLOR: #ffffff
	}	
	
	</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<SCRIPT type="text/javascript">
		function getPrice(){
			var price = $("#price").val();
			$("#renewMoner").val(price);
		}
	</SCRIPT>	
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="renewsaleOrder.do" method="post" onsubmit="return addValidators()">
		<s:token/>
		
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
											&nbsp;订单续费(带*号的为必填项)
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
										<TD width="25%" height=30 align=right>订单号：</TD>
										<TD width="75%" class=category>
											<input id ="saleOrderNo" name="saleOrder" value="${saleorder.saleOrderNo }" onclick="completemission('getSaleOrderListClientOrder.do?auditingState=1&page=orderRenew','')" >
											<input id="saleOrderNoid" type="hidden" name="saleOrderNo" value="${saleorder.id}">
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											订单到期时间：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" onblur="checkValueByRules('orderEndTime','','addressMsg')" id="orderEndTime" name="rl.orderEndTime" value="${saleorder.endTime }" readonly/>
											&nbsp;
											<FONT color=#ff0000 id="addressMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											续费金额：
										</TD>
										<TD class=category>
											<INPUT readonly="readonly" style="WIDTH: 200px" value="${saleorder.price }" name="price" id="price" >
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="priceMsg" color="red"></font>
											<INPUT type="hidden" name="rl.renewMoner" id="renewMoner">
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											续费时间：
										</TD>
										<TD class=category>
											<INPUT id="renewTime" onblur="checkValueByRules('renewTime',['birth'],'renewTimeMsg')"  style="WIDTH: 150px" name="rl.renewTime"
												onclick="WdatePicker()"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="renewTimeMsg"></FONT>点击输入框获取时间
										</TD>
										</TR>
										<TR>
										<TD align=right height=30>
											续费后订单到期时间：
										</TD>
										<TD class=category>
										 <INPUT id="nextRenewTime" onblur="checkValueByRules('nextRenewTime',['birth'],'nextRenewTimeMsg')"  style="WIDTH: 150px" name="rl.nextRenewTime"
												onclick="WdatePicker()"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nextRenewTimeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT  class=button type=submit value=" 确认添加 " onclick="getPrice()">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
					</TR>
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
		</FORM>
<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
	</BODY>
</HTML>
