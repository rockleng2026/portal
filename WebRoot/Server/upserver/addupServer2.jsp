<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ page import="com.fuao.fajxc.vo.UpServer,com.fuao.fajxc.vo.Product,java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新增上架单22</title>
		<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/interface/e.js'></script>
    	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
   		<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.3.2.min.js" ></script>
		
		<style type="text/css">
			#div1{width:250px;height:30px; border:1px solid #C60; position:relative;}
			ul{ list-style:none; background-color:#D7FFEE; margin:0; padding:0; position:absolute;top:30px;left:5px; border:1px solid #C60;width:250px; display:none;}
			#div1 p{ float:right;font-size:12px; width:40px; cursor:pointer;}
		</style>
		
		<style>
	     .black_overlay{  display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.8;  opacity:.80;  filter: alpha(opacity=30);  }  
	     .white_content {  display: none;  position: absolute;  top: 15%;  left: 25%;  width: 50%;  height: 70%;  padding: 16px;  border: 1px solid orange;  background-color: #ADFEDC;  z-index:1002;  overflow: auto;  }  
	    </style>
		
		
		<style type="text/css">
		 .hidden{display:none;}
		 #smallLay{width:300px; height:200px;padding:4px 10px 10px;background-color:#FFFFFF;border:1px solid #05549d;color:#333333;line-height:24px;text-align:left;-webkit-box-shadow:5px 2px 6px #000;-moz-box-shadow:3px 3px 6px #555;}
	    </style>
		<script type="text/javascript">
		function checkonipnum()
		{
		    var n;
			var ipnum=document.getElementById("serverIpNum").value;
			var serip=document.getElementById("serverIp").value;
			if(serip==null || serip==""){
				document.getElementById("serverIpMsg").innerHTML="请选择IP地址！"; 
			}else{
			//alert("serip="+serip);
			var arr=new Array();
			arr=serip.split(",");
		    alert("serip="+arr[1]);
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
		function getstoresId(){
		      sers = $('#serverLocation').val();
		      //alert("ss="+sers);
		      e.loadservers((sers+""),function(pms){
		              $('#productids').empty();
		              var ppt = '<option value="0">请选择</option>'
		             if(pms!=""){
		               $('#productids').append(ppt);
		               $('#productids').append(pms);
		             }else{
		              $('#productids').append(ppt);
		             }
		      });
		}
		
		
		//上架单时对输入的IP进行验证
		function checkip(){
		  var ip =$('#serverIp').val();
		  $.post('checkIPUpserver.do',
		         {serverIp:ip},
		         function(result){
		         if(result=='ERROR'){
		           alert("IP已存在,不能重复添加!");
		         }
		         });
		}
		function getAllIps(){
		     //alert("ips");	
		    var str= window.showModalDialog("./serm/pager/showIPs.jsp","选择IP号","height=300,width=600,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no,edge=sunken"); 
		     $('#serverIp').val(str);
		     checkonipnum();
		}
		  
		 function checkForms(){
		  
		       if($('#saleOrderNum').val()==""){
		          $('#saleNoMsg').html("销售定单不能为空");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		           return false;
		       }else if($('#serverLocation').val()==0){
		       $('#liip').show();
		       $('#liip').html("仓库位置不能为空");
		       $('#saleNoMsg').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#productids').val()==0){
		       $('#serverMsg').html("服务器名称不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#uptime').val()==""){
		       $('#upMsg').html("上架日期不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#downtime').val()==""){
		       $('#downMsg').html("下架日期不能为空");
		       $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#serverIpNum').val()==""){
		               $('#serverIpNumMsg').html("IP数不能为空");
		               $('#saleNoMsg').html("");
			          $('#liip').html("");
			          $('#serverMsg').html("");
			          $('#upMsg').html("");
			          $('#downMsg').html("");
			          $('#serverIpMsg').html("");
			          $('#bwCountMsg').html("");
			           $('#cabids').html("");
		               return false;
		       }else if($('#serverIp').val()==""){
		        	$('#serverIpMsg').html("Ip地址不能为空");
		        	$('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#bwCountMsg').html("");
		           $('#cabids').html("");
		            return false;
		       }else if($('#bandwidthAmount').val()==""){
		        	$('#bwCountMsg').html("带宽数量不能为空");
		        	$('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		           $('#cabids').html("");
		             return false;
		       }else if($('#Tupcabscaid').val()==0){
		       		 $('#cabids').html("机柜名称不能为空");
		       		 $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		              return false;
		       }else {
		       	  $('#saleNoMsg').html("");
		          $('#liip').html("");
		          $('#serverMsg').html("");
		          $('#upMsg').html("");
		          $('#downMsg').html("");
		          $('#serverIpNumMsg').html("");
		          $('#serverIpMsg').html("");
		          $('#bwCountMsg').html("");
		          $('#cabids').html("");
		            return true;
		       }
		   }
		</SCRIPT>
		
   <!-- 测试 -->
	<script type="text/javascript">
		window.onload=function()
		{
		    showid('smallLay');
			var oDiv=document.getElementById('div1');
			var oUl=oDiv.getElementsByTagName('ul')[0];
			var oP=oDiv.getElementsByTagName('p')[0];
			var bSwitch=false;
			
			oP.onclick=function()
			{
				if(bSwitch)
				{
					oUl.style.display='none';
					bSwitch=false;
				}
				else
				{
					oUl.style.display='block';
					bSwitch=true;
				}
			};
		};
		
		
		
		
		
	
		
		//选择机房名称,列出机房下的机柜信息
		function getcabinet(){
		  
		  var cabinetid = $("#electhouse").val();
		  $.post('getCabinetUpserver.do',{'cabinetid':cabinetid},function(result){
		      if(result!=null || result!=""){
			     $("#tab3").html("");
			     $("#cabinet").show();
			     $("#tab3").append(result);
		      }
		      if(result==null || result==""){
		         $("#tab3").html("");
			     $("#cabinet").show();
			     $("#tab3").append(result);
		      }
		  });
		}
		
		
		//选择多个机柜
		var cabinetname = "";
		var cabinetid = "";
		var d = "";
		function checkCabinet(check){
		   var caname = check.value;
		   var caid = check.id;
		   //销售订单号
		   var saleorderNo = $("#saleOrderNum").val();
		   if(check.checked==true){
		     
		      if(saleorderNo!=""){
		        $.post('getGhByCabinetUpserver.do',{'cabid':caid,'saleorderNo':saleorderNo},function(data){
		           d = data;
		           $("#abc").append(d+"|");
		        });
		      }
		      cabinetname += caname+",";
		      cabinetid += caid+",";
		      
		   }else if(check.checked==false){
		      cabinetname=cabinetname.replace(caname+",","");
		      cabinetid=cabinetid.replace(caid+",","");
		   }else{}
		   $("#jghid").attr("value",cabinetid);
		   $("#jgh").attr("value",cabinetname);
		   
		        var cabs = $('#Tupcabscaid').children('option:selected').val();
		        var serid= $('#saleOrderNum').val();
		    //    alert(cabs);
		        alert('serid='+serid);
		        if(cabs!=0){
		           if(serid!=""){
			        e.autoAllotSpase((cabs+","+serid),function(resut){
			           alert(resut);
			           var arr = new Array();
			           arr=resut.split(",");
			           if(arr[1]=='no'){
			              $('#Tupcabscaid').next().html(arr[0]);
			           }else{
			                alert(resut);
				    //       $('#Tupcabscaid').next().html('柜号为:<input type="text" id="tx1" size="3" readOnly>-<input type="text" id="tx2" size="3" readOnly>');
				   //        $('#marknums').val(resut);
				           $('#tx1').val(arr[0]);
				           $('#tx2').val(arr[1]);
				        }
			        });
			        }else{
			             alert("请选择销售订单号");
			       }
			    }
		}
		//验证授权码
		function yanzheng(){
		   var sqm = $("#sqm").val();
		   if(sqm==""){
		     alert("请输入授权码!");
		     return;
		   }
		   $.post('checkAuthorizationUpserver.do',{'sqm':sqm},function(result){
		        alert(result);
		       if(result=="1"){
		         $("#layer").hide();
		         $("#smallLay").hide();
		       }else{
		         alert("授权码不存在,请重新输入...");
		         $("#sqm").val("");
		       }
		       
		   });
		}
		
		//用户点击取消,返回上一个页面
		function fanhui(){
		  window.history.go(-1);
		}
</script>

	<script type="text/javascript">
function showid(idname){
	var isIE = (document.all) ? true : false;
	var isIE6 = isIE && ([/MSIE (\d)\.0/i.exec(navigator.userAgent)][0][1] == 6);
	var newbox=document.getElementById(idname);
	newbox.style.zIndex="9999";
	newbox.style.display="block"
	newbox.style.position = !isIE6 ? "fixed" : "absolute";
	newbox.style.top =newbox.style.left = "50%";
	newbox.style.marginTop = - newbox.offsetHeight / 2 + "px";
	newbox.style.marginLeft = - newbox.offsetWidth / 2 + "px";  
	var layer=document.createElement("div");
	layer.id="layer";
	layer.style.width=layer.style.height="100%";
	layer.style.position= !isIE6 ? "fixed" : "absolute";
	layer.style.top=layer.style.left=0;
	layer.style.backgroundColor="#000";
	layer.style.zIndex="9998";
	layer.style.opacity="0.6";
	document.body.appendChild(layer);
	var sel=document.getElementsByTagName("select");
	for(var i=0;i<sel.length;i++){        
	sel[i].style.visibility="hidden";
	}
	function layer_iestyle(){      
	layer.style.width=Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth)
	+ "px";
	layer.style.height= Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight) +
	"px";
	}
	function newbox_iestyle(){      
	newbox.style.marginTop = document.documentElement.scrollTop - newbox.offsetHeight / 2 + "px";
	newbox.style.marginLeft = document.documentElement.scrollLeft - newbox.offsetWidth / 2 + "px";
	}
	if(isIE){layer.style.filter ="alpha(opacity=60)";}
	if(isIE6){  
	layer_iestyle()
	newbox_iestyle();
	window.attachEvent("onscroll",function(){                              
	newbox_iestyle();
	})
	window.attachEvent("onresize",layer_iestyle)          
	}  
	layer.onclick=function(){newbox.style.display="block";layer.style.display="block";for(var i=0;i<sel.length;i++){
	sel[i].style.visibility="visible";
	}}
	}
</script>
	
	
	
	<script type="text/javascript">
	  function checkOldPwd(){
		     var oldpwd = $("#oldpwd").val();
		     var userid=$("#useridPwd").val();
		     var path = $('#pathHid').val();
		     $.ajax({
			     type:"post",
			     url:path+"cms/checkPwdAdmin.do",
			     data:{
				     "oldpwd":oldpwd,
				     "userid":userid
				  },
			     success:function(data){
					 $("#oldpwdtest").html("");
				     if(data==0){
				    	 $("#oldpwdtest").html("密码错误。。。");
				    	 return;
					 }
				 }
			 });
		 }
		 
		 //点击选择仓库按钮,弹出层
		 function showck(){
		   document.getElementById('light').style.display='block';
		   document.getElementById('fade').style.display='block';
		 }
		 
		 //点击工单按钮
		 function gd(){
		   window.location.href="<%=request.getContextPath()%>/workorderlistUpserver.do";
		 }
	</script>
		
		
		

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<%
   Cookies ck = new Cookies();
   String empName =ck.getCookie(request, "employeeName");
		String empId=ck.getCookie(request,"employeeId");
		
 %>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
	
	新增上架单列表2
	<!-- 遮罩层  -->
<div style="position:absolute;display:none; left:0px; top:0px;" id="tranDiv">
<div style="position:absolute;left:0px; top:0px; width:100%; height:100%;background-color:#000000;filter:alpha(Opacity=30)" id="tranDivBack"> </div> 
<div align='center'style='position:absolute;left:0px; top:0px; width:100%; height:100%; background-color:#e5edf5;background-image:url(images/bestnetqywimg/tccbg.gif);'  id='infoDiv'></div> 
</div> 

<%
  List list = (List)request.getAttribute("rows");

 %>


<!--<div id="smallLay" style="display:none;">
     <table align="center">
      <tr>
        <td colspan="2" align="center"><h2><b>授权码验证</b></h2></td>
      </tr>
	  <tr>
		<td align="right"><h3><b>请输入授权码:</b></h3></td>
		<td align="left"><input type="text" name="" id="sqm" style="height: 20px;"/></td>
	  </tr>
	  <tr>
	    <td align="center" colspan="2">
	     <input type="button" id="yz" onclick="yanzheng()" value="验证" style="height: 25px;width: 40px;"/>
	     <input type="button" id="qx" onclick="fanhui()" value="取消" style="height: 25px;width: 40px;"/>
	    </td>
	  </tr>
	  <tr>
	    <td colspan="2" align="center"><font color="red">提示:只有输入正确的验证码才能执行上架操作.</font></td>
	  </tr>
	 </table>
</div>

--><!--层遮罩部分结束  addPurchaseOrder.do-->
	<!-- onsubmit="return checkForms()" -->
		<FORM name=form1 action="
	     	<c:if test="${upserver==null}">addupUpserver.do</c:if>
	         <c:if test="${upserver!=null}">editUpserver.do</c:if>
		" method="post" onsubmit="">
		<input type="hidden" value="${upserver.id }" id="upid" name="id">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
										 <c:if test="${upserver!=null}">
											&nbsp;修改上架单(带*号的为必填项)
										</c:if>
										<c:if test="${upserver==null}">
										&nbsp;新增上架单(带*号的为必填项)
										</c:if>
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border="1" >
							
								<input type="hidden" value="0" name="del" />
								<TBODY>
									<TR>
										<TD width="20%" height=30 align=right>
											上架单号：
										</TD>
										<TD width="30%" class=category>
									    <c:if test="${upserver!=null}">
									    <input type="hidden" name="ups.id" value="${upserver.id}"/>
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="SJNo" name="upNo" value="${upserver.upNo }">
									    </c:if>
									    <c:if test="${upserver==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="SJNo" name="ups.upNo" value="${SJNo }">
										</c:if>
										</TD>
										<TD width="20%" height=30 align=right>
											销售订单号：
										</TD>
										<!--<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules('saleOrderNum','','saleNoMsg')" 
											
											onclick="completemission('getSaleOrderListClientOrder.do?&page=addupServer','')"
											 
											style="WIDTH: 200px"  id="saleOrderNum" name="saleOrder.saleOrderNo" value="${upserver.saleOrder.saleOrderNo}">
											<input id="saleOrderid" name="saleOrder.id"  type="hidden" value="${upserver.saleOrder.id }">
											<FONT color=#ff0000 id="saleNoMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>-->
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules('saleOrderNum','','saleNoMsg')"
											
											onclick="completemission('orderListUpserver.do?&page=addupServer','')"
											 
											style="WIDTH: 200px"  id="saleOrderNum" name="ups.soOrders.soNums" value="${upserver.soOrders.soNums}">
											<input id="saleOrderid" name="ups.soOrders.soId"  type="hidden" value="${upserver.soOrders.soId }">
											<FONT color=#ff0000 id="saleNoMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<tr>
										<td width="20%" height="30" align="right">
											单位名称：
										</td>
										<td  width="30%" class=category>
											<input id="comname" name="ups.soOrders.customer.customerCompany" value="${upserver.customer.customerCompany }"/>
											<input id="comid" name="ups.soOrders.customer.customerId" type="hidden" value="${upserver.customer.customerId }"/>
										</td>
										<td width="20%" height="30" align="right">
											联系人：
										</td>
										<td  width="30%" class=category>
											<input id="linkname" name="ups.soOrders.customer.realName" value="${upserver.customer.realName }"/>
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											联系电话：
										</td>
										<td  width="30%" class=category>
											<input id="phone" name="ups.soOrders.customer.phone" value="${upserver.customer.phone }"/>
										</td>
										<td width="20%" height="30" align="right">
											销售负责人：
										</td>
										<td  width="30%" class=category>
											<!-- <input id="employeename" name="customer.employee.name" value="${upserver.customer.employee.name }"/>
											 -->
											<label id="employeename">${upserver.soOrders.customer.employee.name }</label>
										</td>
									</tr>
									
									
									
								
									<TR>
										<TD   width="20%" align=right height=30>
											Ip数量：
										</TD>
										<TD width="30%" class=category>
											<INPUT readonly="true" onblur="checkValueByRules('serverIpNum',['num'],'serverIpNumMsg')" style="WIDTH: 100px" id="serverIpNum" name="ups.soOrders.ipnum" value="${upserver.soOrders.ipnum }" >
											<FONT color=#ff0000 id="serverIpNumMsg">*</FONT>
										</TD>
										<TD  width="20%" align=right height=30>
											维护口令：
										</TD>
										<TD  width="30%"  class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'MpassMsg')" style="WIDTH: 200px" id="Mpass" name="ups.maintenancePass" value="${upserver.maintenancePass }">
											<FONT color=#ff0000 id="MpassMsg"></FONT>
										</TD>
									</TR>
									<!--<TR>
										<TD width="20%" align=right height=30>
											Ip地址：
										</TD>
										<TD class=category colspan="3">
											<INPUT type="text" style="WIDTH: 200px" id="serverIp" name="ups.serverIp" value="${upserver.serverIp }" />
											<input type="button" value="选择" onclick="getAllIps()"/>请单击”选择“按钮&nbsp;&nbsp;
											<FONT color=#ff0000 id="serverIpMsg"></FONT>
										</TD>
									</TR>
									--><TR>
										<TD   width="20%" align=right height=30>
											带宽数量：
										</TD>
										<TD  width="30%"  class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'bwCountMsg')" style="WIDTH: 200px" id="bandwidthAmount" name="ups.bandwidthAmount" value="${upserver.bandwidthAmount }">
											<FONT color=#ff0000 id="bwCountMsg"></FONT>
										</TD>
			
										<TD  width="20%"  align=right height=30>
											带宽限制：
										</TD>
										<TD   width="30%" class=category>
											<INPUT onblur="checkValueByRules(this,['num'],'bwThroMsg')" style="WIDTH: 200px" id="bandwidthThrottling" name="ups.bandwidthThrottling" value="${upserver.bandwidthThrottling }">
											<FONT color=#ff0000 id="bwThroMsg"></FONT>
											
										</TD>
									</TR>
									<TR>
										<TD  width="20%" align=right>
											上架人员：
										</TD>
										<TD  width="30%" class=category> 
										<c:if test="${empty upserver}">
										<input id="emp" name="ups.employee.name" value="<%=empName %>" onblur="checkValueByRules('emp','','empMsg')" readonly="readonly" >
								            <%--
											<input name="upFlag" type="hidden" value=0 />
											<input name="delflag" type="hidden" value=0 />
											--%>
											<input id="empid" name="ups.employee.id"  type="hidden" value="<%=empId %>" />
											<input name="audtitingFlag" type="hidden" value=0 />  
										</c:if>
											<c:if test="${not empty upserver}">
											<input id="emp"  name="employee.name" value="${upserver.employee.name }" onblur="checkValueByRules('emp','','empMsg')" >
											</c:if>
										</TD>
										
										
										<TD  width="20%" align=right>
											备注：
										</TD>
										<TD  width="30%" class=category> 
											<textarea rows="3" cols="40" id="temp" name="ups.temp">${upserver.temp}</textarea>
										</TD>
										<c:if test="${flag==1}">
										
										</c:if>
										
										<c:if test="${flag==0}">
											<TR>
											<TD width="20%" align=right height=30>
												仓库位置：
											</TD>
											<!-- getstoresId2() -->
											<TD width="30%" class=category>
											  <input type="button" value="选择仓库" onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'"/>
											  <input type="hidden" name="upser" id="upser"/>
											  <input type="hidden" name="depotid" id="depotid"/>
											  </TD>
											  <td align="right">需要上架的商品:</td>
											  <td align="left">
											     <span id="splb"></span>
											  </td>
										    </TR>
									</c:if>
								</tr>
								  
								<tr>		
											<TD class=category align="center" colspan="4">
											<c:if test="${upserver!=null}">
											<input id="empid"  name="ups.employee.id"  type="hidden" value="${upserver.employee.id }" />
											<input name="ups.upFlag" type="hidden" value="${upserver.upFlag }"/>
											<input name="ups.delflag" type="hidden" value="${upserver.delflag }"/>
											<input name="ups.audtitingFlag" type="hidden" value="${upserver.audtitingFlag }"/>
											<input id="proid" type="hidden" name="proid" value=""/>
											</c:if>
											<c:if test="${upserver==null}">
											<input name="ups.upFlag" type="hidden" value="0"/>
											<input name="ups.delflag" type="hidden" value="0"/>
											</c:if> 
											 <c:if test="${upserver==null}">
											  <INPUT class=button type=submit  value="确认添加 ">
											  &nbsp;&nbsp;&nbsp;&nbsp;
										    </c:if>
											<c:if test="${upserver!=null}">
											  <input class="button" type="submit"   value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 "><!--
											&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="button" value="运维单" onclick="ywd()"/>
											<input type="button" value="工单" onclick="gd()"/>
										--></TD>
									</TR>                                  
								</TBODY>
							</TABLE>
							
                       
							
						</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
				<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
			</TABLE>
	
			
			<!-- 弹出层开始 -->
<div id="popLayer" style="display:none">
<span style="padding-left:20px;"><br/><br/>
添加IP &nbsp;&nbsp;
   </span>
 <table>
 <tr><td></td></tr>
 <tr><td align="right" nowrap class="bg0"  nowrap class="bg0" ></td>
  <td style="padding-left:10px;" nowrap class="bg0">
    IP ：<input type="text" name="addIp" id="addIp" value="" />
   </td> 
  </tr>
   <tr><td colspan="2" align="center" nowrap class="bg0">&nbsp;<font color="red" id="addIpMsg"></font></td></tr>
  </table><br/>
    
    <input type="button" id="commend" onclick="return gteCheckedCb();" value="确定"/>
    <input type="button" id="qx" onclick="return closeWindow();" value="取消"/>
    
</div>
<!-- 弹出层结束 -->
			
			<script type="text/javascript"><!--

	var num = $("#serverIpNum").val();
var ipArray = new Array(num);
var i = 0;
//登陆弹出对话框，并使背景元素不可用
function showWindow(){ 
	var spitnum = $("#serverIp").val();
	var spit = spitnum.split(",");
	var num1 = $("#serverIpNum").val();
	if(num1=="")
	{
		alert("请填写IP数量！");
		return false;
	}
	$("#serverIpMsg").html((spit.length-1)+"/"+num1);
	if((spit.length-1)!=num1)
	{
	 var vid = new Array();
 var ckvid = new Array();
location.href="#";
width = 400;
height = 150;
var windowstr= document.getElementById("popLayer").innerHTML;
document.getElementById("infoDiv").innerHTML=windowstr; 
document.getElementById("infoDiv").style.left=((document.body.clientWidth-width)>0?(document.body.clientWidth-width):0)/2+"px"; 
document.getElementById("infoDiv").style.top=150+"px"; 
document.getElementById("infoDiv").style.zIndex=10001;
document.getElementById("infoDiv").style.width=width; 
document.getElementById("infoDiv").style.height=height; 
document.getElementById("infoDiv").style.border="3px solid #0099ff";
document.getElementById("tranDiv").style.height=document.body.clientHeight+ "px"; 
document.getElementById("tranDiv").style.width=document.body.clientWidth+ "px"; 
document.getElementById("tranDiv").style.display=""; 
document.getElementById("tranDivBack").style.display=""; 
document.getElementById("tranDivBack").style.zIndex=10000;
document.getElementById("infoDiv").style.display=""; 
	}
} 
function closeWindow(){ 
document.getElementById("tranDiv").style.display="none"; 
}

function gteCheckedCb()
{
	var num2 = $("#serverIpNum").val();
	var addIp = $("#addIp").val();
	var ips = $("#serverIp").val();
	if(ips=="")
		{
			ipArray[0] = addIp;
			$("#serverIp").append(addIp+",");
			i++;
			$("#serverIpMsg").html(i+"/"+num2);
			closeWindow();
		}
		else
		{
			var flag = true;
			for(var j=0;j<ipArray.length;j++)
			{
				if(ipArray[j]==addIp)
				{
					$("#addIpMsg").html("您输入的重复的IP，请重新输入！");
					flag = false;
					return ;
				}
			}
			if(flag)
			{
				$("#serverIp").attr("value","");
				$("#serverIp").append(ips+addIp+",");
				i++;
				$("#serverIpMsg").html(i+"/"+num2);
				closeWindow();
			}
		}
}
function resetIp()
{
	var num2 = $("#serverIpNum").val();
	$("#serverIp").attr("value","");
	i=0;
	$("#serverIpMsg").html(i+"/"+num2);
}


     function jia(obj){
       var kc = obj.id;
       var kc2 = obj.name;
       var number = parseInt($("#ipt"+obj.id).val());
       if(number>=kc){
         $("#ipt"+obj.id).val(kc);
         
       }else{
         var num = parseInt($("#ipt"+obj.id).val());
         if(number>=kc2){
            alert("库存不足!");
            return;
         }
         $("#ipt"+obj.id).val(num+1);
         $("#box"+obj.id).val(num+1);
         
       }
     }
     
     function jian(obj){
       var kc = obj.id;
       var sl = parseInt($("#ipt"+obj.id).val());
       if(sl<=0){
          $("#ipt"+obj.id).val(0);
       }else{
         var num = parseInt($("#ipt"+obj.id).val());
         $("#ipt"+obj.id).val(num-1);
         $("#box"+obj.id).val(num-1);
       }
     }
     
     
     function gets(){
        var str = "";
        var ckid = $("#cangku").val();
        $.post('cms/storeCount_getAllDatas2.do',{'depotid':ckid},function(data){
             var d = data.substr(0,(data.length)-1);
             if(d==""){
                $("#tab3").html("");
                return;
             }
            
             var array = d.split("|");
             for(var i=0;i<array.length;i++){
                var arr = array[i].split(",");
                   
                   $("#tab3").html("");
                   str+="<tr><td><input type='checkbox' id='box"+arr[0]+"' alt='"+arr[1]+"' class='"+arr[2]+"'  name='checkbox' value='0'></td><td>&nbsp;&nbsp;</td></td><td>"+arr[1]+"</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>库存"+arr[2]+"台</td><td>&nbsp;&nbsp;&nbsp;</td><td><img id="+arr[0]+" src='<%=request.getContextPath()%>/img/nolines_minus.gif' onclick='javascript:jian(this)'/><input type='text' id=ipt"+arr[0]+" style='width:30px;text-align: right;' value='0' readonly='readonly'/><img id="+arr[0]+" name="+arr[2]+" src='<%=request.getContextPath()%>/img/nolines_plus.gif' onclick='javascript:jia(this)'/></td></tr>";
                   $("#tab3").html(str);
             }
        });
     }
     
     function getcheck(){
         var number = "";
         var str="";
         var string = "";
         var proid = "";
         var depotid = $("#cangku").val();
         var upNo = $("#SJNo").val();
          $("input[name='checkbox']:checked").each(function(){
             proid += $(this).attr("id")+",";
             str+=$(this).attr("id")+","+$(this).attr("class")+","+$(this).val()+"-";
             string+="商品:"+$(this).attr("alt")+"  数量:"+$(this).val()+",";
             number += $(this).val()+",";
		  })
		  
		  
		  $("#upser").val(str);
		  $("#depotid").val(depotid);
		  $("#splb").html(string);
		  $("#divfloat").hide();
		  $("#proid").val(proid);
		  
		  //冻结商品
		  $.post('<%=request.getContextPath()%>/freezeProductUpserver.do',{'proid':proid,'upNo':upNo,'number':number},function(result){
		     	if(result=="SUCCESS"){
		     	  alert("您选中的商品已冻结!");
		     	}  
		  });
		  document.getElementById('light').style.display='none';
		  document.getElementById('fade').style.display='none';
     }
     
     function ywd(){
       window.location.href="<%=request.getContextPath()%>/selectoperateUpserver.do";
     }
     
</script>
</FORM>
<div id="divfloat" ></div>
   
   <div id="light" class="white_content">
<div style="position: absolute;top:1px;left:600px;" id="close">
   <a href="javascript:void(0)" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><h3>关闭</h3></a></div>
<table align="center"><tr><td><h2>服务器上架</h2></td></tr></table>
<div>
<table align="left"> 
  <tr>
    <td>请选择仓库位置:
    </td>
    <td>
    <select id="cangku" onchange="gets()">
    <option value="-1">请选择</option>
      <c:forEach items="${depotlist}" var="s">
        <option value="${s.id }">${s.name }</option>
      </c:forEach>
    </select>
    </td>
  </tr>
  <tr>
     <td colspan="2" align="right"><input type="button" onclick="getcheck()" value="确定"/></td>
  </tr>
</table>
</div>

<br/>
<br/>
<br/>
<br/>
<br/>
<div>
<hr color="red" style="width: 100%;"/>
</div>
<div id="myservers">
  <table id="tab3">
   
  </table>
</div>
 </div>
<div id="fade" class="black_overlay"></div>
   

	</BODY>
</HTML>
