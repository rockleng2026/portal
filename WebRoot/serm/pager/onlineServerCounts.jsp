<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>在线服务器统计</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>serm/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>serm/css/icon.css">
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" charset="GBK" src="<%=basePath%>serm/js/onlineServerCounts.js"></script>
  </head>
  
  <body>
     <div style=" width:100%; height:33px; background:url(./stores/images/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(./stores/images/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">仓库记总： </div>
  <div style=" height:30px; width:100px; text-align:center; float:left; margin-left:15px; font-size:12px;">
    <input id="exportData" type="button" value="导出EXCEL" style=" margin-top:3px;" />
  </div>
</div>
<div style=" width:100%;height:50px;text-align:center; border:#CCC double 1px; margin-top:8px;background:url(./stores/images/xuanxkbg.jpg); background-repeat:repeat-x; font-size:12px;">
<div style="width:600px;height:50px;margin:0 auto;line-height:50px;">
  地区:
   <select name="sels" id="sels" style=" width:100px; height:22px; margin-top:5px;" onchange="changeValue(this.value)">
       <option value=0>请选择</option>
    </select>
   机房：
  <select name="sels" id="sels" style=" width:100px; height:22px; margin-top:5px;" onchange="changeValue(this.value)">
       <option value=0>请选择</option>
    </select>
  机柜:
  <select name="sels" id="sels" style=" width:100px; height:22px; margin-top:5px;" onchange="changeValue(this.value)">
       <option value=0>请选择</option>
   </select>
   <input id="butn" type="button" value="查询" class="butt"/>
  </div>
  </div>

<div style="width:100%;height:80%;">
<table id="dd" style="width:100%;height:100%;">
</table>
</div>
  </body>
</html>
