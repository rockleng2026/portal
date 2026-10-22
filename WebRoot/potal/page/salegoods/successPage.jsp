<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>新增成功！</title>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
	<style type="text/css"> 
body{width:760px; margin:0 auto; font-size:12px}
.main { width:760px; margin:0 auto;}
.wls_cwbg { background:url(<%=path%>/potal/page/accountManager/images/addSuccess.jpg) no-repeat; width:760px; height:504px;}
.wzcs { color:#ff6600;}
.wzcs a { color:#ff6600; text-decoration:none}
.wzls { color:#2d6100;}
.wzls a { color:#2d6100; text-decoration:none}
.xgcg_wz { line-height:25px; width:420px; border-bottom:2px solid #363636; text-align:center;}
</style>
</head>
  
 
<body>
<div class="main">
<div class="wls_cwbg">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="59%" height="326">&nbsp;</td>
    <td width="41%">&nbsp;</td>
  </tr>
  <tr>
    <td height="242" align="right">
	    <div class="xgcg_wz" ><span class="wzls"><a href="javascript:void(0);" style="font-size: 12px;">您还可以：</a>
		    </span><img src="<%=path%>/potal/page/accountManager/images/lsx_jt.jpg" /><span class="wzls"><a style="font-size: 12px;" href="<%=path%>/potal/page/desk.jsp">返回首页</a>
		    </span><img src="<%=path%>/potal/page/accountManager/images/lsx_jt.jpg" alt="jiantou" /><span class="wzcs">
		    <a href="javascript:parent.location.href='safetyExitSystem.do'" style="font-size: 12px;">退出系统</a></span>
    	</div>
    </td>
    <td align="left" valign="top"><p>&nbsp;</p>
      </td>
  </tr>
</table>
</div>
</div>
</body>
</html>
