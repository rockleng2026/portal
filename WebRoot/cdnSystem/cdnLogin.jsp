<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'cdnLogin.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link type="text/css" rel="stylesheet" href="<%=path%>/cdnSystem/css/base.css" />
		<link rel="stylesheet" type="text/css" href="<%=path%>/cdnSystem/css/cdncss.css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>

		<style type="text/css">
body {
	font-size: 12px;
	background: url(<%=path%>/cdnSystem/images/dl_bg.jpg);
}

#main {
	width: 980px;
	margin: 0 auto;
}

.cdn_db {
	color: #fff;
	font-weight: bold;
	font-size: 30px;
	margin-top: 150px;
	margin-left: 190px;
	line-height: 40px;
}

.cdn_db p {
	font-size: 20px;
	line-height: 40px;
	margin: 0;
	padding: 0;
}

.cdn_dlk {
	width: 477px;
	height: 203px;
	background: url(<%=path%>/cdnSystem/images/dlk_bg.png) no-repeat;
	margin: 30px auto;
}

.zs_zt {
	color: #c5c5c5;
	font-size: 12px;
}

.dl_yhm {
	background: url(<%=path%>/cdnSystem/images/dl_yhm.jpg) no-repeat;
	line-height: 27px;
	height: 27px;
	color: #fff;
	border: 0px;
	width: 187px;
}

.yhm_dw {
	color: #fff;
	position: relative;
	top: -22px;
	margin-left: 140px;
}

.dl_mm {
	background: url(<%=path%>/cdnSystem/images/dl_mm.jpg) no-repeat;
	color: #000;
	line-height: 27px;
	height: 27px;
	border: 0px;
	width: 187px;
	margin-top: -12px;
}

.mm_dw {
	color: #949393;
	position: relative;
	top: -22px;
	margin-left: 150px;
}

.dl_jzmm {
	color: #434343;
	font-size: 12px;
	margin-top: -15px;
	position: relative;
	left: 20px;
}

.dl_jzmg {
	margin-top: -14px;
}

.dl_bgt {
	width: 85px;
	height: 25px;
	line-height: 25px;
	color: #fff;
	text-align: center;
	font-size: 14px;
	background: url(<%=path%>/cdnSystem/images/dl_bgt.jpg) no-repeat;
}

.dl_bgt a {
	color: #fff;
	text-decoration: none;
}

.dl_bgt a:hover {
	color: #FF9900;
}

.dl_zhmm a {
	color: #468bd9;
	text-decoration: none;
}

.dl_zhmm a:hover {
	color: #FF9900;
}
</style>

		<script type="text/javascript">
	function login()
	{
		if($("[name=yonghuming]").val()==""||$("[name=yonghuming]").val()=='请输入')
		{
			alert("请输入用户名！");
			$("[name=yonghuming]").focus();
			return;
		}
		else if($("[name=mima]").val()==""||$("[name=mima]").val()=='*****')
		{
			alert("请输入密码！");
			$("[name=mima]").focus();
			return;
		}
		else
		{
			//window.location.href='首页.html';
			var loginUserName=$("[name=yonghuming]").val();
			var password=$("[name=mima]").val();
			$.post("userLoginCdnSystemAction.Action",{loginUserName:loginUserName,password:password},function(data){
				
						if(data=="0")
						{
							alert("登录成功！！");
							window.location.href='cdnSystem/cdnIndex.jsp';
						}
					else
						{
							alert("登录失败！！  请重新登录！！！");
						}
				});
		}
	}
</script>
	</head>

	<body>
		<div id="main">
			<div class="cdn_db">
				CDN管理系统
				<p>
					------后台登陆界面
				</p>
			</div>
		</div>
		<div id="main">
			<div class="cdn_dlk">
				<table width="100%" height="100%" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td width="8%" height="30">
							&nbsp;
						</td>
						<td width="40%" colspan="2">
							&nbsp;
						</td>
						<td width="52%" rowspan="5" align="center" valign="middle">
							<img src="<%=path%>/cdnSystem/images/cdn_logo.gif" width="121" height="107" />
						</td>
					</tr>
					<tr>
						<td height="30">
							&nbsp;
						</td>
						<td colspan="2">
							<input type="text" name="yonghuming" class="dl_yhm"
								onkeydown="if (event.keyCode==13) {}"
								onblur="if(this.value=='')value='请输入';" onfocus="this.value='';"
								value="请输入" />
							<span class="yhm_dw">用户名</span>
						</td>
					</tr>
					<tr>
						<td height="30">
							&nbsp;
						</td>
						<td colspan="2">
							<input type="password" name="mima" class="dl_mm"
								onkeydown=
	if (event.keyCode == 13) {
	};
onblur="if(this.value=='')value='*****';"
								onfocus="if(this.value=='*****')value='';" value="*****" />
							<span class="mm_dw">密码</span>
						</td>
					</tr>
					<tr>
						<td height="30">
							&nbsp;
						</td>
						<td colspan="2">
							<input type="checkbox" name="checkbox" value="checkbox" />
							<div class="dl_jzmm">
								记住用户名
							</div>
						</td>
					</tr>
					<tr>
						<td height="30">
							&nbsp;
						</td>
						<td align="center">
							<div class="dl_bgt">
								<a href="javascript:login()">登陆</a>
							</div>
						</td>
						<td align="center">
							<span class="dl_zhmm"><a href="找回密码验证码错误.html">找回密码</a>
							</span>
						</td>
					</tr>
					<tr>
						<td height="22">
							&nbsp;
						</td>
						<td colspan="2">
							&nbsp;
						</td>
						<td>
							<span class="zs_zt">2012-01-09 10:10:30&nbsp;系统升级到最新版本</span>
						</td>
					</tr>
					<tr>
						<td height="22">
							&nbsp;
						</td>
						<td colspan="2">
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>

			</div>
		</div>
	</body>
</html>
