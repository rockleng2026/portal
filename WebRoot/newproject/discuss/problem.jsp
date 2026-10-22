<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.fuao.fajxc.vo.NewQuestion"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>评论</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
			<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<style type="text/css">
body {
	width: 1024px;
	margin: 0 auto;
	background: #f4f4f4
}

dd,dt,dl,ul,p,h1,h2 {
	margin: 0px;
	margin: 0px;
}

img {
	border: none
}

.Whole {
	width: 885px;
	margin: 0 auto;
}

.Problem {
	width: 885px;
	height: 47px;
	float: left;
	line-height: 44px;
	text-align: center;
	border: 1px solid #e1e1e0;
	margin-top: 16px;
	background: #FFFFFF
}

.Problem span {
	width: 145px;
	float: left;
	height: 44px;
	border-bottom: 3px solid #d5e6ee;
	font-weight: bold
}

.Problemxia {
	width: 885px;
	height: 215px;
	float: left;
	border: 1px solid #e1e1e0;
	border-top: none;
	background: #FFFFFF
}

.Problemleft {
	width: 144px;
	float: left;
	height: 212px;
	border-bottom: 3px solid #d5e6ee;
	border-right: 1px solid #d5e6ee;
	background: #f5fafe
}

.Problemleft span {
	width: 144px;
	float: left;
	text-align: center;
	padding-top: 17px;
}

.Problemleft span img {
	border: 1px solid #d1d2d3;
	padding: 4px;
}

.Problemleft p {
	width: 144px;
	float: left;
	text-align: center;
	font-size: 14px;
	color: #3d6cc9;
	font-weight: bold;
	padding-top: 5px;
}

.Problemright {
	width: 740px;
	float: left
}

.Problemrighttop {
	width: 720px;
	border-bottom: 1px dashed #e0e0e0;
	margin-left: 10px;
	margin-right: 10px;
	height: 30px;;
	line-height: 30px;
	font-size: 14px;
}

.Problemrighttop dd {
	width: 480px;
	float: left;
	background: url(images/fornum/xtb.jpg) no-repeat 0px 6px;
	padding-left: 20px;
}

.Problemrighttop dt {
	width: 200px;
	float: left;
	text-align: right;
	padding-right: 20px;
}

.ProblemrightMiddle {
	width: 700px;
	float: left;
	height: 133px;
	margin-left: 10px;
	margin-right: 10px;
	border-bottom: 1px dashed #e0e0e0;
	padding-top: 10px;
	font-size: 14px
}

.ProblemrightBottom {
	width: 700px;
	float: left;
	background: url(images/fornum/xtb_2.jpg) no-repeat 0px 10px;
	font-size: 14px;
	margin-left: 10px;
	padding-left: 20px;
	line-height: 35px
}

.wbzd {
	width: 670px;
	height: 133px;
	border: 0px;
	overflow: hidden
}

.sz {
	width: 885px;
	float: left;
	text-align: center
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
	color: #0607cf
}

.sz dt {
	width: 250px;
	float: left;
	height: 25px;
	font-size: 14px;
	color: #b0b0b0
}

.sz strong {
	color: #fe781f;
	font-weight: normal
}

.ip {
	width: 30px;
	padding: 0px;
	margin: 0px;
	border: 1px solid #98b0c6
}

.Bottom {
	width: 885px;
	float: left;
	margin-top: 10px;
}

.Bottom dd {
	width: 500px;
	float: left
}

.Bottom dd a {
	padding-left: 5px;
	padding-right: 5px;
}

.Bottom dt {
	width: 54px;
	height: 26px;
	float: right;
	line-height: 26px;
	background: url(images/fornum/fanhuibj.jpg) no-repeat;
	font-size: 12px;
	padding-left: 23px
}

.Bottom dt a {
	font-size: 12px;
	color: #000000;
	text-decoration: none
}

.Form {
	width: 883px;
	height: 194px;
	border: 1px solid #e0e0e0;
	margin-top: 10px;
}

.Formleft {
	width: 144px;
	float: left;
	border-right: 1px solid #ddecf2;
	text-align: center;
	padding-top: 18px;
	height: 176px;
}

.FormMiddle {
	width: 736px;
	float: left
}
</style>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery-1.4.js"></script>
		<script charset="utf-8"
			src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8"
			src="<%=request.getContextPath()%>/kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript">
	// 编辑器
	var objid;
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="content"]', {
			resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			items : [ 'fontname', 'fontsize', 'forecolor', '|', 'bold',
					'italic', 'underline', 'lineheight', 'removeformat', '|',
					'justifyleft', 'justifycenter', 'justifyright',
					'insertorderedlist', 'insertunorderedlist', '|', 'map',
					'image', 'link', 'source', 'fullscreen' ]
		});
	});
	function onsumbitclick() {
		editor.sync();
		var contents = encodeURI(editor.html(), "utf-8");
		if(contents == "")
		{
			alert("请填写内容!");
			return false;
		}
		var id = $("#questid").val();
		var indexdemo = $("#indexdemo").val();
		$.ajax( {
			type : "POST",
			url : "addProblemQuestionProject.do",
			data : {
				"id" : id,
				"contents" : contents,
				"indexdemo" : indexdemo
			},
			success : function(data) {
				alert("评论成功!");
				window.location.href = "selectIdQuestionProject.do?id=" + data+"&test=1";
			}
		});
	}
	function onsumbitclick1() {
		editor.sync();
		var contents = encodeURI(editor.html(), "utf-8");
		if(contents == "")
		{
			alert("请填写内容!");
			return false;
		}
		var id = $("#questid").val();
		var indexdemo = $("#indexdemo").val();
		var test = $("#questid1").val();
		$.ajax( {
			type : "POST",
			url : "addProblemQuestionProject.do",
			data : {
				"id" : id,
				"contents" : contents,
				"indexdemo" : indexdemo,
				"test":test
			},
			success : function(data) {
				alert("评论成功!");
				window.location.href = "selectId1QuestionProject.do?id=" + data;
			}
		});
	}
	function focutextare() {
		$("#content").focus();
	}
	function onloadTop() {
		$("#load").addClass("addload");
	}

	function onfocusIntext()
	{
		$("#content").focus();
	}
	function onzhidi()
	{	
		window.scroll(0,document.body.scrollHeight);
	}
	function onzhiding()
	{
		window.scroll(document.body.scrollWidth,0);
	}
	
	function add(){           
		showWindwoButton('id','创建问题列表','800','550',"createproUIQuestionProject.do");          
	}  	
	//结贴
	function jietie()
	{
		//问题ID
		var questid = $("#questid").val();
		$.ajax( {
			type:"POST",
			url:"jietieQuestionProject.do",
			data:{
				"questid":questid
			},
			success:function(data){
				if(data =="1")
				{
					window.location.href="findBymequestionQuestionProject.do";
				}
				if(data == "2")
				{
					alert("不能结贴");
				}
			}
		});
	}
</script>
	</head>

	<body>
		
		<div class="Whole">
		<c:if test="${question !=null}">
			<div class="Problem">
				<span>论坛问题：${question.questionname}</span>
			</div>
			<div class="Problemxia">
				<div class="Problemleft">
					<span><img src="images/fornum/youke.jpg" / width="72" height="72">
					</span>
					<p>
						${question.employee.name}
					</p>
				</div>
				<div class="Problemright">
					<div class="Problemrighttop">
						<dl>
							<dd>
								发表与${question.lastdate}
							</dd>
							<dt>
								楼主
							</dt>
						</dl>
					</div>
					<div class="ProblemrightMiddle" style="word-wrap:break-word;word-break:break-all;">
						${question.questioninfo}
					</div>
					<div class="ProblemrightBottom">
						<span onclick="onzhidi();" style="CURSOR:hand;">回复</span>
					</div>
				</div>

			</div>
			</c:if>
			<c:if test="${question ==null}">
			<div class="Problem">
				<span>论坛问题：${scheduleplan1.subjecttitle}</span>
			</div>
			<div class="Problemxia">
				<div class="Problemleft">
					<span><img src="images/fornum/youke.jpg" / width="72" height="72">
					</span>
					<p>
						${emp1.name}
					</p>
				</div>
				<div class="Problemright">
					<div class="Problemrighttop">
						<dl>
							<dd>
								发表与${scheduleplan1.begintime}
							</dd>
							<dt>
								楼主
							</dt>
						</dl>
					</div>
					<div class="ProblemrightMiddle" style="word-wrap:break-word;word-break:break-all;">
						${scheduleplan1.workcontent}
					</div>
					<div class="ProblemrightBottom">
						<span onclick="onzhidi();" style="CURSOR:hand;">回复</span>
					</div>
				</div>

			</div>
			</c:if>
			<c:forEach items="${pages.pageList}" var="pro">
			<div class="Problemxia">
				<div class="Problemleft">
					<span><img src="images/fornum/youke.jpg"  width="72" height="72">
					</span>
					<p>
						${pro.employee.name}
					</p>
				</div>
				<div class="Problemright">
					<div class="Problemrighttop">
						<dl>
							<dd>
								回复与${pro.time}
							</dd>
							<dt style="font-size: 12px;color:#3D6CC9;">
								 <a id="gototop" href="javascript:onzhiding();">Top</a>
							</dt>
						</dl>
					</div>
					<div class="ProblemrightMiddle" style="word-wrap:break-word;word-break:break-all;" >
						${pro.contents}
					</div>
				</div>
			</div>
			</c:forEach>
			<c:if test="${question !=null}">
			<div class="sz" style="font-size: 12px;">
					<pp:pages1 url="selectIdQuestionProject.do" param="quid=${question.id}&openmethod=1"/>
					回复次数：${count}
			</div>
			</c:if>
			<c:if test="${question ==null}">
			<div class="sz" style="font-size: 12px;">
					<pp:pages1 url="selectId1QuestionProject.do" param="quid=${scheduleplan1.id}&openmethod=1"/>
			</div>
			</c:if>
			<c:if test="${question !=null}">
			<input type="hidden" value="${question.id}" id="questid" />
			<input type="hidden" value="2" id="questid1" />
			<% NewQuestion newQuestion1 =(NewQuestion) request.getAttribute("question");
			   Employee employee1 =(Employee)request.getAttribute("emp");
			   String newid = newQuestion1.getEmployee().getId().toString();
			   String empid = employee1.getId().toString();
			%>
			<div class="Bottom">
				<dl>
					<dd>
						<%if(newQuestion1.getHandlestatus() !=2){ %><a href="javascript:onfocusIntext();"><img src="images/fornum/Reply.jpg" />
						</a>
						<%} %>
						<%if(newid.equals(empid) && newQuestion1.getHandlestatus() !=2){ %>
							<a href="javascript:jietie();"><img src="images/fornum/resole.png" /></a>
						<%} %>
						<%if(newQuestion1.getHandlestatus()==2){ %>
						<a href="javascript:jietie();"><img src="images/fornum/resole1.png" /></a>
						<%} %>
					</dd>
					<dt>
						<a href="javascript:window.history.go(-1);">返回列表</a>
					</dt>
				</dl>
			</div>
			<%if(newQuestion1.getHandlestatus() != 2){ %>
			<div class="Form">
				<div class="Formleft">
					<img src="images/fornum/fuhu.jpg" />
				</div>
				
				<div class="FormMiddle">
					<form action="addProblemQuestionProject.do" method="post">
	    <table width="700" height="200" align="center">
	    <input type="hidden" value="${question.id}" id="questid" />
	    <input type="hidden" value="${indexdemo}" name="indexdemo" id="indexdemo"/>
	    <tr align="center"><td><textarea name="content" id="content" class="textarea"  style='width:700px;height:300px;'></textarea></td></tr>
	    <tr align="left"><td onclick="onsumbitclick();" style="CURSOR:hand;" title="回复"><img alt="" src="images/fornum/Postreply.jpg"></td></tr>
	    </table>
    </form>
				</div>
				
			</div>
		<%} %>
			</c:if>
			<c:if test="${question ==null}">
			<input type="hidden" value="${scheduleplan1.id}" id="questid" />
			<input type="hidden" value="1" id="questid1" />
			<div class="Bottom">
				<dl>
					<dd>
						<a href="javascript:onfocusIntext();"><img src="images/fornum/Reply.jpg" />
						</a>
					</dd>
					<dt>
						<a href="findByscheduleplanQuestionProject.do">返回列表</a>
					</dt>
				</dl>
			</div>
			<div class="Form">
				<div class="Formleft">
					<img src="images/fornum/fuhu.jpg" />
				</div>
				
				<div class="FormMiddle">
					<form action="addProblemQuestionProject.do" method="post">
	    <table width="700" height="200" align="center">
	    
	    <input type="hidden" value="${indexdemo}" name="indexdemo" id="indexdemo"/>
	    <tr align="center"><td><textarea name="content" id="content" class="textarea"  style='width:700px;height:300px;'></textarea></td></tr>
	    <tr align="left"><td onclick="onsumbitclick1();" style="CURSOR:hand;" title="回复"><img alt="" src="images/fornum/Postreply.jpg"></td></tr>
	    </table>
    </form>
				</div>
				
			</div>
			</c:if>
			
		</div>
	</body>
</html>

