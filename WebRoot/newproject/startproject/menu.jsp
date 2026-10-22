<%@ page contentType="text/html; charset=GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'p_menu.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link href="<%=request.getContextPath()%>/Css/style.css" rel="stylesheet" type="text/css">  -->
  </head>
  
<style>
.ie{width:400px; background-color:#FFFFFF; border:1px solid #000000; padding:20px;padding-top:1px; overflow:hidden; display:none}
#info{filter: alpha(opacity=80)}
</style>

<body>
<script type="text/javascript">
function iboxActive(id, key, num, max) {
var menu = document.getElementById(id + "menu");
(menu.getElementsByTagName("INPUT")[0]||{}).value = key;
var main = menu.parentNode;
var applyfilter;
var menudivs = menu.getElementsByTagName("DIV");
for (var i = 0; i < menudivs.length; i ++) {
menudivs[i].className = id+"menuoff";
(menudivs[i].getElementsByTagName("A")[0]||{}).className = "";
}
menudivs[num].className = id+"menuon"+(num % max);
(menudivs[num].getElementsByTagName("A")[0]||{}).className = "active";
try {
applyfilter = main.filters && main.filters[0];
if (applyfilter) {
   main.filters[0].apply();
}
} catch(e) {}

var parent = menu.parentNode;
var childs = parent.childNodes;
var divs = [];
for (var i = 0, c = childs.length; i < c; i ++) {
if (childs[i].tagName == 'DIV') {
   if (divs.length) childs[i].style.display = 'none';
   divs[divs.length] = childs[i];
}
}
divs[num+1].style.display = 'block';
try {
if (applyfilter) {
   main.filters[0].play();
}
} catch(e) {}
}
</script>

<script language="JavaScript" type="text/javascript">  
//|------------------------------------------------------------------------------------   
//|   
//| 说明：JS弹出全屏遮盖的对话框(弹出层后面有遮盖效果，兼容主流浏览器)   
//|       实现了在最大化、拖动改变窗口大小和拖动滚动条时都可居中显示。   
//|   
//| 注意：主要使用EV_modeAlert和EV_closeAlert这两个函数行了；   
//|       (EV_modeAlert-弹出对话框，EV_closeAlert-关闭对话框)；   
//|       注意：使用时，请在body标签内(不要在其它元素内)写一div，   
//|       再给这div赋一id属性，如：id="myMsgBox"，   
//|       然后就可以调用EV_modeAlert('myMsgBox')来显示了。   
//|       还有，请给你这div设置css：display:none让它在开始时不显示。   

//|------------------------------------------------------------------------------------   
//|   
//用来记录要显示的DIV的ID值
var EV_MsgBox_ID=""; 
//重要    
//弹出对话窗口(msgID-要显示的div的id) 
function EV_modeAlert(msgID){  
    //创建大大的背景框   
    var bgObj=document.createElement("div");  
    bgObj.setAttribute('id','EV_bgModeAlertDiv');  
    document.body.appendChild(bgObj);  
    //背景框满窗口显示   
    EV_Show_bgDiv();  
    //把要显示的div居中显示   
   EV_MsgBox_ID=msgID;  
   EV_Show_msgDiv();  
}    
//关闭对话窗口   
function EV_closeAlert(){  
    var msgObj=document.getElementById(EV_MsgBox_ID);  
    var bgObj=document.getElementById("EV_bgModeAlertDiv");  
    msgObj.style.display="none";  
    document.body.removeChild(bgObj);  
    EV_MsgBox_ID="";  
}  
  
//窗口大小改变时更正显示大小和位置   
window.onresize=function(){  
    if (EV_MsgBox_ID.length>0){  
        EV_Show_bgDiv();  
        EV_Show_msgDiv();  
    }  
}  
  
//窗口滚动条拖动时更正显示大小和位置   
window.onscroll=function(){  
    if (EV_MsgBox_ID.length>0){  
       EV_Show_bgDiv();  
        EV_Show_msgDiv();  
   }  
}  
  
//把要显示的div居中显示   
function EV_Show_msgDiv(){  
    var msgObj   = document.getElementById(EV_MsgBox_ID);  
    msgObj.style.display  = "block";  
    var msgWidth = msgObj.scrollWidth;  
    var msgHeight= msgObj.scrollHeight;  
    var bgTop=EV_myScrollTop();  
    var bgLeft=EV_myScrollLeft();  
    var bgWidth=EV_myClientWidth();  
    var bgHeight=EV_myClientHeight();  
    var msgTop=bgTop+Math.round((bgHeight-msgHeight)/2);  
    var msgLeft=bgLeft+Math.round((bgWidth-msgWidth)/2);  
    msgObj.style.position = "absolute";  
    msgObj.style.top      = msgTop+"px";  
    msgObj.style.left     = msgLeft+"px";  
    msgObj.style.zIndex   = "10001";  
      
}  
//背景框满窗口显示   
function EV_Show_bgDiv(){  
    var bgObj=document.getElementById("EV_bgModeAlertDiv");  
    var bgWidth=EV_myClientWidth();  
    var bgHeight=EV_myClientHeight();  
    var bgTop=EV_myScrollTop();  
    var bgLeft=EV_myScrollLeft();  
    bgObj.style.position   = "absolute";  
    bgObj.style.top        = bgTop+"px";  
    bgObj.style.left       = bgLeft+"px";  
    bgObj.style.width      = bgWidth + "px";  
    bgObj.style.height     = bgHeight + "px";  
    bgObj.style.zIndex     = "10000";  
    bgObj.style.background = "#777";  
    bgObj.style.filter     = "progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=60,finishOpacity=60);";  
    bgObj.style.opacity    = "0.6";  
}  
//网页被卷去的上高度   
function EV_myScrollTop(){  
    var n=window.pageYOffset   
    || document.documentElement.scrollTop   
    || document.body.scrollTop || 0;  
    return n;  
}  
//网页被卷去的左宽度   
function EV_myScrollLeft(){  
    var n=window.pageXOffset   
   || document.documentElement.scrollLeft   
       || document.body.scrollLeft || 0;  
    return n;  
}  
//网页可见区域宽   
function EV_myClientWidth(){  
    var n=document.documentElement.clientWidth   
    || document.body.clientWidth || 0;  
    return n;  
}  
//网页可见区域高   
function EV_myClientHeight(){  
    var n=document.documentElement.clientHeight   
    || document.body.clientHeight || 0;  
   return n;  
}
</script>  


<style type="text/css">
.dd{margin:0px auto; width:500px;}
.hotibox{font-size:12px;color:#000;line-height:18px;}
.hotibox nobr{padding:0px 0px 0px 10px;width:100%}
.hotibox a{text-transform:none;text-decoration:none;color:#000;}
.hotibox a:hover{color:#555;text-decoration:none;}
.i203cmenu {width:100%;height:23px;font-size:12px;font-family:Arial;}
.i203cmenu div a {text-decoration:none;color:#000000;height:100%;width:100%;display:block}
.i203cmenuon0, .i203cmenuon1, .i203cmenuon2, .i203cmenuon3, .dummy {
float:left;margin:0 1px 0 1px;
position:relative;top:1px;
width:50px;height:23px;padding:2px 6px 0 6px;line-height:19px;text-align:center;
border: 1px solid black; border-bottom:0;
cursor:hand;cursor:pointer;
}
.i203cmenuoff {
cursor:hand;cursor:pointer;
float:left;margin:2px 1px 0 1px;width:50px;height:21px;padding:4px 6px 0 6px;line-height:16px;text-align:center;
border:1px solid black; border-bottom:0;
}
.i203c0, .i203c1, .i203c2, .i203c3, .dummy {width:100%;border:1px solid;clear:both;}
.i203cmenuoff {color:#666666;background:url(/school/UploadFiles/200602/20060214092618928.gif) repeat-x top center #f8f8f8;border-color: #cccccc}
.i203cmenuon0 {background:url(/school/UploadFiles/200602/20060214092618854.gif) repeat-x top center #F1F3F5;border-color:#B9C2D0;color:#5C80BA;}
.i203cmenuon1 {background:url(/school/UploadFiles/200602/20060214092618824.gif) repeat-x top center #F1F3F5;border-color:#B9C2D0;color:#5C80BA;}
.i203cmenuon2 {background:url(/school/UploadFiles/200602/20060214092618280.gif) repeat-x top center #F1F3F5;border-color:#B9C2D0;color:#5C80BA;}
.i203cmenuon3 {background:url(/school/UploadFiles/200602/20060214092618280.gif) repeat-x top center #F1F3F5;border-color:#B9C2D0;color:#5C80BA;}
.i203c0,.i203c1,.i203c2,.i203c3, {border:0;padding-top:5px;}
.i203c0 {background:#FEEFB6;border:1px solid #F3B75C;}
.i203c1 {background:#F7FADE;border:1px solid #C8CF65;}
.i203c2 {background:#F1F3F5;border:1px solid #B9C2D0;}
.i203c3 {background:#F1F3F5;border:1px solid #B9C2D0;}
</style>

<div class="dd" style="width: 750px;">
<div class="i203cmenu" id="i203cmenu" style="width: 1500px;">
<div class="i203cmenuon0" onclick="iboxActive('i203c', '0', 0, 4);return false" style="width: 150px;float:left;"><nobr>基本信息</nobr></div>
<div class="i203cmenuoff" onclick="iboxActive('i203c', '1', 1, 4);return false" style="width: 150px;float:left;"><nobr>项目成员</nobr></div>
<div class="i203cmenuoff" onclick="iboxActive('i203c', '2', 2, 4);return false" style="width: 150px;float:left;"><nobr>项目任务</nobr></div>
<div class="i203cmenuoff" onclick="iboxActive('i203c', '3', 3, 4);return false" style="width: 150px;float:left;"><nobr>项目文档</nobr></div>
<div class="i203cmenuoff" onclick="iboxActive('i203c', '4', 4, 4);return false" style="width: 150px;float:left;"><nobr>经费预算</nobr></div>
<div style="clear:both;display:none"></div>
</div>


<div class="i203c2" style="width: 760px;background-color: white;height: 500px;">
<div class="hotibox">
   <iframe src="<%=request.getContextPath() %>/newproject/startproject/startproject.jsp" width="100%" height="100%"></iframe>
   <!--  <input type="button" value="弹出对话框" onclick="EV_modeAlert('envon')" />  -->
</div>
</div>

<div class="i203c2" style="display:none;width: 760px;background-color: white;">
<div class="hotibox">
零度零度123456
</div>
</div>

<div class="i203c2" style="display:none;width: 760px;background-color: white;">
<div class="hotibox">
   sss
</div>
</div>

<div class="i203c2" style="display:none;width: 760px;background-color: white;">
<div class="hotibox">
零度零度零度零度
</div>
</div>

<div class="i203c2" style="display:none;width: 760px;background-color: white;">
<div class="hotibox">
零度零度零度零度零度
</div>
</div>
</div> 

<!-- 弹出层  屏蔽页面 -->
 <br />  
    <!-- 下面这个div将会被弹出显示，其内容和样式自行编写 -->  
   <div id="envon" class="ie" style="background-color: #CAE1FF;">
        <table align="right"><tr><td align="right">关闭</td></tr></table>  
        <div style="text-align:right;" align="right"><img onclick="javascript:EV_closeAlert()" src="<%=request.getContextPath()%>/img/closeDIV.jpg" style="width: 10px;height: 10px;"/></div>  
        <div id="info">
          <table cellspacing="0" cellpadding="0" border="0" align="center">
            <tr><td>编号:</td><td>1</td><td>名称:</td><td><input type="text" value="项目管理"/></td></tr>
            <tr><td>部门:</td><td><select><option value="1">技术部</option><option value="2" selected="selected">销售部</option></select></td><td>人员:</td><td><input type="text" value="张三、李四"/></td></tr>
          </table>  
        </div> 
</body>
</html>
