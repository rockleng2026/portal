<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Date now=new Date();
java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String nowstr=dateFormat2.format(now);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>批量批阅</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />

<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left}
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

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
 .msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
  .msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.rz_box{font-size:12px; border-top:2px solid #4FA805;}
.main {font-size:12px; width:760px; margin:0 auto;}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.ltj { color:#3b8801;  line-height:25px; margin: 0 0 0 auto; width:130px;}
.rz_box .title{width:85px; line-height:25px; background-color:#4FA805; position:absolute; color:#fff; font-size:13px; font-weight:bold; text-align:center;}
.foot_box{font-size:12px; border-bottom:2px solid #4FA805;}
.foot_box ul{margin:0px;width: 800px;} 
.foot_box ul li{float: left;width:70px; line-height:25px; background-color:#4FA805; color:#fff; text-align:center; font-size:13px; font-weight:bold;list-style-image: none;border: 1px solid #ffffff;border-bottom: none;border-left: none;border-top: none;}
.foot_box .title1{color:#000000;background-image: url("<%=path%>/potal/images/green.jpg");border-left: 1px solid #4FA805;border-right: 1px solid #4FA805; }
.list{font-size:12px;}
 .rz_box .list th{ height:35px; background-color:#EDEDED;}
 .gz_rz { line-height:25px; padding-left:5px;}
 .gz_rz p{ line-height:25px;}
 .gz_rz p span { color:#e0731e;}
 .gz_rz p span a { color:#e0731e;}
 .wbbd { width:760px; border-bottom:1px solid #c6c6c6; border-left:1px solid #c6c6c6; border-right:1px solid #c6c6c6; margin:auto auto 5px auto;}
 .ts_nr { border-top:1px solid #c6c6c6;  margin:0 0 5px 0; line-height:25px; padding-left:5px;}
 .sc_fj { width:730px; line-height:30px; background-color:#ededed; padding-left:10px; margin:5px auto 5px 10px;}
 #an_bj { margin:15px auto 90px auto;}
 <!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:22px; height:22px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;cursor:hand; margin:3px;}
 <!-- 按钮 -->
.gb_bt2{ background-color:#cccccc; font-weight:bold; color:#fff; line-height:22px; height:22px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
 a{text-decoration: none;}
 #hssj { color:#abaaaa;}
 .hszt { color:#ff0000;}
  .hs_bt{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;}
.d2{z-index: 100004;position:absolute;left:6%;top:22%;}
 .rz_title { width:28px; background-color:#295900;}
.rz_title { color:#fff; font-size:14px; font-weight:bold; padding:20px 0 20px 0; text-align:center;}
.borderstyle{
   border:1px solid #ccc;
   width:500px; height:80px;
}
/*quiz style*/
.quiz{border:solid 1px #ccc;height:400px;width:500px;}
.pf{font-size:14px;height:26px;border-bottom:solid 1px #e8e8e8;padding-left:20px;background:#3c8301;color:#FFFFFF;position:relative;}
.quiz_content{padding-top:10px;padding-left:20px;position:relative;height:205px;}
.quiz_content .btm{border:none;width:100px;height:33px;background:url(<%=path%>/potal/images/btn.gif) no-repeat;margin:10px 0 0 64px;display:inline;cursor:pointer;}
.quiz_content li.full-comment{position:relative;z-index:99;height:41px;}
.quiz_content li.cate_l{height:24px;line-height:24px;padding-bottom:10px;}
.quiz_content li.cate_l dl dt{float:left;}
.quiz_content li.cate_l dl dd{float:left;padding-right:15px;}
.quiz_content li.cate_l dl dd label{cursor:pointer;}
.quiz_content .l_text{height:120px;position:relative;padding-left:18px;}
.quiz_content .l_text .m_flo{float:left;width:47px;}
.quiz_content .l_text .text{width:450px;height:109px;border:solid 1px #ccc;}
.quiz_content .l_text .tr{position:absolute;bottom:-18px;right:40px;}
/*goods-comm-stars style*/
.goods-comm{height:41px;position:relative;z-index:7;}
.goods-comm-stars{line-height:25px;padding-left:12px;height:41px;position:absolute;top:0px;left:0;width:400px;}
.goods-comm-stars .star_l{float:left;display:inline-block;margin-right:5px;display:inline;}
.goods-comm-stars .star_choose{float:left;display:inline-block;}
/* rater star */
.rater-star{position:relative;list-style:none;margin:0;padding:0;background-repeat:repeat-x;background-position:left top;float:left;}
.rater-star-item, .rater-star-item-current, .rater-star-item-hover{position:absolute;top:0;left:0;background-repeat:repeat-x;}
.rater-star-item{background-position: -100% -100%;}
.rater-star-item-hover{background-position:0 -48px;cursor:pointer;}
.rater-star-item-current{background-position:0 -48px;cursor:pointer;}
.rater-star-item-current.rater-star-happy{background-position:0 -25px;}
.rater-star-item-hover.rater-star-happy{background-position:0 -25px;}
.rater-star-item-current.rater-star-full{background-position:0 -72px;}
/* popinfo */
.popinfo{display:none;position:absolute;top:30px;background:url(<%=path%>/potal/images/comment/infobox-bg.gif) no-repeat;padding-top:8px;width:192px;margin-left:-14px;}
.popinfo .info-box{border:1px solid #f00;border-top:0;padding:0 5px;color:#F60;background:#FFF;}
.popinfo .info-box div{color:#333;}
.rater-click-tips{font:12px/25px;color:#333;margin-left:10px;background:url(<%=path%>/potal/images/comment/infobox-bg-l.gif) no-repeat 0 0;width:125px;height:34px;padding-left:16px;overflow:hidden;}
.rater-click-tips span{display:block;background:#FFF9DD url(<%=path%>/potal/images/comment/infobox-bg-l-r.gif) no-repeat 100% 0;height:34px;line-height:34px;padding-right:5px;}
.rater-star-item-tips{background:url(<%=path%>/potal/images/comment/star-tips.gif) no-repeat 0 0;height:41px;overflow:hidden;}
.cur.rater-star-item-tips{display:block;}	
.rater-star-result{color:#FF6600;font-weight:bold;padding-left:10px;float:left;}
.border_grey{ border:1px solid #C6C6C6; margin-top:4px;}
.rz_content{ padding:10px;}
</style>
<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/coverComment.js"></script>
<LINK href="<%=request.getContextPath() %>/potal/css/index.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=path%>/potal/js/comment.js"></script>
<script>
//编辑器
var contenteditor;
KindEditor.ready(function(K) {
	contenteditor= K.create('textarea[id="py"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
	});
});

// 批阅操作
function piyue(){
	  contenteditor.sync(); 
	  var content = "";
	  content = $("#py").val();
	  content = $.trim(content);
	  if(content == 'undefind' ||content == ''){
	  	alert("批注不能为空!");
	  	return false;
	  }
	  content = encodeURI(encodeURI(content));
	  var id = $("#id").val();
	  var audid = $("#audid").val();
	  var grade=$("#StarNum").val();//分数
	  if(grade=="" || grade.length<=0){
		  alert("请评分！");
		  return false;
	  }
	  var url = "addNewReplyWorkLogNewportal.do?tt="+(new Date().getTime());
	  $.post(url,{id:id,reply:content,audid:audid,mark:grade},function(data)
	  {
	       if(data == 0){
	       	window.location.href="selectOtherWorkLogNewportal.do";
	       }else{
	      	alert("提交错误！请刷新后再试");
	      	return false;
	      }
	  });
  }

// 弹出层
 function addcus(){
	  contenteditor.sync(); 
	  var content = "";
	  content = $("#py").val();
	  content = $.trim(content);
	  if(content == 'undefind' ||content == ''){
	  	alert("批注不能为空!");
	  	return false;
	  }
	  var url = "<%=path%>/potal/page/WorkLog/logGrade.jsp"; 
      $("#addorUpd").load(url);
	  showDiv('addorUpdSuppers',500,3,3);      
  }
//查看附件
function xzfj(fj){
    window.location.href="downloadTaskUpload.do?url="+fj;
}
//弹出查看详情操作
function lookSch(id)
{
	 $("#addrow").load("<%=path%>/lookSchWorkLogNewportal.do?schid="+id);
	 $("#addrow").css("display","block");
}

function yingcang()
{
	 $("#addrow").css("display","none");
}
function back(obj){
    $("#fb"+obj.name).show();
}
function hide(obj){
    $("#fb"+obj.name).hide();
}
//显示历史记录
function showHistory(){
	$("#showjl").hide();
	$("#hidejl").show();
	$("#history").show();
}
// 隐藏历史记录
function hideHistory(){
	$("#showjl").show();
	$("#hidejl").hide();
	$("#history").hide();
}
//弹出问询发送消息页面
function logmessage(id)
{
	 var workid=$("#id").val();
	 var logno=$("#logno").val();
	 $("#addrow").load("<%=path%>/planEmpWorkLogNewportal.do?schid="+id+"&logno="+logno+"&id="+workid);
	 $("#addrow").css("display","block");
}
//切换选项卡的属性得到不同的值
function batch(count){
	 var ids=$("#ids").val();
	 window.location.href="batchreplyWorkLogNewportal.do?ids="+ids+"&count="+count;
}

// 领导添加批注
function batchreply(){
	 contenteditor.sync(); 
	  var content = "";
	  content = $("#py").val();
	  content = $.trim(content);
	  if(content == 'undefind' ||content == ''){
	  	alert("批注不能为空!");
	  	return false;
	  }
	  content = encodeURI(encodeURI(content));
	  var id = $("#id").val();
	  var audid = $("#audid").val();
	  var grade=$("#StarNum").val();//分数
	  var ids=$("#ids").val();
	  var count=$("#num").val();
	  if(grade=="" || grade.length<=0){
		  alert("请评分！");
		  return false;
	  }
	  var url = "replyWorkLogNewportal.do?tt="+(new Date().getTime());
	  $.post(url,{id:id,reply:content,audid:audid,mark:grade},function(data)
	  {
	       if(data == 0){
		       alert("批阅成功！");
	    	   window.location.href="batchreplyWorkLogNewportal.do?ids="+ids+"&count="+count+"&flag=0";
	       }else{
	      	alert("提交错误！请刷新后再试");
	      	return false;
	      }
	  });
}
// 跳转到上一个人的日志批注中
function upreply(){
	var ids=$("#ids").val();
	var count=$("#num").val();
	var num=parseInt(count)-parseInt(1);
	window.location.href="batchreplyWorkLogNewportal.do?ids="+ids+"&count="+num;
}
//跳转到下一个人的日志批注中
function downreply(){
	var ids=$("#ids").val();
	var count=$("#num").val();
	var num=parseInt(count)+parseInt(1);
	window.location.href="batchreplyWorkLogNewportal.do?ids="+ids+"&count="+num;
}
</script>
</head>
  
<body>
<c:if test="${worklog.type==0}">    
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;部门办公&gt;<span class="wzcs">部门日志</span>&gt;<span class="wzcs">批量批阅</span> &nbsp;&nbsp;&nbsp;&nbsp;
<span style="float: right;">
	<span class="wzls">姓名：</span>${worklog.employeeByEmpId.name } &nbsp;&nbsp;&nbsp;&nbsp;
	<span class="wzls">部门：</span>${worklog.employeeByEmpId.department.name }&nbsp;&nbsp;&nbsp;&nbsp;
	<span class="wzls">时间:</span>${worklog.recordTime }
</span>
</div>
</div>
<div class="main">
<div class="rz_box">
	<div class="title" >任务进度</div>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#e7e7e7" class="list">
  <tr>
    <th width="32%">工作内容</th>
    <th width="14%">完成效果</th>
    <th width="36%">效果描述</th>
    <th width="18%">操作</th>
  </tr>
  <!-- 查询今日添加的记事内容  -->
  <c:forEach items="${schelist}" var="plan">      
	  <tr>
	    <td height="30" align="center">
			 <c:if test="${fn:length(plan.workcontent)>20}">
			   ${fn:substring(plan.workcontent, 0, 20)}...
			</c:if> 
			<c:if test="${fn:length(plan.workcontent)<20}">
			   ${plan.workcontent}
			</c:if> &nbsp;
        </td>
	    <td height="30" align="center"><c:if test="${plan.state==0}">未完成</c:if><c:if test="${plan.state==1}">完成</c:if>&nbsp;</td>
	    <td height="30">
            <c:if test="${fn:length(plan.tmp)>20}">
			   ${fn:substring(plan.tmp, 0, 20)}...
			</c:if> 
			<c:if test="${fn:length(plan.tmp)<20}">
			   ${plan.tmp}
			</c:if> &nbsp;
        </td>
	    <td height="30" align="center" class="wzls">
	         <a href="javascript:lookSch(${plan.id });" style="color:#3b8801">详情</a>&nbsp;
	         <a href="javascript:logmessage(${plan.id });" style="color:#3b8801"> 问询</a>&nbsp;立项</td>
	  </tr>
  </c:forEach>
 
</table>
 </div>
</div>
<div class="main">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="44%" height="30" align="right" class="wzls">工作日志</td>
    <td width="56%" height="30" align="right" class="wzls">今天很高兴&nbsp;<%=nowstr %></td>
  </tr>
</table>

</div>
<div class="wbbd">
<div class="rz_box">
	<div class="title" >个人总结</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr  >
    <td width="13%">&nbsp;</td>
    <td width="77%" class="gz_rz">
         <input type="hidden" name="id" id="id" value="${worklog.id }">
		 <input type="hidden" name="type" id="type" value="${worklog.type }">
		 <input type="hidden" name="audid" id="audid" value="${audid}">
		 <input type="hidden" id="logno" value="${worklog.logNo }" />
		 <input type="hidden" id="ids" value="${ids}"/>
		 <input type="hidden" id="num" value="${num }" />
		 <c:if test="${worklog.workresult == null || worklog.workresult == ''}">暂无总结</c:if>
		 <c:if test="${worklog.workresult != null && worklog.workresult != ''}">${worklog.workresult}</c:if>
    </td>
    <td width="10%">&nbsp;</td>
    </tr> 
</table>
 </div>
</div>
<!-- 如果写日志的人投诉的是本级领导或其它部门时则本级领导可看 -->
<c:if test="${worklog.employeeByEmpId.department.employee.id==emp.id}">
<c:if test="${worklog.tsjyflag==1 || worklog.tsjyflag==3}">
<c:if test="${worklog.suggestion != null && worklog.suggestion != ''}">
<div class="wbbd">
<div class="rz_box">
	<div class="title" >投诉建议</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td width="13%">&nbsp;</td>
    <td width="77%" class="gz_rz"> 
                 投诉级别：<c:if test="${worklog.tsjyflag==1}">本级领导</c:if><c:if test="${worklog.tsjyflag==3}">跨部门</c:if> 
    </td>
    <td width="10%">&nbsp;</td>
    </tr>
  <tr>
    <td width="13%">&nbsp;</td>
    <td><table width="77%" border="0" cellspacing="0" cellpadding="0" class="ts_nr">
      <tr>
        <td>
		   ${worklog.suggestion}
        </td>
      </tr>
    </table>
    </td>
    <td width="10%">&nbsp;</td>
    </tr> 
</table>
 </div>
</div>
</c:if>
</c:if>
</c:if> 
<c:if test="${worklog.accessory!=null}">
<div class="wbbd">
<div class="rz_box">
	<div class="title" >附件</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td width="13%">&nbsp;</td>
    <td width="77%" class="gz_rz"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="11%" height="50" align="right">
       <div>
	       <c:if test="${fn:endsWith(worklog.accessory,'.txt')}">
	          <img src="<%=path %>/potal/images/icon/txt.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.png')}">
	          <img src="<%=path %>/potal/images/icon/pdf.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.jpg') || fn:endsWith(worklog.accessory,'.jpeg')}">
	          <img src="<%=path %>/potal/images/icon/jpggs.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.rar') || fn:endsWith(worklog.accessory,'.zip')}">
	          <img src="<%=path %>/potal/images/icon/book.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.doc') || fn:endsWith(worklog.accessory,'.docx')}">
	          <img src="<%=path %>/potal/images/icon/doc.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.xls') || fn:endsWith(worklog.accessory,'.xlsx')}">
	          <img src="<%=path %>/potal/images/icon/exl.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.bmp')}">
	          <img src="<%=path %>/potal/images/icon/bmp.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.gif')}">
	          <img src="<%=path %>/potal/images/icon/gif.jpg" width="25" height="32" />
	       </c:if>
	       <c:if test="${fn:endsWith(worklog.accessory,'.pdf')}">
	          <img src="<%=path %>/potal/images/icon/pdf.jpg" width="25" height="32" />
	       </c:if>
       </div>
    </td>
    <td width="89%" height="50" align="left" class="gz_rz"><P>${worklog.accessory }</P>
	<P><span><a href="javascript:void();" onclick="xzfj('${worklog.accessory}')">预览下载</a></span></P>
	</td>
  </tr>
</table>
</td>
    <td width="10%">&nbsp;</td>
    </tr> 
</table>
</div>
</div>
</c:if>
</c:if>
<!-- 以上是显示的是日志信息 -->
<c:if test="${worklog.type!=0}">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td>
      <span class="wzls">您的位置</span>：首页&gt;部门办公&gt;<span class="wzcs">部门日志</span>&gt;<span class="wzcs">批量批阅</span> &nbsp;&nbsp;&nbsp;&nbsp;
    </td>
  </tr>
  <tr><td><br/></td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tdmg">
  <tr>
    <td width="35%"><span class="wzls"> 姓名：</span>${worklog.employeeByEmpId.name }</td>
    <td width="30%"><span class="wzls">所属部门：</span>${worklog.employeeByEmpId.department.name }</td>
    <td width="35%" align="right" class="ttx"><span class="wzls">时间:</span>${worklog.recordTime }</td>
  </tr>
</table>
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0" class="list">
  <tr>
    <c:if test="${worklog.type==1}">
	    <td   class="rz_title">本<br />
	    周<br />计<br />划</td>
    </c:if>
    <c:if test="${worklog.type==2}">
	    <td   class="rz_title">本<br />
	    月<br />计<br />划</td>
    </c:if>
    <td   class="rz_content">
    <input type="hidden" name="id" id="id" value="${worklog.id }">
	<input type="hidden" name="type" id="type" value="${worklog.type }">
    <input type="hidden" name="audid" id="audid" value="${audid}">
    <input type="hidden" id="ids" value="${ids}"/>
    <input type="hidden" id="num" value="${num }" />
    <table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0" class="">
      <tr>
        <td> 
			${weLogInfo[0]}
	    </td>
      </tr>
    </table></td>
  </tr>
</table><table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0" class="list">
  <tr>
    <c:if test="${worklog.type==1}">
	    <td   class="rz_title">本<br />
	    周<br />工<br />作</td>
    </c:if>
    <c:if test="${worklog.type==2}">
	    <td   class="rz_title">本<br />
	    月<br />工<br />作</td>
    </c:if>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>${weLogInfo[1]} </td>
      </tr>
    </table></td>
  </tr>
</table><table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td   class="rz_title">工<br />
    作<br />
    备<br />
    注</td>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>${weLogInfo[2]}</td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0" class="list">
  <tr>
  <c:if test="${worklog.type==1}">
	    <td   class="rz_title"><p>下<br />
	    周<br />工<br />作<br />
	    计<br />划</p></td>
  </c:if>
   <c:if test="${worklog.type==2}">
	    <td   class="rz_title"><p>下<br />
	    月<br />工<br />作<br />
	    计<br />划</p></td>
  </c:if>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>${weLogInfo[3]}</td>
      </tr>
    </table></td>
  </tr>
</table>
</c:if>
<!-- 以上显示的是周，月志信息 -->
<c:if test="${not empty replyList}">
<div class="wbbd">
<div class="rz_box">	
		<div class="title" >已有批阅</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<c:forEach items="${replyList}" var="audit">
		  <tr class="py">
		    <td width="13%">&nbsp;</td>
		    <td width="77%" class="gz_rz">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
			      <tr>
			        <td align="left">${audit.employeeByInceptemp.name }&nbsp;<span id="hssj">${audit.auditingtime}</span><span style="margin-left: 50px;" class="hszt">${audit.grade}</span></td>
			      </tr>
			      <tr>
			        <td align="left">${audit.tmp }</td>
			      </tr>
			      <tr>
			        <td class="wzls">&nbsp;<span name="${audit.id}" onclick="back(this)" style="display: none;">回复</span></td>
			      </tr>
			      <tr id="fb${audit.id}" style="display: none;">
			        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
			          <tr>
			            <td>
			              <table>
			              <tr><td align="center">
			                <textarea id="xzjh" class="borderstyle" style="overflow:auto;"></textarea></td>
			              </tr>
			              <tr>
			                <td align="right">
			                   <input type="button" name="${audit.id }" value="取消" style="align:right;" onclick="hide(this)" />
			                   <input type="button" value="发表" style="align:right;"/>
			                </td>
			             </tr>
			              </table>  
			            </td>
			          </tr>
			          
			        </table></td>
			      </tr>
			    </table>
		    </td>
		    <td width="10%">&nbsp;</td>
		   </tr>
		   <tr>
			   <td width="13%">&nbsp;</td>
			   <td width="77%">
			      <hr width="100%" style="border: 1px solid #cccccc;"/>
			   </td>
			   <td width="10%">&nbsp;</td>
		   </tr>
		 </c:forEach>
		</table>
 </div>
</div>
</c:if>
<c:if test="${flag==1}">
<div class="wbbd">
<div class="rz_box">
	<div class="title" >批阅</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
	  <tr>
	    <td width="13%">&nbsp;</td>
	    <td width="77%" class="gz_rz" height="45">
	       <table>
	          <tr>
	             <td>
		             <div class="goods-comm">
		                <div class="goods-comm-stars">
							<span class="star_l">满意度：</span>
							<div id="rate-comm-1"  class="rate-comm"  border="1px solid red"></div>
						    <input type="hidden" name="grade" id="StarNum" value="" />
							<input type="hidden" id="path" value="<%=path %>" />
						</div>
					 </div>
	             </td>
	          </tr>
	          <tr>
	             <td><textarea name="content" id="py" class="textarea" style='width:550px;height:0px;visibility:hidden;'></textarea></td>
	          </tr>
	       </table>
	    </td>
	    <td width="10%">&nbsp;</td>
	    </tr> 
	</table>
</div>
</div>
</c:if>
<div class="main" id="an_bj">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <c:if test="${flag==1}"> 
	  <tr>
	    <td width="25%" align="center">&nbsp;</td>
	    <td width="25%" align="center">
	     <div class="gb_bt" onclick="batchreply()" style="width: 40px;">确认</div>
	    </td>
	    <td width="25%" align="center"><div class="gb_bt" onclick="javascript:history.go(-1);" style="width: 40px;">返回</div></td>
	    <td width="25%" align="center">&nbsp;</td>
	  </tr>
  </c:if>
  <c:if test="${flag!=1}"> 
	  <tr>
	    <td width="25%" align="center">&nbsp;</td>
	    <td width="25%" align="center">
	      <c:if test="${num==1}"><div class="gb_bt2" style="width: 40px;">上一条</div></c:if>
	      <c:if test="${num!=1}"><div class="gb_bt" onclick="upreply()" style="width: 40px;">上一条</div></c:if>
	    </td>
	    <td width="25%" align="center">
	       <c:if test="${num==len}"><div class="gb_bt2" style="width: 40px;">下一条</div></c:if>
	       <c:if test="${num!=len}"><div class="gb_bt" onclick="downreply()" style="width: 40px;">下一条</div></c:if>
        </td>
	    <td width="25%" align="center">&nbsp;</td>
	  </tr>
  </c:if>
</table>
</div>
<div class="foot_box">
    <ul>
       <c:forEach items="${list}" var="worklog" varStatus="count">
            <c:if test="${count.count==num}"><li class="title1"><span style="cursor: pointer;" onclick="batch(${count.count})">${worklog.employeeByEmpId.name }</span></li></c:if>
       		<c:if test="${count.count!=num}"><li><span  style="cursor: pointer;"  onclick="batch(${count.count})">${worklog.employeeByEmpId.name }</span></li></c:if>   
       </c:forEach>
    </ul>
</div>

<!-- 弹出层 -->
<div id="addorUpdSuppers">
	<div id="addorUpd"></div>
</div>
<!-- 弹出一行 -->
<div id="addrow" class="d2"></div>

</body>
</html>
