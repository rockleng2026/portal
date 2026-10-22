<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>模板添加/编辑</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
		<link rel="stylesheet" type="text/css" href="./cms/css/checkform-demo.css">
		<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
		<style type="text/css">
		  @import url("cms/css/admin.css");
		</style>
		<script type="text/javascript">
		   function save(){
			   $('#form1').attr("action","<%=request.getContextPath() %>/cms/updateTempTemplate.do");
	    	   var oEditor = FCKeditorAPI.GetInstance("messagecontent");
	    	   var fck=oEditor.EditorDocument.body.innerText;
	           if(fck==null||fck==''){
	        	   oEditor.EditorDocument.body.innerHTML="请输入内容...";
	        	   oEditor.EditorDocument.attachEvent("onclick", clearFCK);
	        	   return;
		       }
	    	   $('#cont').val(fck);
	    	   var tempname=$("#tempname").val();
	    	   var temp=$("#temp").val();
	    	   var fdir=$("#fdir").val();
	    	   var fname=$("#fname").val();
	    	   var action=$("#action").val();
	    	   if(tempname==null||tempname==''){
		    	   alert("请输入模板名称！");
		    	   return;
		       }
		       if(temp==null||temp==''){
			       alert("请输入模板风格！");
			       return;
			   }
		       if(fdir==null||fdir==''){
			       alert("请输入模板路径！");
			       return;
			   }
		       if(fname==null||fname==''){
			       alert("请输入模板文件名称！");
			       return;
			   }
		       if(action==null||action==''){
			       alert("请输入模板调用方法！");
			       return;
			   }
	    	   this.form1.submit();
		   }
		   function clearFCK(){
		 	   var oEditor = FCKeditorAPI.GetInstance("messagecontent");
		 	   oEditor.EditorDocument.body.innerHTML="";
		 	}
		</script>
	</head>
<body onload="loading()">
<div id="weizhi" >
<div id="weizhiwz">当前位置&nbsp;&gt;&gt;&nbsp;模板管理&nbsp;>>&nbsp;模板添加/编辑</div>
 </div>
<div class="conSet">
<form action="" method="post" id="form1" name="form1">
<div id="divmsg" class="errors">
</div>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="space tableBg">
		<tr><td align="left" nowrap class="bg0" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板名称*：
		<span>
		<input name="template.name" id=tempname type="text" value="${template.name }" />
		<input type="hidden" name="template.id" id="tid" value="${template.id }"/>
		<span id="datemsg" style="color:red;"></span>
		</span>
  <tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板站点*：
		<span>
		<input name="template.classes.classid" id=sitekey type="hidden" value="${sitekey }" />
		<input name="sitename" id=sitename type="text" value="${sitename }" readonly="readonly" />(*只读)
		 <!--  
		 <select name="template.classes.classid">
		      <c:if test="${template.classes.classname==null}">
		         <option value="-1">--所有--</option>
		         <c:forEach items="${typelist}" var="type">
		            <option value="${type.classid }">${type.classname }</option>
		         </c:forEach>
		         
		      </c:if>
		      <c:if test="${template.classes.classname!=null}">
		         <c:forEach items="${typelist}" var="type">
		            <option value="${type.classid }">${type.classname }</option>
		         </c:forEach>
		      </c:if>
		 </select>
		 -->
		<span id="titlemsg" style="color:red;"></span>
		</span>
		</td></tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板描述*：
		<span>
		<input type="text" name="template.temp" id="temp" size="50" value="${template.temp}" /> eg首页模板(风格一)
		<span id="ftitlemsg" style="color:red;"></span>
		</span>
		</td></tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板类型*：
		<span>
		  <select name="template.mid">
		    <% String s5="";String s1="";String s2="";String s3="";String s4=""; %>
		    <c:if test="${template.mid==1}">
		       <% s1="selected"; %>
		    </c:if>
		    <c:if test="${template.mid==2}">
		       <% s2="selected"; %>
		    </c:if>
		    <c:if test="${template.mid==3}">
		       <% s3="selected"; %>
		    </c:if>
		    <c:if test="${template.mid==4}">
		       <% s4="selected"; %>
		    </c:if>
		    <c:if test="${template.mid==5}">
		       <% s5="selected"; %>
		    </c:if>
		    
		    <option value="1" <%=s1 %>>首页</option>
		    <option value="2" <%=s2 %>>栏目页</option>
		    <option value="3" <%=s3 %>>内容页</option>
		    <option value="4" <%=s4 %>>最新页</option>
		    <option value="5" <%=s5 %>>其他页</option>
		  </select>
		<span id="sourcemsg" style="color:red;"></span>
		</span>
		</td></tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板内容：<font color="red">*请变更模板前请注意保存，建议copy内容到文本文件中备份一次(模板内容此处未启用)</font>
		<input type="hidden" name="template.contents" id="cont" value="">
		</td>
		</tr>
		<tr><td align="left" nowrap class="bg0" colspan="2">
		<FCK:editor instanceName="messagecontent" inputName="messagecontent" height="600px" basePath="/fckeditor">
		<jsp:attribute name="value">
		   ${template.contents }
		</jsp:attribute>
		</FCK:editor>
		</td></tr>
		<tr><td align="left" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;以下只有管理员能够编辑*:</td></tr>
	    <tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板路径*:
		<span>
		<input type="text" name="template.fdir" id="fdir" size="50" value="${template.fdir }"  <c:if test="${editable != 'true'}">readonly='readonly'</c:if>/>(* 以/cms/*开头) 
		</span>
		</td></tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板文件名称*:
		<span>
		<input type="text" name="template.fname" id="fname" size="50" value="${template.fname }"  <c:if test="${editable != 'true'}">readonly='readonly'</c:if>/>(* eg *.jsp)  
		</span>
		</td></tr>
		<tr><td align="left" nowrap class="bg0"  colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;模板调用方法*:
		<span>
		<input type="text" name="template.do_action" id="action" size="50" value="${template.do_action }" <c:if test="${editable != 'true'}">readonly='readonly'</c:if> />(* http://localhost:8080/FAJxc/+路径+文件名") 
		</span>
		</td></tr>
           <tr>
             <td colspan="2" align="center" nowrap class="bg1">
		        <input type="button" class="save_but"  value="保 存" onclick="save()">
             </td>
           </tr>
</table>
	</form>
</body>

</html>
