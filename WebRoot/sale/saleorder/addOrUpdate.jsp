<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添订单</title>
<SCRIPT type="text/javascript">

</SCRIPT>
</head>
	<body>
	<FORM name="customerform" action="addsaleOrder.do" method="post" onsubmit="return checkToOrder()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">

						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>					
								<TR>
										<TD width="25%" height=30 align="center" colspan="4">
											<c:if test="${saleorder == null}"><h1>新增订单</h1>  </c:if>
											<c:if test="${saleorder != null}"><h1>更新订单</h1>   </c:if>
											<c:if test="${saleorder != null}">订单编号：
											<input style="WIDTH: 200px" type="text" id="ToOrderid" name=saleOrderNo value="${saleorder.saleOrderNo}" readonly /></c:if>	
										</TD>
									</TR>																				
									<TR>
										<TD width="25%" height=30 align=right>
											客户名称
										</TD>
										<TD class=category>
											<input id="cus" name="cus" onblur="checkValueByRules('cus','','cusMsg')" value="${saleorder.customer.realName}" 
											
											onclick="completemission('showDialogOutbound.do?mark=custom','')"
											 readonly="readonly">
											
											   	<input name="cusname" id="cusname" type="hidden" value="${ saleorder.customer.customerId}"/>
											&nbsp;
											
											<FONT color=#ff0000 id="cusMsg">*</FONT>
										</TD>
										<TD height=30 align=right>
										销售员工：
										</TD>
										<TD class=category>
											<c:if test="${empty saleorder.employee}">
												<!-- 
												<input id="emp" value="${employeeName }" onblur="checkValueByRules('emp','','empMsg')"	onclick="completemission('showDialogOutbound.do?mark=employee','')"
											  readonly="readonly">
											   -->
											    <label id="empName"></label>
											   	<input name="empid" id="empid" type="hidden" value="${employeeId }" />
											&nbsp;
											<FONT color=#ff0000 id="empMsg">*</FONT>
											</c:if>
											<c:if test="${not empty saleorder}">
											<label id="empName">${saleorder.customer.employee.name }</label>
											   	<input name="empid" id="empid" type="hidden" value="${employeeId }" />
											&nbsp;
											<FONT color=#ff0000 id="empMsg">*</FONT>
											</c:if>
											
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											机位大小：
										</TD>
										<TD class=category>
											<input id="spaceSize" name="spaceSize" value="${saleorder.spaceSize }" onblur="checkValueByRules('spaceSize',['num'],'spaceSizeMsg')"/>
											U&nbsp;
											<FONT color=#ff0000 id="spaceSizeMsg">*</FONT>
										</TD>
										<TD height=30 align=right>
										机器数量：
										</TD>
										<TD class=category>
											<INPUT id="productNum" name="productNum" value="${saleorder.productNum }" onblur="checkValueByRules('productNum',['num'],'jiguinummsg')"/ />
											&nbsp;
											<FONT color=#ff0000 id="jiguinummsg">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											IP数量：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="ipNum" id="ipNum" value="${saleorder.ipNum}" onblur="checkValueByRules('ipNum','','ipNumMsg')">
											&nbsp;
											<FONT color=#ff0000 id="ipNumMsg"></FONT><font color=#ff0000>*</font>
										</TD>
										<TD height=30 align=right>
										带宽总数：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="bw" id="bw" value="${saleorder.bw}" onblur="checkValueByRules('bw',['num'],'bwMsg')">
											M&nbsp;
											<FONT color=#ff0000 id="bwMsg">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											订单价格：
										</TD>
										<TD class=category >
											<input  name="price" id="price" onblur="checkValueByRules('price',['money'],'priceMsg')" value= "${saleorder.price}"/>
											RMB&nbsp;
											<FONT color=#ff0000 id="priceMsg"></FONT><FONT color=#ff0000 >*</FONT>
										</TD>	
											<TD width="25%" height=30 align=right>
											订单类型：
										</TD>
										<TD class=category>
										<s:select id="orderType" name="orderType" list="#request.orderType" listKey="id" listValue="questionName" value="%{-1,#request.saleorder.allTypeByOrdertype.id}" headerKey="" 
										 headerValue="请选择订单类型" onblur="checkValueByRules('orderType','','orderTypeMsg')">
										</s:select>
										
											<FONT color=#ff0000 id="orderTypeMsg">*</FONT>
										</TD>
																			
									</TR>	
									<TR>
								
										<TD height=30 align=right>
										付费类型：
										</TD>
										<TD class=category>
										<s:select id="payType" name="payType" list="#request.payType" listKey="id" listValue="typeName" value="%{-1,#request.saleorder.allTypeByPayStyle.id}" headerKey=""
										 headerValue="请选择付费类型" onblur="checkValueByRules('payType','','payTypeMsg')">
										</s:select>
												
											&nbsp;
											<FONT color=#ff0000 id="payTypeMsg">*</FONT>
										</TD>
										<TD width="25%" height=30 align=right>
											付费状态：
										</TD>
										<TD class=category>
										<s:select id="payStatus" name="payStatus" list="#request.paystatus" listKey="id" listValue="typeName" value="%{-1,#request.saleorder.allTypeByPayStatus.id}" headerKey=""
										 headerValue="请选择付费状态" onblur="checkValueByRules('payStatus','','payStatusMsg')">
										</s:select>
											&nbsp;
											<FONT color=#ff0000 id="payStatusMsg">*</FONT>
										</TD>
									</TR>	
									
									<TR>
										<TD width="25%" height=30 align=right>
											开始时间：
										</TD>
										<TD class=category>
											<!-- <INPUT style="WIDTH: 200px" name="beginTime" id="beginTime" onfocus="calendar()" value="${saleorder.beginTime}" onblur="checkValueByRules('beginTime','','beginTimeMsg')"> -->
											<INPUT style="WIDTH: 55%" name="beginTime" id="beginTime"  onclick="WdatePicker()"  value="${saleorder.beginTime}" onblur="checkValueByRules('beginTime','','beginTimeMsg')">
											&nbsp;
											<FONT color=#ff0000  id="beginTimeMsg"></FONT><FONT color=#ff0000 >*</FONT>
										</TD>
										<TD height=30 align=right>
										到期时间：
										</TD>
										<TD class=category>
											<!-- <INPUT  style="WIDTH: 200px" name="endTime" id="endTime" onfocus="calendar()" value="${saleorder.endTime}" onblur="checkValueByRules('endTime','','endTimeMsg')"> -->
											<INPUT style="WIDTH: 55%" name="endTime" id="endTime"  value="${saleorder.endTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginTime\')}'})"   style="WIDTH: 150px" onblur="checkValueByRules('endTime','','endTimeMsg')" >
											&nbsp;
											<FONT color=#ff0000 >*</FONT><font color=#ff0000 id="endTimeMsg"></font>
										</TD>
									</TR>	
									
									
									<TR>
										<TD height=30 align=right>
										服务器配置描述：
										</TD>
									<td class=category colspan="3">
									<textarea rows="10" cols="100" id="serverConfiguration" name="serverConfiguration">${saleorder.serverConfiguration}</textarea>
									
									</td>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											备注：
										</TD>
										<TD class=category >
											<textarea rows="3" cols="50" id="description" name="description">${saleorder.description}</textarea>
											
										</TD>	
										<TD  align="right">
											经办人：
										</TD>	
										<td><s:property value="#session.loginName"/>
									<input type="hidden" id="inputAdmin" name="inputAdmin" value="<s:property value="#session.loginName"/>"></td>							
									</TR>
									<TR>
										<TD align="center" class=category colspan="4">
										<c:if test="${saleorder==null}">
											<INPUT class=button type=submit value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${saleorder!=null}">
											<input type="hidden" name="id" value="${saleorder.id }"/>
											<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>									
				</TBODY>
			</TABLE>
			</TD>
			</TR>
			</TBODY>
			</TABLE>
		</FORM>
<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
	</body>
</html>