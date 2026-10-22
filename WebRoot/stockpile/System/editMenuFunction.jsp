<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addMenuFunction.jsp' starting page</title>
    
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
	<script type="text/javascript" src="js/system.js" charset="gbk"></script>
  </head>
  
  <body>
   <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="menuManagerMenu.do?funid=104">菜单管理</a>&nbsp;>&nbsp;修改菜单功能
	</font></div>
	<div class="currentlySet" >
		修改 <font color="blue">${info.linkFunctionName} </font>菜单项
	</div>
		<div class="conSet">
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能名称
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="hidden" name="functionid" id="functionid" value="${info.functionId}">
							<input type="text" name="linkFunctionName" id="linkFunctionName" value="${info.linkFunctionName}"/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属父级菜单
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						<input type="text" name="superName" id="superName" value="${superinfo.linkFunctionName}" readonly="readonly"/>
						<input type="hidden" name="superId" id="superId" value="${superinfo.functionId}"/>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能链接
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="text" name="linkFunctionPage" id="linkFunctionPage" value="${info.linkFunctionPage}"/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能链接图标
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="text" name="imagepath" id="imagepath" value="${info.imagepath}"/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能描述
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<textarea rows="4" cols="50" name="description" id="description">${info.description}</textarea>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						判断录入系统版本
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="radio" name="versionFlag" value="<c:if test="${empty info}">2</c:if><c:if test="${info!= null}">${info.versionFlag }</c:if>" <c:if test="${info.versionFlag ==2 }">checked</c:if>>新的
							<input type="radio" name="versionFlag" value="<c:if test="${empty info}">1</c:if><c:if test="${info!= null}">${info.versionFlag }</c:if>" <c:if test="${info.versionFlag ==1 }">checked</c:if>>旧的
							&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>*</FONT><FONT id="versionFlagMsg" color=#ff0000></FONT>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="提交" onclick="editFunctions()"/>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
		
		<script type="text/javascript">
			
function editFunctions()
{
	var functionid = $("#functionid").val();
	var linkFunctionName = encodeURI($("#linkFunctionName").val());
	var superId = $("#superId").val();
	var linkFunctionPage = $("#linkFunctionPage").val();
	var imagepath = $("#imagepath").val();
	var description = encodeURI($("#description").val());
	
	var url = "updateMenu.do";
	
	$.post(url,{functionid:functionid,linkFunctionName:linkFunctionName,superId:superId,linkFunctionPage:linkFunctionPage,imagepath:imagepath,description:description},function (data){
		if(data=="2"){
			alert("修改菜单项成功");
			window.location.href="menuManagerMenu.do";
		}
		else
		{
			alert("操作菜单项失败");
			return ;
		}
	});
}
		</script>
  </body>
</html>
