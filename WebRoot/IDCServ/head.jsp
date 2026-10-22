<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.Customer"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'head.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link href="<%=basePath%>IDCServ/css/main.css" rel="stylesheet" type="text/css" />
  </head>
  
  <body>
  <% Customer   c=(Customer)session.getAttribute("customer"); 
     if(c.getCustomerName().equals("") || c.getCustomerName()==""){
       request.getRequestDispatcher(basePath+"IDCServ/loggin.jsp");
     }
  %>
  

  <div style=" text-align: right;width: 100%;">
  <br/>
    <font color="#000000" size="-1" >     登录名：<%=c.getCustomerName() %>&nbsp;&nbsp;</font><a  href="<%=basePath%>outSystemsCustomerServer.do" style="margin-right: 120"><font color="blue"  size="-1"><b>安全退出</b></font></a>

    </div>
<div class="dt02">
  <div class="dt0201"><img src="<%=basePath%>IDCServ/image/index_14.jpg" /></div>
  <div class="dt0202">
    <div class="dt0203"><img src="<%=basePath%>IDCServ/image/index_07.jpg" /></div>
    <div class="dt0204">
      <input name="" type="text" value="请输入你要搜索的产品" />
    </div>
   
    <div class="dt0205">
      <input name="" type="submit" value="" />
    </div>
    
  </div>
  <div class="clear"></div>
</div>
<div class="dt03">
  <div class="dt04">
    <ul>
      <li style="background:none;"><a href="<%=basePath%>IDCServ/index.jsp">首 页</a></li>
      <li><a href="javascript:void(0)">互联网解决方案</a></li>
      <li><a href="javascript:void(0)">企业解决方案</a></li>
      <li><a href="javascript:void(0)">政府解决方案</a></li>
      <li><a href="javascript:void(0)">家庭个人解决方案</a></li>
    </ul>
  </div>
</div>
  </body>
</html>
