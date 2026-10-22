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
    
    <title>显示周志</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />

<style type="text/css">
body{color:#292727; font-size:12px;margin-left:15px; width:760px;}
.tdmg{ margin-top:29px;}
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
   width:700px; height:115px;
}
.borderstyle2{
   border:1px solid #ccc;
   width:500px; height:80px;
}
</style>
<script type="text/javascript">
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
</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>

</head>
 <body>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>您的位置：首页&gt;办公桌面&gt; <c:if test="${worklog.type==1}">工作周志</c:if><c:if test="${worklog.type==2}">工作月志</c:if></td>
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
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
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
    <input type="hidden" name="workLog.type" id="type" value="1">
    <input type="hidden" name="workLog.content" id="content" value="">
    <table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0" class="">
      <tr>
        <td> 
			${weLogInfo[0]}
	    </td>
      </tr>
    </table></td>
  </tr>
</table><table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
  <tr>
  <c:if test="${worklog.type==1}">
    <td   class="rz_title">本<br />
    周<br />
    工<br />
    作</td>
 </c:if>
 <c:if test="${worklog.type==2}">
    <td   class="rz_title">本<br />
    月<br />
    工<br />
    作</td>
 </c:if>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>${weLogInfo[1]} </td>
      </tr>
    </table></td>
  </tr>
</table><table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
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
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
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
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
		<c:forEach items="${replyList}" var="audit">
		  <tr class="py">
		    <td width="13%">&nbsp;</td>
		    <td width="77%" class="gz_rz">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
			                <textarea id="xzjh" class="borderstyle2" style="overflow:auto;"></textarea></td>
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
<div class="main" id="an_bj">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
        <c:choose>
                <c:when test="${worklog.isView == 1 && isMy == 0}">
                	<div class="gb_bt" onclick="ensureclick('${worklog.id }')" style="cursor: pointer;width: 80px;" name="sureBtn" id="surenBtn">确认查看</div>
	        	</c:when>
	        	<c:otherwise>
	        		<div class="gb_bt" onclick="javascript:history.go(-1);" style="cursor: pointer;width: 40px;"  name="returnBtn" id="returnBtn">返回</div>
		      </c:otherwise>
		</c:choose>
    </td>
  </tr>
</table>
</div>
 </body>
</html>
