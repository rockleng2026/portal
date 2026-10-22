<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>到货单信息表</title>
<script type="text/javascript">
window.onload = function()
		{

			categorylist('deptSelect','${data.department.id}','');
		}



 var returnvalue="";
 var purmodel = "";
 var i=1;
//选择采购订单
 function purshowWind() {  
               returnvalue= showModalDialog("<%=request.getContextPath() %>/getPurchaseOrder.do?funid=144&is='is'","","dialogWidth=900px;dialogHeight=600px");
               var array = returnvalue.split(",");	
				$("#purOrderid").attr("value",array[0]);
				$("#purOrderNO").attr("value",array[1]);
				$("#totime").attr("value",array[2]);
				$("#grossmoney").attr("value",array[3]);
				
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
				var url = "selectModelPurchaseOrder.do";
				$.post(url,{purid:purid},function(data){
				
					$("#editTabs").append(data);
				});				
}


//添加行时加载类型列表
function addtr()
{
	
	
}
function getpurModel(str)
{
	var mid = $("#model"+str).val();
	var url = "getPurModelCountPurchaseOrder.do";
	$.post(url,{infoid:mid},function(data){
		$("#purcount"+str).attr("value",data);
	});
}



</script>

</head>
	<body>
	<FORM name="customerform" action="<c:if test="${data.id !=null}">updateToOrder.do</c:if>
		<c:if test="${data.id==null}">addToOrder.do	</c:if>" method="post" onsubmit="return checkToOrder()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">
							<TABLE cellSpacing=0 width="100%" cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD align=right>
											
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<font face="Agency FB"><img alt="" src="<%=request.getContextPath()%>/images/r_2.gif"></font>
						</TD>
					</TR>
					<TR>
						<TD><br></TD>
						<TD>
							<TABLE class="grid" width="100%" style="background:#eef7fd" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>					
								<TR>
									<TD width="100%" height=30 align="center" colspan="4"><br>
										<h1><font face="Agency FB">到货单</font></h1><font face="Agency FB"> 
										到货单编号： 
										</font><c:if test="${empty data}"><font face="Agency FB"><input type="text" style="width: 800px;" id="ToOrderid" name="toOrderNum" value="${number}"></font></c:if>
										<c:if test="${not empty data}">
										<font face="Agency FB"><input type="text" style="width: 200px;" id="ToOrderid" name="toOrderNum" value="${data.toOrderNum}"><input type="hidden" style="width: 200px;" id="ToOrderid" name="ToOrderid" value="${data.id}"></font>
										</c:if>
									</TD>
								</TR>																				
								<TR>
									<TD width="5%" height=30 align=right><font face="Agency FB"> 
										订单编号： 
									</font></TD>
									<TD class=category width="35%">
										<font face="Agency FB"><input style="width: 200px;" name="purOrderNO" id="purOrderNO" value="${data.purOrder.purOrderNo}" onblur="checkValueByRules('purOrderNO','','purOrderNO1')"> 
										<img alt="" src="<%=request.getContextPath()%>/images/choose.gif" onclick="completemission('getPurchaseOrder.do?funid=144&is=is','')"> 
										<input type="hidden" style="width: 200px;" name="purOrder.id" id="purOrderid" value="${data.purOrder.id}"> 
										&nbsp; 
										 
										</font><FONT color=#ff0000 id="purOrderNO1" face="Agency FB">*</FONT>
									</TD>
									<TD height=30 align=right><font face="Agency FB"> 
									批次编号： 
									</font></TD>
									<TD class=category>
										<c:if test="${empty data}"><font face="Agency FB"><input style="width: 200px;" name="piciNo" id="pjid" value="${pici}"></font></c:if>
										<c:if test="${not empty data}">
											<font face="Agency FB"><input style="width: 200px;" name="piciNo" id="pjid" value="${data.piciNo}"></font>
										</c:if><font face="Agency FB"> 
										&nbsp; 
										</font><FONT color=#ff0000 id="pjid1" face="Agency FB">*</FONT>
									</TD>
								</TR>	
				
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											交货日期： 
										</font></TD>
										<TD class=category>

											<INPUT  style="WIDTH: 200px" name="totime" id="totime" onfocus="WdatePicker()" value="${data.totime}">
											&nbsp;
											<FONT color=#ff0000 id="totime1">*</FONT>

										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										采购类型： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><select name="buytype" id="buytype" value="${data.buytype}" onblur="checkValueByRules('buytype','','buytype1')"> 
												<option value="">请选择</option> 
												<option value="服务器配件采购" <c:if test="${data.buytype == '服务器配件采购'}">selected='selected'</c:if>="">服务器配件采购</option> 
												<option value="办公配件采购" <c:if test="${data.buytype == '办公配件采购'}">selected='selected'</c:if>="">办公配件采购</option> 
												<option value="食品酒水采购" <c:if test="${data.buytype == '食品酒水采购'}">selected='selected'</c:if>="">食品酒水采购</option> 
												<option value="办公电脑采购" <c:if test="${data.buytype == '办公电脑采购'}">selected='selected'</c:if>="">办公电脑采购</option> 
												<option value="其他采购" <c:if test="${data.buytype == '其他采购'}">selected='selected'</c:if>="">其他采购</option> 
											</select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="buytype1" face="Agency FB">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											交货方式： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><select name="deliverytType" id="deliverytType" onblur="checkValueByRules('deliverytType','','deliverytType1')">  
											<option value="">请选择</option> 
											<option value="物流公司" <c:if test="${data.deliverytType == '物流公司'}">selected='selected'</c:if>="">物流公司</option> 
											<option value="我方送货" <c:if test="${data.deliverytType == '我方送货'}">selected='selected'</c:if>="">我方送货</option> 
											<option value="客户自提" <c:if test="${data.deliverytType == '客户自提'}">selected='selected'</c:if>="">客户自提</option> 
											</select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="deliverytType1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										到货日期： 
										</font></TD>
										<TD class=category>

											<INPUT style="WIDTH: 200px" name="deliveryTime" id="deliveryTime" onfocus="WdatePicker()" value="${data.deliveryTime}" onblur="checkValueByRules('deliveryTime','','deliveryTime1')">
											&nbsp;
											<FONT color=#ff0000 id="deliveryTime1">*</FONT>

										</TD>
									</TR>	
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											交货人： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB">
											<input style="width: 200px;" name="deliveryer" id="deliveryer" value="${data.deliveryer}" onblur="checkValueByRules('deliveryer','','deliveryer1')"> 
											&nbsp; 
											</font>
											<FONT color=#ff0000 id="deliveryer1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										联系电话： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="phone" id="phone" value="${data.phone}" onblur="checkValueByRules('phone',['phone'],'phone1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="phone1" face="Agency FB">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											交货地址： 
										</font></TD>
										<TD class=category >
											<font face="Agency FB"><textarea rows="2" cols="40" name="deliveryaddress" id="deliveryaddress" onblur="checkValueByRules('deliveryaddress','','deliveryaddress1')"> ${data.deliveryaddress}</textarea></font>
											&nbsp;
											<FONT color=#ff0000 id="deliveryaddress1" face="Agency FB">*</FONT>
										</TD>	
									
										<TD width="15%" height=30 align=right><font face="Agency FB"> 
											供应商地址： 
										</font></TD>
										<TD class=category >
											<font face="Agency FB"><textarea rows="2" cols="40" name="supplieraddress" id="supplieraddress"> ${data.supplieraddress}</textarea></font>
											&nbsp;
											<FONT color=#ff0000 id="supplieraddress1" face="Agency FB">*</FONT>
										</TD>									
									</TR>	
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											是否开票：
										</font></TD>
										<TD class=category>
											<font face="Agency FB">
											<input type="radio" name="isBilling" id="isBilling" checked="checked">开
											<input type="radio" name="isBilling" id="isBilling">不开 
											&nbsp; 
											</font><FONT color=#ff0000 id="isBilling1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										结款方式： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><select name="payType" id="payType" onblur="checkValueByRules('payType','','payType1')"> 
											<option value="">请选择</option> 
											<option value="款到发货" <c:if test="${data.payType == '款到发货'}">selected='selected'</c:if>="">款到发货</option> 
											<option value="分期结款" <c:if test="${data.payType == '分期结款'}">selected='selected'</c:if>="">分期结款</option> 
											 
											</select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="payType1" face="Agency FB">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											约定支付方式： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><select name="payAppointType" id="payAppointType" value="${data.payAppointType}" onblur="checkValueByRules('payAppointType','','payAppointType1')"> 
											<option value="">请选择</option> 
											<option value="现金" <c:if test="${data.payAppointType == '现金'}">selected='selected'</c:if>="">现金</option> 
											<option value="支票" <c:if test="${data.payAppointType == '支票'}">selected='selected'</c:if>="">支票</option> 
											<option value="转账" <c:if test="${data.payAppointType == '转账'}">selected='selected'</c:if>="">转账</option> 
											<option value="电汇" <c:if test="${data.payAppointType == '电汇'}">selected='selected'</c:if>="">电汇</option> 
											<option value="试用预付款" <c:if test="${data.payAppointType == '试用预付款'}">selected='selected'</c:if>="">使用预付款</option> 
											</select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="payAppointType1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										运费结算： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="paytraffic" id="paytraffic" value="${data.paytraffic}" onblur="checkValueByRules('paytraffic',['money'],'paytraffic1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="paytraffic1" face="Agency FB">*</FONT>
										</TD>
									</TR>		
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											运单号： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="trafficOrdernum" id="trafficOrdernum" value="${data.trafficOrdernum}" onblur="checkValueByRules('trafficOrdernum',['en_num'],'trafficOrdernum1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="trafficOrdernum1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										运单总额： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="orderGross" id="orderGross" value="${data.orderGross}" onblur="checkValueByRules('orderGross',['money'],'orderGross1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="orderGross1" face="Agency FB">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											物流公司： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="trafficcompany" id="trafficcompany" value="${data.trafficcompany}" onblur="checkValueByRules('trafficcompany','','trafficcompany1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="trafficcompany1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										物流联系人： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="trafficLinkman" id="trafficLinkman" value="${data.trafficLinkman}" onblur="checkValueByRules('trafficLinkman','','trafficLinkman1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="trafficLinkman1" face="Agency FB">*</FONT>
										</TD>
									</TR>
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											物流电话： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="trafficphone" id="trafficphone" value="${data.trafficphone}" onblur="checkValueByRules('trafficphone',['phone'],'trafficphone1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="trafficphone1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										总金额： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><input style="width: 200px;" name="grossmoney" id="price" value="${data.grossmoney}" onblur="checkValueByRules('price',['money'],'grossmoney1')"> 
											&nbsp; 
											</font><FONT color=#ff0000 id="grossmoney1" face="Agency FB">*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
										经办部门： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB"><select id="deptSelect" name="department.id" onchange="getemp()" onblur="checkValueByRules('deptSelect','','deptSelect1')"></select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="deptSelect1" face="Agency FB">*</FONT>
										</TD>
										<TD height=30 align=right><font face="Agency FB"> 
										经办人： 
										</font></TD>
										<TD class=category>
											<font face="Agency FB">
											<select id="empSelect" name="employee.id">
												<option>${data.employee.name}</option>
											</select> 
											&nbsp; 
											</font><FONT color=#ff0000 id="transactdept1" face="Agency FB">*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD  height=30 align=right><font face="Agency FB"> 
											备注： 
										</font></TD>
										<TD class=category colspan="3">
											<font face="Agency FB"><textarea rows="3" cols="50" id="remark" name="remark">${data.remark}</textarea> 
											&nbsp; 
											</font><FONT color=#ff0000 id="remark1" face="Agency FB">*</FONT>
										</TD>									
									</TR>
									<tr></tr>
									<tr>
									<td colspan="4">
									<table border="1" bgcolor="white" width=800px id="editTabs" name="editTabs" width="100%">
									<TR>
										<TD align=center height=30 ><font face="Agency FB"> 
											选择订单中商品： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											应到数量： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											实际到货量： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											单价： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											折扣： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											总价： 
										</font></TD>
										<TD align=center height=30 ><font face="Agency FB"> 
											删除： 
										</font></TD>
									</TR>
							<c:if test="${not empty data}">
								<c:forEach items="${explist}" var="data" varStatus="status">
									<tr id="tr${status.index+1}">
										<td  align=center height=30>
											<font face="Agency FB"><input type="hidden" id="batchids" name="batchids" value="${data.id}"><input id="model${status.index+1}" name="modelid" value="${data.model.name}"><input type="hidden" id="model${status.index+1}" name="model" value="${data.model.model}"></font>
											
											
										</td>
										<td  align=center height=30>
											<font face="Agency FB"><input id="purcount${status.index+1}" name="purcount" value="${data.purcount}"></font>
										</td>
										<td  align=center height=30>
											<font face="Agency FB"><input id="count${status.index+1}" onblur="onesum(${status.index+1})" name="count" value="${data.count}"></font>
										</td>
										<td  align=center height=30>
											<font face="Agency FB"><input id="infoprice${status.index+1}" onblur="onesum(${status.index+1})" name="infoprice" value="${data.price}"></font>
										</td>
										<td  align=center height=30>
											<font face="Agency FB"><input id="discount${status.index+1}" onblur="onesum(${status.index+1})" name="discount" value="${data.discount}"></font>
										</td>
										<td  align=center height=30>
											<font face="Agency FB"><input id="sum${status.index+1}" onblur="onesum(${status.index+1})" name="sum" value="${data.sum}"></font>
										</td>
										<TD align=center height=30 width="10%">
											<font face="Agency FB"><input type="button" value="删除" class="button" onclick="delTr(${status.index+1})"></font>
										</TD>
									</tr>
								</c:forEach>
							</c:if>
									</table>
									</td>
									</tr>
									<tr>
									<td colspan="6"></td>
									<TR>
										<TD width="25%" height=30 align="center" colspan="4" >
											<c:if test="${empty data}">
											<INPUT class=button type=submit value="确认添加 ">
											</c:if>
											<c:if test="${not empty data}">
											<INPUT class=button type=submit value="确认修改 ">
											</c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>		
										</tr>
								</TBODY>
								<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
							</TABLE>
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