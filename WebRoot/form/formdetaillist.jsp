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
    <title>单据详细列表</title>
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
			<div class="main_leirong_title" style="width:90.5%;">单据详细列表</div>
			<div class="line">
				<c:if test="${! empty formtemplist}">
				<form action="selectformmoreFormDetailAction.do" method="post">
				<div class="ziduan_ming" style="width:15%; margin-left:10%;">请选择模板：</div>
				<div class="ziduan_ming_leirong" style=" width:15%;">
					<s:select id="id" name="id" cssClass="category" 
					   list="#request.formtemplist" listKey="id" listValue="typeName" >
					</s:select>
				</div>
				<div class="ziduan_ming_leirong"><input name="" type="submit" value="点击查寻"/></div>
				</form>
				</c:if>
			</div>
			<div style=" float: left; clear: both; width:90%; ">
			<br><hr>
			</div>
			<c:if test="${flag=='yes'}">
				<div class="line" style=" float: left; clear: both; width:90%; ">
					<br/>
					<h3 align="center">
						${formtemp.typeName }
					</h3>
					<hr>
				</div>
				<div class="line">
					<div class="ziduan_ming bill_list_linecs" style=" height:23px;">单据编号</div>	
					<div class="ziduan_ming bill_list_linecs" style=" height:23px;">填表人</div>	
					<div class="ziduan_ming bill_list_linecs" style=" height:23px;">填单时间</div>
					<div class="ziduan_ming bill_list_linecs" style=" height:23px;">审核状态</div>	
					<div class="ziduan_ming bill_list_linecs" style=" height:23px;">操作</div>
				</div>
				<c:if test="${pages.pageList==null}">
					<div class="line">
						<br><br>
						<div  align="center">该单据中没有数据！</div>
					</div>
				</c:if>
			</c:if>
			<c:forEach items="${pages.pageList }" var="data" varStatus="sid" >
			<div class="line">			
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>">${data.orderNo }</div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>"><c:if test="${! empty data.employee}">${data.employee.name }</c:if></div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>">${data.time }</div>
				<div class="ziduan_ming bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>" style=" height:23px;">
						<c:if test="${data.audtitingFlag==0}">未审</c:if>
						<c:if test="${data.audtitingFlag==1}">审核已通过</c:if>
						<c:if test="${data.audtitingFlag==2}">审核未通过</c:if>
						<c:if test="${data.audtitingFlag==8}">正在审核中</c:if>
				</div>
				<div class="ziduan_ming_leirong bill_list_linecs <c:if test="${sid.index%2==0 }">linecolor</c:if>" style="padding-top:1px;">
					<a title="看查详细信息" href="selectoneFormDetailAction.do?id=${data.id }"><img src="img/btn_open.jpg" /></a>&nbsp;
					<c:if test="${data.audtitingFlag==0 }">
						<a title="编辑详细信息" href="editshowFormDetailAction.do?id=${data.id }"><img src="img/btn_update.jpg" /></a>&nbsp;
					</c:if>
					<a title="删除详细单据" href="delruanFormDetailAction.do?id=${data.id }"><img src="img/btn_delete.jpg" /></a>
				</div>
			</div>
			</c:forEach>
			<div class="line">
				<div class="anpager" style=" text-align:center; margin-top: 20px;">	
				<p:pages url="selectformmoreFormDetailAction.do"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>