<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String str = sdf.format(new Date());
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>福奥进销存系统-日程</title>
		<link href="<%=path%>/Css/desk/mainWin.css" type="text/css"
			media="screen" rel="stylesheet">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>

		<script type="text/javascript"
			src="<%=path%>/js/My97DatePicker/changedate.js"></script>

		<script type="text/javascript">
var browser=navigator.appName;
var b_version=navigator.appVersion; 
var version=b_version.split(";"); 
var trim_Version=version[1].replace(/[ ]/g,""); 
</script>
		<script type="text/javascript">
		
		//显示和隐藏层

	
		function onLoad(id){
			if(!id){
			    id = 0;
			}
			
			showDiv(id,'');

		}
		
		function showDiv(tid,dd){
		    if(tid == 0){ 
		    $("#workinfoDiv").show(); $("#workplanDiv").hide(); $("#remindmeDiv").hide();
			}
			else if(tid == 1){
			$("#workplanDiv").show(); $("#workinfoDiv").hide(); $("#remindmeDiv").hide();
			if(dd=='d'){
			   $("#plantype"+tid).val(0);
			   $("#tempname1").html("本日");
			   $("#tempname11").html("当天上班前");
			   $("#tempname2").html("明日");
			   $("#tempname22").html("第二天前");
			   
			}else if(dd == 'w'){
			    $("#plantype"+tid).val(1);
				$("#tempname1").html("本周");
				$("#tempname11").html("本周周一早上");
			   $("#tempname2").html("下周");
			   $("#tempname22").html("本周内");
			}else if(dd == 'm'){
				 $("#plantype"+tid).val(2);
				$("#tempname1").html("本月");
				$("#tempname11").html("本月上班第一天");
			   $("#tempname2").html("下月");
			   $("#tempname22").html("下月之前");
			}else if(dd == 'q'){
				 $("#plantype"+tid).val(3);
				$("#tempname1").html("本季");
				$("#tempname11").html("在本季第一天");
			   $("#tempname2").html("下季");
			   $("#tempname22").html("下季度之前");
			}else if(dd == 'y'){
				 $("#plantype"+tid).val(4);
				$("#tempname1").html("今年");
				$("#tempname11").html("今年开始工作时");
			   $("#tempname2").html("明年");
			   $("#tempname22").html("今年年底");
			}
			}else if(tid == 2){
			$("#remindmeDiv").show(); $("#workinfoDiv").hide(); $("#workplanDiv").hide();
			}
		} 
		function hideDiv(){ 
			$("#workinfoDiv").hide(); $("#workplanDiv").show(); 
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

		<script type="text/javascript">
    $(function(){
     $('#tog1').toggle(
     function(){
     
      $('#sel1').attr('name','begintime1');
     
     $('#begintime0').hide();
     $('#begintime01').show();
      $('#begintime01').attr('name','begintime');
      $('#begintime01').attr('value',"");
      
     $('#tog1').attr('value','选择性时间');
     },function(){
     $('#begintime01').attr("value","11");
     
      $('#begintime01').attr('name','begintime1');
     
      $('#begintime01').hide();
     $('#begintime0').show();
     $('#tog1').attr('value','自定义时间');
                                   
     $('#sel1').attr('name','begintime');
     
     });
    
    });
    
    
    function checksel(){
      var str= $('#begintime0').val();
      $('#sel1').attr('value','<%=str%>'+" "+str);
      
       var strend= $('#endtime0').val();
      $('#sel2').attr('value','<%=str%>'+" "+strend);
     
        
    }
    
    
    
    function timechange1(){
       var str= $('#begintime0').val();
       
      $('#sel1').attr('value','<%=str%>'+" "+str);
    
    
      var strend= $('#endtime0').val();
      $('#sel2').attr('value','<%=str%>'+" "+strend);
    
    }
    
    
    
      function timechange2(){
       var str= $('#begintime0').val();
       
      $('#sel1').attr('value','<%=str%>'+" "+str);
    
    
      var strend= $('#endtime0').val();
      $('#sel2').attr('value','<%=str%>'+" "+strend);
    
    }
    

    
    $(function(){
     $('#tog2').toggle(
     function(){
     
      $('#sel2').attr('name','endtime1');
     
     $('#endtime0').hide();
      $('#endtime01').show();
      $('#endtime01').attr('name','endtime');
      $('#endtime01').attr('value',"");
      
     $('#tog2').attr('value','选择性时间');
     },function(){
     $('#endtime01').attr("value","11");
     
      $('#endtime01').attr('name','endtime01');
     
      $('#endtime01').hide();
     $('#endtime0').show();
     $('#tog2').attr('value','自定义时间');
                                   
     $('#sel2').attr('name','endtime');
     
     });
    
    });
   
   
   
   
   
   $(function(){
     $('#work1').toggle(
     function(){
     $('#workinput').show();
     $('#subjecttitle0').hide();
     $('#workinput').attr('name','subjecttitle');
     $('#subjecttitle0').attr('name','subjecttitle1');
     $('#workinput').value('value','');
     
      $('#work1').attr('value','选择');
     },function(){
      $('#workinput').hide();
     $('#subjecttitle0').show();
      $('#subjecttitle0').attr('name','subjecttitle');
     $('#workinput').attr('name','subjecttitle1');
      $('#workinput').value('value','321');
       $('#work1').attr('value','自定义');
     
     });
    
    });
   
   
   
   
   
   
</script>


		<style>
#begintime01 {
	display: none;
}

#endtime01 {
	display: none;
}

#workinput {
	display: none;
}
</style>
	</head>

	<body topmargin="0" leftmargin="0" onload="onLoad(${data})" marginheight="0"
		marginwidth="0">
		<input name="functionName" type="hidden">
		<div id="Title_bar">
			<div id="Title_bar_Head">
				<div id="Title_Head">
				</div>
				<div id="Title">
					<img src="<%=path%>/images/desk/title_arrow.gif" border="0"
						height="13" width="13">
					日程事务设置
				</div>
				<div id="Title_End">
				</div>
				<div id="Title_bar_bg"></div>
			</div>
		</div>

		<div STYLE="width: 100%; float: left;">

			<div STYLE="width: 85%; float: left;">

				<div id="MainArea">
					<center>
						<!-- 日程类型选择开始 -->
						<div class="ItemBlock_Title1">
							<img src="<%=path%>/images/desk/item_point.gif" border="0">
							日程类型选择
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td height="54" width="50"></td>
											<td width="72">
												选择类型
											</td>
											<td width="543">
												<input onclick="showDiv(0,'');" value="5" name="plantype"
													checked="checked" type="radio">
												日记事&nbsp;&nbsp;
												<c:if test="${data==1}">
												 <input onclick="showDiv(1,'d');" value="0" name="plantype"
												   checked="checked" type="radio">
												  </c:if>
												  <c:if test="${data!=1}">
												 <input onclick="showDiv(1,'d');" value="0" name="plantype"
												    type="radio">
												  </c:if>
												日计划&nbsp;&nbsp;
												<input onclick="showDiv(1,'w');" value="1" name="plantype"
													type="radio">
												周计划&nbsp;&nbsp;
												<input onclick="showDiv(1,'m');" value="2" name="plantype"
													type="radio">
												月计划&nbsp;&nbsp;
												<input onclick="showDiv(1,'q');" value="3" name="plantype"
													type="radio">
												季计划&nbsp;&nbsp;
												<input onclick="showDiv(1,'y');" value="4" name="plantype"
													type="radio">
												年计划&nbsp;&nbsp;
												<input onclick="showDiv(2,'');" value="6" name="plantype"
													type="radio">
												工作提醒&nbsp;&nbsp;
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- 日记事S -->
						<div id="workinfoDiv">
							<form action="addScheduleInfo.do" method="post" id="form0"
								name="form0" onsubmit="return addValidators2('form0')">
								<input value="5" name="plantype" id="plantype0" type="hidden">
								<s:token name="register0"></s:token>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">



									起止时间
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27" width="50">
													</td>
													<td width="72">
														开始时间
													</td>

													<td width="400px;">


														<input id="sel1" type="hidden" name="begintime" value="">

														<input style="width: 150px;" size="10"
															onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00',maxDate:'%y-%M-%d 23:59:58'})"
															class="inputdate" name="begintime1" id="begintime01"
															type="text"
															onblur="checkValueByRules2('begintime01','','begintime0Msg')"
															value="11:11">

														<select style="width: 150px;" class="inputdate"
															name="begintime1" id="begintime0" onblur="timechange1()"
															onblur="checkValueByRules2('begintime0','','begintime0Msg')">
															<option value="09:00">
																<%=str%>&nbsp;09:00
															</option>
															<option value="10:30">
																<%=str%>&nbsp;10:30
															</option>
															<option value="12:00">
																<%=str%>&nbsp;12:00
															</option>
															<option value="14:00">
																<%=str%>&nbsp;14:00
															</option>
															<option value="15:30">
																<%=str%>&nbsp;15:30
															</option>
															<option value="17:00">
																<%=str%>&nbsp;17:00
															</option>
														</select>
														<input id="tog1" type="button" value="自定义时间">

														<FONT color=#ff0000>*</FONT> 点击输入框获取时间
														<FONT color=#ff0000 id="begintime0Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27">
													</td>
													<td>
														结束时间
													</td>
													<td>



														<input id="sel2" type="hidden" name="endtime" value="">

														<input style="width: 150px;" size="10"
															onblur="checkValueByRules2('endtime01','','endtimeMsg')"
															value="321"
															onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00',maxDate:'%y-%M-%d 23:59:58'})"
															class="inputdate" name="endtime1" id="endtime01"
															type="text">


														<select style="width: 150px;" onblur="timechange1()"
															class="inputdate" name="endtime01" id="endtime0"
															onblur="timechange2()">
															<option value="10:30">
																<%=str%>&nbsp;10:30
															</option>
															<option value="12:00">
																<%=str%>&nbsp;12:00
															</option>
															<option value="14:00">
																<%=str%>&nbsp;14:00
															</option>
															<option value="15:30">
																<%=str%>&nbsp;15:30
															</option>
															<option value="17:00">
																<%=str%>&nbsp;17:00
															</option>
															<option value="18:30">
																<%=str%>&nbsp;18:30
															</option>
														</select>

														<input id="tog2" type="button" value="自定义时间">

														<FONT color=#ff0000>*</FONT> 点击输入框获取时间(如果为工作提醒，这个日期不做限制)
														<FONT color=#ff0000 id="endtimeMsg"></FONT>
												</tr>
											</tbody>
										</table>
									</div>

								</div>

								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									工作主题
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27">
													</td>
													<td>
														工作主题:
													</td>
													<td width="350" colspan="2">

														<select style="width: 150px;"
															onblur="checkValueByRules2('subjecttitle0','','subjecttitle0Msg')"
															class="inputdate" name="subjecttitle" id="subjecttitle0">
															<option value="公司工作">
																公司工作
															</option>
															<option value="开会">
																开会
															</option>
															<option value="出门拜访">
																出门拜访
															</option>
															<option value="调查">
																调查
															</option>
															<option value="其它">
																其它
															</option>
														</select>

														<input style="width: 150px;" size="10" class="inputdate"
															value=" " name="subjecttitle1" id="workinput"
															onblur="checkValueByRules2('workinput','','subjecttitle0Msg')">

														<input type="button" value="自定义" id="work1">


														<FONT color=#ff0000>*</FONT>10字符以内
														<FONT color=#ff0000 id="subjecttitle0Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27" width="50"></td>
													<td width="72">
														主题归类:
													</td>
													<td width="250px;">
														<select style="width: 150px" class="SelectStyle"
															name="subjectstyle" id="subjectstyle0"
															onblur="checkValueByRules2('subjectstyle0','','subjectstyle0Msg')"
															onchange="showSelect()" onclick="checksel()">
															<option value="">
																请选择主题
															</option>
															<option value="0">
																公司工作
															</option>
															<option value="1">
																开会
															</option>
															<option value="2">
																出门拜访
															</option>
															<option value="4">
																项目管理
															</option>
															<option value="5">
																其它
															</option>
														</select>
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="subjectstyle0Msg"></FONT>
													</td>
													<td id="prj" style="display: none;">
														<select style="width: 150px" id="myprj"
															class="SelectStyle" name="project"
															onchange="getPrjName()">
															<option value="-1">
																--请选择项目--
															</option>
															<c:forEach items="${prjlist}" var="project">
																<option value="${project.id }">
																	${project.projectname }
																</option>
															</c:forEach>
														</select>
														<FONT color=#ff0000>*</FONT>&nbsp;&nbsp;&nbsp;
														<select style="width: 150px" id="function"
															class="SelectStyle" name="plan.function.id">
															<option value="0">
																--请选择任务--
															</option>
														</select>
														<FONT color=#ff0000>*</FONT>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									人员及效果
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27">
													</td>
													<td>
														发起人员:
													</td>
													<td>
														<input style="width: 150px;" size="10"
															onblur="checkValueByRules2('organizer0','','organizer0Msg')"
															name="organizer" id="organizer0" name="organizer"
															type="text" value="${emp.name }">
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="organizer0Msg"></FONT>默认是自己
													</td>
												</tr>
												<tr>
													<td height="27">
													</td>
													<td>
														参与人员:
													</td>
													<td>


														<select style="width: 150px;"
															onblur="checkValueByRules2('participator0','','participator0Msg')"
															class="inputdate" name="participator" id="participator0">
															<option value="无">
																无
															</option>
															<option value="美工">
																美工
															</option>
															<option value="开发组">
																开发组
															</option>
															<option value="销售部">
																销售部
															</option>
														</select>


														<FONT color=#ff0000>*</FONT>参与者没有则填写无
														<FONT color=#ff0000 id="participator0Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27" width="50"></td>
													<td height="27" width="72">
														既定安排
													</td>
													<td class="TableDetail2" colspan="2">
														<input id="isplan0" name="isplan" value="0" type="radio"
															checked="checked">
														&nbsp;是&nbsp;
														<input id="isplan0" name="isplan" value="1" type="radio">
														&nbsp;否
													</td>
												</tr>
												<tr>
													<td height="27" width="50"></td>
													<td height="27" width="72">
														既定效果
													</td>
													<td class="TableDetail2" colspan="2">
														<input id="effective0" name="effective" value="0"
															checked="checked" type="radio">
														&nbsp;优&nbsp;
														<input id="effective0" name="effective" value="1"
															type="radio">
														&nbsp;良&nbsp;
														<input id="effective0" name="effective" value="2"
															type="radio">
														&nbsp;一般
														<input id="effective0" name="effective" value="3"
															type="radio">
														&nbsp;差&nbsp;
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<!-- 工作纪要E  -->
								<!-- 将今日工作和明日计划2个div包起开始 -->
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									工作概要
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
														<textarea name="workcontent" id="workcontent0" cols="50"
															rows="10" style="display: none"
															onblur="checkValueByRules2('workcontent0','','workcontent0Msg')"></textarea>
														<script type="text/javascript">
if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0") 
{
$("#workcontent0").show();
//alert("IE 8.0");
}
else 
{ document.write("<iframe src='SinaEditor/Edit/editor.htm?id=workcontent0&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");
}
</script>
													</td>
													<td>
														<FONT color=#ff0000>*</FONT>
														<FONT color=#ff0000 id="workcontent0Msg"></FONT>
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
								<div id="InputDetailBar">
									<table align="center" border="0" cellpadding="10"
										cellspacing="0">
										<tbody>
											<tr>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="submit" value="保存" name="subBtn" id="subBtn">
														</div>
														<div class="FuncBtnTail">
														</div>
													</div>
												</td>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="reset" value="重置" name="resBtn" id="resBtn">
														</div>
														<div class="FuncBtnTail"></div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- 日记事E -->

						<!-- 计划S -->
						<div id="workplanDiv">
							<form action="addScheduleInfo.do" method="post" id="form1"
								name="form1" onsubmit="return addValidators2('form1')">
								<input value="0" name="plantype" id="plantype1" type="hidden">
								<s:token name="register1"></s:token>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									起止时间
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27" width="50">
													</td>
													<td width="72">
														开始时间
													</td>
													<td width="400px;">
														<input style="width: 150px;" size="10"
															onblur="checkValueByRules2('begintime11','','begintime11Msg')"
															onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00'})"
															class="inputdate" name="begintime" id="begintime11"
															type="text">

														<FONT color=#ff0000>*</FONT> 点击输入框获取时间
														<FONT color=#ff0000 id="begintime11Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27">
													</td>
													<td>
														结束时间
													</td>
													<td>
														<input style="width: 150px;" size="10"
															onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime11\')}'})"
															onblur="checkValueByRules2('endtime1','','endtime1Msg')"
															class="inputdate" name="endtime" id="endtime1"
															type="text">
														<FONT color=#ff0000>*</FONT> 点击输入框获取时间(如果为工作提醒，这个日期不做限制)
														<FONT color=#ff0000 id="endtime1Msg"></FONT>
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
													<td width="250">
														<input style="width: 150px;" size="10"
															onblur="checkValueByRules2('subjecttitle1','','subjecttitle1Msg')"
															class="inputdate" name="subjecttitle" id="subjecttitle1"
															type="text">
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="subjecttitle1Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27" width="50"></td>
													<td width="72">
														主题归类:
													</td>
													<td width="250px;">
														<select style="width: 150px" class="SelectStyle"
															name="subjectstyle" id="subjectstyle1"
															onblur="checkValueByRules2('subjectstyle1','','subjectstyle1Msg')">
															<option value="">
																请选择主题
															</option>
															<option value="0">
																公司工作
															</option>
															<option value="1">
																开会
															</option>
															<option value="2">
																出门拜访
															</option>
															<option value="3">
																出门拜访
															</option>
															<option value="4">
																其它
															</option>
														</select>
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="subjectstyle1Msg"></FONT>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									<span id="tempname1">今日</span>工作计划(
									<span id="tempname1"></span>计划请于
									<span id="tempname11"></span>上班前安排好)
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
														<textarea name="todayWorkPlan" id="todayWorkPlan1"
															style="display: none"></textarea>
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
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									<span id="tempname2">明日</span>工作计划(
									<span id="tempname2"></span>计划请于
									<span id="tempname22">明天凌晨</span>前安排好)
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
														<textarea name="tomorrowWorkPlan" id="tomorrowWorkPlan1"
															style="display: none"></textarea>
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

											</tbody>
										</table>
									</div>
								</div>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									重要程度
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27"></td>
													<td width="72">
														重要度
													</td>
													<td width="174">
														<select class="SelectStyle" id="importantLevel1"
															name="importantLevel">
															<option value="0">
																不重要
															</option>
															<option value="1">
																一般
															</option>
															<option value="2">
																重要
															</option>
														</select>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div id="InputDetailBar">
									<table align="center" border="0" cellpadding="10"
										cellspacing="0">
										<tbody>
											<tr>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="submit" value="保存" name="subBtn" id="subBtn">
														</div>
														<div class="FuncBtnTail">
														</div>
													</div>
												</td>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="reset" value="重置" name="resBtn" id="resBtn">
														</div>
														<div class="FuncBtnTail"></div>
													</div>
												</td>
											</tr>
											<tr>
												<td height="27" width="50"></td>
												<td width="72"></td>
												<td width="150px;">
													<!--													<select class="SelectStyle" name="subjectstyle" id="subjectstyle2"  onchange="showSelect()">-->
													<!--															<option value="">请选择主题</option>-->
													<!--															<option value="0">公司工作</option>-->
													<!--															<option value="1">开会</option>-->
													<!--															<option value="2">出门拜访</option>-->
													<!--															<option value="4">项目管理</option>-->
													<!--															<option value="5">其它</option>-->
													<!--													</select><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjectstyle2Msg"></FONT>-->
												</td>
											</tr>

										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- 计划E -->

						<!-- 提醒S -->
						<div id="remindmeDiv">
							<form action="addScheduleInfo.do" method="post" id="form2"
								name="form2" onsubmit="return addValidators2('form2')">
								<input type="hidden" name="state" id="state2" value="0" />
								<input value="6" name="plantype" id="plantype2" type="hidden">
								<s:token name="register2"></s:token>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									起止时间
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27" width="50">
													</td>
													<td width="72">
														提醒时间
													</td>
													<td width="400px;">
														<input style="width: 150px;" size="10"
															onblur="checkValueByRules2('remindtime2','','remindtime2Msg')"
															onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'})"
															class="inputdate" name="remindtime" id="remindtime2"
															type="text">
														<FONT color=#ff0000>*</FONT> 点击输入框获取时间
														<FONT color=#ff0000 id="remindtime2Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27" width="50">
													</td>
													<td width="72">
														重复:
													</td>
													<td width="150px;">
														<select class="SelectStyle" name="remainSet"
															id="remainSet2">
															<option value="">
																永不
															</option>
															<option value="0">
																每天
															</option>
															<option value="1">
																每周
															</option>
															<option value="2">
																每两周
															</option>
															<option value="3">
																没月
															</option>
															<option value="4">
																每年
															</option>
														</select>
														<FONT color=#ff0000 id="remainSet2Msg"></FONT>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									提醒主题
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27">
													</td>
													<td>
														提醒标识:
													</td>
													<td>
														<input style="width: 150px;" size="10" onclick=""
															onblur="" class="inputdate" name="subjecttitle"
															id="subjecttitle2" type="text">
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="subjecttitle2Msg"></FONT>
													</td>
												</tr>
												<tr>
													<td height="27" width="50"></td>
													<td width="72">
														主题归类:
													</td>
													<td width="150px;">
														<select class="SelectStyle" name="subjectstyle"
															id="subjectstyle2">
															<option value="">
																请选择主题
															</option>
															<option value="0">
																公司工作
															</option>
															<option value="1">
																开会
															</option>
															<option value="2">
																出门拜访
															</option>
															<option value="3">
																出门拜访
															</option>
															<option value="4">
																其它
															</option>
														</select>
														<FONT color=#ff0000>*</FONT><FONT color=#ff0000
															id="subjectstyle2Msg"></FONT>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									备忘录
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
														<textarea name="workremind" id="workremind2"
															style="display: none"></textarea>
														<script type="text/javascript">
if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE9.0"){
//alert("IE 8.0");
$("#workremind2").show();
}else{document.write("<iframe src='SinaEditor/Edit/editor.htm?id=workremind2&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");}
</script>
													</td>
													<td>
														<FONT color=#ff0000>*</FONT>
														<FONT color=#ff0000 id="workremind2Msg"></FONT>
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


								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									重要程度
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td height="27" width="50"></td>
													<td width="72">
														重要程度
													</td>
													<td width="174">
														<select class="SelectStyle" id="importantLevel2"
															name="importantLevel">
															<option value="0">
																不重要
															</option>
															<option value="1">
																一般
															</option>
															<option value="2">
																重要
															</option>
														</select>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div id="InputDetailBar">
									<table align="center" border="0" cellpadding="10"
										cellspacing="0">
										<tbody>
											<tr>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="submit" value="保存" name="subBtn" id="subBtn">
														</div>
														<div class="FuncBtnTail">
														</div>
													</div>
												</td>
												<td>
													<div class="FuncBtn">
														<div class="FuncBtnHead"></div>
														<div class="FuncBtnMemo">
															<input
																style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
																type="reset" value="重置" name="resBtn" id="resBtn">
														</div>
														<div class="FuncBtnTail"></div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- 提醒E -->


					</center>
				</div>
			</div>
		</div>
		<!-- 以下用来隐藏各种传递参数 -->

		<input type="hidden" name="is" id="is" value="0" />
	</body>
</html>