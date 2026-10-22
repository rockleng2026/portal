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
<script type="text/javascript">
function addSale(){
	var saleName=document.getElementById("saleName").value;
	if(saleName==null|| saleName=="")
	{
		alert("单据名称不能为空！！！");
		return false;
	}
}
</script>

</head>
<body>
<FORM name="" action="updateOrderType.do" method="post" onsubmit="return addSale()">
	<table>
		<tr>
			<td colspan="2" >
				修改单据类型
			</td>
		</tr>
		<tr>
			<td style="width: 150px" align="right">
				单据名称
			</td>
			<td style="width: 450px" align="left">
				<input id="name" name="name" type="text" value="${data.name}"/>
				<input id="id" name="id" type="hidden" value="${data.id}"/>
			</td>
		</tr>
		
		<tr>
			<td style="width: 150px" align="right">
			备注
			</td>
			<td style="width:450px" align="left">
			<textarea rows="4" cols="50" name="temp1" id="temp1">${data.temp1}</textarea>
				
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><INPUT class=button type=submit value="确认添加 "><INPUT class=button type=reset value=" 重置 "></td>
		</tr>
	</table>
	</FORM>
</body>
</html>