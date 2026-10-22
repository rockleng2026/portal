<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=gb2312" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>认证码输入页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<form method=post action="check.jsp">
<table>
<tr>
<td align=left>系统产生的认证码：</td>
<td><img border=0 id="code" src=""><a href="javascript:changeimg()">看不清，换一张</a> </td>
<td><% 
String rand = (String)session.getAttribute("rand");
%> <%= rand %></td>
<script type="text/javascript">

function changeimg()
{
var myimg = document.getElementById("code"); 
now = new Date().getTime();
var url = "image.jsp?tt="+now;
myimg.src=url;
}
changeimg();
</script>
</tr>
<tr>
<td align=left>输入上面的认证码：</td>
<td><input type=text name="randnum" maxlength=4 value=""></td>
</tr>
<tr>
<td colspan=2 align=center><input type=submit value="提交检测"></td>
</tr>
</form>
</body>
</html>
