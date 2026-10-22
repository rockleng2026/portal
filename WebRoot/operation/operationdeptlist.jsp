<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.vo.NewProject"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>部门业务</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
  </head>
  
  <script type="text/javascript">
	  // 修改项目
		function updateProject(id){
            var url = "<%=path%>/toupdnewProject.do?pid="+id;
			showWindwoButton('id','修改任务进度','800','550',url);
		}
		
		//新增部门
		function add(){
		   var url = "<%=path%>/addDeptDepartmentOperation.do";
		   showWindwoButton('id','添加部门业务','800','550',url);
		}
		
		
		function showpage(){
		   var type = $("#type").val();
		   var time = $("#time").val();
		   var dept = $("#dept").val();
		   form1.action="<%=path %>/listDepartmentOperation.do?type="+type+"&time="+time+"&dept="+dept;
		   form1.submit();
		}
		
	
	
	
   </script>
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						类型:
					</th>
					<td>
						<select id="type">
						
						 <option value="-1">请选择</option>
						 <c:forEach items="${typelist}" var="type">
						   <option value="${type.id}">${type.name}</option>
						 </c:forEach>
						</select>
					</td>
					<th>
					    创建时间:
					</th>
					<td>
					   <input type="text" id="time" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</td>
				</tr>
				<tr>
				   <th style="width: 40px">部门:</th>
				   <td>
				     <select id="dept">
				       <option value="-1">请选择</option>
				       <c:forEach items="${deptlist}" var="dept">
				         <option value="${dept.id}">${dept.name}</option>
				       </c:forEach>
				     </select>
				   </td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showpage()" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button type="button" onclick="add()" ><span class="icon_add">添加</span></button>
					</td>
					
				</tr>
			</table>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>编号</th>
			 <th>类型</th>
			 <th>部门</th>
			 <th>金额</th>
			 <th>创建时间</th>
			 <th>备注</th>
			</tr>
			
			<c:forEach items="${list}" var="dept">
			  <tr>
			   <td>${dept.id}</td>
			   <td>${dept.type.name}</td>
			   <td align="left">${dept.dept.name}</td>
			   <td align="right">${dept.money}</td>
			   <td>${dept.creatTime}</td>
			   <td align="left" style="word-break:break-all;word-wrap:break-word">${dept.explain}</td>
			  </tr>
			</c:forEach>
		
			<tr>
				<td id="page" colspan="11"><p:pages url="listDepartmentOperation.do?funid=14" /></td>
			</tr>
		</table>
		</div>
	</body>
</html>
