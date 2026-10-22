<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>编辑运维单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/validators.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/editTable.js" charset="GBK"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" charset="GBK"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/e.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery-1.3.2.min.js"></script>		
			
  </head>
  <style type="text/css">
body{width:595px; margin:0 auto; font-size:12px; color:#282828}
img{border:0}
a{ color:#dd731f}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_top {width:585px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
	.border_grey{ border:1px solid #C6C6C6; height:45px; float:left}
	.rz_title { width:28px; background-color:#5da601;}
	.rz_title { color:#fff; font-size:12px; font-weight:bold; padding:3px 0 3px 0; text-align:center;}
	.rz_content{ padding:10px;}
	.tab_bottom{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:2px;}
	.tab_bottomc{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:5px;}
	.tab_bottomb{ border-bottom:1px #b6b6b6 dashed; padding-top:16px; padding-bottom:10px;}
	.tab_bottom_c{ padding-top:16px; line-height:25px;}
	.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:5px; float:right}
	.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:25px; margin-right:auto; float:left}
	.font_color_hui{color:#7c7c7c}
	.font_color_cheng{color:#dd731f}
</style>
<script type="text/javascript">
   //填写IP地址
  function getAllIps(){
		     //alert("ips");	
		    var str= window.showModalDialog("<%=request.getContextPath()%>/serm/pager/showIPs.jsp","选择IP号","height=300,width=600,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no,edge=sunken"); 
		     $('#serverIp').val(str);
		//     checkonipnum();
		}



  //检查IP地址的数量是否和订单的IP数量匹配
		function checkonipnum(){
		    var n;
			var ipnum=document.getElementById("serverIpNum").value;
			var serip=document.getElementById("serverIp").value;
			if(serip==null || serip==""){
				document.getElementById("serverIpMsg").innerHTML="请选择IP地址！"; 
			}else{
			//alert("serip="+serip);
			var arr=new Array();
			arr=serip.split(",");
		    if(arr[1]==""){
		    n=arr.length-1;
		    }else{
		    n=arr.length;
		    }
			if(arr[1]!="undefined"){
			if(n>ipnum){
				document.getElementById("serverIpMsg").innerHTML="您选择的IP数已经超过啦！";
				document.getElementById("serverIp").value="";
			}else if(n==ipnum)
			{
				document.getElementById("serverIpMsg").innerHTML="您已经选满啦！"+n+"/"+ipnum;
			}
			else
			{
				///document.getElementById("iplist").innerHTML=n+"/"+ipnum;
				document.getElementById("serverIpMsg").innerHTML="请选择足够的IP地址！";
			}
			}else{
			   document.getElementById("serverIpMsg").innerHTML="请选择足够的IP地址！"; 
			}
			}
		}
		
		
		
		$(function(){
		   $('#tuphouse').click(function(){
		      if(document.getElementById("tuphouse").options.length==1){
		      e.getAllHouses("getms",function(res){
		          //alert(res);
		          $('#tuphouse').empty();
		           $('#tuphouse').append('<option value="0">请选择</option>');
		          $('#tuphouse').append(res);
		      });
		      }
		   });
		  
		   $('#tuphouse').change(function(){
		       var sect = $('#tuphouse').children('option:selected').val();
		      // alert("sect="+sect);
		       e.getAllCabinets(sect+"",function(result){
		            //alert(result);
		            $('#Tupcabscaid').empty();
		            $('#Tupcabscaid').append(result);
		       });
		   });
		   $('#Tupcabscaid').change(function(){
		        var cabs = $('#Tupcabscaid').children('option:selected').val();
		        var serid= $('#saleOrderNum').val();
		        if(cabs!=0){
		           if(serid!=""){
			        e.autoAllotSpase((cabs+","+serid),function(resut){
			          // alert(resut);
			           var arr = new Array();
			           arr=resut.split(",");
			           if(arr[1]=='no'){
			              $('#Tupcabscaid').next().html(arr[0]);
			           }else{
				  //         $('#Tupcabscaid').next().html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				           $('#marknums').val(resut);
				           $('#aaa').html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				           $('#tx1').val(arr[0]);
				           $('#tx2').val(arr[1]);
				        }
			        });
			        }else{
			             alert("请选择销售订单号");
			       }
			    }
		   });
		});
		
		
		function edit(){
	//	   checkForm();
		   form1.submit();
		}
		
		function back(){
		   window.history.go(-1);
		}
		
		//提交时,对表单数据进行验证
		function checkForm(){
		   var uptime = $("#uptime").val();
		   if(uptime=="" && uptime.length<=0){
		      $("#sjsj").html("请填写上架时间");
		      return false;
		   }else{
		      $("#sjsj").html("");
		   }
		   
		   var downtime = $("#downtime").val();
		   if(downtime.length<=0 && downtime==""){
		      $("#xjsj").html("请填写下架时间");
		      return false;
		   }else{
		      $("#xjsj").html("");
		   }
		   
		   var address = $("#serverIp").val();
		   if(address.length<=0 && address==""){
		      $("#ipdz").html("请填写IP地址");
		      return false;
		   }else{
		      $("#ipdz").html("");
		   }
		   
		   
		  var jhj = $("#jhj").val();
		  if(jhj.length<=0 && jhj==""){
		      $("#jq").html("请输入交换机名称");
		      return false;
		   }else{
		      $("#jq").html("");
		   }
		   
		   var electHouse = $("#tuphouse").val();
		   if(electHouse<=0 && electHouse==""){
		      $("#jf").html("请选择机房&房间");
		      return false;
		   }else{
		      $("#jf").html("");
		   }
		   
		   var cabinet = $("#Tupcabscaid").val();
		   if(cabinet==0){
		      $("#jg").html("请选择机柜");
		      return false;
		   }else{
		      $("#jg").html("");
		   }
		   
		   var port = $("#port").val();
		   if(port.length<=0 && port==""){
		      $("#dk").html("请输入端口号");
		      return false;
		   }else{
		       $("#dk").html("");
		   }
		   
		   form1.submit();
		   
		}
</script>


  <body>
    <div class="dow_top"> <span><a href="javascript:void(0);">×</a></span> 编辑运维单 </div>
    
<form action="editFault.do" method="post" id="form1" onsubmit="return checkForm();">
<table width="100%" height="540" border="0" cellspacing="0" cellpadding="0" class="border_grey">
  <tr>
    <td><table align="center" width="98%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="59%" class="tab_bottom">
          <input type="hidden" name="operate.id" value="${operate.id }"/>
                          上架单号:${operate.upserver.upNo}
        </td>
        <td width="41%" class="tab_bottom">&nbsp;运维单号:${operate.operateNo}</td>
      </tr>
      <tr>
        <td class="tab_bottom">销售订单号:
           ${operate.saleOrders.soNums}
		   <input type="hidden" id="saleOrderNum" value="${operate.saleOrders.soId}"/>
        </td>
        <td class="tab_bottom">&nbsp;上架人员:${operate.employee.name}</td>
      </tr>
      <tr>
        <td class="tab_bottom">上架时间:
          <input type="text" name="operate.uptime" id="uptime" value="${operate.uptime}" onclick="WdatePicker()"/>
          
          <font color="red" size="2">
           <span style="color:red;" id="sjsj" >
           </span>
       </font>
        </td>
        <td class="tab_bottom">&nbsp;下架时间:
          <input type="text" name="operate.downtime" id="downtime" value="${operate.downtime}" onclick="WdatePicker()"/>
          <br/>
          <font color="red" size="2">
           <span style="color:red;" id="xjsj" > 
           </span>
       </font>
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">仓库名称:${operate.depot.name}</td>
        <td class="tab_bottom">&nbsp;商品名称:${operate.product.property.name}</td>
      </tr>
      <tr>
        <td class="tab_bottom">
           IP地址:
           <input type="hidden" id="serverIpNum" value="${operate.upserver.soOrders.ipnum}"/>
		   <input type="text" id="serverIp" name="operate.ipAddress" value="${operate.ipAddress}"/>
		   
		   <c:if test="${operate.housesAndRooms==null}">
		      <input type="button" id="address" value="选择IP" onclick="getAllIps()"/>
		      <br/>
		      <font color="red" size="2">
               <span style="color:red;" id="ipdz" >
               </span>
       </font>
		   </c:if>
		   <c:if test="${operate.housesAndRooms!=null}">
		     
		   </c:if>
			&nbsp;&nbsp;
			<FONT color=#ff0000 id="serverIpMsg"></FONT>
        </td>
        <td class="tab_bottom">
                          交换机:<input type="text" name="operate.jhj" value="${operate.jhj}" id="jhj"/>
          <br/>
          <font color="red" size="2">
           <span style="color:red;" id="jq" > 
           </span>
       </font>
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">机房&房间:
           <c:if test="${operate.housesAndRooms!=null}">
               ${eh.electName}
           </c:if>
           
           <c:if test="${operate.housesAndRooms==null}">
	           <select id="tuphouse" name="operate.housesAndRooms">
				<option value="${upserver.housesAndRooms }"
				 selected="selected">
			     ${upserver.housesAndRoomsID }
			    </option>
			   </select>
			   
			   <font color="red" size="2">
           <span style="color:red;" id="jf" > 
           </span>
       </font>
		   </c:if>
        </td>
        <td class="tab_bottom">&nbsp;机柜:
           
           <input type="hidden" name="operate.markNum" id="marknums" value="${operate.markNum}"/>
           
           <c:if test="${operate.housesAndRooms!=null}">
              ${cab.caname}
           </c:if>
           
           <c:if test="${operate.housesAndRooms==null}">
				<select
				 onblur="checkValueByRules('Tupcabscaid','','cabids')"
				 id="Tupcabscaid" name="operate.jgh" onclick="funshow()">
				 <c:forEach items="${allcabnt }" var="ct">
				 <option value="${ct.caid }"
				 <c:if test="${upserver.jgh==ct.caid }">selected</c:if>>
				 ${ct.caname}
				 </option>
				 </c:forEach>
				</select>
			<br/>	
		    <font color="red" size="2">
             <span style="color:red;" id="jg" > 
             </span>
            </font>
			</c:if>
		<span id="aaa"></span>
        </td>
      </tr>
      <tr>
        <td class="tab_bottom">
                          端口号:<input type="text" name="operate.port" value="${operate.port}" id="port"/>
         <font color="red" size="2">
           <span style="color:red;" id="dk" > 
           </span>
       </font>
        </td>
        <td class="tab_bottom">&nbsp;备注:
          <textarea rows="5" cols="5" name="operate.temp" style="width: 100px;height: 30px;">${operate.temp}</textarea>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <br /><table width="100%"  height="50" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="41%"></td>
              <td width="10%">
              <c:if test="${operate.housesAndRooms==null}">
                <div class="gb_btl" onclick="javascript:checkForm();">提交</div>
              </c:if>
              <c:if test="${operate.housesAndRooms!=null}">
                <div class="gb_btl" onclick="javascript:back();">返回</div>
              </c:if>
              </td>
              <td width="49%"></td>
              </tr>
          </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>

  </body>
</html>
