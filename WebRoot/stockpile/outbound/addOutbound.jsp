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
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" ></script>
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
											&nbsp;出库单资料(带*号的为必填项)
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
							
								<input type="hidden" value="${oneOutBound.id }" id="oid" name="oid"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											出库单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneOutBound!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="CKBum" name="CKBum" value="${oneOutBound.outboundNo }">
									    </c:if>
									    <c:if test="${oneOutBound==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="CKBum" name="CKBum" value="${CKNo }">
											</c:if>		
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneOutBound.auditingState=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${oneOutBound.auditingState } > 
									    </c:if>
									    <c:if test="${oneOutBound.auditingState=='0'||oneOutBound.auditingState==null }">
									    <label id="sh">未审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value="0" > 
									    </c:if>
										</TD>
									</TR>
									 <TR>
										<TD align=right height=30>
											仓库：
										</TD>
										<TD class=category>
									    <c:if test="${not empty oneOutBound}">
									    	<input id="dep" onblur="checkValueByRules('dep','','depMsg')" value="${oneOutBound.depot.name}" readonly="readonly">
									    </c:if>
									    <c:if test="${empty oneOutBound}">
											   	<input id="dep" onblur="checkValueByRules('dep','','depMsg')" value="${oneOutBound.depot.name}" onclick="completemission('showDialogWarehousing.do?mark=depot','')">
											   	</c:if>
											   	<input id="depId" type="hidden" value="${oneOutBound.depot.id}"/>
											<FONT color=#ff0000>*</FONT><FONT id="depMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											出库类型：
										</TD>
										<TD class=category>
										<s:select onblur="checkValueByRules('outType','','outTypeMsg')" id="outType" name="outType" cssClass="category" list="#request.typeList" listKey="id" listValue="typeName" value="%{'',#request.oneOutBound.allType.id}" headerKey="" headerValue="请选择" >
										</s:select>
											<FONT color=#ff0000>*</FONT><FONT id="outTypeMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category>
										<c:if test="${not empty oneOutBound}">
											   	<input id="emp" value="${oneOutBound.employee.name }" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
											   	<input id="empId" type="hidden" value="${oneOutBound.employee.id }" />
											   	</c:if>
											<c:if test="${empty oneOutBound}">
										<input id="emp" value="<%=empName %>" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly" >
											   	<input id="empId"  type="hidden" value="<%=empId %>" />
											   	</c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										         出库时间：
										</TD>
										<TD class=category>
										<% String bd=""; %>
										<c:if test="${oneOutBound!=null}">
										<c:set var="ttime" value="${oneOutBound.time}" scope="request"></c:set>
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
											备注：
										</TD>
										<TD class=category>
											   <s:textarea cols="50" id="remark" name="remark" rows="7" value="%{#request.oneOutBound.remark}"></s:textarea>
										
										</TD>
									</TR>
									<tr>
									<td>
									
									<input  class=button type="button" value="添加产品" onclick="editTab('out')"><INPUT id="num" name="" type="hidden" />
									</td>
									<td></td>
									</tr>
									<tr>
									<td colspan="6">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs">
									<TR>
										<TD align=center height=30 width="18%">
											条形码：
										</TD>
										<TD align=center height=30 width="18%">
											名称：
										</TD>
										<TD align=center height=30 width="13%">
											型号：
										</TD>
										<TD align=center height=30 width="13%">
											类型：
										</TD>
										<TD align=center height=30 width="10%">
											删除：
										</TD>
									</TR>
									<%int i=0;  %>
									<c:if test="${oneOutBound!=null}">
									<c:forEach items="${oneOutBound.outboundInfos}" var="infodata">
									<%i++; %>
									<tr id="tr<%=i %>">
									<td>
									<input value="${infodata.product.barcode }" onclick="returnSome('showDialogOutbound.do?mark=commodity','code<%=i %>','codeId<%=i %>','pmodel<%=i %>','pname<%=i %>','ptype<%=i %>')" id='code<%=i %>' name='code' />
									<input type="hidden" id='codeId<%=i %>' name='codeId' value="${infodata.product.id }" />
									</td>
									<td>
									<label id='pname<%=i %>' name='pname' >${infodata.product.property.name } </label>
									</td>
									<td><label id='pmodel<%=i %>'  name='pmodel' >${infodata.product.property.model.name }</label></td>
									<td><label id='ptype<%=i %>'  name='ptype' >${infodata.product.property.model.commodityTpye.typeName }</label></td>
									<td><input value="删除" class="button" type="button" onclick='delTr(<%=i %>)'></input></td>
									</tr>
									</c:forEach>
									</c:if>
									
									<input type="hidden" id="selId" value="<%=i %>"/>
									
									<input type="hidden" id="sedit" value="${oneOutBound.id }"/>
									</table>
									</td>
										</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${oneOutBound==null}">
											<INPUT class=button type=button onclick="addorEditOutBound('addOutbound.do')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneOutBound!=null}">
											<input class="button" type="button" value="确认修改" onclick="addorEditOutBound('editOutbound.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>                                  
								</TBODY>
							</TABLE>
							<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
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
