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
		System.out.println("empId:::"+empId+"empName::"+empName);
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
											&nbsp;报损单(带*号的为必填项)
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
						
								<input type="hidden" value="${oneRuin.id }" id="sedit" name="sedit"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneRuin!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="PorLNo" name="PorLNo" value="${oneRuin.ruinNo}">
									    </c:if>
									    <c:if test="${oneRuin==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="PorLNo" name="PorLNo" value="${PorL }">
											</c:if>							
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										     审核状态：
										</TD>
										<TD class=category>
											  	
									   <c:if test="${oneRuin.auditing=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${oneRuin.auditing } > 
									    </c:if>
									    <c:if test="${oneRuin.auditing=='0'||oneRuin.auditing==null }">
									    <label id="sh">未审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value="0" > 
									    </c:if>
										</TD>
									</TR>
									
									
									<TR>
										<TD align=right height=30>
											经办人：
										</TD>
										<TD class=category>
										<c:if test="${oneRuin==null}">
										<input id="emp" value="<%=empName %>" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
										<input id="empId" type="hidden" value="<%=empId %>" readonly="readonly" />
										</c:if>
									    <c:if test="${oneRuin!=null}">
									    <input id="emp" value="${oneRuin.employee.name  }" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
										<input id="empId" type="hidden" value="${oneRuin.employee.id  }" readonly="readonly" />
									    </c:if>
											<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										         时间：
										</TD>
										<TD class=category>
										<% String bd=""; %>
										<c:if test="${oneRuin!=null}">
										<c:set var="ttime" value="${oneRuin.rtime}" scope="request"></c:set>
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
									<TR>
										<TD align=right height=30>
										     总价：
										</TD>
										<TD class=category>
											  	<input id="sum" readonly="readonly" value="${oneRuin.sum}" >
											<FONT color=#ff0000>*</FONT><FONT id="sumMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										        备注：
										</TD>
										<TD class=category>
										
										<s:textarea cols="50" id="remark" name="remark" rows="7" value="%{#request.oneRuin.remark}"></s:textarea>
										
										</TD>
									</TR>
									<tr>
									<tr>
									<td>
									
									<input  class=button type="button" value="添加产品" onclick="editTab('PorL')"><INPUT id="num" name="" type="hidden" />
									</td>
									<td></td>
									</tr>
									<tr>
									<td colspan="6">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs">
									<TR>
										<TD align=center  width="12%">
											条形码：
										</TD>
										<TD align=center  width="8%">
											名称：
										</TD>
										<TD align=center width="10%">
											型号：
										</TD>
										<TD align=center width="10%">
											类型：
										</TD>
										<TD align=center width="10%">
											损损描述：
										</TD>
										<TD align=center width="10%">
											处理方式：
										</TD>
										<TD align=center width="8%">
											价格：
										</TD>
										<TD align=center width="10%">
											删除：
										</TD>
									</TR>
									<%int i=0;  %>
									<c:if test="${oneRuin!=null}">
									<c:forEach items="${oneRuin.ruinInfos}" var="infodata">
									<%i++; %>
									<tr id="tr<%=i %>">
									<td>
									<input value="${infodata.product.barcode }" onclick="returnSome('showDialogOutbound.do?mark=commodity','code<%=i %>','codeId<%=i %>','pmodel<%=i %>','pname<%=i %>','ptype<%=i %>')" id='code<%=i %>' name='code' />
									<input type='hidden' id='codeId<%=i %>' name='codeId' value="${infodata.product.id }" />
									</td>
									<td>
									<label id='pname<%=i %>' name='pname' >${infodata.product.property.name }</label>
									</td>
									<td><label id='pmodel<%=i %>'  name='pmodel' >${infodata.product.property.model.name }</label></td>
									<td><label id='ptype<%=i %>'  name='ptype' >${infodata.product.property.model.commodityTpye.typeName }</label></td>
									<td><input id='desc<%=i %>' name='desc' value="${infodata.describes }" onblur="editHX('desc<%=i %>')" /></td>
									<td><input id='dispose<%=i %>' name='dispose' value="${infodata.disposeManner }" onblur="editHX('dispose<%=i %>')"  /></td>
									<td><input id='price<%=i %>' onblur='editSums(<%=i %>)' name='price' value='${infodata.price }' /></td>
									<td><input value="删除" class="button" type="button" onclick='delTr(<%=i %>)'></input></td>
									</tr>
									</c:forEach>
									</c:if>
									
									<input type="hidden" id="selId" value="<%=i %>"/>
									
									<input type="hidden" id="sedit" value="${oneRuin.id }"/>
									</table>
									</td>
										</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${oneRuin==null}">
											<INPUT class=button type=button onclick="addOreditPorL('addTheDamage.do')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneRuin!=null}">
											<input class="button" type="button" value="确认修改" onclick="addOreditPorL('editTheDamage.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
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
