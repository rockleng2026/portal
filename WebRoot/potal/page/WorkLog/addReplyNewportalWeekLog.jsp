<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Date now=new Date();
java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String nowstr=dateFormat2.format(now);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加周志月志批注</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />

<style type="text/css">
body{color:#292727; font-size:14px;margin-left:15px; width:760px;}
.tdmg{ margin-top:29px;}
.list{font-size:12px;}
.ttx{ color:#4fa805;size:14px; padding-right:10px;}
.border_grey{ border:1px solid #C6C6C6; margin-top:4px;}
.rz_title { width:28px; background-color:#295900;}
.rz_title { color:#fff; font-size:14px; font-weight:bold; padding:20px 0 20px 0; text-align:center;}
.rz_content{ padding:10px;}
.gb_bt1{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center;margin-right:50px; float:right;}
.gb_bt2{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:50px; float:left}
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
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.ltj { color:#3b8801;  line-height:25px; margin: 0 0 0 auto; width:130px;}
 .rz_box .title{width:85px; line-height:25px; background-color:#4FA805; position:absolute; color:#fff; font-size:13px; font-weight:bold; text-align:center;}
 .rz_box .list th{ height:35px; background-color:#EDEDED;}
 .gz_rz { line-height:25px; padding-left:5px;}
 .gz_rz p{ line-height:25px;}
 .gz_rz p span { color:#e0731e;}
 .gz_rz p span a { color:#e0731e;}
 .wbbd { width:760px; border-bottom:1px solid #c6c6c6; border-left:1px solid #c6c6c6; border-right:1px solid #c6c6c6; margin:auto auto 5px auto;}
 .ts_nr { border-top:1px solid #c6c6c6;  margin:0 0 5px 0; line-height:25px; padding-left:5px;}
 .sc_fj { width:730px; line-height:30px; background-color:#ededed; padding-left:10px; margin:5px auto 5px 10px;}
 #an_bj { margin:15px auto 90px auto;}
#hssj { color:#abaaaa;}
.hszt { color:#ff0000;}
<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:25px; 
text-align:center; margin-left:auto; margin-right:auto; border: 2px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
 a{text-decoration: none;}
.msg_green{ border:#4FA805 1px solid; line-height:20px; background-color:#FFF;width:223px;}
.msgshow_green .c2{background:url(images/c2.png) no-repeat 100px 0px; height:11px; position:relative; margin-bottom:-1px;  z-index:1; }
.size{ font-size:14px;}
.dvr{ float:right; margin-right:105px;}
.ip_4{ border:1px solid #a2b3bd; padding:0px; margin:0px; float:left}
.borderstyle{
   border:1px solid #ccc;
   width:500px; height:80px;
}
.d2{z-index: 100004;position:absolute;left:6%;top:22%;}

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
</style>

<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/coverComment.js"></script>
<LINK href="<%=request.getContextPath() %>/potal/css/index.css" type="text/css" rel="stylesheet">

<script type="text/javascript">
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
function ensureclick(id){
	var loc = "seeReplyWorkLogNewportal.do?id="+id;
	window.location = loc;
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

//批阅操作
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
//弹出层
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
	  showDiv('addorUpdSuppers',800,1,1);      
 }
</script>
</head>
 <body>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td>您的位置：首页&gt;办公桌面&gt;添加批注</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tdmg">
  <tr>
    <td width="35%">
            姓名：${worklog.employeeByEmpId.name }</td>
    <td width="30%">所属部门：${worklog.employeeByEmpId.department.name }</td>
    <td width="35%" align="right" class="ttx">&nbsp;
    </td>
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

<div class="wbbd">
<div class="rz_box">	
	<c:if test="${empty replyList}">暂无上级批阅</c:if>
	<c:if test="${not empty replyList}">
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
	</c:if>
 </div>
</div>
<div class="wbbd">
<div class="rz_box">
	<div class="title" >批阅</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
	  <tr  >
	    <td width="13%">&nbsp;</td>
	    <td width="77%" class="gz_rz" height="45">
	       <textarea name="content" id="py" class="textarea" style='width:550px;height:0px;visibility:hidden;'></textarea>
	    </td>
	    <td width="10%">&nbsp;</td>
	    </tr> 
	</table>
 </div>
</div>

<div class="wbbd">
<div class="rz_box">
	<div id="showjl" class="title" onclick="showHistory()" style="cursor: pointer;">展开访问记录</div>
	<div id="hidejl" class="title" onclick="hideHistory()" style="cursor: pointer;display: none;">隐藏访问记录</div>
	<table width="100%" border="0" id="history" cellspacing="0" cellpadding="0" class="list" style="display: none;">
	  <tr>
	    <td width="13%">&nbsp;</td>
	    <td width="77%" class="gz_rz">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
		      <c:forEach items="${recordList}" var="record">
		      　　　　　<td　height="45">${record.employee.name }&nbsp;<span id="hssj">${record.executeTime }</span>&nbsp;丨</td>
			　</c:forEach>
	      </tr>
	    </table></td>
	    <td width="10%">&nbsp;</td>
	  </tr> 
   </table>
 </div>
</div>
<div class="main" id="an_bj">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
  <tr>
    <td width="25%" align="center">&nbsp;</td>
    <td width="25%" align="center"><div class="gb_bt" onclick="addcus()" style="cursor: pointer;">确认</div></td>
    <td width="25%" align="center"><div class="gb_bt" onclick="javascript:history.go(-1);" style="cursor: pointer;">返回</div></td>
    <td width="25%" align="center">&nbsp;</td>
  </tr>
</table>
</div>

<!-- 弹出层 -->
<div id="addorUpdSuppers">
	<div id="addorUpd"></div>
</div>
 </body>
</html>
