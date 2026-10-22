<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
	<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>  
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>新增提醒功能</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script src="<%=request.getContextPath() %>/js/util/util.vbs" type="text/vbscript"></script>
		<SCRIPT LANGUAGE="JavaScript" src="<%=request.getContextPath() %>/js/util/charutil.js"></SCRIPT>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript">
 


function query(){
    var str = document.getElementById("typeName").value.trim();
    if(str == "") return;
    var arrRslt = makePy(str);
    $("#mark").val(arrRslt);

}

//-->
</script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addMessageremind.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;新增提醒功能(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
											<TR>
										<TD width="25%" height=30 align=right>功能名称：</TD>
										<TD width="75%" class=category><input type="hidden" id="is" name="is" value="0">
												<input type="hidden"  id="id" name = "id" value="${messageremind.id }"/>
											   	<input onblur="checkValueByRules('typeName','','typeNameMsg')" name="typeName" id="typeName" type="text" value="${messageremind.typeName}" onkeyup="javascript:document.getElementById('mark').value=this.value.getFirstChars();"/>
											<FONT color=#ff0000 id="typeNameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											标识：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('mark','checkMarkMessageremind.do','markMsg')" style="WIDTH: 200px" id="mark" name="mark" value="${messageremind.mark }"/>
											<FONT color=#ff0000 id="markMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									
									
									<TR>
										
										<TD align=right height=30>
											设置提醒方式：
										</TD>
										<TD class=category>
										 <INPUT id="isPhoneRemind" type="checkbox" name="isPhoneRemind" style="border: 0px" value="sj" <c:if test="${messageremind.isPhoneRemind == 'sj' }">checked = "checked"</c:if>/>手机提醒
										&nbsp;&nbsp;&nbsp; <INPUT id="isEmailRemind" type="checkbox" name="isEmailRemind" style="border: 0px" value="yj" <c:if test="${messageremind.isEmailRemind == 'yj' }">checked = 'checked'</c:if>/>邮件提醒
											&nbsp;&nbsp;&nbsp; <INPUT id="temp" type="checkbox" name="temp" style="border: 0px" value="dxx" <c:if test="${messageremind.temp == 'dxx' }">checked = 'checked'</c:if>/>内部短消息提醒
											&nbsp;
											
										</TD>
									</TR>
									
								
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<c:if test="${cout == null}"><INPUT  class=button type=submit value=" 确认添加 "></c:if>
											<c:if test="${cout != null}"><INPUT  class=button type=submit value=" 确认修改 "><INPUT name = "id" type="hidden" value = "${cout.id }"></c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
