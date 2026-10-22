<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-实名认证</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">

</script>
</head>


<body>
<div class="ly_body">
    <!------------------------------------------头部公用代码------------------------------------------------------------>
<jsp:include page="/litscloud/ucenter/top2.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="litscloud/ucenter/index.jsp" target="_parent">首页</a>>会员中心</div> 
          <div class="bg_c">
              <div class="bg_ct"><ul>
                <li><a href="litscloud/ucenter/bg_data.jsp" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">我的<br />账户</a></li>
                <li><a href="litscloud/ucenter/bg_indent.jsp">自助<br />管理</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
                    <li><a href="litscloud/ucenter/index.jsp" >个人资料</a></li>
                    
                    <li><a href="litscloud/ucenter/bg_password.jsp">修改密码</a></li>
                    
                    <li><a href="litscloud/ucenter/bg_wycz.jsp">我要充值</a></li>
                    <li><a href="litscloud/ucenter/u_zhanghu.jsp" style="background-image:url(litscloud/images/bg_06.jpg); color:#000; background-repeat:no-repeat;">账户信息</a></li>
                    <li><a href="litscloud/ucenter/bg_czjl.jsp">充值记录</a></li>
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
          </div> 
          <div class="ly_xx">
             <div class="ly_xxt">
               <div class="ly_xxtl">个人实名认证</div>
               <div class="ly_xxtr"><span class="blue_q"><a href="litscloud/ucenter/u_zhanghu.jsp">返回账户信息</a></span></div>         
             </div>
             <div class="ly_rz">
               <div class="ly_rzt"></div>
               <div class="ly_rzc">
                 <div class="ly_rzc_l"><img src="litscloud/images/log_53.gif" /></div>
                 <div class="ly_rzc_r">
                    <div class="ly_rzc_rt">您个人实名认证已经完成！</div>
                    <div class="ly_rzc_rc">通过个人实名认证，可以证明您的身份的真实性。</div>
                 </div>
               </div>
               <div class="ly_rzd"></div>
             </div>             
             
          </div>             
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
