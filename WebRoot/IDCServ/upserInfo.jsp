<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'upserInfo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <style type="text/css">
	.on{width:100%;margin-left:15%; float:left;background-position:center; background:url(<%=basePath%>IDCServ/image/upses.jpg) no-repeat; height:36px;margin-top:20px;}
	.on span{float:left; font-size:12px; font-weight:bold;color: #ffffff}
	.on_1{position:relative; left:4%; line-height: 36px;}
	.on_2{position:relative; left:13%; line-height: 36px;}
	.on_3{position:relative; left:22%; line-height: 36px;}
	.on_4{position:relative; left:30%; line-height: 36px;}
	.on_5{position:relative; left:40%; line-height: 36px;}
       #aaa{
         font-size: 14px;
         text-align: center;
         padding-top:30px;
       }
       #bbb{
         font-size: 14px;
         text-align: center;
         padding:15px;
       }
       .pf10{width:100%; border:1px solid #dcdfe6; font-size:12px; color:#666;}
    </style>
	
  </head>
  
  <body>
     <jsp:include page="head.jsp"></jsp:include>
     <!-- 这里上架分两种 -->
     <% request.setAttribute("ps","2"); 
     if(request.getAttribute("ps").equals("1")){
     %>
	<div class="dd09" style="background-position:left -108px;">
	  <ul>
	    <li><span>1,业务定单</span></li>
	    <li><span>2,定单确认</span></li>
	    <li><span>3,付款</span></li>
	    <li><span style="margin-left: 50px;">4,待上架</span></li>
	    </ul>
	</div>
	<%}else{ %>
	<div class="on">
	<span class="on_1">1.业务订单</span>
	<span class="on_2">2.订单确认</span>
	<span class="on_3">3.付款页面</span>
	<span class="on_4">4.配送</span>
	<span class="on_5">5.等待上架</span>
	</div>
	<%} %>
	<div class="pf10">
		<div id="aaa">正在安装服务器...</div>
		<div id="bbb">服务器上架成功，欢迎使用</div>
    </div>
	<jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
