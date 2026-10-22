<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.divUploadMain { margin:0px; padding:0px; font-size:12px;}
.divUploadMain_Hx{ width:725px; height:auto; border:1px #BCBCBC solid; height:35px;}
.divUploadMain_Xh{ float:left;  border-left:1px #BCBCBC solid;  height:35px; line-height:30px; width:100px; padding-left:5px;}
.divUploadBut{ width:723px; height:35px; border-left:1px #BCBCBC solid; border-right:1px #BCBCBC solid; border-bottom:1px #BCBCBC solid; text-align:right; padding-right:5px; line-height:30px; }
.divUploadDelzj{ float:right; padding-right:5px; height:35px; text-align:right; line-height:30px; margin-right:10px;}
.divLb{ float:right; width:auto; height:35px; margin-right:5px; }
</style>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/js/uploadsAddRow.js"></script>
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
	  $('.sel1').attr("id","");
	 $('.sel2').attr("id","form3");

	
	
	 var url = new Array();
	 var zjmc = new Array();
	 url = $("#filelj0");
	 zjmc = document.getElementsByName("sczjmc");
	 //$("input[name='sczjmc']");
   for (var i = 0; i < zjmc.length; i ++) {
      var f = zjmc[i].value;

      var j = i+1;

      for(j; j< zjmc.length;j++){
      var s = zjmc[j].value;

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
	var uploadFile = $("#filelj0");
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
	$("#filelj01").attr("name","");
    $("#filelj0").attr("name","filedata");
	
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
 									$("#uploadstatus1").html("<font color='green'>上传成功</font>");
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

 						$("#form3").ajaxSubmit(options);
 						return false;
 					});
 	}
 }
var uploadcount= 1;//上传级数   
var uploadsum=3;//上传限制
 function addUploadRow11(){
	if(uploadcount < uploadsum){
		var uploadht = "<div class='divUploadMain_Hx'  id='uploadrow"+uploadcount+"' style='border-top:0px;'>"+
	"<div class='divUploadMain_Xh' style='border-left:0px;width: 80px;'>"+
		(uploadcount+1)+
	"</div>"+
	"<div class='divUploadMain_Xh' style='width:180px;'>"+
		"<select id='zjmc' name='sczjmc'>"+
			"<option value='公告1'>公告1</option>"+
			"<option value='公告2'>公告2</option>"+
			"<option value='公告3'>公告3</option>"+
			"<option value='公告4'>公告4</option>"+
			"<option value='公告5'>公告5</option>"+
		"</select>"+
	"</div>"+
	"<div class='divUploadMain_Xh' style='width:378px; '>"+
		"<input type='file' id='filelj"+uploadcount+"' name='filedata' style='width:400px;' />"+
	"</div>"+
	"</div>";

		 $("#doupload").before(uploadht);
	//	document.getElementById("itemCount").value=count; 
		uploadcount++;
	}else{
		alert("只允许添加"+uploadsum+"行");
	}
}
function delUploadRow11(){
 	var nowuploadrow = uploadcount-1;
    if( nowuploadrow <= 0){
    	alert("至少有一行");
    	return false;
    }
 	$('#uploadrow'+nowuploadrow).remove();
 	uploadcount--;
 }
</script>
 
<div class="divUploadMain" >
	<div id="upload" style="display:block">  
    <form id="form3" name="form3" class="sel2"   method="post" enctype="multipart/form-data">
        <div class="divUploadMain_Hx" >
            <div class="divUploadMain_Xh" style="border-left:0px;width:80px;">
                序号
            </div>
            <div class="divUploadMain_Xh" style="width:180px;">
                名称
            </div>
            <div class="divUploadMain_Xh" style="width:378px;">
                上传路径
            </div>
        </div>
        <div class="divUploadMain_Hx" id="uploadrow0" style="border-top:0px;">
            <div class="divUploadMain_Xh" style="border-left:0px;width:80px;">
                1
            </div>
            <div class="divUploadMain_Xh" style="width:180px;">
                <select id="zjmc" name="sczjmc">
                    <option value="公告1">公告1</option>
                    <option value='公告2'>公告2</option>
                    <option value='公告3'>公告3</option>
                    <option value='公告4'>公告4</option>
                    <option value='公告5'>公告5</option>
                </select>
            </div>
            
            <div class="divUploadMain_Xh" style="width:378px; ">
                <input type="file" id="filelj0" name="filedata" style="width:400px;" />
            </div>
        </div>
        
        <c:if test="${zdfj == null || fjlb == ''}"> 
        <div class="divUploadBut" id="doupload">
            <span id="uploadstatus" ></span>
                <input type="button" name="scbutton0" class="gengai" onclick="uploadImage()" value="上传"  />
                <input name="add2" onclick="addUploadRow11()" class="gengai"  type="button" value="增加"   />
                <input name="del2" type="button"  class="gengai" onclick="delUploadRow11()" value="减少" />
                <input name="del2" type="button" class="fangqisc" onclick="hidescfj()" value="放弃上传"  />
                <span id="uploadstatus1" ></span>
        </div>
        </c:if>
    </form>
    </div>
	<c:if test="${detailfj != null}"> 
		<div style="text-align:center; color: blue;">
			暂无附件
		</div>
	</c:if>
	<c:if test="${detailfj == null || detailfj == ''}"> 
    <div class="divUploadBut" id="scfj" style="display:none; border-top:1px #6CF solid; ">
    	<div class="divUploadDelzj" id="delzj">
    		<c:if test="${zdfj == null || fjlb == ''}"> 
        	<div class="divLb" style="width:80px; margin-left: 5px;">
            	<input<c:if test="${fjlb == null || fjlb == ''}"> disabled="disabled"</c:if> name="del" onclick="delfjlb()"  type="button" value="删除附件" style="width:60px; height:25px; margin-right: 5px;"  />
            </div>
        	<div class="divLb" style="width:60px; ">
            	<input name="add2" onclick="uploadaffix()"  type="button" value="上传附件" style="width:60px; height:25px;"  />
            </div>
            </c:if>
    		<c:forEach items="${fjlb}" var="item" varStatus="status">
        	<div class="divLb" id="showform${status}" >
        		<c:if test="${zdfj == null || fjlb == ''}"> 
            	<input  name="zjids" class="input1" type="checkbox" value="${item.id },${item.attachmentPath}"/>
            	</c:if>
				<a id="test" href="javascript:void(0);" onclick="openLayer('test','test_con','<%=path%>${item.attachmentPath}')">${item.attachmentName}</a>&nbsp;&nbsp;
            </div>
            </c:forEach>
        </div>
    </div>
    </c:if>
</div>
		
		<div id="test_con" style="display:none">
<div id="tab" style="padding:8px;">
<div id="tabtop">
<div align="right" id="tabtop-R" ><a  href="javascript:void(0);" onclick="closeLayer()">关闭</a></div>
<div id="tabtop-L"><strong>附件图片</strong></div>
</div>
<div id="tabcontent" >
	<img id="img" src="" style ="width: 500px;height: 320px"/>
</div>
</div>
</div>
