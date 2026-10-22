<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.NewFunctionDelRecord"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="删除记录 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
	TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>删除记录列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
  </head>
  
<body onload="setdivwidth();" >
		<center><b>删除记录</b></center>
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr id="makelist">
			 <th>任务名称</th>
			 <th>上级任务 </th>
			 <th>任务类型</th>
			 <th>任务进度</th>
			 <th>开始时间</th>
			 <th>结束时间</th>
			 <th>执行人</th>
			 <th>删除时间</th>
			</tr>
			<%
				List list=(List)request.getAttribute("list");
			    if(list.size()<=0){%>
			    <tr>
			    	<td colspan="8">很抱赚，没有删除任务记录！</td>
			    </tr>	
			    <%}if(list.size()>0){
			    	for(int i=0;i<list.size();i++){
			    		NewFunctionDelRecord delrecord=(NewFunctionDelRecord)list.get(i);
			%>
			<tr>
			   <td align="left"><%=delrecord.getFunction().getFunctionname() %></td>
			   <td>
			      <%
		              int parentid=delrecord.getFunction().getParentid();
		              NewFunction fun=new NewFunction();
		              if(parentid!=-1){
		            	  fun=(NewFunction)taskdao.getObj(NewFunction.class,parentid);
		              %>
		                 <%=fun.getFunctionname() %>	  
		              <%}else{%>
		              <%="无" %> 
			      <%}%>
			   </td>
			   <td><%=delrecord.getFunction().getFinishtasktype()==1?"独立完成任务":"协同完成任务" %> </td>
			   <td><%=delrecord.getFunction().getFstate() %>%</td>
			   <td><%=delrecord.getFunction().getBegintime() %></td>
			   <td><%=delrecord.getFunction().getEndtime() %></td>
			   <td align="left" style="word-break:break-all;word-wrap:break-word">
			      <%
			          List taskemp=taskdao.taskemp(delrecord.getFunction().getId());
			          if(taskemp.size()>0){
			        	  String str="";
			        	  for(int j=0;j<taskemp.size();j++){
			        	  	Employee emp=(Employee)taskemp.get(j);
			        	  	str+=emp.getName()+",";
			        	  }%>
			        	  <%=str %>
			          <%}else{%>暂无任何人员参与！<%}
			      %>
			   </td>
			   <td><%=delrecord.getDeldate() %></td>
			</tr>
			<%}} %>
		</table>
		
		</div>
	</body>
</html>
