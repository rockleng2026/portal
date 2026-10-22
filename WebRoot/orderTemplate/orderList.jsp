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

		<table width="100%" bgcolor="#FFFFFF" border="1" cellpadding="0" cellspacing="0" bordercolor="#FCDDED" >
			<tr><td colspan="9" align="center"><h3>列表</h3></td></tr>
			<tr align="center">
				<td  width="15%">
					订单编号
				</td>
				<td width="15%">
					订单类型
				</td>
				<td width="15%">
					开始时间
				</td>
				<td width="15%">
					结束时间
				</td>
				<td width="10%">
					套餐
				</td>
				<td width="10%">
					付费状态
				</td>
				<td width="10%">
					审核状态
				</td>
				<td width="5%">
					详细
				</td>
				<td width="5%">
					删除
				</td>
			</tr>
			<tr align="center">
				<td width="15%">
					CDN-11122222
				</td>
				<td width="15%">
					CDN订单
				</td>
				<td width="15%">
					2010-1-2
				</td>
				<td width="15%">
					2010-9-3
				</td>
				<td width="10%">
					免费套餐 II
				</td>
				<td width="10%">
					欠费
				</td>
				<td width="10%">
					审核通过
				</td>
				<td width="5%">
					<a href="<%=request.getContextPath() %>/orderTemplate/orderinfo.jsp">详细</a>
				</td>
				<td width="5%">
					<a href="#">删除</a>
				</td>
			</tr>
		</table>
</body>
</html>