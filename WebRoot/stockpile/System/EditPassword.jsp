<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
	
	</head>

	<body>
	<div class="currentlySet">
			<font size="2">
				当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;修改密码 </font>
		</div>
		
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="left" nowrap style="width: 100px" class="bg1">
						旧密码：
					</td>
					<td align="left" nowrap style="width: 500px" class="bg1">
						<div style="display:inline;"><input type="password" name="oldpassword" id="oldpassword" onblur="checkValueByRules('oldpassword','','oldpasswordMsg')"/></div>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="oldpasswordMsg" color=#ff0000></FONT></div>
					</td>	
				</tr>
				<tr>
					<td align="left" nowrap style="width: 100px" class="bg1">
						新密码：
					</td>
					<td align="left" nowrap style="width: 500px" class="bg1">
						<div style="display:inline;"><input type="password" name="newpassword" id="newpassword" onblur="checkValueByRules('newpassword',['password'],'newpasswordMsg')"/></div>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="newpasswordMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<tr>	
					<td align="left" nowrap style="width: 100px" class="bg1">
						确认密码：
					</td>
					<td align="left" nowrap style="width: 500px" class="bg1">
						<div style="display:inline;"><input type="password" name="confirmpassword" id="confirmpassword" onblur="checkValueByRules('confirmpassword',['password'],'confirmpasswordMsg')"/></div>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="confirmpasswordMsg" color=#ff0000></FONT></div>
					</td>	
				</tr>
				<tr>
					<td align="left" nowrap  class="bg0" colspan="2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="保存" onclick="editpassword('${user.userId}')"/>
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</div>
		
		<script type="text/javascript">
			function checkpassword()
			{
				var newpassword = $("#newpassword").val();
				var confirm = $("#confirmpassword").val();
				
				if(confirm == null||confirm == "")
				{
					$("#confirmpasswordMsg").html("该项不能为空");
					document.getElementById("confirmpassword").focus();
				}
				else if(confirm != newpassword)
				{
					$("#confirmpasswordMsg").html("输入的两次密码不一致");
					document.getElementById("confirmpassword").focus();
				}
			}
			
			function editpassword(uid)
			{
				var old = $("#oldpassword").val();
				var confirm = $("#confirmpassword").val();
				var newpassword = $("#newpassword").val();
				
				if($.trim(old)==""||$.trim(confirm)==""||$.trim(newpassword)=="")
				{
					if(old=="")
					{
						$("#oldpasswordMsg").html("该项不能为空！");
						document.getElementById("oldpassword").focus();
						return ;
					}
					if(newpassword=="")
					{
						$("#newpasswordMsg").html("该项不能为空！");
						document.getElementById("newpassword").focus();
						return ;
					}
					if(confirm=="")
					{
						$("#confirmpasswordMsg").html("该项不能为空！");
						document.getElementById("confirmpassword").focus();
						return ;
					}
				}
				
				if(confirm != newpassword)
					{
						$("#confirmpasswordMsg").html("输入的两次密码不一致");
						document.getElementById("confirmpassword").focus();
						return ;
					}
				
				var url = "editPasswordSystem.do";
				
				$.post(url,{uid:uid,password:newpassword},function(data){
					if(data==1)
					{
						alert("修改密码成功。");
						parent.location.href='login.jsp';
					}
					else
					{
						alert("修改密码失败");
						return ;
					}
				});
			}
		</script>
	</body>
</html>
