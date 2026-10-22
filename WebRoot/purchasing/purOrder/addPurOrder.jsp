<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
	<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
	<BODY onload="tabload()">
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
											&nbsp;采购订单资料(带*号的为必填项)<c:if test="${purList==null&&copyList==null}">
											<input type="button" class="button" value="参考请购单生成" onclick="pleaseOrder()">
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
							
								<input type="hidden" value="0" name="del"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											采购订单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${purList!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="CKBum" name="CKBum" value="${purList.purOrderNo }">
									    </c:if>
									    <c:if test="${purList==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="CKBum" name="CKBum" value="${CGO }">
											</c:if>							
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${purList.auditingState=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${purList.auditingState } > 
									    </c:if>
									    <c:if test="${purList.auditingState=='0'||purList.auditingState==null }">
									    <label id="sh">未审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value="0" > 
									    
									    </c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商：
										</TD>
										<TD class=category>
											
										<input id="sup" value="${purList.supplier.supplierName }" onblur="checkValueByRules('sup','','supMsg')" 
										onclick="completemission('showDialogOutbound.do?mark=supplier','')" />
											   	<input id="supid"  type="hidden" value="${purList.supplier.id }" />
										
											<FONT color=#ff0000>*</FONT><FONT id="supMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category>
											 <c:if test="${not empty purList}">
											<input id="emp" value="${purList.employee.name }" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
											   	<input id="empid"  type="hidden" value="${purList.employee.id }" />
											   	</c:if>
											   		<c:if test="${empty purList}">
										<input id="emp" value="<%=empName %>" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
											   	<input id="empid" name="employee.id" type="hidden" value="<%=empId %>" />
											   	</c:if>
											   
										</TD>
									</TR>
									
									
									<TR>
										<TD align=right height=30>
											账户名称：
										</TD>
										<TD class=category>
<!--										<input id="accountType1" type="hidden" value="${purList.accountType}"/>-->
											<input id="accountType" name="accountType" value="${purList.accountType}" 
											 onblur="checkValueByRules('accountType','','accountType2')" />
						
											<FONT color=#ff0000>*</FONT>名称可选：支付宝,财付,等,如是银行卡请写xx省xx市xx银行 <FONT id="accountType2" color=#ff0000></FONT>
										</TD>
									</TR>
									
									
									<TR>
										<TD align=right height=30> 
											账户名： 
										</TD>
										<TD class=category>
											<INPUT  style="WIDTH: 200px" id="accountName"  name="accountName"
										 onblur="checkValueByRules('accountName','','accountName1')"	 value="${purList.accountName}"  >
											
										<FONT color=#ff0000>*</FONT>账户名称<FONT id="accountName1" color=#ff0000></FONT>
										</TD>
									</TR>
									
									
									<TR>
										<TD align=right height=30>
											账号：
										</TD>
										<TD class=category>
											<INPUT  style="WIDTH: 200px" id="account" name="account" value="${purList.account}"
										 onblur="checkValueByRules('account',['num'],'account1')">
											
										<FONT color=#ff0000>*</FONT>账户卡号<FONT id="account1" color=#ff0000></FONT>
										</TD>
									</TR>
									
									
	
									
									<TR>
										<TD align=right height=30>
										          订货时间：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('orderTime',['birth'],'orderMsg')" style="WIDTH: 150px" id="orderTime" name="orderTime" value="${purList.orderTime}"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="orderMsg"></FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											交货日期：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('deliveryTime',['birth'],'devMsg')" style="WIDTH: 150px" id="deliveryTime" name="deliveryTime" value="${purList.deliveryTime}"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="devMsg"></FONT>
										</TD>
										
									</TR>
									
										<TR>
										<TD align=right height=30>
											总价格：
										</TD>
										<TD class=category>
											<INPUT  style="WIDTH: 200px" id="price" name="price" value="${purList.price }">
											
										</TD>
									</TR>
									
									
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											<INPUT  style="WIDTH: 200px" id="remarks" name="remarks" value="${purList.remarks}">
											
										</TD>
									</TR>
									
									<tr>
									<td>
									
									<input class=button type="button" value="添加产品" onclick="editTab()">
									</td>
									<td></td>
									</tr>
									<tr>
									<td colspan="6">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs">
									<TR>
										<TD align=center height=30 width="18%">
											选择类型：
										</TD>
										<TD align=center height=30 width="18%">
											选择型号：
										</TD>
										<TD align=center height=30 width="13%">
											单价：
										</TD>
										<TD align=center height=30 width="13%">
											折扣：
										</TD>
										<TD align=center height=30 width="10%">
											购买数量：
										</TD>
										<TD align=center height=30 width="10%">
											总价：
										</TD>
										<TD align=center height=30 width="10%">
											删除：
										</TD>
									</TR>
									
									<%int i=0;  %>
									<c:if test="${purList!=null}">
									<c:forEach items="${purList.purOrderInfos}" var="infodata">
									<%i++; %>
									<tr id="tr<%=i %>">
									
									<td>
									<select id="type<%=i %>"  name="type" onchange='getModel(<%=i %>)'onfocus="typeSel(<%=i %>)"  >
									<option selected="selected">${infodata.model.commodityTpye.typeName }</option>								
									</select>
									</td>
									
									<td>
									<select id="model<%=i %>" name="model" onchange='valdateModel(<%=i %>)' >
									<option value="${infodata.model.model }" selected="selected">${infodata.model.name }</option>
									</select>
									</td>
									
									<td><input id='infoprice<%=i %>' name='infoprice' onblur='onesum(<%=i %>)' value="${infodata.price }"/></td>
									<td><input id='discount<%=i %>' name="discount" onblur='onesum(<%=i %>)' value="${infodata.discount }"/></td>
									<td><input id="count<%=i %>" name="count" onblur='onesum(<%=i %>)' value="${infodata.count }"/></td>
									<td><input id="sum<%=i %>" name="sum" value="${infodata.sum }"/></td>
									<td><input value="删除" class="button" type="button" onclick='delTr(<%=i %>)'></input></td>
									
									</tr>
									</c:forEach>
									</c:if>
									
									<c:if test="${copyList!=null}">
										<% String all=""; %>
									<c:forEach items="${copyList}" var="codata">
									<c:set value="${codata.id}" var="coid" scope="request"></c:set>
									<% all+=request.getAttribute("coid")+",";%>
									<c:forEach items="${codata.applyBuyinfos}" var="cdata">
									<%i++; %>
									<tr id="tr<%=i %>">
									
									<td>
									<select id="type<%=i %>"  name="type" onchange='getModel(<%=i %>)'onfocus="typeSel(<%=i %>)"  >
									<option selected="selected">${cdata.commodityTpye.typeName }</option>
									</select>
									</td>
									
									<td>
									<select id="model<%=i %>" name="model"  onchange='valdateModel(<%=i %>)'>
									<option value="${cdata.model.model }" selected="selected">${cdata.model.name }</option>
									</select>
									</td>
									
									<td><input id='infoprice<%=i %>' name='infoprice' onblur='onesum(<%=i %>)' value="0.0"/></td>
									<td><input id='discount<%=i %>' name="discount" onblur='onesum(<%=i %>)' value="1.0"/></td>
									<td><input id="count<%=i %>" name="count" onblur='onesum(<%=i %>)' value="${cdata.count }"/></td>
									<td><input id="sum<%=i %>" name="sum" value="0.00"/></td>
									<td><input value="删除" class="button" type="button" onclick='delTr(<%=i %>)'></input></td>
									
									</tr>
									</c:forEach>
									</c:forEach>
									<%request.setAttribute("applyArray",all); %>
									<input type="hidden" name="applyArray" id="applyArray" value="${applyArray }" />
									</c:if>
									
									<input type="hidden" id="selId" value="<%=i %>"/>
									
									<input type="hidden" id="sedit" value="${purList.id }"/>
									</table>
									</td>
										</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${purList==null}">
											<INPUT class=button type=button onclick="addPurOrder('addPurchaseOrder.do')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${purList!=null}">
											<input class="button" type="button" value="确认修改" onclick="addPurOrder('editPurchaseOrder.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>                                  
								</TBODY>
								<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
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
