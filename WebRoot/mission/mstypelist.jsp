<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>所有类型列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		
</head>
<body onload="setdivwidth()">
	<jsp:include page="/common/loading.jsp"></jsp:include>
	<div id="resulthight">
	<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
		<tr >
			<th>
				序号
			</th>
			<th>
				类型名称
			</th>
			<th>
				类型描述
			</th>
			<th>
				类型添加时间
			</th>
		</tr>
	　　<c:forEach items="${list}" var="missiontype" varStatus="count">
			<tr align="center">
				<td>${count.count }</td>
				<td>${missiontype.name }</td>
				<td>${missiontype.describes }</td>
				<td>${missiontype.buildTime }</td>				
			</tr>
		</c:forEach>
		<tr>
			<td colspan="4" align="center">
				<button onclick="javascript:history.go(-1)"><span class="icon_back">返回</span></button>
			</td>
		</tr>
	</table>
	</div>
</BODY>
</HTML>
