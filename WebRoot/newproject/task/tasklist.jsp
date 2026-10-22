<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.dao.impl.newproject.TaskProjectImpl"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.Taskplan_saleorder"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.vo.CommonScfjb"%>
<%
	String path = request.getContextPath();
	TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
  <head>
  <style type="text/css">
  table th{text-align: right;}
  </style>
  	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
    <title>任务列表</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script src="<%=request.getContextPath()%>/js/My97DatePicker/Calendar2.js" type="text/javascript" language="javascript" charset="GBK"></script>
	<script type="text/javascript">
	   // 修改任务进度
		function updateTask(){
            var url = "<%=path%>/newproject/task/updateTaskPlan.jsp";
			showWindwoButton('id','修改任务进度','800','550',url);
		}
		
		function getPrjName(){
			var pid=$("#myprj").val();
			$.ajax({
				  type: "post",
				  url: "functionTaskProject.do",
				  data: {
					  "pid":pid
					  },
				  success: function(data){						  
				    	
				    	$("#function").html("");
				    	$("#function").html(data);
						 
				 }
				 });
		}
		function showPage(dc){
			form1.action="<%=path %>/selectTaskProject.do?pageNo=0&dc="+dc;
			form1.submit();
		}

        function showfj(name){

	        window.location.href="downloadTaskUpload.do?url="+name;
        }
        function projectInfo(id){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id;
		}
		
		
		function saleorderInfo(obj,obj2){
		 //  var temp2 = document.getElementById("ethip").options[window.document.getElementById("ethip").selectedIndex].value;
		 //  alert(temp2);
		   $.post("saleorderInfoTaskProject.do",{'id':obj,'marker':obj2},function(result){
		        var url = result+"&id="+obj;
		        window.location.href = url;
		   });
		}
		
		function getfj(url){
		 window.location.href="downloadTaskUpload.do?url="+url;
		}
		
		
 </script>
 <style type="text/css">
 .dd2{
  top: 20%;
  left:15%;
  width: 600px;
  height: 500px;
  position: absolute;
  z-index: 1000;
 
 
 
 }
	#BgDiv{background-color:#e3e3e3; position:absolute; z-index:99; left:0; top:0; display:none; width:100%; height:1000px;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}	 
		 </style>
  </head>
  
<body onload="setdivwidth();" >
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<input name="daonum" value="1" type="hidden" />
			<input name="curpage" id="curpage" type="hidden" value="" />
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						我参与的项目：
					</th>
					<td>
						<select id="myprj" name="pid"  onChange="getPrjName()">
						    <option value="0">--请选择项目--</option>
						     <c:forEach items="${prjlist}" var="data" >
						          <option value="${data.id }" <c:if test="${data.id==pid }">selected</c:if> >${data.projectname}</option>
                             </c:forEach>
						</select>
					</td>
					<th>
					        任务名称：
					</th>
					<td>
					   <select id="function" name="newtask.function.id">
					     <c:if test="${fid==null}">
					     	<option value="0">--请选择--</option>	
					     </c:if>
					      <c:if test="${fid!=null}">
					         <option value="${fid }">${fname }</option>
					      </c:if>
					   </select>
					</td>
					 <th>任务计划周期：</th>
				   <td><input type="text" id="begintime" name="newtask.begintime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${begintime}" />
				   至<input type="text" id="endtime" name="newtask.endtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${endtime }" /></td>
				</tr>
				
				<tr class="height24">
					<td colspan="8" style="padding-top: 10px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
					</td>
				</tr>
				
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: left;">
					<h3>
					<a href="<%=path %>/selectTaskProject.do?pid=-2" title="我的任务">我的任务</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="<%=path %>/buildmission.do" title="发布任务">发布任务</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=path %>/publishtaskTaskProject.do" title="分配任务">分配任务</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a href="<%=path %>/waitapptaskTaskProject.do" title="待批任务">待批任务</a>
					 </h3>
					</td>
					
				</tr>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight" style="display:block">
		 <span>您现在的位置：我的任务</span>
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr id="makelist">
			 <th>项目名称</th>
			 <th>上级任务</th>
			 <th>任务名称</th>
			 <th>任务负责人</th>
			 <th>任务进度</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			 <th style="display: none">订单编号</th>
			 <th style="display: none">查看附件</th>
			 <th>任务内容</th>
			 <th>操作</th>
			</tr>
			<%
				List list=(List)request.getAttribute("tasklist");
			    if(list.size()<=0){%>
			    <tr>
			    	<td colspan="11">很抱歉，最近这段时间没有安排任务！</td>
			    </tr>	
			    <%}if(list.size()>0){
			%>
			
			<%
			   for(int i=0;i<list.size();i++){
			        NewTask task=(NewTask)list.get(i);
			 %>
			     <tr >
			        <td >
			           <a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('<%=task.getFunction().getNewProject().getId() %>')">
			           <%=task.getFunction().getNewProject().getProjectname() %></a>
			        </td>
			        <td>
			           <%
			              int parentid=task.getFunction().getParentid();
			              NewFunction fun=new NewFunction();
			              if(parentid!=-1){
			            	  fun=(NewFunction)taskdao.getObj(NewFunction.class,parentid);
			              %>
			                 <%=fun.getFunctionname() %>	  
			              <%}else{%>
			            	 <%="无" %> 
			              <%}%>
			        </td>
					<td align="left">
					    <%=task.getFunction().getFunctionname() %> 
					</td>
					<td>
					<%=task.getEmp().getName() %>
					</td>
					<td>
						<%=task.getSchedule() %>%
					</td>	
					<td>
					<%=task.getBegintime() %>
					</td>
					<td>
					<%=task.getEndtime() %>
					</td>
					
					
					<td align="left" style="word-break:break-all;word-wrap:break-word;width: 10px;display: none">
					  <textarea rows="5" cols="5" style="display: none;" id="tsid"><c:forEach items="${ts}" var="ts2">${ts2.saleorderid},</c:forEach></textarea>
					  <%
						  //从任务、订单的中间表取数据
						  String hqlString = "from Taskplan_saleorder where taskid = "+task.getId()+" and status=1";
						  List ts = taskdao.execHQL(hqlString);
						  for(int j=0;j<ts.size();j++){
						      Taskplan_saleorder s = (Taskplan_saleorder)ts.get(j);
						      String orderid=s.getSaleorderid()+",";
					   %>
					   	 <input type="hidden" value="<%=orderid %>" id="saleorder<%=task.getId() %>"/>
					   	  <input type="hidden" value="<%=s.getFlag() %>" id="salevalue<%=task.getId() %>"/>
					     <a href="javascript:saleorderInfo(<%=orderid %>'<%=s.getFlag() %>')"><%=orderid %></a>
					   <%} %>
					</td>
					
					<td align="left" style="display: none">
					<%String hql="From CommonScfjb where tmp1="+task.getFunction().getId()+"and tmp='Function'";
					  List CommonScfjblist=taskdao.execHQL(hql);
					  CommonScfjb commonScfjb=null;
					  if(CommonScfjblist.size()!=0){ 
					  commonScfjb=(CommonScfjb)CommonScfjblist.get(0);%><input type="hidden" value="<%=commonScfjb.getFjlj()%>" id="fj<%=task.getId() %>"/><a href="javascript:getfj('<%=commonScfjb.getFjlj()%>')" title="<%=commonScfjb.getFjmc()+"."+commonScfjb.getFjhz() %>"><%=commonScfjb.getFjmc().trim().length()>7?commonScfjb.getFjmc().substring(0,7)+".....":commonScfjb.getFjmc()+"."+commonScfjb.getFjhz() %></a>
					  <%}
					  else if(task.getFunction().getParentid()!=-1){String hql2="From CommonScfjb where tmp1="+task.getFunction().getParentid()+"and tmp='Function'";
					  List CommonScfjblist2=taskdao.execHQL(hql2); 
					  if(CommonScfjblist2.size()!=0){
					  CommonScfjb commonScfjb2=null;
					  commonScfjb2=(CommonScfjb)CommonScfjblist2.get(0);%><input type="hidden" value="<%=commonScfjb2.getFjlj()%>" id="fj<%=task.getId() %>"/><a href="javascript:getfj('<%=commonScfjb2.getFjlj()%>')" title="<%=commonScfjb2.getFjmc()+"."+commonScfjb2.getFjhz() %>"><%=commonScfjb2.getFjmc().trim().length()>7?commonScfjb2.getFjmc().substring(0,7)+".....":commonScfjb2.getFjmc()+"."+commonScfjb2.getFjhz() %></a><%} %>
					 <%} %>
					 
					</td>
					<input type="hidden" id="nr<%=task.getId() %>" value="<%=task.getFunction().getFunctioninfo() %>"/>

					<td align="left"><a href="javascript:void(0)" title="点击'详情'查看详细信息"  style="text-decoration: none;" > <% if(task.getFunction().getFunctioninfo()!=null){ %> <%=(task.getFunction().getFunctioninfo().trim().length()>10?task.getFunction().getFunctioninfo().substring(0,10)+"...":task.getFunction().getFunctioninfo()) %> <%} %></a></td>

					<td>
					    <a href="javascript:detali('<%
			              int parentid1=task.getFunction().getParentid();
			              NewFunction fun1=new NewFunction();
			              if(parentid1!=-1){
			            	  fun1=(NewFunction)taskdao.getObj(NewFunction.class,parentid1);
			              %>
			                 <%=fun1.getFunctionname() %>	  
			              <%}else{%>
			            	 <%="无" %> 
			              <%}%>','<%=task.getFunction().getFunctionname() %>','<%=task.getEmp().getName() %>','<%=task.getSchedule() %>','<%=task.getBegintime() %>','<%=task.getEndtime() %>','<%=task.getFunction().getId() %>','<%=task.getId() %>','<%=task.getId() %>')">详情</a>
					    <a href="<%=request.getContextPath()%>/handleTaskTaskProject.do?taskid=<%=task.getId() %>" title="任务进度更进">办理</a>
					</td>
			     </tr>
		  <%} %>
			<tr>
				<td id="page" colspan="11" align="center"><p:pages url="selectTaskProject.do?&funid=14" /></td>
			</tr>
			<%} %>
		</table>
		
		 <script type="text/javascript">
		 
		function detali(v1,v2,v3,v4,v5,v6,v7,v8,v10){//v10对应ide 
          $("#v1").text(v1);
          $("#v2").text(v2);
          $("#v3").text(v4+"%");
          $("#v4").text(v3);
          $("#v5").text(v5);
          $("#v6").text(v6);
			$("#v9").text("");
          $("#v9").append($("#nr"+v10).val());
          
           
         var a=$("#saleorder"+v10).val();
       	 var b= $("#salevalue"+v10).val();
         var c= $("#fj"+v10).val();
     
	
			if(c!=undefined){
				$("#fjlj").text("");
			$("#fjlj").append("<a href='javascript:getfj("+'"'+c+'"'+")'>附件(点击打开)</a>");
			
			}
			if(a!=undefined && b!=undefined){
				$("#v11").text("");
			$("#v11").append("<a href='javascript:saleorderInfo("+'"'+a+b+'"'+")'>"+a+"</a>");
			}
			document.getElementById("ddd2").style.display="block";
			document.getElementById("BgDiv").style.display="block";				
			//$("#ddd2").show():

			}
		 
		 function colsediv1(){
			 document.getElementById("ddd2").style.display="none";
				document.getElementById("BgDiv").style.display="none";		
			
			 }
		 </script>
		 
		  <div class="dd2" id="ddd2" style="display: none">
    	<table style="width:80%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th colspan="4">任务详细信息</th>
			</tr>
					<tr>
			 <td>上级任务</td>
			 <td id="v1">项目编号</td>
			  <td>任务名称</td> 
			  <td id="v2">项目编号</td> 
			 
			</tr>
				<tr>
			 <td>任务进度</td>
			 <td id="v3">项目编号</td>
			  <td>任务负责人</td>
			 <td id="v4">项目编号</td>
			 
			</tr>
			<tr>
			 <td>开始日期</td> 
			  <td id="v5">项目编号</td> 
			 
			  <td>结束日期</td>
			 <td id="v6">项目编号</td>
			</tr>
				 		<tr>
			 <td>订单编号</td>
			 <td colspan="3" id="v11">&nbsp;</td>
			</tr>
			<tr>
				 <td>查看附件</td> 
			  	 <td colspan="3" id="fjlj"></td>
			</tr>
			<tr>
				 <td>任务内容</td>
			 <td colspan="3" id="v9">&nbsp;</td>
			</tr>
			<tr>
				 <td colspan="4"><input type="button" onclick="javascript:colsediv1()" value="关闭"/></td>
			
			</tr>
			</table>
			
			</div>
		</div>
		 <div id="BgDiv" style="display: none" ></div>
	</body>
</html>
