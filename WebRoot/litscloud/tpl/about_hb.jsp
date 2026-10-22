<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-合作伙伴</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="litscloud/css/main.css" />
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="litscloud/js/slides.jquery.js"></script>
<script type="text/javascript" src="litscloud/js/top.js"></script>
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
<div class="ly_body" id="mainbody">
   <!------------------------------------------头部公用代码------------------------------------------------------------>
 <jsp:include page="/litscloud/tpl/top_about.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

   <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>   
     </div>
          <div class="ly_dh">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/about.jsp" target="_parent">关于我们</a> > 合作伙伴
      </div>
   
    <div class="ly_about_d">
       <div class="ly_about_dt"><img src="litscloud/images/ly_51.jpg" /></div>
       <div class="ly_about_dd">
          <div class="ly_about_hz"><ul>
              <li><a href="#"><img height="30" src="litscloud/images/01.gif" width="88" border="0" /></a></li>
              <li><a href="http://www.chinamobile.com/" target="_blank"><img height="31" src="litscloud/images/02.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.cnc.com.cn/" target="_blank"><img height="31" src="litscloud/images/03.jpg" width="88" border="0" /></a></li>
              <li><a href="www.xinnet.cn" target="_blank"><img height="31" src="litscloud/images/04.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.dns.com.cn/index.htm" target="_blank"><img height="31" src="litscloud/images/05.png" width="88" border="0" /></a></li>
              <li><a href="http://www.onlinedown.net/" target="_blank"><img height="31" src="litscloud/images/06.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.cnnic.net.cn/index.htm" target="_blank"><img height="31" src="litscloud/images/07.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.cnnic.net.cn/index.htm" target="_blank"><img height="31" src="litscloud/images/08.jpg" width="88" border="0" /></a></li>
              <li><a href="https://www.alipay.com/" target="_blank"><img height="31" src="litscloud/images/09.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.chinabank.com.cn/" target="_blank"><img height="31" src="litscloud/images/10.jpg" width="88" border="0" /></a></li>
              <li><a href="http://www.tenpay.com/ " target="_blank"><img height="31" src="litscloud/images/11.jpg" width="88" border="0" /></a></li>
          </ul></div>
       </div>
    </div>     
   
   </div>

<!--_________________________底部公用代码 _______________________________________________-->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
