<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>
    <title>福奥进销存系统-计划</title>
    <meta content="MSHTML 6.00.2800.1276" name="GENERATOR">
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="Pragma" content="no-cache">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0">	
	
	<link href="<%=path %>/Css/desk/mainWin2.css" type="text/css" media="screen" rel="stylesheet">
	<link href="<%=path %>/Css/desk/calendar.css" type="text/css" media="screen" rel="stylesheet">
	<link href="<%=path %>/Css/desk/mainWin.css" type="text/css" media="screen" rel="stylesheet">
	
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	var browser=navigator.appName;
	var b_version=navigator.appVersion; 
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	</script>
	<script type="text/javascript">
		
		//判断是否完成  根据是否填写完成时间
		function changeState(){
			var finishtime = $("#finishtime").val();
			if(finishtime.length > 5 ){
				$("#state").val(1);
			}else{
				$("#state").val(0);
			}
		}


		function showSelect(){
		  var val = $("#subjectstyle0").val();
		  if($("#subjectstyle0").val()==4){
			  document.getElementById("prj").style.display="block";  
		  }else{
		    document.getElementById("prj").style.display="none";
		  }
		}

		// 选择项目 
		function getPrjName(){
			var pid=$("#myprj").val();
			//alert(pid);
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
	</script>
</head>
<body topmargin="0" leftmargin="0"  marginheight="0" marginwidth="0">
<div id="Calendar" scrolling="no" style="border:0px solid #EEEEEE ;position: absolute; width: 150; height: 137; z-index: 200; filter :'progid:DXImageTransform.Microsoft.Shadow(direction=135,color=#AAAAAA,strength=4)' ;display: none"></div>
	<div id="Clock" scrolling="no" style="color: #2b333c; font-size: 14px; padding: 10px; border:1px solid #EEEEEE; position: absolute; background: #FFFFFF; width: 150; z-index: 200; filter :'progid:DXImageTransform.Microsoft.Shadow(direction=135,color=#AAAAAA,strength=1)' ;display: none">
	</div>
		<input name="functionName" type="hidden">
		<div id="Title_bar">
			<div id="Title_bar_Head">
				<div id="Title_Head">
				</div>
				<div id="Title">
					<img src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
					修改工作计划
				</div>
				<div id="Title_End">
				</div>
				<div id="Title_bar_bg"></div>
			</div>
			
		</div>
		<div>			
				<div id="MainArea">
					<center>
					<form action="updateScheduleworknotepad.do" method="post" id="form0" name="form0" onsubmit="return addValidators2('form0')">
						<s:token name="register"></s:token>
						<input type="hidden" name="id" id="id1" value="${data.id }"/>
						<s:token name="register1"></s:token>
						<div class="ItemBlock_Title1">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							工作计划类型
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody><tr>
										<td height="54" width="50"></td>
										<td width="72">类型</td>
										<td width="543">
											<c:if test="${(data.plantype) == 0}">
											<input value="0" name="plantype" checked="checked" type="radio">日计划&nbsp;&nbsp;	
											</c:if>
											<c:if test="${(data.plantype) == 1}">
											<input value="1" name="plantype" checked="checked" type="radio">周计划&nbsp;&nbsp;	
											</c:if>
											<c:if test="${(data.plantype) == 2}">
											<input value="2" name="plantype" checked="checked" type="radio">月计划&nbsp;&nbsp;	
											</c:if>
											<c:if test="${(data.plantype) == 3}">
											<input value="3" name="plantype" checked="checked" type="radio">季计划&nbsp;&nbsp;	
											</c:if>
											<c:if test="${(data.plantype) == 4}">
											<input value="4" name="plantype" checked="checked" type="radio">年计划&nbsp;&nbsp;	
											</c:if>
										</td>
									</tr>
								</tbody></table>
							</div>
						</div>
						<div class="ItemBlock_Title">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							起止时间
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
								<tbody>
								<tr><td height="27" width="50">
									</td>
									<td width="72">开始时间</td>
									<td width="400px;">
										<input style="width:150px;" size="10" onblur="checkValueByRules2('begintime1','','begintime1Msg')" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-1'})" class="inputdate" name="begintime" id="begintime1" type="text" value="${data.begintime }">
										<FONT color=#ff0000>*</FONT>点击输入框获取时间<FONT color=#ff0000 id="begintime1Msg"></FONT>
									</td>									
								</tr>
								<tr>
									<td height="27">										
									</td>
									<td>结束时间</td>
									<td>
									<input  style="width:150px;" size="10" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime1\')}'})" onblur="checkValueByRules2('endtime1','','endtime1Msg')" class="inputdate" name="endtime" id="endtime1" type="text"  value="${data.endtime }">
									<FONT color=#ff0000>*</FONT>点击输入框获取时间(如果为工作提醒，这个日期不做限制)<FONT color=#ff0000 id="endtime1Msg"></FONT>
								</tr>
								<!-- 
								<tr>
									<td height="27">										
									</td>
									<td>更新持续时间</td>
									<td>
									<input  style="width:150px;" size="10" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime\')}'})" onblur="checkValueByRules2('durationTime','','durationTimeMsg')" class="inputdate" name="durationTime" id="durationTime" type="text">
									<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="durationTimeMsg"></FONT>
									(到指定时间自动添加计划。如：在此时间之前，日计划会每天添加内容和此一样的新计划。)
								</tr>
								 -->							
								</tbody>
								</table>
									</div>
								</div>
							<div class="ItemBlock_Title">
								<img src="<%=path%>/images/desk/item_point.gif" border="0">
								计划主题
							</div>
							<div class="ItemBlockBorder">
								<div class="ItemBlock">
									<table border="0" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td height="27">
												</td>
												<td>
													计划主题:
												</td>
												<td width="250" colspan="2">
													<input style="width: 150px;" size="10"	onblur="checkValueByRules2('subjecttitle1','','subjecttitle1Msg')" class="inputdate"
													value="${data.subjecttitle }"	name="subjecttitle" id="subjecttitle1" type="text"><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjecttitle1Msg"></FONT>
												</td>
											</tr>
											<tr>
												<td height="27" width="50"></td>
												<td width="72">主题归类:</td>
												<td width="250px;">
													<select style="width:150px" class="SelectStyle" name="subjectstyle" id="subjectstyle1" onblur="checkValueByRules2('subjectstyle1','','subjectstyle1Msg')"  onchange="showSelect()" >
															<option value="" >请选择主题</option>
															<option value="0" <c:if test="${data.subjectstyle == 0 }" >selected</c:if> >公司工作</option>
															<option value="1" <c:if test="${data.subjectstyle == 1 }" >selected</c:if> >开会</option>
															<option value="2" <c:if test="${data.subjectstyle == 2 }" >selected</c:if> >出门拜访</option>
															<option value="3" <c:if test="${data.subjectstyle == 3 }" >selected</c:if> >出门拜访</option>
															<option value="4" <c:if test="${data.subjectstyle == 4 }" >selected</c:if> >项目管理</option>
															<option value="5" <c:if test="${data.subjectstyle == 5 }" >selected</c:if> >其它</option>
													</select><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjectstyle1Msg"></FONT>
												</td>
												<td id="prj" style="display: none;">
													<select style="width:150px" id="myprj"  class="SelectStyle" name="project" onchange="getPrjName()" >
													  <option value="-1">--请选择项目--</option>
													  <c:forEach items="${prjlist}" var="project">
													  	  <option value="${project.id }">${project.projectname }</option>
													  </c:forEach>
													</select><FONT color=#ff0000>*</FONT>&nbsp;&nbsp;&nbsp;
													<select style="width:150px" id="function"  class="SelectStyle" name="plan.function.id">
														<option value="0">--请选择任务--</option>
													</select><FONT color=#ff0000>*</FONT>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						<div class="ItemBlock_Title">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							<span id="tempname1">今日</span>工作计划(<span id="tempname1"></span>计划请于<span id="tempname11"></span>上班前安排好)
						</div>
						<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
													<textarea  name="todayWorkPlan" id="todayWorkPlan1" style="display:none" >${data.todayWorkPlan }</textarea>
<script type="text/javascript">
if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0"){
$("#todayWorkPlan1").show();
//alert("IE 8.0");
}else{document.write("<iframe src='SinaEditor/Edit/editor.htm?id=todayWorkPlan1&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");}
</script>
													</td>
													<td>
														<FONT color=#ff0000>*</FONT>
														<FONT color=#ff0000 id="wtodayWorkPlan1Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="10"></td>
													<td width="10"></td>
													<td width="10"></td>
												</tr>

											</tbody>
										</table>
									</div>
								</div>
						<div class="ItemBlock_Title" >
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							<span id="tempname2">明日</span>工作计划(<span id="tempname2"></span>计划请于<span id="tempname22">明天凌晨</span>前安排好)
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
									<tr>
													<td width="622" height="457" colspan="3">
													<textarea  name="tomorrowWorkPlan" id="tomorrowWorkPlan1" style="display:none">${data.tomorrowWorkPlan }</textarea>
<script type="text/javascript">
if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0"){
//alert("IE 8.0");
$("#tomorrowWorkPlan1").show();
}else{document.write("<iframe src='SinaEditor/Edit/editor.htm?id=tomorrowWorkPlan1&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");}
</script>
													</td>
													<td>
														<FONT color=#ff0000>*</FONT>
														<FONT color=#ff0000 id="tomorrowWorkPlan1Msg"></FONT>
													</td>
												</tr>
									<tr>
										<td height="27"></td>
										<td width="72"></td>
										<td width="174">
										</td>
									</tr>
									
								</tbody></table>
							</div>
						</div>
						<div class="ItemBlock_Title" >
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							重要程度
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
									<tr>
										<td height="27"></td>
										<td width="72">重要度</td>
										<td width="174">
											<select class="SelectStyle" id="importantLevel1" name="importantLevel">
												<option value="1" <c:if test="${data.importantLevel==1 }">selected</c:if>>一般</option>
												<option value="0" <c:if test="${data.importantLevel==0 }">selected</c:if>>不重要</option>
												<option value="2" <c:if test="${data.importantLevel==2 }">selected</c:if>>重要</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
						</div>
						<div id="InputDetailBar">
							<table align="center" border="0" cellpadding="10" cellspacing="0">
								<tbody>
									<tr>
									<td>										
									<div class="FuncBtn"><div class="FuncBtnHead"></div>
							        <div class="FuncBtnMemo">
							        	<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" type="submit"  value="保存" name="subBtn" id="subBtn"></div>
								        <div class="FuncBtnTail">
								        </div>
							        </div>
        							</td>									
									<td>
									<div class="FuncBtn">
										<div class="FuncBtnHead"></div>
								        <div class="FuncBtnMemo">
								        	<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" type="reset"  value="重置" name="resBtn" id="resBtn">
								        </div>
								        <div class="FuncBtnTail"></div>
							        </div>
        							</td>
								</tr>
							</tbody>
						</table>
					</div>						
				</form>
			</center>
	</div>
</div>
	<!-- 以下用来隐藏各种传递参数 -->
	
</body>
</html>
