<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
  alert(1111);
  if(${customer} != null){
  	window.location.href="litscloud/ucenter/index.jsp";
  }
</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body">


<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
         <div class="ly_n_login_n">
            <div class="ly_n_login_l"><img src="litscloud/images/ly_83.jpg" /></div>
            <div class="ly_n_login_r">
                <div class="ly_n_login_rq">
                  <form action="litscloud/litscloudUserLoginCustomerServerC.Action" method="post" id="loginform">
                  <div class="ly_n_login_rt"><p>登录名：</p>${msgtip1 }<span class="blue_q"><a href="litscloud/msg/bg_password.jsp">原支付宝快捷登陆<img src="litscloud/images/ly_84.jpg"/></a></span></div>
                  <div class="ly_n_login_rc"><input type="text" name="userid" id="userid" value="xuyuan" class="login_name" /></div>
                  <div class="ly_n_login_rt"><p>登录密码：</p><font style="color:red;">${msgtip2 }</font><span style="font-weight:normal;"><a href="litscloud/msg/no_function.jsp">忘记登录密码？</a></span></div>
                  <div class="ly_n_login_rc"><input type="password" name="passwd" id="passwd" value="123456" class="login_name" /></div>
                   <div class="ly_n_login_rt"><p>验证码：</p><font style="color:red;">${msgtip3 }</font></div>
                  <% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
                  <div class="ly_n_login_rc"><input type="text" name="ValCode" id="ValCode"  style="width:80px;"/><IMG SRC="<%=imgpath%><%=request.getContextPath() %>/servlet/Img" />&nbsp;<span style="font-weight:normal;"><a href="">重启获取？</a></span></div>
                  <div class="ly_n_login_rm"><input name="dl" class="login_dl" type="checkbox" />十天内免登陆</div>
                  <div class="ly_n_login_rd"><a href="javascript:void(0);"  class="loginImg" onclick="login()">登陆</a></div>
                  <div class="ly_n_login_rt"><span style="float:left; width:120px; float:left; text-align:left;" class="blue_q"><a href="litscloud/msg/no_function.jsp">忘记登录名?</a></span><span class="blue_q" style="float:left; width:120px;"><a href="litscloud/msg/no_function.jsp">免费注册</a></span></div>
                  <div class="ly_n_login_rb">使用合作网站账号登陆：<span class="blue_q"><a href="javascript:void(0);"><img src="litscloud/images/ly_86.jpg"/> 登 陆</a></span></div> 
                </form>
                </div>
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
