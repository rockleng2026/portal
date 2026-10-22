<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
	<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript">
</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<%
   Cookies ck = new Cookies();
   String empName =ck.getCookie(request, "employeeName");
		String empId=ck.getCookie(request,"employeeId");
		
 %>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM name=form1 action="addPurchaseOrder.do" method="post" onsubmit="return addValidators()" >
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
											<c:if test="${oneReg==null}">
												&nbsp;添加价格调整记录(带*号的为必填项)
											</c:if>
											<c:if test="${oneReg!=null}">
												&nbsp;修改价格调整记录(带*号的为必填项)
											</c:if>
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
								align=center border="1" >
						
								
								<TBODY>
								<TR>
										<TD width="25%" height=30 align=right>
											单号：
										</TD>
										<TD width="75%" class=category>
										<c:if test="${not empty preg}">
										<input type="text" readonly="readonly" id="pNo" value="${preg }">
										</c:if>
										<c:if test="${not empty oneReg}">
										<input type="text" readonly="readonly" id="pNo" value="${oneReg.priceRegNo }">
										</c:if>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											类型：
										</TD>
										<TD width="75%" class=category>
									  <input type="text" readonly="readonly" id="typeName" value="${oneReg.model.commodityTpye.typeName }">
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											型号：
										</TD>
										<TD width="75%" class=category>
											<input readonly="readonly" id="modelName" value="${oneReg.model.name }">
											<input readonly="readonly" id="modelId" type="hidden" value="${oneReg.model.model }"/>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										      采购价格：
										</TD>
										<TD class=category>
											  	<input id="importprice" readonly="readonly" value="${oneReg.importprice }" onblur="checkValueByRules('importprice',['money'],'importpriceMsg')">
											  	<c:if test="${oneReg==null}">
											  	<input type="button" value="计算采购价格"  onclick="showPriceReg('sale/priceRegulation/enumImportPrice.jsp')">
											  	</c:if>
											<FONT color=#ff0000>*</FONT><FONT id="importpriceMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneReg.auditingState=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${oneReg.auditingState } > 
									    </c:if>
									    <c:if test="${oneReg.auditingState=='0'||oneReg.auditingState==null }">
									    <label id="sh">未审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value="0" > 
									    
									    </c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										      销售价格：
										</TD>
										<TD class=category>
											  	<input id="saleprice" onblur="checkValueByRules('saleprice',['money'],'salepriceMsg')" value="${oneReg.saleprice}" onclick="">
											<FONT color=#ff0000>*</FONT><FONT id="salepriceMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											制定人：
										</TD>
										<TD class=category>
										<c:if test="${not empty oneReg}">
										<input id="emp" value="${oneReg.employee.name  }" readonly="readonly">
											   	<input id="empId" type="hidden" value="${oneReg.employee.id  }" />
										</c:if>
									 	<c:if test="${empty oneReg}">
									 	<input id="emp" value="<%=empName %>" readonly="readonly">
											   	<input id="empId" type="hidden" value="<%=empId %>" />
									 	</c:if>
											<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										          制定时间：
										</TD>
										<TD class=category>
										<% String bd=""; %>
										<c:if test="${oneReg!=null}">
										<c:set var="ttime" value="${oneReg.rtime}" scope="request"></c:set>
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											bd=formatter.format(request.getAttribute("ttime"));
											System.out.println("time:"+bd);
											 %>
										</c:if>
											<INPUT onblur="checkValueByRules('time',['birth'],'orderMsg')" style="WIDTH: 150px" id="time" name="time" value="<%=bd %>"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="orderMsg"></FONT>
										</TD>
									</TR>
									
									<input type="hidden" id="sedit" value="${oneReg.id }"/>
									
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${oneReg==null}">
											<INPUT class=button type=button onclick="addoreditPriceReq('addpriceReg.do')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneReg!=null}">
											<input class="button" type="button" value="确认修改" onclick="addoreditPriceReq('editpriceReg.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
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
			
		</FORM>
	</BODY>
</HTML>
