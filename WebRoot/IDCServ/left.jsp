<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>left.jsp</title>
    <script type="text/javascript" src="<%=request.getContextPath() %>/IDCServ/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/IDCServ/js/chinaprovinces_0.2.1.js"></script>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 
  </head>
  
  <body>
    <div class="dd13">
     <div class="dd1301">
    <dl>
      <dt>交易管理</dt>
      <dd><a href="javascript:checkorder()">我的订单</a></dd>
      <dt style="margin-top:15px;">工单管理</dt>

      <dd><a href="javascript:checkorder1()">在线工单</a></dd>

      <dt style="margin-top:15px;">账户管理</dt>
      <dd><a href="<%=basePath%>IDCServ/writeAddress.jsp">增加收货地址</a></dd>
      <dd><a href="<%=basePath%>checkAddressCustomerServer.Action">查看收货地址</a></dd>
      <dd><a href="<%=basePath%>selgrmessangeCustomerServer.do">个人资料</a></dd>
      <dd><a href="<%=basePath%>IDCServ/changePsword.jsp">修改密码</a></dd>
    </dl>
  </div>
  <script type="text/javascript">
 function checkorder(){

  	$.ajax({
  	  type:'post',
           url:'checkOrderCustomerServer.do',
           success:function(s){
         
           if(s=="3"){
              location.href="<%=basePath%>selOrderCustomerServer.do";
              }else{
              alert("您好。当前您的信息不完整。请填写个人信息后再查看订单！谢谢。");
               location.href="<%=basePath%>IDCServ/consumer.jsp";
              }
           }
  	});
 
  
 
 }
 function checkorder1(){

  	$.ajax({
  	  type:'post',
           url:'checkOrderCustomerServer.do',
           success:function(s){
        
           if(s=="3"){
              location.href="<%=basePath%>gosubnoteMalfunctionDeclare.do";
              }else{
              alert("您好。当前您的信息不完整。请填写个人信息后再查看订单！谢谢。");
               location.href="<%=basePath%>IDCServ/consumer.jsp";
              }
           }
  	});
 
  
 
 }
 
 
 </script>
  </body>
</html>
