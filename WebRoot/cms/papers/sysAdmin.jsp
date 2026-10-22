<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath2 = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath2%>">
	<title>系统管理员管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		@import url("cms/css/admin.css");
	</style>
	<link rel="stylesheet" type="text/css" href="<%=basePath2%>cms/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath2%>cms/css/icon.css">
	<script type="text/javascript" src="<%=basePath2%>cms/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath2%>cms/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath2%>cms/js/sysadmin.js"></script>
	
	


	
</head>
<body bgcolor="#eeeeee">

    <input type="hidden" id="pathHid" value="<%=basePath2%>">
	<div id="weizhi">
		<div id="weizhiwz">
			当前位置&nbsp;>>&nbsp;管理员管理&nbsp;>>&nbsp;管理员列表
			<input type="hidden" name="basepath" id="basepath" value="${basepath }">
		</div>
	</div>
	<div style="width: 100%; height: 80%;">
		<table id="tabs" align="left">
		</table>
	</div>
	
	<div id="nn">
		<div id="w" class="easyui-window" title="输入界面" iconCls="icon-save"
			style="width: 500px; height: 200px; padding: 5px; background: #fafafa;">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="padding: 10px; background: #fff; border: 1px solid #ccc;">
					<form id="ff" name="foms"
						action=""
						method="post">
						<br>
						<br>
						<div class="conSet">
							<table width="100%" border="0" align="center" cellpadding="3"
								cellspacing="1" class="space tableBg">
								<tr>
									<td align="right" nowrap class="bg3">
										账号：
									</td>
									<td align="left" class="bg0">
										<input type="text" name="admin.username" style="width: 200" id="username" value="${admin.username }"  >
				                        <input type=hidden name="admin.user_id" id="userid" value="${admin.user_id }">
									    <span id="clasid" style="color: red;"></span>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap class="bg3">
										Email：
									</td>
									<td align="left" class="bg0">
										<input type=text name="admin.email" id="email" style="width: 200" >
										<span id="tnmsg" style="color: red;"></span>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap class="bg3">
										密码(*)：
									</td>
									<td align="left" class="bg0">
										<input type="password" name="admin.admin_password" id="pwd1"
											style="width: 200" maxlength="20">
										<span id="engmsg" style="color: red;"></span> 
									</td> 
								</tr>
								<tr>
									<td align="right" class="bg3">
										确认密码：
									</td>
									<td class="bg0">
										<input type="password" name="surepassword" id="pwd2"
											style="width: 200" maxlength="20">
										<span id="engmsg2" style="color: red;"></span>										
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
										<input type="button" class="save_but" id="subs" value="提交信息" onclick="checkform()">
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>	
		</div>	
			
			
			
		<div id="mm">	
			<div id="up" class="easyui-window" title="输入界面" iconCls="icon-save"
			style="width: 500px; height: 200px; padding: 5px; background: #fafafa;">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="padding: 10px; background: #fff; border: 1px solid #ccc;">
					<form id="uppwd" name="forms"
						action=""
						method="post">
						<br>
						<br>
						<div class="conSet">
							<table width="100%" border="0" align="center" cellpadding="3"
								cellspacing="1" class="space tableBg">
								<tr>
									<td align="right" nowrap class="bg3">
										旧密码(*)：
									</td>
									<td align="left" class="bg0">
										<input type="password" name="oldpwd" id="oldpwd"
											style="width: 200" maxlength="20" onblur="checkOldPwd()">
										<input type=hidden name="admin.user_id" id="useridPwd" value="">
										<input type=hidden name="admin.depts.id" id="deptidPwd" value="">
										<span id="oldpwdtest" style="color: red;"></span> 
									</td> 
								</tr>
								<tr>
									<td align="right" class="bg3">
										新密码：
									</td>
									<td class="bg0">
										<input type="password" name="newpwd1" id="newpwd1"
											style="width: 200" maxlength="20">
										<span id="newpwdtest1" style="color: red;"></span>										
									</td>
								</tr>
								<tr>
									<td align="right" class="bg3">
										确认新密码：
									</td>
									<td class="bg0">
										<input type="password" name="admin.admin_password" id="newpwd2"
											style="width: 200" maxlength="20">
										<span id="newpwdtest2" style="color: red;"></span>										
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center" nowrap class="bg1">
										<input type="button" class="save_but" value="提交" id="subsPwd" onclick="checkformPwd()">
									</td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="limt">
		<div id="rolit" class="easyui-window" title="权限设置" iconCls="icon-save"
			style="width: 500px; height: 300px; padding: 5px; background: #fafafa;">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false"
					style="padding: 10px; background: #fff; border: 1px solid #ccc;">
					 <div style="overflow: hidden;width:200px; height:270px; border:#999 double 1px;float: left;">
						<div style="overflow: auto;width:200px;height:230px;">
						<ul id="limitTree" animate="true"></ul>
						</div>
						<div style=" height:28px; width:200px;background-color: #e2f4cd; line-height:30px;">
					    <input type="submit" id="buto" value="提交" style="margin-left:60px; width:70px; height:25px; background:url(./cms/images/button02.png); background-repeat:no-repeat; border:0px; color:#FFF; cursor:pointer;" />
					  </div>
					</div>
					 <div style=" width:200px; height:270px;border:#999 double 1px; float:left;margin-left:10px;  font-size:12px; line-height:200%;">
					  <div style="width:234px;height:242px;overflow:auto;">
					  <form style=" margin-left:10px; margin-right:10px;">
					    
					    <center>树形说明书</center>
					    	操作方法：<br />
					    	当你点击了设置按钮后，将会弹出这个对话框，如果此用户之前有被分配权限，那你打开后第一眼见到的就是之前的权限，然后你你要为此用户增加权限的话要点击多选框，当被打勾时，这时就是选中，如果是选择父类的话，那它下面的子类也全选上，确定无误后，点击提交按钮就可以提交你所设置的权限。
					    
					  </form>
					  </div>
					 </div>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>
