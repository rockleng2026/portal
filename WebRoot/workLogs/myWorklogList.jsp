<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
</head>
<style type="text/css">
 #form1 table tr td{background:#fff; text-align:center; line-height:20px;}
</style>
<script type="text/javascript">


function showInfo(id)
	{
		var url = "goDealWorkLog.do";
		$.post(url,{id:id},function (data){
		$("#contentF"+id+"").html(data);	
		$("#button"+id+"").remove(); 	
		$("#td"+id+"").append("<input type='button' id='bt"+id+"' onClick='closeaa("+id+")' value='关闭'>");
		});
	}
	function cleanC(){
	$("#contentF").html("<br/>");
}
function showInfo2(id)
	{
		var url = "goSeeReply2WorkLog.do?id="+id;
		window.location.href=url+"&tt="+(new Date()).getTime();
	}
function closeaa(id)
{
	$("#contentF"+id+"").html("");
	$("#bt"+id+"").remove();
	$("#td"+id+"").append("<input style='margin-left: 25px;' name='button' id='button"+id+"' type='button' class='PopupButton2' onClick='showInfo("+id+")' value='详情查看'>");
}
</script>

<body>

<!--内容--><!--右栏-->
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					我的工作日志列表
				</div>
			</div>
			
			<div class="Case_Content">
			<form id="Form0" action="selectWorkLog.do?clear=0" method="post">
			  <div class="case_line">
					<div class="case_line_lie" style="text-align: right;">日期：</div>
					<div class="case_line_lie"><input type="text" id="selectDate" name="selectDate" /></div>
					<div class="case_line_lie" style="text-align: right;">日志批注：</div>
					<div class="case_line_lie">
						<select name="isView" id="isView" style="width:84px">
							<option value = "-1">全部</option>
							<option value = "0">未批注</option>
							<option value = "1">已批注</option>
							<option value = "2">已查看</option>
						</select>
			    	</div>
					<div class="case_line_lie" style="border:0;height:23px;width:65px;">
					 	<input class="Search_Btn" id="Input" type="submit" value="查询" name="Input" style="border:0;height:23px;width:65px;" />
					</div>
					 
			  </div>
			</form>
				
			<form id="form1">
				<div class="case_line">
				<table  id="infotable"  width="100%">
				<tr>
					<td align="center" colspan="2">
						<a   href="selectDayWorkLog.do" >查询日日志</a>
					</td>
					<td align="center" colspan="3">
						<a  href="selectMonthWorkLog.do"   >查询周日志</a>
					</td>
					<td align="center" colspan="2">
						<a   href="selectWeekWorkLog.do"  >查询月日志</a>
					</td>
				</tr>
					<tr>
						<td width="20%" align="center" height="20" style="background:#fff;">
							日志编号
						</td>
						<td width="12%" style="background:#fff;">
							日志类型
						</td>
						<td width="12%">
							员工姓名
						</td>
						<td width="12%">
							所属部门
						</td>
						<td width="12%">
							提交时间
						</td>
						<td width="12%">
							领导批注
						</td>
						<td width="20%" align="left">
							详细查看
						</td>
					</tr>
					
					<c:if test="${empty pages.pageList}">
						<tr><td height="20" colspan="7" align="center"><h4>无日志............</h4></td></tr>
					</c:if>
					<c:if test="${!empty pages.pageList}">
						<c:forEach items="${pages.pageList}" var="data" >
						<tr>
								<td width="20%" align="center" height="20">
									 ${data.id }
								</td>
								<td width="12%">
									<c:if test="${data.type == 0}">工作日志</c:if>
								<c:if test="${data.type == 1}">工作周志</c:if>
								<c:if test="${data.type == 2}">工作月志</c:if>
								</td>
								<td width="12%">
									${data.employeeByEmpId.name }
								</td>
								<td width="12%">
									${data.employeeByEmpId.department.name } 
								</td>
								<td width="12%">
									${data.recordTime }
								</td>
								<td width="12%">
									<c:if test="${data.isView == 0}"> 未批注</c:if>
									<c:if test="${data.isView == 1}"><a href="goSeeReply2WorkLog.do?id=${data.id }"> <font color="#ff0000">新批注</font></a></c:if>
									<c:if test="${data.isView == 2}"><a href="goSeeReply2WorkLog.do?id=${data.id }"> 批注已查看</a></c:if>
								</td>
								<td width="20%" align="left" id="td${data.id}">
									<!-- 
									<input style="margin-left: 25px;" name="button" id="button${data.id}" type="button" class="PopupButton2" onClick="showInfo('${data.id}')" value="详情查看">
									 -->
									<input style="margin-left: 25px;" name="button" id="button${data.id}" type="button" class="PopupButton2" onClick="showInfo2('${data.id}')" value="详情查看">
									
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
				
				<table width="100%">
					<tr><td align="center" colspan="7">
					<c:if test="${mark==0}"><p:pages url="selectWorkLog.do"/></c:if>
					<c:if test="${mark==1}"><p:pages url="selectDayWorkLog.do"/></c:if>
					<c:if test="${mark==2}"><p:pages url="selectMonthWorkLog.do"/></c:if>
					<c:if test="${mark==3}"><p:pages url="selectWeekWorkLog.do"/></c:if>
					
					</td></tr>
				</table>
				<div cellSpacing="0" cellPadding="0" width="100%" border="0">
					<div height="30" Align="bottom">
						<table width="100%">
							<tr>
								<td align="center" width="40%">
									<INPUT onClick="window.location='goAddWorkLog.do?mark=0'" type="button" value="新建日日志" >
								</td>
								<td align="center" width="20%">
									<INPUT onClick="window.location='goAddWorkLog.do?mark=1'" type="button" value="新建周日志" >
								</td>
								<td align="center" width="40%">
									<INPUT onClick="window.location='goAddWorkLog.do?mark=2'" type="button" value="新建月日志" >
								</td>
							</tr>
						</table>
						
						
					</div>
				</div>
				</div>
			 </form>
		  </div>
		</div>
		<div id="contentF">
			
		</div>
<!--右栏 结束-->
</body>
</html>
