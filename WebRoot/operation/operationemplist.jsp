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
    <title>员工业务</title>
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
		
		function showpage(){
		  var type = $("#type").val();
		  var time = $("#time").val();
		  var emp = $("#emp").val();
		  form1.action="<%=path %>/listEmployeeOperation.do?type="+type+"&time="+time+"&emp="+emp;
		  form1.submit();
		}
		
		//新增员工
		function add(){
		   var url = "<%=path%>/addEmpEmployeeOperation.do";
		   showWindwoButton('id','添加员工业务','800','550',url);
		}
		
		function checkform1(){
		  var type = $("#type").val();
		  var dept = $("#dept").val();
		  var money = $("#money").val();
		  if(type=="-1"){
		    alert("请选择类型");
		    return false;
		  }
		  if(dept=="-1"){
		    alert("请选择部门");
		    return false;
		  }
		  if(money=="" && money.length<=0){
		    alert("请填写金额");
		    return false;
		  }
		  parent.location.reload();
		}

	
	
   </script>
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="<%=request.getContextPath()%>/" onsubmit="checkform1()">	
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
						 <c:forEach items="${type}" var="type">
						   <option value="${type.id}">${type.name }</option>
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
				   <th style="width: 40px">员工:</th>
				   <td>
				     <select id="emp">
				       <option value="-1">请选择</option>
				       <c:forEach items="${emp}" var="emp">
				         <option value="${emp.id }">${emp.name }</option>
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
			 <th>员工</th>
			 <th>金额</th>
			 <th>创建时间</th>
			 <th>备注</th>
			</tr>
			
			<c:forEach items="${list}" var="emp">
			  <tr>
			   <td>
				   <input type="hidden" id="typeid" value="${emp.type.id}"/>
				   <input type="hidden" id="empid" value="${emp.employee.id}"/>
				   ${emp.id}
			  </td>
			   <td>${emp.type.name}</td>
			   <td>${emp.employee.name}</td>
			   <td align="right">${emp.money}</td>
			   <td>${emp.creatTime}</td>
			   <td align="left" style="word-break:break-all;word-wrap:break-word">${emp.explain}</td>
			  </tr>
			</c:forEach>
		
			<tr>
				<td id="page" colspan="11"><p:pages url="listEmployeeOperation.do?funid=14" /></td>
			</tr>
		</table>
		</div>
	</body>
</html>
