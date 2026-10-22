<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：留言板
  	 创建 人：陈星
	 创建时间：2012-08-27
 -->
<html>
	<head>
		<base href="<%=basePath%>">

		<title>留言板</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style type="text/css">
		@import url("cms/css/admin.css");
		</style>
		<style type="text/css">
		.nShow {
			display: none;
		}
		#outlian{
		   display:none;
		}
		</style>
  <link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
  <link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
  <script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="./cms/js/messagerBorad.js"></script>
</head>

<body>

<div id="weizhi">
 <div id="weizhiwz">当前位置&nbsp;>>&nbsp;审核部&nbsp;>>&nbsp;留言板
</div></div>
 
	<div class="conSet" >
 <form name="thisForm" action="/Message.do?method=selectList&label=term&topid=69"  method="post" >
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="bg1">
	<tr>
	<td align="right">
	<span>
    关键字 &nbsp;
   <input type="text" id="keyword" name="keyword"  />&nbsp;&nbsp;
   </span>
	<span>
   开始时间&nbsp;&nbsp;
   <input type="text" onfocus="setday(this)" onkeydown="setday(this)" id="btime" name="btime" />&nbsp;
    结束时间&nbsp;&nbsp;
   <input type="text" onfocus="setday(this)" onkeydown="setday(this)" id="etime" name="etime" />
   </span>
   <span style="padding-left:20px;">
   </span>
   <span style="padding-left:20px;padding-right:20px;">
    <input type="submit" class="save_but" value="筛 选" >
   </span>
   <span style="padding-left:20px;padding-right:20px;">
   </span>
   </td>
   </tr>
   </table>
   </form>
 </div>
 
<div style="width:100%; height: 80%; margin:0 auto;">
 <table id="dd">
 </table>
</div>

</body>
</html>
