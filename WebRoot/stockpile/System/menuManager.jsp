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
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" charset="gbk"></script>	
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
		<script type="text/javascript" src="js/system.js" charset="gbk"></script>
		
	</head>
	
	<script type="text/javascript">
		window.onload = function (){
			$("#showOrHiddenDiv1").show();
		}
		function showDiv(functionid)
		{
			var functionid = functionid;
			var id = $("#showOrHiddenDiv"+functionid);
			for(var i=1;i<=1000;i++)
			{
				if(i==functionid)
				{
					id.show();	
				}
				else
				{
					$("#showOrHiddenDiv"+i).hide();
					$("#addmenu").hide();
				}
			}
			
		}
		
		function showaddMenu()
		{
			
			var id = $("#addmenu");
			
			var check = $("input[@name='menuname'][@checked]").val();
			if(typeof(check)=="undefined")
			{
				alert("请选择菜单项");
				return ;
			}
			
			var value = $("input[@name='menuname'][@checked]").val();
			var array = value.split(",");
			$("#superName").attr("value",array[0]);
			$("#superId").attr("value",array[1]);
			id.show();
		}
		
		function divhide()
		{
			$("#addmenu").hide();
		}
		
		function delMenusByIds()
		{
			var value = $("input[@name='menuname'][@checked]").val();
			if(typeof(value)=="undefined")
			{
				alert("您还没有选择菜单项");
				return ;
			}
			var array = value.split(",");
			var id = array[1];
			var sid = array[2];
			
			if(sid==0)
			{
				alert("模块不能被删除");
				return ;
			}
			var str = window.confirm("你确定要删除该菜单项？");
			if(str==true)
			{
				var url = "delfuntionMenu.do";
				
				$.post(url,{functionid:id},function(data){
					if(data>0)
					{
						alert("删除菜单项成功");
						window.location.href="menuManagerMenu.do?funid=104";
					}
					else
					{
						alert("删除菜单项失败");
						return  ;
					}
				});
			}
		}
		
		function editMenusByIds()
		{
			
			var value = $("input[@name='menuname'][@checked]").val();
			if(typeof(value)=="undefined")
			{
				alert("您还没有选择菜单项");
				return ;
			}
			var array = value.split(",");
			var id = array[1];
			var sid = array[2];
			if(sid==0)
			{
				alert("模块不能被修改");
				return ;
			}
			else
			{
				window.location.href="editmenuFunctionMenu.do?functionid="+id;
			}
			
		}
	</script>
	<body>
		<div class="currentlySet">
			<font size="2">
				当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;菜单管理 </font>
		</div>
	<p>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		<font size="1" color="blue">
			<c:forEach items="${superfunctionlist}" var="head">	&nbsp;<a href="javascript:void(0)" onclick="showDiv('${head.functionId}')">${head.linkFunctionName}</a>&nbsp;</c:forEach> 
		</font>
	</p>

<c:forEach items="${superfunctionlist}" var="dataindex">
		<div id="showOrHiddenDiv${dataindex.functionId}" style="display:none; float: left; width: 300px;">
			<div class="conSet">
				<table width="300px;" border="0" align="left" cellpadding="3"
					cellspacing="1" class="space tableBg">
					<tr>
						<td align="center" nowrap style="width: 150px" class="bg1">
							<font size="2px;" color="blue">
							<c:forEach items="${option}" var="op">
								<c:if test="${op.key==1}">
								<a href="javascript:showaddMenu()">新增</a> 
								</c:if>
								<c:if test="${op.key==2}">
								<a href="javascript:editMenusByIds()" > 修改 </a>
								</c:if>
								<c:if test="${op.key==3}">
								<a href="javascript:delMenusByIds()" >删除 </a>
								</c:if>
								<c:if test="${op.key==4}">
								<a href="javascript:void(0)" > 查询 </a>  
								</c:if>
							</c:forEach>
							    </font>
						</td>
					</tr>
					<c:forEach items="${superfunctionlist}" var="superdata">
						<c:if test="${superdata.functionId==dataindex.functionId}">
						<tr>
							<td align="left" nowrap class="bg0">
							<input type="radio" name="menuname" id="menuname" value="${superdata.linkFunctionName },${superdata.functionId},${superdata.superId}" onclick="divhide()">
							 <font size="4px;" color="#3366CC"> ${superdata.linkFunctionName }</font>
							</td>
						</tr>
						<c:forEach items="${funcntionlist}" var="data">
							<c:if test="${data.superId==superdata.functionId}">
								<tr>
									<td align="left" nowrap class="bg0">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="menuname" id="menuname" value="${data.linkFunctionName },${data.functionId},${data.superId}" onclick="divhide()">
										<font size="2.5px;" color="#CC9900">  ${data.linkFunctionName	}</font>
									</td>
								</tr>
								<c:forEach items="${funcntionlist}" var="data1">
									<c:if test="${data1.superId==data.functionId}">
										<tr>
											<td align="left" nowrap class="bg0">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" name="menuname" id="menuname" value="${data1.linkFunctionName },${data1.functionId},${data1.superId}" onclick="divhide()">
												   ${data1.linkFunctionName }
											</td>
										</tr>
										<c:forEach items="${funcntionlist}" var="data2">
											<c:if test="${data2.superId==data1.functionId}">
												<tr>
													<td align="left" nowrap class="bg0">
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<input type="radio" name="menuname" id="menuname" value="${data2.linkFunctionName },${data2.functionId},${data2.superId}">
														  ${data2.linkFunctionName }
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>		
</c:forEach>
		
		<div class="conSet" id="addmenu" style="display:none; float:right;width=900px; ">
			<table width="900px;" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能名称
					</td>
					<td align="left" nowrap style="width: 300px" class="bg1">
							<input type="text" name="linkFunctionName" id="linkFunctionName" value=""  onblur="checkValueByRules('linkFunctionName','','linkFunctionNameMsg')"/>
							&nbsp;<FONT color=#ff0000>*</FONT><FONT id="linkFunctionNameMsg" color=#ff0000></FONT>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						所属父级菜单
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						<input type="text" name="superName" id="superName" value="" readonly="readonly"/>
						<input type="hidden" name="superId" id="superId" value=""/>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能链接
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="text" name="linkFunctionPage" id="linkFunctionPage" value=""/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能链接图标
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<input type="text" name="imagepath" id="imagepath" value=""/>					
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						菜单功能描述
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
							<textarea rows="4" cols="50" name="description" id="description"></textarea>
					</td>
				</tr>
				<tr>
					<td align="center" nowrap style="width: 150px" class="bg1">
						判断录入系统版本
					</td>
					<td align="left" nowrap style="width: 450px" class="bg1">
							<input type="radio" name="versionFlag" value="2" <c:if test="${info.versionFlag ==2 }">checked</c:if>>新的
							<input type="radio" name="versionFlag" value="1" <c:if test="${info.versionFlag ==1 }">checked</c:if>>旧的
							&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>*</FONT><FONT id="versionFlagMsg" color=#ff0000></FONT>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="提交" onclick="addMenuFunctions()"/>
						<input type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
