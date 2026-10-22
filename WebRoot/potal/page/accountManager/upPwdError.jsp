<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
<style> 
body{ font-size:12px;}
.tab_lma{ margin-left:210px; margin-top:230px;}
.font_color_hui{color:#696969;}
a{text-decoration: none; color:#696969}
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
<table width="760px" border="0" cellspacing="0" cellpadding="0" align="center" background="<%=path%>/potal/page/accountManager/images/xgsb02bg.jpg">
  <tr>
    <td height="500">
    <table width="50%" border="0" cellspacing="10" cellpadding="0" class="tab_lma font_color_hui">
      <tr>
        <td width="24%" align="right">原因可能是：</td>
        <td width="76%">★ 服务器暂时不可用，请刷新重试！</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>★ 代码出错！</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>★ 网速不给力！</td>
      </tr>
      <tr>
        <td height="50" colspan="2" align="center" valign="bottom"><img src="<%=path%>/portal/images/onePage.png" onclick="up()"/>&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=path%>/portal/images/exit.jpg" onclick="tuichu()"/> </td>
        </tr>
    </table></td>
  </tr>
</table>
</body>
</HTML>

