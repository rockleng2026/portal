<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="我的项目消费记录 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>我的项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
  </head>
  <body onload="setdivwidth();">
     	<center><b>项目消费记录</b></center>
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    		<tr>
			   <td>任务名称</td>
			   <td>任务进度</td>
			   <td>任务执行人</td>
			   <td>支出金额</td>
			   <td>同意支出金额人</td>
			   <td>支出时间</td>
			   <td>使用金额原因</td>
			   <td>支出金额单据</td>
    		</tr>
    		<c:forEach items="${listnp}" var="np">
    			<tr>
    				<td>${np.task.function.functionname}</td>
    				<td>${np.tplan}</td>
    				<td>${np.empsubmit.name}</td>
    				<td>${np.nmoney}</td>
    				<td>${np.emp.name}</td>
    				<td>${np.subtime}</td>
    				<td>${np.remakes}</td>
    				<td>${np.nfj}</td>
    			</tr>
    		</c:forEach>
    	</table>
    	</div>
  </body>
</html>
