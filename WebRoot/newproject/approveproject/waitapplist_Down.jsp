<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="待审批项目 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>待审批项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
  </head>
  
<body onload="setdivwidth();">
		<center><b>待审批项目</b></center>   
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目名称</th>
			 <th>申请人</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			 <th>审批人</th>
			 <th>审批最大金额</th>
			 <th>项目资金</th>
			 <th>审批状态</th>
			</tr>
			<c:forEach items="${waitprj}" var="approve">
				<tr>
				   <td>${approve.newproject.projectname}</td>
				   <td>${approve.applypeople.name }</td>
				   <td>${approve.begintime }</td>
				   <td>${approve.endtime }</td>
				   <td>${approve.approveemp.name }</td>
				   <td>${approve.approveemp.approvemoney}</td>
				   <td>${approve.newproject.money }</td>
				   <c:if test="${approve.applypeople.id!=employee.id or approve.approveemp.id==employee.id and approve.appstatus==0}">
				   <td>
				      <c:if test="${approve.approveemp.approvemoney>=approve.newproject.money and approve.appstatus!=1}">
				                              未审批
				      </c:if>
				      <c:if test="${approve.approveemp.approvemoney<approve.newproject.money and approve.appstatus!=1}">
				                             未审批
				      </c:if>
				      <c:if test="${approve.appstatus==1}">
				         　　　　通过审批
				      </c:if>
				   </td>
				   </c:if>
				   <c:if test="${approve.applypeople.id==employee.id and approve.approveemp.id!=employee.id }">
				   <td>
				      <c:if test="${approve.appstatus==0}">未审批</c:if>
				      <c:if test="${approve.appstatus==1}">通过审批</c:if>
				   </td>
				   </c:if>
				   <c:if test="${approve.applypeople.id==approve.approveemp.id}">
					   <td>
					   </td>
				   </c:if>
				</tr>
			</c:forEach>
		</table></div>
	
	</body>
</html>
