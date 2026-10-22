<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">  
    <title>修改机柜</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type='text/javascript' src='<%=path %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
	<link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
	        $(function(){ 
	              //alert(998);
	            if(document.getElementById('electIds').options.length==1){
	              var ms=$('#eids').val();
	             // alert("ms="+ms);
	              e.ReAtRoom(ms,function(res){
	                  //alert(res);
	                  $('#electIds').append(res);
	                  var pm = document.getElementById('electIds').options;
	                  for(var i = 0;i<pm.length;i++){
	                    if(pm[i].value == ms){
	                        pm[i].selected=true;
	                        $('#selct').val(ms);
	                    }
	                  }
	              });
	            }
	        
	        });
	        function resetSelct(){
	             var se = document.getElementById("electIds").options;
	            // alert("e="+se.length+","+$('#selct').val());
	             for(var i=0;i<se.length;i++){
	                 if(se[i].value == $('#selct').val()){
	                      document.getElementById("formss").reset();
	                      se[i].selected=true;
	                 }
	             }
	        }
	   </script>
  </head>
  
  <body>
    <div style=" width:350px; height:200px;">
						 <div style=" width:350px; height:40px;">
						  <div style=" height:40px; width:200px; font-size:16px; font-weight:bold; text-align:center; line-height:40px; color:#3fade0; float:left;">
						  修改机柜信息
						  </div>
						  <div style="height:40px; width:150px; font-size:12px; line-height:40px; color:#333; float:left;">
						  （带*号的为必填项）
						  </div>
						 </div>
						 <input type="hidden" id="selct"/>
						 <form action="cms/show_updateCa.do" method="post" id="formss">
						 <input type="hidden" value="${cabinet.caid}" id="caid" name="cabinet.caid"/>
						 <input type="hidden" value="${electid}" id="eids"/>
						 <table>
						 	<tr>
							    <td class="zjjigui-wz">房间名：</td>
							    <td class="zjjigui-tx"><select name="electHouse.electId"  id="electIds" class="zjjigui-tx">
							     <option value="0">请选择</option>
							    </select></td>
							    <td class="zjjigui-wzd"></td>
							</tr>
						 	<tr>
							    <td class="zjjigui-wz">机柜名称：</td>
							    <td class="zjjigui-tx"><input name="cabinet.caname" type="text" id="caname" value="${cabinet.caname}" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd"></td>
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">机柜大小：</td>
							    <td><input name="cabinet.casz" type="text" id="casz" value="${cabinet.casz}"  class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（U）</td>
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">最大功率：</td>
							    <td><input name="cabinet.pmax" type="text" id="pmax" value="${cabinet.pmax}" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（W）</td>
							    
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">最大带宽：</td>
							    <td><input name="cabinet.bwmax" type="text" id="bwmax" value="${cabinet.bwmax}"  class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（M）</td>
							  </tr>
							</table>

<div id="zjjf-but-k">
 <div class="zjjf-but1"><input type="submit" value="修改" /></div>
 <div class="zjjf-but2"><input type="button" value="重置"  onclick="resetSelct()"/> </div>
</div>
</form>
</div>
  </body>
</html>
