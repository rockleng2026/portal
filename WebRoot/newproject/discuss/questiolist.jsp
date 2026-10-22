<%@ page language="java" import="java.util.*"
	 pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@page import="com.fuao.fajxc.vo.Scheduleplan"%>
<%@page import="com.fuao.fajxc.vo.NewProject"%>
<%@page import="com.fuao.fajxc.vo.NewQuestion"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>无标题文档</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<script type="text/javascript" src="<%=path%>/js/jquery-1.4.js"></script>
		<script language="javascript" type="text/javascript" defer="defer"
			src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/options.js"></script>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<style type="text/css">
dl,dd,dt,ul,ol,p,h2 {
	padding: 0px;
	margin: 0px;
}

ul {
	list-style-type: none;
}

body {
	width: 1024px;
	margin: 0 auto;
}

.Listtop {
	background: url(images/fornum/topbj.jpg);
	width: 1024px;
	height: 29px;
	float: left;
}

.put {
	width: 135px;
	height: 22px;
	border: 1px solid #005ab2;
	padding: 0px;
	margin: 0px;
}

.Listbd {
	width: 1024px;
	height: 25px;
	float: left;
	font-size: 14px;
}

.Listbd dl {
	width: 330px;
	float: left;
	margin-top: 10px;
}

.Listbd dd {
	width: 110px;
	float: left;
	text-align: right;
	line-height: 25px;
}

.Listbd dt {
	width: 220px;
	float: left;
}

.Listan {
	width: 1024px;
	height: 35px;
	text-align: center;
	float: left;
	margin-top: 20px;
	border-bottom: 1px solid #a7a7a7;
}

.put_1 {
	background: url(/images/ss.jpg) no-repeat;
	padding: 0px;
	margin: 0px;
	width: 67px;
	height: 26px;
	border: none;
}

.put_2 {
	background: url(images/qk.jpg) no-repeat;
	padding: 0px;
	margin: 0px;
	width: 67px;
	height: 26px;
	border: none;
}

.put_3 {
	background: url(images/dc.jpg) no-repeat;
	padding: 0px;
	margin: 0px;
	width: 67px;
	height: 26px;
	border: none;
}

.left {
	padding-left: 20px;
}

.zt {
	padding-left: 20px;
	font-size: 14px;
	font-weight: bold;
}

.STYLE1 {
	font-size: 12px;
}

.STYLE2 {
	padding-left: 20px;
	font-size: 12px;
}

.bk {
	border-bottom: 1px solid #c6c6c6;
}

.sz {
	width: 885px;
	float: left;
	text-align: center;
}

.sz dl {
	width: 520px;
	margin: 0 auto;
	margin-top: 10px;
}

.sz dd {
	width: 270px;
	float: left;
	height: 25px;
	line-height: 25px;
}

.sz dd a {
	font-size: 12px;
	border: 1px solid #eaeef1;
	float: left;
	padding-left: 10px;
	padding-right: 10px;
	margin: 0 3px;
	text-decoration: none;
	color: #0607cf;
}

.sz dt {
	width: 250px;
	float: left;
	height: 25px;
	font-size: 14px;
	color: #b0b0b0;
}

.sz strong {
	color: #fe781f;
	font-weight: normal;
}

.ip {
	width: 30px;
	padding: 0px;
	margin: 0px;
	border: 1px solid #98b0c6;
}

.listjs_1 {
	height: 30px;
	line-height: 30px;
	padding-left: 58px;
	font-size: 14px;
	background: url(images/hdhover.gif) 58px 0px no-repeat;
	float: left;
	margin-top: 10px;
}

.listjs_1 a {
	text-decoration: none;
}

.listjs_1 ul li {
	float: left;
}

.listjs_1 ul li a {
	display: block;
	text-align: center;
	width: 151px;
	color: #002862 !important;
}

.mont2 a {
	display: block;
	width: 151px;
	height: 30px;
	color: #ffffff;
}
.schelist tr td{
	background:url(images/fornum/bjbj.jpg);
}
</style>
		<script type="text/javascript">
	function onsubmitOnAction()
	{
		var creattime = $("#creattime").val();
		var endTime = $("#endTime").val();
		var questionname = encodeURI($("#questionname").val(),"utf-8");
		$("#hidename").val(questionname);
		var questionname1 = $("#questionname1").val();
		var dataValue = $("#dataname").val();
		var dataValue1 = $("#dataname1").val();

		var url = "";
		if(dataValue == "1")
		{
			url = "selectQuestionProject.do";
			$("#form1").attr("action",url);
			$("#form1").submit();
		}	
		if(dataValue1 == "2")
		{
			url = "findByscheduleplanQuestionProject.do";
			$("#form1").attr("action",url);
			$("#form1").submit();
		}
		if(dataValue == "" && dataValue1 == "")
		{
			url = "selectQuestionProject.do?createtime="+creattime+"&endTime="+endTime+"&questionname="+questionname;
			$("#form1").attr("action",url);
			$("#form1").submit();
		}
	}
	function onchanggetquestionname()
	{
		var pname =$("#projects").children('option:selected').val();
		$("#questionname1").val(pname);
	}
	function setTab5()
	{
		 $("#con1_wz3_1").show();
		 $("#con1_wz3_2").hide();
		 $("#wz31").attr("style","background:url(<%=request.getContextPath() %>/images/hd.gif); background-repeat:no-repeat;");
		 $("#wz32").attr("style","background:url(<%=request.getContextPath() %>/images/hd1.png); background-repeat:repeat-x;");
		 window.location.href="selectQuestionProject.do";
	}
	 function setTab6(){
		 $("#con1_wz3_1").hide();
		 $("#con1_wz3_2").show();
		 $("#wz31").attr("style","background:url(<%=request.getContextPath() %>/images/hd1.png); background-repeat:repeat-x;");
		 $("#wz32").attr("style","background:url(<%=request.getContextPath() %>/images/hd.gif); background-repeat:no-repeat;");
		   
		  var url = "findByscheduleplanQuestionProject.do";
		  window.location.href = url;
		}
		function show(id){           
			showWindwoButton('id','项目便签详细','800','550',"findByonescheQuestionProject.do?id="+id);          
		}  
</script>
	</head>

	<body leftmargin="0" topmargin="0" rightmargin="0">
		<form action="selectQuestionProject.do" method="post" id="form1">
		<input type="hidden" value="" id="questionname1" name="questionname1"/>
		<input type="hidden" value="" id="hidename" name="hidename"/>
			<div class="Listtop"
				style="background:url(<%=path%>/images/topbj.jpg); width:1024px; height:29px; float:left"></div>
			<div class="Listbd">
				<dl>
					<dd>
						标题:
					</dd>
					<dt>
						<input name="questionname" value="${titlename}" id="questionname" type="text"
							class="put" />
					</dt>
				</dl>
				<dl>
					<dd>
						时间:
					</dd>
					<dt>
						<input type="text" id="creattime" value="" name="creattime" class="Wdate"
							style="width: 80px;" onclick="WdatePicker();" />
						&nbsp;至&nbsp;
						<input type="text" name="endTime" value="" id="endTime" class="Wdate"
							style="width: 80px;" onclick="WdatePicker();" />
					</dt>
				</dl>
				<c:if test="${data == null}">
				<dl>
					<dd>
						项目名称:
					</dd>
					<dt>
						<select id="projects" onchange="onchanggetquestionname();">
							<option value="-1">
										--请选择--
							</option>
							<c:forEach items="${newPro1}" var="newpro">
								<option value="${newpro.id}" <c:if test="${newpro.id == pid}">selected</c:if> >
									${newpro.projectname}
								</option>
							</c:forEach>
						</select>
					</dt>
				</dl>
				</c:if>
			</div>
			<div class="Listan">
				<input name="" type="button" onclick="onsubmitOnAction();"
					class="put_1" value=" "
					style="background: url(<%=path%>/images/ss.jpg) no-repeat;CURSOR:hand;" />
				<input name="" type="button" onclick="resetjsp();" class="put_2" value=" "
					style="background: url(<%=path%>/images/qk.jpg) no-repeat;CURSOR:hand;" />
			</div>
		</form>
		<span style="text-align: left;height: 24px;width: 100%;">您现在的位置：<a href="<%=path%>/QuestionListQuestionProject.do">问题模块</a>  》讨论社区</span>
		<div class="listright">
		<c:if test="${data != null}">
		<input type="hidden" value="1" name="dataname" id="dataname"/>
			<h2 class="listjs_1">
				<ul>
					<li id="wz31"  class="mont2" style="background:url(<%=request.getContextPath() %>/images/hd.gif); background-repeat:no-repeat;" onclick="setTab5();">
						<a href="#">讨论问题</a>
					</li>
					<li id="wz32" class="" style="" onclick="setTab6();">
						<a href="#">领导评价</a>
					</li>
				</ul>
			</h2>
		</c:if>
		<c:if test="${data ==null}">
		<input type="hidden" value="2" name="dataname1" id="dataname1"/>
			<h2 class="listjs_1">
				<ul>
					<li id="wz31"  class="mont2" style="" onclick="setTab5();">
						<a href="#">讨论问题</a>
					</li>
					<li id="wz32" class="" style="background:url(<%=request.getContextPath() %>/images/hd.gif); background-repeat:no-repeat;"  onclick="setTab6();">
						<a href="#">领导评价</a>
					</li>
				</ul>
			</h2>
		</c:if>  
			<c:if test="${data !=null}">
			<div class="listjs_2" id="con1_wz3_1"  style="float:left; padding-left:58px;">
				<table width="908" border="0" align="center" cellpadding="0"
					cellspacing="0" class="bk">
					<tr>
						<td height="26" colspan="5" width="904" bgcolor="#9dd9fd" class="zt">
							讨论问题
						</td>
					</tr>
					<tr>
						<td width="70" height="37" align="center" valign="middle">
							<span class="STYLE1">浏览次数</span>
						</td>
						<td width="543" height="37" class="STYLE2">
							标题
						</td>
						<td width="100" height="37" align="center" valign="middle">
							<span class="STYLE1">作者</span>
						</td>
						<td width="120" height="37" align="center">
							<span class="STYLE1">最后处理时间</span>
						</td>
					</tr>
					<tbody>
					<% 
					List pagequestionList = (List) request.getAttribute("data");
						if(pagequestionList != null && pagequestionList.size()>0){
							for(int m = 0; m<pagequestionList.size();m++)
							{
								NewQuestion newQuestionS = (NewQuestion) pagequestionList.get(m);
						
							
					%>
							<tr class="topbk">
								<td width="70" height="37" align="center" valign="middle"
									background="<%=path%>/images/fornum/bjbj.jpg">
									<span class="STYLE1"><%=newQuestionS.getPid()%></span>
								</td>
	
								<td width="543" height="37"
									background="<%=path%>/images/fornum/bjbj.jpg" class="STYLE2">
									<% if(newQuestionS.getHandlestatus()== '2'){%>
										<a
											href="selectIdQuestionProject.do?id=<%=newQuestionS.getId() %>&indexdemo=<%=newQuestionS.getIndexdemos() %>"><%=newQuestionS.getQuestionname()%>(已结贴)</a>
									<%} %>
									<%if(newQuestionS.getHandlestatus() != '2'){ %>
										<a
											href="selectIdQuestionProject.do?id=<%=newQuestionS.getId() %>&indexdemo=<%=newQuestionS.getIndexdemos() %>"><%=newQuestionS.getQuestionname()%></a>
									<%} %>
								</td>
								<td width="100" height="37" align="center" valign="middle"
									background="<%=path%>/images/fornum/bjbj.jpg">
									<span class="STYLE1"><%=newQuestionS.getEmployee().getName() %></span>
								</td>
								<td width="120" height="37" align="center"
									background="<%=path%>/images/fornum/bjbj.jpg">
									<span class="STYLE1"><%=newQuestionS.getLastdate()%></span>
								</td>
							</tr>
						<%} %>
							<tr>
								<td colspan="4" style="font-size: 12px;"><p:pages url="selectQuestionProject.do" /></td>
							</tr>
							<%} else{%>
								<tr>
									<td colspan="7" align="center">查无数据</td>
								</tr>
							<%} %>
					</tbody>
				</table>
			</div>
		</c:if>
			<c:if test="${data ==null}">
			<div class="listjs_2" id="con1_wz3_2" style="float:left; padding-left:58px;">
				<table width="908" border="0" align="center" cellpadding="0"
					cellspacing="0" class="bk">
					<tr>
						<td height="26" colspan="7"  bgcolor="#9dd9fd" class="zt">
							评价进度
						</td>
					</tr>
					<tr>
						<td width="70" height="37" align="center" valign="middle">
							<span class="STYLE1">回复次数</span>
						</td>
						<td width="200" height="37" class="STYLE2" align="left">
							标题
						</td>
						<td width="100" height="37" align="left" class="STYLE2">
							项目名称
						</td>
						<td width="50" height="37" align="center" valign="middle">
							<span class="STYLE1">作者</span>
						</td>
						<td width="300" height="37" align="center" valign="middle">
							<span class="STYLE1">创建时间</span>
						</td>
						<td width="120" height="37" align="center">
							<span class="STYLE1">项目功能</span>
						</td>
						<td width="60" height="37" align="center">
							<span class="STYLE1">操作 </span>
						</td>

					</tr>
					
					<tbody id="schelist">
					
					<%
					  List listshce = (List) request.getAttribute("schadulplan");
					  if(listshce != null && listshce.size()>0)
					  {
					  for(int l =  0;l<listshce.size();l++){
						Scheduleplan scheduleplan = (Scheduleplan) listshce.get(l);  
					%>
						<tr class="topbk">
							<td width="70" height="37" align="center" valign="middle"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1"><%=scheduleplan.getTmp()%></span>
							</td>
							<%if("1".equals(scheduleplan.getTmp1()) || "2".equals(scheduleplan.getTmp2())){ %>
							<td width="200" height="37"
								background="<%=path%>/images/fornum/bjbj.jpg" class="STYLE2">
								<a href="selectId1QuestionProject.do?sid=<%=scheduleplan.getId()%>&indexdemo=2"><%=scheduleplan.getSubjecttitle()%></a>
							</td>
							<%} else{%>
							<td width="200" height="37"
								background="<%=path%>/images/fornum/bjbj.jpg" class="STYLE2">
								<%=scheduleplan.getSubjecttitle()%>
								</td>
							<%} %>
							<td width="100" height="37" valign="middle" align="center"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1"><%=scheduleplan.getFunction().getNewProject().getProjectname()%></span>
							</td>
							<td width="50" height="37" align="center" valign="middle"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1"><%=scheduleplan.getEmployee().getName()%></span>
							</td>
							<td width="300" height="37" align="center" valign="middle"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1"><%=scheduleplan.getBegintime()%></span>
							</td>
							<td width="120" height="37" align="center"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1"><%=scheduleplan.getFunction().getFunctionname()%></span>
							</td>
							<td width="60" height="37" align="center" valign="middle"
								background="<%=path%>/images/fornum/bjbj.jpg">
								<span class="STYLE1" onclick="show('<%=scheduleplan.getId()%>');"  style="CURSOR:hand; color:#4A88DF;">详情</span>
							</td>
						</tr>
					<%} %>
					
					</tbody>
					<tr> 
						<td colspan="6" style="font-size: 12px;"><p:pages url="findByscheduleplanQuestionProject.do" /></td>
					</tr>
					<%}else { %>
						<tr>
							<td colspan="7" align="center">查无数据</td>
						</tr>
					<%} %>
				</table>
			</div>
			</c:if>




		</div>
	</body>
</html>


