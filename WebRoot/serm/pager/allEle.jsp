<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags"  prefix="s"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'allEle.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	 <link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>

<SCRIPT type="text/javascript">
	$(document).ready(function(){
			$('#elehouse').change(function(){
				var electid = $(this).children('option:selected').val();
				$.ajax({
				  type: "POST",
				  url:"cms/show_updateorC.do",
				  data:{
				  		"electid":electid
				  },
				  success: function(data){
				       alert("转移成功!");	
				       parent.location.reload();	  		
				  }
				 });
			});
		});
</SCRIPT>
  </head>
  
  <body>
  	<form action=""></form>
  	请选择机房:
    	<div>
    		<select id="elehouse">
    			<s:iterator status="ele" value="#request.list11" var="eles">
    				<option value="<s:property value="#eles.electId"/>"><s:property value="#eles.electName"/></option>
    			</s:iterator>
    		</select>
    	</div>
  </body>
</html>
