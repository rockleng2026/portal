<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
	
	
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
</style>
  <script type="text/javascript">
    function getProductType(){
      window.location.href="<%=request.getContextPath()%>/goAddFault.do?flag=1";
    }
    
    //快捷选择客户
    function showCur(){
<%--		 $("#addrow1").load("<%=req
	uest.getContextPath()%>/pdm/selectCussalegoods.do");--%>
		$("#myFrames").attr("src","<%=request.getContextPath()%>/pdm/selectCussalegoods.do?flag=1");
		$("#addrow1").css("display","block");
//		document.getElementById("addrow1").style.display="block";		
	}
	
	//根据产品类型取到问题类别
	function getQuestion(){
	  var type = $("#cplx").val();
	  $.post('<%=request.getContextPath()%>/getQuestionFault.do',{'type':type},function(data){
	     $("#lb").html(data);
	  });
	  var d = "<option value='-1'>您没有此项业务</option>";
	  $("#ipCard").html(d);
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
	   
	   var phone = document.getElementById("phone").value;
	    if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){
        $("#sjhm").html("手机号码格式错误!");
        return false;
    }else{
        $("#sjhm").html("输入正确!");
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
	   
	   var info = $("#info").val();
	   if(info.length<=0 && info==""){
	      $("#wtms").html("请填写问题描述");
	      return false;
	   }else{
	      $("#wtms").html("");
	   }
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
	
  </script>
  <body>
    <div class="wzdh"> <span class="wzls">&nbsp;&nbsp;您的位置</span><span class="font_color_hui">：首页&gt;客服中心&gt;</span><span class="wzcs">代客填写故障单</span> 
</div>

<form action="<%=request.getContextPath()%>/addConFault.do" method="post" id="form1" onsubmit="return checkFormData();">
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
      <select name="co.proudcotType.id" class="cplx" id="cplx" onchange="getQuestion()">
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
    <td align="right" class="lefttd"><span class="color_red">*</span> IP/账号</td>
    <td>
    <select name="zhangHao" class="cplx" id="ipCard">
      
    </select>
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
    <td align="right" class="lefttd"><span class="color_red">*</span> 问题类别</td>
    <td>
      <select name="co.issueType.questioncategory.id" class="cplx" id="lb">
        
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
      <span class="cheng">对于会员号下所要求的任何操作而引起的任何影响，我公司均不承担任何责任</span></td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 手机号码</td>
    <td colspan="2"><input type="checkbox" name="shouJiHaoMa" id="checkbox4" /> 
      <span class="cheng">请确认手机号码，方便及时跟您短信回复</span>
      <input type="text" name="co.customerphone" id="phone" onblur="checkPhone()" class="cplx"/>
      
      <font color="red" size="2">
           <span style="color:red;" id="sjhm" >
              
           </span>
       </font>
      </td>
  </tr>
  <tr>
    <td align="right" class="lefttd"><span class="color_red">*</span> 邮箱号码</td>
    <td colspan="2"><input type="checkbox" name="youXiangHaoMa" id="checkbox5" />
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
           <div class="gb_bt"><input type="button" value="提交" class="gb_bt" onclick="subForm(),checkEmail()"/></div>
        </td>
        <td width="50%">
        <div class="gb_bt">
         <input type="button" value="取消" class="gb_bt" onclick="javascript:history.go(-1);"/></div>
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
  
  
  </body>
</html>
