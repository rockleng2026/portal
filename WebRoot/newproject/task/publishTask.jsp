<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.vo.CommonScfjb"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%
	String path = request.getContextPath();
    Date date=new Date();
    java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String nowstr= dateFormat2.format(date); 
    TaskProject taskdao=(TaskProject)request.getAttribute("taskdao");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>任务分配</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<style type="text/css">
	     .zjstyle{
	         border:1px solid blue;
	         background-color: white;
	     }
	</style>
	<link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
	<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath() %>/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript">
	// 显示编辑器
	   function showEdit(obj){
		   objid=obj.id;
		   $("#fd").show();
	   }
	   function hideEdit(){
		   $("#fd").hide();
	   }
	// 显示内容
	   function showCont(){
		   $("#fd").hide();
		   editor.sync();  
		   var cont= editor.html();
		   var c=cont.substring(0,8);
		   if(c.length>=8){
			   c=c+"...";
		   }
		   $("#"+objid).attr("title",cont);
		   $("#"+objid).html(c);
	   }
	
		var uploadcount= 0;   
		var uploadsum=6;
		  function addUploadRow(){
			if(uploadcount < uploadsum){
				
			var uploadht = "<tr  class='zjstyle' id=uploadrow"+uploadcount+" aligh='center'><td><input type='text' style='border:1px solid #ccc;background-color: white; height:20px; width:100px;' id='taskname"+(uploadcount+1)+"'></td><td><a id='bj"+uploadcount+"' href='javascript:void();' onclick='showEdit(this)'  title='点击编辑内容'>编辑</a></td><td><%=nowstr%></td><td><input type='text'  class='Wdate' style='width:90px;'  onclick='WdatePicker()' id='taskendtime"+(uploadcount+1)+"'></td><td align='left' colspan='2'><input type='checkbox' id='zxr"+(uploadcount+1)+"' >张三，<input type='checkbox' id='zxr"+(uploadcount+1)+"' >李四</td></tr>";
			 $("#addTask").append(uploadht);
				uploadcount++;
			}else{
				alert("只允许添加"+uploadsum+"行");
			}
		}
		function delUploadRow(){
		 	var nowuploadrow = uploadcount-1;
		    if( nowuploadrow <= -1){
		    	alert("没有可减少的行！");
		    	return false;
		    }
		 	$('#uploadrow'+nowuploadrow).remove();
		 	uploadcount--;
		 }

		//勾选所有要删除项
		function CheckA(form)  {
			  for (var i=0;i<form.elements.length;i++)    {
			    var e = form.elements[i];
			    if (e.name == 'ids')
			    	e.checked = form.chkall.checked; 
			  }
		}

		// 判断选中执行人还是选中任务两个只能选中一个
		function checkEmpOrTask(){
			var empflag=0;
			var taskflag=0;
			var empcheck=document.getElementsByName("emp");
			var taskcheck=document.getElementsByName("ids");
			var tendtime=$("#tendtime").val();
			var emptask="";
			for(var i=0;i<empcheck.length;i++){
				if(empcheck[i].checked==true){
					var id=empcheck[i].id;
					var fid=empcheck[i].value;
					var empno=$("#empno").val();
					if(empno.length<=0){
						alert("请选择移交人！");
						return;
					}
					// 得到员工编号以及员工所在的任务编号
					emptask+=id+"|"+fid+",";
					$("#emptask").val(emptask);
					empflag=1;
				}
			}
			for(var i=0;i<taskcheck.length;i++){
				if(taskcheck[i].checked==true){
					taskflag=1;
				}
			}
			if(empflag==1 && taskflag==1){
				alert("鱼与熊掌不能兼得！");
				return;
			}
			if(empflag==0 && taskflag==0){
				alert("没有选择任何可移交人员或任务！");
				return;
			}
			// 移交人员任务
			if(empflag==1){
				var empno=$("#empno").val();
				$.ajax({
					  type: "post",
					  url: "<%=path%>/moveEmpTaskProject.do",
					  data: {
						  "emptask":emptask,
						  "empno":empno,
						  "tendtime":tendtime
						  },
					  success: function(data){						  
					    	alert(data); 
					    	window.location.href="<%=path %>/publishtaskTaskProject.do";
					 }
				});
			}
			
		}

		// 查看更多参与人
		function more(fid,flag){
			 
			$.ajax({
				  type: "post",
				  url: "moreTaskProject.do",
				  data: {
					  "fid":fid,
					  "flag":flag
					  },
				  success: function(data){						  
				    	
				    	$("#more"+fid).html("");
				    	$("#more"+fid).html(data);
						 
				 }
				 });
		}

		// 显示参与人
		function cyr(fid){
		    var xmid = $("#xmid").val();
		    alert(xmid);
		    $.post('transferTaskProject.do',{'xmid':xmid},function(data){
		       alert(data);
		    });
			$("#pubfid").val(fid);
			$("#cyemp").show();
		}
		//点击参与人员的关闭连接，隐藏层
	    function closecyemp(){
	      $("#cyemp").hide();
	    }
	    // 得到参与人ID
	    function getempno(){
	    	var empcheck=document.getElementsByName("cyr");
	    	var empno="";
	    	for(var i=0;i<empcheck.length;i++){
		    	if(empcheck[i].checked==true){
			    	empno+=empcheck[i].id+",";
			    }
	    	}
	    	$("#empno").val(empno);
		}

		// 保存分配任务人员
		function saveEmp(){
			var empstr=$("#empno").val();
			var tendtime=$("#tendtime").val();
			if(empstr.length>0){
				var fid=$("#pubfid").val();
				$.ajax({
					  type: "post",
					  url: "addEmpTaskProject.do",
					  data: {
						  "fid":fid,
						  "empstr":empstr,
						  "tendtime":tendtime
						  },
					  success: function(data){						  
					    	alert(data);
					    	window.location.href="<%=path %>/publishtaskTaskProject.do";
					 }
			   });
			}else{
				alert("请给任务分配人员！");
			}
		}

		// 删除任务
		function delTask(){
			var empcheck=document.getElementsByName("emp");
			var flag=0;
			for(var i=0;i<empcheck.length;i++){
		    	if(empcheck[i].checked==true){
			    	flag=1;
		    	}
			}
			if(flag==1){
				alert("任务执行人不能被删除，你可以删除整个任务！");
				return;
			}else{
				// 获取选中的任务
				var taskcheck=document.getElementsByName("ids");
				var taskstr="";
				for(var i=0;i<taskcheck.length;i++){
					if(taskcheck[i].checked==true){
						taskstr+=taskcheck[i].value+",";
					}
				}
				$.ajax({
					  type: "post",
					  url: "delTaskProject.do",
					  data: {
						  "taskstr":taskstr
						  },
					  success: function(data){						  
					    	alert(data);
					    	window.location.href="<%=path %>/publishtaskTaskProject.do";
					  }
			   });
			}
		}

		// 发布任务
		function fbrw(empid,fid){

			var lxname=	$("#myprj").val();//选中的项目名字
			var lxname1=$("#myprj").find("option:selected").text();
		
			window.location.href="<%=path %>/buildmission.do?empid="+empid+"&fid="+fid+"&selid="+lxname+"&selid1="+lxname1;
		}

		// 弹出移交记录页面
		function record(fid){
            var url = "<%=path%>/taskrecordTaskProject.do?fid="+fid;
			showWindwoButton('id','移交任务记录','800','550',url);
		}

		// 弹出删除任务记录页面
		function delrecord(pid){
			var url = "<%=path%>/delRecordTaskProject.do?pid="+pid;
			showWindwoButton('id','删除任务记录','800','550',url);
		}

		// 查询
		function showpage(dc){
			form1.action="<%=path %>/publishtaskTaskProject.do?dc="+dc;
			form1.submit();
		}
		//下载附件
		function projectInfo(id){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id;
		}
		//查看附件
		function getfj(url){
		 window.location.href="downloadTaskUpload.do?url="+url;
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
				<tr class="height24">
					<th>
						我负责的项目：
					</th>
					<td>
						<select name="function.newProject.id" id="myprj">
						    <option value="-1">--请选择项目--</option>
						    <c:forEach items="${projectlist}" var="project">
						    	<option value="${project.id }" <c:if test="${pid==project.id }">selected</c:if> >${project.projectname }</option>
						    </c:forEach>
						</select>
					</td>
				   <th>任务周期：</th>
				   <td><input type="text" name="function.begintime" class="Wdate" style="width: 90px;"  onclick="WdatePicker()" value="${begintime}" />
				                    至<input type="text" name="function.endtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${endtime}" />
				   </td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showpage(0)"><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showpage(1)"  ><span    class=icon_xls>导出</span></button>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</form>
     <form id="form2" name=form2 action="" method="post">
	<div id="resulthight">
	<span>您现在的位置：<a href="<%=path %>/selectTaskProject.do?pid=-2" title="我的任务">我的任务</a> 》分配任务 </span>
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    	  <%
			List list=(List)request.getAttribute("tasklist");
		    if(list!=null && list.size()>0){
		    	NewFunction funprj=(NewFunction)list.get(0);// 记录项目编号用
    	  %>
			<tr>
			 <th>所属项目</th>
			 <th>任务名称</th>
			 <th>上级任务</th>
			 <th>任务类型</th>
			 <th>任务进度</th>
			 <th>开始时间</th>
			 <th>结束时间</th>
			 <th>任务内容</th>
			 <th>查看附件</th>
			 <th>执行人</th>
			 <th>操作</th>
			</tr>
			<%
				for(int i=0;i<list.size();i++){
					NewFunction function=(NewFunction)list.get(i);
					 int fid=function.getId();
			%>
				<tr>
				   <td>
				   <input type="hidden" id="xmid" value="<%=function.getNewProject().getId() %>"/>
			           <a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('<%=function.getNewProject().getId() %>')">
			           <%=function.getNewProject().getProjectname() %></a>
			       </td>
				   <td align="left"><%=function.getFunctionname() %></td>
				   <td align="left">
			           <%
			              int parentid=function.getParentid();
			              NewFunction fun=new NewFunction();
			              if(parentid!=-1){
			            	  fun=(NewFunction)taskdao.getObj(NewFunction.class,parentid);
			              %>
			                 <%=fun.getFunctionname() %>	  
			              <%}else{%>
			            	 <%="无" %> 
			              <%}%>
			        </td>
				   <td><%=function.getFinishtasktype()==1?"独立完成任务":"协同完成任务" %> </td>
				   <td><%=function.getFstate() %>%</td>
				   <td><%=function.getBegintime() %></td>
				   <td><%=function.getEndtime() %></td>
				   <td align="left"><a href="#" title="<%=function.getFunctioninfo() %>"  style="text-decoration: none;"> <% if(function.getFunctioninfo()!=null){ %> <%=(function.getFunctioninfo().trim().length()>10?function.getFunctioninfo().substring(0,10)+"...":function.getFunctioninfo()) %> <%} %></a></td>
				   <td align="left">
                      <%String hql="From CommonScfjb where tmp1="+function.getId()+"and tmp='Function'";
					  List CommonScfjblist=taskdao.execHQL(hql);
					  CommonScfjb commonScfjb=null;
					  if(CommonScfjblist.size()!=0){ 
					  commonScfjb=(CommonScfjb)CommonScfjblist.get(0);%><a href="javascript:getfj('<%=commonScfjb.getFjlj()%>')" title="<%=commonScfjb.getFjmc()+"."+commonScfjb.getFjhz() %>"><%=commonScfjb.getFjmc().trim().length()>7?commonScfjb.getFjmc().substring(0,7)+".....":commonScfjb.getFjmc()+"."+commonScfjb.getFjhz() %></a>
					  <%}
					  else if(function.getParentid()!=-1){String hql2="From CommonScfjb where tmp1="+function.getParentid()+"and tmp='Function'";
					  List CommonScfjblist2=taskdao.execHQL(hql2); 
					  if(CommonScfjblist2.size()!=0){
					  CommonScfjb commonScfjb2=null;
					  commonScfjb2=(CommonScfjb)CommonScfjblist2.get(0);%><a href="javascript:getfj('<%=commonScfjb2.getFjlj()%>')" title="<%=commonScfjb2.getFjmc()+"."+commonScfjb2.getFjhz() %>"><%=commonScfjb2.getFjmc().trim().length()>7?commonScfjb2.getFjmc().substring(0,7)+".....":commonScfjb2.getFjmc()+"."+commonScfjb2.getFjhz() %></a><%} %>
					  <%} %>				   </td>
				   <td align="left" id="more<%=fid %>">
				      <%
			    	  List taskemp=taskdao.taskemp(fid);
			    	  if(taskemp.size()>0 && taskemp!=null){
			    		  int state=function.getFstate();
				      if(state==100){
				    	  if(taskemp.size()>5){
				    	  for(int j=0;j<6;j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				      	  <%=emp.getName() %>&nbsp;&nbsp;
				      <%}%>
				         <a href="#" title="点击查看更多参与人"  onclick="more(<%=fid %>,0)">更多</a>
				      <%}else{
				    	  for(int j=0;j<taskemp.size();j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				          <%=emp.getName() %>&nbsp;&nbsp;
				      <%}}}else{
				    	  if(taskemp.size()>5){
				    	  for(int j=0;j<6;j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				      %>
				          <input type="checkbox" id="<%=emp.getId() %>" name="emp" value="<%=fid %>" /> 
				          <%if(function.getFinishtasktype()==0){ %>
				          <a href="#"><%=emp.getName() %></a>&nbsp;&nbsp;
				          <%}else{ %>
				             <%=emp.getName() %>
				          <%} %>
				      <%}%>
				          <a href="javascript:void(0);"  title="点击查看更多参与人"  onclick="more(<%=fid %>,1)">更多</a>
				          <a href="javascript:cyr(<%=fid %>);"  title="点击可给任务分配新人员，也可以将选中的人员任务移交给新人员。">分配人员</a>
				      <%}else{
				    	  for(int j=0;j<taskemp.size();j++){
				    		  Employee emp=(Employee)taskemp.get(j);
				    		  // 这个集合是当前人的执行的任务
				    		  List tlist=taskdao.taskByFidAndExecute(fid,emp.getId());
				    		  String str="";
				    		  if(tlist.size()>0){
				    			  for(int m=0;m<tlist.size();m++){
				    				  NewTask ttask=(NewTask)tlist.get(m);
				    				  str+="任务"+(m+1)+":"+ttask.getFunction().getFunctionname()+"<br>";
				    			  }
				    		  }else{
				    			  str="没有安排任何任务";
				    		  }
				      %>
				          <input type="checkbox" id="<%=emp.getId() %>" name="emp" value="<%=fid %>" />
				          <%if(function.getFinishtasktype()==0){ %> 
				            <a href="javascript:fbrw(<%=emp.getId() %>,<%=function.getId() %>);" title="<%=str %>"><%=emp.getName() %></a> &nbsp;&nbsp;
				          <%}else{ %>
				            <%=emp.getName() %>
				          <%} %>
				      <%}%>
				         <a href="javascript:cyr(<%=fid %>);" title="点击可给任务分配新人员，也可以将选中的人员任务移交给新人员。">分配人员</a>
				      <%}}}else{ %>
				                               当前任务还没有分配任何人员。
				            <a href="javascript:cyr(<%=fid %>);"  title="点击可给任务分配新人员，也可以将选中的人员任务移交给新人员。">分配人员</a>
				      <%} %>
				   </td>
				   <td> 
				       <input style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
																	type=checkbox value="<%=fid %>" name=ids />	
					   <a href="javascript:record(<%=fid %>)" title="查看任务移交记录">移交记录</a>
				   </td>
				</tr>
			<%
				}
			%>	
			<tr>
				<td id="page" colspan="11" align="center"><p:pages url="publishtaskTaskProject.do?&funid=14" /></td>
			</tr>
			<tbody id="addTask">
			    
			</tbody>
			<tr>
			   <td colspan="11">
			        <button  type="button" onclick="fbrw(0,0)" ><span class="icon_add">发布新任务</span></button>
			        <button type="button" onclick="delrecord(<%=funprj.getNewProject().getId() %>)"><span class="icon_find">删除记录</span></button>
			        <button  type="button" onclick="delTask()" ><span class="icon_delete">删除</span></button>
			        <span style="float: right;">
			           <input id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											onclick="CheckA(this.form)" type=checkbox value=select name=chkall />全选/反选
					</span>
			   </td>
			</tr>
			<%}else{ %>
			<tr>
				<td><button  type="button" onclick="fbrw(0,0)" ><span class="icon_add">发布新任务</span></button></td>
				<td>
					你不是项目负责人或你的项目下没有发布任何任务！
				</td>
			</tr>
			
			<%} %>
		</table>
	</div>
	
	<!-- 显示所有参与人员的层 -->
   <div id="cyemp" style="display: none;border:#E8FFF5 0px solid;">
   <div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
     <div style="background-color: #E8FFF5;">选择员工列表<span style="text-decoration: none; float: right;"><a href="javascript:closecyemp();">关闭</a></span></div>
     <div style="background-color: #ebf6fa;">改变任务结束时间：<input type="text" id="tendtime" class="Wdate" style="width: 90px;"  onclick="WdatePicker()" value="" /> </div>
     <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab3" align="left" border="1" style="cursor:pointer; border: solid 1px;border-color: #0A0A0A;" width="100%">
        <c:forEach items="${emplist}" var="cyr">
	     	<tr>
	     		<td>
	     		<input type="hidden" id="empno" value="" />
	     		<input type="hidden" id="emptask" value="" />
	     		<input type="hidden" id="pubfid" value="" />
	     		<input type="checkbox" id="${cyr.employee.id }" name="cyr" value="${cyr.employee.name }" onclick="getempno()"  />${cyr.employee.name } 
	     		</td>
	     	</tr>
     	</c:forEach>
     </table>
   </div>
   <div style="background-color: #E8FFF5; float: left;">
		<button type="button" onclick="saveEmp()"><span class="icon_save">下发任务</span></button>
		<button  type="button" onclick="checkEmpOrTask()" ><span class="icon_reload" >移交</span></button>
		<button type="button"  onclick="closecyemp()"><span class="icon_close">关闭</span></button>
   </div>
   </div>
   <script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
   </div>
	
	</form>
	</body>
</html>
