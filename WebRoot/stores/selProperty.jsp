<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">   
    <title>分类统计</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>stores/css/calendar.css">
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>stores/js/calendar.js"></script>
	<script type="text/javascript" src="<%=basePath%>stores/js/calendar-zh.js"></script>
	<script type="text/javascript" src="<%=basePath%>stores/js/calendar-setup.js"></script>
	<script type="text/javascript" src="<%=basePath%>stores/js/stormRoom.js" charset="GBK"></script>
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
.sousuotjdiv {
	height:30px;
	width:200px;
	text-align:center;
	float:left;
	margin-left:15px;
}
.sousuotj {
	width:120px;
	height:22px;
	margin-top:5px;
}
.feny{ width:60px; height:32px;float:left; cursor:pointer; float:left;}
</style>
<script type="text/javascript"> 
   function changeValue(mp){
      //alert(mp);
      $('#hids').val(mp);
   }
   $(function(){
       $('#selss').click(function(){
       if(document.getElementById("selss").options.length==1){
          var flags="stn";
          $.ajax({
            type:"post",
            url:"cms/storeCount_getSingleSelect.do",
            data:{flagString : flags},
            success:function(res){
               $('#selss').append(res);
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
    <input id="exportData" type="button" value="导出EXCEL" style="margin-top:3px;" />
  </div>
</div>

<div style=" width:100%;border:#CCC double 1px; margin-top:8px;background:#f6f6f6; font-size:12px;">
  <div class="sousuotjdiv" >商品编码：
    <select name="sect1" id="sect1" class="sousuotj">
     <option value=0>请选择</option>
    </select>
  </div>
  <div class="sousuotjdiv" >商品类型：
    <select name="sect2" id="sect2" class="sousuotj" >
     <option value=0>请选择</option>
    </select>
  </div>
  <div class="sousuotjdiv">商品名称：
    <select name="sect3" id="sect3" class="sousuotj" >
     <option value=0>请选择</option>
    </select>
  </div>
  <!--  
  <div class="sousuotjdiv">截止日期：
      <input class="easyui-validatebox" type="text" id="sect4" name="sect4" onclick="return showCalendar('sect4','y-m-dd');"></input>
  </div>
   -->
  <div class="sousuotjdiv">仓库名称：
    <select name="selss" id="selss" class="sousuotj" >
       <option value=0>请选择</option>
    </select>
  </div>
  <div style=" height:30px; width:100px; text-align:center; margin-left:15px; font-size:12px; float:left;">
    <input id="subs" type="button" value="查询" class="butt"/>
  </div>
</div>
<div style="width:100%;height:80%;">
	<table id="dd" style="width:100%;height:100%;">
	</table>
</div>
</body>
</html>