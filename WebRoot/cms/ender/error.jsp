<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>首页</title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="cms/ender/css/style.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.js" type="text/javascript"></script>
<script src="cms/ender/js/zzsc.js" type="text/javascript"></script>
</head>

<body>
<div class="bodyer"> <!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->
    
   <!-- 头部start -->
      <jsp:include page="menu.jsp"></jsp:include>
   <!-- 头部end -->
   <!-- t_bod结束 -->
   <div style="height: 500px;font-size: 18px;">
   		ERROR!!!!!${errorMsg }
   </div>
   
   
   <!-- 内容输出完毕 -->
   <!-- 底部开始 -->
   <jsp:include page="bottum.jsp"></jsp:include>
   <!-- 底部完毕 -->
</div>

</body>
</html>
