<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
request.getSession().removeAttribute("abcname");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>任务-发布</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.4.js"></script>
		<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/validators.js"></script>
	</head>
	<script type="text/javascript">
	
	function download(){
	window.location.href="downloadMissionUpload.do";
	}
	
    function hidefj(){
      $("#annex").hide();
      $("#sqfj").hide();
      $("#zkfj").show();
    }
   
    function showfj(){
      $("#annex").show();
      $("#zkfj").hide();
      $("#sqfj").show();
    }


 	function missionsubmit(){
 	    // $("#fjdiv").style.display='block';
 		//alert("xxxx");
 		var typeid = $("#typeid").val();
 		var name = $("#name").val();
 		var description = $("#description").val();
 		var oEditor = FCKeditorAPI.GetInstance('description'); 
 	    var description=oEditor.GetXHTML(true);
 	    var expEndTime = $("#expEndTime").val();
 		var expStartTime = $("#expStartTime").val();
 		//alert(typeid);
 		if(typeid == ''){
 			alert("请选择任务类别!");
 			$("#typeid").focus();
 			return false;
 		}
 		if(name == ''){
 			alert("请填写任务名称!");
 			$("#name").focus();
 			return false;
 		}
 		if(description == ''){
 			alert("请填写任务描述!");
 			oEditor.EditorDocument.body.focus();
 			return false;
 		}
 		if(expStartTime == ''){
 			alert("请填写预计任务开始时间!");
 			$("#expStartTime").focus();
 			return false;
 		}
 		if(expEndTime == ''){
 			alert("请填写预计任务结束时间!");
 			$("#expEndTime").focus();
 			return false;
 		} 
 		missionform.action="<%=request.getContextPath()%>/addmission.do";	
 		missionform.submit();
 	 }

 	// 选择类型，如果选择的是项目任务的话那么就把所有的项目给显示出来
 	function selectPrj(){
 	 	var prjid=$("#typeid").val();
 	 	if(prjid==2){
 	 		$("#yqcyr").show();
 	 	 	$.ajax({
				  type: "post",
				  url: "<%=path%>/selectprjmission.do",
				  data: {},
				  success: function(data){	
					    $("#p").show();
				    	$("#prj").html("");
				    	$("#prj").append("<option value='-1'>--请选择--</option>");
				    	$("#prj").append(data);  
				 }
			});
 	 	}else{
 	 		 $("#p").hide();
 	 		$("#yqcyr").hide();
 	 		$("#sfun").hide();
 	 	}
 	}

 // 显示参与人
	function cyr(){
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
    	var empname="";
    	for(var i=0;i<empcheck.length;i++){
	    	if(empcheck[i].checked==true){
		    	empno+=empcheck[i].id+",";
		    	empname+=empcheck[i].value+",";
		    }
    	}
    	$("#empno").val(empno);
    	$("#empname").val(empname);
	}

	// 根据项目编号得到项目的参与人员
	function cyrbypid(){
		var prjid= $("#prj").val();
		$("#empno").val("");
		$("#empname").html("");
		$.ajax({
			  type: "post",
			  url: "<%=path%>/cyrbyidmission.do",
			  data: {"prjid":prjid},
			  success: function(data){
				   $("#myprjcyr").html("");
				   $("#myprjcyr").html(data); 
			 }
		});
	}

	// 根据项目编号得到所有的任务 
	function funbypid(){
		var prjid=$("#prj").val();
		$.ajax({
			  type: "post",
			  url: "<%=path%>/funbyidmission.do",
			  data: {"prjid":prjid},
			  success: function(data){
				   $("#sfun").show();
				   $("#fun").html("");
				   $("#fun").html(data);
			 }
		});
	}

	// 选择任务的时候隐藏参与人
	function hideCyr(){
		$("#yqcyr").hide();
	}
 </script>
	<body>
		<div style="margin-left: 60px">
		 <span>您现在的位置:<a href="<%=path %>/selectTaskProject.do?pid=-2" title="我的任务">我的任务</a> 》发布任务</span>

			<div style="float: left; width: 840px;">
					<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
						border=0>
						<TBODY>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
								</TD>
								<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">
									<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
										<TBODY>
										    <FORM id="missionform" name="missionform" method="post" >
											<TR>
												<TD style="font-size: 12px; color: red;">
													&nbsp;任务发布中(带*号的为必填项)
												</TD>
												<TD align=right>
													&nbsp;
												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
								</TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
										align="center" border=1 style="font-size: 14px;">
										<TBODY>
											<TR>
												<TD width="80px;" height=30 align=right align="left">

												</TD>
												<TD>
													&nbsp; 任务类型：
													<input type="hidden" value="${data.taskId }" name="taskId" />
													<input type="hidden" value="${data.employee.id }"
														name="employee.id" />
													<input type="hidden" value="${data.status }" name="status" />
													<input type="hidden" value="${data.sbh }" name="sbh" />
													<c:if test="${function.id==null}">
														<select id="typeid" name="missiontype.id"
															style="width: 200px;" onchange="selectPrj()">
															<option value="">
																--请选择--
															</option>
															<c:forEach items="${missiontypes}" var="sel">
																<option value="${sel.id}"
																	<c:if test="${data.missiontype.id != null && data.missiontype.id != '' && data.missiontype.id == sel.id }">
													selected</c:if>>
																	${sel.name}
																</option>
	
															</c:forEach>
														</select>
													</c:if>
													<c:if test="${function.id!=null && function.id!=''}">
													   <select id="typeid"  name="missiontype.id">
													       <option value="2">项目类型</option>
													   </select>
													</c:if>
													<c:if test="${function.id==null}">
														<c:if test="${data.tmp1!=null && data.tmp1!=''}">
															<SPAN id="p">
															        选择项目：
																<SELECT id="prj" name="tmp1" onchange="cyrbypid()">
																    <option value="-1">--请选择--</option>
																	<c:forEach items="${prjlist}" var="project">
																		<option value="${project.id }" <c:if test="${data.tmp1!=null && data.tmp1!='' && data.tmp1==project.id }">selected</c:if> >${project.projectname }</option>
																	</c:forEach>
																</SELECT>
															</SPAN>
														</c:if>
														<c:if test="${data.tmp1==null}">
															<SPAN id="p" style="display:none;">
															        选择项目：
																<SELECT id="prj" name="tmp1" onchange="cyrbypid()">
																	 <option value="-1">--请选择--</option>
																</SELECT>
															</SPAN>
														</c:if>
														<SPAN id="sfun" style="display: none;">
														        选择任务：
															<SELECT id="fun" name="" onchange="hideCyr()">
													            <c:if test="${data.tmp2!=null && data.tmp2!=''}">
													              <c:forEach items="${funlist}" var="function">
															         <option value="${function.id }" <c:if test="${data.tmp2==function.id}">selected</c:if> >${function.functionname }..</option>
															      </c:forEach>
															    </c:if>
															    <c:if test="${data.tmp2==null || data.tmp2==''}">
															       <option value="-1">--请选择--</option>
															    </c:if>
															</SELECT>
														</SPAN>
													</c:if> 	
													<c:if test="${function.id!=null && function.id!=''}">
													         选择项目：
													    <select name="tmp1">
													       <option value="${function.newProject.id }">${function.newProject.projectname } </option>
													    </select>
													           选择任务：
													    <select name="tmp2">
													       <option value="${function.id }">${function.functionname }</option>
													    </select>
													</c:if>
												</TD>
											</TR>
										
											<TR>
												<TD width="10%" height=30 align=right>
													任务名称：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 95%" name="name" id="name"
														value="${data.name }" />
												</TD>
											</TR>
											<TR>
												<TD width="25%" height=30 align=right>
													任务描述：
												</TD>
												<TD width="75%" class=category>
														<FCK:editor width="700px;"   inputName="description" instanceName="description" height="300px;">
															<jsp:attribute name="value" >${data.description}</jsp:attribute>
														</FCK:editor> 
												
												</TD>
											</TR>
											<TR>
												<TD width="10%" height=30 align=right>
													选择任务类型：
												</TD>
												<TD width="10%" class=category>
												 <c:if test="${function.id==null}">
													<c:if test="${data.taskId != null && data.taskId != ''}">
														<INPUT type="radio" value="1" id="isSingle"
															name="isSingle"
															<c:if test="${data.isSingle == 1 }" >checked="checked"</c:if> />独立完成任务<INPUT
															type="radio" value="0" id="isSingle" name="isSingle"
															<c:if test="${data.isSingle == 0 }" >checked="checked"</c:if> />协同完成任务
										            </c:if>
													<c:if test="${data.taskId == null || data.taskId == ''}">
														<INPUT type="radio" value="1" id="isSingle"
															name="isSingle" />独立完成任务<INPUT type="radio" value="0"
															id="isSingle" name="isSingle" checked="checked" />协同完成任务
									              	</c:if>
									              </c:if>
									              <c:if test="${function.id!=null && function.id!=''}">
									                 <INPUT type="radio" value="1" id="isSingle"
															name="isSingle" checked="checked" />独立完成任务
															<INPUT type="radio" value="0" id="isSingle" name="isSingle" disabled="disabled" />协同完成任务
									              </c:if>
												</TD>
											</TR>
											<c:if test="${function.id==null}">
												<c:if test="${data.tmp1==null}">
													<tr id="yqcyr" style="display: none;">
														<td height=30 align=right>
															邀请参与人：
														</td>
														<td class=category>
															<input type="hidden" id="empno" name="empno" value="">
															<textarea rows="3" cols="55" id="empname" onclick="cyr()"></textarea>
														</td>
													</tr>
												</c:if>
												<c:if test="${data.tmp1!=null}">
													<tr id="yqcyr">
														<td height=30 align=right>
															邀请参与人：
														</td>
														<td class=category>
														    <input type="hidden" name="tmp2" value="${data.tmp2 }"/>
															<input type="hidden" id="empno" name="empno" value="<c:forEach items="${emplist}" var="employee">${employee.id },</c:forEach> ">
															<textarea rows="3" cols="55" id="empname" onclick="cyr()"><c:forEach items="${emplist}" var="employee">${employee.name },</c:forEach></textarea>
														</td>
													</tr>
												</c:if>
											</c:if>	
											<c:if test="${function.id!=null}">
											   <input type="hidden" name="empno" value="${emp.id}" />
											</c:if>
											
											<tr>
												<TD width="10%" height=30 align=right>
													选择周期类型：
												</TD>
												<td>
												<input value="0" name="cycleType" type="radio"<c:if test="${data.cycleType == 0 }" > checked="checked"</c:if>>日任务&nbsp;&nbsp;
												<input value="1" name="cycleType" type="radio"<c:if test="${data.cycleType == 1 }" > checked="checked"</c:if>>周任务&nbsp;&nbsp;
												<input value="2" name="cycleType" type="radio"<c:if test="${data.cycleType == 2 }" > checked="checked"</c:if>>月任务&nbsp;&nbsp;
												<input value="3" name="cycleType" type="radio"<c:if test="${data.cycleType == 3 }" > checked="checked"</c:if>>季任务&nbsp;&nbsp;
												<input value="4" name="cycleType" type="radio"<c:if test="${data.cycleType == 4 }" > checked="checked"</c:if>>年任务&nbsp;&nbsp;
												<input value="5" name="cycleType" type="radio"<c:if test="${data.cycleType == 5 || data.cycleType == null}" > checked="checked"</c:if>>仅此一次(选择此项周期时间可不填)&nbsp;&nbsp;
												</td>
											</tr>
											<TR>
												<TD width="10%" height=30 align=right>
													周期到期时间：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 55%" name="dueTime"
														id="dueTime"
														onclick="closecyemp(),WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'})"
														value="${data.dueTime}">
												</TD>
											</TR>
											
											<TR>
												<TD width="10%" height=30 align=right>
													创建时间：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 55%; color: gray;" name="buildTime"
														id="buildTime" value="${data.buildTime}"
														readonly="readonly" onclick="closecyemp()" />
												</TD>
											</TR>
											<TR>
												<TD width="10%" height=30 align=right>
													预计开始时间：													
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 55%" name="expStartTime"
														id="expStartTime"
														onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'})"
														value="${data.expStartTime}">
												</TD>
											</TR>
											<TR>
												<TD width="10%" height=30 align=right>
													预计结束时间：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 55%" name="expEndTime" id="expEndTime"
														value="${data.expEndTime}"
														onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'expStartTime\')}'})"
														style="WIDTH: 150px">
												</TD>
											</TR>
							</FORM>
											<TR>
											<TD colspan="2">
											<div>
											      <div>    	
													  <b style="float:left;"><img src="<%=path %>/icons/png/52.png" width="25" height="25"></img>附件选择</b>
													      <span style="float:right;">
														   <button type="button" id="zkfj" onclick="showfj()" style="display: none;"><span class="icon_btn_down">展开</span></button>
														   <button  type="button" id="sqfj" onclick="hidefj()" style="display: block;"><span  class="icon_btn_up">收起</span></button>
														  </span>
												  </div>
											      <div id="annex">
											            <jsp:include page="uploadfiles.jsp" flush="true"></jsp:include>
												  </div>
                                            </div>                                       
											</TD>
											</TR>
											<TR>
												<TD height=30>
													&nbsp;
												</TD>
												<TD class=category>
													<INPUT class=button type="button" value="确认提交 "
														onclick="missionsubmit()">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<INPUT class=button type=reset value=" 重置 ">

												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
								</TD>
								<TD></TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				
			</div>
		</div>
		
		
	
   <div id="cyemp" style="width: 200px;display: none;border:#E8FFF5 1px solid;">
   <div id="fd" style="filter:alpha(opacity=100);opacity:1;float: right;" >
     <div style="width: 200px;background-color: #E8FFF5;"><span style="width:100px; float:left;">选择员工列表</span> <span style="text-decoration: none; float: right;"><a href="javascript:closecyemp();">关闭</a></span></div>
     <div  style="overflow: scroll;z-index: 0px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <div id="myprjcyr">
	     <table  align="left" border="1" style="cursor:pointer; border: solid 1px;border-color: #0A0A0A;" width="100%">
	        <c:forEach items="${emplist}" var="emp">
		     	<tr>
		     		<td>
		     			<input type="checkbox" id="${emp.id }" name="cyr" value="${emp.name }" onclick="getempno()"  />${emp.name } 
		     	    </td>
		     	</tr>
	     	</c:forEach>
	     </table>
     </div>
   </div>
   <%  String id=(String)request.getAttribute("selid"); 
												String text1=(String)request.getAttribute("selid1"); 
										if(id!=null && id!=""){
										  Integer  ids=Integer.parseInt(id);
										%>
										     <script type="text/javascript">
										     $(document).ready(function(){
																
										    	  $("#typeid").attr("value",'2');//
										    	 	 var prjid=$("#typeid").val();
										  
										   	 		$("#yqcyr").show();
										   	 	 	$.ajax({
										  				  type: "post",
										  				  url: "<%=path%>/selectprjmission.do",
										  				  data: {},
										  				  success: function(data){
											  				 
										  					    $("#p").show();
										  				    	$("#prj").html("");
										  				    	$("#prj").append("<option value='-1'>--请选择--</option>");
										  				    	$("#prj").append(data);  
										  				   
													    	   $("#prj").attr("value",'<%=ids%>');
													    	   var str="<%=text1%>";
													   
													    	   $("#prj option[text='"+str+"']").attr("selected", true);   //设置Select的Text值为jQuery的项选中 
													    	   $("<option value='<%=ids%>'>"+str+"</option>").appendTo("#prj");
										  				 }
										  			});
										   	 	
										    	   
										    	

										      
										     });
																			
										     
										     </script>
										   
										
										
										<% } %>
   </div>
   <script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
   </div>
	</body>
</html>