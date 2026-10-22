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

		<table style="MARGIN-TOP: 8px" width="100%" bgcolor="#cccccc" >
			<tr><td colspan="4" align="center"><h3>添加订单</h3></td></tr>
			<tr>
				<td width="20%" align="right">
					订单类型：
				</td>
				<td width="30%" align="left">
					<select>
						<option>aaaa</option>
						<option>aaaa</option>
						<option>aaaa</option>
					</select>
				</td>
				<td width="20%" align="right">
					套餐：
				</td>
				<td width="30%" align="left">
					<select>
						<option>bbbb</option>
						<option>bbbb</option>
						<option>bbbb</option>
					</select>
				</td>
			</tr>
				<tr>
				<td align="right">
					付费类型：	
				</td>
				<td align="left">
					<select>
						<option>dddd</option>
						<option>dddd</option>
						<option>dddd</option>
					</select>
				</td>
				<td align="right">
					备注：	
				</td>
				<td align="left" >
					<textarea style= "height:60px "  id="messagecontent" name="messagecontent"  ></textarea>
				</td>
			</tr>
		</table>
</body>
</html>