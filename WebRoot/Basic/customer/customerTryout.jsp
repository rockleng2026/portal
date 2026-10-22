<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/images/date2.js" charset="utf-8"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>	
<title>客户试用记录</title>
</head>
<script type="text/javascript">
</script>
<body>
			<FORM name="CustomerTryoutform" action="
			<c:if test="${data.customer.customerId !=null}">
			updateCustomerTryout.do
			</c:if>
			<c:if test="${data.customer.customerId==null}">
			addCustomerTryout.do
			</c:if>
			" method="post">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background="<%=request.getContextPath() %>/images/r_0.gif">
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;添加客户资料(带*号的为必填项)
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
							<input type="hidden" name="customer.customerId" id="customer.customerId"  value="${param.customerId}">
							<input type="hidden" name="cid" id="cid" value="${param.customerId}"/>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="40%" align=right height=30>
											试用服务器IP：
										</TD>
										<TD class=category>
											<input type="text" name="ip" id="ip" value="${data.ip}" onblur="checkValueByRules('ip','','ip1')">
											&nbsp;
											<FONT color=#ff0000 id="ip1">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											试用服务器配置：
										</TD>
										<TD class=category>
											<textarea id="servercollocate" name="servercollocate" rows="5" cols="50">
												${data.servercollocate}
											</textarea>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											带宽：
										</TD>
										<TD class=category>
											<input type="text" name="bandwidth" id="bandwidth" value="${data.bandwidth}">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											测试开始时间：
										</TD>
										<TD class=category>
											<input type="text" name="tryoutBeginDate" id="tryoutBeginDate" value="${data.tryoutBeginDate}" onfocus="WdatePicker()" onblur="checkValueByRules('tryoutBeginDate','','tryoutBeginDate1')">
											&nbsp;
											<FONT color=#ff0000 id="tryoutBeginDate1">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											测试结束时间:
										</TD>
										<TD class=category>
											<input type="text" name="tryoutEndDate" id="tryoutEndDate" value="${data.tryoutEndDate}" onfocus="WdatePicker()" onblur="checkValueByRules('tryoutEndDate','','tryoutEndDate1')">
											&nbsp;
											<FONT color=#ff0000 id="tryoutEndDate1">*</FONT>
										</TD>
									</TR>
								 <TR>										
									
									<TR>
										<TD align=right height=30>
											是否购买
										</TD>
										<c:if test="${data.isPurchase=='买'}">checked="checked"</c:if>
										<TD class=category>
											<c:if test="${data==null}">
												<input type="radio" name="isPurchase"  id="isPurchase" value="买" checked="checked">买
											 	<input type="radio" name="isPurchase"  id="isPurchase" value="不买" >不买
											</c:if>
											<c:if test="${data!=null}">
												<input type="hidden" name="ctid" id="ctid" value="${data.id}"/>
												<input type="radio" name="isPurchase"  id="isPurchase" value="买" <c:if test="${data.isPurchase=='买'}">checked="checked"</c:if>>买
											 	<input type="radio" name="isPurchase"  id="isPurchase" value="不买" <c:if test="${data.isPurchase=='不买'}">checked="checked"</c:if>>不买
											</c:if>
											 	
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											备注
										</TD>
										<TD class=category>
											 <textarea id="remark" name="remark" rows="5" cols="50">
												${data.remark}
											</textarea>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=submit value="确认提交 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT type=hidden value=ok name=hid1>
											<INPUT type=hidden value=58 name=id>
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
							<IMG alt="" src="images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
</body>
</html>