<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
%>

<html>
	<head>

		<title>创建问题</title>
		
		<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true"></jsp:include>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<jsp:include page="/js/cha.jsp" flush="true"></jsp:include>
		<script language="javascript">
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
	function onsubmitquestion()
	{
		var names = $("#questionname").val();
		var times = $("#lasttime").val();
		if(names == "")
		{
			alert("名称不能为空");
			return false;
		}
		if(times == "")
		{
			alert("时间不能为空");
			return false;
		}
		editor.sync();
		var contents = encodeURI(editor.html(), "utf-8");
		var questionname = encodeURI($("#questionname").val(),"utf-8");
		var lasttime = encodeURI($("#lasttime").val(),"utf-8");
		var quid = $("#quid").val();
		var checkvar = document.getElementById("checkid");
		
		$.ajax({
			type:"POST",
			url:'createProQuestionProject.do',
			data:{
				"questionname":questionname,
				"lasttime":lasttime,
				"contents":contents
			},
			success:function(data)
			{
				if(data =="1")
				{
					alert("添加成功!");
					window.location.href="findBymequestionQuestionProject.do";
				}
				if(data == "2")
				{
					alert("添加问题失败!");
				}
				
			}
			});
	}

	//修改
	function onupdate()
	{
		editor.sync();
		var contents = encodeURI(editor.html(), "utf-8");

		var questionname = encodeURI($("#questionname").val(),"utf-8");
		var lasttime = encodeURI($("#lasttime").val(),"utf-8");
		var quid = $("#quid").val();
		
		$.ajax({
			type:"POST",
			url:'updateUIQuestionProject.do',
			data:{
				"questionname":questionname,
				"lasttime":lasttime,
				"contents":contents,
				"quid":quid
			},
			success:function(data)
			{
				if(data =="3")
				{
					alert("修改成功!");
					window.location.href="findBymequestionQuestionProject.do";
				}
				if(data == "4")
				{
					alert("修改失败!");
				}
				
			}
			});
	}
	function onloadquest()
	{
		editor.sync();
		textvalue =  editor.html();
		textvalue = $("#filename").val();
		editor.html($("#filename").val());
<%--		document.getElementById("content").innerHTML = $("#filename").val();--%>
	}

	function resetjsp1(){
		$("#questionname").val('');
		$("#lasttime").val('');
		editor.sync();
		editor.html('');
	}
	function onreset1()
	{
		$("#questionname").val($("#name1").val());
		$("#lasttime").val($("#time1").val());
		editor.sync();
		editor.html($("#filename").val());
	}
</script>
	</head>
	<body onload="onloadquest();" style="margin-top: 50px;background-color: gray;">
			<input type="hidden" name="filename" id="filename" value="${question.questioninfo}" />
			<input type="hidden" name="path" id="path" value="${question.fj}"/>
			<input type="hidden" name="quid" id="quid" value="${question.id}"/>
			<input type="hidden" id="name1" value="${question.questionname}"/>
			<input type="hidden" id="time1" value="${question.lastdate}"/>
			<div id="resulthight">
				<table style="width: 100%;" border="0" align="center"
					cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju">
					<tr>
						<th align="left" colspan="2">
							<img style="float: left;"
								src="<%=request.getContextPath()%>/icons/png/64.png" width="20"
								height="20"></img>
							<h3 style="text-align: left;">
								创建问题
							</h3>
						</th>
					</tr>
					<tr>
						<th>
							问题名称：
							<font color="red">(*)</font>
						</th>
						<td>
							<input type="text" id="questionname"
								name="newQuestion.questionname" onblur="checkValueByRules('questionname','','empMsg')" value="${question.questionname}" />
								<FONT id="empMsg" color=#ff0000></FONT>
						</td>
					</tr>
					<tr>
						<th>
							创建人：
							<font color="red">(*)</font>
						</th>
						<td>
							<input type="text"  value="${emp.name}" disabled="disabled"   readonly="readonly" />
						</td>
					</tr>
					<tr>
						<th>
							截止时间：
							<font color="red">(*)</font>
						</th>
						<td>
							<input type="text" id="lasttime" value="${question.lastdate}" onblur="checkValueByRules('lasttime','','timeMsg')"  name="newQuestion.lastdate"
								class="Wdate" style="width: 90px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'});" />
								<FONT id="timeMsg" color=#ff0000></FONT><label style="font-size: 12px;">(时间大于7天优先级为低,在3-7天优先级为一般,小于3天优先级为高)</label>
						</td>
					</tr>
					<tr>
						<th>
							问题描述：
							<font color="red">(*)</font>
						</th>
						<td>
							<textarea name="content" id="content" onblur="checkValueByRules('content','','contentMsg')"  class="textarea"
								 style='width: 450px; height: 150px;'>${question.questioninfo}</textarea>
								 <FONT id="contentMsg" color=#ff0000></FONT>
						</td>
					</tr>
					<tr>
						<th>
							当前时间：
							<font color="red">(*)</font>
						</th>
						<td>
							<input type="text"  value="${nowTime}"  disabled="disabled"  readonly="readonly" />
						</td>
					</tr>

					<tr>
						<td colspan="2" align="center">
						<c:if test="${question ==null}">
							<button name='cha' style="CURSOR:hand;" class="button" onclick="onsubmitquestion();">
								<span class="icon_save">保存</span>
							</button>
							</c:if>
							<c:if test="${question !=null}">
								<button name='cha' class="button" style="CURSOR:hand;" onclick="onupdate();">
								<span class="icon_save">修改</span>
							</button>
							</c:if>
							<c:if test="${question ==null}">
								<button type="button" style="CURSOR:hand;" onclick="resetjsp1();">
								<span class="icon_clear">清空</span>
								</button>
							</c:if>
							<!--<c:if test="${question !=null}">修改问题是从数据库里查出来的，不能进行重置
								<button type="reset" onclick="onreset1();"><span class="icon_clear">重置</span></button>
							</c:if>
							-->
							<button type="button" style="CURSOR:hand;" onclick="javascript:history.back(-1);">
								<span class="icon_close">关闭</span>
							</button>
						</td>
					</tr>
				</table>
			</div>
	</body>
</html>
