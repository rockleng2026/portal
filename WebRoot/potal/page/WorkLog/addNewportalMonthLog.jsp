<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Date now=new Date();
java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String nowstr=dateFormat2.format(now);
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>写月志</title>
    
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
<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:22px; height:22px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
 a{text-decoration: none;}
.gb_bt2{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:50px; float:left}
.msg_green{ border:#4FA805 1px solid; line-height:20px; background-color:#FFF;width:223px;}
.msgshow_green .c2{background:url(images/c2.png) no-repeat 100px 0px; height:11px; position:relative; margin-bottom:-1px;  z-index:1; }
.size{ font-size:14px;}
.dvr{ float:right; margin-right:105px;}
.ip_4{ border:1px solid #a2b3bd; padding:0px; margin:0px; float:left}
.borderstyle{
   border:1px solid #ccc;
   width:700px; height:115px;
}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/potal/js/someJs.js"></script>
<script type="text/javascript">
function parseMessage() {
	var bzjh=$("#bzjh").val();
	var bzgz=$("#bzgz").val();
	var gzbz=$("#gzbz").val();
	var xzjh=$("#xzjh").val();
	
	    if(bzjh.length<=0 || "" == content){
	    	alert('本月计划不能为空！');
	    	return false;
	    }
	    if(bzgz<=0 || "" == content){
	    	alert('本月工作不能为空！');
	    	return false;
    	}
	    if(gzbz.length<=0 || "" == content){
	    	alert('工作备注不能为空！');
	    	return false;
   		}
	   if(xzjh.length<=0 || "" == content){
	    	alert('下月计划不能为空！');
	    	return false;
	    }
	    var content=bzjh+"|"+bzgz+"|"+gzbz+"|"+xzjh;
	    $("#content").val(content);
		Form1.submit();
		return true;
}	
</script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>

</head>
 <body>
<form id="Form1" method="post" action="addToWorkLogNewportal.do">
<s:token></s:token>
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr style="font-size: 12px;">
    <td>您的位置：首页&gt;办公桌面&gt;工作日志&gt;<span style="color: red;">工作月志</span></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tdmg">
  <tr style="font-size: 12px;">
    <td width="35%">
            姓名：${emp.name }</td>
    <td width="30%">所属部门：${emp.department.name }</td>
    <td width="35%" align="right" class="ttx"> 
        &nbsp;
    </td>
  </tr>
</table>
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
  <tr>
    <td   class="rz_title">本<br />
    月<br />计<br />划</td>
    <td   class="rz_content">
    <input type="hidden" name="workLog.type" id="type" value="2">
    <input type="hidden" name="workLog.content" id="content" value="">
    <table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0" class="">
      <tr>
        <td> 
<textarea id="bzjh" class="borderstyle" style="overflow:auto;">
1.计划完成任务一


2.计划完成任务二


3.计划完成任务三
</textarea>
	    </td>
      </tr>
    </table></td>
  </tr>
</table><table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
  <tr>
    <td   class="rz_title">本<br />
    月<br />
    工<br />
    作</td>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><textarea id="bzgz" class="borderstyle" style="overflow:auto;">
1.完成任务一


2.完成任务二


3.完成任务三
</textarea></td>
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
        <td><textarea id="gzbz"  class="borderstyle" style="overflow:auto;">
1.任务一详情与分析 


2.任务二详情与分析 


3.任务三详情与分析 
</textarea></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" class="border_grey"  cellspacing="0" cellpadding="0">
  <tr>
    <td   class="rz_title"><p>下<br />
    月<br />工<br />作<br />
    计<br />划</p></td>
    <td   class="rz_content"><table height="115px" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><textarea id="xzjh" class="borderstyle" style="overflow:auto;">
1.完成任务一 


2.完成任务二


3.完成任务三
</textarea></td>
      </tr>
    </table></td>
  </tr>
  <tr>
     <td colspan="2" align="center"><input type="button" class="gb_bt" onclick="parseMessage()" value="保存"/>&nbsp;&nbsp;<input type="button" onclick="history.go(-1)" class="gb_bt" value="返回" /></td>
  </tr>
</table>

</form>
 </body>
</html>
