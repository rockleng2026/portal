<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>任务完成反馈信息</title>
<script type="text/javascript">
/****************14015*******************/
function pload()
{
	var obj  = window.dialogArguments;
	document.getElementById("description").innerHTML = obj.name;
	//alert(obj.name);
	//var oEditor = FCKeditorAPI.GetInstance("description") ; 
    //oEditor.SetHTML(obj.name,false) ; 
    //var getX = oEditor.GetXHTML();
    //alert(getX);    
   	//oEditor.InsertHtml('<p>dd</p>');
}
</script>
</head>
<body onload="pload()">
<table>
<tr>
<td>
<!--<FCK:editor width="700px;" inputName="description" instanceName="description" height="300px;">
	<jsp:attribute name="value" >${data.description}</jsp:attribute>
</FCK:editor>

	--><!--<input type="text" value="${data.description }" height="200px;"/>-->
	<!--<textarea id="description" rows="12" cols="50">${data.description }</textarea>-->
		<h2>任务完成反馈描述</h2>
		<hr/>
		<div id="description">${data.description }</div>
	
</td>
</tr>
</table>

</body>
</html>