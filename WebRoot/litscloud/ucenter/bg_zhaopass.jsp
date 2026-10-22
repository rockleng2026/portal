<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-找回密码</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/litscloud/js/bg_zhaopass.js"></script>
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
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
      
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_dqt">找回密码</div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_zhaopass">
                      <div class="bg_zhaopass_t"><img src="litscloud/images/bg_21.png" /></div>
                      <div class="bg_zhaopass_c">
                         <div class="bg_zhaopass_cl">帐号：</div>
                         <div class="bg_zhaopass_cr"><input type="text" id="youxiang"  name="data_name" class="data_name" value="" /> &nbsp; <img src="litscloud/images/bg_19.png" /><span id="YX" style="font-size:12px;">请输入邮箱</span></div>
                      </div>
                     <div class="bg_zhaopass_c">
                         <div class="bg_zhaopass_cl">验证码：</div>
                         <div class="bg_zhaopass_cm"><input type="text" id="yanzhengma1" name="data_yzm" class="data_yzm"/></div>
                         <div class="bg_zhaopass_cc" align="right"> <img border=0 id="yanzhengma" src="<%=request.getContextPath()%>/servlet/Img"> </div>
                         <div class="bg_zhaopass_ch"><a href="javascript:changeimg()">看不清，换一张</a></div>
                         <div class="bg_zhaopass_cs"><img src="litscloud/images/bg_19.png" />&nbsp;<span id="YZM">请输入验证码</span></div>
                      </div> 
                    </div>
                    <div class="bg_an">
                        <div class="bg_anc"><a onclick="yanZheng('<%=basePath %>')" href="javascript:void(0)">下一步</a></div>
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
<script type="text/javascript">

function changeimg()
{
var myimg = document.getElementById("yanzhengma"); 
now = new Date().getTime();
var url = "<%=request.getContextPath()%>/servlet/Img?tt="+now;
myimg.src=url;
}

changeimg();
</script>
