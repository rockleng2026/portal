<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'customerName.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
				<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
  </head>
  
  <body>
  <form  action="litscloud/web/customerNameCustomerServerC.Action" method="post" >
  	<table>
  		<tr>
  			<td align="right">
  				客户名字
  			</td>
  			<td>
  				${customer.customerName }
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2">
  								
  			</td>
  		</tr>
  		<tr>
  			<td align="right">
  				<input type="submit"  value="提交" />
  			</td>
  			<td>
  				<input type="reset"  value="重置" />
  			</td>
  		</tr>
  	</table>
  
  </form>
  <jsp:include page="/litscloud/ucenter/uploadfile.jsp"></jsp:include>
  
  </body>
</html>
