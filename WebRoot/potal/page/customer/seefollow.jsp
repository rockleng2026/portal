<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<style type="text/css">
body{width:624px; margin: 0 auto; font-size:12px}
img{border:0}
.tc_box1{width:622px; height:285px; border:1px solid #a8a8a8; float:left}
.tc_top1{width:612px; height:23px; line-height:23px; padding-left:10px; background:#295a00; color:#FFFFFF; font-size:12px; margin-bottom:6px;}
.tc_top1 span{float:right; padding-right:15px; margin-top:7px;}
.tc_top1 a{text-decoration:none; font-size:14px; font-weight:bold; color:#FFFFFF}
.tc_nr1{width:603px; height:233px; border:1px solid #bababa; margin:0 auto}
.nr_top1{background:#7b7b7b; color:#FFFFFF}
.tc_rightb1{border-right:1px solid #c3c3c3}
.tc_footb1{border-bottom:1px solid #c3c3c3}
</style>
</head>

<body>
<div class="tc_box1">
<div class="tc_top1"><span><a href="javascript:removeDiv0()"><img src="<%=basePath%>potal/images/customer/xx.png" /></a></span>客户:张三[跟进记录]</div>
<div class="tc_nr1">
<table width="603"  border="0" cellpadding="0" cellspacing="0">
  <tr height="26">
  
    <td width="99" height="26" align="center" class="tc_rightb1 nr_top1">跟进人员</td>
    <td width="108" height="26" align="center" class="tc_rightb1 nr_top1">跟进方式</td>
    <td width="108" height="26" align="center" class="tc_rightb1 nr_top1">跟进时间</td>
    <td width="285" height="26" align="center" class="nr_top1">跟进内容</td>
  </tr>
  <c:forEach items="${list}" var="list1">
  <tr height="26">
    <td width="99" height="25" align="center" bgcolor="#f3f3f3" class="tc_rightb1 tc_footb1">${list1.employee.name}</td>
    <td width="108" height="25" align="center" bgcolor="#f3f3f3" class="tc_rightb1 tc_footb1">
    <c:forTokens items="${list1.followtype}" delims="," var="s1">
    <c:if test="${s1==1}">
          面谈
    </c:if>
     <c:if test="${s1==2}">
          电话
    </c:if> <c:if test="${s1==3}">
          短信
    </c:if> <c:if test="${s1==4}">
          其他
    </c:if>
    
    </c:forTokens></td>
    <td width="108" height="25" align="center" bgcolor="#f3f3f3" class="tc_rightb1 tc_footb1">${list1.date}</td>
    <td width="285" height="25" align="center" bgcolor="#f3f3f3" class="tc_footb1">${list1.detail}</td>
  </tr>
  </c:forEach>
  
</table>

</div>

</div>
</body>
</html>
