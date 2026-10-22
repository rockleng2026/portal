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
    <title>我的项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
  <style type="text/css">
  table th{text-align: right;}
  </style>
  </head>
  
  <script type="text/javascript">
	 //删除操作
	 function delproject(id){
	   if(confirm("你确定要删除这个项目吗?")){
		   var url = "<%=path%>/delnewProject.do";
	      $.post(url,{'pid':id},function(result){
	          if(result=="OK"){
	            alert("删除成功!");
	            window.location.href="<%=request.getContextPath()%>/listnewProject.do";
	          }
	          if(result=="ERROR"){
	            alert("删除失败!");
	          }
	     });
	   }
	 }
	 
	  // 修改项目
		function updateProject(id){
            var url = "<%=path%>/toupdnewProject.do?pid="+id;
			showWindwoButton('id','修改任务进度','800','550',url);
		}
		
		//项目变更操作
		function changeProject(id){
		   var url = "<%=path%>/tochangenewProject.do?pid="+id;
		   showWindwoButton('id','修改任务进度','800','550',url);
		}
		
		//变更已超时的项目
		function changeProject2(id){
		  var url = "<%=path%>/tochange2newProject.do?pid="+id;
		   showWindwoButton('id','修改任务进度','800','550',url);
		}
		
		//项目详细信息
		function projectInfo(id1,id2){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id1+"&projectstatus="+id2;
		}
		
		function fresh(){
		  location.reload();
		}
		
		//页面顶端查询,点击清空按钮,恢复原始状态
		function clearall(){
		  $("#begin,#end").val("");
		  $("#myprj,#function").val("-1");
		}
		
		//页面按开始时间和结束时间查询
		function showpage(dc){
			var projectname= encodeURI(encodeURI($("#projectname").val(),"utf-8"));
			var status=$("#status").val();
			var begintime=$("#begin").val();
			var endtime=$("#end").val();
			form1.action="<%=path %>/listnewProject.do?dc="+dc+"&projectname="+projectname+"&status="+status+"&begintime="+begintime+"&endtime="+endtime;
			form1.submit();	  
		}

		//项目消费记录
		function moneyrecord(id){
		   var url = "<%=path%>/findbyresourceQuestionProject.do?idnp="+id;
		   showWindwoButton('','项目消费记录','900','550',url);
		}
	
		
		   </script>
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						我参与的项目:
					</th>
					<td>
						<input type="text" id="projectname" value="${projectname }" />
					</td>
					<th>
					    状态:
					</th>
					<td>
					   <select id="status" style="width: 100px;">
					       <option value="-1">--全部--</option>
					       <option value="0" <c:if test="${projectstatus==0 }">selected</c:if> />立项中</option>
					       <option value="1" <c:if test="${projectstatus==1 }">selected</c:if> />审批中</option>
					       <option value="2" <c:if test="${projectstatus==2 }">selected</c:if> />进行中</option>
					       <option value="3" <c:if test="${projectstatus==3 }">selected</c:if> />已超时</option>
					       <option value="4" <c:if test="${projectstatus==4 }">selected</c:if> />已结束</option>
					   </select>
					</td>
					<th>任务计划周期:</th>
				   <td><input type="text" id="begin" style="width: 90px;" name="project.begintime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${begintime}" />
				                    至<input type="text" id="end" style="width: 90px;" name="project.endtime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${endtime}" />
				        <font color="red" size="2">*</font><font color="red" id="time" size="2"></font>
				   </td>
				</tr>
				
				<tr class="height24">
					<td colspan="8" style="padding-top: 10px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showpage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showpage(1)"  ><span    class="icon_xls">导出</span></button>
					</td>
				</tr>
					<tr class="height24">
					<td  style="padding-top: 4px;padding-bottom: 4px;text-align: left">
					<h3><a href="listnewProject.do" title="回到我的项目">我的项目</a></h3>
					</td>
					<td  style="padding-top: 4px;padding-bottom: 4px;text-align: left">
					<h3>
				 <a href="waitProjectApprovalProject.do" title="回到待批项目">待批项目</a>
                   </h3>
	</td>
				</tr>
			</table>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight">
		 <span>您现在位置：我的项目</span>
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目编号</th>
			 <th>项目名称</th>
			 <th>项目发起人</th>
			 <th>项目审批人</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			 <th>项目进度</th>
			 <th>项目资金</th>
			 <th>状态</th>
			 <th>操作</th>
			</tr>
			<c:forEach items="${projectlist}" var="project">
			<tr>
			   <td>${project.id }</td>
			   <td>

			   <c:choose>
			   <c:when test="${project.temp1 =='1' || project.temp2 == '1' || project.temp3 == '1'}">
			   <a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('${project.id}','${project.projectstatus}')">
			     ${project.projectname }
			   </a>
			   </c:when>
			  <c:otherwise>
			     ${project.projectname }
			  </c:otherwise>
			   </c:choose>
			   </td>
			   <td>${project.launcher}</td>
			   <td>${project.employee.name}</td>
			   <td>${project.begintime}</td>
			   <td>${project.endtime}</td>
			   <td>${project.schedule}%</td>
			   <td>${project.money}</td>
			   <td>
			   <c:if test="${project.projectstatus==0}">
			           立项中
			   </c:if>
			   <c:if test="${project.projectstatus==1}">
			           审批中
			   </c:if>
			   <c:if test="${project.projectstatus==2}">
			          进行中
			   </c:if>
			   <c:if test="${project.projectstatus==3}">
			           已超时
			   </c:if>
			   <c:if test="${project.projectstatus==4}">
			           已结束
			   </c:if>
			   </td>
			   <td>
			   <c:if test="${project.projectstatus==0}">
			    <c:choose>
			      <c:when test="${project.temp3=='1'}">
			     <a style="text-decoration: none;" href="javascript:updateProject(${project.id})">编辑</a>||
			     <a style="text-decoration: none;" href="javascript:delproject(${project.id})">删除</a>
			     </c:when>  
			     <c:otherwise>
			         编辑||删除
			     </c:otherwise>
			       </c:choose> 
			     
			   </c:if>
			    <c:if test="${project.projectstatus==1}">
			       --
			    </c:if>
			    <c:if test="${project.projectstatus==2}">
			     <c:choose>
			      <c:when test="${project.temp3=='1'}">
			        <a style="text-decoration: none;" href="javascript:changeProject(${project.id})">变更</a>
			        --<a href="javascript:moneyrecord(${project.id});">消费记录</a>
			      </c:when>
			     <c:otherwise>
			                       变更--
			        <a href="javascript:moneyrecord(${project.id});">消费记录</a>
			     </c:otherwise>
			     </c:choose>
			    </c:if>
			    <c:if test="${project.projectstatus==3}">
			     <c:choose>
			      <c:when test="${project.temp3=='1'}">
			       <a style="text-decoration: none;" href="javascript:changeProject2(${project.id})">变更</a>
			       --<a href="javascript:moneyrecord(${project.id});">消费记录</a>
			       </c:when>
			       <c:otherwise>
			                         变更--
			        <a href="javascript:moneyrecord(${project.id});">消费记录</a>
			       </c:otherwise>
			     </c:choose>
			    </c:if>
			    <c:if test="${project.projectstatus==4}">
			      <a href="javascript:moneyrecord(${project.id});">消费记录</a>
			    </c:if>
			    
			   </td>
			</tr>
			</c:forEach>
			<tr>
				<td id="pageNo" colspan="11"><p:pages url="listnewProject.do?funid=14" /></td>
			</tr>
		</table>
		</div>
	</body>
</html>
