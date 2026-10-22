<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="移交记录 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>移交记录列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
  </head>
  
<body onload="setdivwidth();" >
		<center><b>移交记录</b></center>
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr id="makelist">
			 <th>任务所属项目</th>
			 <th>任务名称</th>
			 <th>移交前负责人</th>
			 <th>移交后负责人</th>
			 <th>移交时进度</th>
			 <th>移交的时间</th>
			</tr>
			<%
				List recordlist=(List)request.getAttribute("recordlist");
			    if(recordlist.size()<=0){%>
			    <tr>
			    	<td colspan="6">很抱赚，没有移交任务记录！</td>
			    </tr>	
			    <%}if(recordlist.size()>0){
			%>
			
			<c:forEach items="${recordlist}" var="record" >
			     <tr>
					<td>
						${record.function.newProject.projectname}
					</td>
					<td>
					    ${record.function.functionname}
					</td>
					<td>
					    ${record.oldemp.name}
					</td>
					<td>
					    ${record.newemp.name}
					</td>	
					<td>
						${record.function.fstate}%
					</td>
					<td>
					    ${record.turntime}
					</td>
			     </tr>
			</c:forEach>
			<%} %>
		</table>
		
		</div>
	</body>
</html>
