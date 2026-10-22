<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>审批记录</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	   function showPage(dc){
		   var projectname=encodeURI(encodeURI($("#prjname").val(),"utf-8"));
		   var approveemp=encodeURI(encodeURI($("#approveemp").val(),"utf-8"));
		   var status=$("#status").val();
		   var sqr=encodeURI(encodeURI($("#sqr").val(),"utf-8"));
		   var apptime=$("#apptime").val();
		   form1.action="<%=path%>/appRecordListApprovalProject.do?projectname="+projectname+"&approveemp="+approveemp+"&status="+status+"&sqr="+sqr+"&apptime="+apptime+"&dc="+dc;
		   form1.submit();
	   }
   </script>
  </head>
  
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<input name="daonum" value="1" type="hidden" />
			<input name="curpage" id="curpage" type="hidden" value="" />
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr>
					<th>
						项目名称：
					</th>
					<td>
						<input type="text" id="prjname" value="${projectname }" />
					</td>
					<th>
						审批人:
					</th>
					<td>
						<input type="text" id="approveemp" value="${approveemp }" />
					</td>
					<th>
						审批状态:
					</th>
					<td>
						<select id="status">
						 	<option value="-1">--请选择--</option>
						 	<option value="0" <c:if test="${status==0 }">selected</c:if> >拒绝</option>
						 	<option value="1" <c:if test="${status==1 or status==2 }">selected</c:if> >通过</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>申请人：</th>
					<td>
					    <input type="text" id="sqr" value="${sqr }" />
					</td>
					
					<th>
					     审批时间:
					</th>
					<td><input type="text" id="apptime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${apptime}" /></td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
						<button type="button"  onclick="javascript:history.go(-1)"><span class="icon_back">返回</span></button>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</form>
    <span><a href="<%=path %>/listnewProject.do" title="点击查看项目列表">我的项目</a> << <a href="<%=path %>/waitProjectApprovalProject.do" title="查看待批项目">待批项目</a><< 审批记录</span>
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目名称</th>
			 <th>申请人</th>
			 <th>审批人</th>
			 <th>审批时间</th>
			 <th>审批意见</th>
			 <th>状态</th>
			</tr>
			<c:forEach items="${recordlist}" var="record">
				<tr>
				   <td>${record.projectname}</td>
				   <td>${record.applypeople}</td>
				   <td>${record.approveemp}</td>
				   <td>${record.apptime}</td>
				   <td style="word-break:break-all;word-wrap:break-word">${record.approveinfo}</td>
				   <td>	
				   	   <c:if test="${record.ispass==1}">通过</c:if> 
				   	   <c:if test="${record.ispass==2}">通过</c:if> 
				   	   <c:if test="${record.ispass==0}">拒绝</c:if>
				   </td>
				</tr>
			</c:forEach>
			<tr>
				<td id="page" colspan="6" align="center"><p:pages url="appRecordListApprovalProject.do?&funid=14" /></td>
			</tr>
		</table></div>
	</body>
</html>
