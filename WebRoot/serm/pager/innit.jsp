<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'innit.jsp' starting page</title>
	<META HTTP-EQUIV="pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
	<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
     <link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
    <script type="text/javascript">
      $(document).ready(function(){
        var caid=<%=request.getAttribute("loadcids")%>
        location.href="<%=basePath%>cms/show_showImager.do?cabinetId="+caid;
      });
    </script>
</head>

<body>
   <div style=" height:60px; width:100%; line-height:60px; font-size:16px;color:#3fade0; text-indent:20px;">数据正在加载。。。</div>
</body>
</html>

