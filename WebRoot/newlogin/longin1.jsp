<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
 <%
  		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0); 
	    System.out.println("cookieTest");
	    Cookies cookie=new Cookies();
	  //  cookie.removeCookie(response, "employeeName");
		//			cookie.removeCookie(response, "employeeId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang=zh-cn>
<head>
<meta charset=GBK>
<title>PORTAL系统网页版</title>
<html lang=zh-cn>
<head>

<title>PORTAL系统网页版</title>
<!-- 文档的头部区域的标题。这里要注意，这个title的内容对于SEO来说极其重要-->
<!--[if IE 9]><meta name=ie content=9><![endif]-->
<!-- 文档的头部区域的兼容性写法 -->
<!--[if IE 8]><meta name=ie content=8 ><![endif]-->
<!-- 文档的头部区域的兼容性写法 -->

<!--[if IE 6]>
    <script src="js/DD_belatedPNG_0.0.8a.js"></script>
    <script> DD_belatedPNG.fix('.fixPng'); </script>
<![endif]-->


<head> 
<base href="<%=basePath%>">
<meta name=登录入口口>
<meta name=欢迎来到PORTAL系统登录入口>
		<script type="text/javascript" src="<%=path %>/newlogin/js/changeImg.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<link href="<%=path %>/newlogin/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
   function  subclick1(){
  	 var event=arguments.callee.caller.arguments[0]||window.event;
  	 //alert(event.keyCode);
  	 if (event.keyCode == 13) {
   var va=$("#loginName").val();
  	 	zhanghaoyz(va);
  	 } 
  }  
    function  subclick2(){
    
  	 var event=arguments.callee.caller.arguments[0]||window.event;
  	 //alert(event.keyCode);
  	 if (event.keyCode == 13) {
  	var vb=$("#password").val();
  	
  	 pwdyz(vb);
  	 } 
  }  
    function  subclick3(){
  	 var event=arguments.callee.caller.arguments[0]||window.event;
  	 //alert(event.keyCode);
  	 if (event.keyCode == 13) {
  	 var vc=$("#ValCode").val();
  	 	vayzm(vc);
  	 } 
  }  
    function  subclick4(){
     	 var event=arguments.callee.caller.arguments[0]||window.event;
     	 //alert(event.keyCode);
     	 if (event.keyCode == 13) {
     	 var vc=$("#ValCode").val();
     	 tj();
     	 } 
     }  
function tj(){
document.forms[0].action="potalsLogin.do";
	document.forms[0].submit();


}
function zhanghaoyz(va){
	$("#img11 ").hide();
 $("#yzm").hide();
     if(va==""){
     $("#messagename").show();
     $("#messagename").text("用户名不能为空！");
     
     }else{
      $("#messagename").hide();
      $.ajax({
       	     url:'valloginNameorpwdLogin.do',
       	     type:'post',
       	     data:{loginname:va},
       	     success:function(res){
       	   
       	       if(res=="nologinname"){
       	       		$("#messagename").show();
       	            $("#messagename").text(" 用户名错误或者不存在！");
       	       }else{
       	       	
       	           $("#img11").show();
       	         $("#password").focus();
       	       }
      	     }
     
      });
      
     }
}
function pwdyz(vb){
	 
$("#img22 ").hide();
 
	 var va=$("#loginName").val();
	 if(va==""){
	  $("#messagename").show();
     $("#messagename").text("用户名不能为空！");
     return;
	 }
     if(vb==""){
     $("#messagepwd").show();
     $("#messagepwd").text("密码不能为空！");
     
     }else{
      $("#messagepwd").hide();
        $.ajax({
       	     url:'valloginNameorpwdLogin.do',
       	     type:'post',
       	     data:{loginname:va,loginpwd:vb},
       	     success:function(res){
       	     
       	       if(res=="nologinname"){
       	            $("#messagename").text("用户名错误或者不存在！");
       	       
       	       }else if(res=="rongpwd"){
       	       $("#messagepwd").show();
       	       $("#messagepwd").text("密码不正确！");
       	        $("#yzm").hide();
       	       }else{
           	       
       	          $("#img22").show();
       	   	 	 $("#yzm").show();
       	   	 	   $("#ValCode").focus();
       	    	 $("#img1").hide();
       	       }
       	     
       	     
       	     }
      
      
      
      });
      
     }


}
function vayzm(vc){
	 $("#img1").hide();
 var va=$("#loginName").val();
 var vb=$("#password").val();
  $.ajax({
       	     url:'valloginNameorpwdLogin.do',
       	     type:'post',
       	     data:{loginname:va,loginpwd:vb,yzm:vc},
       	     success:function(res){
       	     
       	       if(res=="nologinname"){
       	            $("#messagename").text("用户名错误或者不存在！");
       	       
       	       }else if(res=="rongpwd"){
       	       $("#messagepwd").show();
       	       $("#messagepwd").text("密码不正确！");
       	        $("#yzm").hide();
       	       }else if(res=="showyzm"){
       	   	  		$("#yzm").show();
       	       }else if(res=="rongyzm"){
       	       				
       	          $("#messageyzm").text("验证码不正确！");
       	       $("#yzm").show();
       	    $("#img1").hide();
       	       }else{
       	       $("#yzm").hide();
       	       $("#img1").show();
       	      }
       	     
       	     
       	     
       	     }
      
      
      
      });




}
	function init(){
	document.all("loginName").focus();
	loaction.href="dingwei";
}
window.onload=init;
</script>


<meta name=登录入口口>
<meta name=欢迎来到PORTAL系统登录入口>
<body>
<div id="body_sec">
    <div class="sec_header">
         <img src="<%=path %>/newlogin/images/bg_06.png" class="fixPng" alt="PROTAL登陆系统" title="PROTAL登陆系统" style="margin-top:250px;" />
    </div>
    <div class="sec_footer">
       <div class="sec_cent">
          <form name="denglu" method="post" id="user_form" ation="potalsLogin.do"> 
			  <% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
        <a name="#dingwei"></a> <div id="yzm" class="yzm" style="display: none;top:77%;left:50%;position:fixed;z-index:100002;">
			 	<img src="<%=imgpath%><%=request.getContextPath() %>/servlet/Img"/><!-- 插入验证码文件 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input  type="text" size="20" name="ValCode"  onchange="vayzm(this.value)" onblur="vayzm(this.value)" onkeydown="subclick3()" id="ValCode" style="width:66px;height:21px" form="user_form" />
			 <p id="messageyzm"  class="sec_white" style="color: red;">&nbsp;&nbsp;请输入验证码</p>   
				</div>
				
         <fieldset class="sec_fie">
            <div class="sec_mm">
                 
                <p class="sec_mmi"> <lable><img src="<%=path %>/newlogin/images/bg_03.jpg" style="margin-left:9px;margin-right:9px;margin-top:5px;" />用户名ID：</lable><input type="text" class="sec_inp"  id="loginName"  name="loginName" onkeydown="subclick1()" form="user_form" pattern="[a-zA-Z0-9]{6-15}"  placeholder="请输入您的帐号"  onblur="zhanghaoyz(this.value)"/><img id="img11" src="<%=path %>/newlogin/images/zhgl_v.png" style="display: none"/></p> 
                 <p id="messagename"  class="sec_white" style="display: none;color: red;"></p>        
              </div> 
                    <div class="sec_mm">
                   <p class="sec_mmi"> <lable><img src="<%=path %>/newlogin/images/bg_04.jpg" style="margin-left:10px;margin-right:10px;margin-top:7px;" />密&nbsp;码PWD：</lable><input type="password"  autofocus="autofocus" id="password"  onkeydown="subclick2()" name="password" class="sec_inp" form="user_form" placeholder="请输入您的密码"   pattern="[A-z9-0]{6-16}"  onblur="pwdyz(this.value)" /><img id="img22" style="display: none" src="<%=path %>/newlogin/images/zhgl_v.png" /></p>
                 <!-- <p class="sec_white"><a href="#">忘记密码?</a></p> -->  <p id="messagepwd"  class="sec_white" style="display: none;color: red;"></p>            
              </div> 
              <div class="sec_an"><a href="javascript:void(0)"><img  src="<%=path %>/newlogin/images/bg_02.jpg" form="user_form"  id="img1" width="100" height="30" class="img_tj"  onkeydown="subclick4()"  onclick="tj()" style="display: none"/></a>                 
         </fieldset>         
       </div>
    </div>
</div>
</body>
</html>
