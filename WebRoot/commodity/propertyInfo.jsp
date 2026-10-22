<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'propertyInfo.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<base href="<%=basePath%>">
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/handlejson.js"></script>
		<LINK href="<%=request.getContextPath()%>/Css/style.css"
			type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

	</head>

	<body>

		<form id="form1" name="form1" method="post" action="">
			<table class="toptable grid" cellSpacing=1 cellPadding=4 border=1>
				<tr>
					<td width="100%" colspan="5" background="images/r_0.gif"
						style="font-size: 12px;">
						商品配置属性信息
					</td>
				</tr>
				<tr>
					<td width="20%" height=30 align=center>
						商品类型
					</td>
					<td width="20%" height=30 align=center>
						temp1
					</td>
					<td width="20%" height=30 align=center>
						temp2
					</td>
					<td width="20%" height=30 align=center>
						temp3
					</td>
					<td width="20%" height=30 align=center>
						时间
					</td>
				</tr>
				<c:forEach items="${pages.pageList}" var="data">
					<tr>
						<td class="category" width="20%" height=30 align=center>
							${data.model.name}
						</td>
						<td class="category" width="20%" height=30 align=center>
							${data.temp1 }
						</td>
						<td class="category" width="20%" height=30 align=center>
							${data.temp2 }
						</td>
						<td class="category" width="20%" height=30 align=center>
							${data.temp3 }
						</td>
						<td class="category" width="20%" height=30 align=center>
							${data.time }
						</td>
					</tr>
				</c:forEach>
			</TABLE>


		</form>
	</body>
</html>
