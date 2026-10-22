<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="ly_top" style="border:none;">
      <div class="ly_topt">
         <div class="ly_top_t">
            <div class="ly_top_tl"><a href="index.html" target="_parent"><img src="litscloud/images/ly_01.jpg" class="logo" alt="立云终端服务" /></a></div>
            <div class="ly_top_tr">
               <div class="ly_top_trt">
               <div class="ly_top_trtr"><span>分享:</span><img src="litscloud/images/ly_02.gif" /> <a href="#">更多</a></div>
               <div class="ly_top_trtc"><a href="#"><img src="litscloud/images/ly_03.gif" /></a></div>
               <div class="ly_top_trtl">Hi,欢迎您！  <a href="login.html" target="_parent">登录</a> | <a href="login.html" target="_parent">注册</a> | <a href="#">忘记密码</a></div>
               </div>
               <div class="ly_top_trd"><a href="#"><img src="litscloud/images/ly_04.gif" /> </a></div>
               <div class="ly_top_trd"></div>  
            </div>
         </div>
         <div class="ly_top_d"><ul>
            <li><a href="litscloud/tpl/index.jsp" target="_parent" style="font-family:Arial, Helvetica, sans-serif; color:#2fafea; background-image:url(litscloud/images/ly_05.gif); background-repeat:no-repeat; background-position:center center;">Home</a></li>
            <li><a href="litscloud/tpl/serve.jsp" target="_parent">云服务</a></li>
            <li><a href="litscloud/tpl/apply.jsp" target="_parent">云应用</a></li>
            <li><a href="litscloud/tpl/apply.jsp" target="_parent">云平台</a></li>
            <li><a href="litscloud/tpl/about.jsp" target="_parent">关于我们</a></li>
            <li><a href="litscloud/ucenter/index.jsp" target="_parent" style="font-family:Arial, Helvetica, sans-serif; color:#2fafea; background-image:url(litscloud/images/ly_05.gif); background-repeat:no-repeat; background-position:center center;">会员中心</a></li>
         </ul></div>
      </div>
   </div>