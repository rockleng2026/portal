<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.fuao.fajxc.util.TimePattern"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	</HEAD>
<script type="text/javascript">
  function ensureclick(id){
	var loc = "seeReplyWorkLog.do?id="+id;
	window.location = loc;
  }	
function showDiv(divid){
   if($("#"+divid).css("display")=="none"){
    $("#"+divid).show();
   	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow.gif?tt="+(new Date()).getTime());
   }else{
   	$("#"+divid).hide();
   	$("#"+divid+"Img").attr("src", "<%=path %>/images/desk/title_arrow2.gif?tt="+(new Date()).getTime());
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
		    var content = $("#logcontentDiv").html
			$("#content").val(content);
			form1.submit();
			return result;
		}else{
			return result;
		}
	}
	
	
	function checkaccessory(){
	
	}
	function uploadimg(url){
	window.location.href="downloadWorkLog.do?url="+url;
	}
	
</script>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
<form action="" method="post" id="form1" name="form1" onsubmit="return addValidators2('form1')">
<input type="hidden" name="type" id="type" value="${worklog.type }">
<input type="hidden" name="id" id="id" value="${worklog.id }">
<div id="logcontentDiv">
	${worklog.content }
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
			<c:if test="${worklog.workresult == null || worklog.workresult == ''}">内容暂无</c:if>
			<c:if test="${worklog.workresult != null && worklog.workresult != ''}">${worklog.workresult}</c:if>
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
			<c:if test="${worklog.selftemper == null || worklog.selftemper == ''}">内容暂无</c:if>
			<c:if test="${worklog.selftemper != null && worklog.selftemper != ''}">${worklog.selftemper}</c:if>
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
			<c:if test="${worklog.suggestion == null || worklog.suggestion == ''}">内容暂无</c:if>
			<c:if test="${worklog.suggestion != null && worklog.suggestion != ''}">${worklog.suggestion}</c:if>
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
<div id="fujianDiv">
<c:if test="${worklog.accessory==null||worklog.accessory==''}">暂无内容</c:if>

<c:if test="${worklog.accessory!=null&&worklog.accessory!=''}">
<input type="button" value="查看附件" onclick="uploadimg('${worklog.accessory}');"></c:if>


</div>
<div id="Title_bar" onclick="showDiv('piyueListDiv')" >
	<div id="Title_bar_Head">
		<div id="Title_Head">
		</div>
		<div id="Title">
			<img id="piyueListDivImg" src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13">
			上级批阅
		</div>
		<div id="Title_End">
		</div>
		<div id="Title_bar_bg"></div>
	</div>
</div>
<div id="piyueListDiv">
<c:if test="${replyList== null || fn:length(replyList) == 0}">暂无上级批阅</c:if>
<c:forEach items="${replyList}" var="data" varStatus="i">
<div class="ItemBlock_Title" onclick="showDiv('piyueList${i.index+1 }')">
	<img src="<%=path %>/images/desk/item_point.gif" border="0">
	批阅人：${data.employeeByInceptemp.name}&nbsp;&nbsp;时间:${data.auditingtime}
	&nbsp;&nbsp;评分:${data.grade}
</div>
<div class="ItemBlockBorder" id="piyueList${i.index+1 }">
<div class="ItemBlock" >
	${data.tmp}
</div>
</div>
</c:forEach>
<div id="InputDetailBar">
	<table align="center" border="0" cellpadding="10" cellspacing="0">
		<tbody>
			<tr>
			<td>										
			<div class="FuncBtn"><div class="FuncBtnHead"></div>
	        <div class="FuncBtnMemo">
	        	</div>
		        <div class="FuncBtnTail">
		        
		        </div>
	        </div>
  			</td>								
			<td>
			<div class="FuncBtn">
				<div class="FuncBtnHead"></div>
		        <div class="FuncBtnMemo">
		        	<c:choose  ><c:when test="${worklog.isView == 1 && isMy == 0}">
		        	<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" onclick="ensureclick('${worklog.id }')" type="button"  value="确认查看" name="sureBtn" id="surenBtn">
		        	</c:when>
		        	<c:otherwise>
		        	<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" onclick="javascript:history.go(-1);" type="button"  value="返回" name="returnBtn" id="returnBtn">
		        	</c:otherwise>
		        	</c:choose>
		        </div>
		        <div class="FuncBtnTail"></div>
	        </div>
  			</td>
		</tr>
		</tbody>
	</table>
</div>
</form>
</body>
</HTML>
