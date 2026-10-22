<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title></title>
		<STYLE>TD {
	FONT-SIZE: 12px; COLOR: #ffffff; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif
}
</STYLE>

<SCRIPT language=JavaScript>
//<!--
function tick() {
var hours, minutes, seconds;
var intHours, intMinutes, intSeconds;
var today;
today = new Date();
intHours = today.getHours();
intMinutes = today.getMinutes();
intSeconds = today.getSeconds();

if (intHours == 0) {
hours = "00:";
} else if (intHours < 10) { 
hours = "0" + intHours+":";
} else {
hours = intHours + ":";
}

if (intMinutes < 10) {
minutes = "0"+intMinutes+":";
} else {
minutes = intMinutes+":";
}
if (intSeconds < 10) {
seconds = "0"+intSeconds+" ";
} else {
seconds = intSeconds+" ";
} 
timeString = hours+minutes+seconds;
Clock.innerHTML = timeString;
window.setTimeout("tick();", 1000);
}

window.onload = tick;
//-->

</SCRIPT>

<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</head>
	<BODY leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
	 
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#73a3d4 height=4></TD></TR></TBODY></TABLE>
<TABLE height=28 cellSpacing=0 cellPadding=0 width="100%" bgColor=#3a6592 
border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE height="100%" cellSpacing=2 cellPadding=0 width="100%" border=0>
        <TBODY>
        <TR>
          <TD noWrap align=right width=109><SPAN id=Clock></SPAN></TD>
          <TD align=right width=60>&nbsp;</TD>
          <TD noWrap align="center" 
          width=650>当前用户:${sessionScope.loginName }&nbsp;&nbsp;&nbsp;&nbsp;
          	姓名：${emp.name }&nbsp;&nbsp;&nbsp;&nbsp;
          	部门：${emp.department.name }&nbsp;&nbsp;&nbsp;&nbsp;
          	岗位：${empposition.workposition.name }&nbsp;&nbsp;&nbsp;&nbsp;
          	岗位类型：<c:if test="${empposition.positiontype==1}">主岗</c:if><c:if test="${empposition.positiontype==2}">分岗</c:if><c:if test="${empposition.positiontype==3}">分管</c:if>&nbsp;&nbsp;&nbsp;&nbsp;
          	工号：${emp.empNo }
          	</TD>
          <TD 
          style="FONT-WEIGHT: bolder; FILTER: shadow(Color=#000000,direction=180)" 
          noWrap align=right width=434>程序开发：福奥科技
      </TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
     
</BODY></HTML>