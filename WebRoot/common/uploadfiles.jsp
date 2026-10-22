<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="<%=request.getContextPath() %>/Css/uploadfiles.css" type=text/css rel=stylesheet />
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" >
//放弃上传
function surrenderupload()
{
$("#upload").css("display","none");
$("#scfj").css("display","");
$("#uploadflag").val("0");
}

function uploadaffix()
{
$("#upload").css("display","");
$("#scfj").css("display","none");
$("#uploadflag").val("2");
}

function uploadImage() {
	 var url = new Array();
	 var zjmc = new Array();
	 url = $("input:file");
	 zjmc = document.getElementsByName("sczjmc");
	 //$("input[name='sczjmc']");
   for (var i = 0; i < zjmc.length; i ++) {
      var f = zjmc[i].value;
      var j = i+1;
      //alert(zjmc.length)
      for(j; j< zjmc.length;j++){
      var s = zjmc[j].value;
        //alert("s="+s);
      	if( s == f ){
      		alert("上传附件填写的名称重复");
      		return false;
      	}
      }
   }
   for(var i=0; i<zjmc.length; i++)
	 {
		 if(zjmc[i].value==null ||zjmc[i].value=="" )
		 {
			 alert("上传文件的证件名称输入不完整");
			 return false;
		 }
	 }
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
		if(!(suffix == "jpg" || suffix == "gif" || suffix == "bmp" || suffix == "jpeg" || suffix == "png" || suffix == "doc" || suffix == "docx" || suffix == "xls" || suffix == "xlsx")){
			alert("上传只允许jpg gif bmp jpeg png doc docx xls xlsx格式文件，请选择正确的格式上传！");
			return false;
		}
	}
	var dd = (new Date()).getTime();
	if(confirm("你确定要上传证件?")){
 	 	$(document)
 	 			.ready(
 	 					function() {
 	 						var options = {
 	 							url : "doUploadupload.do?dd="+dd,
 	 							type : "POST",
 							dataType : "script",
 							success : function(date) {

 								if(date == '1')
 								{

 									$("#uploadstatus").html("<font color='green'>上传成功</font>");
									$("#uploadflag").val("1");
 								
 								}else if(date == '2')
 								{
 								alert("文件格式错误");
 								}else if(date == '3')
 								{
 								alert("上传出错,上传文件的总大小不能超出9M，您上传的文件超出规定的大小")
 								}else{
 								alert("服务器问题导致上传失败。请稍后在试");
 								}
 							}
 						};
 						$("#form2").ajaxSubmit(options);
 						return false;
 					});
 	}
 }
var uploadcount= 1;//上传级数   
var uploadsum=6;//上传限制
 function addUploadRow(){
	if(uploadcount < uploadsum){
		var uploadht = "<div class='biaodan_li1'  id='uploadrow"+uploadcount+"'>"+
			"<div class='biaodan_ul1'>"+
				"<div class='biaodan_lil1' style='width:100px' >"+(uploadcount+1)+"</div>"+
				"<div class='biaodan_lir1' style='width:200px'><select id='zjmc' name='sczjmc'>"+
				    "<option value='身份证'>身份证</option>"+
				    "<option value='毕业证'>毕业证</option>"+
				    "<option value='学士学位证'>学士学位证</option>"+
				    "<option value='个人照片(正装)'>个人照片(正装)</option>"+
				    "<option value='个人照片(全身)'>个人照片(全身)</option>"+
				    "<option value='笔试情况附件'>笔试情况附件</option>"+
			      "</select></div>"+
				"<div class='biaodan_lil2' style='width:655px'><input type='file' id='filelj"+uploadcount+"' name='filedata' style='width:300px; border:#000000 solid 1px; height:25px; line-height:25px;' />"+
			"</div>"+
		"</div>";
		 $("#doupload").before(uploadht);
	//	document.getElementById("itemCount").value=count;
		uploadcount++;
	}else{
		alert("只允许添加"+uploadsum+"行");
	}
}
function delUploadRow(){
 	var nowuploadrow = uploadcount-1;
    if( nowuploadrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#uploadrow'+nowuploadrow).remove();
 	uploadcount--;
 }
</script>
<div style="display:none" id="upload">

     <form id="form2" name="form2" method="post" enctype="multipart/form-data">
		<div class="biaodan_li1">
			<div class="biaodan_ul1">
				<div class="biaodan_lil1" style="width:100px">序号</div>
				<div class="biaodan_lir1" style="width:200px">名称</div>
				<div class="biaodan_lil2" style="width:655px">上传路径</div>
			</div>
		</div>
		<div class="biaodan_li1" id="uploadrow0">
			<div class="biaodan_ul1">
				<div class="biaodan_lil1" style="width:100px">1</div>
				<div class="biaodan_lir1" style="width:200px"><select id="zjmc" name="sczjmc">
				    <option value="身份证">身份证</option>
				    <option value='毕业证'>毕业证</option>
				    <option value='学士学位证'>学士学位证</option>
				    <option value='个人照片(正装)'>个人照片(正装)</option>
				    <option value='个人照片(全身)'>个人照片(全身)</option>
				    <option value='笔试情况附件'>笔试情况附件</option>
			      </select></div>
				<div class="biaodan_lil2" style="width:655px"><input type="file" id="filelj0" name="filedata" style="width:300px; border:#000000 solid 1px; height:25px; line-height:25px;" />
				</div>
			</div>
		</div>
		<div class="biaodan_li1" id="doupload">
			<div class="biaodan_ul1">
				<div class="biaodan_lil1" style="width:957px">
					<div style="float:right; margin-right:20px; display:inline">
					<span id="uploadstatus" ></span>
					<input type="button" name="scbutton0" onclick="uploadImage()" value="上传" style="width:60px; height:25px;" />
					<input name="add2" onclick="addUploadRow()"  type="button" value="增加" style="width:60px; height:25px;"  />
					<input name="del2" type="button"  onclick="delUploadRow()" value="减少" style="width:60px; height:25px;"  />
					<input name="del2" type="button"  onclick="surrenderupload()" value="放弃上传" style="width:60px; height:25px;"  />
					</div>
				</div>
			</div>
		</div>
		</form>
		</div>
		
		<div class="biaodan_li1" id="scfj">
			<div class="biaodan_ul1">
				<div class="biaodan_lil1" style="width:957px">
					<div id="delzj" style="float:right; margin-right:20px; display:inline">
					<table><tr>
					<c:forEach items="${fjlb}" var="item" varStatus="status">
					<td id="showform${status}"><input  name="zjids" class="input1" type="checkbox" value="${item.id },${item.fjlj}"/><a id="test" href="javascript:void(0);" onclick="openLayer('test','test_con','<%=path%>${item.fjlj}')">${item.fjmc}</a></td>
					</c:forEach>
					<td><input<c:if test="${fjlb == null || fjlb == ''}"> disabled="disabled"</c:if> name="del" onclick="delfjlb()"  type="button" value="删除附件" style="width:60px; height:25px;"  /></td>
					<td><input name="add2" onclick="uploadaffix()"  type="button" value="上传附件" style="width:60px; height:25px;"  /></td></tr></table>
					</div>
				</div>
			</div>
		</div>
		
		<div id="test_con" style="display:none">
<div id="tab" style="padding:8px;">
<div id="tabtop">
<div align="right" id="tabtop-R" ><a  href="javascript:void(0);" onclick="closeLayer()">关闭</a></div>
<div id="tabtop-L"><strong>附件图片</strong></div>
</div>
<div id="tabcontent"><img id="img" src=""/></div>
</div>
</div>
