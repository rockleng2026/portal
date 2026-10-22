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
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>写日志</title>
    
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
.rz_box{ border-top:2px solid #4FA805;}
.main { width:760px; margin:0 auto;}
.main1{width:750px; margin:0 auto; text-align:center}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.ltj { color:#3b8801;  line-height:25px; margin: 0 0 0 auto; width:330px;}
 .rz_box .title{width:85px; line-height:25px; background-color:#4FA805; position:absolute; color:#fff; font-size:13px; font-weight:bold; text-align:center;}
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
.gb_bt{ background-color:#4FA805; font-size:12px;color:#fff; line-height:22px; height:22px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
 a{text-decoration: none;color:#4FA805;}
 #hssj { color:#abaaaa;}
 .hszt { color:#ff0000;}
  .hs_bt{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;}
.d2{z-index: 100004;position:absolute;left:6%;top:22%;}
</style>
<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="<%=path %>/js/jquery-1.4.js"></script>
<script>
var editor;
KindEditor.ready(function(K) {
	editor = K.create('textarea[id="workresult"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
	});
});
var tsjyeditor;
KindEditor.ready(function(K) {
	tsjyeditor = K.create('textarea[id="suggestion"]', {
		resizeType : 1,
		allowPreviewEmoticons : false,
		allowImageUpload : false,
		items : [
'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
	});
});

// 点击保存
function parseMessage() {
	// 得到选中的投诉建议
	var ra=$(":radio:checked").val();
	if(ra!='null' && ra!='undefined'){
		$("#tsjy").val(ra);
	}
	// 得到选中的部门
	var radept=$("input[name='dept']:checked").val();
    $("#deptid").val(radept);
	editor.sync(); 
	tsjyeditor.sync();
	var result = confirm("日志一天只能提交一次，你确定提交吗！");
	if(result == true){
	    var content = $("#workresult").val();
	    if( content == null || content == ''){
	   		alert("请填写个人总结!");
	   		return false;
	   	}
	   	var reg=new RegExp("<br />","g"); 
	   	content = content.replace(reg,"\r\n");
		$("#content").val(content);
		$("#wresult").val(content);
		form1.action="<%=path %>/addToWorkLogNewportal.do";
		form1.submit();
		return result;
	}else{
		return result;
	}
}

// 弹出添加一行。
function addrow()
{
	 $("#addrow").load("<%=path%>/potal/page/WorkLog/addRow.jsp");
	 $("#addrow").css("display","block");
}

function yingcang()
{
	 $("#addrow").css("display","none");
}

//弹出查看详情操作
function lookSch(id)
{
	 $("#addrow").load("<%=path%>/lookSchWorkLogNewportal.do?schid="+id);
	 $("#addrow").css("display","block");
}
function hideemps(){
    $("#dept").hide();
}
function kbm(){
	$("#dept").show();
}
function fanhui(){
	history.go(-1);
}
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/someJs.js"></script>
</head>
  
  <body>
    
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;个人办公&gt;<span class="wzcs">日志列表</span>
</div>
</div>
<div class="main1">
<div class="ltj">
 <span style="color:red">新增工作记事请点击右边>></span>
 <a href="javascript:addrow();" style="font: bold;cursor: pointer;"  onmouseover="changeColor(this)" onmouseout="huifuColor(this)">添加一行</a>
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
  <!-- 查询今日添加的记事内容 -->
  <c:if test="${empty workList}">
     <tr><td colspan="4" align="center">暂无工作记事</td></tr>
  </c:if>
  <c:forEach items="${workList}" var="plan">      
	  <tr>
	    <td height="30" align="center">
		    <c:if test="${fn:length(plan.workcontent)>20}">
			   ${fn:substring(plan.workcontent, 0, 20)}...
			</c:if> 
			<c:if test="${fn:length(plan.workcontent)<20}">
			   ${plan.workcontent}
			</c:if> &nbsp;
		</td>
	    <td height="30" align="center"><c:if test="${plan.state==0}">未完成</c:if><c:if test="${plan.state==1}">完成</c:if>&nbsp; </td>
	    <td height="30"> 
	       <c:if test="${fn:length(plan.tmp)>20}">
			   ${fn:substring(plan.tmp, 0, 20)}...
			</c:if> 
			<c:if test="${fn:length(plan.tmp)<20}">
			   ${plan.tmp}
			</c:if> &nbsp;
	     </td>
	    <td height="30" align="center" class="wzls">
	           	<a href="javascript:lookSch(${plan.id });" name="UpPwd">详情</a>&nbsp;&nbsp;<a  name="UpPwd">立项</a>
	    </td>
	  </tr>
  </c:forEach>
</table>
 </div>
</div>
<div class="main">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td width="44%" height="30" align="right" class="wzls">工作日志</td>
    <td width="56%" height="30" align="right" class="wzls">今天很高兴&nbsp;<%=nowstr %></td>
  </tr>
</table>

</div>
<form id="form1" name="form1" action="" method="post">
<s:token></s:token>
<input type="hidden" id="content" name="workLog.content">
<input type="hidden" id="wresult"  name="workLog.workresult" />
<input type="hidden" name="type" id="workLog.type" value="0">
<input type="hidden" name="depts" id="deptid" value="" />
<div class="wbbd">
<div class="rz_box">
	<div class="title" >个人总结</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr  >
    <td width="13%">&nbsp;</td>
    <td width="77%" class="gz_rz">
		<textarea id="workresult"  class="textarea" style='width:550px;height:0px;visibility:hidden;'></textarea>
    </td>
    <td width="10%">&nbsp;</td>
    </tr> 
</table>
 </div>
</div>
<div class="wbbd">
<div class="rz_box">
	<div class="title" >投诉建议</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
    <tr>
	    <td width="13%">&nbsp;</td>
	    <td>
	      <table width="77%" border="0" cellspacing="0" cellpadding="0" class="list">
		      <tr>
			    <td width="20%" align="right">投诉建议：<input type="hidden" id="tsjy" name="workLog.tsjyflag" value="0" /></td>
			    <td width="20%"><input type="radio" name="radio2" id="radio1" value="1"/>本级领导</td>
			    <td width="20%"><input type="radio" name="radio2" id="radio2" value="2" />上级领导</td>
			    <td width="20%"><input type="radio" name="radio2" id="radio3" value="3" onclick="kbm()" />跨部门</td>
			    <td width="20%"><input type="radio" name="radio2" id="radio4" value="4" />总经办</td>
		      </tr>
	      </table>
	    </td>
	    <td width="10%">&nbsp;</td>
    </tr>
  <tr>
    <td width="13%">&nbsp;</td>
    <td><table width="77%" border="0" cellspacing="0" cellpadding="0" class="list">
      <tr>
        <td>
          <textarea  name="workLog.suggestion" id="suggestion"  class="textarea" style='width:550px;height:0px;visibility:hidden;'></textarea>
        </td>
      </tr>
    </table>
    </td>
    <td width="10%">&nbsp;</td>
    </tr> 
</table>
 </div>
</div>
</form>
<div class="wbbd">
<div class="rz_box">
	<div class="title" >附件</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
     <tr>
       <td width="13%">&nbsp;</td>
       <td width="77%" align="right">上传附件：
          <jsp:include page="uploadfiles.jsp"></jsp:include>
       </td>
       <td width="10%">&nbsp;</td>
     </tr>
   </table>
</div>
</div>
<div class="main" id="an_bj">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td width="25%" align="center">&nbsp;</td>
    <td width="25%" align="center"><input class="gb_bt"  type="button" onclick="parseMessage()" value="确认"/></td>
    <td width="25%" align="center"><input class="gb_bt" type="button" onclick="fanhui()" value="返回" /></td>
    <td width="25%" align="center">&nbsp;</td>
  </tr>
</table>
</div>
<!-- 弹出一行 -->
<div id="addrow" class="d2"></div>
<!-- 部门列表 -->
<div id="dept" style="position: absolute;left: 300px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:left;font-weight:bold;">选择部门列表</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideemps();" style="text-decoration: none;">确定</a>&nbsp;&nbsp;<a href="javascript:hideemps();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
        <c:forEach items="${deptlist}" var="dept">
         <tr>
           <td><input type="radio" name="dept" value="${dept.id}" />${dept.name } </td>
         </tr>
        </c:forEach>
     </table>
   </div>
</div>

</body>
</html>
