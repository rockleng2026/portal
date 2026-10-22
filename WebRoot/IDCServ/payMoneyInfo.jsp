<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
    <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>payMoney</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
    <link href="<%=request.getContextPath()%>/IDCServ/css/main.css" rel="stylesheet" type="text/css" />
    <style>
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
       #ccc{
         font-size: 14px;
         text-align: center;
         padding:15px;
       }
    </style>
</head>
<body>
<jsp:include page="head.jsp"></jsp:include>
<div class="dd09" style=" background-position:left -72px;">
  <ul>
    <li><span>1,业务定单</span></li>
    <li><span>2,定单确认</span></li>
    <li><span>3,付款</span></li>
    <li><span style="margin-left: 50px;">4,待上架</span></li>
    </ul>
</div>
<div class="pf10">
     <div id="aaa">正在等待付款...</div>
     <div id="bbb">正在付款成功...</div>
     <div id="ccc">正在等待财务审核...</div>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
</body>
</html>
	