<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添单据</title>

</head>
<body>
<table width="100%">
	<tr>
		<td width="50%" align="left">
		单据类型列表
		</td>
	
		<td width="50%" align="right">
		<a href="goAddOrderType.do">增加单据类型</a>
		</td>
	</tr>
</table>

	<table bgcolor="#cccccc" width="100%">
	
		<tr>
			<td width="20%">编号</td>
			<td width="20%">单据名称</td>
			<td width="20%">详细信息</td>
			<td width="20%">修改</td>
			<td width="20%">删除</td>
		</tr>
			<c:forEach items="${pages.pageList}" var="data"  varStatus="state">
		<tr>
			<td width="20%">${data.id}</td>
			<td width="20%">${data.name}</td>
			<td width="20%"><a href="goInfoOrderType.do?id=${data.id}">详细信息</a></td>
			<td width="20%"><a href="goUpdateOrderType.do?id=${data.id}">修改</a></td>
			<td width="20%"><a href="#" onclick="del(${data.id})">删除</a></td>
		</tr>
		</c:forEach>
	</table>	
</body>
	<SCRIPT type="text/javascript">
		function del(id)
		{
		alert(id);
			var url="delOrderType.do";
				$.post(url,{id:id},function(data){
				if(data==1)
				{
					alert("删除成功！！！");
					window.location.href='<%=request.getContextPath() %>/goListOrderType.do';
				}
				else
				{
					alert("删除失败！！！");
				}
			});
		}
	</SCRIPT>
</html>
