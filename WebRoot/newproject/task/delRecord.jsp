<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.NewFunctionDelRecord"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
	String path = request.getContextPath();
    TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>删除任务记录列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	   // 修改任务进度
		
		function showPage(dc){
			var functionname= encodeURI(encodeURI($("#functionname").val(),"utf-8"));
			var tasktype=$("#tasktype").val();
			var begintime=$("#begintime").val();
			var endtime=$("#endtime").val();
			var deltime=$("#deltime").val();
			var pid=$("#pid").val();
			form1.action="<%=path %>/delRecordTaskProject.do?pid="+pid+"&functionname="+functionname+"&tasktype="+tasktype+"&begintime="+begintime+"&endtime="+endtime+"&dc="+dc+"&deltime="+deltime;
			form1.submit();
		}

  
      
		
 </script>
  </head>
  
<body onload="setdivwidth();" >
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
					        任务名称：
					</th>
					<td>
					    <input type="hidden" id="pid" value="${pid }"/>
						<input type="text" id="functionname" name="functionname" value="${functionname }" />
					</td>
					<th>
					        任务类型：
					</th>
					<td>
					   <select id="tasktype" name="tasktype">
					       <option value="-1">--请选择--</option>
					       <option value="0" <c:if test="${tasktype==0}">selected</c:if> >协同完成任务</option>
					       <option value="1" <c:if test="${tasktype==1}">selected</c:if>>独立完成任务</option>
					   </select>
					</td>
					<th>
						删除时间：
					</th>
					<td>
						<input type="text" id="deltime" name="deltime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${deltime}" />
					</td>
				</tr>
				<tr>
				    <th>任务周期:</th>
				    <td>
				        <input type="text" id="begintime" name="begintime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${begintime}" />至
				        <input type="text" id="endtime" name="endtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${endtime}" />
				    </td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<input name="zuanquswjgbm" id="zuanquswjgbm" type="hidden"  value="" />
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
						 <button type="button"  onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
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
				Pages pagelist=(Pages)request.getAttribute("pages");
			    if(pagelist.getPageList().size()<=0){%>
			    <tr>
			    	<td colspan="8">很抱赚，没有删除任务记录！</td>
			    </tr>	
			    <%}if(pagelist.getPageList().size()>0){
			    	for(int i=0;i<pagelist.getPageList().size();i++){
			    		NewFunctionDelRecord delrecord=(NewFunctionDelRecord)pagelist.getPageList().get(i);
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
			<%} %>
			
			<tr>
				<td id="page" colspan="8" align="center"> 
				   <pp:pages1 url="delRecordTaskProject.do" param="pid=${pid}&openmethod=1"/>
				</td>
			</tr>
			<%} %>
		</table>
		
		</div>
	</body>
</html>
