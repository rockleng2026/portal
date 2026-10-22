<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>" />
    <title>福奥portal_销售业务子系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
    <meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>
	<meta http-equiv="x-ua-compatible" content="ie=7" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>
	<meta http-equiv="description" content="福奥Portal业务系统,CMS"/>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/index2.css" />
	<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/style2.css" />
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>potal/js/options.js"></script>
	<script type="text/javascript" src="<%=basePath%>potal/js/tuodong.js"></script>
	
	
  </head>
<!--[if IE 6]>
<script type="text/javascript" src="js/pngfix.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('.rightnr .change i, ..rightnr, ..btn-slide, .change i.cur , .mountainbox, img');
</script>
<![endif]-->
<body>
  	    <div class="body">
			<div class="top">
				<jsp:include page="/potal/frame/head.jsp" flush="true"></jsp:include>
			</div>
			<div class="topx"></div>
			<div class="contentbox">
				<div class="content">
					<div class="leftbox">
						<jsp:include page="/potal/frame/left.jsp" flush="true"></jsp:include>
					</div>
					<div class="kh_middlebox" id="middle_content_div">
						<iframe frameborder="0" height="550" width="808" scrolling="auto" name="targetName" src="<%=basePath %>potal/page/desk.jsp">
         				</iframe>
					</div>
				</div>
				<div class="rightbox">

					<jsp:include page="/potal/frame/right.jsp" flush="true"></jsp:include>


				</div>
			</div>
			<div class="dibu"></div>
		</div>
		<div class="dibuxia"></div>
  </body>
  
</html>
