<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.bussiness.message.MessageBussiness"%>
<%@page import="com.fuao.fajxc.vo.Message"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
MessageBussiness messageBussiness=(MessageBussiness)request.getAttribute("messageBussiness");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>消息记录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	<style type="text/css">
		.main{ width:650px; font-size:12px; margin:0 auto; float:left}
		
		.dow_top{width:650px; height:26px; background:#413c39; padding-left:10px; float:left; line-height:30px; color:#FFFFFF; font-size:14px; font-weight:bold; overflow:hidden}
		.dow_top span{float:right; padding-right:10px; padding-top:1px;}
		.dow_top a{color:#FFFFFF; font-size:12px; font-weight:bold; text-decoration:none}
		.tab_bd{ border:1px solid #d4d4d4}
		.td_bd{ background:#efefef; color:#292727; font-size:16px;}
		.fc_lv{ color:#295900}
		.cheng{ color:#e0731e}
		.td_bdd{ background:#efefef;}
		.r{ float:left; margin-left:3px; font-size:14px;}
		.l{ float:right; margin-right:10px; font-size:12px;}
		.dv{ float:left;}
		.zhuyao { width:650px; margin:auto;}
	</style>

  </head>
  
  <body>
<div class="main">
<div class="dow_top"> <span><a href="#">×</a></span> 消息记录 </div>
</div>
<div class="main" style="height:300px; overflow: auto;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="30"> 当前位置：首页>消息模块><span class="cheng">消息记录</span>><a href="javascript:void(0);" onclick="history.go(-1)" style="color:#e0731e; font-size:12px; font-weight:bold; text-decoration:none" >返回</a></td>
    </tr>
    <tr>
      <td>
	      <table width="660" border="0" cellpadding="0" cellspacing="0" class="tab_bd">
	          <%
	              Message msg=(Message)request.getAttribute("message");
	              Employee emp=(Employee)messageBussiness.getEmp(Employee.class,Integer.parseInt(msg.getSender()));
	          %>
		        <tr>
		          <td class="td_bd">
		              <span class="r" style="word-break:break-all;word-wrap:break-word"><span class="fc_lv"><%=emp.getName() %></span>:<%=msg.getMessagecontent() %></span>
		              <span class="l"><%=msg.getReleasetime() %></span>
		          </td>
		        </tr>
		        <%
		            List<Message> msglist=(List<Message>)request.getAttribute("msglist");
		            for(int i=0;i<msglist.size();i++){
		            	Message message=msglist.get(i);
		            	Employee emp2=(Employee)messageBussiness.getEmp(Employee.class,Integer.parseInt(message.getSender()));
		            	if(message.getSuperid().equals(msg.getMessageid())){
		        %>
			        <tr>
			          <td>
				          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tab_bd">
				          <tr>
					          <td width="5%">&nbsp;</td>
					          <td width="75%" style="word-break:break-all;word-wrap:break-word"><span class="fc_lv"><%=emp2.getName() %></span>:<%=message.getMessagecontent() %></td>
					          <td width="20%"><%=message.getReleasetime() %></td>
				          </tr>
				          </table>
			          </td>
			        </tr>
		        <%}
		             for(int j=0;j<msglist.size();j++){
		            	 Message message2=msglist.get(j);
		            	 Employee emp3=(Employee)messageBussiness.getEmp(Employee.class,Integer.parseInt(message2.getSender()));
		                if(message.getMessageid().equals(message2.getSuperid())){
		             %>
		             <tr>
		              <td>
				          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tab_bd">
				          <tr>
					          <td width="10%">&nbsp;</td>
					          <td width="70%" style="word-break:break-all;word-wrap:break-word"><span class="fc_lv"><%=emp3.getName() %></span>:<%=message2.getMessagecontent() %></td>
					          <td width="20%"><%=message2.getReleasetime() %></td>
				          </tr>
				          </table>
			          </td>
			        </tr>
		           <%}%>
		           <%} %>  
		        <%}%>
	      </table>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
