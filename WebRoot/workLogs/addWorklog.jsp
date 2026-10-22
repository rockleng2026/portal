<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.fuao.fajxc.util.TimePattern"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta content="MSHTML 6.00.2800.1276" name="GENERATOR">
	    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
	    <meta http-equiv="Content-Style-Type" content="text/css">
	    <meta http-equiv="Pragma" content="no-cache">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0">	
		<title>新建工作日志</title>
		<link href="<%=path %>/Css/desk/mainWin2.css" type="text/css" media="screen" rel="stylesheet">
		<link href="<%=path %>/Css/desk/calendar.css" type="text/css" media="screen" rel="stylesheet">
		<link href="<%=path %>/Css/desk/mainWin.css" type="text/css" media="screen" rel="stylesheet">
		<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path %>/js/util/ckbrowserutil.js"></script>
	</HEAD>
<script type="text/javascript">
function AddProject()
{
	 window.location.href="loadApprovernewProject.do";
}

function AddDayPlan()
{
	window.location.href="goAddworknotepad.do?data=1";
}

function addClick(id){
	alert("弹出层");
	$("#floatDiv").load("float.html");
}
function showDiv(divid){
      if($("#"+divid).css("display")=="none"){
        $("#"+divid).show();
      	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow.gif");
      }else{
      	$("#"+divid).hide();
      	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow2.gif");
      }
}
	function parseMessage() {
		//var oEditor = FCKeditorAPI.GetInstance('content'); 
 	    //var content = oEditor.GetXHTML(true);
 	    //if( null == content || "" == content){
 	    //alert('日志内容不能为空！');
 	    //return false;
 	   //}
		var result = confirm("日志一天只能提交一次，你确定提交吗！");
		if(result == true){
		    var content = $("#logcontentDiv").html();
		    //alert(content);
			$("#content").val(content);
			form1.submit();
			return result;
		}else{
			return result;
		}
	}
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">

<form action="addToWorkLog.do" method="post" id="form1" name="form1" onsubmit="return addValidators2('form1')">

<input type="hidden" id="content" name="content">
<input type="hidden" name="type" id="type" value="0">
<div id="logcontentDiv">
<div>&nbsp;</div>
<p style="text-align: center"><strong><span style="font-size: 22pt">工作日报</span></strong></p>
<p style="height: 10px;">&nbsp;</p>
<p style="text-align: left"><b><span style="font-size: 14pt">姓名：${emp.name } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size: 14pt">所属部门：${emp.department.name }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style="font-size: 14pt">提交日期：<%=TimePattern.doTimeDf3(new Date()) %></span></b>
</p>
<div id="Title_bar" onclick="showDiv('missionDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="missionDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			任务
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="missionDiv">
<c:if test="${misList== null || fn:length(misList) == 0}">暂无此任务</c:if>
<c:forEach items="${misList}" var="data" varStatus="i" >
<div class="ItemBlock_Title" onclick="showDiv('mission${i.index+1}')">
	<img src="<%=path %>/images/desk/item_point.gif" border="0">任务${i.index+1}
</div>

<div class="ItemBlockBorder" id="mission${i.index+1 }">
<div class="ItemBlock" >
	<table border="0" cellpadding="0" cellspacing="0">
		<tbody>
		<tr>
			<td width="60">任务名称</td>
			<td width="120">${data. mission.name}</td>
		</tr>
		<tr>
			<td width="80">预计截止时间</td>
			<td width="120">${data.mission.expEndTime }</td>
			<td height="27" width="60"></td>
			<td width="60"></td>
		</tr>
		<tr>
			<td width="60">是否完成</td>
			<td width="120">
			<c:if test="${data.status == 0}">为接受</c:if>
			<c:if test="${data.status == 1}">已接受</c:if>
			<c:if test="${data.status == 2}">已完成</c:if>
			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td width="60">任务详细</td>
			<td colspan="3">
			</td>
		</tr>
		<tr>
			<div>${data.mission.description }</div>
		</tr>
		</tbody>
	</table>
</div>
</div>
</c:forEach>
</div>
<div id="Title_bar" onclick="showDiv('planDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
							<img id="planDivImg" src="<%=path %>/images/desk/title_arrow.gif"
								border="0" height="13" width="13">
							计划 &nbsp;&nbsp;<input type="button" value="添加日计划" onclick="AddDayPlan()"/>
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div>


<div id="planDiv">
<c:choose>
<c:when test="${yesterdayPlanList== null || fn:length(yesterdayPlanList) == 0}">暂无昨天为今天所做的任务计划</c:when>
<c:otherwise>
<div>
 <div style="height:25px;width:100%;backgound:#fff;margin:3px 3px 3px 3px;text-align: left;">
 		<h3 style="text-align: text">昨天为今天所做的任务计划</h3>
 </div>
</div><c:forEach items="${yesterdayPlanList}" var="data" varStatus="i">
<div class="ItemBlock_Title" onclick="showDiv('plan${i.index+1 }')">
	<img src="<%=path %>/images/desk/item_point.gif" border="0">计划${i.index+1 }
</div>
<div class="ItemBlockBorder" id="plan${i.index+1 }">
<div class="ItemBlock" >
<table border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td width="60">计划标识</td>
		<td width="120">${data.subjecttitle }</td>
		<td height="27" width="60">计划归类</td>
		<td width="60">${data.subjectstyle }</td>
	</tr>
	<tr>
		<td width="60">开始时间</td>
		<td width="120">${data.begintime }</td>
		<td height="27" width="60">结束时间</td>
		<td width="60">${data.endtime }</td>
	</tr>
	<tr>
		<td width="60">重要程度</td>
		<td width="120">
		<c:if test="${data.importantLevel==0 }">不重要</c:if>
		<c:if test="${data.importantLevel==2 }">重要</c:if>
		<c:if test="${data.importantLevel==1 }">一般</c:if>
		</td>
		<td height="27" width="60"></td>
		<td width="60"></td>
	</tr>
	<tr>
		<td width="60">计划内容</td>
		<td colspan="3">
				${data.tomorrowWorkPlan }
		</td>
	</tr>
	</tbody>
</table>

</div>
</div>
</c:forEach>
</c:otherwise>
</c:choose>
</div>



<div id="planDiv">
<c:choose>
<c:when test="${planList== null || fn:length(planList) == 0}">暂无今天所做的任务计划</c:when>
<c:otherwise>
<div>
 <div style="height:25px;width:100%;backgound:#fff;margin:3px 3px 3px 3px;text-align: left;">
 		<h3 style="text-align: text">今天所做的任务计划</h3>
 </div>
</div>
<c:forEach items="${planList}" var="data" varStatus="i">
<div class="ItemBlock_Title" onclick="showDiv('plan${i.index+1 }')">
	<img src="<%=path %>/images/desk/item_point.gif" border="0">计划${i.index+1 }
</div>
<div class="ItemBlockBorder" id="plan${i.index+1 }">
<div class="ItemBlock" >
<table border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td width="60">计划标识</td>
		<td width="120">${data.subjecttitle }</td>
		<td height="27" width="60">计划归类</td>
		<td width="60">${data.subjectstyle }</td>
	</tr>
	<tr>
		<td width="60">开始时间</td>
		<td width="120">${data.begintime }</td>
		<td height="27" width="60">结束时间</td>
		<td width="60">${data.endtime }</td>
	</tr>
	<tr>
		<td width="60">重要程度</td>
		<td width="120">
		<c:if test="${data.importantLevel==0 }">不重要</c:if>
		<c:if test="${data.importantLevel==2 }">重要</c:if>
		<c:if test="${data.importantLevel==1 }">一般</c:if>
		</td>
		<td height="27" width="60"></td>
		<td width="60"></td>
	</tr>
	<tr>
		<td width="60">计划内容</td>
		<td colspan="3">
			${data.todayWorkPlan }
		</td>
		
	</tr>
	</tbody>
</table>

</div>
</div>
</c:forEach>
</c:otherwise>
</c:choose>
</div>
<div id="Title_bar" onclick="showDiv('workrecordDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="workrecordDivImg"  src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			日程&nbsp;&nbsp;<input type="button" value="添加日记事" class="showbox"/>
			&nbsp;&nbsp;<input type="button" value="发起项目" onclick="AddProject()"/>
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="workrecordDiv" >
<c:if test="${workList== null || fn:length(workList) == 0}">暂无工作记事</c:if>
<c:forEach items="${workList}" var="data" varStatus="i">
<div class="ItemBlock_Title" onclick="showDiv('work${i.index+1 }')">
	<img src="<%=path %>/images/desk/item_point.gif" border="0">工作${i.index+1 }
</div>
<div class="ItemBlockBorder" id="work${i.index+1 }">
<div class="ItemBlock" >
<table border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td width="60">工作标识</td>
		<td width="120">${data.subjecttitle }</td>
		<td height="27" width="60">工作归类</td>
		<td width="60">${data.subjectstyle }</td>
	</tr>
	<tr>
		<td width="60">发起人员</td>
		<td width="120">${data.organizer }</td>
		<td height="27" width="60">参与人员</td>
		<td width="60">${data.participator }</td>
	</tr>
	<tr>
		<td width="60">开始时间</td>
		<td width="120">${data.begintime }</td>
		<td height="27" width="60">结束时间</td>
		<td width="60">${data.endtime }</td>
	</tr>
	<tr>
		<td width="60">既定计划</td>
		<td width="120">
		<c:if test="${data.isplan==0 }">是</c:if>
		<c:if test="${data.isplan==1 }">否</c:if>
		</td>
		<td height="27" width="60">既定效果</td>
		<td width="60">
		<c:if test="${data.effective==0 }">优</c:if>
		<c:if test="${data.effective==1 }">良</c:if>
		<c:if test="${data.effective==2 }">一般</c:if>
		<c:if test="${data.effective==3 }">差</c:if>
		</td>
	</tr>
	<tr>
		<td width="60">工作概述</td>
		<td colspan="3">
		</td>
	</tr>
	<tr>
		${data.workcontent }
	</tr>
	</tbody>
</table>
</div>
</div>
</c:forEach>
</div>
</div>
</div>
<div id="Title_bar"  onclick="showDiv('workresultDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="workresultDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			个人总结
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="workresultDiv">
	<div class="ItemBlockBorder">
		<div class="ItemBlock">
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td width="622" height="457" colspan="3">
						<textarea  name="workresult" id="workresult" style="display:none" ></textarea>
<script type="text/javascript">
if(Sys.ie=="9.0") 
{
$("#workresult").show();
//alert("IE 8.0");
}
else 
{ document.write("<iframe src='SinaEditor/Edit/editor.htm?id=workresult&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");
}
</script>
						</td>
						<td>
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="workresultMsg"></FONT>
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
</div>
<div id="Title_bar"  onclick="showDiv('temperDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="temperDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			今日心情
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="temperDiv">
	<div class="ItemBlockBorder">
		<div class="ItemBlock">
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td width="622" height="457" colspan="3">
						<textarea  name="selftemper" id="selftemper" style="display:none" ></textarea>
<script type="text/javascript">
if(Sys.ie=="9.0") 
{
$("#selftemper").show();
//alert("IE 8.0");
}
else 
{ document.write("<iframe src='SinaEditor/Edit/editor.htm?id=selftemper&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");
}
</script>
						</td>
						<td>
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="sleftemperMsg"></FONT>
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
</div>
<div id="Title_bar"  onclick="showDiv('suggestionDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="suggestionDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			投诉建议
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="suggestionDiv">
	<div class="ItemBlockBorder">
		<div class="ItemBlock">
			<table border="0" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<td width="622" height="457" colspan="3">
						<textarea  name="suggestion" id="suggestion" style="display:none" ></textarea>
<script type="text/javascript">
if(Sys.ie=="9.0") 
{
$("#suggestion").show();
//alert("IE 8.0");
}
else 
{ document.write("<iframe src='SinaEditor/Edit/editor.htm?id=suggestion&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");
}
</script>
						</td>
						<td>
							<FONT color=#ff0000>*</FONT>
							<FONT color=#ff0000 id="suggestionMsg"></FONT>
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
</div>

<div id="Title_bar"  onclick="showDiv('fujianDiv')">
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		
		<div id="Title">
			<img id="fujianDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			附件
		</div>
		
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
	</form>
<div id="fujianDiv">

<jsp:include page="/workLogs/uploadfiles.jsp"></jsp:include>

</div>
<div id="InputDetailBar">
	<table align="center" border="0" cellpadding="10" cellspacing="0">
		<tbody>
			<tr>
			<td>										
			<div class="FuncBtn"><div class="FuncBtnHead"></div>
	        <div class="FuncBtnMemo">
	        	<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" type="button" onclick="return parseMessage();"  value="保存" name="subBtn" id="subBtn"></div>
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





<div id="floatDiv">
<script type="text/javascript"> 
$(function(){
	
	$(".showbox").click(function(){
		$("#TB_overlayBG").css({
			display:"block",height:$(document).height()
		});
		$(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		});
	});
	
	$(".close").click(function(){
		$("#TB_overlayBG").css("display","none");
		$(".box ").css("display","none");
	});
	$(".submitclick").click(function(){
	   if(addValidators2('form0')){
	    //alert(11);
	   	//var begintime = $("#begintime0").val();
	   //var endtime = $("#endtime0").val();
	   	//var subjecttitle = $("#subjecttitle0").val();
	   	//var subjectstyle = $("#subjectstyle0").val();
	   //var organizer = $("#organizer0").val();
	   //var participator = $("#participator0").val();
	   	//var isplan = $("#isplan0").val();
	   	//var effective = $("#effective0").val();
	   	var content  = $("#content0").val();
	   	if( content == null || content == ''){
	   		alert("请填写工作概述!");
	   		return false;
	   	}
	   	//alert(content);
	   	var reg=new RegExp("<br />","g"); 
	   	content = content.replace(reg,"\r\n");
	   	$("#workcontent0").val(content);
	   	//
	   	//var url = "xx.do?tt"+(new Date().getTime());
	   	//$.post(url,{},function(data){});
	   	 $("#form0").submit();
	   }
	});
});
</script>
<p><style type="text/css"> 
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
a{color:#5e5e5e;text-decoration:none;}
a:hover{color:#3366cc;text-decoration:underline;}
/* box */
.box{position:absolute;width:650px;left:50%;height:auto;z-index:100;background-color:#fff;border:1px #8FA4F5 solid;padding:1px;}
.box h2{height:25px;font-size:14px;background-color:#3366cc;position:relative;padding-left:10px;line-height:25px;color:#fff;}
.box h2 a{position:absolute;right:5px;font-size:12px;color:#fff;}
.box .mainlist{padding:10px;}
.box .mainlist li{height:24px;line-height:24px;}
.box .mainlist li span{margin:0 5px 0 0;font-family:"宋体";font-size:12px;font-weight:400;color:#ddd;}
#TB_overlayBG{background-color:#666;position:absolute;z-index:99;left:0;top:0;display:none;width:100%;height:100%;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
</style></p>
<div id="TB_overlayBG">&nbsp;</div>
<div style="display:none" class="box">
<h2>添加日程记事<a class="close" href="#">关闭</a></h2>
<form action="addScheduleInfo.do" method="post" id="form0" name="form0" >
<s:token name="register0"></s:token>
<input type="hidden" id="mark" name="mark" value="worklog" />
<input type="hidden" id="workcontent0" name="workcontent" value="" />
<div class="mainlist">
<ul>
 <li><input type="radio"  value="5" id="plantype" name="plantype" checked="checked"/>日记事 </li>
 <li>开始时间：<input  style="width: 150px;"  type="text" onblur="checkValueByRules2('begintime0','','begintime0Msg')" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00',maxDate:'%y-%M-%d 23:59:58'})" name="begintime" id="begintime0"  /><FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="begintime0Msg"></FONT></li>
 <li>结束时间：<input  type="text" style="width: 150px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begintime0\')}',maxDate:'%y-%M-%d 23:59:59'})" onblur="checkValueByRules2('endtime0','','endtimeMsg')" name="endtime" id="endtime0" /><FONT color=#ff0000>*</FONT> 点击输入框获取时间(如果为工作提醒，这个日期不做限制)<FONT color=#ff0000 id="endtimeMsg"></FONT></li>
 <li>工作主题：<input  style="width: 150px;"  type="text" size="10" 	onblur="checkValueByRules2('subjecttitle0','','subjecttitle0Msg')" name="subjecttitle" id="subjecttitle0" /><FONT color=#ff0000>*</FONT>10字符以内<FONT color=#ff0000 id="subjecttitle0Msg"></FONT></li>
 <li>工作归类：<select style="width:150px" class="SelectStyle" name="subjectstyle" id="subjectstyle0" onblur="checkValueByRules2('subjectstyle0','','subjectstyle0Msg')">
    <option value="">请选择主题</option>
    <option value="0">公司工作</option>
    <option value="1">开会</option>
    <option value="2">出门拜访</option>
    <option value="3">出门拜访</option>
    <option value="4">其它</option>
</select><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="subjectstyle0Msg"></FONT></li>
<li>发起人员：<input  style="width: 150px;"  onblur="checkValueByRules2('organizer0','','organizer0Msg')" name="organizer" id="organizer0" name="organizer" type="text" value="${emp.name }" /><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="organizer0Msg"></FONT>默认是自己(*30字以内)</li>
<li>参与人员：<input  style="width: 250px;"  onblur="checkValueByRules2('participator0','','participator0Msg')" name="participator" id="participator0" type="text"/><FONT color=#ff0000>*</FONT>*30字以内,参与者没有则填写无<FONT color=#ff0000 id="participator0Msg"></FONT></li>
<li>既定安排：
<input id="isplan0" name="isplan" value="0" type="radio" checked="checked"/>&nbsp;是&nbsp;
<input id="isplan0" name="isplan" value="1" type="radio"/>&nbsp;否</li>
<li>既定效果：
<input id="effective0" name="effective" value="0" checked="checked" type="radio"/>&nbsp;优&nbsp;
<input id="effective0" name="effective" value="1" type="radio"/>&nbsp;良&nbsp;
<input id="effective0" name="effective" value="2" type="radio"/>&nbsp;一般
<input id="effective0" name="effective" value="3" type="radio"/>&nbsp;差&nbsp;
</li>
<li>工作概要：<FONT color=#ff0000>*</FONT>300字符以内<FONT color=#ff0000 id="content0Msg"></FONT></li>
<li style="height: 100px;">
<textarea  name="content" id="content0" cols="50" rows="10" onblur="checkValueByRules2('content0','','content0Msg')" ></textarea>
</li>
<li>
<span style="text-align: center"><input id="button1" name="button1" value="提交" class="submitclick" type="button"/>&nbsp;
<input id="button2" name="button2" value="关闭" type="button" class="close"/>
</span>
</li>
</ul>
</div>
</form>
<div>
</div>
</div>
</div>
</body>
</HTML>
