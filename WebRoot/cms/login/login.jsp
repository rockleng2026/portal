<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath",basePath);
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>登录界面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="./cms/css/denglu.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="./cms/js/login.js"></script>
	
	<style type="text/css">
	    .a{
	       color:#82b21e;
	       background-color: #fdfdfd;
	       border: 1px solid #CCC;
	       width: 200px;
	       height: 28px;
	       font-size: 20px;
	       line-height: 30px;
	    }
	</style>
	
	</head>

<body>
<div id="bk">
 <div id="head"></div>
 <div id="mid">
  <div id="left"></div>
  <div id="main">
  <form  action="cms/adminLoss.do" method="post" id="loginForm" name="foss">

  <input type="hidden" id="paths" name="paths" value="${basePath }"/>
  <table id="tb" width="450px" height="135px" cellpadding="0" cellspacing="0" border="0">
  <caption style="color:red;">
	   <s:iterator value="errors.names" var="ers" status="p">
	       <s:property value="ers"/>
	   </s:iterator>
  </caption>
   <tr>
    <td width="100" height="45px" align="right">用户名：</td>
    <td height="45px" colspan="2" align="left" >
       <input type="text"  id="yhm" name="admins.username"  class="a"  onkeyup="if(event.keyCode=='13'){subs();}"/>
    </td>
    <td width="128" height="45px"><span id="errname" style="color:red;"></span></td>
   </tr>
   <tr >
     <td width="100" height="45px" align="right">密&nbsp;&nbsp;码：</td>
     <td height="45px" colspan="2" align="left" ><input type="password" id="mima" name="admins.admin_password" class="a" onkeyup="if(event.keyCode=='13'){subs();}" /></td>
     <td width="128" height="45px"><span id="errpass" style="color:red;"></span></td>
   </tr>
   <tr>
    <td width="100" height="45px" align="right">验证码：</td>
    <td width="136" height="40px;" align="left"><input type="text" id="yzm" name="admins.admCode" style="width: 100px;" class="a" onkeyup="if(event.keyCode=='13'){subs();}"/></td>
    <td  width="146" height="45px" align="left"><img src="cms/changesLogin.do"  onclick="changeCode(this)" style="position:relative;left:-20px; width:90px; cursor: pointer;" alt="看不清楚？点击刷新" class="code" id="imas"/></td>
    <td width="128" height="45px"><span id="errcode" style="color:red;"></span></td>
   </tr>
  </table>
  <table id="button" width="450px" height="38px" cellpadding="0" cellspacing="0" >
  <tr>
   <td width="100" height="38px">&nbsp;</td>
   <td id="button1"  width="139" height="38px" ><input type="button" class="button1" onClick="subs()" id="but" value="登录" onkeyup="if(event.keyCode=='13'){subs();}"/></td>
   <td id="button2"  width="146" height="38px"><input type="button" class="button2" onClick="document.foss.reset();" value="取消"/></td>
   <td>&nbsp;</td>
  </tr>
  </table>
  </form>
  </div>
  <div id="right"></div>
 </div>
</div>
</body>
</html>