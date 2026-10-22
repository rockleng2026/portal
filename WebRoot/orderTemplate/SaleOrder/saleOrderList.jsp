<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
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
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
	<link rel="stylesheet" type="text/css" href="Css/setMeal/css.css">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
  </head>
  <script type="text/javascript">
  function del(id)
  {
  	var url="delSaleOrderorderAction.do";
  	$.post(url,{id:id},function (data){
  	if(data==0)
  	{
  		alert("删除成功！！！！");
  		window.location.href='<%=request.getContextPath() %>/saleOrderListorderAction.do';
  	}
  	else
  	{
  		alert("删除失败！！！！");
  	}	
  	});
  	
  }
  function orderNum()
  {
  
    var orderNo=document.getElementById("orderNo").value;
    if(orderNo==null || orderNo=="")
    {
      
    }
     window.location.href='<%=request.getContextPath() %>/selectByOrderNumberorderAction.do?orderNo='+orderNo;
  }
  	
  </script>
 <body>
<table width="1000" border="0" align="center">
  <tr>
    <td align="center" width="94%" style="text-align:right;">订单编号：
    <input id="orderNo" name="orderNo" type="text"/>
      <input id="" name="" type="button" value="查询" onclick="orderNum()"/></td>
    
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
      <!-- 循环 -->
      <c:if test="${empty pages.pageList}"><tr><td align="center" colspan="10">无订单</td></tr></c:if>
      <c:if test="${!empty pages.pageList}">
      <c:forEach items="${pages.pageList}" var="data"  varStatus="state">
      <tr>
        <td width="15%" align="center" height="30">${data.orderNo}</td>
        <td width="10%" align="center">  ${data.setmealComm.name}</td>
        <td width="15%" align="center"> ${data.buildTime} </td>
        <td width="10%" align="center">${data.inputAdmin} </td>
        <td width="10%" align="center"> 
        <c:if test="${data.auditState ==0}">未审</c:if>
        <c:if test="${data.auditState ==1}">审核同意</c:if>
        <c:if test="${data.auditState ==2}">审核拒绝</c:if>
        <c:if test="${data.auditState ==8}">接收</c:if>
         </td>
        
          
        <td width="10%" align="center"><a href="#">流程跟踪</a></td>
        <td width="10%" align="center">
        <c:if test="${data.payStatus ==1}">月付</c:if>
        <c:if test="${data.payStatus ==2}">季付</c:if>
        <c:if test="${data.payStatus ==3}">半年付</c:if>
        <c:if test="${data.payStatus ==4}">一年付</c:if>
        <c:if test="${data.payStatus ==5}">一次付</c:if>
        </td>
        <td width="10%" align="center"><a href="saleOrderInfoorderAction.do?id=${data.id}&info=info">详细信息</a></td>
        <td width="5%" align="center"><a href="updateSaleOrderorderAction.do?id=${data.id}">修改</a></td>
        <td width="5%" align="center"><input id="" name="" type="button" value="删除" onclick="del(${data.id})" /></td>
      </tr>
      </c:forEach>
      </c:if>
      <!-- 循环结束 -->
      <tr>
        <td colspan="10" align="center" height="30"><p:pages url="saleOrderListorderAction.do"/> </td>
      </tr>
    </table></td>
    </tr>
</table>
</html>
