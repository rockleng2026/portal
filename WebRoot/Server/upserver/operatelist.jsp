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
		<title>填写上架单</title>
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
		 //点击选择仓库按钮,弹出层
		 function showck(){
		   document.getElementById('light').style.display='block';
		   document.getElementById('fade').style.display='block'
		 }
		 
		 
		 //点击编辑,得到详细信息,并对运维单的数据完善
		 function editOperate(obj){
		    window.location.href="<%=request.getContextPath()%>/getOperatesUpserver.do?opid="+obj;
		    
		 }
		 
		 //点击详细信息,查看
		 function showOperate(obj){
		   window.location.href="<%=request.getContextPath()%>/showOperateUpserver.do?opid="+obj;
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
	
	
	填写运维单
	<!-- 遮罩层  -->
<div style="position:absolute;display:none; left:0px; top:0px;" id="tranDiv">
<div style="position:absolute;left:0px; top:0px; width:100%; height:100%;background-color:#000000;filter:alpha(Opacity=30)" id="tranDivBack"> </div> 
<div align='center'style='position:absolute;left:0px; top:0px; width:100%; height:100%; background-color:#e5edf5;background-image:url(images/bestnetqywimg/tccbg.gif);'  id='infoDiv'></div> 
</div> 



<!--层遮罩部分结束  addPurchaseOrder.do-->
	<!-- onsubmit="return checkForms()" -->
		<FORM name=form1 action="" method="post">
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
										
										<c:if test="${upserver==null}">
										&nbsp;填写运维单(带*号的为必填项)
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
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="13%" height=30 class=category>
											编号
										</TD>
										<TD width="10%" class=category>
											运维单号
										</TD>
										<TD width="8%" class=category>
											上架单号
										</TD>
										<TD width="10%" class=category>
											上架人员
										</TD>
										<TD width="6%" class=category>
											上架时间
										</TD>
										<TD width="8%" class=category>
											仓库名称
										</TD>
										<TD width="8%" class=category>
											商品名称
										</TD>
										<td width="10%" class=category>
										         操作
										</td>
									</TR>


									<!--循环-->
                             
									<c:forEach items="${oplist}" var="operate" >
											<TR>
												<TD align=middle>
												  
												  ${operate.id}
												</TD>
												<TD align=middle>
												  ${operate.operateNo}
												</TD>
												<TD align=middle>
												  <input type="hidden" id="" value="${operate.upserver.id}"/>
												  ${operate.upserver.upNo}
												</TD>
												<TD align=middle>
												  ${operate.employee.name}
												</TD>
												<TD align=middle>
												  ${operate.uptime}
												</TD>
												<TD align=middle>
											      ${operate.depot.name}
												</TD>
												<TD align=middle>
											      ${operate.product.property.name}
												</TD>
												<TD align=middle>
												 <c:if test="${operate.housesAndRooms==null}">
												   <a href="javascript:editOperate(${operate.id})">编辑</a>
												 </c:if>
												 <c:if test="${operate.housesAndRooms!=null}">
												   <a href="javascript:showOperate(${operate.id})">详细信息</a>
												 </c:if>
												</TD>
											</TR>
										</c:forEach>
										<tr>
					 					 <td id="page" colspan="8"><p:pages url="selectoperateUpserver.do?funid=14" /></td>
					                    </tr>
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
<div>
<hr color="red" style="width: 100%;"/>
</div>
<div id="">
  <table id="">
   
  </table>
</div>
 </div>
<div id="fade" class="black_overlay"></div>
   
	</BODY>
</HTML>
