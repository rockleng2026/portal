<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.dao.impl.newproject.TaskProjectImpl"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.Taskplan_saleorder"%>
<%
	String path = request.getContextPath();
	TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>任务详细信息</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript">
	   function saleorderInfo(obj,obj2){
		   $.post("saleorderInfoTaskProject.do",{'id':obj,'marker':obj2},function(result){
		        var url = result+"&id="+obj;
		        window.location.href = url;
		   });
		}
 </script>
  </head>
  
<body onload="setdivwidth();" >
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    	    <%
				NewTask task=(NewTask)request.getAttribute("task");
			%>
			<tr id="makelist">
			 <td align="right"  class="rightbold"  width="30%">项目名称：</td>
			 <td align="left" width="70%"><%=task.getFunction().getNewProject().getProjectname() %></td>
			</tr>
			<tr>
			   <td  class="rightbold" align="right">任务名称：</td>
			   <td align="left"><%=task.getFunction().getFunctionname() %> </td>
			</tr>
			<tr>
			   <td align="right"  class="rightbold" >任务负责人：</td>
			   <td align="left">
					<%=task.getEmp().getName() %>
			   </td>
			</tr>
			<tr>
			   <td align="right"  class="rightbold" >任务进度：</td>
			   <td align="left">
						<%=task.getSchedule() %>%
			   </td>
			</tr>
			<tr>
			   <td align="right"  class="rightbold" >开始日期：</td>
			   <td align="left">
					<%=task.getBegintime() %>
			   </td>
			</tr>
			<tr>
			   <td align="right"  class="rightbold" >结束日期：</td>
			   <td align="left">
					<%=task.getEndtime() %>
			   </td>
			</tr>
			<tr>
			   <td align="right"  class="rightbold" >订单编号：</td>
			   <td align="left"  style="word-break:break-all;word-wrap:break-word">
					  <textarea rows="5" cols="5" style="display: none;" id="tsid"><c:forEach items="${ts}" var="ts2">${ts2.saleorderid},</c:forEach></textarea>
					  <%
						  //从任务、订单的中间表取数据
						  String hqlString = "from Taskplan_saleorder where taskid = "+task.getId();
						  List ts = taskdao.execHQL(hqlString);
						  for(int j=0;j<ts.size();j++){
						      Taskplan_saleorder s = (Taskplan_saleorder)ts.get(j);
						      String orderid=s.getSaleorderid()+",";
					   %>
					     <a href="javascript:saleorderInfo(<%=orderid %>'<%=s.getFlag() %>')"><%=orderid %></a>
					   <%} %>
				</td>
			</tr>
			<tr>
			   <td  class="rightbold"  align="right">任务内容：</td>
			   <td align="left"  style="word-break:break-all;word-wrap:break-word"><%=task.getFunction().getFunctioninfo()%></td>
			</tr>
		     <tr>
		        <td colspan="2">
		            <button type="button"  onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
		        </td>
		     </tr>
		</table>
		</div>
	</body>
</html>
