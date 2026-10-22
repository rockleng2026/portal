<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="分配任务 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
    TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>任务分配</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<style type="text/css">
	     .zjstyle{
	         border:1px solid blue;
	         background-color: white;
	     }
	</style>
  </head>
  
<body onload="setdivwidth();">
	<center><b>审批记录</b></center>
	<div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    	  <%
			List list=(List)request.getAttribute("tasklist");
		    if(list!=null){
    	  %>
			<tr>
			 <th>所属项目</th>
			 <th>任务名称</th>
			 <th>任务进度</th>
			 <th>开始时间</th>
			 <th>结束时间</th>
			 <th>任务内容</th>
			 <th>执行人</th>
			</tr>
			<%
				for(int i=0;i<list.size();i++){
					NewFunction function=(NewFunction)list.get(i);
					 int fid=function.getId();
			%>
				<tr>
				   <td><%=function.getNewProject().getProjectname() %></td>
				   <td><%=function.getFunctionname() %></td>
				   <td><%=function.getFstate() %>%</td>
				   <td><%=function.getBegintime() %></td>
				   <td><%=function.getEndtime() %></td>
				   <td><a href="#" title="<%=function.getFunctioninfo() %>"> <% if(function.getFunctioninfo()!=null){ %> <%=(function.getFunctioninfo().trim().length()>10?function.getFunctioninfo().substring(0,10)+"...":function.getFunctioninfo()) %> <%} %></a></td>
				   <td align="left" id="more<%=fid %>">
				      <%
			    	  List taskemp=taskdao.taskemp(fid);
			    	  if(taskemp.size()>0 && taskemp!=null){
			    		  int state=function.getFstate();
				      if(state==100){
				    	  if(taskemp.size()>5){
				    	  for(int j=0;j<6;j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				      	  <%=emp.getName() %>&nbsp;&nbsp;
				      <%}%>
				      <%}else{
				    	  for(int j=0;j<taskemp.size();j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				          <%=emp.getName() %>&nbsp;&nbsp;
				      <%}}}else{
				    	  if(taskemp.size()>5){
				    	  for(int j=0;j<6;j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				          <input type="checkbox" id="<%=emp.getId() %>" name="emp" value="<%=fid %>" /><%=emp.getName() %>&nbsp;&nbsp;
				      <%}%>
				      <%}else{
				    	  for(int j=0;j<taskemp.size();j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				          <input type="checkbox" id="<%=emp.getId() %>" name="emp" value="<%=fid %>" /><%=emp.getName() %> &nbsp;&nbsp;
				      <%}%>
				      <%}}}else{ %>
				                               当前任务还没有分配任何人员。
				      <%} %>
				   </td>
				</tr>
			<%
				}
			%>	
			<%}else{ %>
			<tr>
				<td>
					你不是项目负责人或你的项目下没有发布任何任务！
				</td>
			</tr>
			<%} %>
		</table>
	</div>
	</body>
</html>
