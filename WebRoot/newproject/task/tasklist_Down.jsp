<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyyMMddhhmmsss");
	Date now=new Date();
	String nowstr=dateFormat2.format(now);
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
	response.setCharacterEncoding("utf-8"); 
	String filename ="任务列表 "+nowstr+".xls";	
	filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
	response.setHeader("Content-Disposition", "attachment;" + " filename="+filename);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>任务列表导出</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	
  </head>
  
<body onload="setdivwidth();" >
		
		<!-- 数据显示  -->
		<center><b>任务列表</b></center>
		 <div id="resulthight" style="display:block">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr id="makelist">
			 <th>项目名称</th>
			 <th>任务名称</th>
			 <th>任务负责人</th>
			 <th>任务进度</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			</tr>
			<c:forEach items="${tasklist}" var="data" >
			     <tr>
					<td align=middle>
						${data.function.newProject.projectname}
					</td>
					<td align=middle>
					${data.function.functionname}
					</td>
					<td align=middle>
					${data.emp.name}
					</td>
					<td align=middle>
						${data.schedule}%
					</td>	
					<td align="middle">
					${data.begintime}
					</td>
					<td align="middle">
					${data.endtime}
					</td>
			     </tr>
			</c:forEach>
		</table>
		</div>
	</body>
</html>
