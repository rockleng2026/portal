<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.sql.Date"%>
<%@page import="com.fuao.fajxc.vo.Customer"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
     <jsp:include page="head.jsp"></jsp:include>
     <jsp:include page="left.jsp"></jsp:include>
  <div class="dd1302">
    <div class="dd1303"><span>我的等级</span></div>
    <div class="dd23">
    <%  
    Customer c=(Customer)session.getAttribute("customer"); 
    %>
    <pre>
           当前登录的用户名：<%=c.getCustomerName() %>
	您上次登录的IP是: <%=c.getLocalip() %>
	您上次登录的时间是:<%=c.getHistorytime() %>
	您本次登录的IP是:<%=request.getRemoteAddr() %>
	最近消费：￥<%=session.getAttribute("money") %>元 
	</pre>
    </div>
  </div>
</div>
    <jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
