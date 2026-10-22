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
<title> 流程跟踪列表 </title>
<style type="text/css">
html,body,div,span,p,a,img,ul,li,dl,dt,dd,ol,form,label,form{ margin:0; padding:0; border:0; outline:0; font-size:100%;}
body{ font-size:12px; background-color:#FFFFFF; color:#000000; font-family:Tahoma,Verdana; line-height:150%;}
.tab{ background-color:#CCCCCC; margin-top:10px;}
.tab td{ background-color:#FFFFFF;}
.td28 td{ background-color:#EFEFEF; height:24px; padding-left:10px; color:#996600; font-size:13px; font-weight:bold;}
</style>
</head>
<body>

<table width="98%" border="0" cellspacing="1" cellpadding="6" align="center" class="tab">
<tr class="td28">
    <td colspan="6" style="text-align:center; font-size:16px; font-weight:bold;">订单流程跟踪</td>
</tr>
<tr style="text-align:center; color:#63C; font-weight:bold;">
    <td >订单信息</td>
    <td >客户姓名</td>
    <td >订单状态</td>
    <td >上架单信息</td>
    <td >服务器状态</td>
    <td >故障信息</td>
</tr>
<tr style="text-align:center;">
    <td ><a href="#" onclick="javascript:window.location.href='order-list.jsp'">SSDD123456</a></td>
    <td >周涛</td>
    <td >快到期</td>
    <td >快下架</td>
    <td >正常</td>
    <td >暂无</td>
</tr>
<tr style="text-align:center;">
    <td ><a href="#" onclick="javascript:window.location.href='order-list.jsp'">SSDD654321</a></td>
    <td >张帆</td>
    <td >到期</td>
    <td >已下架</td>
    <td >停止服务</td>
    <td >暂无</td>
</tr>
</table>
</body>
</html>