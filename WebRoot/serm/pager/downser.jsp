<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>下架单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
	<link type="text/css" rel="stylesheet"
		href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet"
		href="<%=basePath%>serm/css/easyui.css">
	<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
		<script type="text/javascript"
		src="<%=basePath%>serm/js/jquery.checkform.js"></script>

    <SCRIPT type="text/javascript">
          $(function(){
			  $('#dt').datebox({   
				  required:true, 
                  missingMessage: "必填项", 
				  onSelect:function(ms){
				   // alert($('#dt').datebox("getValue"));
				  }
			  }); 
			});
function checkform()
{
   $.messager.confirm("提示","你确定提交吗？",function(p){
   if(p){
    jQuery.checkForm({
        ctrls: [                                   
            {id: "outselect",type:"mustSelect", par:"0",msg: "请选择下架类型"},
            {id: "countBank",type:"mustInput", par:"12", msg: "结算账号不能为空"},   
            {name:"downse.costFlag",type:"mustRadio", par:"", msg: "费用结清状态不能为空"},
            {id: "outsouse",type:"mustInput", par:"0", msg: "下架原因不能为空"},
            {id:"remoneys",type:"mustInt",par:"0",msg:"必须输入数字"}
            ],
        success: function(){ 
       
    	  if($('#remoneys').val()==""){
    	     $('#remoneys').val(0);
    	  
    	  }
    	  if($('#configInfo').val()==""){
    	    $('#configInfo').val("无");
    	 
    	  }
    	  if($('#beMark').val()==""){
    	     $('#beMark').val("无");
    	 
    	  }
    	  if($('#remoneys').val()==""){
    	     $('#remoneys').val(0);
    	  }
    	  if($('#cusnames').val()==""){
    	      $('#cusnames').val("无");
    	  }
        // document.getElementById("forms").submit();          
          $('#forms').form("submit",{
               url:"cms/show_downthisServs.do",
               onsubmit:function(){return $('#forms').form("validate")},
               success:function(result){
                    if(result=='yes'){
                        //alert(result);
                       $.messager.alert('提示','下架成功','info',function(){
                           top.location.reload();
                       });
                       
                     }
               }
          });                   
        },
        failed: function(msg){  
            if(msg=="请选择下架类型"){
              	$('#sp2').html('');
		    	$('#sp3').html('');
		    	$('#sp4').html('');
		    	$('#sp5').html('');
		    	$('#spmt').html('');
            	$('#sp1').html(msg);
            }
            if(msg=="结算账号不能为空"){
                $('#sp1').html('');
    	        $('#sp4').html('');
    	        $('#spmt').html('');
    	        $('#sp5').html('');
            	$('#sp3').html('');
            	$('#sp2').html(msg);
            }
            if(msg=="费用结清状态不能为空"){
            	$('#sp1').html('');
    	        $('#sp2').html(''); 
    	        $('#sp4').html('');
    	        $('#sp5').html('');
    	        $('#spmt').html('');
            	$('#sp3').html(msg);
            }
            if(msg=="下架原因不能为空"){
            	$('#sp1').html('');
		    	$('#sp2').html('');
		    	$('#sp3').html('');
		    	$('#spmt').html('');
		    	$('#sp4').html('');
            	$('#sp5').html(msg);
            }
            if($('#dt').datebox("getValue")==""){
              	$('#sp1').html('');
              	$('#spmt').html('');
		    	$('#sp2').html('');
		    	$('#sp3').html('');
		    	$('#sp5').html('');
            	$('#sp4').html("日期不能为空");
            }
            if(msg=="必须输入数字"){
            	$('#sp2').html('');
		    	$('#sp3').html('');
		    	$('#sp4').html('');
		    	$('#sp5').html('');
            	$('#sp1').html('');
                $('#spmt').html(msg);
            }
            }
        }); 
        }
        });
        }
    </SCRIPT>
</head>

<body>
<div style=" width:900px; height:840px;">
 <div style=" width:840px; height:40px;">
  <div style=" height:40px; width:200px; font-size:16px; font-weight:bold; text-align:center; line-height:40px; color:#3fade0; float:left;">
  请输入下架信息
  </div>
  <div style="height:40px; width:200px; font-size:12px; line-height:40px; color:#333; float:left;">
  （带*号的为必填项）
  </div>
 </div>
 <form  method="post" name="forms" id="forms">
 <input type="hidden" id="upNo" name="downse.upNo" value="<s:property value="#session.upseList.id"/>"/>
 <table width="840" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="125" class="xzsjd-wz">下架单号：</td>
    <td width="120" class="xzsjd-tx"><input name="downse.downNo" type="text"  class="zjjigui-tx" value="<s:property value="#session.upseList.upNo"/>" readonly="readonly"/></td>
    <td width="30" class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td width="125" class="xzsjd-wz">业务类型：</td>
    <td width="120" class="xzsjd-tx"><select name="downse.businesstype" id="select" style=" width:120px;">
    <option value="IDC" >IDC</option>
	<option value="VPS" >VPS</option>
	<option value="虚拟主机">虚拟主机</option>
    </select></td>
    <td width="30" class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">单位名称：</td>
    <td class="xzsjd-tx"><input name="downse.customer.customerCompany" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.customer.customerCompany"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">服务器名称：</td>
    <td class="xzsjd-tx"><input name="downse.product.property.name" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.product.property.name"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">联系人：</td>
    <td class="xzsjd-tx"><input name="downse.customer.realName" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.customer.realName"/>"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">电话：</td>
    <td class="xzsjd-tx"><input name="downse.customer.phone" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.customer.phone"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style="color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">证件号码：</td>
    <td class="xzsjd-tx"><input name="downse.customer.cardid" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.customer.cardid"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">公司负责人：</td>
    <td class="xzsjd-tx"><input name="downse.customer.employee.name" id="cusnames" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.customer.employee.name"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
   <tr>
    <td class="xzsjd-wz">机房位置：</td>
    <td class="xzsjd-tx"><input name="downse.serverLocation" type="text"  class="zjjigui-tx" readonly="readonly" value="<s:property value="#session.upseList.Tupcabs.Telecthouse.electPosition"/>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">下架类型：</td>
    <td ><select name="downse.allType.id" id="outselect" style=" width:120px;">
    <option value="0">请选择</option>
     <option value="22">损坏下架</option>
     <option value="23">更改配置下架</option>
     <option value="26">客户下架</option>
    </select></td>
    <td class="xzsjd-xh">*</td>
    <td width="120"><span style=" color:#F00; font-size:12px;" id="sp1"></span></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">系统显示：</td>
    <td class="xzsjd-tx">
    <select id="system" name="downse.system"  style=" width:120px;">
        <option value="windows2003">windows2003</option>
		<option value="windows2008">windows2008</option>
		<option value="Linux(redhat)">Linux(redhat)</option>
		<option value="Linux(centos)">Linux(centos)</option>
		<option value="Unix">Unix</option>
		<option value="其它">其它</option>
    </select>
    </td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">宽带流量：</td>
    <td>
    <input type="text"  class="zjjigui-tx" readonly="readonly"  name="downse.bandwidthflow" value="<s:property value="#session.upseList.bandwidthAmount"/>"/>M
    </td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">反退金额：</td>
    <td class="xzsjd-tx"><input name="downse.returnAmout" type="text" id="remoneys" class="zjjigui-tx"/>￥</td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"><span id="spmt"></span></td>
    <td class="xzsjd-wz">结算账号：</td>
    <td class="xzsjd-tx"><input name="downse.settlementAccount" id="countBank" type="text"  class="zjjigui-tx"/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120"><span style=" color:#F00; font-size:12px;" id="sp2"></span></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">下架日期：</td>
    <td class="xzsjd-tx"><input name="downse.dowTimedt" type="text"  class="zjjigui-tx" id="dt"/>
    </td>
    <td class="xzsjd-xh">*</td>
    <td width="120" ><span style=" color:#F00; font-size:12px;" id="sp4"></span></td>
    <td class="xzsjd-wz">费用结清：</td>
    <td style=" font-size:12px; line-height:30px;"><input name="downse.costFlag" type="radio" value="1" />是&nbsp;&nbsp;<input name="downse.costFlag" type="radio" value="0" />否</td>
    <td class="xzsjd-xh">*</td>
    <td width="120"><span style=" color:#F00; font-size:12px;" id="sp3"></span></td>
  </tr>
 
  <tr>
    <td class="xzsjd-wz">要下架的IP：</td>
    <td colspan="4" class="xzsjd-tx"><input name="downse.serverIp" type="text"  style=" border:0px; background:url(images/xzsjd.jpg); background-position:center;
    background-repeat:no-repeat;height:30px; width:250px;" value="<s:property value="#session.upseList.serverIp"/>"/><a style="line-height:40px; color:#F00; font-size:16px;"></a></td>
      <td colspan="2" class="xzsjd-tx"></td>
      <td width="120" style=" color:#F00; font-size:12px;"></td>
    </tr>
   <tr>
    <td class="xzsjd-wz">经手人：</td>
    <td class="xzsjd-tx"><input name="downse.employee.name" type="text"  class="zjjigui-tx" value="<%=request.getSession().getAttribute("loginName") %>"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
    <td class="xzsjd-wz">&nbsp;</td>
    <td class="xzsjd-tx">&nbsp;</td>
    <td  >&nbsp;</td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">下架原因：</td>
    <td colspan="5" style="height:60px;"><input name="downse.downcause" type="text" id="outsouse"  style="height:50px; width:470px;overflow-y:scroll; overflow-x:hidden;
    table-layout: fixed;word-wrap:break-word;word-break:break-all;
     border: double #CCC thin";/></td>
    <td class="xzsjd-xh">*</td>
    <td width="120"><span style=" color:#F00; font-size:12px;" id="sp5"></span></td>
  </tr>
   <tr>
    <td class="xzsjd-wz">配置详情：</td>
    <td colspan="5"  style="height:60px;"><input name="downse.configurationinfo" id="configInfo" type="text"  style="height:50px; width:470px;overflow-y:scroll; overflow-x:hidden;
    table-layout: fixed;word-wrap:break-word;word-break:break-all;
   border: double #CCC thin;"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
  <tr>
    <td class="xzsjd-wz">备注：</td>
    <td colspan="5"  style="height:60px;"><input name="downse.remark" type="text" id="beMark" style="height:50px; width:470px; overflow-y:scroll; overflow-x:hidden;
    table-layout:fixed;word-wrap:break-word;word-break:break-all; border: double #CCC thin;"/></td>
    <td class="xzsjd-xh"></td>
    <td width="120" style=" color:#F00; font-size:12px;"></td>
  </tr>
</table>
<div id="xzsjd-but-k">
 <div style=" margin-left:250px;">
  <input class="zjjf-but1" type="button" value="确认" onclick="checkform()"/>
  <input class="zjjf-but2" type="reset" value="重置">
 </div>
</div>
</form>
</div>
</body>
</html>

