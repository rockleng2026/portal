<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title>查看工作日志</title>
		<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="../Js/Common.js"></script>
		<script type="text/javascript">
		function ensureclick(){
				var loc = "seeReplyWorkLog.do?id="+${data.id };
				window.location = loc;
			}					
		</script>
	</HEAD>
	<body class="PopupWinBody1">
	<form action="" name="Form1" method="post">
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					日志/批注详情
				</div>
			</div>
			<div class="Case_Content" style="margin-left: 10px;">
				日志创建人： ${data.employeeByEmpId.name }  &nbsp;部门:  ${data.employeeByEmpId.department.name } &nbsp;时间： ${data.recordTime }  &nbsp;日志具体内容如下：
				<div style="height: 412px; overflow: auto">
					<br />
					${data.content}
					
				</div>
			<div style="height: 212px; overflow: auto">
				
					<center>
					<br />
					<input type="hidden" id="id" name="id" value="${data.id }"/>
					<blockquote><h1><font size="7" face="仿宋_GB2312"><strong><font color="red">上级批注： 
					</font></strong></font></h1></blockquote><h1><font size="7" face="仿宋_GB2312"><strong></strong></font></h1>
					时间：${data.replyTime }&nbsp;姓名：${data.employeeByReplier.name }
					<br />
					<textarea rows="10" cols="90" name="reply" readonly="readonly">${data.replyContent }</textarea>
					</center>
				
				</div>
				<div style=" overflow: auto">
				<div>
					<c:if test="${(isMy == 0) && (data.isView == 1)}" >
						<INPUT id="btnsure" type="button" onclick="javascript:ensureclick();"
							value="确认查看" name="btnsure" class="PopupButton3"
							style="float: left; margin-left: 130px;">
					</c:if>
						<INPUT id="btnreturn" onclick="history.go(-1)" type="button"
							value="返回" name="btnClose" class="PopupButton3"
							style="float: left; margin-left:155px;">
					</div>
				</div>
				
			</div>
		</div>
		</form>
	</body>
</HTML>
