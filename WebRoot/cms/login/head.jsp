<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
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
	<script type="text/javascript" src="cms/js/jquery-1.7.2.min.js"></script>
    <link href="./cms/css/cms.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
      function times(){
       var timers = new Date();
       var years =timers.getFullYear();
       var months=timers.getMonth()+1;
       var days=timers.getDay();
       var hour=timers.getHours();
       var mint=timers.getMinutes();
       var minus=timers.getSeconds();
       var pmint;
       var pminus;
       if(mint<10){
          pmint=0+''+mint;
       }else{
         pmint=mint;  
       }
       if(minus<10){
          pminus=0+''+minus;
       }else{
         pminus=minus;  
       }
       //alert(years+","+months+","+days+","+hour+","+mint);
       document.getElementById("timers").innerHTML="当前时间："+years+"年"+months+"月"+(days+2)+"日"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+hour+":"+pmint+":"+pminus;
       }
       function gones(){
          window.setInterval("times()",1000);
       }
      function freshCache(){
      	
      	$.post("cms/reconfigNews.do",{},function(data){
      		//alert(data);
      		if(data == '0'){
      			alert("刷新成功");
      		}else{
      			alert("内部错误");
      		}
      	});
      }
      function currentHTML(id) 
			{  
			//alert(1111);
				 $.ajax({
					  type: "POST",
					  url: "<%=basePath%>cms/currentHTMLTemplate.do",
					  data:{
                     "id":id
					  },
					  success: function(data){
					       //alert(data+"访问路径:调用方法+模板路径+文件名.html");
					       if(data == 0 || data == "0"){
					       	alert("生成成功");
					       }else{
					       	alert("网络错误!");
					       }
					  }
					 });			 
			}
    </script>
</head>
<body onload="gones()"> 
<div id="header">
 <div id="header2">
 版本：1.0
 </div>
 <div id="header3">
 <ul>
  <li class="shuaxin" onclick="top.document.location.reload();">刷新</li>
  <li class="bangzhu">帮助</li>
  <li class="tuichu"><A style="text-decoration: none;" onclick="return confirm('确定要退出吗？');" 
      href="javascript:parent.location.href='<%=path %>/cms/safetyExitAdmin.do'" target="_top"><font color="white">安全退出</font></A></li>
 </ul>
 </div>
</div>
<div id="outDiv">
<div id="middleDiv"><h2>当前用户：<s:property value="#session.adminid.username"/></h2></div>
<div id="header-nav">
 <ul>
  <li ><a href="#" target="_blank">主页</a></li>
  <li ><a href="#" target="_blank">预览首页</a></li>
  <li ><a href="javascript:void(0);" onclick="freshCache()">更新栏目缓存</a></li>
  <li ><a href="javascript:void(0);" onclick="currentHTML(8)">生成首页</a></li>
 </ul>
</div>
<div id="lastDiv">
   <span id="timers"></span>
</div>
</div>
</body>
</html>
