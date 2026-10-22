<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.fuao.fajxc.util.TimePattern"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新建工作日志</title>
		<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
	</HEAD>
<script type="text/javascript">
	function parseMessage() {
		var oEditor = FCKeditorAPI.GetInstance('content'); 
 	    var content = oEditor.GetXHTML(true);
 	    if( null == content || "" == content){
 	    	alert('日志内容不能为空！');
 	    	return false;
 	    }
			Form1.submit();
			return true;
	}	
							
</script>

  <body class="PopupWinBody1">
		<form id="Form1" method="post" action="addToWorkLog.do">
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					新增日志
					<input type="hidden" name="type" id="type" value="2">
				</div>
			</div>
			<div class="Case_Content" style="margin-left: 0px;">请在下方填写工作日志：
				<center>
				<div style="height: 612px; overflow: auto">
					<!-- 添加日志时自动加入模板 Start-->
					<table width="100%"><tbody><tr><td>
					<FCK:editor instanceName="content" inputName="content" height="600px" basePath="/fckeditor" >
						<jsp:attribute name="value">
						<!-- S模版内的内容CSS样式 -->
						 <style type="text/css">
						    div{ overflow:hidden;}
						  	#divZD{ width:auto; height:auto;}
							
							#divTop{ width:auto; height:auto;}
							#divGzrz{font-size:18px; font-weight:bold; text-align:center; color:#ff0000;}
							#divSsbm{ width:auto; height:40px; text-align:center; line-height:40px; color:#00C; font-size:16px; font-weight:bold;}
							
							#divMain{ width:auto; height:auto;}
							#divGzqk{ width:auto; height:auto;}
							#divGzqk_Bth{ width:96.4%; height:35px; color:#F00; font-size:24px; line-height:35px; font-weight:bold; }
							#divJrrw{ width:auto; height:auto;}
							#divJrrw_Bth{ width:96.4%; height:35px; color:#F00; font-size:24px; line-height:35px; font-weight:bold; }
							#divJrrw_LieH{ width:auto; height:auto;}
							#divJrrw_Lie{ width:24%; height:35px; float:left; line-height:35px; border-top:1px #CCC solid; border-left:1px solid #CCC; border-bottom:1px solid #CCC; text-align:center; color:#00F; font-weight:bold;}
							#divJrrw_LieNrH{ width:auto; height:auto; margin-bottom:20px;}
							#divJrrw_LieNr{  width:24%; height:100px; float:left; border-left:1px solid #CCC; border-bottom:1px solid #CCC; color:#333; font-size:14px; padding-top:5px;}
							
							#divJxrw{ width:auto; height:auto;}
							#divJxrw_Bth{width:96.4%; height:40px; color:#F00; font-size:24px; line-height:40px; font-weight:bold; clear:both;}
							#divJxrwLieH{ width:auto; height:auto;}
							#divJxrw_Lie{ width:19.2%; height:35px; float:left; line-height:35px; border-top:1px #CCC solid; border-left:1px solid #CCC; text-align:center; color:#00F; font-weight:bold; word-break:break-all;}
							#divJxrw_LieNrH{ width:auto; height:auto; margin-bottom:20px;}
							#divJxrw_LieNr{ width:19.2%; height:100px; float:left; border-top:1px #CCC solid; border-left:1px solid #CCC; border-bottom:1px solid #CCC; font-size:14px; padding-top:5px; word-break:break-all;}
							
							#divCzSys{ width:auto; height:auto;}
							#divCzSys_Bth{ width:96.4%; height:40px; color:#F00; font-size:24px; line-height:40px; font-weight:bold; clear:both;}
							#divCzSysLieH{ width:auto; height:auto;}
							#divCzSysLie{width:32%; height:35px; float:left; line-height:35px; border-top:1px #CCC solid; border-left:1px solid #CCC; text-align:center; color:#00F; font-weight:bold; word-break:break-all;}
							#divCzSysLieNrH{ width:auto; height:auto; margin-bottom:20px;}
							#divCzSysLieNr{width:32%; height:35px; float:left; line-height:35px; border-top:1px #CCC solid; border-left:1px solid #CCC; border-bottom:1px solid #CCC; word-break:break-all;}
								
							#divBottom{ width:auto; height:auto;}
						  </style>
						<!-- E模版内的内容CSS样式 -->
						<!-- S内容 -->
						<div style="line-height:25px;">
						<div>&nbsp;</div>
						<p style="text-align: center"><strong><span style="font-size: 22pt">工作月报</span></strong></p>
						<p style="height: 10px;">
<p style="text-align: left"><b><span style="font-size: 14pt">姓名：${emp.name }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size: 14pt">所属部门：${emp.department.name }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size: 14pt">提交日期：<%=TimePattern.doTimeDf3(new Date()) %></span></b></p>
<hr />
<div>&nbsp;</div>
<div><b><span style="font-size: 14pt">本月计划：</span></b></div>
<div><span style="font-size: 14pt">1、计划完成任务一。</span></div>
<div><span style="font-size: 14pt">2、计划完成任务二。</span></div>
<div><span style="font-size: 14pt">3、计划完成任务三。</span></div>
<div>&nbsp;</div>
<div><b><span style="font-size: 14pt">本月工作：</span></b></div>
<div><span style="font-size: 14pt">1、完成任务一。</span></div>
<div><span style="font-size: 14pt">2、完成任务二。</span></div>
<div><span style="font-size: 14pt">3、完成任务三。</span></div>
<div>&nbsp;</div>
<div><b><span style="font-size: 14pt">工作备注：</span></b></div>
<div><span style="font-size: 14pt">1、任务一详情与分析。</span></div>
<div><span style="font-size: 14pt">2、任务二详情与分析。</span></div>
<div><span style="font-size: 14pt">3、任务三详情与分析。</span></div>
<div>&nbsp;</div>
<div><b><span style="font-size: 14pt">下月工作计划：</span></b></div>
<div><span style="font-size: 14pt">1、完成任务一。</span></div>
<div><span style="font-size: 14pt">2、完成任务二。</span></div>
<div><span style="font-size: 14pt">3、完成任务三。</span></div>
<div>&nbsp;</div>
<div><b><span style="font-size: 14pt">日志模板说明：</span></b></div>
<div><span style="font-size: 14pt">1、&ldquo;本月工作&rdquo;主要以量化标准汇报本月工作。</span></div>
<div><span style="font-size: 14pt">2、&ldquo;工作备注&rdquo;主要详述相关工作的具体内容以及工作中发现的问题。</span></div>
<div><span style="font-size: 14pt">3、&ldquo;下月工作&rdquo;主要以量化标准规划下月工作。</span></div>
</div>
						<div id="divZD">
						   <!-- 头开始 -->
						   <div id="divTop">
						   <hr />
						   <!-- 头结束 -->
						   <!-- 中开始 -->
						   <div id="divMain">
						    <!-- 今日任务开始 -->
						    <c:if test="${empty misList}"><div id="divJrrw_Bth">今日无任务！</div></c:if>
							<c:if test="${!empty misList}">
						    <div id="divJrrw" style="clear:both;">
						     <div id="divJrrw_Bth">今日任务</div>
						     <div id="divJrrw_LieH">
						     <div id="divJrrw_Lie"> 
						       <strong>任务名称</strong>
						     </div>
						     <div id="divJrrw_Lie" style="width:25%;"> 
						       <strong>任务内容</strong>
						     </div>
						     <div id="divJrrw_Lie"> 
						       <strong>任务完成状态</strong>
						     </div>
						     <div id="divJrrw_Lie" style="border-right:#CCC 1px solid;"> 
						       <strong>反馈信息</strong>
						     </div>
						     </div>
						     <!-- 列的内容开始 -->
						     <div id="divJrrw_LieNrH" >
						      <div id="divJrrw_LieNr">
						      ${data.mission.name }
						      </div>
						      <div id="divJrrw_LieNr" style="width:25%;">
						      ${data.mission.description }
						      </div>
						      <div id="divJrrw_LieNr">
						      	<c:if test="${data.status == 0 }"><span style="font-size: 14pt; color: #ff0000;">任务未接收。</span></c:if>
								<c:if test="${data.status == 1 }"><span style="font-size: 14pt; color: #ff00ff;">任务已接收未完成。</span></c:if>
								<c:if test="${data.status == 2 }"><span style="font-size: 14pt; color: #0000ff;">任务已完成。</span></c:if>
						      </div>
						      <div id="divJrrw_LieNr" style="border-right:#CCC 1px solid;">
						      请输入反馈信息
						      </div>
						     </div>
						     <!-- 列的内容结束 -->
						    </div>
						    </c:if>
						    <!-- 今日任务结束 -->
						    <!-- 继续任务列标题开始 -->
						    <c:if test="${empty meList}"><div id="divJxrw_Bth">无持续任务！</div></c:if>
							<c:if test="${!empty meList}">
						    <div id="divJxrw">
						     <div id="divJxrw_Bth">
						     持续任务
						     </div>
						     <div id="divJxrwLieH">
						      <div id="divJxrw_Lie">任务名称</div>
						      <div id="divJxrw_Lie">任务内容</div>
						      <div id="divJxrw_Lie">任务到期时间</div>
						      <div id="divJxrw_Lie">任务完成状态</div>
						      <div id="divJxrw_Lie" style="border-right:#CCC 1px solid;">跟进记录</div>
						     </div>
						    </div>
						    <!-- 继续任务列标题结束 -->
						    
						    <!-- 继续任务内容行开始 -->
						    <div id="divJxrw_LieNrH">
						     <div id="divJxrw_LieNr">${data.mission.name }</div>
						     <div id="divJxrw_LieNr">${data.mission.description }</div>
						     <div id="divJxrw_LieNr">${data.mission.expEndTime }</div>
						     <div id="divJxrw_LieNr">
						     		<c:if test="${data.status == 0 }"><span style="font-size: 14pt; color: #ff0000;">任务未接收。</span></c:if>
									<c:if test="${data.status == 1 }"><span style="font-size: 14pt; color: #ff00ff;">任务已接收未完成。</span></c:if>
									<c:if test="${data.status == 2 }"><span style="font-size: 14pt; color: #0000ff;">任务已完成。</span></c:if>
							</div>
						     <div id="divJxrw_LieNr" style="border-right:#CCC 1px solid;">${data.completeDescribe }</div>
						    </div>
						    </c:if>
						    <!-- 继续任务内容行结束 -->
						    <!-- 今日自定义任务开始 -->
						    <c:if test="${empty planList}"><div id="divJrrw_Bth">无自定义日程计划！</div></c:if>
							<c:if test="${!empty planList}">
						    <div id="divJrrw" style="clear:both;">
						     <div id="divJrrw_Bth">自定义日程计划</div>
						     <div id="divJrrw_LieH">
						     <div id="divJrrw_Lie" style="width:25%;"> 
						       <strong>任务内容</strong>
						     </div>
						     <div id="divJrrw_Lie">完成状态</div>
						     <div id="divJrrw_Lie" style="border-right:#CCC 1px solid;"> 
						       <strong>反馈信息</strong>
						     </div>
						     </div>
						     <!-- 列的内容开始 -->
						     <div id="divJrrw_LieNrH" >
						      <div id="divJrrw_LieNr" style="width:25%;">
						      ${data.todayWorkContent }
						      </div>
						      <div id="divJrrw_LieNr">
						    	<c:if test="${data.state == 0 }"><span style="font-size: 14pt; color: #ff00ff;">任务未完成。</span></c:if>
								<c:if test="${data.state == 1 }"><span style="font-size: 14pt; color: #0000ff;">任务已完成。</span></c:if>
						      </div>
						      <div id="divJrrw_LieNr" style="border-right:#CCC 1px solid;">
						      请输入反馈信息
						      </div>
						     </div>
						     <!-- 列的内容结束 -->
						    </div>
						    </c:if>
						    <!-- 今日自定义任务结束 -->
						    <!-- 自定持续义任务开始 -->
						    <c:if test="${empty pList}"><div id="divJrrw_Bth">无持续自定义日程任务！</div></c:if>
							<c:if test="${!empty pList}">
						    <div id="divJrrw" style="clear:both;">
						     <div id="divJrrw_Bth">自定持续日程计划</div>
						     <div id="divJrrw_LieH">
						     <div id="divJrrw_Lie"> 
						       <strong>任务内容</strong>
						     </div>
						     <div id="divJrrw_Lie" style="width:25%;"> 
						       <strong>任务计划结束时间</strong>
						     </div>
						     <div id="divJrrw_Lie">任务完成状态</div>
						     <div id="divJrrw_Lie" style="border-right:#CCC 1px solid;"> 
						       <strong>填写跟进记录</strong>
						     </div>
						     </div>
						     <!-- 列的内容开始 -->
						     <div id="divJrrw_LieNrH" >
						      <div id="divJrrw_LieNr">
						      ${data.workMission }
						      </div>
						      <div id="divJrrw_LieNr" style="width:25%;">
						     ${data.endtime }
						      </div>
						      <div id="divJrrw_LieNr" style=" color:#F00; font-size:14px;">
						    	<c:if test="${data.state == 0 }"><span style="font-size: 14pt; color: #ff00ff;">任务未完成。</span></c:if>
								<c:if test="${data.state == 1 }"><span style="font-size: 14pt; color: #0000ff;">任务已完成。</span></c:if>
						      </div>
						      <div id="divJrrw_LieNr" style="border-right:#CCC 1px solid;">
						      请输入反馈信息
						      </div>
						     </div>
						     <!-- 列的内容结束 -->
						    </div>
						    </c:if>
						    <!-- 自定持续义任务结束 -->
						    <div id="divCzSys">
						     <div id="divCzSys_Bth">
						     系统操作记录
						     </div>    
						     <div id="divCzSysLieH">
						      <div id="divCzSysLie">
						      	操作时间
						      </div>
						      <div id="divCzSysLie">
						      	操作内容
						      </div>
						      <div id="divCzSysLie" style="border-right:#CCC 1px solid;">
						      	操作详细
						      </div>
						     </div>
						     <c:forEach items="${recordList }" var="data">
							     <div id="divCzSysLieNrH">
							      <div id="divCzSysLieNr">${data.executeTime }</div>
							      <div id="divCzSysLieNr">${data.content }</div>
							      <div id="divCzSysLieNr" style="border-right:#CCC 1px solid;">
							      	<a href="#" onclick="window.showModalDialog('<%=request.getContextPath() %>/workLogs/goDetailRecord.do?id=${data.id }&entityName=${data.entityName}&entityId=${data.entityId }','','dialogWidth=850px;dialogHeight=550px;');">操作详细</a>
							      </div>
							     </div>
						     </c:forEach>
						    </div>
						   </div>
						   </div>
						   <!-- 中结束 -->
						   <!-- 尾开始 -->
						   <div id="divBottom">
						   </div>
						   <!-- 尾结束 -->
						  </div>
						<!-- E内容 -->
						</jsp:attribute>
					</FCK:editor>
					</td></tr></tbody></table>
					<!-- 添加日志时自动加入模板END -->
				</div>
				</center>
				<div style=" overflow: auto">
					<div>
						<INPUT class="PopupButton3" id="btnSave" onclick="return parseMessage();" type="button" value="保存" style="float: left; margin-left: 150px;">
						<INPUT id="btnreturn" onclick="history.go(-1)" type="button"
							value="返回" name="btnClose" class="PopupButton3"
							style="float: left; margin-left: 165px;">
					</div>
				</div>
			</div>
		</div>
	</form>
	</body>
</HTML>
