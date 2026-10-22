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
<title> 订单流程跟踪 </title>
<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="dt01"><h1>订单列表</h1></div>
<div class="dt03"><img src="image/1_03.gif" /></div>
<div class="dt08"><img src="image/c2_01.gif" border="0" usemap="#Map" />
  <map name="Map" id="Map">
    <area shape="rect" coords="24,16,97,93" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?funid=262'"/>
     <div class="dt04">+1</div>
    <area shape="rect" coords="192,21,249,93" href="#" onclick="javascript:window.location.href='getmyreceivemission.do?status='+1"/>
    <div class="dt05">+5</div>
    <area shape="rect" coords="328,18,401,97" href="#" onclick="javascript:window.location.href='goAddWorkLog.do?funid=293'"/>
    <area shape="rect" coords="449,12,522,93" href="#" onclick="javascript:window.location.href='goAddworknotepad.do?funid=269'"/>
    <area shape="rect" coords="574,8,642,99" href="#" onclick="javascript:window.location.href='selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248'"/>
    <div class="dt06">+2</div>
    <area shape="rect" coords="692,20,747,101" href="#" onclick="javascript:window.location.href='messtypeCustomer.do?funid=250'"/>
  </map>
</div>
<div class="dt09">
	<ul>
      <li>订单号：dfdg23132</li>
      <li>客服姓名：张三</li>
      <li>下单时间：2011-02-30</li>
      <li>到期时间：2012-09-05</li>
      <li>上次续费：2012-06-09</li>
      <li>付费类型：月付</li>
    </ul>
    <div style="clear:both;" ></div>
</div>
<div class="dt10">
	<ul>
   		<li><img src="image/a5_13.jpg" /><div class="dt11">正常</div></li>
        <li><img src="image/a5_07.jpg" /><div class="dt11" style="left:120px;">快到期</div></li>
        <li><img src="image/a5_16.jpg" /><div class="dt11" style="left:120px;">正常</div></li>   
     	<li><img src="image/a5_10.gif" /><div class="dt11" style="left:115px;">暂无</div></li>   
	</ul>
    <div style="clear:both;" ></div>
</div>
</body>
</html>
