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
	<BODY onload="tabload('a')">
		<FORM name=form1 id=form1 >
		
		<c:if test="${not empty oneAss}">
			<input type="hidden" value="${oneAss.id }" id="id" name="id">
			<input type="hidden" value="${oneAss.productByServerId.id }" id="id" name="productByServerId.id">
			
		</c:if>
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
										  <c:if test="${oneAss!=null}">
											&nbsp;修改组装服务器资料(带*号的为必填项)
											</c:if>
											<c:if test="${oneAss==null}">
											&nbsp;添加组装服务器资料(带*号的为必填项)
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
							
								<input type="hidden" value="0" name="delflag"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											组装服务器单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${oneAss!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="downNo" name="assemblyNo" value="${oneAss.assemblyNo }">
									    </c:if>
									    <c:if test="${oneAss==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="downNo" name="assemblyNo" value="${XJNo }">
											</c:if>
											</TD>
									</TR>
								
									<TR>
										<TD width="25%" height=30 align=right>
											Cpu：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('cpuName','','cpuMsg')" style="WIDTH: 200px" id="cpuName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=cpu','cpuName','cpuId','','')" value="${oneAss.productByCpuId.property.name }">
											<input id="cpuId" name="productByCpuId.id" type="hidden" value="${oneAss.productByCpuId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="cpuMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											主板：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('mainBoardName','','mainBoardMsg')" style="WIDTH: 200px" id="mainBoardName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=mainboard','mainBoardName','mainBoardId','','')" value="${oneAss.productByMainBoardId.property.name }">
											<input id="mainBoardId" name="productByMainBoardId.id" type="hidden" value="${oneAss.productByMainBoardId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="mainBoardMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											硬盘：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('hdName','','hdMsg')" style="WIDTH: 200px" id="hdName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=hd','hdName','hdId','','')" value="${oneAss.productByHdId.property.name }">
											<input id="hdId" name="productByHdId.id" type="hidden" value="${oneAss.productByHdId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="hdMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											内存：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('memoryName','','memoryMsg')" style="WIDTH: 200px" id="memoryName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=memory','memoryName','memoryId','','')" value="${oneAss.productByMemoryId.property.name }">
											<input id="memoryId" name="productByMemoryId.id" type="hidden" value="${oneAss.productByMemoryId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="memoryMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											机箱：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('crateName','','crateMsg')" style="WIDTH: 200px" id="crateName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=crate','crateName','crateId','','')" value="${oneAss.productByCrateId.property.name }">
											<input id="crateId" name="productByCrateId.id" type="hidden" value="${oneAss.productByCrateId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="crateMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											电源：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('powerName','','powerMsg')" style="WIDTH: 200px" id="powerName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=power','powerName','powerId','','')" value="${oneAss.productByPowerId.property.name }">
											<input id="powerId" name="productByPowerId.id" type="hidden" value="${oneAss.productByPowerId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="powerMsg"></FONT>
											</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											网卡：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('networkCardName','','networkCardMsg')" style="WIDTH: 200px" id="networkCardName" onclick="returnSome('showDialogOutbound.do?mark=commodity&server=networkCard','networkCardName','networkCardId','','')" value="${oneAss.productByNetworkCardId.property.name }">
											<input id="networkCardId" name="productByNetworkCardId.id" type="hidden" value="${oneAss.productByNetworkCardId.id }"><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="networkCardMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											类型：
										</TD>
										<TD width="75%" class=category>
											<select  id="typea"  name="type" onchange='getModel("a")'onfocus="typeSel('a')"  >
											<option value="${oneAss.model.commodityTpye.id }" selected="selected">${oneAss.model.commodityTpye.typeName }</option>
											</select>
											</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											型号：
										</TD>
										<TD width="75%" class=category>
											<select id="modela" name="model.model" onblur="checkValueByRules('modela','','modelaMsg')" >
											<option value="${oneAss.model.model }" selected="selected">${oneAss.model.name }</option>
											</select>
											<FONT color=#ff0000 >*</FONT>
											<FONT color=#ff0000 id="modelaMsg"></FONT>
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category> 
										<c:if test="${empty oneAss}">
										<input id="emp"  value="<%=empName %>"  >
											<input id="empid" name="employee.id"  type="hidden" value="<%=empId %>" />
										</c:if>
											<c:if test="${not empty oneAss}">
											<input id="emp" value="${oneAss.employee.name }"  >
											<input id="empid" name="employee.id"  type="hidden" value="${oneAss.employee.id }" />
											</c:if>
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											仓库：
										</TD>
										<TD width="75%" class=category>
											<input id="dep" onblur="checkValueByRules('dep','','depMsg')" value="${oneAss.depot.name}" onclick="returnSome('showDialogStat.do?mark=depot','dep','deId')">
											   	<input id="deId" type="hidden" name="depot.id" value="${oneAss.depot.id}"/>
											<FONT color=#ff0000>*</FONT><FONT id="depMsg" color=#ff0000></FONT>
											</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											组装日期：
										</TD>
										<% String bb=""; %>
										<c:if test="${oneAss!=null}">
										<c:set var="ttime" value="${oneAss.atime}" scope="request"></c:set>
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											bb=formatter.format(request.getAttribute("ttime"));
										
											 %>
										</c:if>
										<TD class=category>
											<INPUT onblur="checkValueByRules('downTime',['birth'],'downTimeMsg')" style="WIDTH: 150px" id="downTime" name="atime" value="<%=bb %>"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="downTimeMsg"></FONT>
										</TD>
										
									</TR>
									<TR>
										<TD align=right height=30>
										        备注：
										</TD>
										<TD class=category>
											<textarea rows="3" cols="50" id="description" name="remark">${oneAss.remark}</textarea>
											
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${oneAss==null}">
											<INPUT class=button type=button onclick="addOreditAll('addAssemblyServer.do','selectAssemblyServer.do?funid=202')" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneAss!=null}">
											<input class="button" type="button" value="确认修改" onclick="addOreditAll('editAssemblyServer.do','selectAssemblyServer.do?funid=202')"/>&nbsp;&nbsp;&nbsp;&nbsp;
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
