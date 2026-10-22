<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'upservers.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type='text/javascript' src='<%=path %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/icon.css">
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/easyui.css">
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery.checkform.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
	    <script type="text/javascript" src="<%=basePath%>serm/js/upservers.js"></script>
	 <script type="text/javascript">
	  window.onload=function(){
	    var cabitid=<%=request.getAttribute("catids") %>
	    //alert("ci="+cabitid);
	    $('#jgh').val(cabitid);
	    e.getUpservNumber("pmnums",function(ps){
	        //alert(ps);
	        $('#upNo').val(ps);
	     });
	  }
	  $(function(){
	   
	     $('#selnode').click(function(){
	          getSaleOrders();
	     }); 
	   
	   $('#dows').datebox({   
				  required:true, 
                  missingMessage: "必填项", 
				  onSelect:function(ms){
				   // alert($('#dt').datebox("getValue"));
				  }
			  }); 
	   //结束U
	   $('#ends').blur(function(){
	     //alert(9494);
	     getpassion();
	   });
	
	  });
	  //验证U位置
	  function getpassion(){
	     var serverSize=$('#spaceSize').val();
	     var stat = $('#starts').val();
	     var end = $('#ends').val();
	     if(serverSize !=((end-stat)+1)){
	        $.messager.alert("提示","你输入的位置有误，请重新输入","info");
	        $('#starts').val('');
	        $('#ends').val('');
	     }else{
	       var caid=$("#jgh").val();
	       var msm=stat+","+end+","+caid;
	       e.getCabpossition(msm,function(res){
	          if(res=="no"){
	             $.messager.alert("提示","你输入的位置已被占用或位置不够","info"); 
	             $('#starts').val('');
	             $('#ends').val('');
	          }
	       });
	     }
	  }
	  function getSaleOrders(){
	    var str=$('#saleOrderNo').val();
        e.getUpsernode(str,function(pm){
          //alert(pm);
          var da=new Date();
          var arr=new Array();
          var arr=pm.split(",");
          $('#company').val(arr[0]);
          $('#sname').val(arr[1]);
          $('#mobile').val(arr[2]);
          $('#empname').val(arr[3]);
         // $('#servs').val(arr[4]);
          $('#spaceSize').val(arr[4]);
          $('#empIds').val(arr[5]);
          $('#customerId').val(arr[6]);
          $('#ipnum').val(arr[7]);
          $('#ups').val((da.getFullYear()+"-"+(da.getMonth()+1)+"-"+da.getDate()));
        });
	  }
	  $(function(){
	     //仓库
	   $('#possions').click(function(){
	       if(document.getElementById("possions").options.length==1){
	            e.loadStorage("all",function(res){
	                // alert(res);
	                 $('#possions').append(res);
	                 $('#servs').empty();
	            });
	       }
	   });
	  });
	  //服务器的
	  function changeServs(sers){
	      //alert("sers="+sers);
	      e.loadservers((sers+""),function(pms){
	        // alert(pms);
	         $('#servs').append(pms);
	      });
	  }
	</script>
</head>

<body>
<div style=" width:900px; height:500px;">
 <div style=" width:840px; height:40px;">
  <div style=" height:40px; width:200px; font-size:16px; font-weight:bold; text-align:center; line-height:40px; color:#3fade0; float:left;">
  请输入上架信息
  </div>
  <div style="height:40px; width:200px; font-size:12px; line-height:40px; color:#333; float:left;">
  （带*号的为必填项）
  </div>
 </div>
 <form method="post" id="formss" name="formss">
 <input type="hidden" id="bathpaths" value="<%=basePath%>">
 <input type="hidden" id="empIds" name="upServer.empIds"/>
 <input type="hidden" id="customerId" name="upServer.customer.customerId"/>
 <table width="890" border="0" cellspacing="0" cellpadding="0" align="center" style="font-size:12px;">
  <tr>
    <td width="125" class="xzsjd-wz">上架单号：</td>
    <td width="120" class="xzsjd-tx"><input name="upServer.upNo" type="text" id="upNo" class="zjjigui-tx" readonly="readonly"/></td>
    <td width="30" class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up1"></span></td>
    <td width="125" class="xzsjd-wz">销售订单号：</td>
    <td width="120" class="xzsjd-tx"><input name="upServer.salenodeString" id="saleOrderNo" type="text"  class="zjjigui-tx" onkeypress="javascript:if(event.keyCode == '13'){getSaleOrders();}"/></td>
    <td width="200" colspan="2"><input type="button" id="selnode" value="查询" style="cursor: pointer;float:left"/><span id="errors" style="font-size:12px;float:left;color:red;">*</span></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">单位名称：</td>
    <td class="xzsjd-tx"><input name="upServer.customer.customerCompany" type="text" id="company" class="zjjigui-tx" readonly="readonly"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">联系人：</td>
    <td class="xzsjd-tx"><input name="upServer.customer.customerName" id="sname" type="text"  class="zjjigui-tx" readonly="readonly"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">联系电话：</td>
    <td class="xzsjd-tx"><input name="upServer.customer.mobilePhone"  readonly="readonly" id="mobile" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style="color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">销售负责人：</td>
    <td class="xzsjd-tx"><input name="upServer.salenameString" id="empname" readonly="readonly" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">仓库位置：</td>
    <td class="xzsjd-tx">
    <select name="upServer.serverLocation" id="possions" onchange="changeServs(this.value)">
     <option value="0">请选择</option>
    </select>
    </td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="ser1s"></span></td>
    <td class="xzsjd-wz">服务器名称：</td>
    <td class="xzsjd-tx">
	    <select name="upServer.product.id" id="servs" >
	     <option value="0">请选择</option>
	    </select>
    </td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style="color:#F00; font-size:12px;"><span id="ser2s"></span></td>
  </tr>
   <tr>
    <td class="xzsjd-wz">上架日期：</td>
    <td class="xzsjd-tx"><input name="upServer.uptimeString" id="ups" type="text"  class="zjjigui-tx" readonly="readonly"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">下架日期：</td>
    <td class="xzsjd-tx"><input name="upServer.downtimeString" id="dows" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up2"></span></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">IP数量：</td>
    <td class="xzsjd-tx"><input name="upServer.ipnum"  id="ipnum" type="text"  class="zjjigui-tx"  readonly="readonly"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up3"></span></td>
    <td class="xzsjd-wz">维护口令：</td>
    <td class="xzsjd-tx"><input name="upServer.maintenancePass" id="maintenancePass" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">带宽数量：</td>
    <td class="xzsjd-tx"><input name="upServer.bandwidthAmount" id="bandwidthAmount" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up4"></span></td>
    <td class="xzsjd-wz">带宽限制：</td>
    <td class="xzsjd-tx"><input name="upServer.bandwidthThrottling" id="bandwidthThrottling" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">交换机名称：</td>
    <td class="xzsjd-tx"><input name="upServer.jhjname" id="jhjname" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up5"></span></td>
    <td class="xzsjd-wz">端口：</td>
    <td class="xzsjd-tx"><input name="upServer.port" id="port" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="up6"></span></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">机柜号：</td>
    <td class="xzsjd-tx"><input name="upServer.jgh" type="text" id="jgh" readonly="readonly" class="zjjigui-tx" /></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">服务器大小：</td>
    <td class="xzsjd-tx"><input name="upServer.salespaceString" readonly="readonly" id="spaceSize" type="text"  class="zjjigui-tx"/></td>
    <td style="line-height:40px; font-size:12px;" >（U）<a style="line-height:40px; color:#F00; font-size:16px;"></a></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">IP地址：</td>
    <td colspan="4" class="xzsjd-tx"><input name="upServer.serverIp" id="serverIp" type="text" readonly  style="border: double #CCC thin;
    line-height:30px; height:30px; width:350px;"/><input type="button" value="选择" onclick="getAllIps()"/></td>
      <td colspan="2" class="xzsjd-tx">请单击“选择”按钮<a style="line-height:40px; color:#F00; font-size:16px;">*</a></td>
      <td width="120" style=" color:#F00; font-size:12px;"><span id="up7"></span></td>
    </tr>
  <tr>
    <td class="xzsjd-wz">服务器位置：</td>
    <td colspan="6" style=" height:40px;"><input name="upServer.startpossition" type="text" id="starts" style="height:20px; width:30px; border: double #CCC thin"/>（U）————
      <input name="upServer.endpossition" type="text" id="ends" style="height:20px; width:30px; border: double #CCC thin" />（U）
      <a  style="line-height:40px; font-size:12px; margin-left:20px;">（在机柜中的具体位置）</a>
      <a style="line-height:40px; color:#F00; font-size:16px;">*</a></td>
      <td width="120" style=" color:#F00; font-size:12px;"><span id="up8"></span></td>
    </tr>
  <tr>
    <td class="xzsjd-wz">备注：</td>
    <td colspan="5"><input name="upServer.temp" type="text" id="temps"  style="height:60px; width:445px; border: double #CCC thin"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
</table>
<div id="xzsjd-but-k">
 <div style="margin-left:250px;">
  <input type="button" class="zjjf-but1" value="确认" onclick="checkform()">
  <input type="reset" class="zjjf-but2" value="重置">
 </div>
</div>
</form>
</div>
</body>
</html>
	