<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="审批记录 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>审批记录</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	
  </head>
  
<body onload="setdivwidth();">
		<!-- 数据显示  -->
		<center><b>审批记录</b></center>
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目名称</th>
			 <th>申请人</th>
			 <th>审批人</th>
			 <th>申批时间</th>
			 <th>审批意见</th>
			 <th>状态</th>
			</tr>
			<c:forEach items="${recordlist}" var="record">
				<tr>
				   <td>${record.projectname}</td>
				   <td>${record.applypeople}</td>
				   <td>${record.approveemp}</td>
				   <td>${record.apptime}</td>
				   <td>${record.approveinfo}</td>
				   <td>	
				   	   <c:if test="${record.ispass==1}">通过</c:if> 
				   	   <c:if test="${record.ispass==0  or record.ispass==2}">拒绝</c:if>
				   </td>
				</tr>
			</c:forEach>
		</table></div>
	</body>
</html>
