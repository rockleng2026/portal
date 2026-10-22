<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%response.setHeader("Cache-Control","no-store");response.setHeader("Pragma","no-cache");response.setDateHeader ("Expires", 0);%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'serverChange.jsp' starting page</title>
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
	<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type='text/javascript' src='<%=path %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/icon.css">
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/easyui.css">
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
    <style type="text/css">
    #allDivs{
       display:none;
    }
    </style>
    <script type="text/javascript">
      
        $(document).ready(function(){
         var upid=<%=request.getParameter("changid")%>
         //alert(upid);
         $.messager.confirm('提示','转移之前要先下架，是否执行此操作 ？',function(p){
          if(p){
             e.upsFlags((upid+","+2),function(res){
             if(res!='no'){
                $.messager.alert('提示','此服务器已成功下架。','info');
                $('#allDivs').show();
               // alert(res);
                var arrs = new Array();
                arrs = res.split(",");
                $('#hous').val(arrs[0]);
                $('#presentHouse').html(arrs[1]);
                $('#cabs').val(arrs[2]);
                $('#presentcabit').html(arrs[3]);
                $('#number1').html(arrs[4]);
                $('#number2').html(arrs[5]);
                $('#uphid').val(arrs[6]);
             }
           });
          }else{
              history.go(-1);
          }
         });
         $('#noOper').click(function(){
          $.messager.confirm('提示','你确定取消之前操作，返回上一级并上架吗 ？',function(p){
          if(p){
             e.upsFlags((upid+","+1),function(rs){
                history.go(-1);
             });
             }
             });
           });
          $('#changeHouse').click(function(){
           var ho=$('#hous').val();
           if(document.getElementById("changeHouse").options.length==1){
	           e.getAllHouses(ho,function(as){
	              $('#changeHouse').append(as);
	               $('#changecabit').empty();
	           });
           }
          });
        
         });
       
            function moveClick(){ 
            var flag=0;
             var part=new RegExp("/^[0-9]*$/");
             //alert(1212);
             if(document.getElementById("changeHouse").options.length==1){
		           $('#error2').html('');
		           $('#error3').html('');
                   $('#error1').html("请选择转换的机房");
                   flag=1;
             }
             if($('#chagcab').val()==''){
                  $('#error1').html('');
                  $('#error3').html('');
                  $('#error2').html('请选择转换的机柜');
                  flag=1;
             }
             if($('#number3').val()=='' || $('#number4').val()==''){
                   $('#error1').html('');
                   $('#error2').html(''); 
                  $('#error3').html('请填写转换的位置');
                 flag=1;
             }
          
             if(($('#number2').html()-$('#number1').html())!= ($('#number4').val()-$('#number3').val())){
	                   $('#error1').html('');
	                   $('#error2').html(''); 
                       $('#error3').html('填写正确的位置号,或是该位置号不适合');
                       flag=1;
             }
             
             if(flag==0){
	             var stt = $('#number3').val()+","+$('#number4').val()+","+$('#chagcab').val();
	             //alert("stt="+stt);
	             e.getCabpossition(stt,function(ps){
	                if(ps=='yes'){
	                    $('#code1').val($('#number3').val());
	                    $('#code2').val($('#number4').val());
	                    //document.getElementById("forms").submit();
	                    $('#forms').form('submit',{
	                        url:'cms/show_changerOnOther.do',
	                        onsubmit:function(){ return $('#forms').form('validate')},
	                        success:function(result){
	                           //alert(result);
	                           $.messager.alert('提示','转移服务器成功.','info',function(){
	                               window.top.location.reload();
	                           });
	                        }
	                    });
	                }else{
	                   $.messager.alert('提示','你输入的柜号已存在','info');
	                }
	             });
             }
        }
         function getHous(pms){
           //alert(pms);
           $('#hous').val(pms);
           $('#changecabit').empty();
           e.getAllCabinets(pms,function(cs){
                $('#changecabit').append(cs);
           });
         }
         function gotocab(mps){
           $('#chagcab').val(mps);
         }
         function possionblur(){
                   e.getChangePosition(($('#number3').val()+","+$('#number4').val()+","+$('#changecabit').val()),function(result){
                   // alert(result);
                   if(result=="yes"){
                      if(($('#number2').html()-$('#number1').html())!= ($('#number4').val()-$('#number3').val())){
	                   $('#error1').html('');
	                   $('#error2').html(''); 
                       $('#error3').html('填写正确的位置号');
                       $('#number3').val('');
                       $('#number4').val('');  
                          
                      }else{
		                   $('#error1').html('');
			               $('#error2').html(''); 
			               $('#error3').html('');
			               moveClick();
		             }
                   }else{
                       $('#error1').html('');
	                   $('#error2').html(''); 
                       $('#error3').html('位置号填写有误');
                       $('#number3').val('');
                       $('#number4').val('');  
                        
                   }
              });
         }
    </script>
</head>

<body>
<div id="allDivs"><div align="center"> 
</div><div style=" width:400px; height:250px;"><div align="center"> 
 </div><div style=" width:400px; height:40px;">
  <div style=" height:40px; width:200px; font-size:16px; font-weight:bold; text-align:center; line-height:40px; color:#3fade0; float:left;">
  请输入服务器转移信息
  </div>
  <div style="height:40px; width:200px; font-size:12px; line-height:40px; color:#333; float:left;">
  （带*号的为必填项）
  </div>
 </div>

 <table width="350" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td class="zjjf-wz">当前机房：</td>
    <td><span id="presentHouse" style="width:120px; height:22px; border:#bfbfbf double 1px;"></span>
    </td>
    <td class="zjjf-xh">&nbsp;</td>
    <td class="zjjf-bz"></td>
  </tr>
  <tr>
    <td class="zjjf-wz">转移到机房：</td>
    <td class="zjjf-tx"><select id="changeHouse" style=" width:120px; height:22px; border:#bfbfbf double 1px;" onchange="getHous(this.value)">
    <option value="0">请选择</option>
    </select></td>
    <td class="zjjf-xh">*</td>
    <td class="zjjf-bz"><span id="error1" style="color:#F00;"></span></td>
  </tr>
  <tr>
    <td class="zjjf-wz">当前机柜：</td>
    <td>
    <span id="presentcabit" style=" width:120px; height:22px; border:#bfbfbf double 1px;"></span>
    </td>
     <td class="zjjf-xh">&nbsp;</td>
     <td class="zjjf-bz"></td>
  </tr>
  <tr>
    <td class="zjjf-wz">转移机柜：</td>
    <td>
    <select id="changecabit" style=" width:120px; height:22px; border:#bfbfbf double 1px;" onchange="gotocab(this.value)">
    <option value="0">请选择</option>
    </select>
    </td>
     <td class="zjjf-xh">*</td>
     <td class="zjjf-bz"><span id="error2" style="color:#F00;"></span></td>
  </tr>
   <tr>
    <td class="zjjf-wz">机柜中的位置：</td>
    <td><span style="height:20px; width:20px; border: double #CCC 1px;" id="number1"/></span> 
    U—
      <span style="height:20px; width:20px; border: double #CCC 1px;" id="number2"/></span>U</td>    
    <td class="zjjf-xh">&nbsp;</td>
    <td class="zjjf-bz"></td>
  </tr>
  <tr>
    <td class="zjjf-wz">转移后的位置：</td>
    <td><input id="number3" type="text"  style="height:20px; width:20px; border: double #CCC 1px;" />
    U—
      <input id="number4" type="text"  style="height:20px; width:20px; border: double #CCC 1px;" />U</td>    
    <td class="zjjf-xh">*</td>
    <td class="zjjf-bz"><span id="error3" style="color:#F00;"></span></td>
  </tr>
  <!--  
  <tr>
    <td class="zjjf-wz">是否改变IP：</td>
    <td style="color:#434343; line-height:30px;font-size:12px; color:#434343;">是<input name="gaibian" type="checkbox" value="" />&nbsp;&nbsp;&nbsp;&nbsp;否<input name="gaibian" type="checkbox" value="" /></td>
    <td class="zjjf-xh">*</td>
    <td class="zjjf-bz"></td>
  </tr>
  -->
  <tr style=" display:none;">
<!--显示是 display:visible-->
    <td class="zjjf-wz">改变后的全部IP：</td>
    <td colspan="3"><input name="serchag." type="text" style=" width:250px;"/></td>
  </tr>
  <tr>
   <td colspan="4" style=" color:#F00; line-height:30px; font-size:12px; display:none;">
   多个IP用，号隔开
   </td>
  </tr>
</table>
 <form method="post" name="forms" id="forms">
 <input type="hidden" id="hous" name="serchag.changeHouse">
 <input type="hidden" id="chagcab" name="serchag.changecabit" >
 <input type="hidden" id="uphid" name="serchag.upidString"/>
 <input type="hidden" id="code1" name="serchag.number3">
 <input type="hidden" id="code2" name="serchag.number4" >
 <div id="zjjf-but-k">
 <input type="button" class="zjjf-but1" value="转换" id="butn" onclick="possionblur()">
 <input type="button" id="noOper" class="zjjf-but2" value="返回并上架" >
</div>
</form>
</div>
</div>
</body>
</html>
