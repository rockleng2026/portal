<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@page import="java.text.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<%

   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd ");
    String str =   sdf.format(new Date());
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>福奥进销存系统-日程</title>
		<meta content="MSHTML 6.00.2800.1276" name="GENERATOR">
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<meta http-equiv="Content-Style-Type" content="text/css">
		<meta http-equiv="Pragma" content="no-cache">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0">

		<link href="<%=path%>/Css/desk/mainWin2.css" type="text/css"
			media="screen" rel="stylesheet">
		<link href="<%=path%>/Css/desk/calendar.css" type="text/css"
			media="screen" rel="stylesheet">
		<link href="<%=path%>/Css/desk/mainWin.css" type="text/css"
			media="screen" rel="stylesheet">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>

		<style>
#begintime0 {
	display: none;
}

#endtime0 {
	display: none;
}

#workinput {
	display: none;
}
</style>
	</head>

	<script type="text/javascript">
	var browser=navigator.appName;
	var b_version=navigator.appVersion; 
	var version=b_version.split(";"); 
	var trim_Version=version[1].replace(/[ ]/g,""); 
	</script>
	<script type="text/javascript">
		//判断是否完成的状态
		function changeState(){
			var finishtime = $("#finishtime").val();
			if(finishtime.length > 5 ){
				$("#state").val(1);
			}else{
				$("#state").val(0);
			}
		}


		function showSelect(){
		  var val = $("#subjectstyle1").val();
		  if(val==3){
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
				    	
				    	$("#functionSel").html("");
				    	$("#functionSel").html(data);
						 
				 }
				 });
		}
	</script>

	<script type="text/javascript">
	$(function(){
	  var  va= $('#begintime0').val();
	   var da= va.substring(0,11);
	
	   
	   $('#begintime01').append("<option value=09:00>"+da+" 09:00</option>");
	   $('#begintime01').append("<option value=10:30>"+da+" 10:30</option>");
	   $('#begintime01').append("<option value=12:00>"+da+" 12:00</option>");
	   $('#begintime01').append("<option value=14:00>"+da+" 14:00</option>");
	   $('#begintime01').append("<option value=15:30>"+da+" 15:30</option>");
	   $('#begintime01').append("<option value=17:00>"+da+" 17:00</option>");
	});
	
	
		$(function(){
	  var  va= $('#endtime0').val();
	   var da= va.substring(0,11);
	   $('#endtime01').append("<option value=10:30>"+da+" 10:30</option>");
	    $('#endtime01').append("<option value=12:00>"+da+" 12:00</option>");
	   $('#endtime01').append("<option value=14:00>"+da+" 14:00</option>");
	   $('#endtime01').append("<option value=15:30>"+da+" 15:30</option>");
	   $('#endtime01').append("<option value=17:00>"+da+" 17:00</option>");
	   $('#endtime01').append("<option value=18:30>"+da+" 18:30</option>");
	});
	
	
	</script>

	<script type="text/javascript">

$(function(){
   $('#tog1').toggle(function(){
    $('#begintime0').show();
    $('#begintime0').attr('name','begintime');
    $('#begintime0').attr('value','');
   
    
    $('#btime2').attr('name','begintime1');
    $('#begintime01').hide();
    $('#tog1').attr('value','选择性时间');
   
   },function(){
   
    $('#begintime01').show();
    $('#begintime0').hide(); 
    var  va= $('#btime').val();
	 var da= va.substring(0,11);
	 var  stri=da+''+'00:00:00';
     $('#begintime0').attr('value',stri);
     
     $('#begintime0').attr('name','begintime1');
    $('#btime2').attr('name','begintime');
    $('#tog1').attr('value','自定义时间');
  
   });
});


$(function(){
   $('#tog2').toggle(function(){
    $('#endtime0').show();
    $('#endtime0').attr('name','endtime');
    $('#endtime0').attr('value','');
    
    $('#etime2').attr('name','endtime01');
    
    $('#endtime01').hide();
    $('#tog2').attr('value','选择性时间');
   
   },function(){
   
    $('#endtime01').show();
    $('#endtime0').hide(); 
    $('#endtime0').attr('value','11:11');
    $('#etime2').attr('name','endtime');
    $('#endtime0').attr('name','endtime01');
      $('#tog2').attr('value','自定义时间');
  
   });
});


	
	
	
	
	
   $(function(){
     $('#work1').toggle(
     function(){
        $('#workinput').show();
        $('#workinput').attr('name','subjecttitle');
     $('#subjecttitle0').attr('name','subjecttitle1');
     $('#subjecttitle0').hide();
     $('#work1').attr('value','选择');
     },function(){
      $('#workinput').hide();
     $('#subjecttitle0').show();
     
   $('#subjecttitle0').attr('name','subjecttitle');
     $('#workinput').attr('name','subjecttitle1');
     $('#work1').attr('value','自定义');
     });
    
    });
    
    
    
    
    
    $(function(){
     $('#begintime01').blur(function(){
     var beg=$('#begintime01').val();
     var  va= $('#btime').val();
	 var da= va.substring(0,11);
     if(beg==11){
     $('#btime2').attr('value',va);
     $('#btime2').val();
     }else{
     var str=da+''+beg;
     $('#btime2').attr('value',str);
     }
     }); 
    });  
    
    
    
	
    $(function(){
     $('#endtime01').blur(function(){
     var end=$('#endtime01').val();
     var  va= $('#etime').val();
	 var da= va.substring(0,11);
     if(end==22){
     $('#etime2').attr('value',va);
     $('#etime2').val();
     }else{
     var str=da+''+end;
     $('#etime2').attr('value',str);
     }
     }); 
    });
	</script>



	</head>

	<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
		<div id="Calendar" scrolling="no"
			style="border: 0px solid #EEEEEE; position: absolute; width: 150; height: 137; z-index: 200; filter: 'progid:DXImageTransform.Microsoft.Shadow(direction=135,color=#AAAAAA,strength=4)'; display: none"></div>
		<div id="Clock" scrolling="no"
			style="color: #2b333c; font-size: 14px; padding: 10px; border: 1px solid #EEEEEE; position: absolute; background: #FFFFFF; width: 150; z-index: 200; filter: 'progid:DXImageTransform.Microsoft.Shadow(direction=135,color=#AAAAAA,strength=1)'; display: none">
		</div>

		<input name="functionName" type="hidden">
		<div id="Title_bar">
			<div id="Title_bar_Head">
				<div id="Title_Head">
				</div>
				<div id="Title">
					<img src="<%=path%>/images/desk/title_arrow.gif" border="0"
						height="13" width="13">
					修改日程事务
				</div>
				<div id="Title_End">
				</div>
				<div id="Title_bar_bg"></div>
			</div>

		</div>
		<div>
			<div>
				<div id="MainArea">
					<center>
						<form action="updateScheduleworknotepad.do" method="post"
							id="form1" name="form1" onsubmit="return addValidators2('form1')">
							<s:token name="register"></s:token>
							<input type="hidden" name="id" id="id1" value="${data.id }" />
							<input type="hidden" name="plan.isplan" value="${data.isplan }">
							<div class="ItemBlock_Title1">
								<img src="<%=path%>/images/desk/item_point.gif" border="0">
								类型
							</div>
							
							
							




							<div class="ItemBlockBorder">
								<div class="ItemBlock">
									<table border="0" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td height="54" width="50"></td>
												<td width="72">
													类别
												</td>
												<td width="543">
													<input value="${data.plantype }" name="plantype"
														checked="checked" type="radio">
													日程记事&nbsp;&nbsp;
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="ItemBlock_Title">

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
									
										<input style="width:150px;" size="10" onblur="checkValueByRules2('begintime0','','begintime0Msg')" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00',maxDate:'%y-%M-%d 23:59:58'})" class="inputdate" name="begintime1" id="begintime0" type="text" value="${data.begintime }">
							
						    	<input type="hidden" id="btime" name="btime" value="${data.begintime }"></input>
						    	<input type="hidden" id="btime2" name="begintime" value="${data.begintime }"></input>
							         
									<select style="width:150px;"   class="inputdate" name="begintime2" id="begintime01" >
									            <option value="11">${data.begintime }</option>
									          
									</select>
							
				
							             <input id="tog1" type="button"  value="自定义时间"  >
							             
										<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="begintime0Msg"></FONT>
									</td>									
								</tr>
								<tr>
									<td height="27">										
									</td>
									<td>结束时间</td>
									<td>
									<input  style="width:150px;" size="10" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime0\')}',maxDate:'%y-%M-%d 23:59:59'})" onblur="checkValueByRules2('endtime0','','endtimeMsg')" class="inputdate" name="endtime1" id="endtime0" type="text" value="${data.endtime}">
									
									<input type="hidden" id="etime" name="etime" value="${data.endtime }"></input>
									<input type="hidden" id="etime2" name="endtime" value="${data.endtime }"></input>
									
									<select style="width:150px;"  class="inputdate" name="endtime3" id="endtime01" onblur="timechange2()">
									            <option value="22">${data.endtime }</option>
												
									</select>
									
									
									
									  <input id="tog2" type="button"  value="自定义时间"  >
									  
									<FONT color=#ff0000>*</FONT> 点击输入框获取时间(如果为工作提醒，这个日期不做限制)<FONT color=#ff0000 id="endtimeMsg"></FONT>
								</tr>
								</tbody>
								</table>
									</div>
						</div>
						<div class="ItemBlock_Title">
							
							
							
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
													计划主题:
												</td>
												<td width="250" colspan="2">
													<select style="width: 150px;"
														onblur="checkValueByRules2('subjecttitle0','','subjecttitle0Msg')"
														class="inputdate" name="subjecttitle" id="subjecttitle0">
														<option value="${data.subjecttitle}">
															${data.subjecttitle}
														</option>
														<option value="公司工作"
															<c:if test="${data.subjecttitle  == '公司工作'}" >selected</c:if>>
															公司工作
														</option>
														<option value="开会"
															<c:if test="${data.subjecttitle  == '开会'}" >selected</c:if>>
															开会
														</option>
														<option value="出门拜访"
															<c:if test="${data.subjecttitle  == '出门拜访'}" >selected</c:if>>
															出门拜访
														</option>
														<option value="项目管理"
															<c:if test="${data.subjecttitle  == '项目管理'}" >selected</c:if>>
															项目管理
														</option>
														<option value="调查"
															<c:if test="${data.subjecttitle  == '调查'}" >selected</c:if>>
															调查
														</option>
														<option value="其它"
															<c:if test="${data.subjecttitle  == '其它'}" >selected</c:if>>
															其它
														</option>
													</select>


													<input style="width: 150px;" size="10" class="inputdate"
														name="subjecttitle1" id="workinput">

													<input type="button" value="自定义" id="work1">


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
														onblur="checkValueByRules2('subjectstyle1','','subjectstyle1Msg')"
														　 onchange="showSelect()">
														<c:if test="${taskid == null}">
														<option value="">
															请选择主题
														</option>
														<option value="0"
															<c:if test="${data.subjectstyle == 0 }" >selected</c:if>>
															公司工作
														</option>
														<option value="1"
															<c:if test="${data.subjectstyle == 1 }" >selected</c:if>>
															开会
														</option>
														<option value="2"
															<c:if test="${data.subjectstyle == 2 }" >selected</c:if>>
															出门拜访
														</option>
														</c:if>
														<c:if test="${taskid != null}">
														<option value="3"
															<c:if test="${data.subjectstyle == 3 }" >selected</c:if>>
															项目管理
														</option>
														</c:if>
														<c:if test="${taskid == null}">
														<option value="3"
															<c:if test="${data.subjectstyle == 3 }" >selected</c:if>>
															项目管理
														</option>
														</c:if>
														<c:if test="${taskid == null}">
														<option value="4"
															<c:if test="${data.subjectstyle == 4 }" >selected</c:if>>
															其它
														</option>
														</c:if>
													</select>
													<FONT color=#ff0000>*</FONT><FONT color=#ff0000
														id="subjectstyle1Msg"></FONT>
												</td>
												<c:if test="${taskid !=null}">
												<td id="prj">
												
													<select style="width: 150px" id="myprj" class="SelectStyle"
														name="project" onchange="getPrjName()">
														<option value="${newpro.id}">
															${newpro.projectname}
														</option>
														<c:forEach items="${prjlist}" var="project">
															<option value="${project.id }">
																${project.projectname }
															</option>
														</c:forEach>
													</select>
												
													<FONT color=#ff0000>*</FONT>&nbsp;&nbsp;&nbsp;
													<select style="width: 150px" id="functionSel"
														class="SelectStyle" name="plan.function.id">
														<c:forEach items="${listfunction}" var="function">
														<option value="${function.id}">
															${function.functionname}
														</option>
														</c:forEach>
													</select>
													<FONT color=#ff0000>*</FONT>
												</td>
													</c:if>
													<c:if test="${taskid ==null}">
												<td id="prj" style="display: none;">
												
													<select style="width: 150px" id="myprj" class="SelectStyle"
														name="project" onchange="getPrjName()">
														<option value="${newpro.id}">
															${newpro.projectname}
														</option>
														<c:forEach items="${prjlist}" var="project">
															<option value="${project.id }">
																${project.projectname }
															</option>
														</c:forEach>
													</select>
												
													<FONT color=#ff0000>*</FONT>&nbsp;&nbsp;&nbsp;
													<select style="width: 150px" id="functionSel"
														class="SelectStyle" name="plan.function.id">
														<c:forEach items="${listfunction}" var="function">
														<option value="${function.id}">
															${function.functionname}
														</option>
														</c:forEach>
													</select>
													<FONT color=#ff0000>*</FONT>
												</td>
													</c:if>
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
														class="inputdate" name="organizer" id="organizer0"
														name="organizer" type="text"
														value="${data.employee.name }">
													<FONT color=#ff0000>*</FONT><FONT color=#ff0000
														id="organizer0Msg"></FONT>一个人就填写自己
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
														<option value="无"
															<c:if test="${data.participator  == '无'}" >selected</c:if>>
															无
														</option>
														<option value="美工"
															<c:if test="${data.participator == '美工'}" >selected</c:if>>
															美工
														</option>
														<option value="开发组"
															<c:if test="${data.participator  == '开发组'}" >selected</c:if>>
															开发组
														</option>
														<option value="销售部"
															<c:if test="${data.participator == '销售部'}" >selected</c:if>>
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
														<c:if test="${data.isplan == 0 }" > checked="checked"</c:if>>
													&nbsp;是&nbsp;
													<input id="isplan0" name="isplan" value="1"
														<c:if test="${data.isplan == 1 }" > checked="checked"</c:if>
														type="radio">
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
														type="radio"
														<c:if test="${data.effective == 0 }" > checked="checked"</c:if>>
													&nbsp;优&nbsp;
													<input id="effective0" name="effective" value="1"
														type="radio"
														<c:if test="${data.effective == 1 }" > checked="checked"</c:if>>
													&nbsp;良&nbsp;
													<input id="effective0" name="effective" value="2"
														type="radio"
														<c:if test="${data.effective == 2 }" > checked="checked"</c:if>>
													&nbsp;一般
													<input id="effective0" name="effective" value="3"
														type="radio"
														<c:if test="${data.effective == 3 }" > checked="checked"</c:if>>
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
													<textarea name="workcontent" id="workcontent0"
														style="display: none">${data.workcontent }</textarea>
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
					</center>
				</div>
	</body>
</html>
