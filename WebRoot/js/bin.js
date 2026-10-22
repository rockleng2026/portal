// JavaScript Document

function remove(element) {
	element.parentNode.removeChild(element);
}

function modify(url){
	var sc_width=screen.availWidth;
    var sc_height=screen.availHeight;
    var top = (sc_height)/2;
    var left = (sc_width)/3;
    var url=url+"?"+Math.random();
  	var result =  window.showModalDialog(url,window, "resizable: yes; help: no; status: no; scroll: yes; dialogWidth:680px;dialogHeight:550px");
    if(result){
       	window.location = "#";
    }
}

var  maxhi=0;
//设置Iframe高度
function setIframeHeight(){
    if (document.readyState == "complete") {
        if (window.frameElement != null) {
            if(parent.document.all(window.frameElement.name)){
            var parentHeight = parent.document.all(window.frameElement.name);
            var iframeHeight = document.body.scrollHeight;          
            if(iframeHeight>0){
				if(parentHeight.title=="showResult"){
	                 parent.document.all(window.frameElement.name).style.height=iframeHeight+100;
	            }else{ 					 
					parent.document.all(window.frameElement.name).style.height =iframeHeight+100;	
				} 
				if(maxhi==0 || maxhi<iframeHeight){
					maxhi=iframeHeight;
					window.setTimeout('setIframeHeight()', '1000');
				}
			}else{
				window.setTimeout('setIframeHeight()', '1000');
			}
			if(parent&&(parent.setIframeHeight)){
        		parent.setIframeHeight();
        	}
			}
        }
    }else {
        window.setTimeout('setIframeHeight()', '1000');
    }
}
 

//设置页面div层高度
function setdivheight(){
	if (document.readyState == "complete") {
		var hight = document.getElementById('resulthight').scrollHeight;
		document.getElementById('resulthight').style.height=hight+20;
	}
}




function add(id,tableId){
	var tbody = document.getElementById(tableId); 
	var tr = document.createElement("tr");
	var tds = document.getElementById(id).childNodes;
	for(var c=0;c<tds.length;c++){
		var td = document.createElement("td");
		td.innerHTML =tds[c].innerHTML;
		tr.appendChild(td);
	}
	clearInputValue(tr);
	tbody.appendChild(tr);
}
		
/**
 * 删除行提示
 * @param {Object} blid
 * @param {Object} id
 */
function deltr(blid,id){
	var flag=0;
	var checkboxs = document.getElementById(id).getElementsByTagName("input");
	for(var c=0;c<checkboxs.length;c++){
		if(checkboxs[c].type=='checkbox'&&checkboxs[c].checked){
			flag=1;
		}
	}
	if(flag==0){
		alert('请勾选需要删除的行！');
	}else{
		deltr_(blid,id);
	}
}
/*
 * 删除选中的tr行，特殊用
 * @param {Object} blid
 * @param {Object} id
 */
function deltr_(blid,id){
	var checkboxs = document.getElementById(id).getElementsByTagName("input");
	for(var c=0;c<checkboxs.length;c++){
		if(checkboxs[c].type=='text'){
			checkboxs[c].value='';
		}
		if(checkboxs[c].type=='select'){
			checkboxs[c].value='';
		}
		if(checkboxs[c].type=='checkbox'&&checkboxs[c].checked){
			checkboxs[c].checked=false;
			if(checkboxs[c].parentNode.parentNode.id==blid){
				checkboxs[c].parentNode.parentNode.style.display='none';
			}else if(checkboxs[c].parentNode.parentNode.parentNode.childNodes.length>1&&checkboxs[c].parentNode.parentNode.id!=blid){
				checkboxs[c].parentNode.parentNode.parentNode.removeChild(checkboxs[c].parentNode.parentNode);
				deltr_(blid,id);
			}
		}
	}
} 

function clearInputValue(obj){
	var inputs = obj.getElementsByTagName("input");
	for(var c=0;c<inputs.length;c++){
		inputs[c].value = "";
	}
	var textareas = obj.getElementsByTagName("textarea");
	for(var c=0;c<textareas.length;c++){
		textareas[c].value = "";
	}

	var radios = obj.getElementsByTagName("radio");
	for(var c=0;c<radios.length;c++){
		radios[c].checked =false;
	}	
	var selects = obj.getElementsByTagName("select");
	for(var c=0;c<selects.length;c++){
		selects[c].value = "";
	}
	
}

//弹出窗口
var show = function(url,title,height,width){
	var PageHref = url;//Link address
	showWindwoButton('id',title,height,width,PageHref)
}

//弹出纳税人详细资料
function nsrlshinf1(nsrlsh,nsrmc){
	var openwidth=window.screen.width*1.05;
	var openheight= window.screen.height*0.78;
	var PageHref = "NSR/HJGL_NSRXX.jsp?NSRLSH="+nsrlsh;//Link address
	showWindwoButton('id',nsrlsh+"   "+nsrmc,openwidth,openheight,PageHref)
}
//弹出纳税人详细资料
function nsrlshinf2(url,nsrlsh,nsrmc){
	var openwidth=window.screen.width*1.05;
	var openheight= window.screen.height*0.78;
	var PageHref = "NSR/HJGL_NSRXX.jsp?NSRLSH="+url;//Link address
	showWindwoButton('id',nsrlsh+"   "+nsrmc,openwidth,openheight,PageHref)
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
		document.getElementById(wushuju).style.display="";
		document.getElementById(youshuju).style.display="none";
	}else{
		document.getElementById(wushuju).style.display="none";
		document.getElementById(youshuju).style.display="";
	}
}

//去左空格;   
function ltrim(s){     
	return s.replace(/(^\s*)/, "");  
}   
 //去右空格;   
function rtrim(s){   
	return s.replace(/(\s*$)/, "");  
} 
//去左右空格;   
function trim(s){  
	return rtrim(ltrim(s));   
} 


function showImport(url){
	var PageHref = url;
	showWindwoButton('id','导入',400,200,PageHref);
}


