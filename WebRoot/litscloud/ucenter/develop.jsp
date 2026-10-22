<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-功能开发中</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCo	mmand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">

</script>
</head>
  
  <body>
    <div class="ly_body">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>


	 <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
         <div class="ly_develop">
           <div class="ly_developt"><img src="litscloud/images/log_08.gif" /></div> 
           <div class="ly_developd"><a href="javascript:history.back(-1)">返回上一页</a></div> 
         </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
	

<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
  </body>
</html>
