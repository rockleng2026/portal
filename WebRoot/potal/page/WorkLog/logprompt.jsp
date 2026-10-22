<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>、
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> 日志提示  </title>
<style> 
body{ font-size:12px;}
.tab_lma{ margin-left:210px; margin-top:230px;}
.font_color_hui{color:#696969;}
a{text-decoration: none; color:#696969}
img{ cursor:pointer;}
a:hover{ color:#fd6600}
</style>
<script type="text/javascript">
function up()
{
	window.location.href = "<%=path%>/potal/page/desk.jsp";
}

function tuichu()
{
	parent.location.href = "safetyExitSystem.do";
}
</script>
</head>
 
<body>
<table width="760px" border="0" cellspacing="0" cellpadding="0" align="center"  background="<%=path%>/potal/images/logPrompt.jpg">
  <tr>
    <td height="500">
    <table width="50%" border="0" cellspacing="10" cellpadding="0" class="tab_lma font_color_hui">
      <tr>
        <td width="24%" align="right"></td>
        <td width="76%"></td>
      </tr>
      <tr>
        <td height="50" colspan="2" align="center" valign="bottom"><img src="<%=path%>/potal/images/onePage.png" onclick="up()"/>&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=path%>/potal/images/exit.jpg" onclick="tuichu()"/> </td>
       
      </tr>
    </table></td>
  </tr>
</table>
</body>
</HTML>