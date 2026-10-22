<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.action.product.AtherproductAction"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    
    <title>填写故障单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


	<script type="text/javascript" src="<%=request.getContextPath()%>/potal/customerService/js/options.js"></script>
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/potal/customerService/js/tuodong.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
	<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
	
  </head>
  <style type="text/css">
body{ width:760px; font-size:14px;}
.font_color_hui {color:#8c8c8c;}
.wzcs {color:#ff6600;}
.wzdh {line-height:25px; font-size:12px;}
.lefttd{ font-size:14px; font-weight:bold; padding-right:5px;}
.wzls {color:#3b8801;}
.cplx{ width:150px;}
.wzym{ width:230px;}
.bottomfont{color:#fe0000; font-size:12px; line-height:35px}
.color_red{ color:#fe0000}
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto;}
.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto;}
.gb_bth{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:50px; line-height:20px; text-align:center; float:left; margin-left:auto; margin-right:auto;}
.gb_bthh{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:75px; line-height:20px; text-align:center; float:left;margin-left:auto; margin-right:auto;}
.cheng{color:#dd731f; font-size:12px;}
.d2{z-index: 100004;position:absolute;left:13%;top:22%;}
.rz_box .list th{ height:35px; background-color:#EDEDED;}
.wbbd { width:760px; border-bottom:1px solid #c6c6c6; border-left:1px solid #c6c6c6; border-right:1px solid #c6c6c6; margin:auto auto 5px auto;}

.tab{ border:8px solid #50a806; margin:120px auto;}
.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:5px;}
.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:5px; margin-right:0px; float:left}
.gb_bthui{ background-color:#7b7b7b;color:#fff; width:80px; line-height:20px; text-align:center; margin-left:5px; }
.font{ font-size:24px; font-weight:bold;color:#456e22}
.font_red{ font-size:12px;color:#ff0101}
.tab{ border:8px solid #50a806; margin:120px auto;height: 200px;width: 400px;}
</style>
  <script type="text/javascript">
    function getProductType(){
      window.location.href="<%=request.getContextPath()%>/goAddFault.do?flag=1";
    }
    
    //快捷选择客户
    function showCur(){
<%--		 $("#addrow1").load("<%=req
	uest.getContextPath()%>/pdm/selectCussalegoods.do");--%>
		$("#myFrames").attr("src","<%=request.getContextPath()%>/pdm/selectCus2Fault.do");
		$("#addrow1").css("display","block");
//		document.getElementById("addrow1").style.display="block";		
	}
	
	//根据产品类型取到问题类别
	function getQuestion(){
	  var cusid = $("#cusid").val();
	  if(null==cusid || cusid==""){
	     alert("请先选择客户!");
	     return;
	  }
	  var type = $("#cplx").val();
	  $.post('<%=request.getContextPath()%>/getQuestionFault.do',{'type':type},function(data){
	     $("#lb").html(data);
	  });
	}
	
	function check(obj){
	  if(obj.checked){
	//     obj.value=1;
	      $("#sure").val("1");
	  }else{
	     obj.value=0;
	     $("#sure").val("0");
	  }
	}
	
	function check2(obj){
	   if(obj.checked){
	      $("#pay").val("1");
	   }else{
	      $("#pay").val("0");
	   }
	}
	
	function check3(obj){
	   if(obj.checked){
	      $("#declare").val("1");
	   }else{
	      $("#declare").val("0");
	   }
	}
	
	//确认手机号码
	function check4(obj){
	   if(obj.checked){
	      $("#tel").val("1");
	   }else{
	      $("#tel").val("0");
	   }
	}
	
	function check5(obj){
	   if(obj.checked){
	      $("#mail").val("1");
	   }else{
	      $("#mail").val("0");
	   }
	}
	
	function subForm(){
	   var cusname = $("#cusname").val();
	   if(cusname.length<=0 && cusname==""){
	      $("#khmc").html("请选择客户名称");
	      return false;
	   }else{
	      $("#khmc").html("");
	   }
	   
	   var cplx = $("#cplx").val();
	   if(cplx==-1){
	      $("#protype").html("请选择产品类型");
	      return false;
	   }else{
	      $("#protype").html("");
	   }
	   
	   var sjhm = $("#phone").val();
	   if(sjhm.length<=0 && sjhm==""){
	      $("#sjhm").html("请填写手机号码");
	      return false;
	   }else{
	      $("#sjhm").html("");
	   }
	   
	   var declare = $("#declare").val();
	   if(declare==0){
	      $("#shengming1").html("请勾选责任声明");
	      return false;
	   }else{
	      $("#shengming1").html("");
	   }
	   
	   var phone = document.getElementById("phone").value;
	    if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){
        $("#sjhm").html("手机号码格式错误!");
        return false;
    }else{
        $("#sjhm").html("");
    }
    
       //确认手机号码
       var tel = $("#tel").val();
       if(tel==0){
          $("#sjhm").html("请确认您的手机号码");
          return false;
       }else{
          $("#sjhm").html("");
       }
	   
	   var yx = $("#email").val();
	   if(yx.length<=0 && yx==""){
	      $("#yxhm").html("请填写邮箱地址");
	      return false;
	   }else{
	     $("#yxhm").html("");
	   }
	   
	   var email = $("#email").val();
	   var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	   if(!myreg.test(email)){
	     $("#yxhm").html("请填写有效的邮箱!");
	     return false;
	   }else{
	     $("#yxhm").html("输入正确!");
	   }
	   
	   //确认邮箱信息
	   var mail = $("#mail").val();
	   if(mail==0){
	      $("#yxhm").html("请确认您的邮箱");
	      return false;
	   }else{
	      $("#yxhm").html("");
	   }
	   
	   var info = $("#info").val();
	   if(info.length<=0 && info==""){
	      $("#wtms").html("请填写问题描述");
	      return false;
	   }else{
	      $("#wtms").html("");
	   }
	   
	   showDIV();
	   form1.submit();
	   
	}
	
	//验证邮箱
	function checkEmail(){
	  var mail = document.getElementById("email").value;
	  var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	  if(!myreg.test(mail)){
	     $("#yxhm").html("请填写有效的邮箱!");
	     document.getElementById("email").focus();
	  }else{
	     $("#yxhm").html("输入正确!");
	  }
	}
	
	//验证电话号码
	function checkPhone(){
	   var phone = document.getElementById("phone").value;
	    if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){
        $("#sjhm").html("手机号码格式错误!");
        document.getElementById("phone").focus();
    }else{
        $("#sjhm").html("输入正确!");
    }
	}
	
	//点击提交按钮,显示遮挡层
	function showDIV(){
	   $("#sqm").val("");
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
	}
	
	//关闭遮挡层
	function closeDIV(){
	   window.location.href="goAddFault.do";
	}
	
	//反馈上级
	function close(){
	  window.history.go(-1);
	}
	
	//验证授权码
		function yanzheng(){
		   var sqm = $("#sqm").val();
		   if(sqm=="" || sqm==null){
		     alert("请输入授权码!");
		     return;
		   }
		       if(sqm=="fuaotech"){
		         $("#layer").hide();
		         $("#smallLay").hide();
		         form1.submit();
		//         subForm();
		//         checkEmail();
		       }else{
		         alert("授权码不存在,请重新输入...");
		         $("#sqm").val("");
		       }
		}
		
		//发送授权码
		function getSqm(){
		  alert("授权码为:fuaotech");
		}
		
		//获取IP/账号
	   function getIp(){
	      var cusid = $("#cusid").val();
	      var orderType = $("#cplx").val();
	      $.post('getorderlist2Fault.do',{'cusid':cusid,'orderType':orderType},function(data){
	          if(data!=1){
	            $("#ipCard").html(data);
	          }
	          if(data==1){
	            var result = "<option value='-1'>没有查询到IP地址</option>";
	            $("#ipCard").html(result);
	          }
	      });
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
	//隐藏下拉框
//	for(var i=0;i<sel.length;i++){        
//	sel[i].style.visibility="hidden";
//	}
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
	
	//隐藏遮挡层
	function hideid(idname){
	var isIE = (document.all) ? true : false;
	var isIE6 = isIE && ([/MSIE (\d)\.0/i.exec(navigator.userAgent)][0][1] == 6);
	var newbox=document.getElementById(idname);
	newbox.style.zIndex="9999";
	newbox.style.display="none"
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
	//隐藏下拉框
//	for(var i=0;i<sel.length;i++){        
//	sel[i].style.visibility="hidden";
//	}
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
	layer.onclick=function(){newbox.style.display="none";layer.style.display="none";for(var i=0;i<sel.length;i++){
	sel[i].style.visibility="visible";
	}}
	}
</script>
  
  <body>
    <div class="wzdh"> <span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;客服中心&gt;</span><span class="wzcs">代客填写故障单</span> 
</div>

<form action="<%=request.getContextPath()%>/addConFault.do" method="post" id="form1" onsubmit="return subForm();">
<table width="100%" border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td width="21%" align="right" class="lefttd"><span class="color_red">*</span> 客户名称</td>
    <td colspan="2"><label for="textfield"></label>
      <table width="50%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td width="30%">
           <input type="text" name="co.customer.customerName" id="cusname"  class="cplx" onclick="showCur();"/>
           <input type="hidden" id="cusid" name="co.customer.customerId" value=""/><br/>
           <font color="red" size="2">
           <span style="color:red;" id="khmc" >
          
           </span>
           </font>
        </td>
        <td width="20%"><div class="gb_bthh"><a style="text-decoration:none;color: white;" href="javascript:showCur();">快捷选择</a></div></td>
      </tr>
  </table></td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 产品类型</td>
    <td width="33%"><label for="select"></label>
      <select name="co.proudcotType.id" class="cplx" id="cplx" onchange="getQuestion()" onblur="getIp()">
        <option value="-1">请选择</option>
        <c:forEach items="${orderType}" var="type">
          <option value="${type.id}">${type.questionName}</option>
        </c:forEach>
      </select><br/>
      <font color="red" size="2">
           <span style="color:red;" id="protype" >
            
           </span>
       </font>
    </td>
    <td width="46%">&nbsp;</td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 问题类别</td>
    <td>
      <SELECT NAME="co.issueType.questioncategory.id" class="cplx" id="lb">
        
      </SELECT>
    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" class="lefttd">
      <span class="color_red">*</span> 请勾选确认
    </td>
    <td colspan="2">
    <input type="checkbox" id="checkbox" onclick="check(this)" value="0"/>
    <input type="hidden" name="co.sure" id="sure" value="0"/>
      <span class="cheng">请确认您提交的产品类型与问题类别，否则不予处理</span>
    </td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> IP/账号</td>
    <td>
    <select name="ipCart" class="cplx" id="ipCard">
       
    </select>
    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" class="lefttd">是否支付费用</td>
    <td colspan="2"><input type="checkbox" id="checkbox2" onclick="check2(this)"/> 
    <input type="hidden" id="pay" name="co.ispay" value="0"/>
      <span class="cheng">产生费用</span></td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 负责声明</td>
    <td colspan="2">
      <input type="checkbox" id="checkbox3" onclick="check3(this)"/>
      <input type="hidden" id="declare" name="co.isdeclare" value="0"/>
      <span class="cheng">对于会员号下所要求的任何操作而引起的任何影响，我公司均不承担任何责任</span>
     <br/>
      <font color="red" size="2">
           <span style="color:red;" id="shengming1" >
            
           </span>
      </font>
      
      </td>
      
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 手机号码</td>
    <td colspan="2">
      <input type="checkbox" name="shouJiHaoMa" id="checkbox4" onclick="check4(this)"/> 
      <input type="hidden" id="tel" name="" value="0"/>
      <span class="cheng">请确认手机号码，方便及时跟您短信回复</span>
      <input type="text" name="phone" id="phone" value="" onblur="checkPhone()" class="cplx"/>
      
      <font color="red" size="2">
           <span style="color:red;" id="sjhm" >
              
           </span>
       </font>
      </td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 邮箱号码</td>
    <td colspan="2">
      <input type="checkbox" name="youXiangHaoMa" id="checkbox5" onclick="check5(this)"/>
      <input type="hidden" id="mail" name="" value="0"/>
      <span class="cheng">请确认邮箱号码，方便及时跟您短信回复</span>      
      <input type="text" name="co.email" id="email"  class="cplx"/>
      <font color="red" size="2">
           <span style="color:red;" id="yxhm" >
            
           </span>
      </font>
      </td>
  </tr>
  <tr>
    <td align="right" class="lefttd">网站域名</td>
    <td><input name="co.wdnr" type="text"  class="wzym" id="textfield2"/></td>
    <td class="cheng">方便技术们第一时间处理进的问题</td>
  </tr>
  <tr>
    <td align="right" valign="top" class="lefttd"><span class="color_red">*</span> 问题描述</td>
    <td><label for="textfield3"></label>
    <textarea name="co.descs" rows="5" class="wzym" id="info"></textarea><br/>
    <font color="red" size="2">
           <span style="color:red;" id="wtms" >
            
           </span>
    </font>
    </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    
</table>
</td>
  </tr>
  </table>
  </form>
  <div class="wbbd">
<div class="rz_box">
	<div class="title" >上传附件</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
     <tr>
       <td width="13%">&nbsp;</td>
       <td width="77%" align="right">
          <jsp:include page="uploadfile.jsp"></jsp:include>
       </td>
       <td width="10%">&nbsp;</td>
     </tr>
   </table>
</div>
</div>
<table align="center">
   <tr>
    <td>&nbsp;</td>
    <td colspan="2"><table width="57%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50%">
           <div class="gb_bt"><input type="button" value="提交" id="subbtn" class="gb_bt" onclick="subForm()"/></div>
        </td>
       
      </tr>
    </table>
     
    </td>
  </tr>
</table>
  
  <!-- 列出所有客户的div -->
  <div id="addrow1" class="d2" style="display: none;">
	<iframe frameborder="0"  scrolling="no" marginheight="0" marginwidth="0" id="myFrames" src="" style="width:623px;height:410px;"></iframe>
  </div>
  
  <!-- 遮挡层 -->
  <div id="smallLay" style="display:none;">
     
     <div style="background-color: white; height: 200px;width: 400px;border-color: red;top: 100px;">
     <table align="center" class="tab">
      <tr>
        <td colspan="2" align="center" class="font">
            授权码验证
        </td>
      </tr>
      
	  <tr>
    <td colspan="2" align="center">请输入授权码：
      <label for="textfield"></label>
    <input type="text" name="textfield" id="sqm" /></td>
  </tr>
	   <tr>
    <td width="133" align="center"><div class="gb_btl"><a style="text-decoration:none;color: white;" href="javascript:yanzheng();">验证</a></div></td>
    <td width="157" align="center"><div class="gb_btr"><a style="text-decoration:none;color: white;" href="javascript:closeDIV();">取消</a></div></td>
  </tr>
	  <tr>
	    <td colspan="2" align="center"><font color="red">提示:没有收到授权码,点击再次<a href="javascript:getSqm();">获取</a>授权码</font></td>
	  </tr>
	 </table>
	 </div>
</div>
  
  </body>
</html>
