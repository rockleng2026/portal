<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<%@ page language="java" import="org.apache.struts2.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>模块列表</title>
    
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
    <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="./cms/js/adminmodel.js"></script>
  </head>
  
  <body bgcolor="#eeeeee">
<div id="weizhi">
			<div id="weizhiwz">
				当前位置&nbsp;>>&nbsp;技术部&nbsp;>>&nbsp;模块管理
				<input type="hidden" name="basepath" id="basepath" value="${basepath }">
			</div>
		</div>
  
   <div style="width: 100%; height: 80%;">
				<table id="tabs" align="left">
			</table>
			</div>
  
  
  </body>
</html>
