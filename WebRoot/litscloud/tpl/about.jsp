<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-关于我们</title>
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
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > 关于我们
      </div>
    
    <div class="ly_about_d">
       <div class="ly_about_dt"><img src="litscloud/images/ly_51.jpg" /></div>
       <div class="ly_about_dd">立云数据中心，是国内领先的综合电信业务运营商，是信息产业部认定的IDC服务运营商，公司成立于2008年。历经5年专业化运营，依托与基础电信业务运营商和IT设备厂商在渠道、资源上的优势，成功为近 千家企业级客户提供网络安全保障服务。<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;立云致力于新一代增值电信业务服务，集众多10年以上经验的行业内专家、多地设立的专业化运营团队，为您提供各种网络解决方案和更高效、快捷的服务。<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;立云服务范围涉及服务器销售、服务器托管、服务器租用、带宽出租、CDN加速、BGP运营、EDC运营等多种业务范围，专业为企业及中小客户提供7*24小时IDC服务。
 </div>
    </div>     
   
   </div>



<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
