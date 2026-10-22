<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-邮箱验证</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/litscloud/js/updatePhone.js"></script>
			<script type="text/javascript" src="litscloud/js/user.js"></script>
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
          <!-- 菜单1S -->
          <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include>
          <!-- 菜单1E -->
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_dqt">修改手机</div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_zhaopass">
                      <div class="bg_zhaopass_t" style="margin:0px;"><img src="litscloud/images/sj_02.jpg" /></div>
                      <div class="bg_zhaopass2_t"></div>
                      <div class="bg_zhaopass2_c"><ul>
                         <li><a href="#" style="background-image:url(litscloud/images/bg_24.png); font-weight:bold; color:#000;">邮箱验证</a></li>
                      </ul></div> 
                      <div class="bg_zhaopass2_d">
                        <div class="bg_zhaopass2_dq">
                          <div class="bg_zhaopass2_dl">您绑定的邮箱：</div>
                          <div class="bg_zhaopass2_dr">${customer.email}&nbsp;&nbsp;&nbsp;<input type="button" onclick="open1();" name="bg_button" value="免费获取验证码" /></div>
                        </div>
                        <div class="bg_zhaopass2_dq">
                          <div class="bg_zhaopass2_dl">验证码：</div>
                          <div class="bg_zhaopass2_dr"><input type="text" id="suijima" name="suijima" name="bg_yzm" class="data_yzm" value="" /></div>
                    	
                        </div>    
                        <div class="bg_zhaopass2_dm" id="typediv1" style="display: none">
                             <div class="bg_zhaopass2_dmt">如果一分钟内没有收到验证码，请重新获取</div>
                             <div id="daojishi1" class="bg_zhaopass2_dmd"><img src="litscloud/images/bg_18.png" />验证码也发送 →_→ <INPUT TYPE= "text"" id="jump"   disabled="true" value="59" style="width: 20px" />秒后重新获取  </div>
                             <div id="daojishi2" style="display: none" class="bg_zhaopass2_dmd"><INPUT TYPE= "button"" id="" onclick="open1()"  value="发送" />点击后再次发送  </div>
                             
                          </div>
                        </div>                     
                      </div>                
                    </div>
                    <div class="bg_an">
                       <div class="bg_anl">
                         <div class="bg_anlc"><a href="javascript:history.back(-1)">返回</a></div>
                       </div>
                       <div class="bg_anr">
                         <div class="bg_anrc"><a onclick="yanZhengMa('<%=basePath %>')" href="javascript:void(0)">下一步</a></div>
                       </div>
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
<script>
	

</script>
