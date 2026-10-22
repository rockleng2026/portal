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
		<script type="text/javascript" src="<%=path %>/js/util/ckbrowserutil.js"></script>
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
		    var content = $("#logcontentDiv").html();
		    $("#content").val(content);
			form1.submit();
			return result;
		}else{
			return result;
		}
	}
	
function piyue2()
{
  var content = "";
  if(Sys.ie == '9.0'){
  	content = $("#piyue1").val();
  }else{
	  var ifm = window.frames[0].EDiaryEditor.iframe; 
	  content = (ifm.contentWindow || ifm).document.body.innerHTML; //兼容所有浏览器
  }
  content = $.trim(content);
  if(content == 'undefind' ||content == ''){
  	alert("批注不能为空!");
  	return false;
  }
  var val=$('input:radio[name="mark"]:checked').val(); 
  content = encodeURI(encodeURI(content));
  var id = $("#id").val();
  var audid = $("#audid").val();
  var url = "addNewReplyWorkLog.do?tt="+(new Date().getTime());
    $.post(url,{id:id,reply:content,audid:audid,mark:val},function(data)
    {
         if(data == 0){
         	window.location.href="selectOtherWorkLog.do";
         }else{
        	alert("提交错误！请刷新后再试");
        	return false;
        }
    });
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
此功能暂无
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


         <c:if test="${isResult}">  
				<div id="Title_bar" onclick="showDiv('piyueDiv')" >
				<div id="Title_bar_Head">
					<div id="Title_Head">
					</div>
					<div id="Title">
						<img src="<%=path %>/images/desk/title_arrow.gif" border="0" height="13" width="13" id="piyueListDivImg">
						批阅
					</div>
					<div id="Title_End">
					</div>
					<div id="Title_bar_bg"></div>
				</div>
			</div>
			<div id="piyueDiv">
				<div class="ItemBlockBorder">
					<div class="ItemBlock">
						<div style="height:30px;width:100%;background:white; vertical-align: center;margin-bottom:10px;">
							评分：&nbsp; &nbsp;<input type="radio"  name="mark" value="1"/>  1 &nbsp; &nbsp;
								<input type="radio"  name="mark" id="mark" value="2"/>  2 &nbsp; &nbsp;
								<input type="radio"  name="mark" id="mark" value="3"/>  3 &nbsp; &nbsp;
								<input type="radio"  name="mark" id="mark" value="4"/>  4 &nbsp; &nbsp;
								<input type="radio"  name="mark" id="mark"  value="5" checked="checked"/>  5 &nbsp; &nbsp;
        				 </div>
						<table border="0" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td width="622" height="457" colspan="3">
									<textarea  name="piyue" id="piyue1" style="display:none" ></textarea>
			<script type="text/javascript">
			//alert(Sys.ie);
			if(Sys.ie == "9.0"){
			$("#piyue1").show();
			}else{document.write("<iframe src='<%=path%>/SinaEditor/Edit/editor.htm?id=piyue1&ReadCookie=0' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='No' width='621' height='457'></iframe>");}
			</script>
									</td>
									<td>
										<FONT color=#ff0000>*</FONT>
										<FONT color=#ff0000 id="piyue1Msg"></FONT>
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
			</c:if>

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
		        	<c:if test="${isResult}"> 
		        		<input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" onclick="piyue2()" type="button"  value="批阅" name="doBtn" id="doBtn"/>
		        	</c:if>
		        	
		        <input style="background-image: url('<%=path %>/images/desk/awokeBtn_bg.gif'); border-style: none;" onclick="javascript:history.go(-1);" type="button"  value="返回" name="returnBtn" id="returnBtn">
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
