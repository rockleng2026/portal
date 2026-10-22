<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.fuao.fajxc.util.Cookies" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
 <%
  		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0); 
	    System.out.println("cookieTest");
	    Cookies cookie=new Cookies();
	  //  cookie.removeCookie(response, "employeeName");
		//			cookie.removeCookie(response, "employeeId");
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>login.jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Css/login.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" charset="GBK" src="js/login.js"></script>
<script type="text/javascript">
	function init(){
	document.all("loginName").focus();
}
window.onload=init;
//document.onkeydown = function(event){   
 //       event = event?event:window.event;   
 //       if (event.keyCode == 13) {   
 //           alert("hello world!");   
 //       }   
 //   }; 
  function  subclick(){
  	 var event=arguments.callee.caller.arguments[0]||window.event;
  	 //alert(event.keyCode);
  	 if (event.keyCode == 13) {
  	 	login3();
  	 } 
  }  
</script>
  </head>
  <body>
  
	<div class="Login_BgT"></div>
	<div class="Login_BgC" >
		<div class="Login_Box">
			<div class="LBox_L">福奥科技进销存系统登陆   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			<div class="LBox_M">
				<form name="UserLogin"  method="post">
				<table>
					<tr>
						<td class="Tab">用户名</td><td>
						<input type="text" name="loginName" id="loginName" value="" size="20" onkeydown="if(event.keyCode==13)event.keyCode=9" />
						</td>
					</tr>
					<tr>
						<td class="Tab">密&nbsp;码</td><td><input type="password" id="password" name="password"  onkeydown="if(event.keyCode==13)event.keyCode=9" /><br />
						  <font color="red">${errorMsg == null ? "" : errorMsg }</font></td>
					</tr>
					<tr>
					<% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
						<td class="Tab">验证码</td><td><input type="text" size="10" name="ValCode" id="ValCode" style="width:35px" onkeydown="subclick()"><img  src="<%=imgpath%><%=request.getContextPath() %>/servlet/Img"/><!-- 插入验证码文件 --></td>
					</tr>
					<tr>
						<td></td><td>
						<input type="hidden" name="aftervalue" id="aftervalue" value="afterEmpty" />
						<!-- 
						<a  href="javascript:login();" id="submit" class="Login_btn01">登陆</a><a href="javascript:document.forms[0].reset();" class="Login_btn01">重置</a>
						 -->
						<a  href="javascript:login3();" id="submit2" class="Login_btn01">登陆</a><a href="javascript:document.forms[0].reset();" class="Login_btn01">重置</a>
						<!-- <a  onclick="login();" id="submit" class="Login_btn01">老版本后端</a><br/> -->
						<a  onclick="login2();" id="submit3" class="Login_btn01">后台管理</a>
						</td>
					</tr>
				</table>
				</form>
			</div>
			<div class="LBox_R">
			</div>
			<style>
				.bizmail_loginpanel{font-size:12px; width:580px;height:auto;border:1px solid #cccccc;background:#ffffff;}
				.bizmail_LoginBox{padding:10px 15px;}
				.bizmail_loginpanel h3{padding-bottom:5px;margin:0 0 10px 0;border-bottom:1px solid #cccccc;font-size:14px;}
				.bizmail_loginpanel form{margin:0;padding:0;}
				.bizmail_loginpanel input.text{font-size:12px;width:100px;height:20px;margin:0 2px;border:1px solid #C3C3C3;border-color:#7C7C7C #C3C3C3 #C3C3C3 #9A9A9A;}
				.bizmail_loginpanel .bizmail_column{height:28px;}
				.bizmail_loginpanel .bizmail_column label{display:block;float:left;width:30px;height:24px;line-height:24px;font-size:12px;}
				.bizmail_loginpanel .bizmail_column .bizmail_inputArea{float:left;width:240px;}
				.bizmail_loginpanel .bizmail_column span{font-size:12px;word-wrap:break-word;margin-left: 2px;line-height:200%;}
				.bizmail_loginpanel .bizmail_SubmitArea{margin-left:30px;clear:both;}
				.bizmail_loginpanel .bizmail_SubmitArea a{font-size:12px;margin-left:5px;}
				.bizmail_loginpanel select{width:110px;height:20px;margin:0 2px;}
			</style>
		<script type="text/javascript" src="http://exmail.qq.com/zh_CN/htmledition/js_biz/outerlogin.js"  charset="gb18030"></script>
		<div align="center">
		<script type="text/javascript">
			writeLoginPanel({domainlist:"cicgp.com", mode:"horizontal"});
		</script>
		</div>
		
	</div>
			
<div class="Copyright">Copyright(C)2008 Fuao2008.com ALL Right Reserved</div>
	</div>

  </body>
</html>
