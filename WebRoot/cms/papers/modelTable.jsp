<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>system menu list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
			@import url("cms/css/admin.css");
	</style>
	<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
	<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="./cms/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="./cms/js/modelTable.js"></script>
	<script type="text/javascript">
	    function del(id){
	    	var url = '<%=request.getContextPath()%>/cms/delTempTemplate.do?id='+id;
			window.location.href=url;
		}

		   function upload(){
			   //alert("qfdsa");
			    var f = new ActiveXObject("MSComDlg.CommonDialog");    
			    alert(f.fileName);
			        f.Filter = "*.*";
			        f.FilterIndex = 2;
			        f.MaxFileSize = 300;//文件大小
			        f.ShowSave();
			        alert(f.fileName) //文件路径与名称
			}
		   function fn_browse(id) 
			{ 
				 $.ajax({
					  type: "POST",
					  url: "cms/addFileTemplate.do",
					  data:{
                      "id":id
					  },
					  success: function(data){
					       alert(data);
					  }
					 });			 
			} 
			function currentHTML(id) 
			{  
				 $.ajax({
					  type: "POST",
					  url: "<%=basePath%>cms/currentHTMLTemplate.do",
					  data:{
                     "id":id
					  },
					  success: function(data){
					       //alert(data+"访问路径:调用方法+模板路径+文件名.html");
					       if(data == "0"){
					       	alert("生成成功");
					       }else{
					       	alert("网络错误!");
					       }
					  }
					 });			 
			}
		   
		/**
* 生成静态页面
*/
function tohtml(key,tid){
	    alert(tid);
	    if(tid == null || tid == ""){
	    	alert("id标识为空");
	    	return false;
	    }
		//alert(contents);
		//return false;
		var tt = (new Date()).getTime();
		var url = "/tpltohtml.do?tt="+tt;
		$.post(url,{
		id:tid,
		key:key
	}, function(data) {
		if ($.trim(data) == "0") {
		    alert("生成成功");
		    return true;
		} else if($.trim(data == "1")){
			alert("生成失败！");
			return false;
		}else {
			alert("网络问题，请稍候再试！");
			return false;
		}
	});
	return true;
} 
	</script>

  </head>

  <body>
<div id="weizhi">
 <div id="weizhiwz">当前位置&nbsp;>>&nbsp;
 <a href="/sys_admin/adminshow.jsp?type=list">模板管理</a>→模板列表
 </div>
</div>
 
<div class="conSet">
<input type="hidden" name="basepath" id="basepath" value="${basepath }">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="space tableBg">
<tr>
<td align="center" nowrap style="width:100px" class="bg1" >ID</td>
<td align="left" nowrap style="width:100px" class="bg1">模板名</td>
<td align="left" nowrap style="width:100px" class="bg1">类别</td>
<td align="left" nowrap style="width:150px" class="bg1">风格</td>
<td align="left" nowrap style="width:150px" class="bg1">模板路径</td>
<td align="left" nowrap style="width:150px" class="bg1">文件名</td>
<td align="right" nowrap style="width:150px" class="bg1">操作<a href="<%=request.getContextPath() %>/cms/addTemplate.do" >添加模板</a>
&nbsp;&nbsp;<a href="javascript:void(0);" onclick="buildFatherClass()" style="color:blue;" title="批量生成会慢些，请稍等！">校正父类</a>
</td>
</tr>


    <c:forEach items="${templist}" var="temp">
     <tr>
       <td align="center" nowrap style="width:100px" class="bg1" >${temp.id }</td>
       <td align="left" nowrap style="width:100px" class="bg1" >${temp.name }</td>
       <td align="left" nowrap style="width:100px" class="bg1" >${temp.classes.classname }</td>
       <td align="left" nowrap style="width:100px" class="bg1" >${temp.temp }</td>
       <td align="left" nowrap style="width:100px" class="bg1" >${temp.fdir }</td>
       <td align="left" nowrap style="width:100px" class="bg1" >${temp.fname }</td>
       <td align="right" nowrap  class="bg0">
		<a href="<%=request.getContextPath() %>/cms/updateTemplate.do?tid=${temp.id}">修改</a>&nbsp;|&nbsp;
		<a href="javascript:del(${temp.id })" onclick="return confirm('确定删除模板页，${temp.name}')" title="删除">删除</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="fn_browse(${temp.id })" >写入文件</a>
		&nbsp;&nbsp;<a href="javascript:void(0)" onclick="currentHTML(${temp.id})">生成静态页</a>
		</td>
	  </tr> 
    </c:forEach>

</table>
</div>

</body>
</html>
  
  
