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
		产品列表
		</td>
	
		<td width="50%" align="right">
		<a href="<%=request.getContextPath() %>/orderTemplate/addProducts.jsp">增加产品</a>
		</td>
	</tr>
</table>

	<table bgcolor="#cccccc" width="100%">
	
		<tr>
			<td width="20%">编号</td>
			<td width="20%">产品名称</td>
			<td width="20%">详细信息</td>
			<td width="20%">修改</td>
			<td width="20%">删除</td>
		</tr>
		<!-- 
		<c:forEach items="${pages.pageList}" var="data"  varStatus="state">
		<tr>
			<td width="20%">${state.index+1}</td>
			<td width="20%">${data.name}</td>
			<td width="20%"><a href="#">详细信息</a></td>
			<td width="20%"><a href="#">修改</a></td>
			<td width="20%"><a href="#" onclick="del(${data.id})">删除</a></td>
		</tr>
		</c:forEach>
		 -->
		 <tr>
			<td width="20%">1</td>
			<td width="20%">CDN产品</td>
			<td width="20%"><a href="<%=request.getContextPath() %>/orderTemplate/productsinfo.jsp">详细信息</a></td>
			<td width="20%"><a href="<%=request.getContextPath() %>/orderTemplate/updateProducts.jsp">修改</a></td>
			<td width="20%"><a href="#" onclick="del()" >删除</a></td>
		</tr>
	</table>	
</body>
	<SCRIPT type="text/javascript">
		function del(id)
		{
			var url="";
				$.post(url,{id:id},function(data){
				if(data==1)
				{
					alert("删除成功！！！");
					window.location.href='<%=request.getContextPath() %>/AdddanjuSale.do';
				}
				else
				{
					alert("删除失败！！！");
				}
			});
		}
	</SCRIPT>
</html>
