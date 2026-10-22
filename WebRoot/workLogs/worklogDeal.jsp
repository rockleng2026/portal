<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title>工作日志详情</title>
		<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
		<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body class="PopupWinBody1">
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					日志详情
				</div>
			</div>
			<div class="Case_Content" style="margin-left: 0px;">
			日志创建人： ${data.employeeByEmpId.name }  &nbsp;部门:  ${data.employeeByEmpId.department.name } &nbsp;时间： ${data.recordTime }  &nbsp;日志具体内容如下：
				<center>
				<div style="height: 612px; overflow: auto">
				<table width="100%"><tbody><tr><td>
					<FCK:editor instanceName="content" inputName="content" height="600px">
						<jsp:attribute name="value">${data.content}</jsp:attribute>
					</FCK:editor>
				</td></tr></tbody></table>
				</div>
				</center>
				<div style=" overflow: auto">
					<div>
						<INPUT id="btnreturn" onclick="history.go(-1)" type="hidden"
							value="返回" name="btnClose" class="PopupButton3"
							style="float: left; margin-left: 165px;">
					</div>
				</div>
			</div>
		</div>
	</body>
</HTML>
