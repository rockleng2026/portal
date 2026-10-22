<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
	<script type="text/javascript" src="<%=path %>/js/date2.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript">

	</script>
</head>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
<form action="addScheduleInfo.do" method="post" id="form1" name="form1" onsubmit="return addValidators()">
<!-- 防重复提交 -->
<s:token name="register"></s:token>
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
					日程事务查看
				</div>
				<div id="Title_End">
				</div>
				<div id="Title_bar_bg"></div>
			</div>
			<div id="Title_bar_Tail">
				
			</div>
		</div>
		<div>
			
			<div>
				<div id="MainArea">
					<center>
					<!-- 日程类型选择开始 -->
						<div class="ItemBlock_Title1">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							日程类型
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody><tr>
										<td height="54" width="50"></td>
										<td width="72">类型</td>
										<td width="543">
										<input value="0" name="plantype" checked="checked" type="radio">日计划&nbsp;&nbsp;
										</td>
									</tr>
								</tbody></table>
							</div>
						</div>
						<!-- 日程类型选择结束 -->	
						<div class="ItemBlock_Title">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							工作相关
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
								<tbody>
								<tr>
									<td height="27" width="50">
									</td>
									<td width="92">工作标识</td>
									<td>
										${data.subjecttitle }
									</td>
								</tr>
								<tr>
									<td height="27" width="50">
									</td>
									<td width="92">工作归类</td>
									<td>
										${data.subjectstyle }
									</td>
								</tr>
								<tr>
									<td height="27" width="50">
									</td>
									<td width="92">工作开始时间</td>
									<td>
										${data.begintime }
									</td>
								</tr>
								<tr>
									<td height="27">
										
									</td>
									<td>工作结束时间</td>
									<td>
										${data.endtime }
									</td>
								</tr>
								<tr>
									<td height="27">
									</td>
									<td>工作发起者</td>
									<td>
										${data.organizer }
									</td>
								</tr>
								<tr>
									<td height="27">
									</td>
									<td>工作参与者</td>
									<td>
										${data.participator }
									</td>
								</tr>
								<tr>
									<td height="27">
									</td>
									<td>既定计划</td>
									<td>
										<c:if test="${data.isplan == 0 }" > 是</c:if>
										<c:if test="${data.isplan == 1 }" > 否</c:if>
									</td>
								</tr>
								<tr>
									<td height="27">
									</td>
									<td>既定效果</td>
									<td>
										<c:if test="${data.effective == 0 }" > 优</c:if>
										<c:if test="${data.effective == 1 }" > 良</c:if>
										<c:if test="${data.effective == 2 }" > 一般</c:if>
										<c:if test="${data.effective == 3 }" > 差</c:if>
									</td>
								</tr>
								</tbody>
								</table>
									</div>
								</div>
						<!-- 将今日工作和明日计划2个div包起开始 -->
						<div>							
						<!-- 今日任务开始 -->	
						<div class="ItemBlock_Title">
							<img src="<%=path %>/images/desk/item_point.gif" border="0">
							工作概况
						</div>
						<div class="ItemBlockBorder">
							<div class="ItemBlock">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody><tr>
										<td width="300" colspan="3">
											${data.workcontent }
										</td>										
									</tr>									
									
								</tbody></table>
							</div>
						</div>
						<!-- 今天日任务结束 -->	
						<div id="InputDetailBar">
							<table align="center" border="0" cellpadding="10" cellspacing="0">
								<tbody>
									<tr>
									<td>										
									<div class="FuncBtn"><div class="FuncBtnHead"></div>
							        <div class="FuncBtnMemo">
							        	
								        <div class="FuncBtnTail">
								        </div>
							        </div>
        							</td>									
									<td>
									<div class="FuncBtn">
										<div class="FuncBtnHead"></div>
								        <div class="FuncBtnMemo">
								        	<a href="javascript:history.go(-1);">返回</a>
								        </div>
								        <div class="FuncBtnTail"></div>
							        </div>
        							</td>
								</tr>
							</tbody></table>
						</div>
			</center>
</form>
</body>
</html>
