<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<title>Insert title here</title>
<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<base target="_self">
<script type="text/javascript">
	$(document).ready(function(){
		var url = "selectcommodityTpye.do";//url地址
		$.post(url,{
			},function(data){
					 $("#typea").append($.trim(data));
			});
	});
	</script>
</head>

<body>
<form action="" >
<table align="left">
 	<select id="typea"  name='typea' onchange='getModel("a")'  >
	</select>
			<br/>		<br/>				
	<select id="modela" name="modela"  >
	</select>	
	<br/><br/>
	<input id="importprice" readonly="readonly"/>
	<br/><br/>
	<input type="button" class="button" value="计算" onclick="enumPrice()" >
	<br/><br/>
	<input value="确定" class="button" type="button" onclick="closeP()"/>
	</table>
</form>
</body>
</html>