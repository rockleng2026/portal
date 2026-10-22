<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'cdnIndex.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="<%=path%>/cdnSystem/css/base.css" />

	<link rel="stylesheet" type="text/css" href="<%=path%>/cdnSystem/css/cdncss.css"/>


<style>
.main1{
	width:1000px;
	background-color:#f1f1f1;
	height:690px;
	font-size:14px;
	text-align: center;
}
.xd_j_zi{ font-size:12px; color:#626262; font-weight:bold}
.xd_j_zi_b{ color:#427db7; font-size:12px;}
.xd_j_zi_h{ color:#626262; font-size:12px;}
.xc_zhmm_div{width:840px; margin-left:82px; text-align:left; font-size:14px; color:#626262;}
.xc_zhmm_div_b{ border:1px solid #cdcdcd; height:417px; background-color:#FFF}
.xc_zhmm_blue{ color:#4586d8; font-size:12px;}
.xc_zhmm_ctab{ margin-top:20px;}
.xc_zhmm_cyurl{ display:block; background: url(<%=path%>/images/anniu.jpg) repeat-x; width:85px; line-height:25px; margin-left:161px; margin-top:30px; color:#FFFFFF; text-decoration:none; text-align:center; float:left;}

</style>
  </head>
 <script type="text/javascript">
 function yanzheng()
 {
 	
 		if(document.getElementById("password1").value==""||document.getElementById("password1").value==null )
 		{
 			alert("登录密码不能为空");
 			return false;
 		}
 		else if(document.getElementById("email").value==""||document.getElementById("email").value==null)
 		{
 			alert("邮箱不能为空");
 			return false;
 		}
 		else if(document.getElementById("password2").value==""||document.getElementById("password2").value==null )
 		{
 			alert("新登录密码不能为空");
 			return false;
 		}
 		else if(document.getElementById("password").value==""||document.getElementById("password").value==null)
 		{
 			alert("确认登录密码不能为空");
 			return false;
 		}
 		else if(document.getElementById("apiPassword1").value==""||document.getElementById("apiPassword1").value==null )
 		{
 			alert("新api密码不能为空");
 			return false;
 		}
 		else if( document.getElementById("apiPassword1").value==""||document.getElementById("apiPassword1").value==null)
 		{
 			alert("确认api密码不能为空");
 			return false;
 		}
 	
 		if((document.getElementById("password2").value==document.getElementById("password").value)==false)
 		{
 			alert("2次输入的登录密码不一样！！ 请重新输入");
 			return false;
 		}
 		if((document.getElementById("apiPassword1").value==document.getElementById("apiPassword").value)==false)
 		{
 			alert("2次输入的api密码不一样！！ 请重新输入");
 			return false;
 		}
 	
 	
 }
 	
 </script>
  
<body>
<form id ="form1" name=form1 action="updateCdnSystemAction.Action" method="post">
<jsp:include page="top.jsp" flush="true"/>
<div align="center">
<div id="header" class="main" style="display: none;">
	<div style="float:left;width:90px;">
		<img  src="images/logo.png"/>
	</div><div style="float:left; line-height:72px;"></div><div style="float:left">
		
		<div id="nav" style="background:url('<%=path%>/images/nav_l.png') no-repeat left; height:27px; padding-left:8px;">
			<div id="xuanxiangka">
          </div>
		</div>
	</div>
	
</div>
<div style=" height:3px; background-color:#1967AF" class="main"></div>
<div id="p" class="main" style="line-height:26px; background-color:#484647; color:#cecccd; text-align:right; font-size:12px;"><a><strong style="color:#fff;">修改账户信息 </strong> |   <a href="<%=path%>/cdnSystem/cdnUpdateUser.jsp"> 修改用户信息 </a>|<a href="切换客户.html"> 切换账户</a> | <a href="业务概括.html"> 业务概括</a></a> <span style="padding-left:80px; padding-right:5px;">账号管理 | 设置</span></div>
<div class="main1">
<table class="xd_j_top" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="40" height="29" align="center"  class="xd_j_t"><img  src="<%=path%>/cdnSystem/images/yjt.png" width="11" height="11" /></td>
        <td width="960" align="left"><span class="xd_j_zi">当前位置</span>:</span><span class="xd_j_zi_h">我的账户</span>&gt;<span class="xd_j_zi_b">修改信息</span></td>
      </tr>
    </table></td>
  </tr>
</table>

<div class="xc_zhmm_div">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="3%"><img src="<%=path%>/cdnSystem/images/xc_rt.png" width="26" height="29" /></td>
      <td width="97%">找回密码</td>
    </tr>
  </table>
  <div class="xc_zhmm_div_b">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="xc_zhmm_ctab">
  <tr>
    <td width="19%" height="32" align="right">现有登陆密码：</td>
    <td width="22%"><input type="text" name="password1" id="password1" /><input type="hidden" name="id" id="id" value="${user.id }" />
       <span class="xc_zhmm_blue">*</span></td></td>
    <td width="59%" class="xc_zhmm_blue">&nbsp;</td>
  </tr>
  <tr>
    <td height="32" align="right">邮箱：</td>
    <td><input type="text"  name="email" id="email" />
       <span class="xc_zhmm_blue">*</span></td>
    <td class="xc_zhmm_blue">&nbsp;</td>
  </tr>
  <tr>
    <td height="32" align="right">新登录密码：</td>
    <td><input type="text"  name="password2" id="password2"  /></td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td height="32" align="right">&nbsp;</td>
    <td colspan="2" class="xc_zhmm_blue"><p>新的登入密码必须为6-16位字符，且使用大写字母、小写字母、数字、特殊符号（包含标点）四种字符至少三种的</p>
      <p>组合，且与登录名无相关性</p></td>
    </tr>
  <tr>
    <td height="32" align="right">确定新登录密码：</td>
    <td height="32" align="left"><input type="text"  name="password" id="password" /></td>
    <td height="32" align="right">&nbsp;</td>
    </tr>
  <tr>
    <td height="32" align="right">&nbsp;</td>
    <td height="32" colspan="2" align="left"  class="xc_zhmm_blue">再输入一次新密码</td>
    </tr>
  <tr>
    <td height="32" align="right">新api密码：</td>
    <td height="32" colspan="2" align="left" style="font-size:12px"><input type="text"  name="apiPassword1" id="apiPassword1" />
&nbsp;      
      &nbsp;(用于内容刷新API、计费带宽查询API、日志下载地址查询API、FIS系统等.)</td>
    </tr>
  <tr>
    <td height="32" align="right">&nbsp;</td>
    <td height="32" colspan="2" align="left" class="xc_zhmm_blue"><p>新的api密码必须为6-16位字符，且使用大写字母、小写字母、数字、特殊符号（包含标点）四种字符至少三种的</p>
      <p>组合，且与登录名无相关性</p></td>
    </tr>
  <tr>
    <td height="32" align="right">确认api密码：</td>
    <td height="32" align="left"><input type="text" name="apiPassword" id="apiPassword" /></td>
    <td height="32" align="right">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" align="center"><input type="submit" onclick="return yanzheng()" style="width: 80px;height: 30px;" value="修改"/></td>
  </tr>
  <tr>
    <td colspan="3" align="right">&nbsp;</td>
  </tr>
  </table>
</div>
</div>
<hr  style="margin-top:150px"/>
<span style="color:#7b7b7b; font-size:12px;">Copyright &copy; 福奥科技有限公司</span>
</div>
</div>
</form>
</body>
</html>
