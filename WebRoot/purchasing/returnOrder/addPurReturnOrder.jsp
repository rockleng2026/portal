<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>采购退货单信息表</title>
<script type="text/javascript">
	 var returnvalue="";
	 var somemodel="";
	//选择采购订单
 	function showWind() {  
         returnvalue= showModalDialog("<%=request.getContextPath() %>/getpageToOrder.do?is='is'","","dialogWidth=900px;dialogHeight=600px");
         var array = returnvalue.split(",");		
        $("#toOrderid").attr("value",array[0]);	
		$("#toOrderNO").attr("value",array[1]);
		$("#purOrderid").attr("value",array[2]);
		$("#purorderNO").attr("value",array[3]);
		
		$("#supplierId").attr("value",array[4]);
		$("#supplierName").attr("value",array[5]);
		$("#phone").attr("value",array[6]);
		$("#supplierAddress").attr("value",array[7]);
		$("#buytype").attr("value",array[8]);
		$("#grossmoney").attr("value",array[9]);
		$("#piciNO").attr("value",array[10]);
		
		
		var trArray = document.getElementsByName("model");
		var modelArray = new Array();
		for(var i=0;i<trArray.length;i++)
		{
			modelArray[i] = trArray[i].value;
		}
		for(var j=0;j<modelArray.length;j++)
		{
			delTr(j+1);
		}
				
		var purid = $("#purOrderid").val();
		var url = "selectModelRejection.do";
		$.post(url,{toOrderid:array[0]},function(data){
			$("#editTabs").append(data);
		});			
		
	}
	var i=1;
	
	//选择商品时，获取到该批次中的信息
	function getpurModelInfo(str)
	{
		var modelid = $("#model"+str).val();
		var url = "getBatchexpInfoRejection.do";
		$.post(url,{modelid:modelid},function (data){
			var array = data.toString().split(",");
			$("#count"+str).attr("value",array[0]);
			$("#infoprice"+str).attr("value",array[1]);
			$("#discount"+str).attr("value",array[2]);
			$("#sum"+str).attr("value",array[3]);
		});
	}
	
	function checkReturnOrder()
	{
		if(!addValidators())
		{
			return false;
		}
		else
		{
			return true;
		}
	}
</script>
</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post" onsubmit="return checkReturnOrder()">
			<TABLE cellSpacing=0 cellPadding=0 width="1236" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							
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
										<TD height=30 align="center" colspan="4">
											<h1><c:if test="${not empty returnorder}">修改</c:if>采购退货单</h1>
										</TD>
									</TR>																				
									<TR>
										<TD width="100" height=30 align=right> 
											退货日期： 
										</TD>
										<TD width="400" class=category>
											<INPUT style="WIDTH: 200px" name="returnTime" id="returnTime" onclick="WdatePicker()" value="${returnorder.returnTime}"  onblur="checkValueByRules('returnTime','','returnTimeMsg')">
											&nbsp;
											<FONT color=#ff0000 id="returnTimeMsg">*</FONT>
										</TD>
										<TD height=30 align=right> 
										到货单编号： 
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="" id="toOrderNO" value="${returnorder.toOrder.toOrderNum}" readonly="readonly"  onblur="checkValueByRules('toOrderNO','','toOrderNO1')"/>
											<INPUT style="WIDTH: 200px" type="hidden" name="toOrder.id" id="toOrderid" value="${returnorder.toOrder.id}" />
											<img alt="" src="<%=request.getContextPath()%>/images/choose.gif" onclick="completemission('getpageToOrder.do?is=is','')" >
											&nbsp;
											<FONT color=#ff0000 id="toOrderNO1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											订单编号：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="" id="purorderNO" value="${returnorder.purOrder.purOrderNo}" readonly="readonly" />
											<input type="hidden" name="purOrder.id" id="purOrderid" value="${returnorder.purOrder.id}" />
											&nbsp;
											<FONT color=#ff0000 id="orderid1">*</FONT>
										</TD>
										<TD width="25%" height=30 align=right>
											批次编号：
										</TD>
										<TD class=category>
											<div style="display: inline;"><INPUT style="WIDTH: 200px" name="linkPeople" id="piciNO" value="${returnorder.toOrder.piciNo}" readonly="readonly"></div>
											&nbsp;
											<div style="display: inline;"><FONT color=#ff0000 id="linkPeople1">*</FONT></div>
										</TD>
									</TR>	
									<TR>
										<TD width="100" height=30 align=right>
										采购类型：
										</TD>
										<TD width="400" class=category>
										<input name="buytype" id="buytype" value="${returnorder.buytype}" />
											&nbsp;
											<FONT color=#ff0000 id="buytypeMsg">*</FONT>
										</TD>
										<TD width="25%" height=30 align=right>
											供应商：
										</TD>
										<TD class=category>
										<INPUT style="WIDTH: 200px" name="" id="supplierName" value="${returnorder.supplier.supplierName}" readonly="readonly">
										<INPUT style="WIDTH: 200px"  type="hidden" name="supplier.id" id="supplierId" value="${returnorder.supplier.id}" readonly="readonly">
											&nbsp;
											<div style="display: inline;"><FONT color=#ff0000 id="orderid1">*</FONT></div>
										</TD>
									</TR>	
									<TR>
										<TD height=30 align=right> 
										联系电话： 
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="phone" id="phone" value="${returnorder.supplier.mobilePhone}" readonly="readonly">
											&nbsp;
											<FONT color=#ff0000 id="phone1">*</FONT>
										</TD>
										<TD height=30 align=right> 
										供应商地址： 
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="supplierAddress" id="supplierAddress" readonly="readonly" value="${returnorder.supplier.supplierAddress}">
											&nbsp;
											<FONT color=#ff0000 id="pjid1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											退货方式：
										</TD>
										<TD class=category>
											<select name="returnStyle" id="returnStyle"  onblur="checkValueByRules('returnStyle','','returnStyle1')"> 
										<c:if test="${empty returnorder}">
											<option value="">请选择</option>
										<c:forEach items="${map1}" var="map1">
											<option value="${map1.key}">${map1.value}</option>
										</c:forEach>
										</c:if>
										<c:if test="${not empty returnorder}">
										<c:forEach items="${map1}" var="map1">
											<c:if test="${map1.value==returnorder.returnStyle}">
											<option value="${map1.key}" selected="selected">${map1.value}</option>
											</c:if>
											<c:if test="${map1.value!=returnorder.returnStyle}">
											<option value="${map1.key}">${map1.value}</option>
											</c:if>
										</c:forEach>
										</c:if>
											</select>
											&nbsp;
											<FONT color=#ff0000 id="returnStyle1">*</FONT>
										</TD>
										<TD height=30 align=right>
										退货原因：
										</TD>
										<TD class=category>
											<select name="returnReason" id="returnReason"  onblur="checkValueByRules('returnReason','','returnReason1')"> 
												<c:if test="${empty returnorder}">
											<option value="">请选择</option>
											<c:forEach items="${map2}" var="map2">
												<option value="${map2.key}">${map2.value}</option>
											</c:forEach>
											</c:if>
											<c:if test="${not empty returnorder}">
											<c:forEach items="${map2}" var="map2">
												<c:if test="${map2.value==returnorder.returnStyle}">
												<option value="${map2.key}" selected="selected">${map2.value}</option>
												</c:if>
												<c:if test="${map2.value!=returnorder.returnStyle}">
												<option value="${map2.key}">${map2.value}</option>
											</c:if>
											</c:forEach>
											</c:if>
											</select>
											&nbsp;
											<FONT color=#ff0000 id="returnReason1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											退货地址：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="returnAddress" id="returnAddress" value="${returnorder.toOrder.deliveryaddress}"  onblur="checkValueByRules('returnAddress','','returnAddress1')">
											&nbsp;
											<FONT color=#ff0000 id="returnAddress1">*</FONT>
										</TD>
										<TD height=30 align=right>
											退货期限：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="returnTimeLimit" id="returnTimeLimit" onFocus="WdatePicker()" value="${returnorder.returnTimeLimit}">
											&nbsp;
											<FONT color=#ff0000 id="returnTimeLimit1">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											退货说明：
										</TD>
										<TD class=category >
											<textarea rows="3" cols="40" name="returnDescription" id="supplieraddress" > ${returnorder.returnDescription}</textarea>
										</TD>	
										<TD width="25%" height=30 align=right>
											付款约定：
										</TD>
										<TD class=category >
											<textarea rows="3" cols="40" name="payappoint" id="payappoint">${returnorder.payappoint}</textarea>
										</TD>									
									</TR>	
									
									<TR>
										<TD width="25%" height=30 align=right>
											是否开票：
										</TD>
										<TD class=category>
											<c:if test="${empty returnorder}">
												<input type="radio" name="isBilling" id="isBilling" value="on">开 <input type="radio" name="isBilling" id="isBilling" value="off">不开
											</c:if>
											<c:if test="${not empty returnorder}">
												<c:if test="${returnorder.isBilling=='on'}">
													<input type="radio" name="isBilling" id="isBilling" checked="checked">开
													 <input type="radio" name="isBilling" id="isBilling">不开
												</c:if>
												 <c:if test="${returnorder.isBilling=='off'}">
													<input type="radio" name="isBilling" id="isBilling">开
													 <input type="radio" name="isBilling" id="isBilling" checked="checked">不开
												</c:if>
											</c:if>
											&nbsp;
											<FONT color=#ff0000 id="isBilling1">*</FONT>
										</TD>
										<TD height=30 align=right>
										结款方式：
										</TD>
										<TD class=category>
											<select name="payType" id="payType"  onblur="checkValueByRules('payType','','payType1')">
											<c:if test="${empty returnorder}">
												<option value="">请选择</option>
												<c:forEach items="${map3}" var="map3">
													<option value="${map3.key}">${map3.value}</option>
												</c:forEach>
											</c:if>
											<c:if test="${not empty returnorder}">
												<c:forEach items="${map3}" var="map3">
													<c:if test="${returnorder.payType==map3.value}">
														<option value="${map3.key}" selected="selected">${map3.value}</option>
													</c:if>
													<c:if test="${returnorder.payType!=map3.value}">
														<option value="${map3.key}">${map3.value}</option>
													</c:if>
												</c:forEach>
											</c:if>
											</select>
											&nbsp;
											<FONT color=#ff0000 id="payType1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											约定支付方式：
										</TD>
										<TD class=category>
											<select name="payAppointType" id="payAppointType"  onblur="checkValueByRules('payAppointType','','payAppointType1')">
											<c:if test="${empty returnorder}">
												<option value="">请选择</option>
												<c:forEach items="${map4}" var="map4">
													<option value="${map4.key}">${map4.value}</option>
												</c:forEach>
											</c:if>
											<c:if test="${not empty returnorder}">
												<c:forEach items="${map4}" var="map4">
													<c:if test="${returnorder.payAppointType==map4.value}">
														<option value="${map4.key}" selected="selected">${map4.value}</option>
													</c:if>
													<c:if test="${returnorder.payAppointType!=map4.value}">
														<option value="${map4.key}">${map4.value}</option>
													</c:if>
												</c:forEach>
											</c:if>
											</select>
											&nbsp;
											<FONT color=#ff0000 id="payAppointType1">*</FONT>
										</TD>
										<TD height=30 align=right>
										运费结算：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="paytraffic" id="paytraffic" value="${returnorder.paytraffic}" onblur="checkValueByRules('paytraffic',['num'],'paytraffic1')"/>
											&nbsp;
											<FONT color=#ff0000 id="paytraffic1">*</FONT>
										</TD>
									</TR>		
									<TR>
										<TD width="25%" height=30 align=right>
											运单号：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="trafficOrdernum" id="trafficOrdernum" value="${returnorder.trafficOrdernum}" onblur="checkValueByRules('trafficOrdernum',['en_num'],'trafficOrdernum1')">
											&nbsp;
											<FONT color=#ff0000 id="trafficOrdernum1">*</FONT>
										</TD>
										<TD height=30 align=right>
										运单总额：
										</TD>
										<TD class=category>
											<c:if test="${not empty returnorder}">
												<INPUT style="WIDTH: 200px" name="orderGross" id="orderGross" value="${returnorder.orderGross}" onblur="checkValueByRules('orderGross',['money'],'orderGross1')">
											</c:if>
											<c:if test="${empty returnorder}">
												<INPUT style="WIDTH: 200px" name="orderGross" id="orderGross" value="0.00" onblur="checkValueByRules('orderGross',['money'],'orderGross1')">
											</c:if>&nbsp;
											<FONT color=#ff0000 id="orderGross1">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											物流公司：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="trafficcompany" id="trafficcompany" value="${returnorder.trafficcompany}">
											&nbsp;
											<FONT color=#ff0000 id="trafficcompany1">*</FONT>
										</TD>
										<TD height=30 align=right>
										物流联系人：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="trafficLinkman" id="trafficLinkman" value="${returnorder.trafficLinkman}"  onblur="checkValueByRules('trafficLinkman','','trafficLinkman1')">
											&nbsp;
											<FONT color=#ff0000 id="trafficLinkman1">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											物流电话：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="trafficphone" id="trafficphone" value="${returnorder.trafficphone}"  onblur="checkValueByRules('trafficphone',['phone'],'trafficphone1')">
											&nbsp;
											<FONT color=#ff0000 id="trafficphone1">*</FONT>
										</TD>
										<TD height=30 align=right>
										总金额：
										</TD>
										<TD class=category>
											<c:if test="${not empty returnorder}">
												<INPUT style="WIDTH: 200px" name="grossmoney" id="grossmoney" value="${returnorder.grossmoney}"  onblur="checkValueByRules('grossmoney',['money'],'grossmoney1')">
											</c:if>
											<c:if test="${empty returnorder}">
												<INPUT style="WIDTH: 200px" name="grossmoney" id="grossmoney" value="0.00"  onblur="checkValueByRules('grossmoney',['money'],'grossmoney1')">
											</c:if>																						
											&nbsp;
											<FONT color=#ff0000 id="grossmoney1">*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
										经办部门：
										</TD>
										<TD class=category>
											<select id="deptSelect" name="department.id" onChange="getemp()"  onblur="checkValueByRules('deptSelect','','deptSelect1')"></select>
											&nbsp;
											<FONT color=#ff0000 id="deptSelect1">*</FONT>
										</TD>
										<TD height=30 align=right>
										经办人：
										</TD>
										<TD class=category>
											<select id="empSelect" name="employee.id" name="${returnorder.employee.id}" ></select>
											&nbsp;
											<FONT color=#ff0000 id="transactdept1">*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											备注：
										</TD>
										<TD class=category colspan="3">
											<textarea rows="3" cols="50" id="remark" name="remark">${returnorder.remark}</textarea>
										</TD>									
									</TR>	
									<tr>
									<td colspan="4">
									<table border="1" bgcolor="white" id="editTabs" width="100%" name="editTabs">
									<TR>
										<TD align=center height=30 width="18%">
											选择到货单中商品：
										</TD>
										<TD align=center height=30 width="15%">
											数量：
										</TD>
										<TD align=center height=30 width="15%">
											单价：
										</TD>
										<TD align=center height=30 width="15%">
											折扣：
										</TD>
										<TD align=center height=30 width="15%">
											总价：
										</TD>
										<TD align=center height=30 width="10%">
											删除：
										</TD>
									</TR>
							<c:if test="${not empty returnorder}">
								<c:forEach items="${infoList}" var="data" varStatus="status">
									<tr id="tr${status.index+1}">
										<td  align=center height=30>
											<input type="hidden" id="batchids" name=batchexpId value="${data.batchexp.id}"/>
											<input id="model${status.index+1}" name="modelid" value="${data.model.name}"/>
											<input id="model${status.index+1}" type="hidden" name="model" value="${data.model.model}"/>
										</td>
										<td  align=center height=30>
											<input id="count${status.index+1}" onblur='onesum(${status.index+1})' name="count" value="${data.count}"/>
										</td>
										<td  align=center height=30>
											<input id="infoprice${status.index+1}" onblur='onesum(${status.index+1})' name="infoprice" value="${data.returnprice}"/>
										</td>
										<td  align=center height=30>
											<input id="discount${status.index+1}" onblur='onesum(${status.index+1})' name="discount" value="${data.discount}"/>
										</td>
										<td  align=center height=30>
											<input id="sum${status.index+1}" onblur='onesum(${status.index+1})' name="sum" value="${data.sum}"/>
										</td>
										<TD align=center height=30 width="10%">
											<input value='删除' class='button' type='button'  onclick='delTr(${status.index+1})' />
										</TD>
									</tr>
								</c:forEach>
							</c:if>
									</table>
									</td>
								</tr>
									<TR>
										<TD width="25%" height=30 align="center" colspan="4" >
											<c:if test="${empty returnorder}">
												<INPUT class=button type=submit value="确认添加 ">
												<input type="hidden" name="returnorderid" id="returnorderid" value="0"/>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT class=button type=reset value=" 重置 ">
												&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT type=hidden value=ok name=hid1>
												<INPUT type=hidden value=58 name=id>
											</c:if>
											<c:if test="${not empty returnorder}">
												<INPUT class=button type=submit value="确认修改 ">
												<input type="hidden" name="returnorderid" id="returnorderid" value="${returnorder.id}"/>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT class=button type=reset value=" 重置 ">
												&nbsp;&nbsp;&nbsp;&nbsp;
												<INPUT type=hidden value=ok name=hid1>
												<INPUT type=hidden value=58 name=id>
											</c:if>
										</TD>
									</TR>				
								</TBODY>
							</TABLE>
							<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
						</TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		
	</body>
</html>