<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（评价失败）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->

</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心>订单管理>评价宝贝</div> 
          
             <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
        
           <div class="bg_pjcg">
               <div class="bg_pjcg_t"><img src="litscloud/images/log_46.gif" /></div>
               <div class="bg_pjcg_d">
                  <div class="bg_pjcg_dl">
                     <div class="bg_pjsb_dlt"></div>
                     <div class="bg_pjsb_dlc">
                        <div class="bg_pjsb_L"><img src="litscloud/images/log_53.gif" /></div>
                        <div class="bg_pjsb_r">
                            <div class="bg_pjsb_rt">抱歉，评价发布失败</div>
                            <div class="bg_pjsb_rc">原因可能是：<br />
                              1、你已进行过评价<br />
                              2、不在评价期内，交易成功后15天内可做评价
                            </div>
                            <div class="bg_pjsb_rd"><a href="#">重新评价</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">返回订单列表</a></div>
                        </div>
                     </div>
                     <div class="bg_pjsb_dld"></div>
                  </div>
                  <div class="bg_pjcg_dr">
                    <a href="#"><img src="litscloud/images/log_44.gif" /> 评价须知</a>
                  </div>
               </div>
           </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
