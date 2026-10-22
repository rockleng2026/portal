<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=GBK" pageEncoding="GBK"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>


		<title>更新订单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>

		<LINK href="<%=request.getContextPath()%>/Css/setMeal/css.css"
			type="text/css" rel="stylesheet">


	</head>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/cdn/js/jquery-1.3.2.min.js"></script>

	<script type="text/javascript">
   function two()
 {
 
    var department=document.getElementById("department").value;
  
    var url="selectEmployeeorderAction.do";
    $.post(url,{department:department},function (data){
     $("#employeeList").remove();
     $("#tdtd").append(data);
    });
 }
	
	function al()
	{
	   
	    var orderType=document.getElementById("ordertypeId").value;
		
		var taocanType=document.getElementById("taocanType").value;
		
		var url="taocanorderAction.do";
		$.post(url,{orderType:orderType,taocanType:taocanType},function (data){
		    var rd=document.getElementsByName("a");
		    
		    $("#trtr").remove();
		    for(var i=0;i<rd.length;i++)
		    {
		      $("#trtr").remove();
		    }
		    $("#addtr").append(data);
		});
		
		
	}
	
	function add1()
	{
	  
	   
	    var orderType=document.getElementById("ordertypeId").value;
	    if(orderType=="0")
	    {
	      alert("请输入单据类型！！！！");
	      return false;
	    }
	    var taocanType=document.getElementById("taocanType").value;
	    if(taocanType=="0")
	    {
	      alert("请输入套餐类型！！！！");
	      return false;
	    }
	    var fufeiType=document.getElementById("fufeiType").value;
	    if(fufeiType=="0")
	    {
	      alert("请输入付费类型！！！！");
	      return false;
	    }

    var cusname=document.getElementById("cusname").value;
     if(cusname==null || cusname=="")
     {
        alert("请填写客户姓名!!");
	     return false;
     }
    
     var discountDes=document.getElementById("discountDes").value;
    
     var orderNumber=document.getElementById("orderNumber").value;
   if(orderNumber==null || orderNumber=="")
   {
        alert("请填写订单号!!");
	     return false;
   } 
     
     var price=document.getElementById("price").value;
   if(price==null || price=="")
   {
        alert("请填写价格!!");
	     return false;
   } 
    var isfouDiscount="";
    
   
  var rdValue=document.getElementsByName("isfouDiscount");
  for(var i=0;i<rdValue.length;i++){
	if(rdValue[i].checked==true){
	  isfouDiscount=rdValue[i].value;
	  break;
	}
  }
  
    
    
   if(isfouDiscount==null || isfouDiscount=="")
   {
        alert("请填写是否折扣!!");
	     return false;
   } 
  if(isfouDiscount=="1")
    if (discountDes=="" || discountDes==null)
   {
    alert("请填写折扣描述！！");
    return false;
   }
    var xufeiStartTime  =document.getElementById("xufeiStartTime").value;
   if(xufeiStartTime==null || xufeiStartTime=="")
   {
        alert("请填写订单续费开始时间!!");
	     return false;
   }  
   var orderNextXufei  =document.getElementById("orderNextXufei").value;
   if(orderNextXufei==null || orderNextXufei=="")
   {
        alert("请填写订单下次续费时间!!");
	     return false;
   } 
   
   var department=document.getElementById("department").value;
   if(department==0)
   {
        alert("请输入部门!!");
	     return false;
   } 
   var xiaoshou=document.getElementById("employeeList").value;
   if(xiaoshou==0)
   {
        alert("请输入员工姓名!!");
	     return false;
   }
   
   var orderDes=document.getElementById("orderDes").value;
    
   	var crd=document.getElementsByName("a");
	var orderId="";
	for(var i=0;i<crd.length;i++)
	{
	 if(crd[i].checked==true)
	 {
	   orderId=crd[i].value;
	 }
	}
	if(orderId==""||orderId==null)
	{
		alert("请选择套餐！！");
		return false;
	}
	
   var xiaoshou1=encodeURI(xiaoshou);
   var cusname1=encodeURI(cusname);
   var discountDes1=encodeURI(discountDes);
   var isfouDiscount1=encodeURI(isfouDiscount);
   var orderDes1=encodeURI(orderDes);
   var department1=encodeURI("department");
   var employeeList1=encodeURI("employeeList");
   var url="updateSOorderAction.do";
   $.post(url,{
              orderType:orderType, //订单类型
              taocanType:taocanType,//套餐类型
              fufeiType:fufeiType,  //付费类型
              xiaoshou:xiaoshou1,    //销售人员 
              cusname:cusname1,              //客户姓名
              discountDes:discountDes1,//折扣描述
              orderNumber:orderNumber,//订单编号
              price:price,            //价格
              isfouDiscount:isfouDiscount1,//是否折扣
              xufeiStartTime:xufeiStartTime,    //订单续费开始时间
              orderNextXufei:orderNextXufei,  //订单下次续费
              orderDes:orderDes1,       //订单描述
              orderId:orderId,//套餐id
              employeeList:employeeList1 //员工
              },function (data){
   				if(data==0)
			   	{
			   		alert("修改成功");
			   		window.location.href='<%=request.getContextPath()%>/saleOrderListorderAction.do';
			   	}
			   	else
			   	{
			   		alert("修改失败 ");
			   	}
   
   });
	     
	    
	}
	function taocan(id)
	{
　		　window.open ('<%=request.getContextPath()%>/selecttaocanorderAction.do?type=info&id='+id);
	}
</script>
	<style type="text/css">
.divclass {
	OVERFLOW: auto;
	scrollbar-face-color: #FFFFFF;
	scrollbar-shadow-color: #D2E5F4;
	scrollbar-highlight-color: #D2E5F4;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #D2E5F4;
}
</style>

	<body>
		<form action="addsaleOrder.do" method="post">
			<table width="1000" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr>
					<td align="center" colspan="4">
						<div class="dt01"
							style="background:url(<%=request.getContextPath()%>/images/setMeal/hdr.gif) repeat-x left center; ">
							<div class="left">
								<img
									src="<%=request.getContextPath()%>/images/setMeal/hdrl.gif" />
							</div>
							<div class="left" style="width: 988px;">
								<h3>
									修改订单
								</h3>
							</div>
							<div class="right">
								<img
									src="<%=request.getContextPath()%>/images/setMeal/hdrr.gif" />
							</div>
						</div>
					</td>
				</tr>
				<tr>
				   <td align="right" width="250" height="30" >
						订单号：
					</td>
					
					<TD class=category style="font-size:18px;">
						<input type="text" name="orderNumber" id="orderNumber"  value="${SaleorderComm.orderNo}">
						<input type="hidden" name="orderId">
					</TD>
					<td align="right" width="250" height="30" >
						单据类型：

					</td>
					
					<td align="left" width="350" >
					   <input type="hidden" name="ordertypeId" value="${setmealComm.ordertype.id}"/>
						${setmealComm.ordertype.name}
						
						
					</td>
					
					
					
				</tr>
				<tr style="background: #fff;">
				   
				    <td align="right" width="250">
						套餐类型：
					</td>
					<td align="left" width="250" >
					  <select onchange="al()" id="taocanType">
                	
                    <option value="2" <c:if test="${setmealComm.chargeMode==2}">selected="selected"</c:if> >赠送</option>
                    <option value="1"  <c:if test="${setmealComm.chargeMode==1}">selected="selected"</c:if> >免费</option>
                    <option value="3"  <c:if test="${setmealComm.chargeMode==3}">selected="selected"</c:if>>预付</option>
                    <option value="4"  <c:if test="${setmealComm.chargeMode==4}">selected="selected"</c:if>>后付</option>
                </select>
						
					</td>
					  <td align="right" width="250" height="30">
						付费类型：
					</td>
					<td align="left" width="250">
					<select id="fufeiType">
                	
                    <option value="1" <c:if test="${SaleorderCommm.payStyle==1}">selected="selected"</c:if> >月付</option>
                    <option value="2"  <c:if test="${SaleorderCommm.payStyle==2}">selected="selected"</c:if> >季付</option>
                    <option value="3"  <c:if test="${SaleorderCommm.payStyle==3}">selected="selected"</c:if>>半年付</option>
                    <option value="4"  <c:if test="${SaleorderCommm.payStyle==4}">selected="selected"</c:if>>一年付</option>
                    <option value="5"  <c:if test="${SaleorderCommm.payStyle==4}">selected="selected"</c:if>>一次付</option>
                </select>
						
					</td>
					
				</tr>
				<tr>
				 
					<td align="right" width="250" height="30">
						客户姓名：
					</td>
					<TD class=category>
						<input id="cus" onblur="checkValueByRules('cus','','cusMsg')"
							value="${customer.customerName}"
							onclick="returnSome2('showDialogOutbound.do?mark=custom','cus','cusname')"
							readonly="readonly">
						<input name="cusname" id="cusname" type="hidden"
							value="${customer.customerId}" />
					
					</TD>
						<td align="right" width="250">
						销售人员：
					</td>
					<td align="left" width="250" id="tdtd">
						<input id="xiaoshou" name="" type="hidden"/>
            	
                <select  onchange="two()" id="department" name=""  >
            		<c:forEach items="${department}" var="data">
            			<option value="${data.id}" <c:if test="${data.id==dtId}">selected="selected"</c:if>>${data.name}</option>
            		</c:forEach>
            	</select>
            	<select id="employeeList" >
            	
            		<c:forEach items="${employee1}" var="data">
            			<option value="${data.id}" <c:if test="${data.id==SaleorderComm.employeeId }">selected="selected"</c:if>>${data.name}</option>
            		</c:forEach>
            	</select>
						
					</td>
					
				</tr>
				

				<tr style="font-size: 12px;">
				
						<td align="right" width="250">
						 录入人员:
					</td>
					
					<td align="left" width="250">
						<input type="text" disabled="disabled" value="${SaleorderComm.inputAdmin}"/>
						
					</td>
					<td align="right" width="250">
						录入时间：
					</td>
					
					<td align="left" width="250">
						
					<input type="text" disabled="disabled" value="${SaleorderComm.buildTime}"/>
					
					
				</tr>
                 <tr>
                
					<td align="right" width="250" height="30">
						是否折扣：
					</td>
					<TD class=category>
					<input type="radio" name="isfouDiscount" id="isfouDiscount"   value="1"/ >是
					<input type="radio" name="isfouDiscount" id="isfouDiscount"  checked="checked"  value="2" />否
						

					</TD>
					
					<td align="right" width="250">
						折扣描述：
					</td>
					<td align="left" width="250">
						<input type="text" id="discountDes" value="${SaleorderComm.discountDescribe}">
					</td>
                 
                 </tr>
				<tr>
				    <td align="right" width="250">
						订单续费开始时间：
					</td>
					<td align="left" width="250">
						<input type="text" name="xufeiStartTime" id="xufeiStartTime" value="${SaleorderComm.startTime}" onclick="WdatePicker()">
					</td>
					<td align="right" width="250">
						订单下次续费时间：
					</td>
					<TD class=category>
						<input type="text" name="orderNextXufei" id="orderNextXufei" value="${SaleorderComm.payNexttime}" onclick="WdatePicker({minDate:'#F{$dp.$D(\'xufeiStartTime\')||\'2020-10-01\'}'})">

					</TD>
					
				</tr>
				<tr>
				
					<td align="right" width="250">
						价格：
					</td>
					<td align="left" width="250">
						<input type="text" name="price" id="price" value="${SaleorderComm.price}">
					</td>
					<td align="right" width="250">
						订单描述：
					</td>
					<td align="left" width="250">
						<textarea style="height: 60px; width: 200px;" id="orderDes" >${SaleorderComm.describtion}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table  id="addtr" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                	<td colspan="8" height="15"></td>
                </tr>
                	<!--<tr>
                    	<td colspan="8" align="center" class="dt08" height="30">套餐</td>
                    </tr>-->
                    <tr class="dt08">
                    	<td width="15%" align="center" height="30">
                        	套餐名称
                        </td>
                        <td width="10%" align="center">
                        	活动开始时间
                        </td>
                        <td width="10%" align="center">
                        	活动结束时间
                        </td>
                        <td width="30%" align="center">
                        	套餐描述
                        </td>
                        <td width="10%" align="center">
                        	服务时间
                        </td>
                        <td width="10%" align="center">
                        	原价
                        </td>
                        <td width="10%" align="center">
                        	实际价格
                        </td>
                        <td width="5%" align="center">
                        	选择
                        </td>
                    </tr>
                    
                     <tr id="trtr">
                    	<td width="15%" align="center" height="30">
                        	<a href="javascript:void(0)" onclick="taocan(${setmealComm.id})">${setmealComm.name }</a>
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.startTime }
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.endTime }
                        </td>
                        <td width="30%" align="center">
                        	${setmealComm.describe }<a href="javascript:void(0)" id="jtip2" onclick="add(2)">详细信息</a>
                        	<div id="alerts2" style="position:absolute; z-index:2; width:400px; height:100px; background-color:#fff;  border:1px dashed #0166d4;display:none" class="divclass"><div align="right">
				<span onclick="showDiv()" style="color: #993333; font-weight:bold">关闭</span></div >${setmealComm.describe }</div>
                        </td>
                        <td width="10%" align="center">
                        	
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.totalPrice }
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.payPrice }
                        </td>
                        <td width="5%" align="center">
                        	<input type="radio" name="a" checked="checked" value="${setmealComm.id}"/>
                        </td>
                    </tr>
                    
                    
                     
                </table>
						<table width="100%">
						 <tr>

								<td colspan="8" align="center" height="50">
									<input id="" name="" type="button" value="修改" onclick="add1()" />
									&nbsp;&nbsp;
									<input id="" name="" type="reset" value="重置" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript">
function showDiv()
{
  
document.getElementById("alerts2").style.display="none";
}
function add(count){
	
 $("#jtip"+count+"").click(function(){//对象定位
 var h=0, l=0, w=0, obj = this;
 while(obj != null)
 {
 h += obj.offsetTop -10;
 l += obj.offsetLeft -15;
 obj = obj.offsetParent;
 }

 w = $(this).width();

 $("#alerts"+count+"").css({'top':h+'px','left':(l+w)+'px'});
 $("#alerts"+count+"").show();
})


}





</script>
</html>
