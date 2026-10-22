<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title>查看工作日志/批注</title>
		<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
	<script type="text/javascript">
		function saveData(){	
				var reply = document.getElementById("reply");
				if(reply.value == ""){
				
					alert("批注不能为空");
					return;
				}
				var result = confirm("确定添加批注？");
				if(result == false){
					return;
				}				
				Form1.submit();
			}					
	</script>
	</HEAD>
	<body class="PopupWinBody1">
		
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					日志详情
				</div>
			</div>
			<div class="Case_Content" style="margin-left: 10px;">
			日志创建人： ${data.employeeByEmpId.name }  &nbsp;部门:  ${data.employeeByEmpId.department.name } &nbsp;时间： ${data.recordTime }  &nbsp;日志具体内容如下：
				<div style="height: 412px; overflow: auto">
					<br />
					${data.content }
				</div>
				<form name="Form1" method="post" action="addReplyWorkLog.do">
				<div style="height: 212px; overflow: auto">
				
					<center>
					<br />
					<input type="hidden" name="id" value="${data.id }">
					批注：
					<br/>
					<textarea rows="10" cols="80" id="reply" name="reply"></textarea>
					</center>
				
				</div>
				<div style=" overflow: auto">
					<div>
						<INPUT id="button" onclick="javascript:saveData()" type="button"
							value="保存" name="save" class="PopupButton3"
							style="float: left; margin-left: 185px;">
						<INPUT id="btnreturn" onclick="history.go(-1)" type="button"
							value="返回" name="btnClose" class="PopupButton3"
							style="float: none; margin-left: 185px;">
					</div>
				</div>
				</form>
			</div>
		</div>
	</body>
</HTML>
