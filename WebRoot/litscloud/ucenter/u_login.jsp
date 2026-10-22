<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.fuao.fajxc.vo.Customer"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<style type="">
.loginImg {color:#fff; display:block;}
</style>
<% Customer cus =(Customer)request.getSession().getAttribute("customer");%>
<script type="text/javascript">
$().ready(
	function(){
	$.post("<%=path%>/litscloud/web/isOkCookiesCustomerServerC.Action",{},function(data){
		document.getElementById("userid").value=data;//显示
	});
});
$(document).ready(function(){
$("#yanzhengma1").keydown(function(e){
var curKey = e.which;
if(curKey == 13){
login();
return false;
}
});
}); 

if( '<%=cus %>' != 'null'){
	
    window.location.href="<%=path %>/litscloud/ucenter/index.jsp";
  }
function yanzheng(lujing)
{
	location.reload();

}  
function aa()
{
	document.getElementById("qiehuan").innerHTML="手机号：";//显示
	document.getElementById("IsOk").value="2";//显示
	
	}
function bb()
{
	document.getElementById("qiehuan").innerHTML="登录名：";//显示
	document.getElementById("IsOk").value="1";//显示
	
	}

 //function reloadVerifyCode(obj){  
  //      obj.src = "<%=request.getContextPath()%>/servlet/Img?d=" + new Date();  
  //  } 

function aaaa()
{
	$.post("https://dnsapi.cn/Info.Version",{
		login_email:"yanyinhua@fuaotech.com",
		login_password:"utemyan",
		format:"json",
		lang:"en",
		error_on_empty:"yes",
	
	},function(data){
	alert(data);
	
	});
}
</script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
</head>

<body>
<!-- 头部S -->
<div class="ly_body">


<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  
   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  ....
      <div class="ly_n_login">
         <div class="ly_n_login_n">
            <div class="ly_n_login_l"><img src="litscloud/images/ly_83.jpg" /></div>
            <div class="ly_n_login_r">
                 <div class="ly_n_login_rs"></div>
                <div class="ly_n_login_rq" style="display:block;" id="div1" >
                 <form action="litscloud/litscloudUserLoginCustomerServerC.Action" method="post" id="loginform">
                  <div class="ly_n_login_rt" style="height:40px;">
                     <div class="ly_n_login_rqt"><span class="blue_q"><a onclick="aa()" href="javascript:void(0)">手机登陆</a></span></div>
                    <div class="ly_n_login_rqd">
                  <p id="qiehuan"><c:if test="${IsOkPhone=='2'}">手机登录：</c:if><c:if test="${IsOkPhone!='2'}">登录名：</c:if></p><input type="hidden" id="IsOk" name="IsOk" value=<c:if test="${IsOkPhone=='2'}">2</c:if><c:if test="${IsOkPhone!='2'}">1</c:if> /><span class="blue_q"><a href=javascript:void(0)" onclick="bb()">原支付宝快捷登陆</a></span>
                   </div>
                  </div>
                
                  <div class="ly_n_login_rc"><input type="text" name="userid" id="userid" value="" class="login_name" /></div>
                  <div class="ly_n_login_rt"><p>登录密码：</p><span style="font-weight:normal;"><a href="litscloud/ucenter/bg_zhaopass.jsp" target="_parent">忘记登录密码？</a></span></div>
                  <div class="ly_n_login_rc"><input type="password" name="passwd" id="passwd" value="" class="login_name" /></div>
                  
                  
                   <div class="ly_n_login_rt"><p>验证码：</p></div>
                   
                    
                  <div class="ly_n_login_rc" style="height:30px; "><div style="float: left"><input type="text" id="yanzhengma1" name="yanzhengma1" class="data_yzm"/></div><div  style="float: left"><span id="YZM" style="color:#f00;">${msgtip }</span></div></div>
                  <div class="ly_n_login_rl"> <img border=0 id="yanzhengma" src="<%=request.getContextPath()%>/servlet/Img"><a href="javascript:changeimg()">看不清，换一张</a> </div>
                  <div class="ly_n_login_rm"><input type="hidden" name="dl1" id="dl1" value="1" /><input id="dl" name="dl" class="login_dl" type="checkbox" />十天保存登陆账号</div>
                  <div class="ly_n_login_rd">
                        <div class="ly_n_login_rdl"></div>
                        <div class="ly_n_login_rdc"><a href="javascript:void(0);" onclick="login()" target="_parent">登陆</a></div>
                        <div class="ly_n_login_rdr"></div></div>
                  <div class="ly_n_login_rt"><span style="float:left; width:120px; float:left; text-align:left;" class="blue_q"><a href="javascript:void(0);" target="_parent">忘记登录名?</a></span><span class="blue_q" style="float:left; width:120px;"><a href="litscloud/ucenter/u_logon.jsp" target="">免费注册</a></span></div>
                  <div class="ly_n_login_rb">使用合作网站账号登陆：<span class="blue_q"><a href="javascript:void(0);"><img src="litscloud/images/ly_86.jpg" /> 登 陆</a></span></div> 
                </form>
               
                </div>
                
                <div class="ly_n_login_rw"></div>
            </div>
         </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
<script type="text/javascript">

function changeimg()
{
var myimg = document.getElementById("yanzhengma"); 
now = new Date().getTime();
var url = "<%=request.getContextPath()%>/servlet/Img?tt="+now;
myimg.src=url;
}

//changeimg();
</script>
