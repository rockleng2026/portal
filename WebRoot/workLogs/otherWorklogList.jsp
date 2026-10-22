<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd" >

<HTML>
<head>
	<title>我的工作日志</title>
	<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/workLogJs.js"></script>
<script type="text/javascript">

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
	var url = "goDetailWorkLog.do?id="+id;
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
		 url:"checkWorkLog.do",         
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
		 window.location.href="selectOtherWorkLog.do";
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
</script>
</head>
<style type="text/css">

body{background:#fff;}

 #form1 table { border-collapse: collapse;}

 #form1 table tr {background:#fff; text-align:center; line-height:20px;}

#infotable tr:hover{background:#999;}



 #Form1{background:#fff;}
 
   #login{
        position: absolute;
         display: none;
         top: 50px;
         right: 50px;
         background-color:blue;
         border: solid 1px;
         padding: 10px;
         z-index: 99;
   }
   
   #workLog{
   		position: absolute;
		width:600px;
		border: #039 solid 1px;
		text-align:left;
		font-family:"Courier New", Courier, monospace;
		font-weight:500;
		font-size:14px;
		letter-spacing:1px;
		position:absolute;
	
		display:none;
		background-color:white;
		z-index:120;
	}
p
{ 
	line-height:22px;
}

.header {
    padding: 10px 0 0;
    position: fixed;
}

#form1Head {
	width:100%;
	height:35px;
	padding-bottom:4px;
}

a{
text-decoration:none;
}

#form1Head table
 {
 	height:100%;width:50%; 
 	border: black  solid 1px; 
 	border-collapse: collapse;
 }

#form1Head tr,td{border: black  solid 1px;}

#form1Head tr{height:25px;width:50%; }

#form1Head td{width:50px;height:25px;line-height:25px;text-align:center;}

body{text-align:center; vertical-align:center;}

.winTitle{background:#9DACBF; height:25px; line-height:25px}

.winTitle .title_left{font-weight:bold; color:#FFF; padding-left:5px; float:left}

.winTitle .title_right{float:right}

.winTitle .title_right a{color:#000; text-decoration:none}

.winTitle .title_right a:hover{text-decoration:underline; color:#FF0000}

.winContent{padding:5px;}

</style>

<body>

<!--内容-->
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					我的工作日志列表
				</div>
			</div>
			
			<div style="padding:5px 5px 5px 5px; width:100%;height:45px;text-align:center;">
			<form id="Form1" action="selectOtherWorkLog.do?clear=0" method="post">
			  <div style="height:100%;padding-bottom: 20px;">
					 日期 <input type="text" id="selectDate" name="selectDate" style="width:100px;" /> 
					 &nbsp;&nbsp;&nbsp;
				            部门&nbsp;<select id="departmentID" name="departmentID" onchange="t(this)"  style="width:100px;">
								<option  id="deparmentID" value="-1">请选择:</option>
								<c:forEach items="${deparments}" var="department">
									<option  id="deparmentID" value="${department.id}">${department.name}</option>
								</c:forEach>
						</select>
				      &nbsp;&nbsp;&nbsp;
				          员工  <select id="employeeID"  name="employeeID" style="width:100px;">
								<option  id="deparmentID" value="-1">请选择:</option>
								<c:forEach items="${employees}" var ="employee">
									<option name="employeeID" value="${employee.id}">${employee.name}</option>
								</c:forEach>
							</select>
				       &nbsp;&nbsp;&nbsp;
				         日期批注 <select name="isView" id="isView"  style="width:100px;">
							<option value = "-1">全部</option>
							<option value = "0">未批注</option>
							<option value = "1">已批注</option>
							<option value = "2">已查看</option>
						</select>
				          &nbsp;&nbsp;&nbsp;
          				<input value="查询"  id="Input" type="submit" value="查询" name="Input" style="cursor:hand;"/>
          				
				</div>
			</form>
				
			<form id="form1" style="background:#fff; ">
				<div id="form1Head">
					<table>
						<tr>
							<td>  
								<a  href="selectOtherDayWorkLog.do" >查询日日志</a>
							 </td>
							<td>
								<a  href="selectOtherMonthWorkLog.do" >查询周日志</a>							
						  	</td>
							<td> 
								<a   href="selectOtherWeekWorkLog.do">查询月日志</a>
							</td>
						</tr>
						
					</table>
					<input type="button" value="批量批阅"  onclick="p()" style="position: absolute;right:310px;top:80px;cursor:hand;"/>
					<input type="button" value="对比"  onclick="q()" style="position: absolute;right:230px;top:80px;cursor:hand;" />
					<div style="position: absolute;right:60px;top:80px;">
							每页显示
							<select id="pageCount" onchange="sendPageCount(this)"> 
						
								<c:forEach items="${pageCounts}" var="count">
									<c:choose>
											
											   <c:when test="${count==defaultPageCount}">    
											   		<option value="${count}" selected="selected">${count}</option>
											   </c:when>
											   <c:otherwise> 
											   		<option value="${count}">${count}</option>
											   </c:otherwise>
											</c:choose>
								</c:forEach>
							</select> 
							条记录
					</div>
				</div>
				
				<table id="" width="100%" align="center" cellspacing="1" >
				<tr>
						<td width="12%" id="tdid" align="center" height="20" >
							<input type="checkbox" value=" ${data.id}" checked="checked" />
						</td>
						<td width="7%" id="tdid" align="center" height="20" style="display: none;" >
							日志编号
						</td>
						<td width="12%" id="tdtype" >
							日志类型
						</td>
						<td width="12%" id="tdemployeeByEmpName" >
							员工姓名
							
						</td>
						<td width="20%" id="tddepartment" >
							所属部门
							
						</td>
						<td width="12%" id="tdrecordTime"  >
							
							提交时间
							
						</td>
						<td width="12%" id="tdisView2" >
							领导批注
						</td>
						<td width="20%" align="left" >
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;详细查看
						</td>
					</tr>
					</table >
					<table  id="infotable"  width="100%" style="border:solid 1px blue;">
					<c:if test="${empty pages.pageList}">
						<tr><td height="20" colspan="7" align="center"><h4>无日志............</h4></td></tr>
					</c:if>
					<c:if test="${!empty pages.pageList}">
						<c:forEach items="${pages.pageList}" var="data" >
						<tr>
								<td>
										<input type="checkbox" value="${data.id}" id="ids" />
								</td>
								<td width="7%" align="center" height="20" style="display: none;">
									${data.id }
								</td>
								<td width="12%">
									<c:if test="${data.type == 0}">日志</c:if>
								<c:if test="${data.type == 1}">周志</c:if>
								<c:if test="${data.type == 2}">月志</c:if>
								</td>
								<td width="12%">
									${data.employeeByEmpId.name }
								</td>
								<td width="20%">
									${data.employeeByEmpId.department.name } 
								</td>
								<td width="12%">
									${data.recordTime }
								</td>
								<td width="12%">
								<%--<c:if test="${data.isView == 0}">
									<c:choose>
											<c:when test="${emp.id==data.employeeByEmpId.id}">
												<a> 添加批阅 </a>
											</c:when>
											<c:otherwise>
												--%>
												<% int i = 0 ;%>
													<c:forEach items="${audlist}" var="aud">
														<c:if test="${data.isView == 0}">
														<c:if test="${data.logNo==aud.orderNo}">
															<%  i = 1; %>
															<a href="goAddNewReplyWorkLog.do?logNo=${data.logNo }&audid=${aud.id }">添加批注</a>
														</c:if>
													</c:if>
													</c:forEach>
													<c:if test="${data.isView == 0}">
													<%if(i==0) {%>
															<a href="goAddNewReplyWorkLog.do?logNo=${data.logNo }">添加批注</a>
														<%}%>
														</c:if><%--
											</c:otherwise>
										</c:choose>
									</c:if>
									--%><!-- onclick="showInfo2('${data.id}')" -->
									<!--  <a href="goAddReplyWorkLog.do?id=${data.id }"> <font color="#ff0000">未批注</font></a>-->
									<c:if test="${data.isView == 1}"><a href="goSeeReply2WorkLog.do?id=${data.id }&logNo=${data.logNo }"> <font color="#ff0000">批注待查看</font></a></c:if>
									<c:if test="${data.isView == 2}"><a href="goSeeReply2WorkLog.do?id=${data.id }"> 批注已查看</a></c:if>
								</td>
								<td width="20%" align="left" id="td${data.id}" >
									<center>
										<input id="shortcut" class="PopupButton2" type="button" value="简要" onmouseout="" onclick="mov('getContentWorkLog.do',${data.id})" style="cursor:hand;"/>
										<input style="margin-left: 10px;cursor:hand;" name="button" id="button${data.id}" type="button" class="PopupButton2" onClick="showInfo3('${data.id}')" value="详情" >
									</center>								
								</td>
						</tr>
						<tr>
							<td colspan="7" >
							<div id="contentF${data.id}" align="left">
								
		    					</div>
								
							</td>
						</tr>
					</c:forEach>
					</c:if>
				</table>
				
				<table width="100%" style="border:0;margin-top:11px;margin-bottom:8px;">
					<tr>
						<td id="page" align="right" colspan="5"  style="border: 0;">
							<c:if test="${mark==0}">
								<p:pages  url="selectOtherWorkLog.do"/>
							</c:if>
							<c:if test="${mark==1}"><p:pages url="selectOtherDayWorkLog.do"/></c:if>
							<c:if test="${mark==2}"><p:pages url="selectOtherMonthWorkLog.do"/></c:if>
							<c:if test="${mark==3}"><p:pages url="selectOtherWeekWorkLog.do"/></c:if>
							<c:if test="${mark==4}"><p:pages url="obscureselect1WorkLog.do"/></c:if>
						</td>
						<td style="border: 0;" align="left">
							<lable style="font-size:13px; float:left;">
							每页显示
							<select id="pageCount" onchange="sendPageCount(this)" style="cursor:hand;" value="50"> 
								<c:forEach items="${pageCounts}" var="count">
									<c:choose>
											
											   <c:when test="${count==defaultPageCount}">    
											   		<option value="${count}" selected="selected">${count}</option>
											   </c:when>
											   <c:otherwise> 
											   		<option value="${count}">${count}</option>
											   </c:otherwise>
											</c:choose>
								</c:forEach>
							</select> 
							条记录
						 	</lable>
						</td>
					</tr>
				</table>
				</form>
				</div>
		</div>
		<div id="contentF">
			
		</div>
		
<!--右栏 结束-->

        <div id="pageid" style="position: absolute; right:150px; top: 250px; display:none ;">
            <div class="header">
            <a href="#" onclick="topWork()"  onmouseover="movetop('prompt1')" onmouseout="movedown('prompt1')"><IMG alt="" src="<%=request.getContextPath() %>/images/11_03.jpg"></a>
            	<div id="prompt1" style="position: absolute; right:0px; top: 45px; display: none;" >上一篇</div>
            	
            <br/>
            
			<a href="#" onclick="downWork()" onmouseover="movetop('prompt2')" onmouseout="movedown('prompt2')" ><IMG alt="" src="<%=request.getContextPath() %>/images/11_06.jpg"></a>
			<div id="prompt2" style="position: absolute; right:0px; top: 75px; display: none;" >下一篇</div>
            </div>   
            <input id="workId" name="workId" value="" type="hidden">
            <input id="workId1" name="workId1" value="" type="hidden">
        </div>
 <div id="login" >
 	<lable style="font-weight:bold; font-size:16px;" >员工日志批量批阅 </lable>
 	<p></p><br/>
 	<table>
 		<tr>
 			<td> 
 				<center> 
 					<lable id="piyueinfo"></lable>
 				</center>
 			 </td>
 		</tr>
 		<tr> <td> <textarea rows="10" cols="30" id="content"> </textarea></td> </tr>
 		<tr style="border:0px;"> 
 		 <center>
 			<td style="border:0px;">
 		 		<input type="button" value="提交" onclick="commit('URToWorkLog.do')" style="cursor:hand;"/> 
 		 		<input type="button" value="返回" onclick="back()" style="cursor:hand;"/>
 			 </td> 
 		</center>
 		 </tr>
 	</table>
 </div>
 
 <div id="cover" style="position: absolute;z-index: 3px;top:0px;right:0px;background: #CCCCCC;width:100;height:100%;Alpha(Opacity=60); opacity = 0.6;display:none;">
 </div>
 
 <div id="workLog" >
 	<div class="winTitle" onMouseDown="startMove(this,event)" onMouseUp="stopMove(this,event)">
	 	<span class="title_left" id="title_left">  </span>
	 	<span class="title_right">
	 	<a href="javascript:mout()" title="单击关闭此窗口"><img src="<%=request.getContextPath()%>/images/closeSign.gif"/></a>
	 	</span><br style="clear:right"/>
 	</div>
 	<div style="height:30px;width:100%;line-height:30px;align:left;font-size:13px;" id="title">
 		
 	</div>
 	<h2 id="title1"></h2>
 	<div class="winContent" id="workLogContent"  style="font-size:14px;">
 		
 	</div>
 	<div style="margin-top:10px;width:100%;height:20px;text-align:center;" >
 		<input type="image" src="<%=request.getContextPath()%>/images/closePage.gif" style="position:absolute;left:290px;bottom:5px;"
 		 onclick="mout()"  class="PopupButton2" style="cursor:hand;"/> 
 	</div>
</div>
</body>
</html>
