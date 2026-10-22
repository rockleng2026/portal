<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>任务-分发</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
  </head>
 <script type="text/javascript">
 	function handoutsubmit(){
 		//alert("xxxx");
 		var typeid = $("#typeid").val();
 		var name = $("#name").val();
 		var description = $("#description").val();
 		var expEndTime = $("#expEndTime").val();
 		var expStartTime = $("#expStartTime").val();
 		//alert(typeid);
 		if(typeid == ''){
 			alert("请选择任务类别!");
 			$("#typeid").focus();
 			return false;
 		}
 		if(name == ''){
 			alert("请填写任务名称!");
 			$("#name").focus();
 			return false;
 		}
 		if(description == ''){
 			alert("请填写任务描述!");
 			$("#description").focus();
 			return false;
 		}
 		if(expStartTime == ''){
 			alert("请填写预计任务开始时间!");
 			$("#expStartTime").focus();
 			return false;
 		}
 		if(expEndTime == ''){
 			alert("请填写预计任务结束时间!");
 			$("#expEndTime").focus();
 			return false;
 		}
 		
 		//var mes=$("#mesty");
 		//mes.empty();
 		//$.post('selbysuperidmessage.do',{surperid:surperid},
 		//function (data){
 		//	if(data!=1)
 		//		mes.append(data);
 		//});
 		
 		$("#handoutform").submit();
 	}
 </script>
  <body>
  <div style="margin-left: 60px">
<FORM id="handoutform" name="handoutform" action="<%=request.getContextPath()%>/savehandoutmission.do"  method="post">
	<div style="float:left; width:500px;">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD style="font-size: 12px;color: red;">
											&nbsp;任务发布中(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD ></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align="center" border=1  style="font-size: 14px;">
								<TBODY>										
									<input type="hidden" name="id" id="id" value="${data.taskId }"/>
									<TR>
										<TD width="5%" height=30 align=right>
											任务名称：
										</TD>
										<TD width="10%" class=category>
											${data.name }
										</TD>
									</TR>
									<TR>
									<TD width="20%" class=category colspan="2" align="center">
											从右边选择接收人
										</TD>
									</TR>
									<TR>
									<TR>
									<TD width="20%" class=category colspan="2">
											<textarea rows="20" cols="65" name="receiver" id="receiver" readonly="readonly" ></textarea>
											&nbsp;
											<FONT color=#ff0000 >*</FONT>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<input type="hidden" id="users" name="users">
											<INPUT class=button type="button" value="确认提交 " onclick="setusers()">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</div>
		</FORM>
	<div id="sub-dept" style="float:left; width:230px;margin: 0px;padding: 0px;border: 0px;">
	</div>
</div>
<script type="text/javascript">
	$("#sub-dept").load("alldeptmessageDepartment.do");
	function setusers(){
	alert(""+emps);
	$('#users').attr("value",emps);
	var receive = $("#receiver").val();
	if(receive  == null || receive == ''){
		alert("请填写员工");
		return false;
	}
	$("#handoutform").submit();
}
</script>	
</body>
</html>