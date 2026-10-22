<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>读取消息</title>

</head>
<body onload="pload()">
<script type="text/javascript">
function pload()
{
	var obj=window.dialogArguments; 
	
	document.getElementById("aa").innerHTML=obj.name;
}

</script>
<table>
<tr>
<td><div id="aa"></div></td>
</tr>
</table>

</body>
</html>