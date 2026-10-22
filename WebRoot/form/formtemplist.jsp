<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>单据模板列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/style_s.css">
  </head>
<body>
	<div class="con" >
		<div class="righter">
			<div class="main_leirong_title" style="width:90.5%;">单据模板列表</div>
			<div class="line">
				<form action="selectonetempFormTempAction.do" method="post">
					<div class="ziduan_ming" style="width:15%; margin-left:10%;">请输入查找模板：</div>
					<div class="ziduan_ming_leirong">
						<input id="namestr" name="namestr" type="text" />
					</div>
					<div class="ziduan_ming_leirong">
						<input type="submit"  value="搜索" />
					</div>
				</form>  
			</div>
			<div class="line">
				<div class="ziduan_ming bill_list_linecs" style="width:40%; height:23px;">单据模板名称</div>
				<div class="ziduan_ming bill_list_linecs" style="height:23px;">创建时间</div>
				<div class="ziduan_ming bill_list_linecs" style="height:23px;">创建员工</div>
				<div class="ziduan_ming bill_list_linecs" style="height:23px;">操作</div>
			</div>
			<c:forEach items="${pages.pageList }" var="data" varStatus="sid" >
			<div class="line">			
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>" style="width:40%;">${data.typeName }</div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>">${data.time }</div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>">${data.employee.name }</div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>" style="padding-top:1px;">
					<a title="看查详细信息/添加详细单据" href="selectoneFormTempAction.do?id=${data.id }"><img src="img/btn_open.jpg" /></a>&nbsp;
					<a title="编辑模板" href="editshowFormTempAction.do?id=${data.id }"><img src="img/btn_update.jpg" /></a>&nbsp;
					<a title="删除模板" href="delruanFormTempAction.do?id=${data.id }"><img src="img/btn_delete.jpg" /></a>
				</div>
			</div>
			</c:forEach>
			<div class="line">
				<div class="anpager" style=" text-align:center; margin-top: 20px;">	
				<p:pages url="selectmoreFormTempAction.do"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
