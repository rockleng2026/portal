<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Messagereceiver"%>
<%@page import="com.fuao.fajxc.bussiness.message.MessageBussiness"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
MessageBussiness messageBussiness=(MessageBussiness)request.getAttribute("messageBussiness");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>详细信息</title>
<style>
body{ font-size:12px}
.bc{ font-size:16px}
.wz_hs { color:#ff0000;}

.main { width:760px; margin:0 auto;background-color: #fff;}
.yx_bt { line-height:30px; color:#fff; font-size:14px; font-weight:bold; background-color:#295a00;}
.yx_bt span { color:#81f106;}
.yx_bt a { text-decoration:none; color:#fff;}
.nei{width:645px; margin:auto}
.top{width:750px; margin:auto; padding-left:20px;}
.cha{ color:#FFF}
.p{
	margin-top:10px;
	border:2px solid #ffeabd
}
.b{ line-height:10px}
.bb{ margin-top:5px; margin-bottom:5px;}
.c{ margin-bottom:10px;}
.gb_bt{ background-color:#4FA805;
font-size:12px; font-weight:bold; color:#fff; width:75px; line-height:20px; text-align:center;}
.ccc{ border-bottom:1px dashed #999}
a{ color:#e1731c; text-decoration:none}
</style>
<link rel="stylesheet" type="text/css" href="<%=path %>/potal/css/commonCss.css"/>
</head>

<body>
<div class="main">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="yx_bt">
  <tr>
    <td width="15%" align="center"><a href="<%=path %>/writelogmessage.do">写消息</a></td>
    <td width="17%" align="center"><a href="<%=path %>/noreadMessagemessage.do">收件箱（${messagecount}）</a></td>
    <td width="17%" align="center"><a href="<%=path %>/sendEmailmessage.do">已发送</a></td>
    <td width="17%" align="center"><a href="<%=path %>/delEmailmessage.do">已删除</a></td>
    <td width="17%" align="center"><a href="<%=path %>/caogaoEmailmessage.do">草稿箱</a></td>
    <td width="17%" align="right"><a href="javascript:out()">×</a>&nbsp;&nbsp;</td>
  </tr>
</table>
</div>
<div class="main">
<%
   Messagereceiver receiver=(Messagereceiver)request.getAttribute("receiver");
   // 发件人
   Employee fjr=(Employee) messageBussiness.getEmp(Employee.class,Integer.parseInt(receiver.getMessage().getSender()));
   // 收件人
   Employee sjr=(Employee)messageBussiness.getEmp(Employee.class,Integer.parseInt(receiver.getReceiverer()));
%>
<table  class="top" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="2"><strong><span class="bc"><%=receiver.getMessage().getTitleweb() %></span></strong></td>
  </tr>
  <tr>
    <td width="370" height="22" class="ccc">发件人：<%=fjr.getName() %>&nbsp;</td>
    <td class="ccc" width="435">收件人：<%=sjr.getName() %></td>
  </tr>
  
  <tr>
    <td height="26" colspan="2" class="ccc">发件时间：<%=receiver.getReceivetime() %></td>
  </tr>
</table>
</div>
<div class="main">
<table  class="nei p" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td>
	  <table class="ccc c bb top" width="100%">
	  <tr>
	    <td style="word-break:break-all;word-wrap:break-word"><%=receiver.getMessage().getMessagecontent() %></td>
	  </tr>
	  </table>
  </td>
  </tr>
  <tr>
    <td><table  class="top" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table  class="c" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25"><div class="gb_bt">附件(1)</div></td>
  </tr>
  <tr>
    <td height="22">&nbsp;&nbsp;<strong>&nbsp;普通附件</strong></td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="c">
		  <tr>
		    <td width="5%" align="right"><img src="<%=path %>/potal/images/ygxx_word.png" width="33" height="34" /></td>
		    <td width="63%" align="left">
		                    公司情况统计234(mb)<br/>
		       <a href="#">下载</a>&nbsp;&nbsp;&nbsp;<a href="#">预览</a>
		    </td>
		 </tr>
		</table>
	</td>
  </tr>
</table>
</td>
  </tr>
</table>
</div>
</body>
</html>
