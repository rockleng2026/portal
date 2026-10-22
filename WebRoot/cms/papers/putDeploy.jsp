<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
  request.setCharacterEncoding("GBK");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：推荐配置
  	 创建 人：陈星
	 创建时间：2012-08-27
 -->
<html>
	<head>
		<base href="<%=basePath%>">

		<title>推荐配置</title>

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
		  <script type="text/javascript" src="./cms/js/putDeploy.js"></script>
   </head>

<body>
<div id="weizhi" >
 <div id="weizhiwz">当前位置&nbsp;>>&nbsp;信息管理&nbsp;>>&nbsp;推荐配置
</div></div>
<br>
<div class="conSet"><div style=" background:#e2f4cd; height:30px; margin-left:10px;">
<input  border="0px" class="button03" name="wzfb" id="wzfb"  value="添加配置" type="button"/>
</div>
</div> 
    
<div style="width:100%; height: 80%; margin:0 auto;">
  <table id="dd">
  </table>
</div>
 
  
</body>
</html>
