<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-修改邮箱</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/litscloud/js/bg_password.js"></script>
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript" src="litscloud/js/user.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
	 $(document).ready(function(){ 
 document.getElementById("a1").className = "aBackgroundImage";
 document.getElementById("a1").style.color= "#000000";
 
 });
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
        <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include>
      
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_dqt">更换邮箱</div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_zhaopass">
                      <div class="bg_zhaopass_t"><img src="litscloud/images/yx_01.jpg" /></div>
                      <div class="bg_zhaopass_c">
                         <div class="bg_zhaopass_cl">原来邮箱：</div>
                         <div class="bg_zhaopass_cr"><input type="text" style="width: 200px" id="" disabled="true" name="data_name" class="data_name" value="${customer.email}" /> &nbsp; <img src="litscloud/images/bg_18.png" /></div>
                      </div>
                     <div class="bg_zhaopass_c">
                         <div class="bg_zhaopass_cl">更换邮箱：</div>
                         <div class="bg_zhaopass_cm"><input type="text" style="width: 200px" id="email" name="data_yzm" class="data_yzm"/></div>
                         <div class="bg_zhaopass_cc"></div>
                         <div class="bg_zhaopass_cs"> </div>
                      </div> 
                    </div>
                    <div class="bg_an">
                        <div class="bg_anc"><a onclick="updateEmail('<%=basePath %>')" href="javascript:void(0)">下一步</a></div>
                    </div>
                </div>  
                
             </div>
             <div class="bg_dd"></div>
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
