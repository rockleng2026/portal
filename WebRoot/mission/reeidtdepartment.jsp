<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="x-ua-compatible" content="ie=7" />

<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/validators.js"></script>
<link type="text/css" rel="stylesheet"
	href="<%=basePath%>Css/missionuse.css" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#sel").change(function() {
			if (confirm("确定要修改本部门的主管？") == true) {

				var val = $("#sel").find("option:selected").text();
				var a = $("#sel").val();
				if (a != 0) {
					document.getElementById("zhuguan").value = val;
				}
			}
		});
		$("#sel1").change(function() {
			if (confirm("确定要修改本部门的级别？") == true) {

				var val = $("#sel1").find("option:selected").text();
				var a = $("#sel1").val();
				if (a != 0) {
					document.getElementById("islevel").value = val;
				}
			}
		});

	});
</script>
</head>
<body>
	<div class="container" id="cpcontainer">
		<div class="itemtitle">
			<h3>福奥科技 - 添加部门(针对部门重置）</h3>
		</div>
		<table class="tb tb2 ">
			<tr>
				<th class="partition">功能提示</th>
			</tr>
			<tr>
				<td class="tipsblock" s="1">
					<ul id="tipslis">
						<li>“添加部门(针对部门重置”是针对部门重置。进行根部门的编辑</li>
						<li>这个页面将进行对一级、二级、三级、部门的初始化编辑</li>
						<li>请注意填写好页面上的信息的正确性*内容必填</li>
					</ul>
				</td>
			</tr>
		</table>
		<p class="flip" style="background: #92c0e2">&nbsp;</p>
	</div>
	<form action="resetpositionmissiontype.do" name="cpform" method="post"
		autocomplete="off" id="cpform">
		<input type="hidden" name="formhash" value="ff5905c1" /> <input
			type="hidden" id="formscrolltop" name="scrolltop" value="" /> <input
			type="hidden" name="anchor" value="" />
		<table class="tb tb2 fixpadding">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">此处填写公司根名称： </font>
			<input type="hidden" value="" />
			<tr class="header">

				<td width="200">公司名称：</td>
				<th align="left"><input type="text" id="n1" name="n1"
					value="" /></th>

				<td>部门所属级别</td>
				<th align="left"><input type="text" value="一级" /></th>
			</tr>
			<!-- 
			<tr>

				<td align="center" width="200">&nbsp;&nbsp;&nbsp;&nbsp;<font
					color="red">添加下级部门：</font></td>

				<td align="left"></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<c:set value="1" var="namenum"></c:set>

			<tr class="header">

				<td width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;二级部门名称：</td>
				<th align="left"><input type="text" id="n2" name="name2"
					value="" /></th>

				<td>部门所属级别</td>
				<th align="left"><input type="text" value="二级" /></th>
			</tr>
 			-->
		</table>
		<input type="button" class="btn" id="submit_modsubmit"
			name="modsubmit" onclick="submit1();" value="提交" />
	</form>

	<script type="text/javascript">
		function submit1() {

			if ($("#n1").val() != "" && $("#n2").val() != "") {

				if (confirm("确认提交吗？") == true) {
					$("#cpform").submit();
				}

			}
			alert("部门填写不能为空！");
		}
	</script>
</body>
</html>












