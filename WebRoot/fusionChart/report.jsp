<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.NewTask"%>
<%@page import="com.fuao.fajxc.dao.newproject.QuestionProject"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
		QuestionProject questiondao=(QuestionProject)request.getAttribute("questiondao");			
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>任务进度报表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>

		<script language="javascript" src="../js/desk/stm31.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/FusionCharts.js"></script>
		<script language="javascript" type="text/javascript" defer="defer"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<LINK href="<%=request.getContextPath()%>/Css/desk/desktop.css"
			type=text/css media=screen rel=stylesheet>
		<LINK href="<%=request.getContextPath()%>/Css/desk/mode.css"
			type=text/css media=screen rel=stylesheet>
		<LINK href="<%=request.getContextPath()%>/Css/move.css" type=text/css
			rel=stylesheet>
		
				<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true"></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true"></jsp:include>
		<base target="_self">

		<script type="text/javascript">
	function onsubmitclick(){
			var proid = $("#proid").children('option:selected').val();
			$("#hidepro").val(proid);
			$("#form1").submit();
		}
	function clickbutton(){
			
		}
</script>
		<style type="text/css">
#marquee,#marquee ul {
	padding: 0px;
	margin: 0px;
}

#marquee {
	position: relative;
	list-style: none;
	height: 230px;
	width: 600px;
	overflow: hidden;
}

#marquee ul {
	position: absolute;
}
</style>

		<script type="text/javascript">
var typenum=0;
  var Marquee = function(id){
    try{document.execCommand("BackgroundImageCache", false, true);}catch(e){};
    var container = document.getElementById(id),
    slide = container.getElementsByTagName("ul")[0],
    speed = arguments[1] || 80,  //速度
    delta = 0,//当前滚动的位置
    critical = slide.offsetHeight;//临界点
    slide.innerHTML += slide.innerHTML;
    var rolling = function(){
      delta == -critical ? delta = 0 : delta--;
      slide.style.top = delta + "px";
    }
    var timer = setInterval(rolling,speed);//设置定时器
    container.onmouseover=function() {clearInterval(timer)}//鼠标移到marquee上时，清除定时器，停止滚动
    container.onmouseout=function() {timer=setInterval(rolling,speed)}//鼠标移开时重设定时器
  }
  window.onload = function(){
    Marquee("marquee");
  }
  function showfj(name){
		var url = encodeURI(name,'GBK');
  window.location.href="<%=path%>/downloadTaskUpload.do?url="+url;
  }
  
  //项目总览
  function taskwatch()
  {
   window.location.href="<%=path %>/fusionChartsQuestionProject.do";
   
  }
  //甘特图
  function gante()
  {
     window.location.href="<%=path %>/projectGTTnewProject.do";
  
  }
  
</script>
	</head>

	<body>
		<div id="box2" class="box2"
			style='border: #89aad7 1px solid; margin-bottom: 10px;'>
			<form action="fusionChartsQuestionProject.do" method="post"
				id="form1">
				<input type="hidden" value="" id="hidepro" name="hidepro" />
				<div align="center">
					项目名称：
					<select id="proid" onchange="onsubmitclick();">
						<option value="-1">
							--请选择--
						</option>
						<c:forEach items="${proList}" var="prolist">
							<option value="${prolist.id}" <c:if test="${prolist.id == hidepro }">selected</c:if> >
								${prolist.projectname}
							</option>
						</c:forEach>
					</select>
				</div>
			</form>
			<div align="left" style="padding-top: 10px;">
			<h3>
			<a href="<%=path %>/fusionChartsQuestionProject.do">项目总览</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=path %>/projectGTTnewProject.do">甘特图</a>
			</h3>		
			<span>您现在的位置：项目总览</span>
			</div>
		</div>
		<DIV ID=Content style="voerflow-y:auto;height:380px;">
			<!-- 左边左面开始 -->
			<DIV STYLE="width: 100%; float: left;margin-buttom:10px;" ID=sub>
				<!--柱状图 -->
				<div urlvalue="Oasp2903" functionid="FUNC00005" recordcount="5"
					minflg="0" class="DesktopBlock" id="FUNC00005">
					<DIV ID=Block>
						<div>
							<div
								style="height: 20px; border: 1px solid #4891C6; background-color: #3F9DE7; color: #FFFFFF;"
								align="center">
								项目进度
							</div>
							<c:if test="${list==null}">
								<div style="height: 232px;" align="center">
									查无数据
								</div>
							</c:if>
							<c:if test="${list!=null}">
								<DIV ID="BlockHead1" style="height: 232px;">

								</DIV>

								<script type="text/javascript">
						var chartXML="<chart caption='项目进度(当前${nowTime})'   yAxisMaxValue='100' subcaption='' baseFontSize='11'  showvalues='0'  yAxisName='完成度' xAxisName='项目名称' decimals='2'  numberSuffix='%25'>"+
						  <c:forEach items='${list}' var='pro'>
						  "<set label='${pro.projectname}' value='${pro.schedule}' hoverText='${pro.projectname},完成度${pro.schedule}%25(${pro.begintime}~${pro.endtime})' />"+
						 </c:forEach>
						"</chart>";
					
							var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/Column2D.swf","myid","584","230","0","0");
							mychart.setDataXML(chartXML);
							mychart.render("BlockHead1");
					</script>
							</c:if>
						</div>
					</div>
				</div>
				</div>
				<!--柱状图结束 -->

          <DIV STYLE="width: 100%; float: right;margin-buttom:10px;" ID="right">

				<!-- 饼状图开始 -->
				<div functionid="FUNC00007" recordcount="5" minflg="0"
					class="DesktopBlock" id="FUNC00007">
					<DIV ID="Block">
						<div>
							<div align="center"
								style="height: 20px; border: 1px solid #4891C6; background-color: #3F9DE7; color: #FFFFFF;">
								任务(功能)进度
							</div>
							<c:if test="${functionList==null}">
								<div align="center" style="height: 232px;">
									查无数据
								</div>
							</c:if>
							<c:if test="${functionList!=null}">
								<DIV ID="BlockHead3" style="height: 232px;">
								</DIV>

								<script type="text/javascript">
						
						
						var chartXML2="<chart caption='${proname}${startTime} 至 ${endTime}(当前${nowTime})'   yAxisMaxValue='100' subcaption='' baseFontSize='11'  showvalues='0'  yAxisName='完成度' xAxisName='项目名称' decimals='2'  numberSuffix='%25'>"+
						<c:forEach items='${functionList}' var='function'>								
						"<set label='${function.functionname}' value='${function.fstate}' hoverText='完成${function.fstate}%25进度'/>"+	
						</c:forEach>
						"</chart>";
							var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/Pie2D.swf","myChartid3","584","230","0","0");
							mychart.setDataXML(chartXML2);
							mychart.render("BlockHead3");
					</script>
							</c:if>
						</div>
					</DIV>
				</div>
				</div>
				<!-- 饼状图开始 -->
				<DIV STYLE="width: 100%; float: left;margin-buttom:10px;" ID=sub>
				<div urlvalue="Oasp9006" functionid="FUNC00019" recordcount="5"
					minflg="0" class="DesktopBlock" id="FUNC00019">
					<DIV ID="Block">
						<div>
							<div
								style="height: 20px; border: 1px solid #4891C6; background-color: #3F9DE7; color: #FFFFFF;"
								align="center">
								人员进度
							</div>
							<c:if test="${pages==null}">
								<div style="height: 232px;" align="center">
									查无数据
								</div>
							</c:if>
							<c:if test="${pages!=null}">
								<DIV ID="BlockHead2" style="height: 232px;">
									<table border="1" align="center" cellpadding="0" width="586px"
										cellspacing="0" class="tableStyle" id="youshuju">
										<tr align="center">
											<td>所属项目</td>
											<td>上级任务</td>
											<td>任务名称</td>
											<td>执行人</td>
											<td>人员进度</td>
											<td>开始时间</td>
											<td>结束时间</td>
											<td>当前时间</td>
										</tr>
										<% List taskList1 = (List) request.getAttribute("taskList");
										   if(taskList1 != null && taskList1.size()>0){
										   String proname1 = request.getAttribute("proname").toString();
										   String nowTime1 = request.getAttribute("nowTime").toString();
										   for(int m = 0; m<taskList1.size();m++)
										   {
											   NewTask newTask1 = (NewTask) taskList1.get(m);  
										%>
										
											<tr align="center">
												<td><%=proname1 %></td>
												<td>
												    <% if(newTask1.getFunction().getParentid()==-1){%>无<%}else{
												    	NewFunction fun=(NewFunction)questiondao.getObj(NewFunction.class,newTask1.getFunction().getParentid());
												    %>
												        <%=fun.getFunctionname() %>
												    <%} %>
												</td>
												<td align="left"><%=newTask1.getFunction().getFunctionname()%></td>
												<td><%=newTask1.getEmp().getName()%></td>
												<td><%=newTask1.getSchedule()%>%</td>
												<td><%=newTask1.getBegintime() %></td>
												<td><%=newTask1.getEndtime() %></td>
												<td><%=nowTime1%></td>
											</tr>
										<%} }%>
										<tr>
											<td colspan="9"><p:pages url="fusionChartsQuestionProject.do"/></td>
										</tr>
									</table>
								</DIV>
							</c:if>
						</DIV>
					</DIV>
				</div>
			</div>
			<!-- 饼状图结束 -->
			<!-- 右边 -->
			
				<!-- 饼状图结束 -->
				<!-- 无缝滚动开始 -->
				<DIV STYLE="width: 100%; float: right;margin-buttom:10px;" ID="right">
				<div urlvalue="Oasp2803" functionid="FUNC00004" recordcount="5"
					minflg="0" class="DesktopBlock" id="FUNC00004" style="">
					<DIV ID="Block">
						<div>
							<div align="center"
								style="height: 20px; border: 1px solid #4891C6; background-color: #3F9DE7; color: #FFFFFF;">
								滚动
							</div>

							<%--								<div align="center" style="height: 232px;">查无数据</div>--%>
							<div style="height: 232px;">
								<div id="marquee">
									<ul>
										<c:forEach items="${scheList}" var="sche">
											<li>${sche.employee.name}在${sche.begintime}修改了项目${sche.function.newProject.projectname}下的${sche.function.functionname}进度为${sche.isplan}%.... </li>
										</c:forEach>
									</ul>
								</div>

							</div>
						</div>
					</DIV>
				</div>
				<!-- 无缝滚动结束 -->
			</DIV>
		</DIV>
		<input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" />
	</body>
</html>
