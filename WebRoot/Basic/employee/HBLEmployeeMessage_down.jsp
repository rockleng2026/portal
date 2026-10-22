<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="员工基本信息列表 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<title>员工基本信息列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
</HEAD>
<BODY>
	<!-- 数据显示  -->
		<center><b>员工基本信息列表</b></center>
		<div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    	   <TR align="center">
				<th>姓名</th>
				<th>性别</th>
				<th>年龄</th>
				<th>生日</th>
				<th>联系电话</th>
				<th>学历</th>
				<th>所属部门</th>
				<th>职位</th>
				<th>工号</th>
				<th>入职时间</th>
				<th>是否在职</th>
		 </TR>    
		<tbody id="infotable">
		      <c:forEach items="${emplist}" var="data" >
				<c:if test="${data.department.depNo!=111}">
				<TR>
					
					<TD align=center height=25>
						<span>${data.name}</span>												
					</TD>
					<TD align=center >
					    <c:if test="${data.sex==1}"><span>男</span></c:if>
						<c:if test="${data.sex==2}"><span>女</span></c:if>
					</TD>
					<TD align=center>
						${data.age}
					</TD>
					<TD align=center>
						<c:set var="birthDate" scope="request" value="${data.birth}"  />
						${data.birth}
					</TD>
					<TD align=center>
						${data.tel}
					</TD>
					<TD align=center>
						${data.education}
					</TD>
					<TD align=center>
						${data.department.name}
					</TD>
					<TD align=center>
						${data.groups.groupName}
					</TD>
					<TD align=center>
						${data.empNo}
					</TD>
					<TD align=center>
						${data.entryTime}
					</TD>
					<TD align=center>
						<c:if test="${data.isLeave==1}">在职</c:if>
						<c:if test="${data.isLeave==0}">离职</c:if>
					</TD>
				</TR>
				</c:if>
				<c:if test="${emp.department.depNo ==111 && data.department.depNo == 111}">
				<TR>
					<TD align=center height=25 >
						<span>${data.name}</span>
					</TD>
					<TD align=center>
					    <c:if test="${data.sex==1}"><span>男</span></c:if>
						<c:if test="${data.sex==2}"><span>女</span></c:if>
					</TD>
					<TD align=center>
						${data.age}
					</TD>
					<TD align=center>
						<c:set var="birthDate" scope="request" value="${data.birth}"  />
						${data.birth}
					</TD>
					<TD align=center>
						${data.tel}
					</TD>
					<TD align=center>
						${data.education}
					</TD>
					<TD align=center>
						${data.department.name}
					</TD>
					<TD align=center>
						${data.groups.groupName}
					</TD>
					<TD align=center>
						${data.empNo}
					</TD>
					<TD align=center>
						${data.entryTime}
					</TD>
					<TD align=center>
						<c:if test="${data.isLeave==1}">在职</c:if>
						<c:if test="${data.isLeave==0}">离职</c:if>
					</TD>
				</TR>
				</c:if>
			</c:forEach>
		</tbody>  
    	</table>
    	</div>
</HTML>
