<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加客户退单记录</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		
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
											<c:if test="${empty retundmentlog}">
												<INPUT style="WIDTH: 200px;color: gray" id="clientOrderNum" name="clientOrderNum" value="${serial}" readonly="readonly"/>
											</c:if>
											<c:if test="${not empty retundmentlog}">
												<INPUT style="WIDTH: 200px;color: gray" id="clientOrderNum" name="clientOrderNum" value="${retundmentlog.clientOrderNum}" readonly="readonly"/>
											</c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											销售订单编号：
										</TD>
										<TD width="75%" class=category>
												<INPUT style="WIDTH: 200px;color: gray" readonly="readonly" id="saleOrderNum" name="saleOrderNum" value="${retundmentlog.saleOrder.saleOrderNo}" onblur="checkValueByRules('saleOrderNum','','saleOrderNumMsg')"
												<c:if test="${empty retundmentlog}"> 
												onclick="completemission('getSaleOrderListClientOrder.do?mark=add','')"
												
												</c:if>/>
										
											<INPUT style="WIDTH: 200px" id="saleOrderid" type="hidden" name="saleOrder.id" type="TEXT" value="${retundmentlog.saleOrder.id}" />
											<FONT color=#ff0000 id="saleOrderNumMsg" name="saleOrderNumMsg"></FONT><FONT color=#ff0000>*</FONT>
																					
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											销售人员：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px;color: gray" readonly="readonly" id="salePerson" name="salePerson" value="${retundmentlog.employeeByEmpId.name}" onblur="checkValueByRules('salePerson','','salePersonMsg')"  />
											<FONT color=#ff0000 id="salePersonMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											退货人：
										</TD>
										<TD class=category>
											<%=request.getSession().getAttribute("loginName") %>
											<input id ="declareR" name="declareR" type="hidden" value="<%=request.getSession().getAttribute("loginName") %>"/>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											退款时间：
										</TD>
										<TD class=category>
										 <INPUT id="returnTime" onblur="checkValueByRules('returnTime',['birth'],'returnTimeMsg')"  style="WIDTH: 150px" name="returnTime"
												onclick="WdatePicker()" value="${retundmentlog.returnTime}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="returnTimeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									
									<tr>
									<td align=right>退款原因：
										</TD>
										<TD class=category>
											<textarea id="returnReason" name="returnReason" cols="100">${retundmentlog.returnReason}</textarea>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="returnReasonMsg"></FONT>
											</TD>
									</tr>
									<TR>
										
										<TD align=right height=30>
											退款期限：
										</TD>
										<TD class=category>
										 <INPUT id="returnLimitTime" name="returnLimitTime" onblur="checkValueByRules('returnLimitTime',['birth'],'returnLimitTimeMsg')"  style="WIDTH: 150px" 
												onclick="WdatePicker()" value="${retundmentlog.returnLimitTime}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="returnLimitTimeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									 <TR>
										<TD align=right height=30>
											帐&nbsp;&nbsp;号：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" id="account" name="account" value="${retundmentlog.account}" onblur="checkValueByRules('account','','accountMsg')" />
											<FONT color=#ff0000 id="serveridMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									 <TR>
										<TD align=right height=30>
											退款金额：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" id="money" name="money" value="${retundmentlog.money}"/>
										</TD>
									</TR>

									 <TR>
										<TD align=right height=30>
											财务是否审核：
										</TD>
										<TD width="75%" class=category>
											<select id="financingState" name="financingState">
												<c:if test="${empty retundmentlog}">
													<option value="0" selected="selected">未审核</option>
													<option value="1">审核</option>
												</c:if>
												<c:if test="${not empty retundmentlog}">
													<c:if test="${retundmentlog.financingState==0}">
														<option value="0" selected="selected">未审核</option>
														<option value="1">审核</option>
													</c:if>
													<c:if test="${retundmentlog.financingState==1}">
														<option value="0">未审核</option>
														<option value="1" selected="selected">审核</option>
													</c:if>
												</c:if>
											</select>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<c:if test="${empty retundmentlog}"><INPUT  class=button type=button onclick="addClientReturnOrder('add')" value=" 确认添加 "></c:if>
											<c:if test="${not empty retundmentlog}"><INPUT  class=button type=button  onclick="addClientReturnOrder('edit')" value=" 确认修改 "><input type="hidden" name="id" id="id" value="${retundmentlog.id }"/></c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
								<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
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
		<div align="left"><br></div><script type="text/javascript">
			function addClientReturnOrder(option)
			{
				if(!addValidators())
				{
					return false;
				}
				
				var clientOrderNum = $("#clientOrderNum").val();
				var saleOrderid = $("#saleOrderid").val();
				var declareR = $("#declareR").val();
				var returnTime = $("#returnTime").val();
				var returnReason = $("#returnReason").val();
				var returnLimitTime = $("#returnLimitTime").val();
				var account = $("#account").val();
				var approveState = $("#approveState").val();
				var financingState = $("#financingState").val();
				
				if(option=="add")
				{
					var url = "addClientOrder.do";
					$.post(url,{clientOrderNum:clientOrderNum,saleOrderid:saleOrderid,declareR:declareR,returnTime:returnTime,returnReason:returnReason,returnLimitTime:returnLimitTime,account:account,approveState:approveState,financingState:financingState},function(data){
						if(data=='1')
						{
							alert("添加退单成功");
							window.location.href="getAllListClientOrder.do";
						}
						else
						{
							alert("添加退单失败");
							return ; 
						}
					});
				}
				if(option=="edit")
				{
					var id = $("#id").val();
					var url = "updateClientOrder.do";
					$.post(url,{id:id,clientOrderNum:clientOrderNum,saleOrderid:saleOrderid,declareR:declareR,returnTime:returnTime,returnReason:returnReason,returnLimitTime:returnLimitTime,account:account,approveState:approveState,financingState:financingState},function(data){
						alert(data);
						if(data=='1')
						{
							alert("修改退单成功");
							window.location.href="getAllListClientOrder.do";
						}
						else
						{
							alert("修改退单失败");
							return ; 
						}
					});
				}
				
			}
		</script>
	</BODY>
</HTML>
