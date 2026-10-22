<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />

 <title>商品详细</title>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px; color:#333132}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left; height:1000px;}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}
.ccc{ text-align:center;width:50px; line-height:20px;float:right; background-color:#7b7b7b;color:#fff;}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.d1{ line-height:20px;}
.da{ width:794; margin-left:30px; margin-right:30px; margin-top:10px; height:600px;}
.sp1{float:left;}
.sp2{float:right;}
.sp3{float:right; background-color:#7b7b7b; width:50px; text-align:center; margin-left:10px;line-height:20px; color:#fff;}
.sp4{ float:left;background-color:#7b7b7b; width:50px; text-align:center; margin-left:10px;line-height:20px; color:#fff;}
.sp5{ padding-left:130px; float:left;}
.sp6{ float:left;}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:0px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
.msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
.msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.tdyh{ padding-right:75px;}
.tcolor{ border:1px solid #295a01; background-color:#eafed9; }
.tdcolor{ color:#3d3d3d; background-color:#bcbcbc; border:1px; border-color:#999999; height:28px; size:14px;}
.ta111{ margin-top:10px; margin-left:5px; margin-bottom:10px; margin-right:5px; border:1px solid #bababa;}
.btn{ background-color:#50a806; color:#fff;}
.zt{ color:#295b02;}
.zt2{ color:#F00;}
.tbcenter{ margin-top:10px; margin-bottom:10px; border-color:#295a01}
.tdleft{ padding-left:40px;}
.qc{ padding-left:25px}
.yfd { width:600px; float:right; line-height:25px;}
.yfd span { color:#fec2a8;}
.gb_bt{ background-color:#7a7a7a; font-weight:bold; color:#fff; width:50px; line-height:20px; text-align:center; margin-left:auto; margin-right:29px; float:right;}
.div_left{ float:right; width:100px;}
.div_right{ float:right;width:100px;}
.gb_bt2{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; float:right; margin-right:30px;}
.gb_bt3{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; float:left; margin-right:30px;}
.tc_bottom_top{ margin-top:25px; margin-bottom:10px;}
.ttx{ size:20px;}
.tbbottom{ margin-top:13px;}
.top1{color:#3b8902;}
.top2{color:#fe6700;}
.khmg{ padding-top:15px;}
.top3{ margin-top:7px; margin-bottom:12px;}
.bg_wz { line-height:30px; padding-left:30px;}
.bg_t { line-height:30px; border:1px solid #ececec; background-color:#f8f8f8;}
.sp_tp { width:100px; height:100px; border:1px solid #ff6600;}
.sp_tp_t { width:100px; height:100px; border:1px solid #d9d9d9;}
.sp_ms { width:650px; line-height:25px; padding-top:20px; padding-left:10px; padding-right:10px; border:1px solid #ececec; background-color:#f8f8f8;}
.lh_ss { line-height:40px;}
.fh_an { width:50px; line-height:25px; color:#fff; background-color:#50a806; text-align:center; border:0;}



a { color:#213f71; font-size:9pt; text-decoration:none; }
a:hover { color:#0066cc; }
.blk_18 { overflow:hidden; zoom:1; font-size:9pt; border:1px solid #e3e3e3; background:#ffffff; width:692px; margin-top:8px; }
.blk_18 .pcont { width:638px; float:left; overflow:hidden; padding-left:5px; }
.blk_18 .ScrCont { width:32766px; zoom:1; margin-left:-5px; }
.blk_18 #List1_1, .blk_18 #List2_1 { float:left; }
.blk_18 .LeftBotton, .blk_18 .RightBotton { width:15px; height:74px; float:left; background:url(ax.gif) no-repeat; }
.blk_18 .LeftBotton { background-position: 0 0; margin:8px 5px 0; }
.blk_18 .RightBotton { background-position: 0 -100px; margin:8px 1px 10px 5px; }
.blk_18 .LeftBotton:hover { background-position: -20px 0; }
.blk_18 .RightBotton:hover { background-position: -20px -100px; }
.blk_18 .pl img { display:block; cursor:pointer; border:none; margin:6px auto 1px auto; }
.blk_18 .pl { width:105px; border:1px solid #f3f3f3; float:left; float:left; text-align:center; line-height:24px; }
.blk_18 a.pl:hover { border:1px solid #5dacec; color:#5dacec; background:#fff; }
</style>

<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>

<script type="text/javascript">

var Speed_1 = 10; //速度(毫秒)
var Space_1 = 20; //每次移动(px)
var PageWidth_1 = 107 * 6; //翻页宽度
var interval_1 = 5000; //翻页间隔时间
var fill_1 = 0; //整体移位
var MoveLock_1 = false;
var MoveTimeObj_1;
var MoveWay_1="right";
var Comp_1 = 0;
var AutoPlayObj_1=null;
function GetObj(objName){if(document.getElementById){return eval('document.getElementById("'+objName+'")')}else{return eval('document.all.'+objName)}}
function AutoPlay_1(){clearInterval(AutoPlayObj_1);AutoPlayObj_1=setInterval('ISL_GoDown_1();ISL_StopDown_1();',interval_1)}
function ISL_GoUp_1(){if(MoveLock_1)return;clearInterval(AutoPlayObj_1);MoveLock_1=true;MoveWay_1="left";MoveTimeObj_1=setInterval('ISL_ScrUp_1();',Speed_1);}
function ISL_StopUp_1(){if(MoveWay_1 == "right"){return};clearInterval(MoveTimeObj_1);if((GetObj('ISL_Cont_1').scrollLeft-fill_1)%PageWidth_1!=0){Comp_1=fill_1-(GetObj('ISL_Cont_1').scrollLeft%PageWidth_1);CompScr_1()}else{MoveLock_1=false}
AutoPlay_1()}
function ISL_ScrUp_1(){if(GetObj('ISL_Cont_1').scrollLeft<=0){GetObj('ISL_Cont_1').scrollLeft=GetObj('ISL_Cont_1').scrollLeft+GetObj('List1_1').offsetWidth}
GetObj('ISL_Cont_1').scrollLeft-=Space_1}
function ISL_GoDown_1(){clearInterval(MoveTimeObj_1);if(MoveLock_1)return;clearInterval(AutoPlayObj_1);MoveLock_1=true;MoveWay_1="right";ISL_ScrDown_1();MoveTimeObj_1=setInterval('ISL_ScrDown_1()',Speed_1)}
function ISL_StopDown_1(){if(MoveWay_1 == "left"){return};clearInterval(MoveTimeObj_1);if(GetObj('ISL_Cont_1').scrollLeft%PageWidth_1-(fill_1>=0?fill_1:fill_1+1)!=0){Comp_1=PageWidth_1-GetObj('ISL_Cont_1').scrollLeft%PageWidth_1+fill_1;CompScr_1()}else{MoveLock_1=false}
AutoPlay_1()}
function ISL_ScrDown_1(){if(GetObj('ISL_Cont_1').scrollLeft>=GetObj('List1_1').scrollWidth){GetObj('ISL_Cont_1').scrollLeft=GetObj('ISL_Cont_1').scrollLeft-GetObj('List1_1').scrollWidth}
GetObj('ISL_Cont_1').scrollLeft+=Space_1}
function CompScr_1(){if(Comp_1==0){MoveLock_1=false;return}
var num,TempSpeed=Speed_1,TempSpace=Space_1;if(Math.abs(Comp_1)<PageWidth_1/2){TempSpace=Math.round(Math.abs(Comp_1/Space_1));if(TempSpace<1){TempSpace=1}}
if(Comp_1<0){if(Comp_1<-TempSpace){Comp_1+=TempSpace;num=TempSpace}else{num=-Comp_1;Comp_1=0}
GetObj('ISL_Cont_1').scrollLeft-=num;setTimeout('CompScr_1()',TempSpeed)}else{if(Comp_1>TempSpace){Comp_1-=TempSpace;num=TempSpace}else{num=Comp_1;Comp_1=0}
GetObj('ISL_Cont_1').scrollLeft+=num;setTimeout('CompScr_1()',TempSpeed)}}
function picrun_ini(){
GetObj("List2_1").innerHTML=GetObj("List1_1").innerHTML;
GetObj('ISL_Cont_1').scrollLeft=fill_1>=0?fill_1:GetObj('List1_1').scrollWidth-Math.abs(fill_1);
GetObj("ISL_Cont_1").onmouseover=function(){clearInterval(AutoPlayObj_1)}
GetObj("ISL_Cont_1").onmouseout=function(){AutoPlay_1()}
AutoPlay_1();
}

$(function(){
	var imgs=$('#imgs').val();

	  var imgvalue=  imgs.split('|');
	    if(imgvalue!=""){
	  for(var i=1; i<imgvalue.length; i++){
	  	if(imgvalue[i]!=""){
	    	$('#List1_1').append("<a class='pl' href='javascript:void(0);'><img src='"+imgvalue[i]+"'  width='96' height='72'/></a>");
	  	}
	    }
	  }
	});
</script>
</head>

<body>
<div class="d1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><span class="top1">您的位置</span>：<a href="<%=basePath %>potal/page/desk.jsp">首页</a>&gt;<a href="<%=basePath%>selectsalegoods.do">出售中的商品</a>&gt;<span class="top2">商品详情</span></td>
  </tr>
</table>
<div class="top3"></div>
</div>
<div class="dow">
<div class="dow_top">
商品详情
</div>
<div class="dow_nr">
	 <div class="lb">
     <ul>
     <li>商品的基本信息</li>
     </ul>
     </div>	 
    <div class="c">
	   <p>&nbsp;</p>
    </div>
    <input type="hidden" id="imgs" name="imgs" value="${sg.sgImg}"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="bg_wz">
  <tr>
    <td width="15%" align="right">商品全称：</td>
    <td width="35%">${sg.sgname}</td>
    <td width="25%" align="right">一口价：</td>
    <td width="25%">${sg.sgPrice }元</td>
  </tr>
  <tr>
    <td align="right">商品类型：</td>
    <td>${sg.goods_dict.gdnames}</td>
    <td align="right">上架类型：</td>
    <td>
    	<c:if test="${sg.sgchecks == '0'}">无</c:if>
    	<c:if test="${sg.sgchecks != '0'}">上架</c:if>
    </td>
  </tr>
  <tr>
    <td align="right">开始时间：</td>
    <td>${sg.sgtime}</td>
    <td align="right">运费：</td>
    <td>暂无</td>
  </tr>
  <tr>
    <td align="right" valign="top">商品属性：</td>
    <td colspan="3"><table width="100%" align="left" border="0" cellspacing="0" cellpadding="0" class="bg_t">
    <c:forEach items="${getpropertys}" var="sgo">
      <tr>
        <td width="6%" align="left">${sgo.value[0]}：</td>
        <td width="24%">${sgo.value[1]}</td>
      </tr>
      </c:forEach>
    </table></td>
    </tr>
</table>
<center>
<!-- picrotate_left start  -->


<div class="blk_18"> <a class="LeftBotton" onmousedown="ISL_GoUp_1()" onmouseup="ISL_StopUp_1()" onmouseout="ISL_StopUp_1()" href="javascript:void(0);" target="_self"><img src="potal/images/zuo.jpg"/></a>
  <div class="pcont" id="ISL_Cont_1">
    <div class="ScrCont">
      <div id="List1_1" >

      </div>
      <div id="List2_1"></div>
    </div>
  </div>
  <a class="RightBotton" onmousedown="ISL_GoDown_1()" onmouseup="ISL_StopDown_1()" onmouseout="ISL_StopDown_1()" href="javascript:void(0);" target="_self"><img src="potal/images/you.jpg"/></a> </div>
<div class="c"></div>
<script type="text/javascript">
        <!--
        picrun_ini()
        //-->
        </script>
<!-- picrotate_left end -->
</center>

	  <p>&nbsp;</p>
	  <div class="lb">
      <ul>
        <li>商品描述</li>
        
      </ul>
  </div>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="90%"><div class="sp_ms">${sg.sgDetails}</div></td>
          </tr>
  </table>
		<p>&nbsp;</p>
  <div class="lb">
    <ul>
      <li>售后保障信息</li>
    </ul>
  </div>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10%" align="right" class="lh_ss">发票：有</td>
            <td width="90%" align="center" class="lh_ss">保修：有</td>
          </tr>
          <tr>
            <td align="right" valign="top">售后说明：</td>
            <td><div class="sp_ms">暂无</div></td>
          </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
      <input type="button" style="CURSOR:pointer;" name="fanHui" onclick="javascript:window.history.go(-1);"  value="返回" class="fh_an" /></td>
  </tr>
</table>

  
  </div>
</div>
</body>
</html>
