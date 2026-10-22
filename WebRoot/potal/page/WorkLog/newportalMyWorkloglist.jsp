<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="x-ua-compatible" content="ie=7" />

<title>我的日志列表</title>
<style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
body{font:12px/180% Arial, Helvetica, sans-serif, "新宋体";}

/* cover-list */
.cover-list{width:670px;margin:20px auto;}
.cover-list li{float:left;margin:0 15px 15px 0;display:inline;width:152px;height:150px;overflow:hidden;}
/* detail-frame */
.detail-frame{display:none;}
.arrow-left{position:absolute;width:6px;height:9px;top:30px;left:0;margin-left:-6px;background:url(<%=path%>/potal/images/arrow_gray.gif) no-repeat;}
.arrow-right{position:absolute;width:6px;height:9px;top:30px;left:320px;background:url(<%=path%>/potal/images/arrow_gray.gif) no-repeat -6px 0;}
.detail-tip{position:absolute;width:300px;background:#fff;border:1px solid #ddd;padding:10px;}
.detail-tip h2{font-size:12px;line-height:18px;color:#3366cc;}
.detail-tip p{margin:10px 0 0 0;font-size:14px;}
</style>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.main { width:760px; margin:0 auto;}
.dow_nr{width:758px; border:0px solid #455c32;  float:left}
.dow_nr td{font-size:12px;line-height: 26px;}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF;height: 26px;}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#5da500; }

.tc_rightb{border-right:1px solid #c3c3c3;}
/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;} 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.tab ul li { width:90px; line-height:25px; float:left;text-align:center; background-color:#E8E8E8; margin-left:2px;}
.tab ul  .active{ background-color:#4FA805; color:white; font-size:12px; }
.tab div{ clear:both; border-top:1px solid #4FA805; }
.gb_bt{cursor:pointer; background-color:#4FA805; font-weight:bold; color:#fff; width:60px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto;}
.msg_green{ border:#4FA805 1px solid; line-height:20px; background-color:#FFF;width:223px;}
 .ahovestyle{background-color:#5da601;color:#FFFFFF;}
 .showview{border-bottom:1px solid #c3c3c3;border-right:1px solid #c3c3c3;font-size: 12px;}
<!-- 表格里面的按钮  -->
.gb_bb{color:#4FA805; line-height:25px; font-size:12px;height:25px;
text-align:center;cursor:hand;margin:3px; width:100%;}
 a{text-decoration: none;}
 a:hover{color:red;}
.msgshow_green .c2{background:url(images/c2.png) no-repeat 100px 0px; height:11px; position:relative; margin-bottom:-1px;  z-index:1; }
.size{ font-size:12px;}
.dvr{ float:right; margin-right:5px;}

</style>
<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
<link href="<%=path%>/potal/css/thickbox.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/potal/js/thickbox.js"></script>
<script type="text/javascript" src="<%=path %>/potal/js/newPortalworkLogJs.js"></script>
<script type="text/javascript">
//表格里面颜色变化
$(function(){
	$("[name=view]").mouseover(function(){
		$(this).css("color","red");
	});
	$("[name=view]").mouseout(function(){
		$(this).css("color","#4FA805");
	});
});





function sendPageCount(selectNode)
{
	var pageCount = $(selectNode).val();
	window.location.href = "selectOtherWorkLog.do?pageCount="+pageCount;
	$(selectNode).attr("selected","selected");
}

function mov(url,id)
{	
	var Form1 = M("Form1");
	var workLog = M("workLog");
	workLog.style.top = Form1.offsetTop+getScrollTop()+ 37+"px";
	//alert(workLog.style.top );
	workLog.style.right = 189+"px";
//	alert($("#workLog").attr("right"));
	//alert(workLog.style.right);
	//$("#workLog").css("top","37px");
    //	$("#workLog").css("right","189px");
	
	$.ajax({         
		 type:"post", 
		 async:false,
		 data:{workID:id},          
		 url:"getTitle1WorkLog.do",         
		 dataType: "html",         
		 success: function(data)        
		 {             
			 $("#title_left").html(data);
		 }  
		});
	
	
	
	 $.ajax({         
		 type:"post", 
		 async:false,
		 data:{workID:id},          
		 url:"getTitleWorkLog.do",         
		 dataType:"html",         
		 success: function(data)        
		 {             
			 $("#title").html(data);
		 }  
		});
	 
	$.post(url,{workID:id},
	function (data)
	{
		//alert(data);
		$("#workLogContent").html(data);
		workLog.style.display = "block";
	});
}


function showInfo3(id)
{
	var url = "goDetailWorkLogNewportal.do?id="+id;
	window.location.href=url+"&tt="+(new Date()).getTime();
}

var info = "";
var result;

//打开DIV层
function p()
{
	if(count())
	{
		y();
		
		if(result)
		{
			if(info.indexOf("是")=='-1')
			{
				alert(info);
			}
			else
			{
				
				if(confirm(info))
				{
					change();
			        showLogin();
			        popCoverDiv();
			        void(0);//不进行任何操作,如：<a href="#">aaa</a>
				}
			}
		}
		else
		{
			
			change();
	        showLogin();
	       	popCoverDiv();
	        void(0);//不进行任何操作,如：<a href="#">aaa</a>
		}   
	}
	
}

function pi()
{
	change();
    showLogin();
    popCoverDiv();
    void(0);
}

function y()
{
	
	
	var s = "";
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	
	 $.ajax({         
		 type:"post", 
		 async:false,
		 data:{ids:s},          
		 url:"checkWorkLogNewportal.do",         
		 dataType: "html",         
		 success: function(data)        
		 {               
			 info = data;
			 
			 if(data=='1')
			{
				 result = false;
			}
			 else
			{
				result = true;
			}
		 }  
		});
}

function back()
{
	document.getElementById("login").style.display = 'none';
	document.getElementById("cover_div").style.display = 'none';
}

function commit(url)
{
	//alert(1);
	var s = "";
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			if(i < all2.length - 1)
			{
				s+=$(all2[i]).val()+",";
			}
			else
			{
				s+=$(all2[i]).val();
			}
		}
	}
	
	var content = $("#content").val();
	
	
	content = encodeURI(encodeURI(content));
	
	if(content=="%2520")
	{
		alert("不能为空!");
		return;
	}
	
	
	$.post(url,{ids:s,replycontent:content},
	function (data)
	{
		 window.location.href="selectOtherWorkLogNewportal.do";
	});
}

function count()
{
	
	//var all=document.getElementsByName('ids');
	var j = 0;
	
	var all2 = $("[id=ids]");
	
	for(var i = 0; i < all2.length;i++)
	{ 
		
		var v = $(all2[i]).attr("checked");
		
		if(v=='checked')
		{
			j++;
		}
	}
	
	if(j>0){
		return true;
	}else{
		alert("请您先选择要批阅的日志");
		return false;
	}
}
//勾选所有要删除项
function CheckA(form)  {
	  for (var i=0;i<form.elements.length;i++)    {
	    var e = form.elements[i];
	    if (e.name != 'chkall')
	    	e.checked = form.chkall.checked; 
	  }
}

// 删除日志
function delWorkLog(){
	// 获取选中的任务
	var logcheck=document.getElementsByName("ids");
	var logstr="";
	for(var i=0;i<logcheck.length;i++){
		if(logcheck[i].checked==true){
			logstr+=logcheck[i].value+",";
		}
	}

	if(window.confirm("您确定要删除吗？")){
		$.ajax({
			  type: "post",
			  url: "delTaskProject.do",
			  data: {
				  "taskstr":taskstr
				  },
			  success: function(data){						  
			    	alert(data);
			    	window.location.href="<%=path %>/publishtaskTaskProject.do";
			  }
	   });
	}
}

// 查看详细日志
function showInfo2(id)
{
	var url = "goSeeReply2WorkLogNewportal.do?id="+id+"&flag=0";
	window.location.href=url+"&tt="+(new Date()).getTime();
}
// 切换样式
function changestyle(obj){
	 $("#cxrz").removeClass("active");
	 $("#cxzz").removeClass("active");
	 $("#cxyz").removeClass("active");
	 $("#"+obj.id).addClass("active");
	 $("#"+obj.id).children("a").css("color","white");
}
// 切换a标签的样式
function changeOutStyle(obj){
	$("#td"+obj.id).children("a").css("color","red");
	//$("#td"+obj.id).addClass("ahovestyle");
}
function changeMoveStyle(obj){
	$("#td"+obj.id).children("a").css("color","#4FA805");
}
</script>
</head>
  
 <body>
<div class="dow">
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页&gt;工作日志&gt;<span class="wzcs">我的日志</span>
</div>
</div>
<div style="line-height:50px;">
<form  id="Form0" action="selectWorkLogNewportal.do?clear=0&logtype=${logtype}" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="70%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right">选择时间&nbsp;</td>
              <td>
                <label for="textfield"></label>
                <input type="text"  id="selectDate" name="selectDate" size="10" onclick="WdatePicker();" /> 
              </td>
            </tr>
          </table></td>
           <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="right">日志批注&nbsp;</td>
              <td>
                <label for="textfield"></label>
                <select name="isView" id="isView" style="width:84px">
							<option value = "-1">全部</option>
							<option value = "0">未批注</option>
							<option value = "1">已批注</option>
							<option value = "2">已查看</option>
				</select>
              </td>
            </tr>
          </table></td>
        </tr>
      </table></td>
      <td width="30%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input type="submit" class="gb_bt"  id="Input" name="Input"  value="查询 "></td>
          <td><INPUT onClick="window.location='goAddWorkLogNewportal.do?mark=0'" type="button" class="gb_bt" value="新建日志" ></td>
          <td><INPUT onClick="window.location='<%=path %>/potal/page/WorkLog/addNewportalWeekLog.jsp?mark=1'" class="gb_bt" type="button" value="新建周志" ></td>
          <td><INPUT onClick="window.location='<%=path %>/potal/page/WorkLog/addNewportalMonthLog.jsp?mark=2'" class="gb_bt" type="button" value="新建月志" ></td>
        </tr>
      </table></td>
    </tr>
  </table>
 </form>
</div>
  <div class="outline tab">
	<ul>
	   <li <c:if test="${logtype==0}"> class='active' </c:if>  id="cxrz"><a href="selectDayWorkLogNewportal.do">查询日日志</a></li>
	   <li <c:if test="${logtype==1}"> class='active' </c:if>  id="cxzz"><a href="selectMonthWorkLogNewportal.do">查询周日志</a></li>
	   <li <c:if test="${logtype==2}"> class='active' </c:if>  id="cxyz"><a href="selectWeekWorkLogNewportal.do">查询月日志</a></li>
	</ul>
</div>
  <div class="dow_nr">
 <form id="form2" name=form2 action="" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">   
    <tr>
      <td  width="10%" align="center" class="tc_top tc_rightb">姓名</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">部门</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">职位</td>
      <td  width="10%" align="center" class="tc_top tc_rightb">类型</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">时间</td>
      <td  width="15%" align="center" class="tc_top tc_rightb">领导批注</td>
      <td  width="10%" align="center" class="tc_top tc_rightb">内容</td>
      <td  width="10%" align="center" class="tc_top tc_rightb">操作</td>
    </tr>
    <c:if test="${empty pages.pageList}">
		<tr><td align="center" colspan="8" class="tc_rightb">无日志............</td></tr>
	</c:if>
	<c:if test="${!empty pages.pageList}">
		<c:forEach items="${pages.pageList}" var="data" >
		<tr>
				<td class="tc_footb tc_rightb" align="center">
					${data.employeeByEmpId.name }
				</td>
				<td class="tc_footb tc_rightb" align="center">
					${data.employeeByEmpId.department.name } 
				</td>
				<td class="tc_footb tc_rightb" align="center">
				   <!-- ${data.employeeByEmpId.workposition.name } -->
				   ${data.employeeByEmpId.groups.groupName}&nbsp;
				</td>
				<td class="tc_footb tc_rightb" align="center">
				   <c:if test="${data.type == 0}">工作日志</c:if>
				   <c:if test="${data.type == 1}">工作周志</c:if>
				   <c:if test="${data.type == 2}">工作月志</c:if>&nbsp;
				</td>
				<td class="tc_footb tc_rightb" align="center">
					${data.recordTime }&nbsp;
				</td>
				<td class="tc_footb tc_rightb" id="td${data.id}" align="center">
					　<c:if test="${data.isView == 0}"> 未批注</c:if>
					  <c:if test="${data.isView == 1}"><a href="goSeeReply2WorkLogNewportal.do?id=${data.id }" id="${data.id}" onmouseout="changeMoveStyle(this)" onmouseover="changeOutStyle(this)" ><font color="#ff0000">新批注</font></a></c:if>
					  <c:if test="${data.isView == 2}"><a href="goSeeReply2WorkLogNewportal.do?id=${data.id }" id="${data.id}" onmouseout="changeMoveStyle(this)" onmouseover="changeOutStyle(this)" > 批注已查看</a></c:if>
				</td>				
				<td align="center"  class="showview">
					<a class="thickbox gb_bb" href="<%=path %>/resultByLidWorkLogNewportal.do?logid=${data.id }&height=300&width=500" >查看缩略</a>
				</td>
				<td class="tc_footb tc_rightb" align="left" id="td${data.id}" >
					<center>
						<a name="view" id="button${data.id}"  class="gb_bb" onClick="showInfo2('${data.id}')" >详情查看</a>
					</center>								
				</td>
		</tr>
		<tr>
			<td colspan="8" class="tc_footb tc_rightb">
				<div id="contentF${data.id}" align="left"></div>
			</td>
		</tr>
	</c:forEach>
	</c:if>
    <tr>
      <td colspan="8" align="right" class="foot1">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td id="page" width="100%">
              <c:if test="${logtype==0}"><p:pages  url="selectWorkLogNewportal.do?type=0"/></c:if>
			  <c:if test="${logtype==1}"><p:pages url="selectMonthWorkLogNewportal.do?type=1"/></c:if>
			  <c:if test="${logtype==2}"><p:pages url="selectWeekWorkLogNewportal.do?type=2"/></c:if>
          </td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
</form>
</div>
</div>
<!--演示内容开始-->
<script type="text/javascript">
function ms(obj){
	
	 $.ajax({
		  type: "post",
		  url: "resultByLidWorkLogNewportal.do",
		  data: {
			  "logid":obj
			  },
		  success: function(data){			  
				  $("#contentmore").html(data);
		  }
	});
	
}
</script>
<div class="dvr" style="display: none" id="contentmore"></div>
</body>
</html>
