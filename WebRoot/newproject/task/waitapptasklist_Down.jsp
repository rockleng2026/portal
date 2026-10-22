<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.NewPrjtresource"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="待批任务列表 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>导出待批任务列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	
  </head>
  
<body onload="setdivwidth();" >
		<!-- 数据显示  -->
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目名称</th>
			 <th>任务名称</th>
			 <th>提交人</th>
			 <th>项目负责人</th>
			 <th>完成度</th>
			 <th>申请金额</th>
			 <th>提交日期</th>
			 <th>附件</th>
			 <th>申请金额描述</th>
			 <th>操作</th>
			</tr>
			<c:if test="${not empty waitapptask}">
				<% 
				   List waitapptask =(List)request.getAttribute("waitapptask"); 
				   Employee emp=(Employee)request.getAttribute("emp");
				   for(int i=0;i<waitapptask.size();i++){
					   NewPrjtresource resource=(NewPrjtresource)waitapptask.get(i);
				%>
					<tr>
					     <td>
                            <%=resource.getTask().getFunction().getNewProject().getProjectname() %>
					     </td>
					     <td align="left"><%=resource.getTask().getFunction().getFunctionname() %></td>
					     <td><%=resource.getEmpsubmit().getName() %></td>
					     <td><%=resource.getEmp().getName() %></td>
					     <td><%=resource.getTplan() %>%</td>
					     <td align="right"><%=resource.getNmoney()%></td>
					     <td><%=resource.getSubtime() %></td>
					     <td> 
					        <%=resource.getNfj() %>
					     </td>
					     <td align="left">
					        <%=resource.getRemakes() %>
					     </td>
					     <td>
					       <%
					       if(resource.getEmp().getId().equals(emp.getId())){
					          if(resource.getAppstatus()==0 || resource.getAppstatus()==2){
					        	  if(resource.getNmoney()<=emp.getApprovemoney()){
					       %>
					         <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,1)">通过</a>
					       <%}if(resource.getNmoney()>emp.getApprovemoney()){ %>
					         <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,2)">通过并上报</a>
					       <%} %>
					        <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,0)">拒绝</a>
					       <%}}if(resource.getAppstatus()==1){
					       %>
					                     <b>审批通过</b>					       
					       <%}if(!resource.getEmp().getId().equals(emp.getId()) && resource.getAppstatus()==2){ %>
					                    <b style="color: blue;">正在审批中...</b>
					       <%}if(!resource.getEmp().getId().equals(emp.getId()) && resource.getAppstatus()==0){ %>
					                    <b style="color: red;">审批未通过</b>
					       <%}if(resource.getAppstatus()==3){ %>
					                   <b style="color: red;">审批未通过</b>
					       <%} %>
					     </td>
					</tr>
				<%} %>
			</c:if>
			<c:if test="${empty waitapptask}">
			   <tr><td colspan="10" align="center">暂无数据。。。</td></tr>
			</c:if>
		</table>
	</body>
</html>
