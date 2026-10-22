<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<meta name="Generator" content="dianzhuiy" />
	<meta name="Author" content="dianzhuiy" />
	<meta name="Keywords" content="dianzhuiy" />
	<meta name="Description" content="dianzhuiy" />
	<title> 运维流程 </title>
</head>

<body>
<div class="dt01"><h1>运维</h1></div>
<div class="dt02">
<img src="image/4_02.gif" border="0" usemap="#Map" />
<map name="Map" id="Map">
  <area shape="rect" coords="24,18,95,94" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?funid=262'" />
  <area shape="rect" coords="192,21,248,96" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?status='+1"/>
  <area shape="rect" coords="328,17,400,96" href="#" onclick="javascript:window.location.href='goAddWorkLog.do?funid=293'"/>
  <area shape="rect" coords="449,12,523,97" href="#" onclick="javascript:window.location.href='goAddworknotepad.do?funid=269'"/>
  <area shape="rect" coords="573,8,639,97" href="#" onclick="javascript:window.location.href='selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248'"/>
  <area shape="rect" coords="691,17,750,96" href="#" onclick="javascript:window.location.href='messtypeCustomer.do?funid=250'"/>
  <area shape="rect" coords="45,140,115,221" href="#" onclick="javascript:window.location.href='selectMalfunctionDeclare.do?tag=0&funid=87'"/>
  <area shape="rect" coords="129,268,188,345" href="#" onclick="javascript:window.location.href='getpageCustomer.do?type2=1&funid=22'"/>
  <area shape="rect" coords="288,267,377,351" href="#" onclick="javascript:window.location.href='selectsaleOrder.do?funid=179'"/>
  <area shape="rect" coords="548,273,619,354" href="#" onclick="javascript:window.location.href='selectServerState.do?funid=206'"/>
  <area shape="rect" coords="142,404,213,493" href="#" onclick="javascript:window.location.href='selectDownserver.do?funid=199'"/>
  <area shape="rect" coords="272,405,340,492" href="#" onclick="javascript:window.location.href='getAllListClientOrder.do?funid=183'"/>
  <area shape="rect" coords="394,406,461,492" href="#" onclick="javascript:window.location.href='selectUpserver.do?funid=193'"/>
  <area shape="rect" coords="346,538,418,630" href="#" onclick="javascript:window.location.href='selectMalfunctionDeclare.do?tag=1&funid=88'"/>
  <area shape="rect" coords="457,538,526,629" href="#" onclick="javascript:window.location.href='selectrlsaleOrder.do?funid=241'"/>
  <area shape="rect" coords="146,552,206,634" href="#" onclick="javascript:window.location.href='warehousingInfoWarehousing.do?funid=65'"/>
  <area shape="rect" coords="483,417,545,487" href="#" onclick="javascript:window.location.href='outBoundInfoOutbound.do?funid=69'"/>
</map>
</div>
</body>
</html>
