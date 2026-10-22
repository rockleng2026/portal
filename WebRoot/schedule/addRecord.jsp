<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript">
		//显示和隐藏层
		function onLoad(){
			$("#mission").hide();
		}
		function showDiv(){ 
			$("#todayAndTomorrow").show(); $("#mission").hide();
		} 
		function hideDiv(){ 
			$("#todayAndTomorrow").hide(); $("#mission").show(); 
		}
	</script>
	</head>

	<body topmargin="0" leftmargin="0" onload="onLoad()" marginheight="0"
		marginwidth="0">
		<form action="addScheduleInfo.do" method="post" id="form1"
			name="form1" onsubmit="return addValidators()">
			<!-- 防重复提交 -->
			<s:token name="register"></s:token>
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
													<input onclick="showDiv();" value="5" name="plantype" checked="checked" type="radio">日记事&nbsp;&nbsp;
													<input onclick="showDiv();" value="0" name="plantype" type="radio">日计划&nbsp;&nbsp;
													<input onclick="hideDiv();" value="1" name="plantype" type="radio">周计划&nbsp;&nbsp;
													<input onclick="hideDiv();" value="2" name="plantype" type="radio">月计划&nbsp;&nbsp;
													<input onclick="hideDiv();" value="3" name="plantype" type="radio">季计划&nbsp;&nbsp;
													<input onclick="hideDiv();" value="4" name="plantype" type="radio">年计划&nbsp;&nbsp;
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- 日程类型选择结束 -->
							<div class="ItemBlock_Title">
								<img src="<%=path%>/images/desk/item_point.gif" border="0">
								工作起止时间
							</div>
							<div class="ItemBlockBorder">
								<div class="ItemBlock">
									<table border="0" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td height="27" width="50">
												</td>
												<td width="72">
													工作开始时间
												</td>
												<td width="400px;">
													<input style="width: 150px;" size="10"
														onclick="WdatePicker({dateFmt:'yyyy-MM-dd H:mm:ss',minDate:'%y-%M-%d 00:00:00',maxDate:'%y-%M-%d 23:59:59'})"
														class="inputdate" name="begintime" id="begintime"
														type="text">
													<FONT color=#ff0000>*</FONT> 点击输入框获取时间
													<FONT color=#ff0000 id="begintimeMsg"></FONT>
												</td>
											</tr>
											<tr>
												<td height="27">
												</td>
												<td>
													工作结束时间
												</td>
												<td>
													<input style="width: 150px;" size="10"
														onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime\')}',maxDate:'%y-%M-%d 23:59:59'})"
														class="inputdate"
														name="endtime" id="endtime" type="text">
													<FONT color=#ff0000>*</FONT> 点击输入框获取时间
													<FONT color=#ff0000 id="endtimeMsg"></FONT>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							
							<!--  工作纪要S  -->
							<div class="ItemBlock_Title">
								<img src="<%=path%>/images/desk/item_point.gif" border="0">
								工作相关
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
												<td>
													<input style="width: 150px;" size="10"
														onclick=""
														onblur="" class="inputdate"
														name="recordtitle" id="recordtitle" type="text">
													<FONT color=#ff0000>*</FONT>
												</td>
											</tr>
											<tr>
												<td height="27" width="50">
												</td>
												<td width="72">
													主题归类:
												</td>
												<td width="150px;">
													<select class="SelectStyle" name="recordstyle" id="recordstyle">
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
														</select><FONT color=#ff0000 id="recordstyleMsg"></FONT>
												</td>
											</tr>
											<tr>
												<td height="27">
												</td>
												<td>
													发起人员:
												</td>
												<td>
													<input style="width: 150px;" size="10"
														onclick=""
														onblur="" class="inputdate"
														name="organizer" id="organizer" name="organizer" type="text" value="${emp.name }" >
													<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="organizerMsg"></FONT>一个人就填写自己
												</td>
											</tr>
											<tr>
												<td height="27">
												</td>
												<td>
													参与人员:
												</td>
												<td>
													<input style="width: 150px;" size="10"
														onclick=""
														onblur="" class="inputdate"
														name="participator" id="participator" type="text">
													<FONT color=#ff0000>*</FONT>参与者没有则填写无
													<FONT color=#ff0000 id="participatorMsg"></FONT>
												</td>
											</tr>
											<tr>
															<td height="27" width="50"></td>
															<td height="27" width="72">既定安排</td>
															<td class="TableDetail2" colspan="2">
																<input id="isplan" name="isplan" value="0" type="radio"
																	checked="checked">&nbsp;是&nbsp;
																<input id="isplan" name="isplan" value="1" type="radio">&nbsp;否
															</td>
											</tr>
											<tr>
															<td height="27" width="50"></td>
															<td height="27" width="72">既定效果</td>
															<td class="TableDetail2" colspan="2">
																<input id="effective" name="effective" value="0" type="radio">&nbsp;优&nbsp;
																<input id="effective" name="effective" value="1" type="radio">&nbsp;良&nbsp;
																<input id="effective" name="effective" value="2" type="radio">&nbsp;一般
																<input id="effective" name="effective" value="3" type="radio">&nbsp;差&nbsp;
															</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<!-- 工作纪要E  -->
							<div id="todayAndTomorrow">
								<!-- 今日任务开始 -->
								<div class="ItemBlock_Title">
									<img src="<%=path%>/images/desk/item_point.gif" border="0">
									工作内容
								</div>
								<div class="ItemBlockBorder">
									<div class="ItemBlock">
										<table border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="622" height="457" colspan="3">
													<textarea  name="todayWorkContent" id="todayWorkContent" style="display:none"></textarea>
													<iframe src="SinaEditor/Edit/editor.htm?id=todayWorkContent&ReadCookie=0" frameBorder="0" marginHeight="0" marginWidth="0" scrolling="No" width="621" height="457"></iframe>
													</td>
													<td>
														<FONT color=#ff0000>*</FONT>
														<FONT color=#ff0000 id="todayWorkContentMsg"></FONT>
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
								<!-- 今天日任务结束 -->
							</div>
							<div id="InputDetailBar">
								<table align="center" border="0" cellpadding="10"
									cellspacing="0">
									<tbody>
										<tr>
											<td>
												<div onclick="submitButton('SAVE');" class="FuncBtn">
													<div class="FuncBtnHead"></div>
													<div class="FuncBtnMemo">
														<input
															style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
															type="submit" onclick="getShiJian();" value="保存"
															name="subBtn" id="subBtn">
													</div>
													<div class="FuncBtnTail">
													</div>
												</div>
											</td>
											<td>
												<div onclick="window.close();" class="FuncBtn">
													<div class="FuncBtnHead"></div>
													<div class="FuncBtnMemo">
														<input
															style="background-image: url('<%=path%>/images/desk/awokeBtn_bg.gif'); border-style: none;"
															type="reset" onclick="getShiJian();" value="重置"
															name="resBtn" id="resBtn">
													</div>
													<div class="FuncBtnTail"></div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</center>
					</div>
				</div>
				日历（上）为查看工作日程
				<br />
				日历（下）为查看工作计划
				<div id="div1" style="width: 15%; float: left; margin-top: 10px;"></div>
				<div id="div2" style="width: 15%; float: left; margin-top: 10px;"></div>
				<script>
				 WdatePicker({eCont:'div1',
				 	onpicked:function(dp)
					{
					    window.location.href="goListworknotepad.do?planStyle=0&selectDate=" + dp.cal.getDateStr();
					}
				 })
				 
				 WdatePicker({eCont:'div2',
				 	onpicked:function(dp)
					{
					    window.location.href="goListworknotepad.do?planStyle=1&selectDate=" + dp.cal.getDateStr();
					}
				 })
				 </script>
			</div>
			<!-- 以下用来隐藏各种传递参数 -->
			<input type="hidden" name="state" id="state" value="0" />
		</form>
	</body>
</html>
