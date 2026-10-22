<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gb2312"%>
    <%@ page import="com.fuao.fajxc.util.yeepay.*" %>
    <%@ page import="java.text.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
<title>Insert title here</title>

</head>


<body >

		<table  width="100%" bgcolor="#FFFFFF" border="1" cellpadding="0" cellspacing="0" bordercolor="#FCDDED" >
			<tr align="center"><td colspan="9" ><h3>详细信息</h3></td></tr>
		
			<tr >
				<td width="30%" align="right">订单类型：</td><td width="20%" align="left">aaaaa</td>
				<td width="30%" align="right">产品类型名称：</td><td width="20%" align="left">bbbbb</td>
			</tr>
			<c:forEach items="" var="">
			<tr >
				<td width="30%" align="right">产品名称：</td><td width="20%" align="left">aaaaa</td>
				<td width="30%" align="right">单价：</td><td width="20%" align="left">bbbbb</td>
			</tr>
			</c:forEach>
		</table>
</body>
</html>