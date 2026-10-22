<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
		<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" charset="gbk"></script>	
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
	</head>

	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="userListSystem.do?mark=employee">用户列表</a>&nbsp;>&nbsp;新增员工账户
	</font></div>
		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						登录名：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
					<c:if test="${empty object}">
							<div style="display:inline;">&nbsp; 
							<s:select id="userName" name="userName" onchange="loginName()" list="#request.emplist" listKey="id" listValue="name" headerValue="请选择用户!!" headerKey="-1"></s:select>
							</div>	
							</c:if>
							<c:if test="${not empty object}">
								<input name="userName1" id="userName1" value="${object}" readonly="readonly" style="color: gray"/>
								<input name="userName" id="userName" value="${object}" type="hidden"/>
							</c:if>
							
					
							<div style="display:inline;">&nbsp;
							<c:if test="${empty userskip}">
								<input type="text" name="loginName" id="loginName" value="用户的工号" readonly="readonly" onblur="checkValueByRules('loginName','','loginNameMsg')"/>
							</c:if>
							<c:if test="${not empty userskip}">
								<input type="text" name="loginName" id="loginName" value="${userskip.loginName}" readonly="readonly" style="color: gray" />
							</c:if>
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
					<td align="center" nowrap style="width: 150px" class="bg1">
						角色：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1" >
						<div style="display:inline;">
						<select name="roleId" id="roleId"  onblur="checkValueByRules('roleId','','roleIdMsg')">
							<c:if test="${empty userskip}">
								<option value="">请选择</option>
							</c:if>
							<c:forEach items="${rolelist}" var="data">
							<c:if test="${data.roleId==userskip.roles.roleId}">
								<option value="${data.roleId }" selected="selected">${data.roleName }</option>
							</c:if>
							<c:if test="${data.roleId!=userskip.roles.roleId}">
								<option value="${data.roleId }">${data.roleName }</option>
							</c:if>
							</c:forEach>
						</select>
						</div>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="roleIdMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<c:if test="${not empty grouplist}">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						组：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1" >
						<s:select onblur="checkValueByRules('grouplistname','','grouplistnameMsg')" id="grouplistname" name="grouplistname" list="#request.grouplist" listKey="groupId" listValue="groupName" headerValue="请选择" headerKey="" onchange="selectGroupPermission()"></s:select>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="grouplistnameMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						组权限角色：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1" >
						<select onchange="show()" onblur="checkValueByRules('groupPermission','','groupPermissionMsg')" id="groupPermission" name="groupPermission">
								<option value="">请选择</option>
							</select>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="groupPermissionMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<tr id="res" style="display: none;">
					<td align="center" nowrap style="width: 150px" class="bg1">
						组角色访问资源权限：
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1" >
						<c:forEach items="${infolist}" var="info" varStatus="state">
							&nbsp;<input type="checkbox" id="resourceSet" name="resourceSet" value="${info.functionId }" />${info.linkFunctionName }&nbsp;
							<c:if test="${(state.index+1)%3==0}"><br/></c:if>
						</c:forEach>
						<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="groupPermissionMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				<tr>
					<td  colspan="2" align="center"  class="bg1">
						<FONT color=#ff0000>注：只有组权限角色为主管级别以上的才需要配置访问资源权限</FONT>
					</td>
					
				</tr>
				</c:if>
				<tr>
					<td colspan="2" align="left" nowrap style="width: 450px" class="bg1">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${empty userskip}">
							<input type="hidden" value="0" id="userid" name="userid"/>
							<input type="button" value="提交" onclick="saveOrUpdateUser()"/>
							<input type="reset" value="重置" />
						</c:if>
						<c:if test="${not empty userskip}">
							<input type="hidden" value="${userskip.userId}" id="userid" name="userid"/>
							<input type="button" value="修改" onclick="saveOrUpdateUser()"/>
							<input type="reset" value="重置" />
						</c:if>
					</td>
				</tr>
			</table>
		</div>
<script type="text/javascript">	
	function saveOrUpdateUser() {
		var userid = $("#userid").val();
		var loginName = encodeURI($("#loginName").val());
		var password = $("#password").val();
		var repassword = $("#repassword").val();
		var userName = encodeURI($("#userName").val());
		var roleId = $("#roleId").val();
		var mark = "employee";
		var grouplistname = $("#grouplistname").val();
		var groupPermission = $("#groupPermission").val();
		var resourceSet = "";
		
		$("input[name='resourceSet'][checked]").each(function(){
				resourceSet += $(this).val()+",";
		});
	
		if(!addValidators())
		{
			return false;
		}
		else if(password =='')
		{
			$("#passwordMsg").html("该项不能为空 ！");
			document.getElementById("password").focus();
			return;
		}
		else if(repassword!=password)
		{
			$("#repasswordMsg").html("您输入的密码不一致，请重新输入");
			document.getElementById("repassword").focus();
			return;
		}
		else if(userName == -1)
		{
			alert("没有该类型下的用户，请先添加该类型下的用户，程序将终止执行该操作。谢谢！");
			return ;
		}
		else if(groupPermission == -1)
		{
			alert("没有该组下的成员，请先添加该组下的成员，程序将终止执行该操作。谢谢！");
			return ;
		}
		else
		{
			 var url = "addOrUpdateUserSystem.do";
			$.post(url,{userid:userid,loginName:loginName,password:password,userName:userName,roleId:roleId,mark:mark,grouplistname:grouplistname,groupPermission:groupPermission,resourcePermission:resourceSet},function(data){
				if(data=="1")
				{
					alert("新增用户成功");
					window.location.href="userListSystem.do?mark="+mark;
				}
				else if(data=="2")
				{
					alert("修改用户成功");
					window.location.href="userListSystem.do?mark="+mark;
				}
				else
				{
					alert("操作失败");
					return ;
				}
			});
		}
	}
	//员工或者客户的集合
	function selectEmp()
	{
		var select =document.getElementById("userName"); 
		while(select.options.length) 
		{ 
			select.options.remove(0); 
		}
		
		var usertype = "empyolee";
		var url = "selectEmpOrCustSystem.do";
		$.post(url,{usertype:usertype},function(data){
			$("#userName").append(data);
		});
	}
	//组成员集合
	function selectGroupPermission()
	{
		$("#res").hide();
		var select =document.getElementById("groupPermission"); 
		while(select.options.length) 
		{ 
			select.options.remove(0); 
		}
		var group = $("#grouplistname").val();
	
		var url = "selectGroupPermissionSystem.do";
		$.post(url,{groupid:group},function(data){
			$("#groupPermission").append(data);
		});
	}
	
	function show()
	{
		var text = $("#groupPermission>option:selected").get(0).text;
		if(text.indexOf("成员")==-1)
		{
			$("#res").show();
		}
		else
		{
			$("#res").hide();
		}
	}	
	function loginName()
	{
		var userId=document.getElementById("userName").value;
		var url="loginNameSystem.do?tt="+(new Date()).getTime();
		$.post(url,{userId:userId},function(data){
		    alert(111);
			alert(data);
			$("#loginName").val(data);
		});
	}
	
		</script>
	</body>
</html>
