<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%
	String path = request.getContextPath();
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	   // 修改任务进度
		
		function showPage(dc){
			var projectname= encodeURI(encodeURI($("#projectname").val(),"utf-8"));
			var functionname=encodeURI(encodeURI($("#functionname").val(),"utf-8"));
			var turntime=$("#turntime").val();
			var oldempname=encodeURI(encodeURI($("#oldempname").val(),"utf-8"));
			var newempname=encodeURI(encodeURI($("#newempname").val(),"utf-8"));
			var fid=$("#fid").val();
			form1.action="<%=path %>/taskrecordTaskProject.do?fid="+fid+"&projectname="+projectname+"&functionname="+functionname+"&turntime="+turntime+"&oldempname="+oldempname+"&newempname="+newempname+"&dc="+dc;
			form1.submit();
		}

  
      
		
 </script>
  </head>
  
<body onload="setdivwidth();" >
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<input name="fid" id="fid" value="${fid }" type="hidden" />
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						项目名称
					</th>
					<td>
						<input type="text" id="projectname" name="projectname" value="${projectname }" />
					</td>
					<th>
					        任务名称：
					</th>
					<td>
						<input type="text" id="functionname" name="functionname" value="${functionname }" />
					</td>
					<th>
						移交时间：
					</th>
					<td>
						<input type="text" id="turntime" name="turntime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${turntime}" />
					</td>
				</tr>
				<tr>
				   <th>（前）负责人：</th>
				   <td>
				       <input type="text" id="oldempname" name="oldempname" value="${oldempname}" />
				   </td>
				   <th>（后）负责人：</th>
				   <td>
				       <input type="text" id="newempname" name="newempname" value="${newempname}" />
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
			 <th>任务所属项目</th>
			 <th>任务名称</th>
			 <th>移交前负责人</th>
			 <th>移交后负责人</th>
			 <th>移交时进度</th>
			 <th>移交的时间</th>
			</tr>
			<%
				Pages pagelist=(Pages)request.getAttribute("pages");
			    if(pagelist.getPageList().size()<=0){%>
			    <tr>
			    	<td colspan="6">很抱歉，没有移交任务记录！</td>
			    </tr>	
			    <%}if(pagelist.getPageList().size()>0){
			%>
			
			<c:forEach items="${pages.pageList}" var="record" >
			     <tr>
					<td>
						<a style="text-decoration: none;" href="<%=request.getContextPath()%>/newproject/question_project/alldetail.jsp" title="点击查看详细信息">
						${record.function.newProject.projectname}</a>
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
			<tr>
				<td id="page" colspan="6" align="center"> 
				   <pp:pages1 url="taskrecordTaskProject.do" param="fid=${fid }&openmethod=1"/>
				</td>
			</tr>
			<%} %>
		</table>
		
		</div>
	</body>
</html>
