<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加机柜</title>   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type='text/javascript' src='<%=path %>/dwr/interface/e.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=path %>/dwr/util.js'></script>
 <%
	String electid = request.getParameter("electid");
	request.setAttribute("temp",electid);
 %>
    <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	        $(function(){ 
	          $('#electIds').click(function(){
	              //alert(998);
	            if(document.getElementById('electIds').options.length==1){
	              var ms=$('#temp').val();
	              //alert("ms="+ms);
	              e.ReAtRoom(ms,function(res){
	                  //alert(res);
	                  $('#electIds').append(res);
	              });
	            }
	          });
	        });
			function onClickCabinet()
			{
				var caname = $('#caname').val();
				var casz = $('#casz').val();
				var pmax = $('#pmax').val();
				var bwmax = $('#bwmax').val();
				if(caname == "")
				{
					$('#lbl1').show();
					return false;
				}
				if($('#electIds').val()==0){
				    if(document.getElementById('electIds').options.length==1){
				       return true;
				    }else{
				         $('#rom1').html('请选择房间号');
				         return false;
				    }
				  
				}
				if(casz == "" || isNaN(casz))
				{
					$("#lbl2").show();
					return false;
				}
				if(pmax == "" || isNaN(pmax))
				{
					$('#lbl3').show();
					return false;
				}
				if(bwmax == "" || isNaN(bwmax))
				{
					$('#lbl4').show();
					return false;
				}
				
			}
			
			function fucsC(obj,num)
			{
				var temp = num;
				var a = obj.value;
				var str = "#lbl"+temp;
				if(a == "")
				{
					$(str).show();
					return false;
				}
				if(a != "")
				{
					$(str).hide();
				}
				
			}
<!--			function checkIsInteger(str) -->
<!--        	{ -->
<!--                //如果为空，则通过校验 -->
<!--                if(str == "") -->
<!--                return true; -->
<!--               if(/^(\-?)(\d+)$/.test(str)) -->
<!--               return true; -->
<!--             else -->
<!--               return false; -->
<!--         } -->
<!--         String.prototype.trim = function() -->
<!--        { -->
<!--                return this.replace(/(^[\s]*)|([\s]*$)/g, ""); -->
<!--        } -->
<!--        $("myButton").onclick=function(){ -->
<!--             -->
<!--            if(checkIsInteger($("myInput").value.trim())){ -->
<!--                alert("成功"); -->
<!--            }else{ -->
<!--                alert("只能是数字"); -->
<!--            } -->
<!--        } -->
<!--		}-->
	</script>
</head>
<body>
						<div style=" width:500px; height:200px;">
						 <div style=" width:350px; height:40px;">
						  <div style=" height:40px; width:200px; font-size:16px; font-weight:bold; text-align:center; line-height:40px; color:#3fade0; float:left;">
						  请输入机柜信息
						  </div>
						  <div style="height:40px; width:150px; font-size:12px; line-height:40px; color:#333; float:left;">
						  （带*号的为必填项）
						  </div>
						 </div>
						 <form action="cms/show_createCabint.do" method="post" onsubmit="return onClickCabinet();" >
						 <input type="hidden" id="temp" name="temp" value="${temp}"/>
						 
						 <table>
						   	 <tr>
							    <td class="zjjigui-wz">房间号：</td>
							    <td class="zjjigui-tx"><select name="electHouse.electId"  id="electIds" class="zjjigui-tx">
							     <option value="0">请选择</option>
							    </select></td>
							    <td class="zjjigui-wzd"></td><td><div id="rom1" style="font-size: 12px;color: red;"></div></td>
							 </tr>
						 	 <tr>
							    <td class="zjjigui-wz">机柜名称：</td>
							    <td class="zjjigui-tx"><input name="cabinet.caname" onblur="fucsC(this,1);" type="text" id="caname" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd"></td><td><label id="lbl1" style="font-size: 12px;color: red;display: none;">机柜名不能为空</label></td>
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">机柜大小：</td>
							    <td><input name="cabinet.casz" type="text" id="casz" onblur="fucsC(this,2);" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（U）</td><td><label id="lbl2" style="font-size: 12px;color: red;display: none;">机柜大小不能为空或者不是数字</label></td>
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">最大功率：</td>
							    <td><input name="cabinet.pmax" type="text" id="pmax" onblur="fucsC(this,3);" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（W）</td><td><label id="lbl3" style="font-size: 12px;color: red;display: none;">机柜功率不能为空或者不是数字</label></td>
							  </tr>
							  <tr>
							    <td class="zjjigui-wz">最大带宽：</td>
							    <td><input name="cabinet.bwmax" type="text" id="bwmax" onblur="fucsC(this,4);" class="zjjigui-tx"/></td>
							    <td class="zjjigui-wzd">（M）</td><td><label id="lbl4" style="font-size: 12px;color: red;display: none;">机柜带宽不能为空或者不是数字</label></td>
							  </tr>
							</table>

		<div id="zjjf-but-k">
 		<div class="zjjf-but1"><input type="submit" value="确认" onclick="onClickCabinet();" /></div>
 		<div class="zjjf-but2"><input type="reset" value="重置"/> </div>
		</div>
</form>
</div>
</body>
</html>
