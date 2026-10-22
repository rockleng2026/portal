<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出售中的商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		
		<base target="_self">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style type="text/css">
.uu {
	width: 610px;
	margin: 0 auto;
}

img {
	border: 0
}

dl,dd,dt,p,input {
	padding: 0px;
	margin: 0px;
}

.dow {
	width: 610px;
	height: 230px;
	float: left;
	font-size: 12px
}

.dow_top {
	width: 610px;
	height: 26px;
	background: #3c8301;
	padding-left: 10px;
	float: left;
	line-height: 26px;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	overflow: hidden
}

.dow_top span {
	float: right;
	padding-right: 10px;
	padding-top: 1px;
}

.dow_top a {
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	text-decoration: none
}

.dow_nr {
	width: 615px;
	border: 1px solid #455c32;
	float: left
}

.tc_form {
	width: 610px;
	float: left;
	line-height: 23px;
}

.tc_form dd {
	width: 530px;
	float: left;
	text-align: right;
}

.tc_form dt {
	width: 210px;
	float: left;
	text-align: left;
	padding-left: 10px;
}

.tc_form dt span {
	width: 50px;
	float: right
}

.tc_form dt span a {
	width: 45px;
	float: left;
	text-align: center;
	color: #FFFFFF;
	text-decoration: none;
	height: 21px;
	background: #519300;
	line-height: 21px;
}

.text {
	height: 19px;
	border: 1px solid #b2b2b2
}

.foot {
	padding-right: 15px
}

.foot a {
	height: 24px;
	padding: 5px;
	text-decoration: none;
	color: #000000
}

}
.foot a:hover {
	background: #5da500;
	color: #FFFFFF
}

.tc_top {
	background: #7b7b7b;
	color: #FFFFFF
}

.tc_footb {
	border-bottom: 1px solid #c3c3c3
}

.tc_footb a {
	text-decoration: none;
	color: #ff9002;
}

.tc_footb a:hover {
	background: #5da601;
	float: left;
	width: 100%;
	color: #FFFFFF;
	line-height: 26px;
	clear: both;
}

.tc_rightb {
	border-right: 1px solid #c3c3c3
}

.ccc {
	text-align: center;
	width: 60px;
	line-height: 20px;
	background-color: #7b7b7b;
	color: #fff;
	display: block;
	margin-left: 15px;
}

a {
	text-decoration: none
}

/*hongbinma */
ul,ul li {
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.foot1 {
	padding-right: 15px
}

.text1 {
	width: 145px;
	height: 19px;
	border: 1px solid #b2b2b2
}
</style>
<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
<script type="text/javascript">
	function onsubmitemp()
	{
		form1.action = "<%=basePath%>selectEmpsalegoods.do";
		form1.submit();
	}

	function selectEmp(id, name) {
		parent.document.getElementById('empname').value= name;
		parent.document.getElementById('empid').value= id;
		parent.document.getElementById('addrow2').style.display='none';   
	}
	function closeEmp()
	{
		parent.document.getElementById('addrow2').style.display='none';
	}
</script>
	</head>
	<body class="uu">

		<div class="dow">
			<div class="dow_top">
				<span><a href="javascript:closeEmp();">×</a>
				</span> 员工信息列表
			</div>
			<form action="" method="post" id="form1">
			<div class="dow_nr">
				<table width="100%" border="0" cellspacing="0" height="202" cellpadding="0" style="background-color: #ffffff;" style="font-size: 12px;">
					<tr style="font-size: 12px;">
						<td height="32" colspan="7" align="right">
							员工姓名
							<input name="empname" id="empname" value="${empnames}" type="text" class="text1" />
						</td>
						<td height="32" align="center">
							<a onclick="onsubmitemp();" style="CURSOR:pointer;"><span class="ccc">查询</span>
							</a>
						</td>
					</tr>
					<tr style="font-size: 12px;">
						<td width="58" height="26" align="center" class="tc_top tc_rightb">
							工号
						</td>
						<td width="80" height="26" align="center" class="tc_top tc_rightb">
							姓名
						</td>
						<td width="54" height="26" align="center" class="tc_top tc_rightb">
							性别
						</td>
						<td width="88" height="26" align="center" class="tc_top tc_rightb">
							学历
						</td>
						<td width="136" height="26" align="center"
							class="tc_top tc_rightb">
							联系电话
						</td>
						<td width="130" height="26" align="center"
							class="tc_top tc_rightb">
							部门
						</td>
						<td width="116" height="26" align="center"
							class="tc_top tc_rightb">
							职位
						</td>
						<td width="98" height="26" align="center" class="tc_top">
							操作
						</td>
					</tr>
					<c:if test="${pages != null}">
					<c:forEach items="${pages.pageList}" var="emp">
					 <tr style="font-size: 12px;">
					      <td width="58" height="26" align="center" class="tc_rightb tc_footb">${emp.empNo}</td>
					      <td width="80" height="26" align="center" class="tc_rightb tc_footb">${emp.name}</td>
					      <td width="54" height="26" align="center" class="tc_rightb tc_footb">
						  	<c:if test="${emp.sex == 1}">
						  		男
						  	</c:if>
						  	<c:if test="${emp.sex == 2}">
						  		女
						  	</c:if>    
						  </td>
					      <td width="88" height="26" align="center" class="tc_rightb tc_footb">${emp.education}</td>
					      <td width="136" height="26" align="center" class="tc_rightb tc_footb">${emp.tel}</td>
					      <td width="130" height="26" align="center" class="tc_rightb tc_footb">${emp.department.name}</td>
					      <td width="116" height="26" align="center" class="tc_rightb tc_footb">${emp.place}</td>
					      <td width="98" height="26" align="center" class="tc_footb"><a style="CURSOR:pointer;" onclick="javascript:selectEmp('${emp.id}','${emp.name}')">选择该员工</a></td>
   					 </tr>
   					 </c:forEach>
   					 </c:if>
					<tr style="font-size: 12px;">
						<td height="35" colspan="8" align="right" class="foot1">
							<p:pages url="selectEmpInfosalegoods.do"/>
						</td>
					</tr>
				</table>
			</div>
</form>
		</div>
	</body>
</html>
