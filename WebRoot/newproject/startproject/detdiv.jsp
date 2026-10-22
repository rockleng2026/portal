<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.vo.NewProject"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>我的项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
  </head>
  
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div>
   	<table style="width:50%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th colspan="4">任务详细信息</th>
			</tr>
					<tr>
			 <td>上级任务</td>
			 <td>项目编号</td>
			  <td>任务名称</td> 
			  <td>项目编号</td> 
			 
			</tr>
				<tr>
			 <td>任务进度</td>
			 <td>项目编号</td>
			  <td>任务负责人</td>
			 <td>项目编号</td>
			 
			</tr>
			<tr>
			 <td>开始日期</td> 
			  <td>项目编号</td> 
			 
			  <td>结束日期</td>
			 <td>项目编号</td>
			</tr>
				 		<tr>
			 <td>订单编号</td>
			 <td colspan="3">项目编号</td>
			</tr>
			<tr>
				 <td>查看附件</td> 
			  	 <td colspan="3">项目编号</td>
			</tr>
			<tr>
				 <td>任务内容</td>
			 <td colspan="3">项目编号</td>
			</tr>
			</table>
			
			</div>
  </body>
</html>
