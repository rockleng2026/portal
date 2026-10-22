<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>定单确认</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
      <style>
       #aaa{
         font-size: 14px;
         text-align: center;
         padding-top:30px; 
       }

    </style>
    <script>
        function subvalue(sno,sna,snm,cuid){
           document.getElementById("salnos").value=sno;
           document.getElementById("flagsnos").value=sna;
           document.getElementById("salMonys").value=snm;
           document.getElementById("cusId").value=cuid;
           document.getElementById("payForms").submit();
        }
    </script>
  </head>
  <body>
  <form action="<%=request.getContextPath()%>/IDCServ/payForMoney.jsp" method="post" target="_self" id="payForms">
      <input type="hidden" name="salnos" id="salnos"> <!-- 定单ID -->
      <input type="hidden" name="flagsnos" id="flagsnos"><!-- 客户名称 -->
      <input type="hidden" name="salMonys" id="salMonys"><!-- 金额 -->
       <input type="hidden" name="cusId" id="cusId"><!-- ID -->
  </form>
 <jsp:include page="head.jsp"></jsp:include>
 <c:if test="${mpsFlags == 'a3'}">
        <div class="dd09" style=" background-position:left -72px;">
		  <ul>
		    <li><span>1,业务定单</span></li>
		    <li><span>2,定单确认</span></li>
		    <li><span>3,付款</span></li>
		    <li><span style="margin-left: 50px;">4,待上架</span></li>
		    </ul>
		</div>
</c:if>
 <c:if test="${mpsFlags == 'a1' || mpsFlags == 'a2'}">
	<div class="dd09" style=" background-position:left -36px;">
	    <ul>
	    <li><span>1,业务定单</span></li>
	    <li><span>2,定单确认</span></li>
	    <li><span>3,付款</span></li>
	    <li><span style="margin-left: 50px;">4,待上架</span></li>
	    </ul>
	</div>
  </c:if>

   <c:if test="${mpsFlags == 'a4'}">
		<div class="dd09" style="background-position:left -108px;">
	    <ul>
	    <li><span>1,业务定单</span></li>
	    <li><span>2,定单确认</span></li>
	    <li><span>3,付款</span></li>
	    <li><span style="margin-left: 50px;">4,待上架</span></li>
	    </ul>
	</div>
  </c:if>
<div class="pf10">
    <s:iterator value="#session.FlowList" var="fl" >
    <s:if test="#fl.dfContent=='等待用户确认定单信息...' && #fl.dfstat==null ">
        <div id="aaa"><s:property value="#fl.dftime" escapeXml="false"/>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/defineorderCustomerServer.do?paratid=<s:property value="#fl.Tsaleorders.id" escapeXml="false"/>" style="color:red;" target="_self"><s:property value="#fl.dfContent" escapeXml="false"/></a></div>
    </s:if>
    <s:elseif test="#fl.dfContent=='相关人员已审核等待用户付款...' && #fl.dfstat==null">
        <div id="aaa"><s:property value="#fl.dftime" escapeXml="false"/>&nbsp;&nbsp;&nbsp;<a href="javascript:subvalue('<s:property value="#fl.Tsaleorders.saleOrderNo"/>','<s:property value="#fl.Tsaleorders.customer.realName"/>',(<s:property value="#fl.Tsaleorders.price"/>*<s:property value="#fl.Tsaleorders.productNum"/>),<s:property value="#fl.Tsaleorders.customer.customerId"/>);" style="color:red;" ><s:property value="#fl.dfContent" escapeXml="false"/></a></div>
    </s:elseif>
    <s:else>
     <div id="aaa"><s:property value="#fl.dftime" escapeXml="false"/>&nbsp;&nbsp;&nbsp;<s:property value="#fl.dfContent" escapeXml="false"/></div>
    </s:else>
    </s:iterator>
</div>
<jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
