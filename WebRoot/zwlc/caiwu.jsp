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
<title> 职位流程 </title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="dt01"><h1>财务</h1></div>
<div class="dt03"><img src="image/1_03.gif" /></div>
<div class="dt02">
<img src="image/2_02.gif" border="0" usemap="#Map" />
<map name="Map" id="Map"> 
  <area shape="rect" coords="24,18,95,94" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?funid=262'" />
  <area shape="rect" coords="192,21,248,96" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?status='+1"/>
  <area shape="rect" coords="328,17,400,96" href="#" onclick="javascript:window.location.href='goAddWorkLog.do?funid=293'"/>
  <area shape="rect" coords="449,12,523,97" href="#" onclick="javascript:window.location.href='goAddworknotepad.do?funid=269'"/>
  <area shape="rect" coords="573,8,639,97" href="#" onclick="javascript:window.location.href='selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248'"/>
  <area shape="rect" coords="691,17,750,96" href="#" onclick="javascript:window.location.href='messtypemessage.do?funid=245'"/>
  <area shape="rect" coords="46,140,106,228" href="#" onclick="javascript:window.location.href='addPagecharge.do?funid=39'"/>
  <area shape="rect" coords="140,141,196,231" href="#" onclick="javascript:window.location.href='addShowpay.do?funid=41'"/>
  <area shape="rect" coords="238,173,359,275" href="#" onclick="javascript:window.location.href='selectcharge.do?funid=40'"/>
  <area shape="rect" coords="200,310,311,408" href="#" onclick="javascript:window.location.href='selectsaleOrder.do?funid=179'"/>
  <area shape="rect" coords="325,309,398,406" href="#" onclick="javascript:window.location.href='selectcharge.do?funid=40'"/>
  <area shape="rect" coords="495,308,570,403" href="#" onclick="javascript:window.location.href='selectpay.do?funid=42'"/>
  <area shape="rect" coords="575,306,693,411" href="#" onclick="javascript:window.location.href='getPurchaseOrder.do?funid=54'"/>
  <area shape="rect" coords="504,172,639,288" href="#" onclick="javascript:window.location.href='getPurchaseOrder.do?funid=54'"/>
  <area shape="rect" coords="218,462,296,564" href="#" onclick="javascript:window.location.href='selectpay.do?funid=42'"/>
  <area shape="rect" coords="616,459,732,559" href="#" onclick="javascript:window.location.href='selectcharge.do?funid=40'"/>
  <area shape="rect" coords="364,588,435,677" href="#" onclick="javascript:window.location.href='selectrlsaleOrder.do?funid=241'"/>
</map>
</div>
</body>
</html>
