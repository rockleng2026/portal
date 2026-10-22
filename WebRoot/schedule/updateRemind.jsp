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
    <title>福奥进销存系统-日程</title>
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
		
		//判断是否完成  根据是否填写完成时间
		function changeState(){
			var finishtime = $("#finishtime").val();
			if(finishtime.length > 5 ){
				$("#state").val(1);
			}else{
				$("#state").val(0);
			}
		}
	</script>
</head>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">

<!-- 防重复提交 -->
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
			<div>
				<div id="MainArea">
					<center>
					<form action="updateScheduleworknotepad.do" method="post" id="form2" name="form2" onsubmit="return addValidators2('form2')">
						<input type="hidden" name="id" id="id" value="${data.id }"/>
						<input type="hidden" name="state" id="state" value="${data.state }"/>
						<s:token name="register2"></s:token>
						<div class="ItemBlock_Title1">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							类型
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody><tr>
										<td height="54" width="50"></td>
										<td width="72">类别</td>
										<td width="543">
											<input value="${data.plantype }" name="plantype" checked="checked" type="radio">日程提醒&nbsp;&nbsp;	
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
									<td width="72">提醒时间</td>
									<td width="400px;">
										<input style="width:150px;" size="10" onblur="checkValueByRules2('remindtime2','','remindtime2Msg')" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d'})" class="inputdate" name="remindtime" id="remindtime2" type="text" value="${data.remindtime }">
										<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="remindtime2Msg"></FONT>
									</td>							
								</tr>
								<tr>
								<td height="27" width="50">
									</td>
									<td width="72">重复:</td>
									<td width="150px;">
								     <select class="SelectStyle" name="remainSet" id="remainSet2">
											<option value="" <c:if test="${data.remainSet == '' }" >selected</c:if> >永不</option>
											<option value="0" <c:if test="${data.remainSet == 0 }" >selected</c:if> >每天</option>
											<option value="1" <c:if test="${data.remainSet == 1 }" >selected</c:if> >每周</option>
											<option value="2" <c:if test="${data.remainSet == 2 }" >selected</c:if> >每两周</option>
											<option value="3" <c:if test="${data.remainSet == 3 }" >selected</c:if> >没月</option>
											<option value="4" <c:if test="${data.remainSet == 4 }" >selected</c:if> >每年</option>
										</select><FONT color=#ff0000 id="remainSet2Msg"></FONT>
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
													<input style="width: 150px;" size="10"	onblur="checkValueByRules2('subjecttitle2','','subjecttitle2Msg')"  class="inputdate"
													 value="${data.subjecttitle }"	name="subjecttitle" id="subjecttitle2" type="text"><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjecttitle2Msg"></FONT>
												</td>
											</tr>
											<tr>
												<td height="27" width="50"></td>
												<td width="72">主题归类:</td>
												<td width="150px;">
													<select class="SelectStyle" name="subjectstyle" id="subjectstyle2">
															<option value="">请选择主题</option>
															<option value="0" <c:if test="${data.subjectstyle == 0 }" >selected</c:if> >公司工作</option>
															<option value="1" <c:if test="${data.subjectstyle == 1 }" >selected</c:if> >开会</option>
															<option value="2" <c:if test="${data.subjectstyle == 2 }" >selected</c:if> >出门拜访</option>
															<option value="3" <c:if test="${data.subjectstyle == 3 }" >selected</c:if> >出门拜访</option>
															<option value="4" <c:if test="${data.subjectstyle == 4 }" >selected</c:if> >其它</option>
													</select><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjectstyle2Msg"></FONT>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						<div class="ItemBlock_Title">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							备忘录
						</div>
						<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
													<textarea  name="workremind" id="workremind2" style="display:none">${data.workremind }</textarea>
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
						
						
						<div class="ItemBlock_Title" >
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							重要程度
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
									<tr>
										<td height="27" width="50"></td>
										<td width="72">重要程度</td>
										<td width="174">
											<select class="SelectStyle" id="importantLevel2" name="importantLevel">
												<option value="0" <c:if test="${data.importantLevel == 0 }" >selected</c:if> >不重要</option>
												<option value="1" <c:if test="${data.importantLevel == 1 }" >selected</c:if> >一般</option>
												<option value="2" <c:if test="${data.importantLevel == 2 }" >selected</c:if> >重要</option>
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
							</tbody></table>
						</div>
					</form>
				</center>
	</div>
</div>
	
</body>
</html>
