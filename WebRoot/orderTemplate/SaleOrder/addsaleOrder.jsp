<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addsaleOrder.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	

  </head>
  

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
		
		var taocanType=document.getElementById("taocanType").value;
		var orderType=document.getElementById("orderType").value;
		var url="taocanorderAction.do";
		
		$.post(url,{taocanType:taocanType,orderType:orderType},function(data){
			
			var rd=document.getElementsByName("a");
			$("#trtr").remove();
			for(var i=0;i<rd.length;i++)
			{
				$("#trtr").remove();
			}
			$("#addtr").append(data);
		});
		
	}
	
	function taocan(id)
	{
	window.open ('<%=request.getContextPath() %>/selecttaocanorderAction.do?type=info&id='+id)

	}

</script>
<style type="text/css">	
.divclass{
	OVERFLOW:auto;
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
  <div style=" position:absolute; left:10px; top:10px; width:150px; background:#D2E6E4;">
  	<h4 align="center">添加单据流程</h4>
  <h5>	单据类型<br /><FONT color=#ff0000>&nbsp;&nbsp;(根据所买产品选择)</FONT></h5>
  	
  	↓
  <h5>	套餐类型<br /></h5>
  ↓
  <h5>	选择套餐<br /></h5>
  ↓
  <h5>	销售人员<br /><FONT color=#ff0000>&nbsp;&nbsp;(选择部门→员工)</FONT></h5>
  ↓
  <h5>	客户<br /></h5>
  ↓
  <h5>	描述<br /><FONT color=#ff0000>&nbsp;&nbsp;(可选填写)</FONT></h5>
  ↓
  <h5>	付费类型<br /></h5>
  ↓
  <h5>	完成<br /></h5>
  </div>
  <div style=" position:absolute; right:10px; left:165px; top:10px; width:800px; ">
  <form id="form1">
	<table width="1000" border="0" cellpadding="0" cellspacing="0"  align="center">
  <tr>
    <td align="center" colspan="4"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; " >
        <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:988px;">
          <h3>增加订单</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
        <tr>
        	<td align="right" width="250" height="30"> 
            	单据类型：
            </td>
            <td align="left" width="250">
                <s:select  id="orderType" name="danjuLeixing" cssClass="category" 
                list="#request.orderType" listKey="id" listValue="name" headerKey="0" headerValue="请选择！！" value="%{'',#request.orderType.name}">
                </s:select>
            	
            </td>
            <td align="right" width="100">
            	套餐类型：
            </td>
            <td align="left" width="400">
            		  <select onchange="al()" id="taocanType">
                	<option value="0" >请选择！！</option>
                    <option value="2" >赠送</option>
                    <option value="1"   >免费</option>
                    <option value="3"  >预付</option>
                    <option value="4" >后付</option>
                </select>
                
             
            </td>
        </tr>
        <tr style="background:#fff;">
        	<td align="right" width="250" height="30">
            	付费类型：
            </td>
            <td  align="left" width="250">
            	<select id="fufeiType">
                	<option value="0">请选择！！</option>
                	<option value="1">月付</option>
                    <option value="2">季付</option>
                    <option value="3">半年付</option>
                    <option value="4">一年付</option>
                    <option value="5">一次付</option>
                </select>
            </td>
        	<td  align="right" width="100">
            	销售人员：
            </td>
            <td  align="left" width="400" id="tdtd">
            	<input id="xiaoshou" name="" type="hidden"/>
            	   <s:select  onchange="two()" id="department" name="" 
                list="#request.department" listKey="id" listValue="name" headerKey="0" headerValue="请选择部门" value="%{'',#request.department.id}">
                </s:select>
            	<select id="employeeList" >
            		<option value="0">请选择员工</option>
            	</select>
            </td>
        </tr>
        <tr>
        	<td align="right" width="250">
            	客户姓名：
            </td>
           <TD class=category>
			<input id="cus" onblur="checkValueByRules('cus','','cusMsg')" value="${saleorder.customer.realName}" 
			onclick="returnSome2('showDialogOutbound.do?mark=custom','cus','cusname')" readonly="readonly">
			<input name="cusname" id="cusname" type="hidden" value="${ saleorder.customer.customerId}"/>
			&nbsp;
			<FONT color=#ff0000 id="cusMsg">*</FONT>
			</TD>
        	<td  align="right" width="100">
            	订单描述：
            </td>
            <td  align="left" width="400">
            	<textarea style="height:50px;width:200px;" id="orderDes"></textarea>
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
                     
                </table>
                <table width="100%">
                    <tr>
                    	<td  align="center" height="50">
                        	<input id="" name="" type="button" value="增加" onclick="xxx()"/>&nbsp;&nbsp;
							<input id="" name="" type="reset" value="重置"/>
							
							
                        </td>
                    </tr> 
                    </table>
            </td>
        </tr>
    </table>
    </form> 	
    </div>
</body>
<script type="text/javascript">

function xxx()
{

   var orderType=document.getElementById("orderType").value;
   if(orderType ==0)
   {
        alert("请选择单据类型!!");
	     return false;
   }
    var taocanType=document.getElementById("taocanType").value;
   if(taocanType=="0")
   {
        alert("请选择套餐类型!!");
	     return false;
   }
    var fufeiType=document.getElementById("fufeiType").value;
   if(fufeiType==0)
   {
        alert("请选择付费类型!!");
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
    var cus=document.getElementById("cusname").value;
   if(cus==null || cus=="")
   {
        alert("请填写客户姓名!!");
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
	var orderDes1=encodeURI(orderDes);
   var url="addSaleOrderorderAction.do";
   $.post(url,{
   orderType:orderType,//单据类型
   taocanType:taocanType,//套餐类型
   fufeiType:fufeiType,//付费类型
   xiaoshou:xiaoshou1,//销售员工
   cus:cus,//客户
   orderDes:orderDes1,//单据描述
   orderId:orderId//套餐
   },function (data){
   	if(data==0)
   	{
   		alert("增加成功！！！");
   		
   		window.location.href='<%=request.getContextPath() %>/saleOrderListorderAction.do';
   	}
   	else
   	{
   		alert("增加失败！！！ ");
   	}
   });

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
