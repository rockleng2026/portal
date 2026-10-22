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

  <script type="text/javascript">

function changeimg()

{

alert("aaa");
var myimg = document.getElementById("code"); 
alert(myimg.src);
now = new Date().getTime();
var url = "image.jsp?tt="+now;
alert(url); 
myimg.src=url;
} 
</script>
</head>
<body>
<% String randnum = request.getParameter("randnum"); %>
<form method=post action="check.jsp">
<table>
<tr>
<td align=left>SESSION中的的认证码：<% 
String rand = (String)session.getAttribute("rand");
%> <%= rand %></td>
<td align=left>请求获取到的认证码：<% 
%> <%= randnum %></td>
</tr>
<tr>
<td colspan=2 align=center><input type=submit value="提交检测"></td>
</tr>
</form>
</body>
</html>
