<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<LINK href="<%=request.getContextPath() %>/Css/jquery-ui-1.8.2.custom.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.position.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ui.dialog.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#dialog-modal{
	display:none;
	text-align: center;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	padding: 0px;
	background-image: url(../images/bg.jpg);
	background-repeat: no-repeat;
	background-position: center bottom;
}
#dialog-modal input{
	vertical-align: middle;
}
#dialog-modal cite {
	font-weight: normal;
	color: #999;
	font-style: normal;
}
#dialog-modal form,#dialog-modal dt,#dialog-modal dd,#dialog-modal dl,#dialog-modal h1,#dialog-modal h2,#dialog-modal h3,#dialog-modal h4,#dialog-modal h5,#dialog-modal p {
	margin: 0px;
	padding: 0px;
}
#dialog-modal .input-set {
	margin: 0px;
	padding: 0px;
	border: 1px solid ;
	line-height: 19px;
	height: 19px;
}
#dialog-modal .textarea-set {
	border: 1px solid #ccc;
	overflow: auto;
	padding: 2px 1px;
}
</style>
<script type="text/javascript">
	function submitdescrib(){
		var id = $("#meid").val();
		//var describe = $("#describe").val();
		var status = $("#mestatus").val();
		
		var oEditor = FCKeditorAPI.GetInstance("describe"); 
    	var describe = oEditor.GetXHTML();
		if(describe == null || describe == ''){
			alert("请填写描述信息!");
			$("#describe").focus();
			return false;
		}
		//var url = "completemission.do";
		//describe = encodeURI(encodeURI(describe));
		//$.post(url,{id:id,status:status,describe:describe},
		//function(data){
		//	if(data == 0){
		//		alert("提交成功");
		//		window.location.href="getmyreceivemission.do";
		//	}else if(data == 1){
		//		alert("提交错误,请联系管理员!");
		//		return false;
		//	}else{
		//		alert("网络错误");
		//		return false;
			//}
		//});
		$("#applyInfoForm").submit();
	}
</script>
<div id="dialog-modal" title="提交完成任务信息反馈">
 <form action="<%=request.getContextPath() %>/completemission.do" method="post" id="applyInfoForm">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
  	<td align="center" valign="top">反馈描述：</td>
  </tr>
  <tr>
  <input type="hidden" name="meid" id="meid" />
  <input type="hidden" name="mestatus" id="mestatus" />
  <td align="center" >
	  <FCK:editor width="800px;" inputName="describe" instanceName="describe" height="300px;">
		  <jsp:attribute name="value" ></jsp:attribute>
	  </FCK:editor> 
  <!--<textarea id ="describe" name="describe" rows="8" class="textarea-set" style="width:830px;"></textarea>-->
  </td>
  </tr>
  <tr>
 	<td colspan="1">
 	</td> 
  </tr>
  <tr>
   <td align="center" height="28"><input type="button"  value="提  交"  class="submit-set" onclick="submitdescrib()"/></td>
  </tr>
</table>
</form>
<style>
.divUploadMain { margin:0px; padding:0px; font-size:12px;}
.divUploadMain_Hx{ width:836px; height:auto; border:1px #6CF solid; height:35px; }
.divUploadMain_Xh{ float:left;  border-left:1px #6CF solid;  height:35px; line-height:30px; width:100px; padding-left:5px;}
.divUploadBut{ width:840px; height:35px; text-align:right; padding-right:5px; line-height:30px;}
.divUploadDelzj{ float:right; padding-right:5px; height:35px; text-align:right; line-height:30px; margin-right:10px;}
.divLb{ float:right; width:auto; height:35px; margin-right:5px;}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery.form.js"></script>
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
//删除证件
function delfjlb()
{
var url="delfileupload.do";
var all=document.getElementsByName('zjids');
var id ="";
var j=0;
var bean = "CommonScfjb";
for(var i=0;i<all.length;i++)
{
	if(all[i].checked==true)
	{
		id+=all[i].value+",";
		j++;
	}
}
if(id == null || id == '' || id.length==0)
{
	alert("请选择要删除的证件！")
	return;
}
else if(confirm("你确定要将此证件删除吗?,删除后将不能恢复")== true)
{
	$.post(url,{id:id,bean:bean},
			function (data)
			{
				if(data==1){
					var allcheck=document.getElementsByName('zjids');
					
					for(var j=0;j<allcheck.length;j++)
					{
						if(allcheck[j].checked==true)
						{
							allcheck[j].parentNode.style.display="none";
							
						}
					}
					alert('删除成功！');
				}else if(data == 0)
				{
					alert("删除失败");
				}
				else {
					alert('出错了');
				}
			});
	
}

}
function uploadImage() {
	 var formid = $("#formid").val();//如果存在则上传成功后自动提交否则不错操作

     var url = new Array();
	 var zjmc = new Array();
	 url = $("input:file");
	 zjmc = document.getElementsByName("sczjmc");
	 //$("input[name='sczjmc']");
   for (var i = 0; i < zjmc.length; i ++) {
      var f = zjmc[i].value;
     // alert("f="+f);
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
		if(!(suffix == "zip"||suffix == "rar"||suffix == "jpg" || suffix == "gif" || suffix == "bmp" || suffix == "jpeg" || suffix == "png" || suffix == "doc" || suffix == "docx" || suffix == "xls" || suffix == "xlsx")){
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
									
									if(formid == 'undefind' || formid == null || formid == ''){
									}else{
										$("#"+formid).submit();
									}
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
		var uploadht = " "+
	"<div class='divUploadMain_Hx'  id='uploadrow"+uploadcount+"' style='border-top:0px;'>"+
	"<div class='divUploadMain_Xh' style='border-left:0px;'>"+
		(uploadcount+1)+
	"</div>"+
	"<div class='divUploadMain_Xh' style='width:160px;'>"+
	"<input type='text' id='zjmc' name='sczjmc' />"+	
	"</div>"+
	"<div class='divUploadMain_Xh' style='width:500px; '>"+
		"<input type='file' id='filelj"+uploadcount+"' name='filedata' style='width:400px; width:495px;' />"+
	"</div>"+
	"</div>";
		//alert(uploadht);
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

<div class="divUploadMain" >
	<div id="upload" style="display:none">
    <form id="form2" name="form2" method="post" enctype="multipart/form-data">
        <div class="divUploadMain_Hx">
            <div class="divUploadMain_Xh" style="border-left:0px;">
                序号
            </div>
            <div class="divUploadMain_Xh" style="width:160px;">
                名称
            </div>
            <div class="divUploadMain_Xh" style="width:500px;">
                上传路径
            </div>
        </div>
        <div class="divUploadMain_Hx" id="uploadrow0" style="border-top:0px;">
            <div class="divUploadMain_Xh" style="border-left:0px;">
                1
            </div>
            <div class="divUploadMain_Xh" style="width:160px;">
                <input type='text' id='zjmc' name='sczjmc' />
            </div>
            
            <div class="divUploadMain_Xh" style="width:500px; ">
                <input type="file" id="filelj0" name="filedata" style="width:400px; width:495px;" />
            </div>
        </div>
        
        <c:if test="${zdfj == null || fjlb == ''}"> 
        <div class="divUploadBut" id="doupload">
            <span id="uploadstatus" ></span>
            	
                <input type="button" name="scbutton0" onclick="uploadImage()" value="上传" style="width:60px; height:25px;" />
                <input name="add2" onclick="addUploadRow()"  type="button" value="增加" style="width:60px; height:25px;"  />
                <input name="del2" type="button"  onclick="delUploadRow()" value="减少" style="width:60px; height:25px;"  />
                <input name="del2" type="button"  onclick="surrenderupload()" value="放弃上传" style="width:80px; height:25px;"  />
        </div>
        </c:if>
    </form>
    </div>
	
    <div class="divUploadBut" id="scfj">
    	<div class="divUploadDelzj" id="delzj">
    		<c:if test="${zdfj == null || fjlb == ''}"> 
        	<div class="divLb" style="width:80px; margin-left: 5px;">
            	<input id="del" name="del" onclick="delfjlb()"  type="button" value="删除附件" <c:if test="${fjlb == null || fjlb == ''}"> disabled="disabled"</c:if>  style="width:60px; height:25px; margin-right: 5px;"  />
            </div>
        	<div class="divLb" style="width:60px;">
            	<input name="add2" onclick="uploadaffix()"  type="button" value="上传附件" style="width:60px; height:25px;"  />
            </div>
            </c:if>
    		<c:forEach items="${fjlb}" var="item" varStatus="status">
        	<div class="divLb" id="showform${status}" >
        		<c:if test="${zdfj == null || fjlb == ''}"> 
            	<input  name="zjids" class="input1" type="checkbox" value="${item.id },${item.fjlj}"/>
            	</c:if>
				<a id="test" href="<%=request.getContextPath() %>/${ item.fjlj}" target="_blank" >${item.fjmc}</a>&nbsp;&nbsp;
            </div>
            </c:forEach>
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
	function completemission(id,status)
	{
		$("#meid").val(id);
		$("#mestatus").val(status);
		$("#dialog-modal").dialog({modal: true,hide:'slide',heigth:600,width:850});
	}
</script>

