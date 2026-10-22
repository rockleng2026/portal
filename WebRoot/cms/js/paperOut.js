$(function (){  
	$("#typeid").click(function(){
		if(document.getElementById("typeid").options.length==1){
		 $.ajax({
			  type: "POST",
			  url: "cms/loadNews.do",
			  data:"",
			  success: function(data){
			    $('#typeid').append(data);
		       }
			 });
		}
	});
});

jQuery(function($){
    jQuery("input,select,textarea").addClass("warning-normal");
});
function checkform()
{
    var seq = $("#sequence").val();
    //var ss = $("#smalltext").val();
    //alert(111);
   // alert(ss);
    var oEditor = FCKeditorAPI.GetInstance("messagecontent");
	   var oEditor2 = FCKeditorAPI.GetInstance("messagesmalltext");
	   $('#contents').val(oEditor.GetXHTML(true));
	   $('#smalltext').val(oEditor2.GetXHTML(true));
    var seqflag = checkseq(seq);
    jQuery.checkForm({
        ctrls: [                                   
            {id: "title",type:"mustInput", par:"",msg: "标题不能为空"}, 
            {id: "ftitle",type:"mustInput", par:"6", msg: "副标题不能为空"},
            {id: "source",type:"mustInput", par:"12", msg: "文章来源不能为空"},   
            {id:"typeid",type:"mustSelect",par:"100",msg:"请选择所属栏目"},
            {id: "smalltext",type:"mustInput", par:"0", msg: "文章简介不能为空"}
            ],
        success: function(){ 
    	$('#titlemsg').html('');
    	$('#ftitlemsg').html('');
    	$('#sourcemsg').html('');
    	$('#contentmsg').html('');
    	$('#papermsg').html('');
        getvalues();                                      
        },
        failed: function(msg){  
            if(msg=="标题不能为空"){
            	$('#titlemsg').html(msg);
            }
            if(msg=="副标题不能为空"){
            	$('#ftitlemsg').html(msg);
            }
            if(msg=="文章来源不能为空"){
            	$('#sourcemsg').html(msg);
            }
            if(msg=="请选择所属栏目"){
            	$('#contentmsg').html(msg);
            }
            if(msg=="文章简介不能为空"){
            	$('#papermsg').html(msg);
            }
            if(seqflag == false){
            	$('#seqmsg').html('只能输入0-999的数字！');
            }
            }
        });
       function getvalues(){
    	   if($('#cid').val()>0){
    		  if($('#ulss').val()=="uls"){
    			  $('#form1').attr("action","cms/addOrUpdateNews.do?pams=paperCheck.jsp");
    		  }else{
    	          $('#form1').attr("action","cms/addOrUpdateNews.do?pams=up");
    		  }
    	   }else{
    		  $('#form1').attr("action","cms/addOrUpdateNews.do?pams=ad");
    	   }
    	  
    	   this.form1.submit();
       }

}
function getdou(vas){
	   var ps=new Array();
	   var mes="";
	   var pi=0;
	   var pattern=new RegExp("[,]"); 
	   if(pattern.test(vas)){
		   ps=vas.split(",");
		   if(ps.length<=6){
	 	   }else{
	 		  mes="关键字长度太长"; 
	 	   }
	   }else{
		   mes="关键字的分割符用逗号";
	   } 
       if(mes!=""){
		   $("#divmsg").html(mes);
	       $("#divmsg").show(); 
       }else{
    	   $("#divmsg").html("");
    	   $("#divmsg").hide(); 
       }
}

function checkseq(vas){
	   var mes="";
	   if(vas == ""){
	   	mes="序号不能为空";
	   }else if(vas != "0"){
	  // var str = /^999$|^([1,2,3]\d)$|^\d?$/;
	   var str = /^[1-9]\d{0,2}$/ ;
		if(!str.test(vas)){
				mes=('只能输入0-999的数字！');
		}
      }
		if(mes!=""){
		   $("#seqmsg").html(mes);
	       $("#seqmsg").show();
	       return false; 
       }else{
    	   $("#seqmsg").html("");
    	   $("#seqmsg").hide();
    	   return true; 
       }
}


//处理图片显示部分
function upfile() {
	alert("xxxx");
	var pic = $("#pic").val();
    alert(pic);
 	alert("result:"+checkFileName(pic));
	if (checkFName(pic)) {
		$("#inpic").css("display", "none");
		//document.getElementById("up_pic_form").submit();
		$("#up_pic_form").submit();
		$("#pic_loading").css("display", "");
	} else {
		$("#hintmsg").css("display", "");
		$("#hintmsg").html("上传文件仅支持jpg,jpeg,gif,png,bmp格式的图片");
	}
}
//验证图片是否符合格式条件
function checkFName(fileName) {
	alert("checkFName"+fileName);
	if (fileName != "") {
		str = fileName;
		strs = str.toLowerCase();
		lens = strs.length;
		var i = strs.lastIndexOf(".");
		extname = strs.substring(i + 1, lens);
		if ((extname != "jpg" && extname != "jpeg" && extname != "JPEG" && extname != "JPG")
				&& (extname != "gif" && extname != "GIF")
				&& (extname != "png" && extname != "PNG")
				&& (extname != "bmp" && extname != "bmp")) {
			//alert("上传文件仅支持jpg,jpeg,gif,png,bmp格式的图片");
			return false;
		} else {
			return true;
		}
	} else {
		return true;
	}
}
function selectChange() {
	alert("function --selectChange()");
	if ($("#imgflag").attr("checked")) {
		//alert("id="+document.getElementById("up_pic_form").action);
		$("#picform").css("display", "block");
		//$("#inpic").css("display","");
	} else {
		$("#picform").css("display", "none");
	}
}
//上传图片成功后调用的方法
function picCallback(val, showpic) {
	alert("success");
	$("#pic_loading").css("display", "none");
	$("#inpic").css("display", "none");
	$("#pic_show").attr("src", showpic);
	$("#pic_name").html(val);
	$("#titlepic").val(showpic);
	$("#publisher_perch").css("display", "");
	
}

function showpic() {
	$("#pic_showdiv").css("display", "");
}
function hidepic() {
	$("#pic_showdiv").css("display", "none");
}
//下面是处理添加图片的
function checkPic() {
	var fileName1 = document.getElementById("picname").value;
	var img = new Image();
	img.src = fileName1;

	if (fileName1 == "") {
		alert("请点击浏览按钮，选择您要上传的jpg、jpeg、png、gif、bmp格式的图片文件");
		document.getElementById("picname").focus();
		return false;
	} else {
		if (checkFileName(fileName1) == false) {
			document.getElementById("picname").select();
			return false;
		}
		//if(img.fileSize>10068000)
		//{
		// alert("照片的大小不能超过3M,谢谢合作！");
		// document.getElementById("picname").focus();
		//return false;
		//}

	}

	return true;
}
function checkFileName(fileName) {
	if (fileName != "") {
		str = fileName;
		strs = str.toLowerCase();
		lens = strs.length;
		var i = strs.lastIndexOf(".");
		extname = strs.substring(i + 1, lens);
		if ((extname != "jpg" && extname != "jpeg" && extname != "JPEG" && extname != "JPG")
				&& (extname != "gif" && extname != "GIF")
				&& (extname != "png" && extname != "PNG")
				&& (extname != "bmp" && extname != "bmp")) {
			alert("上传文件仅支持jpg,jpeg,gif,png,bmp格式的图片");
			return false;
		} else {
			return true;
		}
	} else {
		return true;
	}
}
//上传图片
function submitPic() {
	if (!checkPic()) {
		return;
	}
	document.getElementById("addpicForm").submit();
}
//将图片插入正文
function addpic(val){
	    var oEditor = parent.FCKeditorAPI.GetInstance("name_origin");
	    var ehtml=oEditor.GetXHTML(true);
    	oEditor.SetHTML(ehtml+val); 
	}
	function insertpic(val){
	    var oEditor = FCKeditorAPI.GetInstance("name_origin");
	    var ehtml=oEditor.GetXHTML(true);
    	oEditor.SetHTML(ehtml+val); 
	}
	//上传图片成功后调用的方法
function uploadCallback(showpic)
{
	//var str="<li><input style='width:450px;border:0px;background:#f9f9f9;' readonly='true' value="+showpic+" />" +
			//"<a onclick=\"addpic('<img  src="+showpic+" />')\" style=\"cursor:hand;\">插入正文</a></li>";
	//document.getElementById("piclist").innerHTML+=str;
	//alert("picpath:"+showpic);
	var str="<img  src="+showpic+" />";
	insertpic(str);
	
}
//图片信息推荐处理
function selectAllbox(id,allid){
  //var cidlist="";
  if($("#"+id).attr("checked")==true){
   $("input[name='"+allid+"']").each(function() {   
      this.checked = true; 
     // cidlist+=this.value+","; 
   });
  }else{
    $("input[name='"+allid+"']").each(function() {   
       this.checked = false;   
   });
  }
   //return cidlist;
}
//获取选中的信息cid
function getAllBoxVal(id){
 var cidlist="";
 $("[name='"+id+"']").each(function(){ 
 if(this.checked){
    cidlist+=$(this).val()+",";
 }
  });
 return cidlist;
}
//图片信息推荐实现
function ctpictohtml(id){
  var mark="ctpicth";
  var cidlist=getAllBoxVal(id);
  if(cidlist==""){
    alert('请选择推荐项');
    return false;
  }
  var position=$("#position").val();
  var codenum=$("#codenum").val();
  var typeid=$("#typeid").val();
  var url="/contentsToHtml.do";
	//定义缓存处理变量
	var nowDate = (new Date()).getTime();
	url +="?t="+nowDate;
	$.post(url,{
	mark:mark,
	typeid:typeid,
	cidlist:cidlist,
	codenum:codenum,
	position:position
	},function(data){
	   if($.trim(data)=="0")
	   {    alert("操作成功");
	        window.location.href="/ctpictohtml.do";
	   }else{
	        alert("网络问题，请稍候再试！");
	        return false;
	   }
	 });
	 return true;
}
/**
* add by lzy  2013-07-14 
*/
		
 function delectimg(id){
	  var img=$('#img'+id).val();
	  if(!img){
	    alert('您要删除的图片不存在,请先上传！');return;
	  }
	  $('#img'+id).attr('value',"");
	   $('#imga'+id).attr('src',"product_manage/img/noneimg.jpg"); 
	}
	
	//上传图片验证
	function checkimg(){
	    var img1= $('#img1').val();
	    var img2= $('#img2').val();
	    var img3= $('#img3').val();
	    var img4= $('#img4').val();
	    var img5= $('#img5').val();
	    var img6= $('#img6').val();
	    if(img1!='' || img2!='' || img3!='' || img4!='' || img5!=''|| img6!=''){
	    	$('#imgMsg').html('填写正确');
	        return true;
	     }else{
	        //alert(99999999999999);
	        $('#imgMsg').html('图片至少上传一张!'); 
	        return false;
	     }
	}