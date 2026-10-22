<%@ page contentType="text/html; charset=UTF-8"%>
<%  
String path = request.getContextPath();
%>
<!-- 导入DWR根据配置文件dwr.xml生成的JS文件 -->
<script type="text/javascript">
//判断IE版本
function IeVesion() { 
var Sys = {}; 
var ua = navigator.userAgent.toLowerCase(); 
var s; 
(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] : 
(s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] : 
(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] : 
(s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] : 
(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0; 
var ieversion=7; 
if (Sys.ie){ 
	ieversion = parseInt(Sys.ie); 
}
return ieversion;
} 

function setdivwidth1(w){  
	setdivwidth(w);
}

function setdivwidth(w){
	//IE6判断 
	if ($.browser.msie){
		if($.browser.version=='6.0'){
			$("#youshuju").css("margin-bottom","12px");
		}
	}
	var leftwid = 0
	if(typeof(w) != "undefined"){
		leftwid = 0;
	}
	if (document.readyState == "complete") { 
		var offsetWid = 0; 
		if (window.innerHeight){
		    offsetWid = window.innerWidth;
		}
		else if ((document.body) && (document.body.clientHeight))
		{
		    offsetWid = document.body.clientWidth;
		}else{
			offsetWid = document.body.offsetWidth; 
		}
		
		if(offsetWid!='0'){	
		
			if(offsetWid<=650){//控制最小页面宽度
				offsetWid=650;
			}
			offsetWid=parseInt(offsetWid)+parseInt(leftwid);
			if(document.getElementById('pagerdiv')!=null){
				var pagertablewidth=document.getElementById('pagerdiv').offsetWidth+40;
				document.getElementById('pagerdiv').style.left=offsetWid-pagertablewidth;
			}
			
			document.getElementById('searchDiv').style.width='98%';
			//document.getElementById('searchDiv').style.width=offsetWid-14;
			document.getElementById('resulthight').style.width=offsetWid-13;   			
			
			var ieversion = IeVesion();
			if(ieversion<=6){
				var divheigth1 = document.getElementById('resulthight').offsetHeight;//scrollHeight
				//document.getElementById('youshuju').style.height=divheigth1;	//	设置table高度
				//document.getElementById('resulthight').style.height=divheigth1+45;	//	设置div高度
			}
			
		}else{
			window.setTimeout('setdivwidth()', '500');
		}
		
	}else{
		window.setTimeout('setdivwidth()', '500');
	} 
}




	//查询税费信息
	function jspcha(bool){
	var lenbutton=document.getElementsByName("cha").length;
		for(var a=0;a<lenbutton;a++){ 
			if(bool)document.getElementsByName("cha")[a].disabled="disabled";
			else  document.getElementsByName("cha")[a].disabled=false;
		}
	}

	//查询条件重置
	function resetjsp(){
	var objFile=document.getElementsByTagName('input');
      	for(var m=0;m<objFile.length;m++){
      		 if(objFile[m].type=='text'){
      			 objFile[m].value="";
      		 }

      		if(objFile[m].type=='password'){
     			 objFile[m].value="";
     		 }
      		 if(objFile[m].type=='radio'){
      			 objFile[m].checked=false;
      		}
      		 if(objFile[m].type=='checkbox'){
      			 objFile[m].checked=false;
      		 }
      	}
     	var selectFile=document.getElementsByTagName('select');
      	for(var m=0;m<selectFile.length;m++){
      		selectFile[m].value=selectFile[m].options[0].value;//"";
      	}
	}
	//设置iframe 高度
	function setParentIframeHeight(iframeid){
		if (document.readyState == "complete") {
			var parentiframe= parent.document.getElementById(iframeid);//sxkhiframe
			var height=document.getElementById("showdiv").offsetHeight+30; 
			parentiframe.style.height=height;
		}
	    else {
	        window.setTimeout("setParentIframeHeight("+iframeid+")", "200");
	    }
	}
	//查询效果
	function changeTable(bool,wushuju,youshuju){
		var ahref=document.getElementsByTagName("button");
		for(var a=0;a<ahref.length;a++){
			if(bool) ahref[a].disabled="disabled";
			else ahref[a].disabled="";
		}
		if(bool){ 
			//var height=document.getElementById("youshuju").clientHeight;
			//if(height=='0'){
			//	height='300';
			//}
			//document.getElementById(wushuju).style.height =height ;
			if(document.getElementById(wushuju)!=null)document.getElementById(wushuju).style.display="";
			if(document.getElementById(youshuju)!=null)document.getElementById(youshuju).style.display="none";
		}else{
			if(document.getElementById(wushuju)!=null)document.getElementById(wushuju).style.display="none";
			if(document.getElementById(youshuju)!=null)document.getElementById(youshuju).style.display="";
		}
	}
	
	function showProgress(bool){
		var ahref=document.getElementsByTagName("button");
		for(var a=0;a<ahref.length;a++){
			if(bool) ahref[a].disabled="disabled";
			else ahref[a].disabled="";
		}
		showProgressBar();
	}

	function buttonujsp(bool){
		var ahref=document.getElementsByTagName("button");
		for(var a=0;a<ahref.length;a++){
			if(bool) ahref[a].disabled="disabled";
			else ahref[a].disabled="";
		} 
	}
	
	//清空
	function refresh(){
		var v=document.forms[0].elements; 
		for(var i=0;i<v.length;i++){ 
			if(v[i].type=="text"){ 
				v[i].value="";
			} 
			if(v[i].type=="checkbox"){
				v[i].checked = false;
			}
		} 
		var oSelects = document.getElementsByTagName("select"); 
		for(var i=0;i<oSelects.length;i++){ 
			oSelects[i].selectedIndex = 0;
		}
	}

	//checkbox 单选择效果
	function checkone(obj,bool){
		if(bool){
			var objtext=document.getElementsByName(obj.name);
			for(var a=0;a<objtext.length;a++){
				objtext[a].checked="";
			}
			obj.checked="checked";
		}
	}
	//checkbox 单选择效果
	function radioone(obj){
		var objtext=document.getElementsByName(obj.name);
			for(var a=0;a<objtext.length;a++){
				objtext[a].checked="";
			}
		obj.checked="checked";
	}
   // 票号补全 
   function sph(obj){
	if(isNaN(obj.value)){
		obj.value="";
	 }else if(obj.value.length<8 && obj.value.length>0){
		  var str="000000000000000";
		 obj.value=str.substring(0,8-obj.value.length)+""+obj.value;
	 }
	}
   // 是数字 
   function isnum(obj){
	if(isNaN(obj.value)){
		obj.value="";
	 }
	}
  function replace(value){
	  value=value.replace(' ','');
	  if(value.indexOf(' ')>=0){
		  replace(value)
	   }else{ return value;
		}
	}
var tab_close=true;// onmouseout="divtabclose('zyz_dv')"   鼠标离开层，层关闭
var divsettime=null;// onmouseover="divtabshow('zyz_dv')"  鼠标在层上面，层显示
var oldpartid="";//旧的id
// DIV窗口显示
function divtabshow(partid){
	 tab_close=false;
	 document.getElementById(partid).style.visibility="visible";
	 if(divsettime!=null){ clearTimeout(divsettime);} //取消关闭
	 oldpartid=partid;
	 tab_close=true;
	 //partid=partid.replace("_dv","");
}

// DIV窗口关闭
function divtabclose(partid){//延时调用	
	if(oldpartid!=partid && oldpartid.length>0){
		 document.getElementById(oldpartid).style.visibility='hidden';
	}
	 if(tab_close){
		
		 divsettime=window.setTimeout("divtabclosetime('"+partid+"')", "300");
		 tab_close=false;
	 }
}
//DIV窗口关闭
function divtabclosetime(partid){	// alert(partid);
	 document.getElementById(partid).style.visibility='hidden';
	 partid=partid.replace("_dv","");
	 var boxobj= document.getElementsByName(partid) 
		var boxvalue="";
		for(var a=0;boxobj!=null && a<boxobj.length;a++){
			if(boxobj[a].checked){ 	boxvalue+="-"+boxobj[a].lang; }
		}
		if(boxvalue.length>2){
			document.getElementsByName(partid+"_show")[0].value=boxvalue.substring(1,boxvalue.length);
		}else{
			document.getElementsByName(partid+"_show")[0].value="--所有--";
		}
		tab_close=true;
}


// 税管员树  全选
function selallname(inputname,bool){
   	var boxobj= document.getElementsByName(inputname);
		for(var a=0;a<boxobj.length;a++){
			boxobj[a].checked=bool;
		}
  }	
function selnamedir(inputname,sameval,bool){
   	var boxobj= document.getElementsByName(inputname);
		for(var a=0;a<boxobj.length;a++){ 
			if(boxobj[a].id==sameval){
				boxobj[a].checked=bool;
			}			
		}
  }	
function selnamedisplay(inputname,sameval){
	var boxobj= document.getElementsByName(inputname);
	for(var a=0;a<boxobj.length;a++){ 
		if(boxobj[a].id==sameval){
			var trobj=document.getElementById(inputname+boxobj[a].value);
			if(trobj.style.display==""){
				trobj.style.display="none";
			}else{
				trobj.style.display="";
			}
		}			
	}
}





//指标考核条件  zyz 
function changeKHZB(obj,value){	
	var val=obj.value;
	if(val.length>0){
		var khlxType="";
		if(document.getElementById("khlxType")!=null){
			khlxType=document.getElementById("khlxType").value;
		}
		DwrKhzb.khzbDwr(value,khlxType,changeKHZBdata);
	}else{
		var str="<select name=\"C_ID\" ><option value=\"\">--所有--</option></select>";
		document.getElementById("KHZBID").innerHTML=str;
	}		
}
function changeKHZBdata(data){
	document.getElementById("KHZBID").innerHTML=data;
}




//指标考核条件 hbl
function changeYHDM(obj,value){
	var val=obj.value;
	if(val.length>0){
		DwrKhzb.Yhzl(value,changeYHDMdata);
	}else{
		var str="<select name=\"C_ID\" ><option value=\"\">--所有--</option></select>";
		document.getElementById("C_KHH_DM").innerHTML=str;
	}		
}
function changeYHDMdata(data){
	document.getElementById("C_KHH_DM").innerHTML=data;
}



function showspan(partid,bool){
	 document.getElementById(partid).style.visibility="hidden";
	 if(bool){
		 document.getElementById(partid).style.visibility="visible";
	 }
}
//考评分数js检查
function kpfsnum(obj,num){
	var test=/^[0-9]{1,}$/;
	if(isNaN(obj.value)){
		obj.value="";
	}
	if(parseInt(obj.value)>parseInt(num) || parseInt(obj.value)<-parseInt(num)){
	obj.value=num;
	}
}

</script> 
<style>
.heji{font-weight: bold;color: red;}
.span_class{ 
float:left;
overflow: no; 
position:absolute; 
width: 100px; 
z-index: 6; 
visibility: hidden; 
background-color:#fff; 
border: 1px solid #95CAFF;
padding: 3px;
white-space: nowrap;
margin: -2px 0 0 0;
font-size: 16px;
 }

.boldhand{float: left;font-weight: bold;cursor:pointer;} 
 <!-- 多选框CSS  样式 -->
 .selzyzdiv{ float:left;}
.selzyz_div{  
	float:left;
	overflow: auto; 
	position: absolute;  
	z-index: 1; 
	visibility: hidden; 
	 width:180px;
	 height:250px;
	 margin: -1px 0 0 0;
  }
 .checkboxdiv td{
  border-left: 1px solid #95CAFF;
  border-top: 1px solid #95CAFF;
 }
 .checkboxdiv{
 background-color:#F7F7F7;
  border-bottom: 1px solid #95CAFF;
  border-right: 1px solid #95CAFF;
 }
 
.select_div{
	position: absolute;
	padding:1px 2px;
	z-index:30;
 	background-color: #ffffff; 
  	border: 1px solid #b7d1eb; 
	display:none;
	margin: 0px 0 0 0px;
	width:170px;
	overflow: auto;
	
}

.nsrlsh_div{
	position: absolute;
	padding:1px 2px;
	z-index:30;
 	background-color: #ffffff; 
  	border: 1px solid #b7d1eb; 
	display:none;
	margin:0 0 0 -130px ;
	width:350px;
	height:285px;
	overflow-y:auto;
	overflow-x: auto;
	white-space: normal;
	
}
.classnr{   display: block;
            width: 200px;
            overflow: hidden;
            white-space: nowrap;
            -o-text-overflow: ellipsis;
            text-overflow: ellipsis; }
            
button{margin: 0 2px;}

#resulthight{
	width: 100%; 
	overflow-x: auto;
	overflow-y: hidden;
	padding: 0 0 20px 0;
	 
}

</style>