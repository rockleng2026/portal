<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'userlis.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="Css/admin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" charset="gbk"></script>	
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
	</head>

	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="customerListSystem.do">客户列表</a>&nbsp;>&nbsp;开通客户账户
	</font></div>
		<div class="conSet">
		<form action="openaccountSystem.do" method="post">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						客户名称：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
						<input type="hidden" name="id" id="id" value="<%=request.getParameter("id") %>" />
						<input type="text" name="customername" id="customername" value="<%=new String(request.getParameter("customername").getBytes("ISO-8859-1"),"gbk") %>" onblur="checkValueByRules('customername','','customernameMsg')"/>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="customernameMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						登录账户：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;">
								<input type="text" name="loginName" id="loginName" value="" onblur="checkValueByRules('loginName','','loginNameMsg')"/>
							</div>	
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="loginNameMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						密码：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;">&nbsp;<input type="password" name="password" id="password" value="" onblur="checkValueByRules('password',['password'],'passwordMsg')"/></div>	
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="passwordMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						确认密码：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;">&nbsp;<input type="password" name="repassword" id="repassword" value="" onblur="checkValueByRules('repassword',['password'],'repasswordMsg')"/></div>	
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="repasswordMsg" color=#ff0000></FONT></div>				
					</td>
				</tr>
				<tr>
					<td colspan="2" align="left" nowrap style="width: 450px" class="bg1">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" onclick="openaccount()" value="提交"/>
							<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
			</form>
		</div>
	</body>
	<script type="text/javascript">
		function openaccount()
		{
			var id = $("#id").val();
			var loginName = $("#loginName").val();
			var repassword = $("#repassword").val();
			var password = $("#password").val();
			if(password!=repassword)
			{
				$("#repassword").attr("value","");
				$("#repasswordMsg").html("输入的两次密码不一致，请重新输入！");
				return false;
			}
			else
			{
				var url = "openaccountSystem.do";
				$.post(url,{id:id,loginName:loginName,repassword:repassword},function(data){
					if(data=='1')
					{
						alert("开通账户成功。");
						window.location.href="customerListSystem.do";
					}
					else
					{
						alert("开通账户失败");
						return false;
					}	
				});
			}
			
		}
	</script>
</html>
