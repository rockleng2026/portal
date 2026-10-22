<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'saleOrderList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/setMeal/css.css">

  </head>
  
 <body>
<table width="1000" border="0" align="center">
  <tr>
    <td align="center" width="94%" style="text-align:right;"><input id="" name="" type="text"/>
      <input id="" name="" type="button" value="查询"/></td>
    <td align="right" width="6%" height="30"><a href="#" style="color:#0166d4; font-weight:bold; text-decoration:none; ">增加订单</a></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0"  width="1000" align="center">
  <tr>
    <td align="center" colspan="10"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; " >
        <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:987px;">
          <h3>订单列表</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
  <tr style="height:30px; line-height:30px;">
  
  <td colspan="10" align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr class="dt03">
        <td width="15%" align="center" height="35">订单编号 </td>
        <td width="10%" align="center"> 套餐 </td>
        <td width="15%" align="center"> 申请时间 </td>
        <td width="10%" align="center"> 申请人 </td>
        <td width="10%" align="center"> 审核状态 </td>
        <td width="10%" align="center"> 流程跟踪 </td>
        <td width="10%" align="center"> 付费状态 </td>
        <td width="10%" align="center"> 详细信息 </td>
        <td width="5%" align="center"> 修改 </td>
        <td width="5%" align="center"> 删除 </td>
      </tr>

      
      <tr>
        <td width="15%" align="center" height="30"> XSDD-2012 </td>
        <td width="10%" align="center"> 套餐A </td>
        <td width="15%" align="center"> 2012-02-23 </td>
        <td width="10%" align="center"> 胥渊 </td>
        <td width="10%" align="center"> 未审核 </td>
        <td width="10%" align="center"><a href="#">流程跟踪</a></td>
        <td width="10%" align="center"> 未付 </td>
        <td width="10%" align="center"><a href="#">详细信息</a></td>
        <td width="5%" align="center"><a href="#">修改</a></td>
        <td width="5%" align="center"><a href="#">删除</a></td>
      </tr>
      <tr>
        <td colspan="10" align="center" height="30"> 分页 </td>
      </tr>
    </table></td>
    </tr>
</table>
</html>
