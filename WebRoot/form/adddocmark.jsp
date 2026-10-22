<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加详细单据</title>
    <!-- saved from url=(0014)about:internet -->   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/style_s.css">
  </head>
<body>
	<div class="con" >
		<div class="righter">
			<div class="main_leirong_title" style="width:90.5%;">添加审核类型</div>
			<br><br>
			<div class="line" style=" margin-left: 100px; float: left">
				<form action="markaddFormTempAction.do" method="post">
					<table>
					  <tr>
					  	<td align="right" nowrap class="bg0"  nowrap class="bg0" >
					  		审核类型名称 ：
					  	</td>
					  	<td style="padding-left:10px;" nowrap class="bg0">
					   		<input type="text" name="aname" id="aname" />
					   	</td> 
					  </tr>
					  <tr>
					    <td align="right" nowrap class="bg0"  nowrap class="bg0" >
					    	审核类型标识 ：
					    </td>
					  	<td style="padding-left:10px;" nowrap class="bg0">
					  		<input type="text" name="mark" id="mark" />
					  	</td>
					  </tr>
					 </table><br/>
					    <input type="submit"  value="确定"/>
					    <input type="reset"  value="取消"/>
				</form>
			</div>
		</div>
	</div>
</body>
</html>