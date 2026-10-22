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
		<FORM name=form1 id="form1"  method="post" onsubmit="return addValidators()" >
		<input type="hidden" name="delflag" value="0" />
		<input type="hidden" name="id" value="${oneRuin.id }"/>
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
											&nbsp;报溢资料(带*号的为必填项)
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
											单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneRuin!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="incomeNo" name="incomeNo" value="${oneRuin.incomeNo}">
									    </c:if>
									    <c:if test="${oneRuin==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="incomeNo" name="incomeNo" value="${BY }">
											</c:if>							
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										     审核状态：
										</TD>
										<TD class=category>
											  	
									   <c:if test="${oneRuin.auditingState=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${oneRuin.auditingState } > 
									    </c:if>
									    <c:if test="${oneRuin.auditingState=='0'||oneRuin.auditingState==null }">
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
										<input id="emp" value="<%=empName %>"  onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
										<input id="empId" type="hidden" value="<%=empId %>" name="employee.id" readonly="readonly" />
										</c:if>
									    <c:if test="${oneRuin!=null}">
									    <input id="emp" value="${oneRuin.employee.name  }" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly">
										<input id="empId" type="hidden"  name="employee.id" value="${oneRuin.employee.id  }" readonly="readonly" />
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
										<c:set var="ttime" value="${oneRuin.itime}" scope="request"></c:set>
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											bd=formatter.format(request.getAttribute("ttime"));
											System.out.println("time:"+bd);
											 %>
										</c:if>
											<INPUT onblur="checkValueByRules('time',['birth'],'orderMsg')" style="WIDTH: 150px" id="time" name="itime" value="<%=bd %>"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="orderMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										     总价：
										</TD>
										<TD class=category>
											  	<input id="allSum" name="allSum" readonly="readonly" value="${oneRuin.allSum}" >
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										       是否已入库：
										</TD>
										<TD class=category>
										
										
										 <c:if test="${oneRuin.inmark=='1' }">
									    <input type="radio" style="border:0;" name="inmark" id="inmark" value="0" >未入库
											<input type="radio" style="border:0;" name="inmark" id="inmark" checked="checked" value="1">已入库
									    </c:if>
									    <c:if test="${oneRuin.inmark=='0'||oneRuin.inmark==null }">
									    <input type="radio" style="border:0;" name="inmark" id="inmark" value="0" checked="checked">未入库
											<input type="radio" style="border:0;" name="inmark" id="inmark" value="1">已入库
									
									    </c:if>
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
									<td>
									
									<input class=button type="button" value="添加产品" onclick="editTab('income')">
									</td>
									<td></td>
									</tr>
									<tr>
									<td colspan="6">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs">
									<TR>
										<TD align=center width="18%">
											选择类型：
										</TD>
										<TD align=center  width="18%">
											选择型号：
										</TD>
										<TD align=center  width="13%">
											单价：
										</TD>
										<TD align=center  width="10%">
											数量：
										</TD>
										<TD align=center  width="10%">
											总价：
										</TD>
										<TD align=center  width="10%">
											删除：
										</TD>
									</TR>
									<%int i=0;  %>
									<c:if test="${oneRuin!=null}">
									<c:forEach items="${oneRuin.incomeInfos}" var="infodata">
									<%i++; %>
									<tr id="tr<%=i %>">
									<td>
									<select id="type<%=i %>"  name="type" onchange='getModel(<%=i %>)'onfocus="typeSel(<%=i %>)"  >
									<option selected="selected">${infodata.model.commodityTpye.typeName }</option>
									</select>
									</td>
									<td>
									<select id="model<%=i %>" name="model" onchange='valdateModel(<%=i %>)'>
									<option value="${infodata.model.model }" selected="selected">${infodata.model.name }</option>
									</select>
									<td><input id='price<%=i %>' name='price' onblur='onesumBY(<%=i %>)' value="${infodata.price }"/></td>
									<td><input id="count<%=i %>" name="count" onblur='onesumBY(<%=i %>)' value="${infodata.count }"/></td>
									<td><input id="sum<%=i %>" name="sum" value="${infodata.sum }"/></td>
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
											<INPUT class=button type=button onclick="addOrdereditIncome('addincome.do','selectincome.do?funid=212')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneRuin!=null}">
											<input class="button" type="button" value="确认修改" onclick="addOrdereditIncome('editincome.do','selectincome.do?funid=212')"/>&nbsp;&nbsp;&nbsp;&nbsp;
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
