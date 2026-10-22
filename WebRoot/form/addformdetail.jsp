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
    <title>添加详细单据</title>
    <!-- saved from url=(0014)about:internet -->   
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
	<div class="con" >
		<div class="righter">
			<div class="main_leirong_title" style="width:90.5%;">添加单据详细</div>
			<div class="line">
				<form action="readaddFormDetailAction.do" method="post">
					<div class="ziduan_ming" style="width:15%; margin-left:10%;">请选择模板：</div>
					<div class="ziduan_ming_leirong" style=" width:15%;">
						<s:select id="id" name="id" cssClass="category" 
						   list="#request.formtemplist" listKey="id" listValue="typeName" 
						   value="%{'',#request.id}">
						</s:select>
					</div>
					<div class="ziduan_ming_leirong">
						<input name="" type="submit" value="点击查寻"/>
					</div>
				</form>
			</div>
			<div style=" float: left; clear: both; width:90%;"><br><hr>
			</div>
			<c:if test="${showflag=='yes'}">
				<div class="line" style=" float: left; clear: both; width:90%; "><br>
					<h3 align="center">
						${formtemp.typeName }
					</h3>
					<hr>
				</div>
				<div class="line" style="  float: left; clear:both;">
					<form action="addFormDetailAction.do" method="post">
					 	<div style="float:left; margin-left: 88px; width:100%">
							<input type="hidden" id="formtempid" name="formtempid" value="${formtemp.id }"/>
					     	 ${formtemp.code }
					      	<br>
					      	<input type="hidden" id="temp" name="temp" value="" />
					    </div>
					    <div style=" margin-left: 88px; clear:both;">
					    	<br>
					    	<input type="submit" value="提交"  onclick="return ComPang()">&nbsp;&nbsp;&nbsp;&nbsp;
					    	<input type="reset" value="重置"/>
					    </div>
					</form>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>