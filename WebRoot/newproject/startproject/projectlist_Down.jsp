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
	String filename ="我的项目 "+nowstr+".xls";	
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
		<center><b>项目列表</b></center>
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目编号</th>
			 <th>项目名称</th>
			 <th>项目发起人</th>
			 <th>项目审批人</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			 <th>项目进度</th>
			 <th>项目资金</th>
			 <th>状态</th>
			</tr>
			<c:forEach items="${projectlist}" var="project">
			<tr>
			   <td>${project.id }</td>
			   <td>
			   ${project.projectname }
			   </td>
			   <td>${project.launcher}</td>
			   <td>${project.employee.name}</td>
			   <td>${project.begintime}</td>
			   <td>${project.endtime}</td>
			   <td>${project.schedule}%</td>
			   <td>${project.money}</td>
			   <td>
			   <c:if test="${project.projectstatus==0}">
			           立项中
			   </c:if>
			   <c:if test="${project.projectstatus==1}">
			           审批中
			   </c:if>
			   <c:if test="${project.projectstatus==2}">
			          进行中
			   </c:if>
			   <c:if test="${project.projectstatus==3}">
			           已超时
			   </c:if>
			   <c:if test="${project.projectstatus==4}">
			           已结束
			   </c:if>
			   </td>
			</tr>
			</c:forEach>
		</table>
		</div>
	</body>
</html>
