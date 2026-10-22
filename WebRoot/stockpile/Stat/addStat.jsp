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
											&nbsp;采购订单资料(带*号的为必填项)
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
						
								<input type="hidden" value="${oneStat.id }" id="sedit" name="sedit"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											盘点单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneStat!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="PDNo" name="PDNo" value="${oneStat.statNo }">
									    </c:if>
									    <c:if test="${oneStat==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="PDNo" name="PDNo" value="${PDNo }">
											</c:if>							
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											盘点类型：
										</TD>
										<TD width="75%" class=category>
										<script type="text/javascript">
										$(document).ready(function(){
									         var ckT=$("#ckT").val();
										     $("#statMethod option[value='"+ckT+"']").attr("selected",true); 
										});
										</script>
										<input type="hidden" value="${oneStat.statType}" id="ckT">
										
									     <select id="statMethod" name="statMethod"  onblur="checkValueByRules('statMethod','','statMethodMsg')">
										
											<option value="">请选择盘点方式</option>
											<option value="月盘点">月盘点</option>
											<option value="周盘点">周盘点</option>
											<option value="年盘点">年盘点</option>
											<option value="季度盘点">季度盘点</option>
											</select>
											<FONT color=#ff0000>*</FONT><FONT id="statMethodMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										      仓库：
										</TD>
										<TD class=category>
											  	<input id="dep" onblur="checkValueByRules('dep','','depMsg')" value="${oneStat.depot.name}" onclick="completemission('showDialogStat.do?mark=depot','')" >
											   	<input id="depId" type="hidden" value="${oneStat.depot.id}"/>
											<FONT color=#ff0000>*</FONT><FONT id="depMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											盘点人：
										</TD>
										<TD class=category>
										<c:if test="${not empty oneStat}">
												<input id="emp" value="${oneStat.employee.name  }"  readonly="readonly">
											   	<input id="empId" type="hidden" value="${oneStat.employee.id  }" />
											   	</c:if>
											<c:if test="${empty oneStat}">
										<input id="emp" value="<%=empName %>"  readonly="readonly" >
											   	<input id="empId"  type="hidden" value="<%=empId %>" />
											   	</c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
										          盘点时间：
										</TD>
										<TD class=category>
										<% String bd=""; %>
										<c:if test="${oneStat!=null}">
										<c:set var="ttime" value="${oneStat.statTime}" scope="request"></c:set>
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
										
										<s:textarea cols="50" id="remark" name="remark" rows="7" value="%{#request.oneStat.remark}"></s:textarea>
										
										</TD>
									</TR>
									<tr>
									<td>
									
									<input  class=button type="button" value="添加产品" onclick="editTab('tes')">
									</td>
									<td></td>
									</tr>
									<tr>
									<td colspan="6">
									<table border="1" bgcolor="white" id="editTabs" name="editTabs">
									<TR>
										<TD align=center  width="18%">
											选择类型：
										</TD>
										<TD align=center  width="18%">
											选择型号：
										</TD>
										<TD align=center  width="13%">
											账面数量：
										</TD>
										<TD align=center  width="13%">
											盘点数量：
										</TD>
										<TD align=center  width="10%">
											损益数量（正数为盘盈，负数为盘亏）：
										</TD>
										<TD align=center width="10%">
											备注：
										</TD>
										<TD align=center width="10%">
											删除：
										</TD>
									</TR>
									<%int i=0;  %>
									<c:if test="${oneStat!=null}">
									<c:forEach items="${oneStat.statInfos}" var="infodata">
									<%i++; %>
									<tr id="tr<%=i %>">
									<td>
									<select id="type<%=i %>"  name="type" onchange='getModel(<%=i %>)'onfocus="typeSel(<%=i %>)"  >
									<option selected="selected">${infodata.model.commodityTpye.typeName }</option>
									</select>
									</td>
									
									<td>
									<select id="model<%=i %>" name="model" onchange='modelcount(<%=i %>)'>
									<option value="${infodata.model.model }" selected="selected">${infodata.model.name }</option>
									</select>
									<td><input id='datacount<%=i %>' name='datacount' readonly='readonly' value="${infodata.datacount  }"/></td>
									<td><input id='factcount<%=i %>' name="factcount" onblur='calcu(<%=i %>)'   value="${infodata.factcount  }"/></td>
									<td><input id="count<%=i %>" name="count" readonly='readonly' value="${infodata.profitOrloss }"/></td>
									<td><input id="remarks<%=i %>" name="remarks" value='-----' onblur='editHX("remarks<%=i %>")' value="${infodata.remark }"/></td>
									<td><input value="删除" class="button" type="button" onclick='delTr(<%=i %>)'></input></td>
									</tr>
									</c:forEach>
									</c:if>
									
									<input type="hidden" id="selId" value="<%=i %>"/>
									
									<input type="hidden" id="sedit" value="${oneStat.id }"/>
									</table>
									</td>
										</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${oneStat==null}">
											<INPUT class=button type=button onclick="addOreditStat('addStat.do')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneStat!=null}">
											<input class="button" type="button" value="确认修改" onclick="addOreditStat('editStat.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
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
