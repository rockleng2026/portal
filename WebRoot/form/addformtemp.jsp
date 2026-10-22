<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加/修改单据模板</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/style_s.css">
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/juqery/lib/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/juqery/lib/jquery.form.js"></script>
	<script type="text/javascript" src="js/validators.js" ></script>
	<script type="text/javascript" src="js/handlejson.js" ></script>
	<script type="text/javascript">
var billcount=0;
function checknum()
{
	var ss=document.getElementById('temps').getElementsByTagName('div').length;
	billcount=ss;
}
function Reset()
{
    var f=document.forms[0];alert(f.id);
    f.reset();
}
function getDiv1()
{
   var newdiv1=document.createElement("div");
   newdiv1.style.backgroundColor="#ffffff";
   newdiv1.className="ziduan_ming billziduan";
   return newdiv1;
}
function addProElement() 
{
    var tem=document.getElementById('temps');
    billcount++;
    newdiv1=getDiv1();
	newdiv1.innerHTML='temp'+billcount+'&nbsp;&nbsp;&nbsp;&nbsp;<input name="temp'+billcount+'" id ="temp'+billcount+'"/>';
	tem.appendChild(newdiv1);
 }
function CancelTr()
{   
	var tem=document.getElementById('temps');
	if(tem.hasChildNodes())
	{
		tem.removeChild(tem.lastChild);
		billcount--;
	}
 }
 function ComPang()
 {
	var temp="";
	for(var i=1;i<billcount;i++)
	{
		temp+=document.getElementById("temp"+i).value+"#";
	}
	temp+=document.getElementById("temp"+i).value;
	document.getElementById("temp").value=temp;
 }
</script>
</head>
<body onload="checknum()">
	<div class="con">
		<form  id ="form1" name=form1 action="
		<c:if test="${empty temp}">addFormTempAction.do</c:if>
		<c:if test="${!empty temp}">editupdateFormTempAction.do</c:if>
		" method="post" >
		<div class="righter">
			<div class="main_leirong_title">
			<c:if test="${empty temp}">添加单据模板(*表示必填字段)</c:if>
			<c:if test="${!empty temp}">修改单据模板(*表示必填字段)</c:if>
			</div>
			<div class="line">
				<div class="ziduan_ming"><font color="#FF0000">*</font>模板名称：</div>
				<div class="ziduan_ming_leirong">
					<input id="typeName" name="typeName" type="text" value="${temp.typeName }"/>
					<c:if test="${!empty temp}">
						<input id="id" name="id" type="hidden" value="${temp.id }"/>
						<input id="time" name="time" type="hidden" value="${temp.time }"/>
						<input id="employee" name="employee.id" type="hidden" value="${temp.employee.id }"/>
						<input id="delflag" name="delflag" type="hidden" value="${temp.delflag }"/>	
					</c:if>			
				</div>
			</div>
			<div class="line">
				<br>
				<div class="ziduan_ming" style="width:15%;">请选择审核类型：</div>
				 <c:if test="${!empty temp}">
				 <div class="ziduan_ming" style="width:15%;">
				 	<input type="hidden" id="oldmark" name="oldmark" value="${temp.mark }" />
				 	默认选择：${TName }
				 	</div>
				 </c:if>
				<div class="ziduan_ming_leirong" style=" width:15%;">
					<s:select id="mark" name="mark" cssClass="category" 
					   list="#request.doclist" listKey="mark" listValue="aname" headerKey="__" headerValue="请选择："  
					   value="%{'',#request.docmark.mark}">
					</s:select>
				</div>
				<div class="ziduan_ming" style=" width:200px;">
					<a href="form/adddocmark.jsp">没有您要的审核类型？</a>
				</div>
				<br>
			</div>
			<br>
			<div class="line" style="margin-top: 30px;">
				<div class="ziduan_ming" style="height:450px; padding-top:190px;"><font color="#FF0000">*</font>HTML代码：</div>
				<div class="ziduan_ming_leirong" style="width:75%; height:500px;">
					<FCK:editor width="800px;"   inputName="code" instanceName="code" height="600px;">
						<jsp:attribute name="value" >${temp.code }</jsp:attribute>
					</FCK:editor> 
				</div>
			</div>
			<div class="ziduan_title">字段类型</div>
			<div class="line">
				<div class="ziduan_ming" style=" text-align:center;">字段</div>
				<div class="ziduan_ming" style="text-align:left;padding-left:50px;">属性值</div>
			</div>
			<div class="line" id="temps" >
				<c:if test="${!empty temp}">
					${pingstr }
				</c:if>
				<input type="hidden" id="temp" name="temp" value="" />
			</div>
			<div class="line" style=" float: left; padding-left:5%; width:90%;">
				<input name="" type="button" value="添加字段" onclick="addProElement();"/>&nbsp;
				<input name="" type="button" value="删除字段" onclick="CancelTr();"/>
			</div>
			<div class="line" style=" float: left; text-align:center; margin-top:5px; clear:both;">
				<c:if test="${empty temp}"><INPUT  class=button type=submit value=" 确认添加 " onclick="return ComPang()"></c:if>
				<c:if test="${!empty temp}"><INPUT  class=button type=submit value=" 确认修改 "  onclick="return ComPang()"></c:if>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input  type="reset" value="重置" />
			</div>
			<div class="line" style=" height:20px;"></div>
		</div>
		</form>
	</div>
</body>
</html>
