<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.NewProject"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.opensymphony.xwork2.inject.util.Function"%>
<%@page import="com.fuao.fajxc.vo.CommonScfjb"%>
<%@page import="com.fuao.fajxc.dao.newproject.Project"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	Project taskdao=(Project)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
	　　<title>详情列表</title>
	   <jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<script language="javascript">
		// 编辑器
		var objid;
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="content"]', {
				resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : false,
				items : [
	'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
	'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
	'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
			});			
		});
				// 创建问题
				function add(){           
		            var url = "<%=path%>/newproject/question_project/addquestion.jsp";  
					showWindwoButton('id','创建问题列表','800','550',url);          
				}  
				// 问题详情
				function details(){
					var url = "<%=path%>/newproject/question_project/details.jsp";  
					showWindwoButton('id','问题详情','800','550',url);  
				}
				// 显示编辑器
				function showEdit(){
					$("#fd").show();
				}
				// 隐藏编辑器
				function hideEdit(){
					$("#fd").hide();
				}
				//下载附件
				function showfj(name){
				var url = encodeURI(name,'GBK');
	        window.location.href="downloadTaskUpload.do?url="+url;
        }
        //加载项目流程
        function getprocedures(a){
       
       
        window.location.href="getProceduresApprovalProject.do?projectid="+a;
        }
		</script>
		
</head>
<body>
<div align="center">
  <font color="blue"><h1><b>项目详细信息</b></h1></font>
</div>
<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
	<div class="searchDiv"  id="searchDiv" >
	<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0"　class="tableStyle"  cellpadding="0" id="youshuju" >
	    <tr align="center" style="font-size: 14px;font-weight: bold;" >
	       <td style="width: 33%;border-right: 1px solid #89aad7"><img src="<%=request.getContextPath()%>/icons/sanj.jpg"/>项目信息</td><td style="border-right: 1px solid #89aad7"><img src="<%=request.getContextPath()%>/icons/sanj.jpg"/>项目跟踪</td><td><img src="<%=request.getContextPath()%>/icons/sanj.jpg"/>项目交流</td>
	    </tr>
	  
		<tr style="font-size: 12px;font-weight: bold;">
		
		  <td style="border-right: 1px solid #89aad7" align="center"><img src="<%=request.getContextPath()%>/icons/cir.jpg"/>基本信息<br/>
		  <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="<%=path %>/appRecordListApprovalProject.do">审批记录</a></td>
		  <td style="border-right: 1px solid #89aad7" align="center"><img src="<%=request.getContextPath()%>/icons/cir.jpg"/>
		      <a href="<%=path %>/selectTaskProject.do?npid=${p.id}">任务列表</a>&nbsp;&nbsp;&nbsp;&nbsp;  
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="<%=path%>/projectGTTnewProject.do">甘特图</a> <br/>  
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="<%=path %>/QuestionListQuestionProject.do">问题跟踪</a>&nbsp;&nbsp;&nbsp;&nbsp; 
		      <c:if test="${status!=0}">
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="javascript:void(0);" onclick="getprocedures(' ${p.id}');" > 项目审批流程</a></td><td align="center">
		      </c:if> 
		      <c:if test="${status==0}">
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/> 项目流程</td><td align="center">
		      </c:if>
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="<%=path %>/selectQuestionProject.do">讨论问题</a><br/> 
		      <img src="<%=request.getContextPath()%>/icons/cir.jpg"/><a href="<%=path%>/findByscheduleplanQuestionProject.do">领导评价</a></td>
		</tr>
	</table>
</div></div>
  
<div id="resulthight">
	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	       <tr>
	         <td colspan="2">
	          当前位置:<a style="text-decoration: none;" href="listnewProject.do"><font color="blue"><b>我的项目</b></font></a>>>项目详细信息
	         </td>
	       </tr>
	       <tr>
	           <td colspan="6"  align="left" >
	            	<h3>一、项目基本信息</h3>
	           </td>
	        </tr>
	        
	    	<tr>
	    	<td width="14%" align="center"><strong>项目编号:</strong></td>
	    	<td  align="left">
	    	  ${p.id}
	    	</td>	
	    	</tr>
		<tr>
 		    <td width="10%" align="center"><strong>项目名称:</strong></td>
	    	<td>${p.projectname}</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>项目创建者:</strong></td>
	    	<td>${p.launcher}</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>参与部门:</strong></td>
	    	<td>
	    	 <c:forEach items="${d}" var="dept">
	    	  ${dept.dept.name},
	    	 </c:forEach>
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>计划周期:</strong></td>
	    	<td>${p.begintime}至${p.endtime}</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>项目进度:</strong></td>
	    	<%
	    	  NewProject proj  = (NewProject)request.getAttribute("p");
	    	 %>
	    	<td style="word-break:break-all;word-wrap:break-word">
	    	<%=proj.getSchedule()+"%" %>
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>项目功能列表:</strong></td>
	    	<td style="word-break:break-all;word-wrap:break-word">
	    	<% List<NewFunction> functionlist=(List)request.getAttribute("functionlist"); 
	    	   String fun="";
	    	   for(int i=0;i<functionlist.size();i++){
	    	   fun+=","+functionlist.get(i).getFunctionname();
	    	   }
	    	   String funs=fun.replaceFirst(",","");
	    	%>
	    	<%=funs %>
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>项目描述:</strong></td>
	    	<%
	    	  NewProject project  = (NewProject)request.getAttribute("p");
	    	 %>
	    	<td style="word-break:break-all;word-wrap:break-word">
	    	${p.projectinfo}
	    	
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="10%" align="center"><strong>查看附件</strong></td>
	    	 <td style="word-break:break-all;word-wrap:break-word"><c:forEach items="${CommonScfjblist}" var="data"  varStatus="count" >
	    	     <a href="javascript:showfj('${data.fjlj}')" title="${data.fjmc}.${data.fjhz}">${data.fjmc}.${data.fjhz}</a>，
	    	     </c:forEach>
	    	 </td>
	    	</tr>
	</table>
</div>

<div id="resulthight">
	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	        <tr>
	           <td colspan="6"  align="left" >
	            	<h3>二、项目成员信息</h3>
	           </td>
	        </tr>
		<tr>
 		    <td width="14%" align="center"><strong>项目创建者：</strong></td>
	    	<td>${p.launcher}</td>	
	    	</tr>
	    	<tr>
	    	<td width="14%" align="center"><strong>项目查看人：</strong></td>
	    	<td>
	    	  <c:forEach items="${e}" var="e">
	    	    ${e.emp.name},
	    	  </c:forEach>
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="14%" align="center"><strong>项目参与人：</strong></td>
	    	<td>
	    	 <c:forEach items="${cyrlist}" var="cyr">
	    	   ${cyr.employee.name},
	    	 </c:forEach>
	    	</td>	
	    	</tr>
	    	<tr>
	    	<td width="14%" align="center"><strong>项目审批人：</strong></td>
	    	<td>${p.employee.name}</td>	
	    	</tr>
	</table>

	
	<!-- 编辑器内容 -->
	<form action="" name="" method="post">
	<div id="fd" style="display:none; filter:alpha(opacity=100);opacity:1;float: right;" >
		<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
		     <tr>
		        <td colspan="2" align="left"><h3>项目问题处理</h3></td>
		     </tr>
		     <tr>
		     	<th>汇报时间：</th>
		     	<td align="left"><input type="text" onclick="WdatePicker()" /></td>
		     </tr>
             <tr>
             	<th>汇报结果处理：</th>
                <td><textarea name="content" id="content" class="textarea"  style='width:450px;height:150px;'></textarea></td>
             </tr>
             <tr>
                <td align="center" colspan="2">
                   <button type="button" onclick="showCont()"><span class="icon_save">保存</span></button>
                   <button type="button" onclick="hideEdit()"><span class="icon_close">关闭</span></button>
                </td>
             </tr>
		</table>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
	</div>
	</form>
</div>

</body>
</html>