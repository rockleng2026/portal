<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
body{width:624px; font-size:12px}
img{border:0}
.tc_box{width:622px; height:285px; border:1px solid #a8a8a8; float:left}
.tc_top{width:612px; height:23px; line-height:23px; padding-left:10px; background:#295a00; color:#FFFFFF; font-size:12px; margin-bottom:6px;}
.tc_top span{float:right; padding-right:15px; padding-top:7px;}
.tc_top a{text-decoration:none; font-size:14px; font-weight:bold; color:#FFFFFF}
.tc_nr{width:603px; height:233px; border:1px solid #bababa; margin:0 auto}
.nr_top{background:#7b7b7b; color:#FFFFFF}
.tc_rightb{border-right:1px solid #c3c3c3}
.tc_footb{border-bottom:1px solid #c3c3c3}
</style>
</head>

<body>
<div class="tc_box">
<div class="tc_top"><span><a href="javascript:removeDiv0()"  ><img src="<%=basePath%>potal/images/customer/xx.png" /></a></span>客户:张三[交接记录]</div>
<div class="tc_nr">
<table width="603"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="99" height="26" align="center" class="nr_top tc_rightb">原业务人员</td>
    <td width="108" height="26" align="center" class="nr_top tc_rightb">新业务人员</td>
    <td width="108" height="26" align="center" class="nr_top tc_rightb">交接时间</td>
    <td width="285" height="26" align="center" class="nr_top">交接原因</td>
  </tr>
  <c:forEach items="${list}" var="list1">
  <tr>
    <td width="99" height="25" align="center" class="tc_rightb tc_footb">${list1.employeeByOldPrincipal.name}</td>
    <td width="108" height="25" align="center" class="tc_rightb tc_footb">${list1.employeeByNewPrincipal.name}</td>
    <td width="108" height="25" align="center" class="tc_rightb tc_footb">${list1.movetime}</td>
    <td width="285" height="25" align="center" class="tc_footb">${list1.moveCause}</td>
  </tr>
</c:forEach>
</table>

</div>

</div>
</body>
</html>
