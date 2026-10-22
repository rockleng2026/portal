<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>个人信息</title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />
	<link href="../css/admin.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>cms/css/easyui.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>cms/css/icon.css" />
	<script type="text/javascript" src="<%=basePath%>cms/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>cms/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>cms/js/selfinfo.js"></script>
	<script type="text/javascript">
	function reflesh(){
		window.location.reload(); 
	}
	</script>
</head>

<body>
<div id="weizhi">
<div id="weizhiwz">当前位置&nbsp;>>&nbsp;个人信息管理</div>
</div>
<table style="width:100%; height:430px; margin:0 auto;">
 
<tr>
<td width="100%" height="330px">
<form style="width:95%; height:330px;overflow-y: scroll;border:#CCC 1px double; margin: 0 auto; text-indent:20px;">
<br/><br/>
<p style="margin-left: 20px;"><font style="font-weight: bold;">个人信息</font>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="reflesh();" title="点击刷新信息"><font color="red">刷新个人信息</font></a></p> 
<p style="margin-left: 20px;">用户名：<s:property value="#session.adminid.username"/></p>
<p style="margin-left: 20px;">邮箱：<s:property value="#session.adminid.email"/></p>
<p style="margin-left: 20px;">注册日期：<s:property value="#session.adminid.regdate"/></p>
<p style="margin-left: 20px;">所在部门：<s:property value="#session.adminid.depts.name"/></p>
<p style="margin-left: 20px;"><input type="button" value="修改资料" onclick="update(${adminid.user_id },'${adminid.username }','${adminid.email }',${adminid.depts.id },'${adminid.depts.name }')"><input type="button" value="修改密码" onclick="updatePwd(${adminid.user_id },${adminid.depts.id })"></p>
</form>
</td>
</tr>
<tr>
<td width="100%" height="100">
<input type="hidden" name="basepath" id="basepath" value="${basepath}"/>
  <img src="../images/shouye-title.jpg" width="360" height="58" style=" float:right; margin-right:25px; margin-top:10px;" /></td>
</tr>
</table>
<div id="nn" style="display: none">
		<div id="w" class="easyui-window" title="输入界面" iconCls="icon-save"
			style="width: 500px; height: 200px; padding: 5px; background: #fafafa;">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="padding: 10px; background: #fff; border: 1px solid #ccc;">
					<form id="ff" name="foms"
						action=""
						method="post">
						<br />
						<br />
						<div class="conSet">
							<table width="100%" border="0" align="center" cellpadding="3"
								cellspacing="1" class="space tableBg">
								<tr>
									<td align="right" nowrap class="bg3">
										账号：
									</td>
									<td align="left" class="bg0">
										<input type="text" name="admin.username" style="width: 200" id="username" value="${adminid.username }" readonly="readonly" /> *账号不能修改
				                        <input type=hidden name="admin.user_id" id="userid" value="${adminid.user_id }" />
									    <span id="clasid" style="color: red;"></span>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap class="bg3">
										Email：
									</td>
									<td align="left" class="bg0">
										<input type=text name="admin.email" id="email" style="width: 200" value="#session.adminid.email"/>
										<span id="tnmsg" style="color: red;"></span>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap class="bg3">
										输入密码(*)：
									</td>
									<td align="left" class="bg0">
										<input type="password" name="admin.admin_password" id="pwd1"
											style="width: 200" maxlength="20"  onchange="checkOldPwd2(${adminid.user_id })"/>
										<span id="engmsg" style="color: red;"></span>
										<input type=hidden name="isok2" id="isok2" value="0" />
									</td> 
								</tr>
								<tr>
									<td align="right" class="bg3">
										所属部门：
									</td>
									<td class="bg0">
										<select name="admin.depts.id" id="depts">
										    <option value="-1">--所有--</option>
										</select>
										<span id="dept" style="color: red;"></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center" nowrap class="bg1">
										<input type="button" class="save_but" id="subs" value="提交信息" onclick="checkform()" />*修改成功返回后请点击“刷新个人信息”
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>	
		</div>
<div id="mm" >	
			<div id="up" class="easyui-window" title="输入界面" iconCls="icon-save"
			style="width: 500px; height: 200px; padding: 5px; background: #fafafa;">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="padding: 10px; background: #fff; border: 1px solid #ccc;">
					<form id="uppwd" name="forms"
						action=""
						method="post">
						<br />
						<br />
						<div class="conSet">
							<table width="100%" border="0" align="center" cellpadding="3"
								cellspacing="1" class="space tableBg">
								<tr>
									<td align="right" nowrap class="bg3">
										旧密码(*)：
									</td>
									<td align="left" class="bg0">
										<input type="password" name="oldpwd" id="oldpwd"
											style="width: 200" maxlength="20" onchange="checkOldPwd(${adminid.user_id })" />
										<input type=hidden name="admin.user_id" id="useridPwd" value="" />
										<input type=hidden name="admin.depts.id" id="deptidPwd" value="" />
										<input type=hidden name="isok" id="isok" value="0" />
										<span id="oldpwdtest" style="color: red;"></span> 
									</td> 
								</tr>
								<tr>
									<td align="right" class="bg3">
										新密码：
									</td>
									<td class="bg0">
										<input type="password" name="newpwd1" id="newpwd1"
											style="width: 200" maxlength="20" />
										<span id="newpwdtest1" style="color: red;"></span>										
									</td>
								</tr>
								<tr>
									<td align="right" class="bg3">
										确认新密码：
									</td>
									<td class="bg0">
										<input type="password" name="admin.admin_password" id="newpwd2"
											style="width: 200" maxlength="20" />
										<span id="newpwdtest2" style="color: red;"></span>										
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center" nowrap class="bg1">
										<input type="button" class="save_but" value="提交" id="subsPwd" onclick="checkformPwd()" />
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>  
</body>
</html>
