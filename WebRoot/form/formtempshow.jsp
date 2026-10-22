<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>单据模板显示/添加详细单据</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/style_s.css">
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	 function ComPang()
	 {
		var temp="";
		for(var i=1;;i++)
		{
			var ss=document.getElementById("temp"+i).value;
			if(ss!=null)
			{
				temp+=ss+"#";
				document.getElementById("temp").value=temp;
			}
			else {
				document.getElementById("temp").value=temp;
				break;
			}
		}
	 }
	</script>
  </head>
<body>
	<div class="con" style=" margin-left: 100px; float: left">
		<div class="righter"  style="width:100%">
			<div class="main_leirong_title" style="width:90.5%;">单据模板显示/添加详细单据</div>
			<div class="line" style="width:80%">
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%; height:23px;">单据模板名称</div>
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%;height:23px;">创建时间</div>
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%;height:23px;">创建员工</div>
			</div>
			<div class="line"  style="width:80%">
			<hr>
			</div>
			<div class="line"  style="width:80%">				
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%;">${formtemp.typeName }</div>
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%;">${formtemp.time }</div>
				<div class="ziduan_ming_leirong bill_list_linecs linecolor" style="width:15%;">${formtemp.employee.name }</div>
			</div>
			<div style="float: left; margin-left: 88px; width:80%;">
				<br>
				<form action="selectformmoreFormDetailAction.do?id=${formtemp.id }" method="post">	
					<input type="submit" value="查看该单据下的所有详细单据"/>
				</form>
			</div><br>
			<div style="float: left; clear: both; width:80%;">
			<br/><hr><br/>
			<form action="addFormDetailAction.do" method="post">
				<input type="hidden" id="formtempid" name="formtempid" value="${formtemp.id }"/>
				<div style="clear:both;">
			    ${formtemp.code }
			    </div>
			    <div style="float:left; margin-left: 88px; clear:both;">
			    	<br>
			    	<input type="hidden" id="temp" name="temp" value="" />
			    	<input type="submit" value="提交"  onclick="return ComPang()">&nbsp;&nbsp;&nbsp;&nbsp;
			    	<input type="reset" value="重置"/>
			    	<br><br><br>
			    </div>
			</form>
			</div>
		</div>
	</div>
</body>
</html>