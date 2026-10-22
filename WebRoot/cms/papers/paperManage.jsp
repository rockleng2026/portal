<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath2 = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- 
            页面名称：文章管理
	 创建 人：陈星
	 创建时间：2012-08-21
 -->
<html>
	<head>
		<base href="<%=basePath2%>">
		<title>文章管理</title>
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
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=path%>/cms/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path%>/cms/js/paperManage.js"></script>
		<script type="text/javascript" src="<%=path%>/cms/js/jquery.checkform.js"></script>
<style>
<!--
#dialog-modal{
	width:728px;
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
	<body bgcolor="#eeeeee">
		<div id="weizhi">
			<div id="weizhiwz">
				当前位置&nbsp;>>&nbsp;内容部&nbsp;>>&nbsp;文章管理
				<input type="hidden" name="basepath" id="basepath" value="<%=path %>">
			</div>
		</div>
		<div class="conSet">
			<form id="form1" name="form1" action="<%=request.getContextPath() %>/cms/selectNews.do" method="post">
				<table width="100%" border="0" align="center" cellpadding="3"
					cellspacing="1" class="bg1">
					<tr>
						<td align="left">
							<span> &nbsp;&nbsp;关键字 &nbsp; 
							    <input type="text" id="key" name="news.keyboard" />&nbsp;&nbsp;

							</span>
							<span> 是否显示 &nbsp;&nbsp; <input type="radio" id="showflag"

									name="news.showflag" value="0" checked />&nbsp;显示 <input
									type="radio" id="showflag" name="news.showflag" value="1" />&nbsp;不显示

							</span>
							<span style="padding-left: 20px;"> 审核状态 &nbsp;&nbsp; <select
									name="news.status" id="status">
									<option value="100" selected>
									  请选择
									</option>
									<option value="0">
										未审核
									</option>
									<option value="1">
										审核成功
									</option>
									<option value="2">
										审核失败
									</option>
								</select> </span>
							<span style="padding-left: 20px;"> 选择信息类别 &nbsp;&nbsp; <select
									name="news.classes.classname" id="typeid" style="width:100px;">
									<option value='100'>
										ALL
									</option>
								</select> </span>
							<span style="padding-left: 60px; padding-right: 20px;"> <input
									type="button" class="save_but" onclick="subt()" value="筛 选"> </span>
							<span style="padding-right:20px;">
    							<input type="button"  class="save_but"  onclick="showModel()" value="推荐" ></span>
							
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="conSet">
			<div
				style="background: #e2f4cd; height: 30px; border-top: #fff solid 1px; padding-top: 5px">
				<span> </span>
				<span style="padding-left: 10px;">
				<span>
			
			</span>
			<span style="padding-left:10px;">
		    </span>
							
			</span>
			</div>
			</div>
			<div style="width: 100%; height: 80%;">
				<table id="tabs" align="left">
			</table>
			</div>
			
<!-- 推荐弹出层 -->
<div id="recpartselect" style="display: none;">
 
  <c:forEach items="${recpartlist}" var="rec">
  <option value='${rec.pid }'>
  	<c:if test="${rec.mid == 1}">首页</c:if>
  	<c:if test="${rec.mid == 2}">栏目页</c:if>
  	<c:if test="${rec.mid == 3}">内容页</c:if>
  	<c:if test="${rec.mid == 4}">最新页</c:if>
  	<c:if test="${rec.mid == 5}">其它页</c:if>
  -${rec.part_name }</option>
  </c:forEach>	
 
</div>
<div id="dialog-modal" title="Basic modal dialog" style="display: none;">
	<div class="dialog-modal-close"><img src="/imgs/close.gif" onclick="$('#dialog-modal').css('display','none');" /></div>
	<div class="dialog-modal-title"><h3>标题</h3><h3>位置</h3><h3 style="width: 80px;">序号</h3><h3 style="width: 100px;">本地图片</h3></div>
	<form action="cms/commitPartsRec_part.do" method="post" id="recform">
	<input type="hidden" id="recNum" name="recNum" value="0" />
	<div class="dialog-modal-main" >		
	 </div>
	 <div class="dialog-modal-but"><input type="submit" onclick="return result()" value="推荐" /></div>
	 </form>
	  <script type="text/javascript">
	  var pjpath = "<%=path %>";
	  	function result(){
	  		
	  		var num = $("#recNum").val();
	  		//alert(num);
	  		var repx = /^[1-9]\d{0,1}$/;
	  		var recImgSrcs = $("input[name^=recImgSrc]");
	  		//alert(recImgSrcs.length);
	  		for(var i =0;i<recImgSrcs.length;i++){
	  			//alert(recImgSrcs[i]);
	  			var pname = $("#recPart"+i).find("option:selected").text();
	  			//alert(pname);
	  			$("#info_pname"+i).val(pname);
	  			var seq = $("#info_seq"+i).val();
				if(seq == ""){
				   	alert("序号不能为空");
				   	return false;
				 }else if(seq != "0"){
				   //alert(repx.test(seq));
				   if(!repx.test(seq)){
						alert('序号只能输入0-99的数字！');
						return false;
					}
			      }
			    
			    var rec = $(recImgSrcs[i]);
	  			var val = rec.val();
	  			//alert("val:"+val);
	  			var id = rec.attr("id").substring(9);
	  			if(val == null || "" == $.trim(val)){
	  				$("#isImg"+i).val(1);
	  				//alert($("#isImg"+i).val());
	  				//如果要必须传图片的话 请去掉下面2行注释
	  				//alert("还有未上传的图片!");
	  				//return false;
	  				//alert("影片：<< "+$("#L"+id).text()+" >>\n还有的没有上传图片！");
	  				//return false;
	  			}
	  		}
	  		
	  		$("body").append("<div style='position: absolute;top: 30%;left: 40%;" +
	  		"z-index: 1000;background-color: rgb(197,257,252);width:60px;' >提交中...</div>");
	  		return true;
	  	}
	 	function showModel() {
			var pms = "";
			var pmt = "";
			var sels=$('#tabs').datagrid('getSelections');
				$.each(sels,function(){
				pms=pms+","+this.pid;
				pmt=pmt+"@leng@"+this.ptl;
				});
			//alert(pms);
			if($.trim(pms) == ""){
				alert("请先勾选你想要推荐的产品或文章!");
				return;
			}
			$("#dialog-modal").css("display","block");
			$("#fileupload").val(" ");
			//writeContent($("input[checked=true]"));
			//var checkList = $("input[id='ck']");
			var checkList = pms.split(",");
			//alert("checkList:"+checkList.length);
			var vidlist = "";
			for(var i = 0;i<checkList.length-1;i++){
				if($(checkList[i]).attr("checked")){
					vidlist += ","+$(checkList[i]).val();
					//alert(vidlist);
				}
			}
			//alert(vidlist);
			writeContent(pms.substring(1),pmt.substring(6));
			
		}
	 
	 	var selectHtml = $("#recpartselect").html();
	 	//alert(selectHtml);
	 	function writeContent(checkList,titleList){
	 		var vids  = checkList.split(",");
	 		var vtitles  = titleList.split("@leng@");
	 		$("#recNum").val(vids.length);
	 		var htmlText = "";
	 		for(var i = 0;i<vids.length;i++){
	 			var text = "<div class='dialog-modal-recItem'><input type='hidden' name='recVid"+i+"' value='"+vids[i]+"' />" +
	 			"<span>"+vtitles[i]+"</span>"+
				"<span ><select name='recPart"+i+"' id='recPart"+i+"'>"+selectHtml+"</select></span>"+
				"<span style='width:80px;'><input style='width:78px;' name='info_seq"+i+"' id='info_seq"+i+"' value='1'/></span>"+
				"<input type='hidden' name='pyname"+i+"' value='"+$("#pyname"+vids[i]).text()+"'>"+
				"<input type='hidden' id='isImg"+i+"' name='isImg"+i+"' value='0'>"+
				"<input type='hidden' id='info_pname"+i+"' name='info_pname"+i+"' value=''>"+
				"<span  style='width: 100px;'><input type='hidden' name='recImgSrc"+i+"' id='recImgSrc"+vids[i]+"' value='' />"+
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
	 	function uploadImage(){
	 		//alert("uploadFileJS");
	 		var file = $("#fileupload").val();//文件的路径
	 		//alert(file);
	 		if(file == null || file == ""){
	 			return;
	 		}
			//onchange="uploadFileJS()"
			$('#uploadFilename').val((new Date()).getTime()+$("#fileupload").val().substring($("#fileupload").val().lastIndexOf('.')));
			$("#recImgSrc"+remarkId).val($('#uploadFilename').val());
			//alert(11111);
			$(document)
			.ready(
					function() {
						var options = {
						    url : "cms/upload2cmsbg.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
							//alert(msg);
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									$("#tipDiv").html(data[0]);
									var pathi=pjpath;
									var va=pathi+data[1];//相对路径
								    //$("#showpath").append("<input type='hidden' height='100' width='100' value='<%=path%>/"+data[1]+"'/>");
									//$("#ico").attr("value",data[1])
									$("#recImgSrcText"+remarkId).text("上传成功");
									$("#recImgSrc"+remarkId).val(data[2]);
									$("#uploadDiv").css("display","none");
									
								} else {
									$("#recImgSrcText"+remarkId).text(msg);
								}
							}
						};
						//alert(options);
						$("#formadds").ajaxSubmit(options);
						
						return false;
					});
			
			
			
			//$('#uploadForm').submit();
			//file = $("#uploadFile").val();//文件的路径
			//if(file == null || file == ""){
				//$("#recImgSrcText"+remarkId).text("");
				//alert("文件上传失败！请重新上传！\n若多次上传失败，请更换浏览器上传图片！");
			//}else{
			//	$("#recImgSrcText"+remarkId).text("上传成功");
			//	
			//	$("#uploadDiv").css("display","none");
			//}
		}
	 </script>
</div> 
<div style="display: none;position: absolute;top: 30%;left: 40%;background-color: blue" id="uploadDiv" >
  <button onclick="$('#uploadDiv').css('display','none');">关闭</button>
		<form id="formadds" name="formadds" action=""  method="post" >
	 	<input name="fileupload" id="fileupload" type="file"  onchange="uploadImage()"/>
	 	<input name="filename" id="uploadFilename" style="display: none"  type="text" />
	 	<input type="reset" style="display: none" id="but_reset" />
	 </form>
	  <iframe src="about:blank" id="up_pic_iframe" name="up_pic_iframe" style="width: 0;height: 0;"></iframe>
	</div>
	</body>
</html>
