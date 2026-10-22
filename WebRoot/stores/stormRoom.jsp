<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'stormRoom.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>stores/js/stormRoom.js"></script>
 <style>
.tdfirst {
	background:#f6f6f6;
	border-bottom:#CCC double 1px;
	border-left:#bfbfbf double 1px;
	border-top:#bfbfbf double 1px;
	font-size:12px;
	text-align:center;
	line-height:30px;
}
.tdlast {
	border-bottom:#CCC double 1px;
	border-left:#bfbfbf double 1px;
	font-size:12px;
	line-height:30px;
	text-align:center;
}
.butt {
	height:25px;
	width:79px;
	background:url(./stores/images/but.png);
	border:0px;
	margin-top:3px;
	text-align:center;
	cursor:pointer;
	color:#333;
}
.feny{ width:60px; height:32px;float:left; cursor:pointer; float:left;border:0px;}
</style>
<script type="text/javascript"> 
   function changeValue(mp){
      //alert(mp);
      $('#hids').val(mp);
   }
   $(function(){
       $('#sels').click(function(){
       if(document.getElementById("sels").options.length==1){
          $.ajax({
            type:"post",
            url:"cms/storeCount_selectAll.do",
            data:"",
            success:function(res){
               $('#sels').append(res);
            }
          });
          }
       });
      $('#exportData').click(function(){
         location.href="../cms/storeCount_exports.do";
      });
   });
</script>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0">
<input type="hidden" id="hids" value="0"/>
<div style=" width:100%; height:33px; background:url(./stores/images/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(./stores/images/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">仓库记总： </div>
  <div style=" height:30px; width:100px; text-align:center; float:left; margin-left:15px; font-size:12px;">
    <input id="exportData" type="button" value="导出EXCEL" style=" margin-top:3px;" />
  </div>
</div>
<div style=" width:100%;height:50px;text-align:center; border:#CCC double 1px; margin-top:8px;background:url(./stores/images/xuanxkbg.jpg); background-repeat:repeat-x; font-size:12px;">
<div style="width:400px;height:50px;margin:0 auto;line-height:50px;">
  <div style=" height:30px; width:250px; text-align:center; float:left; margin-left:15px;">仓库名称：
    <select name="sels" id="sels" style=" width:150px; height:22px; margin-top:5px;" onchange="changeValue(this.value)">
       <option value=0>请选择</option>
    </select>
  </div>
  <div style=" height:30px; width:100px; text-align:center; float:left; margin-left:15px; font-size:12px;">
    <input id="butn" type="button" value="查询" class="butt"/>
  </div>
  </div>
</div>

<div style="width:100%;height:80%;">
<table id="dd" style="width:100%;height:100%;">
</table>
</div>
</body>
</html>
