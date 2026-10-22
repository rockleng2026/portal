<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
	<title>项目便签问题详情</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/lang/zh_CN.js"></script>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
    </head>
    <script type="text/javascript">
<%--    var editor;--%>
<%--	KindEditor.ready(function(K) {--%>
<%--		editor = K.create('textarea[name="content"]', {--%>
<%--			resizeType : 1,--%>
<%--			allowPreviewEmoticons : false,--%>
<%--			allowImageUpload : false,--%>
<%--			items : [--%>
<%--'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',--%>
<%--'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',--%>
<%--'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']--%>
<%--		});--%>
<%--	});--%>
	function onloadquest()
	{
<%--		editor.sync();--%>
<%--		textvalue =  editor.html();--%>
<%--		textvalue = $("#filename").val();--%>
<%--		editor.html($("#filename").val());--%>
		document.getElementById("content").innerHTML = $("#filename").val();
		
	}
	
    </script>      
<body onload="onloadquest();">
<form action="#" method="get">
     <div id="resulthight">
     <input type="hidden" name="filename" id="filename" value="${sche.workcontent}" />
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    		<tr align="left">
    			<td colspan="2" align="left"><h3><img src="<%=request.getContextPath() %>/icons/img.gif"></img>项目便签详细信息</h3></td>
    		</tr>
			<tr style="height: 30px;"> 
				<td class="rightbold" width="30%">名称：</td>
				<td width="70%">${sche.subjecttitle}</td>
			</tr>
			
			<tr> 
				<td class="rightbold">描述：</td>
				<td>
					<textarea name="content" disabled="disabled" readonly="readonly" id="content" class="textarea" style='width: 450px; height: 150px;'></textarea>
				</td>
			</tr>
			<tr>
				<td class="rightbold">发布人：</td>
				<td>${sche.employee.name}</td>
			</tr>
			  <tr> 
			 	<td class="rightbold">所属项目功能：</td>
			 	<td>${sche.function.functionname}</td>
			 </tr>
			 <tr> 
			 	<td class="rightbold">开始时间：</td>
			 	<td>${sche.begintime}</td>
			 </tr>
			 <tr> 
			 	<td class="rightbold">结束时间：</td>
			 	<td>${sche.endtime}</td>
			 </tr>
			 <tr>
			 	<td align="center" colspan="2">
			      <button type="button"  onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
			    </td>
			 </tr>
		</table>
	</div>
</form>
	</body>

</html>