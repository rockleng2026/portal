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
    
    <title>My JSP 'addFunction.jsp' starting page</title>
    
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
	<c:if test="${empty info}">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="selectFunctionsSystem.do?funid=103">模块列表</a>&nbsp;>&nbsp;新增模块功能
	</c:if>
	<c:if test="${not empty info}">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;<a href="selectFunctionsSystem.do?funid=103">模块列表</a>&nbsp;>&nbsp;修改模块功能
	</c:if>
		
	</font></div>

		<div class="conSet">
			<table width="600" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						模块名称
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="hidden" name="superId" id="superId" value="0">
							<div style="display:inline;"><input type="text" name="linkFunctionName" id="linkFunctionName" value="${info.linkFunctionName}" onblur="checkFunctions()"/></div>
							<c:if test="${not empty functionid}">
								<input type="hidden" name="functionid" id="functionid" value="${functionid}"/>
							</c:if>					
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="linkFunctionNameMsg" color=#ff0000></FONT></div>
					</td>
				</tr>
				
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						模块功能链接
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<div style="display:inline;"><input type="text" name="linkFunctionPage" id="linkFunctionPage" value="${info.linkFunctionPage}" onblur="checkFunctions()"/></div>
							<div style="display:inline;">&nbsp;<FONT color=#ff0000>*</FONT><FONT id="linkFunctionPageMsg" color=#ff0000></FONT></div>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						模块功能链接图标
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="text" name="imagepath" id="imagepath" value="${info.imagepath}"/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						模块功能描述
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<textarea rows="4" cols="50" name="description" id="description">${info.description}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"  nowrap style="width: 450px" class="bg1">
						<c:if test="${empty info}">
							<input type="button" value="提交" onclick="addMenuFunctions()"/>
						</c:if>
						<c:if test="${not empty info}">
							<input type="button" value="修改" onclick="editFunctionSystem()"/>						
						</c:if>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
		<script type="text/javascript">
			function checkFunctions()
			{
				var linkfunctionname = $("#linkFunctionName").val();
				var linkfunctionpage = $("#linkFunctionPage").val();
				
				if(linkfunctionname=="")
				{
					$("#linkFunctionNameMsg").html("该项不能为空");
					document.getElementById("linkFunctionName").focus();
				}
				else if(linkfunctionpage=="")
				{
					$("#linkFunctionPageMsg").html("该项不能为空");
					document.getElementById("linkFunctionPage").focus();
				}
				else
				{
					$("#linkFunctionNameMsg").html("");
					$("#linkFunctionPageMsg").html("");
				}
			}
		</script>
  </body>
</html>
