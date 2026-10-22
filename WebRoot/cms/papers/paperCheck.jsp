<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：文章审核
	 创建 人：陈星
	 创建时间：2012-08-21
 -->
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>文章审核</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
			@import url("cms/css/admin.css");
		</style>
		<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
		<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="./cms/js/paperCheck.js"></script>

  </head>
  
  <body>
<div id="weizhi" >
 <div id="weizhiwz">当前位置&nbsp;>>&nbsp;审核部&nbsp;>>&nbsp;留言审核
</div></div>
 <div class="conSet" >
 <form name="thisForm" action="/contentsstatus.do"  method="post" >
 <input type="hidden" id="basepath" value="<%=basePath %>"/>
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="bg1">
	<tr>
   <td align="center" >
   <span >
   审核状态 &nbsp;&nbsp;
   <select name="status" id="status" >
   <option value="0" selected>待审核</option>
   <option value="1" >审核成功</option>
   <option value="2" >审核失败</option>
   </select>
   </span>
  <span style="padding-left:20px;">
          选择信息类别 &nbsp;&nbsp;
    <select name="typeid" id="typeid" style="width:100px;">
		<option value='100'>all</option>
   </select>
   </span>
   <span style="margin-left:20px;">
   <input type="button" class="save_but" value="筛 选" onclick="subs()" >
   </span>
   </td>
   <td align="left" >
    &nbsp;
   </td>
   </tr>
   </table>
   </form>
    </div>
    
<div style="width:100%; height:80%; margin:0 auto;">
  <table id="dd">
  </table>
</div>
 
  
</body>
</html>
  
