<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/refurbish.js" ></script>
		<META http-equiv=Refresh content=300>
		<STYLE type=text/css>A:link {
	FONT-SIZE: 12px; COLOR: #666666; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A:active {
	FONT-SIZE: 12px; COLOR: #666666; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A:visited {
	FONT-SIZE: 12px; COLOR: #666666; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A:hover {
	FONT-SIZE: 12px; COLOR: #f29422; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A.blue:link {
	FONT-SIZE: 12px; COLOR: #ffffff; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A.blue:active {
	FONT-SIZE: 12px; COLOR: #73a2d6; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A.blue:visited {
	FONT-SIZE: 12px; COLOR: #ffffff; LINE-HEIGHT: 20px; TEXT-DECORATION: none
}
A.blue:hover {
	FONT-SIZE: 12px; COLOR: #73a2d6; LINE-HEIGHT: 20px; TEXT-DECORATION: underline
}
.style1 {font-size: 16px}
</STYLE>
<script type="text/javascript">
	// 选择分岗
	function fgwop(){
		var fgwopid=$("#fgwop").val();
		parent.location.href="<%=request.getContextPath()%>/User2Login.do?fgwopid="+fgwopid;
	}
</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR></HEAD>
	<BODY leftMargin=0 topMargin=0  marginwidth="0" marginheight="0" onload="refurbishtable()">
<TABLE style="FONT-SIZE: 12px; COLOR: #ffffff" cellSpacing=0 cellPadding=0 
width="100%" bgColor=#3a6592 border=0 >
  <TBODY>
  <TR>
    <TD width=214 height=28><A href="#" target=_blank><IMG 
      src="../images/Title.gif" border=0></A></TD>
    
    <TD width=21></TD>
    <TD noWrap align=right width=*>    
		<!-- 选择分岗 -->
		<select name="fgwop" id="fgwop" onchange="fgwop()">
		　　<option value="-1">--请选择岗位--</option>
		    <c:forEach items="${fglist}" var="workposition">
		    	<option value="${workposition.id}">${workposition.name}</option>
		    </c:forEach>
		</select>
    [<A class=blue 
      onclick="showModalDialog('about/about.htm',window,'dialogHeight:250px;dialogWidth:360px;dialogleft:200px;help:no;status:no;scroll:no');" 
      href="#">关于系统</A>] [<A 
      class=blue onclick="return confirm('确定要退出吗？');" 
      href="javascript:parent.location.href='safetyExitSystem.do'" target="_top">安全退出</A>] &nbsp;&nbsp; 
    </TD>
   </TR>
   </TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="100%" 
background=../images/topnav_bg.jpg  border=0>
  <TBODY>
  <TR id="sendmes">
    <TD vAlign=bottom width=95><A 
      href="editPassSystem.do" 
      target=right><IMG src="../images/button7.jpg" border=0></A> </TD>
    <TD vAlign=bottom  ><A 
      href="desk.jsp" target=right><IMG 
      src="../images/button8.jpg" border=0></A>
</TD>
</TR>

</TBODY>
</TABLE></BODY>
</HTML>