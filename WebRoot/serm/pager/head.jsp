<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'head.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
	<script>
  function ms(){
     var pm = new Date();
     var ph,pt,ps;
     var pyear=pm.getFullYear();
     var pmouth=pm.getMonth()+1;
     var pday = pm.getDate();
     var phour = pm.getHours();
     if(phour<10){
        ph=0+''+phour;
     }else{
       ph=phour;
     }
     var pminuse = pm.getMinutes();
     if(pminuse<10){
        pt=0+''+pminuse;
     }else{
       pt=pminuse;
     }
     var pmiao = pm.getSeconds();
      if(pmiao<10){
        ps=0+''+pmiao;
     }else{
       ps=pmiao;
     }
     document.getElementById("timers").innerHTML="当前时间："+pyear+"-"+pmouth+"-"+pday+"&nbsp;&nbsp;&nbsp;"+ph+":"+pt+":"+ps;
} 
window.setInterval("ms()",1000);
function returnMain(){
   //alert(212);
    //parent.location.href="<%=basePath%>cms/loadCityServers.do";
    window.top.opener=null;
    window.top.open('', '_self', ''); 
    window.top.close();

}
</script>
</head>

<body onload="ms()">
<!--头部-->
<div style="width:100%;height:120px;margin: 0 auto;border:0px;">
<div style=" width:100%; height:90px; background:url(./serm/images/head-bg.jpg);">
 <div style="float:left;"><img src="./serm/images/head-title.jpg" width="186" height="90" border="0"/></div>
 <div style=" width:100px; height:20px; text-align:center; font-size:14px; color:#FFF; font-weight:bold;float:left; margin-top:43px;">版本：2012</div>
</div>
<!--头部下面显示用户时间，搜索IP按钮--> 
<div style=" height:30px; width:100%; background:url(./serm/serm/images/head2-bg.jpg);">
<!--头部下面显示用户--> 
 <div style=" height:30px; width:200px; float:left; margin-left:190px; font-size:12px; line-height:30px; 
 text-indent:35px; background:url(./serm/images/head2-1.jpg); background-repeat:no-repeat;">当前用户：<%=request.getSession().getAttribute("loginName") %></div>
<!--头部下面显示时间--> 
 <div id="timers" style=" height:30px; width:250px; float:left; margin-left:20px; font-size:12px; line-height:30px;
  text-indent:35px; background:url(./serm/images/head2-2.jpg);background-repeat:no-repeat;"></div>
<!--搜索IP按钮
 <div style="height:30px; width:200px; float:left; margin-left:30px; font-size:12px; line-height:30px;">
 
 IP:<input type="text" style=" height:22px; width:120px; line-height:22px; font-size:12px;
   background:url(./serm/images/zjjigui-bd-bg.jpg);background-repeat:no-repeat; background-position:top; border:0px;" />
   <input name="but" type="button" value="搜索" style=" height:26px; line-height:26px; width:57px; background:url(./serm/images/queren-but.jpg);
    background-repeat:no-repeat; background-position:top; font-size:12px; border:0px; cursor:pointer;"  />
    </div>
 --> 
 <div style="height:30px; width:200px; float:left; margin-left:50px;">
  <input type="button" class="zjjf-but1" value="返回首页" onclick="returnMain()" >
</div>
</div>
</div>
</body>
</html>
