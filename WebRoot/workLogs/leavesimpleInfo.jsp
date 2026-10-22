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
    <title>员工请假信息</title>
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
			<div style=" float: left; clear: both; width:100%; ">
			<br><hr>
			</div>
				<div class="line" style=" float: left; clear: both; width:100%; ">
					<br/>
					<h3 align="center">
						员工请假单
					</h3>
					<hr>
				</div>
				<div class="line">
					<div class="ziduan_ming bill_list_linecs" style="width:15%; height:23px;">请假人</div>	
					<div class="ziduan_ming bill_list_linecs" style="width:15%; height:23px;">请假开始时间</div>
					<div class="ziduan_ming bill_list_linecs" style="width:15%; height:23px;">请假结束时间</div>	
					<div class="ziduan_ming bill_list_linecs" style="width:15%; height:23px;">类型</div>
					<div class="ziduan_ming bill_list_linecs" style="width:30%; height:23px;">内容</div>
				</div>
				
				<c:forEach items="${leavelist}" var="leave">
		    		 <div class="line">
					    <div class="ziduan_ming bill_list_linecs" style="width:15%;  height:23px;">${leave.temp}</div>	
					    <div class="ziduan_ming bill_list_linecs" style="width:15%;  height:23px;">${leave.begintime}</div>
					    <div class="ziduan_ming bill_list_linecs" style="width:15%;  height:23px;">${leave.endtime}</div>
					    <div class="ziduan_ming bill_list_linecs" style="width:15%;  height:23px;">
					       <c:if test="${leave.leavetype==0}">休假(假)</c:if>
					       <c:if test="${leave.leavetype==1}">病假</c:if>
					       <c:if test="${leave.leavetype==2}">事假</c:if>
					       <c:if test="${leave.leavetype==3}">其他</c:if>
					    </div>
					    <div class="ziduan_ming bill_list_linecs" style="width:30%; height:23px;">${leave.content}</div>
					</div>
				</c:forEach>
				<div class="line" style=" float: left; clear: both; width:100%; ">
						<br/>
						 <h3 align="center">
							<a href="javascript:void(0);" onclick="javascript:history.go(-1);">返回</a>
						</h3> 
				</div>
		</div>
	</div>
</body>
</html>