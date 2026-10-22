<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（支付成功）</title>
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
             <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include> 
        <div class="bg_zf">
              <div class="bg_zft"><img src="litscloud/images/zf_01.gif" /></div> 
              <div class="bg_zfd">
                  <div class="bg_zfd_t"></div> 
                  <div class="bg_zfd_c">
                     <div class="bg_zfd_cl"><img src="litscloud/images/zf_06.gif" /></div>
                     <div class="bg_zfd_cr">
                        <div class="bg_zfd_crt">你已成功付款! </div>
                        <!-- <div class="bg_zfd_crc">对方将立即收到您的付款。<br />
如果您有未付款信息，<a href="#">查看并继续付款</a></div> -->
                        <div class="bg_zfd_crd">您可能需要：<a href="litscloud/ucenter/my_order.jsp">返回订单列表</a><a href="javascript:void(0);">消费记录</a><a href="javascript:void(0);">我要充值</a></div>
                     </div>
                  </div>
                  <div class="bg_zfd_d"></div>  
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
