<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"  "http://www.w3.org/TR/html4/loose.dtd" >

<HTML>
<head>
	<title>所有人员的工作日志</title>
	<LINK href="<%=request.getContextPath() %>/Css/page.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
	</head>
<script type="text/javascript">

function showInfo(id)
	{
		//var obj=new Object();
		//window.showModalDialog("<%=request.getContextPath() %>/workLogs/goDealWorkLog.do?id="+id,obj,"dialogWidth=900px;dialogHeight=600px");
		var nowDate = (new Date()).getTime();
		var url = "<%=request.getContextPath() %>/workLogs/goDealWorkLog.do?id="+id+"&dd="+nowDate;
		//alert(url);
		$("#contentF").load(url);		
	}
	function cleanC(){
	$("#contentF").html("<br/>");
}
function exPage(){
   //alert("1212");
   location.href="exportLoggersWorkLog.do?oper=part";
}
function showInfo2(id)
	{

		var url = "goDeal2WorkLog.do?id="+id;
		window.location.href=url+"&tt="+(new Date()).getTime();
	}
</script>


<body>

<!--内容--><!--右栏-->
		<div class="Case_CF_R">
			<div class="Case_Title">
				<div class="F_Title">
					所有工作日志列表
				</div>
			</div>
			<div id="contentF">
		    </div>
			<div class="Case_Content">
			<form id="Form1" action="allListWorkLog.do?clear=0" method="post">
			  <div class="case_line">
					<div class="case_line_lie" style="text-align: right;">日期：</div>
					<div class="case_line_lie"><input type="text" id="selectDate" name="selectDate" onclick="WdatePicker();" onfocus="WdatePicker();"/></div>
					<div class="case_line_lie" style="text-align: right;">日志批注：</div>
					<div class="case_line_lie">
						<select name="isView" id="isView" style="width:84px">
							<option value = "-1">全部</option>
							<option value = "0">未批注</option>
							<option value = "1">新批注</option>
							<option value = "2">已查看</option>
						</select>
			    	</div>
					<div class="case_line_lie" style="border:0;height:23px;width:65px;">
					 	<input class="Search_Btn" id="Input" type="submit" value="查询" name="Input" style="border:0;height:23px;width:65px;" />
					</div>
			  </div>
			</form>
			<div >
			<form action="selctNumWorkLog.do?clear=0" method="post">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					月份:
					<select id="yue" name="yue">
					<option value="01">1月份</option>
					<option value="02">2月份</option>
					<option value="03">3月份</option>
					<option value="04">4月份</option>
					<option value="05">5月份</option>
					<option value="06">6月份</option>
					<option value="07">7月份</option>
					<option value="08">8月份</option>
					<option value="09">9月份</option>
					<option value="10">01月份</option>
					<option value="11">11月份</option>
					<option value="12">12月份</option>
				</select>
				&nbsp;&nbsp;
				日志类型:
				<select id="type" name="type">
					<option value="0">日日志</option>
					<option value="1">周日志</option>
					<option value="2">月日志</option>
				</select>
				&nbsp;&nbsp;
				员工：
					<input id="emp" value="${employeeName }" onblur="checkValueByRules('emp','','empMsg')"
					 onclick="completemission('showDialogOutbound.do?mark=employee','')" readonly="readonly">
					<input name="empid" id="empid" type="hidden" value="${employeeId }" />
				&nbsp;&nbsp;&nbsp;&nbsp;	
					<input id="selectWorklog" name="selectWorklog" type="submit" value="查询"/>
					<span style="margin-left:100px;">
					    <input id="selectWorklog" name="selectWorklog" type="button" onclick="exPage()" value="导出日志"/>
					</span>
				</form>	
			</div>
			<form id="form1">
				<!-- 中部表格 -->
				<div class="IP_Library">
					<div class="case_line2">
						<div class="case_line_lie" > 日志编号 </div>
						<div class="case_line_lie" > 日志类型 </div>
						<div class="case_line_lie" > 员工姓名 </div>
						<div class="case_line_lie" > 所属部门 </div>
						<div class="case_line_lie" > 提交时间 </div>
						<div class="case_line_lie" > 领导批注 </div>
						<div class="case_line_lie" > 详情查看 </div>
					</div>
					<c:if test="${empty pages.pageList}">
						<div class="case_line1">无日志</div>
					</c:if>
					<c:if test="${!empty pages.pageList}">
					<c:forEach items="${pages.pageList}" var="data" >
						<div class="case_line1">
							<div class="case_line_lie"> ${data.id }</div>
							<div class="case_line_lie">
								<c:if test="${data.type == 0}">工作日志</c:if>
								<c:if test="${data.type == 1}">工作周志</c:if>
								<c:if test="${data.type == 2}">工作月志</c:if>
							</div>
							<div class="case_line_lie"> ${data.employeeByEmpId.name } </div>
							<div class="case_line_lie"> ${data.employeeByEmpId.department.name } </div>
							<div class="case_line_lie"> ${data.recordTime }</div>
							<div class="case_line_lie">
								<c:if test="${data.isView == 0}"> 未批注</c:if>
								<c:if test="${data.isView == 1}"><font color="#ff0000">新批注</font></c:if>
								<c:if test="${data.isView == 2}"> 批注已查看</c:if>
							</div>
							<div class="case_line_lie case_line_xiangxi">
							  <input style="margin-left: 25px;" name="button" type="button" class="PopupButton2" onClick="showInfo2('${data.id}')" value="详情查看">
							</div>
						</div>
					</c:forEach>
					</c:if>
				</div>
				<!--分页-->
				<div class="Page">
				<c:if test="${mark==0}">
					<p:pages url="allListWorkLog.do"/>
					</c:if>
					<c:if test="${mark!=0}">
					<p:pages url="selctNumWorkLog.do"/>
					</c:if>
				</div>
			 </form>
		  </div>
		</div>
		<div id="contentF">
			
		</div>
<!--右栏 结束-->
<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
</body>
</html>
