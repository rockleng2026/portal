<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.NewPrjtresource"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
  <head>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>待批任务列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
	<script src="<%=request.getContextPath()%>/js/My97DatePicker/Calendar2.js" type="text/javascript" language="javascript" charset="GBK"></script>
	<script type="text/javascript">
	   // 查看任务详情
		function selTaskInfo(taskid){
            var url = "<%=path%>/selTaskInfoTaskProject.do?taskid="+taskid;
			showWindwoButton('id','任务详情','800','550',url);
		}
		
		// 输入审批意见
		function writeYJ(approveid,status){
			$("#fd").show();
			$("#approveid").val(approveid);
			$("#status").val(status);
		}
		
		function hideEdit(){
			$("#fd").hide();
			$("#content").html("");
		}
		
		function showPage(dc){
			var projectname=encodeURI(encodeURI($("#projectname").val(),"utf-8"));
			var taskname=encodeURI(encodeURI($("#taskname").val(),"utf-8"));
		    var subtime=$("#subtime").val();
		    var subempname=encodeURI(encodeURI($("#subempname").val(),"utf-8"));
		    var appempname=encodeURI(encodeURI($("#appempname").val(),"utf-8"));
		    var appstatus=$("#appstatus").val();
			form1.action="<%=path %>/waitapptaskTaskProject.do?pageNo=0&dc="+dc+"&projectname="+projectname+"&taskname="+taskname+"&subtime="+subtime+"&subempname="+subempname+"&appempname="+appempname+"&appstatus="+appstatus;
			form1.submit();
		}

        function showfj(name){
	        window.location.href="downloadTaskUpload.do?url="+name;
        }

        // 审批
		function app(){
			var approveid=$("#approveid").val();
			var status=$("#status").val();
			var content=encodeURI(encodeURI($("#content").val(),"utf-8"));
			form2.action="<%=path%>/appTaskProject.do?approveid="+approveid+"&status="+status+"&content="+content;
			form2.submit(); 
		}

		//查看项目的详细信息
		function projectInfo(id){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id;
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
						项目名称
					</th>
					<td>
					   <input type="text" id="projectname" value="${projectname }" />
					</td>
					<th>
					        任务名称：
					</th>
					<td>
					   <input type="text" id="taskname" value="${taskname }" />
					</td>
					<th>提交日期：</th>
					<td><input type="text" id="subtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${subtime}" /></td>
				</tr>
				<tr>
				   <th>提交人：</th>
				   <td><input type="text" id="subempname"  value="${subempname }" /> </td>
				   <th>项目负责人：</th>
				   <td><input type="text" id="appempname" value="${appempname }" /> </td>
				   <th>审批状态：</th>
				   <td> 
				       <select id="appstatus">
				          <option value="-1">--请选择--</option>
				          <option value="0" <c:if test="${appstatus==0}">selected</c:if> >未通过</option>
				          <option value="1" <c:if test="${appstatus==1}">selected</c:if> >通过</option>
				          <option value="2" <c:if test="${appstatus==2}">selected</c:if> >审批中</option>
				       </select> 
				   </td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
		 <span>您现在的位置:<a href="<%=path %>/selectTaskProject.do?pid=-2" title="我的任务">我的任务</a> 》待批任务</span>
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
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
			<c:if test="${not empty pages.pageList}">
				<% 
				   Pages pages =(Pages)request.getAttribute("pages"); 
				   Employee emp=(Employee)request.getAttribute("emp");
				   for(int i=0;i<pages.getPageList().size();i++){
					   NewPrjtresource resource=(NewPrjtresource)pages.getPageList().get(i);
				%>
					<tr>
					     <td><a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('<%=resource.getTask().getFunction().getNewProject().getId() %>')">
					        <%=resource.getTask().getFunction().getNewProject().getProjectname() %></a>
					     </td>
					     <td align="left"><a style="text-decoration: none;" href="javascript:selTaskInfo(<%=resource.getTask().getId() %>);"  title="查看任务详细信息" ><%=resource.getTask().getFunction().getFunctionname() %></a></td>
					     <td><%=resource.getEmpsubmit().getName() %></td>
					     <td><%=resource.getEmp().getName() %></td>
					     <td><%=resource.getTplan() %>%</td>
					     <td align="right"><%=resource.getNmoney()%></td>
					     <td><%=resource.getSubtime() %></td>
					     <td align="left"> 
					        <a href="javascript:void();" style="text-decoration:none;" title="<%=resource.getTemp2() %>" onclick="showfj('<%=resource.getNfj() %>')">
					           <%if(resource.getNfj()!=null){ %> <%=resource.getTemp2().length()>7?resource.getTemp2().substring(0,7)+"...":resource.getTemp2() %><%} %>
					        </a>   
					     </td>
					     <td align="left">
					        <a  href="javascript:void();"  style="text-decoration:none;" title="<%=resource.getRemakes() %>">
					          <%if(resource.getRemakes()!=null){ %> <%=resource.getRemakes().length()>10?resource.getRemakes().substring(0,10)+"...":resource.getRemakes() %><%} %>
					        </a>
					     </td>
					     <td>
					       <%
					       if(resource.getEmp().getId().equals(emp.getId())){
					    	   Integer xx=resource.getAppstatus();
					    	 out.print(xx);
					          if(resource.getAppstatus()==0 || resource.getAppstatus()==2){
					        	  
					        	  Double s1=resource.getNmoney();
					        	  Double s2=emp.getApprovemoney();
					        		 out.print(s1);
					        		 out.print(s2);
					        	  if(resource.getNmoney()<=emp.getApprovemoney()){
					       %>
					         <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,1)">通过</a>
					       <%}if(resource.getNmoney()>emp.getApprovemoney()&&resource.getTask().getFunction().getNewProject().getEmployee().getName().equals(resource.getTask().getFunction().getNewProject().getLauncher())){%>
							 <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,1)">通过</a>					       
					        <%}else if(resource.getNmoney()>emp.getApprovemoney()&&emp.getId().equals(resource.getTask().getFunction().getNewProject().getEmployee().getId())){%>
					         <a href="javascript:void(0);" onclick="writeYJ(<%=resource.getId() %>,1)">通过</a>					
					       <%}if(resource.getNmoney()>emp.getApprovemoney() && !resource.getTask().getFunction().getNewProject().getEmployee().getId().equals(emp.getId())){ %>
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
				<tr>
				   <td id="page" colspan="10" align="center"><p:pages url="waitapptaskTaskProject.do?&funid=14" /></td>
				</tr>
			</c:if>
			<c:if test="${empty pages.pageList}">
			   <tr><td colspan="10" align="center">暂无数据。。。</td></tr>
			</c:if>
		</table></div>
		
		<!-- 弹出内容 -->
		<form action="" name="form2" id="form2" method="post">
			<div id="fd" style="display:none; filter:alpha(opacity=100);opacity:1;float: right;" >
				<table style="width:100%; text-align: center; height: 150px;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
				     <tr>
				        <th align="left">
				        	审批意见：
						   	<input type="hidden" name="approveid" id="approveid" value="" />
						   	<input type="hidden" name="status" id="status" value="" />
				        </th>
				     </tr>
		             <tr>
		                <td><textarea name="content" id="content"  style='width:450px;height:150px;'></textarea></td>
		             </tr>
		             <tr>
		                <td align="center">
		                   <button type="button" onclick="app()"><span class="icon_save">保存</span></button>
		                   <button type="button" onclick="hideEdit()"><span class="icon_close">关闭</span></button>
		                </td>
		             </tr>
				</table>
				<script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
			</div>
		</form>
	</body>
</html>
