<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<% SimpleDateFormat formatter = new  SimpleDateFormat("yyyy-MM-dd"); 
    Date currentTime = new Date(); //得到系统时间
	String date = formatter.format(currentTime);
 %>
<% String path = request.getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>新增一行的弹出框</title>

<style type="text/css"> 
.n{width:760px; margin:0 auto; font-size:12px;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:692px; height:230px; float:left}
.dow_top{width:692px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{font-size:12px;width:700px; border:1px solid #455c32;float:left;height:auto;background:white;}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{width:145px; height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; clear:both}
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}
.zysh { background-color:#7c7c7c; color:#fff; line-height:20px; width:70px; text-align:center; margin-right:150px;}
.jcjg { width:541px; height:75px; background-color:#f0f0f0; border:1px solid #adadad; line-height:20px;}
.jcjg span { color:#fa905e;}
.xhbt { color:#fe0000;}
	<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:22px; height:22px;
text-align:center; margin-left:auto; margin-right:auto; border: 1px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
a{text-decoration: none;}
.border_grey tr td{ border:1px solid #C6C6C6; margin-top:4px;}

.xq_main { width:760px; margin:0 auto;background-color: #ffffff;}
.xq_wzdh { line-height:25px;}
.xq_wzls { color:#3b8801;}
.xq_wzcs { color:#ff6600;}
.xq_dow{width:760px; height:230px; float:left}
.xq_dow_top{width:760px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden; margin-bottom:10px;}
.xq_dow_top span{float:right; padding-right:10px; padding-top:1px;}
.xq_dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
	 ul ,ul li{ margin:0px; padding:0px; list-style:none;}
	.xq_sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; }
	.xq_sp_nav_tab .xq_nomarl{ width:105px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#EAFED9;}
	.xq_sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
	.xq_sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
	.xq_sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
	.xq_font_color_hui{ color:#8c8c8c;}
	.xq_font_color_lv{ color:#295a01;}
.xq_dow_top {width:760px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.xq_gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto; border:0} 
.bg_xxx {border-bottom: 1px dashed #3b8401;}
.xb_gznr { line-height:25px; background-color:#eeeeee; width:500px; padding-left:15px;}
.xb_xgms { width:500px; line-height:20px; padding-top:15px; padding-left:15px; padding-right:15px; background-color:#eeeeee;}
.xb_lbk { border:1px solid #295a01; background-color: #ffffff;}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/jsalidators.js" ></script>
<script type="text/javascript">
    // 切换是否完成操作
    function isFinish(m){
        $("#state").val(m);
        $("#isOkState").val(m);
        $("#yqtime").hide();
    }
    function isFinish2(m){
        $("#state").val(m);
        $("#isOkState").val(m);
        $("#yqtime").show();
    }
    function isOkNtId(m,n)
    {
    	 $("#ntId").val(m);
    	 $("#fanwei1").val(100-n);
    	 document.getElementById("fanwei").innerHTML=" 任务进度还剩下"+(100-n)+"%";
		
        }
    // 判断非空验证
    function check(){
        var begintime=$("#begintime").val();
        var endtime=$("#endtime").val();
        var selbegintime=$("#selbegintime").val();
        var selendtime=$("#selendtime").val();
        var workcontent=$("#workcontent").val();
        var jingdu=$("#jingdu").val();
        var fanwei1=$("#fanwei1").val();
        var ntId=$("#ntId").val();
       
        if(begintime.length<=0 && selbegintime.length<=0){
            alert("开始时间不能为空！");
            return false;
        }
        if(endtime.length<=0 && selendtime.length<=0){
            alert("结束时间不能为空！");
            return false;
        }
        if((jingdu-fanwei1)>0)
        {
			alert("超出进度范围");
			return false;
         }
        if(jingdu!=fanwei1)
        {
			document.getElementById("state").value="0";
         }
        if(workcontent.length<=0){
            alert("工作内容不能为空！");
            return false;
        }
    }
    
    function showbeginXuanZeBtn()
    {
    	 $("#beginMsg").hide();
    	 $("#beginXuanZeBtn").show();
    }
    
    function showendXuanZeBtn()
    {
   		 $("#endMsg").hide();	
    	 $("#endXuanZeBtn").show();
    }
    
    // 开始时间失去交点事件
    function begmsg(){
    	 var begintime=$("#begintime").val();
    	 if(begintime.length<=0){
              $("#beginMsg").show();
              $("#beginXuanZeBtn").hide();
    	 }else{
    		 $("#beginMsg").hide();
    		 $("#beginXuanZeBtn").show();
         }
    }
    // 结束时间失去交点事件
    function endmsg(){
    	var endtime=$("#endtime").val();
    	 if(endtime.length<=0){
        	$("#endMsg").show();
        	 $("#endXuanZeBtn").hide();
    	 }else{
    		$("#endMsg").hide();
    		 $("#endXuanZeBtn").show();
         }
    }
    // 工作内容失去交点事件
    function gzrnmsg(){
    	 var workcontent=$("#workcontent").val();
    	 if(workcontent.length<=0){
        	$("#gzrnMsg").show();
    	 }else{
    		 $("#gzrnMsg").hide();
         }
        
    }
</script>
<script type="text/javascript">
$(function(){
	// 自定义按钮事件
	$("#beginZiDingYiBtn").click(function(){
		$("#beginZiDingYi").css("display","none");
		$("#beginXuanZe").css("display","block");
		$("#selbegintime").attr("name","");
		$("#begintime").attr("name","sch.begintime");
	});
	
	$("#beginXuanZeBtn").click(function(){
		$("#beginZiDingYi").css("display","block");
		$("#beginXuanZe").css("display","none");
		$("#selbegintime").attr("name","sch.begintime");
		$("#begintime").attr("name","");
	});
	$("#endZiDingYiBtn").click(function(){
		$("#endZiDingYi").css("display","none");
		$("#endXuanZe").css("display","block");
		$("#selendtime").attr("name","");
		$("#endtime").attr("name","sch.endtime");
	});
	
	$("#endXuanZeBtn").click(function(){
		$("#endZiDingYi").css("display","block");
		$("#endXuanZe").css("display","none");
		$("#selendtime").attr("name","sch.endtime");
		$("#endtime").attr("name","");
	});
});
</script>
</head>
 
<body class="n">
<c:if test="${empty sche}">
<div class="dow">
<div class="dow_top">
<span><a href="javascript:yingcang()">&times;</a></span>
&nbsp;&nbsp;&nbsp;新增一行日志记事
</div>
<div class="dow_nr">
<form id="form1" name="form1" method="post" action="<%=path %>/addWorkSchWorkLogNewportal.do" onsubmit="return check();">
<table width="100%"  border="0" cellspacing="0"  cellpadding="0">
   <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="border_grey">
      
       <tr>
        <td width="16%" height="35" align="center">任务名称</td>
        <td width="35%" height="35" align="center">任务进度
        <input id="ntId" type="hidden" name="ntId" value="">
        <input type="hidden" name="isOkState" id="isOkState" value="1" /></td>
        <td width="14%" height="35" align="center">预计完成时间</td>
        <td width="35%" height="35" align="center" colspan="2" >功能描述</td>
      </tr>
      <c:forEach items="${newTask}" var="dt">
      <tr>
        <td width="16%" height="35" align="left"><input type="radio" onclick="isOkNtId(${dt.id},${dt.schedule })" name="renwu" id="renwu" value="${dt.id }" >${dt.function.newProject.projectname }</td>
        <td width="35%" height="35" align="center">${dt.schedule }%
         </td>
         <td width="14%" height="35" align="center"  >${dt.endtime}</td>
        <td width="35%" height="35" align="center" >${dt.function.newProject.projectinfo}</td>
      </tr>
      </c:forEach>
      <tr>
        <td width="16%" height="35" align="right">发起人：</td>
        <td width="35%" height="35" align="left">
	            <input type="text" name="sch.organizer" readonly="readonly"  value="${emp.name }" />
	            <input type="hidden" name="sch.plantype" readonly="readonly"  value="5" />
	            <input type="hidden" name="sch.state" id="state" value="1" />
	            <input type="hidden" name="sch.employee.id" value="${emp.id }"/>
        </td>
        <td width="14%" height="35" align="right" >完成进度：</td>
        <td width="35%" height="35" align="left">
          <label>
          <input id="jingdu" name="jingdu" value="" style="width: 40px"> %<font id="fanwei" name="fanwei" style="color: red;font-size: 7px">(例如：完成是100%)</font><input type="hidden"  id="fanwei1" name="fanwei1" value="100"/>
            <!-- 
             	<input type="radio" name="tmp2" value="完成"  checked="checked" onclick="isFinish(1)" />完成　
             	<input type="radio" name="tmp2" value="未完成"  onclick="isFinish2(0)" />未完成
             	 -->
          </label>
          </td>
      </tr>
      <tr>
        <td height="35" align="right">参与人：</td>
        <td height="35" align="left">
            <c:if test="${sche.participator==null || sche.participator==''}">
	            <select name="sch.participator" id="participator0">
					<option value="无">
						无
					</option>
					<option value="美工">
						美工
					</option>
					<option value="开发组">
						开发组
					</option>
					<option value="销售部">
						销售部
					</option>
				</select>
			</c:if>
        </td>
        <c:if test="${sche.tmp1==null}">
	        <td height="35" align="left" colspan="2" id="yqtime" style="display: none;" >
	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  延期时间：<input type="text" name="sch.tmp1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value=""/> 
	        </td>
        </c:if>
        
      </tr>
      <tr>
        <td height="35" align="right">开始时间：</td>
        <td height="35" align="left">
          <div id="beginZiDingYi">
        		<select name="sch.begintime" id="selbegintime">
	        		<option> <%=date%> 09:00 </option>
	        		<option> <%=date%> 10:30</option>
	        		<option> <%=date%> 14:00</option>
	        		<option> <%=date%> 15:30</option>
	        		<option> <%=date%> 17:00</option>
        		</selec>
        		<input type="button" class="gb_bt" value="自定义时间"  id="beginZiDingYiBtn"/>
        	</div>
        	<div id="beginXuanZe" style="display:none;">
        		 <input type="text" name="sch.begintime" onfocus="showbeginXuanZeBtn()" id="begintime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00'})" value="${sche.begintime}"/>
            	 <input type="button" class="gb_bt" value="选择时间"  id="beginXuanZeBtn"/><font color="red" id="beginMsg" style="display: none;">不能为空！</font>
        	</div>
        </td>
        <td height="35" align="right">结束时间：</td>
        <td height="35" align="left">
           <div id="endZiDingYi">
        	<select name="sch.endtime" id="selendtime">
	        		<option> <%=date%> 10:30</option>
	        		<option> <%=date%> 12:00</option>
	        		<option> <%=date%> 15:30</option>
	        		<option> <%=date%> 17:00</option>
	        		<option> <%=date%> 18:30  </option>
        		</selec>	
        	<input type="button" class="gb_bt" value="自定义时间"  id="endZiDingYiBtn"/>
        	</div>
        	<div id="endXuanZe" style="display:none;">
        		 <input type="text" onfocus="showendXuanZeBtn()" name="sch.endtime" id="endtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d 00:00:00'})" value="${sche.endtime}" />
          		<input type="button" class="gb_bt" value="选择时间" id="endXuanZeBtn"/><font color="red" id="endMsg" style="display: none;">不能为空！</font>
        	</div>
        </td>
      </tr>
    </table></td>
    </tr>
   <tr>
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" class="border_grey">
      <tr>
        <td align="right">工作内容：</td>
        <td align="left" style="height: 115px;">
	          <textarea name="sch.workcontent" id="workcontent" cols="70" rows="8" wrap="physical" onblur="gzrnmsg()"></textarea>
	          <font color="red" id="gzrnMsg" style="display: none;">不能为空！</font>
      　　　</td>
      </tr>
      <tr>
	  <td width="16%" align="right" style="height: 115px;">效果描述：</td>
        <td width="84%">
           <textarea name="sch.tmp"  cols="70" rows="8" wrap="physical">${sche.tmp }</textarea>
        </td>
      </tr>
    </table>      
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="4" align="right">&nbsp;</td>
        </tr>
    </table> 
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      </tr>
      
    </table></td>
    </tr>
	<tr>
    <td align="center" height="50">
		<input class="gb_bt" type="submit" name="Submit" value="确认" />
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <input class="gb_bt" type="reset" name="" onclick="yingcang()" value="关闭" />
    </td>
    </tr>
</table>
  </form>    
</div>
</div> 
</c:if>
<c:if test="${not empty sche}">
<div class="xb_lbk">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="36">
    <div class="xq_dow_top"> <span><a href="javascript:yingcang();">×</a></span> 查看工作记事 </div>
    </td>
  </tr>
</table>
<br />
<table width="98%" border="0" align="center" cellpadding="15" cellspacing="0" class="bg_xxx">
  <tr>
    <td width="14%" align="right">发起人：</td>
    <td width="18%" align="left">${sche.organizer}</td>
    <td width="15%" align="right">完成效果：</td>
    <td width="20%" align="left">
         <c:if test="${sche.state==1}">完成</c:if>
	     <c:if test="${sche.state==0}">未完成</c:if>
    </td>
    <td width="13%" align="right">参与人：</td>
    <td width="20%" align="left">${sche.participator }</td>
  </tr>
  <tr>
    <td align="right">开始时间：</td>
    <td align="left">${sche.begintime}</td>
    <td align="right">结束时间：</td>
    <td align="left">${sche.endtime}</td>
    <c:if test="${not empty sche.tmp1}">
	    <td>延期时间:</td>
	    <td>${sche.tmp1 }</td>
    </c:if>
  </tr>
</table>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="14%" align="right">工作内容：</td>
    <td width="86%"><div class="xb_gznr">${sche.workcontent }&nbsp;</div></td>
  </tr>
  <tr>
    <td height="21" align="right">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right" valign="top">效果描述：</td>
    <td><div class="xb_xgms">${sche.tmp }</div></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
  <tr>
    <td align="center"><input type="button" name="button2" id="button2" class="xq_gb_btr" onclick="yingcang()" value="关闭" /></td>
    </tr>
</table>
</div>
</c:if>
</body>
</html>
