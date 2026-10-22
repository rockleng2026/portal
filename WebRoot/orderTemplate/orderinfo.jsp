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
			<tr align="center" >
				<td colspan="4">
					<h4>订单编号：</h4>
				</td>
			</tr>
			<tr >
				<td width="30%" align="right">订单类型：</td><td width="20%" align="left">aaaaa</td>
				<td width="30%" align="right">审核状态：</td><td width="20%" align="left">bbbbb</td>
			</tr>
			<tr >
				<td align="right">客户：</td><td align="left">aaaaa</td>
				<td align="right">负责员工：</td><td align="left">bbbbb</td>
			</tr>
			<tr >
				<td align="right">开始时间：</td><td align="left">aaaaa</td>
				<td align="right">结束时间：</td><td align="left">bbbbb</td>
			</tr>
			<tr >
				<td align="right">原价：</td><td align="left">aaaaa</td>
				<td align="right">实际价格：</td><td align="left">bbbbb</td>
			</tr>
			<tr >
				<td align="right">付费状态：</td><td align="left">aaaaa</td>
				<td align="right">付费类型：</td><td  align="left">bbbbb</td>
			</tr>
			<tr>
				<td align="center" colspan="4" >
					备注:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table>
						<tr>
							<td>
								套餐
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table>
						<tr>
							<td>
								产品
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<table>
						<tr>
							<td>
								其他玩意
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</body>
</html>