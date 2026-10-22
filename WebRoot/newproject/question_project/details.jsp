<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewQuestion"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
	<title>项目问题详情</title>
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
<body onload="onloadquest();" style="margin-top: 50px;background-color: gray;">
<form action="#" method="get">
     <div id="resulthight">
     <% NewQuestion newQuestion1 = (NewQuestion)request.getAttribute("newquest"); %>
     <input type="hidden" name="filename" id="filename" value="<%=newQuestion1.getQuestioninfo()%>" />
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    		<tr align="left">
    			<td colspan="2" align="left"><h3><img src="<%=request.getContextPath() %>/icons/img.gif"></img>问题详细信息</h3></td>
    		</tr>
			<tr style="height: 30px;"> 
				<td class="rightbold" width="30%">问题名称：</td>
				<td width="70%"><%=newQuestion1.getQuestionname()%></td>
			</tr>
			<tr> 
				 <td class="rightbold">优先级：</td>
				 <td>
				 	<span id="pic"　style="margin-top: 10px;">
	                    <%
						 java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
						 Date lastdate=dateFormat2.parse(newQuestion1.getLastdate());
						 Date now=new Date();
						 long l=lastdate.getTime()-now.getTime(); 
						 long day=l/(24*60*60*1000); 
						 if(day>=7){%>
						 	 <img src="<%=request.getContextPath() %>/img/green.gif"></img><label style="font-size: 12px;">&nbsp;&nbsp;(优先级为低)</label>
						 <%}else if(day>=3 && day<7){%>
							 <img src="<%=request.getContextPath() %>/img/yellow.gif"></img><label style="font-size: 12px;">&nbsp;&nbsp;(优先级为一般)</label>
						 <%}else if(day<=1){%>
						 	 <img src="<%=request.getContextPath() %>/img/red.gif"></img><label style="font-size: 12px;">&nbsp;&nbsp;(优先级为高)</label>
						 <%}%>
	                 </span>
	             </td> 
			</tr>
			<tr> 
				<td class="rightbold">问题描述：</td>
				<td>
					<textarea name="content" disabled="disabled" id="content" class="textarea" style='width: 450px; height: 150px;'></textarea>
				</td>
			</tr>
			<tr>
				<td class="rightbold">创建人：</td>
				<td><%=newQuestion1.getEmployee().getName()%> </td>
			</tr>
			 <tr> 
			 	<td class="rightbold">截止时间：</td>
			 	<td><%=newQuestion1.getLastdate()%></td>
			 </tr>
			 <tr>
			 	<td align="center" colspan="2">
			      <button type="button"  onclick="javascript:history.back(-1);"><span class="icon_close">关闭</span></button>
			    </td>
			 </tr>
		</table>
	</div>
</form>
	</body>

</html>