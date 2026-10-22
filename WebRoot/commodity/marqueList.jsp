<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>商品类型 型号列表页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript">

{
if($("#typeSelect").val()=="")
{
alert("请选择商品类型");
return;
}
if($("#modelSelect").val()=="")
{
alert("请选择商品型号");
return;
}
    var ral=new Array(4);
    ral[0]=$("#typeSelect").find("option:selected").val();
     ral[1]=$("#typeSelect").find("option:selected").text();
      ral[2]=$("#modelSelect").find("option:selected").val();
       ral[3]=$("#modelSelect").find("option:selected").text();
    window.returnValue = ral;
    window.close();

}
</script>
  </head>
  
  <body>&nbsp; 
 
<script type="text/javascript">
	function getdept(){
		var url = "selectcommodityTpye.do";//url地址
		$.post(url,{
			},function(data){
					 $("#typeSelect").append($.trim(data));
			});
	}
getdept();
function getModel(){
   var nowDate = (new Date()).getTime();
   var deptid = $("#typeSelect").val();
   var url = "selectcommodityModel.do";
   $("#modelSelect").empty();
   $.post(url,{
	    deptid:deptid
	},function(data){
	 $("#modelSelect").append(data);
	 });
}

function doprint(){

	$("div#myPrintArea").printArea();
}
</script>
<form action="">
商品类型：<select id="typeSelect" name="typeSelect" onchange="getModel()"></select>


商品型号 :<select id="modelSelect" name="modelSelect" ></select>	
<input type="button" value="确定" onclick="ruturnvaleu();">
</form>
  </body>
</html>
