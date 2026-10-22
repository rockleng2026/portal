<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<%@ page language="java" import="org.apache.struts2.*" %>
<jsp:useBean id="smart" scope="page" class="com.jspsmart.upload.SmartUpload"></jsp:useBean>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：信息推荐
  	 创建 人：陈星
	 创建时间：2012-08-27
 -->
<html>
	<head>
		<base href="<%=basePath%>">

		<title>信息推荐</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style type="text/css">
		@import url("cms/css/admin.css");
		@import url("cms/css/part.css");
		</style>
		<style type="text/css">
		.nShow {
			display: none;
		}
		#outlian{
		   display:none;
		}
		</style>
  <link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
  <link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
  <script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
  <script type="text/javascript" src="./cms/js/informationOut.js"></script>
  <script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/js/uploadsAddRow.js"></script>
<style>
<!--
#dialog-modal{
	width:660px;
	margin: 0 auto;
	border: 1px solid blue;
	font-size:12px;
	font-family:Verdana;
	background:rgb(199,232,248);
	position: absolute;
	top: 20%;
	left: 25%;
}
#dialog-modal .dialog-modal-close{
	width: 100%;
	height: 20px;
}
#dialog-modal .dialog-modal-close img{
	float: right;
}
#dialog-modal .dialog-modal-main{
	clear: both;
	width: 100%;
}
#dialog-modal .dialog-modal-main .dialog-modal-recItem{
	float: left;
}
#dialog-modal .dialog-modal-main span,#dialog-modal .dialog-modal-title h3{
	width: 210px;
	float: left;
	margin-left: 1px;
	border: 1px solid blue; 
	height: 23px;
	margin-bottom: 1px;
	vertical-align: middle;
}
#dialog-modal .dialog-modal-title h3{
	text-align: center;
}
#dialog-modal .dialog-modal-main .dialog-modal-but{
	height: 23px;
	text-align: center;
	width: 100%;
	float: left;
}
-->
</style>
</head>
 <script type="text/javascript">
	function tuijian(){
	 $("#part").show();
		
	}
   
   //上传图片
   function uploadImage() {
	 var url = new Array();
	 var file=$("#filedata");
	 url = $("input:file");
	    for(var i=0; i<url.length; i++)
	 {
		 if(url[i].value==null || url[i].value=="" )
		 {
			 alert("上传文件的URL输入不完整");
			 return false;
		 }
	 }
	var uploadFile = $("input:file");
	for(var j =0;j<uploadFile.length;j++){
		if(!(uploadFile[j].value != null && uploadFile[j].value != "" )){
			alert("请选择图片上传！");
			return false;
		}
	    var suffix = uploadFile[j].value.substring(uploadFile[j].value.lastIndexOf(".")+1).toLowerCase();
		if(!(suffix == "jpg" || suffix == "gif" || suffix == "bmp" || suffix == "jpeg" || suffix == "png")){
			alert("上传只允许jpg gif bmp jpeg png格式文件，请选择正确的格式上传！");
			return false;
		}
	}
	 
	var dd = (new Date()).getTime();
	if(confirm("你确定要上传此图片吗?")){ 
		$(document)
 	 			.ready(
 	 					function() {
 	 						var options = {
 	 							url : "doUploadupload.do?dd="+dd,
 	 							type : "POST",
 							dataType : "script",
 							success : function(date) {
 								if(date == '1'){
 									$("#uploadstatus").html("<font color='green'>上传成功</font>");
									$("#uploadflag").val("1");
 								
 								}else if(date == '2'){
 								alert("文件格式错误");
 								}else if(date == '3'){
 							
 								alert("上传出错,上传文件的总大小不能超出9M，您上传的文件超出规定的大小")
 								}else{
 								alert("服务器问题导致上传失败。请稍后在试");
 								}
 							}
 						};
 						$("#form2").ajaxSubmit(options);
 						alert("上传完毕");
 						return false;
 					});
     }
 }


   function a(){
      var files= $("#file").val();
      if(files==null||files==''){
         alert("上传文件不能为空!");
         return false;
      }
      $("#files").val(files);
      
   }

 </script>
 
<body>
<div id="weizhi">
<div id="weizhiwz">当前位置&nbsp;>>&nbsp;内容部&nbsp;>>&nbsp;文章推荐</div>
</div>
 
 <div class="conSet" >
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1"  class="bg1">
	<tr>
   <td align="right" >
  <span >
   推荐位置 &nbsp;&nbsp;
    <select name="info.info_pid" id="info_pid" >
      <option value='100'>ALL</option>
    </select>
   </span>
    <span style="padding-left:20px;padding-right:20px;">
    <input type="button" class="save_but" onclick="subt()" value="筛 选" >
    </span>
          
          
           <!-- 点击推荐  弹出层 -->    

<div id="part" style="display: none;">
<form id="" name="" action="cms/commitPartRec_part.do" method="post" onsubmit="return a()">
<table border="0" cellpaing="1" cellspacing="1"  class="space tableBg">
<tr>
 <td class="bg1" style=" width:120px; height:30px; text-indent:15px;">标题</td>
 <td class="bg1" style=" width:200px; height:30px;">
  <input type="hidden" id="cid" name="news.cid" value="${news.cid }"/>
 <splan>
 <input type="text" id="title" name="news.title" value="${news.title}" style="width:160px; height:20px;" />
 <input type="hidden" value="" id="files" name="fileName">
 </splan>
 </td>
</tr>
<tr>
 <td class="bg1"  style=" width:120px; height:30px;text-indent:15px;">位置</td>
 <td class="bg1"  style=" width:200px; height:30px;">
   <select name="rec_part.part_desc" id="desc_name" style="width:160px; height:25px;" >
       
   </select>
 </td>
</tr>
<tr>
  <td class="bg1" colspan="2"  style=" width:120px; height:30px;text-indent:15px;">&nbsp;</td>
</tr>

<tr>
 <td class="bg1" style="width:120px; height:30px;">
 <input type="submit" style="width:70px; height:25px; background:url(cms/images/button02.png); background-repeat:no-repeat; border:0px; color:#FFF; cursor:pointer;" value="推荐" />
 </td>
 <td class="bg1" style="width:200px; height:30px;">
 <input type="button" style="width:70px; height:25px; background:url(cms/images/button02.png); background-repeat:no-repeat; border:0px; color:#FFF; cursor:pointer;" onclick="closeDIV()" value="退出" />
 </td>
</tr>
</table>
</form>
</div>
<div style="display: none;">
<form action="" id="form2" name="form2" enctype="multipart/form-data">
<table id="diva" style="display: none;position: relative;bottom: 65px;" align="right">
  <!-- 上传文件 -->
 <tr>
 <td>
   <input type="file" name="filedata" id="file" style="height: 23px;width: 220px; background-color: #e2f4cd;border: 1px solid #ccc;" />
   <!--  <span id="uploadstatus" ></span>  -->
   <input type="button" onclick="uploadImage()" style="width:100px; height:25px; background:url(cms/images/button03.png); background-repeat:no-repeat; border:0px; color:#FFF; cursor:pointer;" value="上传图片" >
 </td>
</tr>


</table>
</form>
</div>
   </td>
   </tr>
   </table>

 </div>
 

 
<div style="width:100%; height: 80%; margin:0 auto;">
  <table id="dd">
  </table>
</div> 

<div id="dialog-modal" title="Basic modal dialog" style="display: none;">
	<div class="dialog-modal-close"><img src="/imgs/close.gif" onclick="$('#dialog-modal').css('display','none');" /></div>
	<div class="dialog-modal-title"><h3>标题</h3><h3>位置</h3><h3>本地图片</h3></div>
	<form action="/recAction.do?topid" method="post">
	<input type="hidden" id="recNum" name="recNum" value="0" />
	<div class="dialog-modal-main" >		
	 </div>
	 <div class="dialog-modal-but"><input type="submit" onclick="return result()" value="推荐" /></div>
	 </form>
	  <script type="text/javascript">
	  	function result(){
	  		var num = $("#recNum").val();
	  		var recImgSrcs = $("input[name^=recImgSrc]");
	  		for(var i =0;i<recImgSrcs.length;i++){
	  			var rec = $(recImgSrcs[i]);
	  			var val = rec.val();
	  			var id = rec.attr("id").substring(9);
	  			if(val == null || "" == val){
	  				$("#isImg"+i).val(1);
	  				alert($("#isImg"+i).val());
	  				//alert("影片：<< "+$("#L"+id).text()+" >>\n还有的没有上传图片！");
	  				//return false;
	  			}
	  		}
	  		$("body").append("<div style='position: absolute;top: 30%;left: 40%;" +
	  		"z-index: 1000;background-color: rgb(197,257,252);width:60px;' >提交中...</div>");
	  		return true;
	  	}
	 	function showModel() {
			$("#dialog-modal").css("display","block");
			$("#uploadFile").val(" ");
			//writeContent($("input[checked=true]"));
			var checkList = $("input[name='vid']");
			var vidlist = "";
			for(var i = 0;i<checkList.length;i++){
				if($(checkList[i]).attr("checked")){
					vidlist += ","+$(checkList[i]).val();
					//alert(vidlist);
				}
			}			
			writeContent(vidlist.substring(1));
		}
	 
	 	var selectHtml = $("#recpartselect").html();
	 	function writeContent(checkList){
	 		var vids  = checkList.split(",");
	 		$("#recNum").val(vids.length);
	 		var htmlText = "";
	 		for(var i = 0;i<vids.length;i++){
	 			var text = "<div class='dialog-modal-recItem'><input type='hidden' name='recVid"+i+"' value='"+vids[i]+"' />" +
	 			"<span>"+$("#L"+vids[i]).text()+"</span>"+
				"<span><select name='recPart"+i+"'>"+selectHtml+"</select></span>"+
				"<input type='hidden' name='pyname"+i+"' value='"+$("#pyname"+vids[i]).text()+"'>"+
				"<input type='hidden' id='isImg"+i+"' name='isImg"+i+"' value='0'>"+
				"<span><input type='hidden' name='recImgSrc"+i+"' id='recImgSrc"+vids[i]+"' value='' />"+
				"<button onclick='showUploadDiv("+vids[i]+")' title='点击上传图片' style='color:blue;cursor:pointer;'>上传图片</button>" +
				"<code id='recImgSrcText"+vids[i]+"' style='color:red;'></code></span></div>";
				htmlText += text;
	 		}
	 		$(".dialog-modal-main").html(htmlText);
	 	}
	 	var remarkId = 0;
	 	function showUploadDiv(vid){
	 		remarkId = vid;
	 		$("#uploadDiv").css("display","block");
	 		$("#but_reset").click();
	 	}
	 	function uploadFileJS(){
	 		var file = $("#uploadFile").val();//文件的路径
	 		if(file == null || file == ""){
	 			return;
	 		}
			//onchange="uploadFileJS()"
			$('#uploadFilename').val((new Date()).getTime()+$("#uploadFile").val().substring($("#uploadFile").val().lastIndexOf('.')));
			$("#recImgSrc"+remarkId).val($('#uploadFilename').val());
			
			$('#uploadForm').submit();
			file = $("#uploadFile").val();//文件的路径
			if(file == null || file == ""){
				$("#recImgSrcText"+remarkId).text("");
				alert("文件上传失败！请重新上传！\n若多次上传失败，请更换浏览器上传图片！");
			}else{
				$("#recImgSrcText"+remarkId).text("上传成功");
				
				$("#uploadDiv").css("display","none");
			}
		}
	 </script>
</div> 
<div id="recpartselect" style="display: none;">
 
  <c:forEach items="${recpartlist}" var="rec">
  <option value='${rec.pid }'>${rec.part_name }</option>
  </c:forEach>	
 
</div>
  
</body>
</html>
  