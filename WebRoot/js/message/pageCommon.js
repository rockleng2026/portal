//******************************************************
// USER NAME			大连华天
// SYSTEM NAME		OA8000
// SUB SYSTEM NAME	COMMON COMPONENT
// FILE NAME			pageCommon.js
/**
* 窗口隐含域处理
* @AUTHOR	sissi
* @VERSION 	2004.10.18 新建
*/
//******************************************************

function init() {
	if(window.opener) self.focus();
	setTopTitle();
	showAlert();
	showConfirm();
	openNewWindow();
	openNewUrl();
	writeCookie("");
	writeQuickIdeaDefault();
	getFrameHeight();
	window.inerror = false;
	var functionNameObj = document.getElementById("functionName");
	if (!functionNameObj) functionNameObj = document.getElementsByName("functionName")[0];
	if (functionNameObj != null && opener != null) {
		if (functionNameObj.value == "^^0509CLOSE") {
			functionNameObj.value = "";
			opener.document.actForm.submit();
			window.close();
			return true;
		}
		//个人设置保存后关闭弹出窗口
		if (functionNameObj.value == "^^1205CLOSE") {
			functionNameObj.value = "";
			window.close();
			return true;
		}
		if (functionNameObj.value == "^^SwfUploadCLOSE") {
			functionNameObj.value = "";
			window.close();
			return true;
		}
	}
}

function menu() {
	st_onload();
}

//******************************************************
/**
* 初使化窗口时，根据父窗口传的值设置窗口标题
*/
//******************************************************
function setTopTitle() {
	if (document.homeForm.topTitle.value != "") {
		top.document.title = document.homeForm.topTitle.value;
	}
}

function showAlert() {
	if (document.homeForm.alertMsg.value != "") {
		alert(document.homeForm.alertMsg.value);
		document.homeForm.alertMsg.value = "";
	}
}

function openNewUrl() {
	if (document.homeForm.newUrl.value != "") {
		openUrl(document.homeForm.newUrl.value);
		document.homeForm.newUrl.value = "";
	}
}

function openUrl(urlStr) {
	window.open(urlStr, 'newWindow',
			   'toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes');
}

function openNewWindow() {
	if (document.homeForm.newWindow.value != "") {
	    var varOption = "toolbar=no,location=no,status=yes,menubar=no,resizable=yes,scrollbars=yes,width=" + screen.availWidth + ",height=" + screen.availHeight + ",left=0,top=0";
	    window.open(document.homeForm.newWindow.value, 'autoOpenWin', varOption);
	    document.homeForm.newWindow.value = "";
	}
}

function showConfirm() {
	if (document.homeForm.confirmMsg.value != "") {
		if (confirm(document.homeForm.confirmMsg.value)) {
    			document.homeForm.submit();
		}
		document.homeForm.confirmMsg.value = "";
	}
}

function openWindow(url, pWidth, pHeight, winName) {
	if(!url) return false;
	var winWidth = window.screen.availWidth; 
	var winHeight = window.screen.availHeight;
	if(!pWidth) pWidth = winWidth;
	if(!pHeight) pHeight = winHeight;
	var pleft = (winWidth - pWidth) / 2;
	if(pleft < 1) {
		pleft = 0;
		pWidth = winWidth;
	}
	var ptop = (winHeight - pHeight) / 2;
	if(ptop < 1) {
		ptop = 1;
		pHeight = winHeight;
	}
	var varOption = "dependent,toolbar=no,location=no,status=no,menubar=no,resizable=no,scrollbars=yes,"
				+ "width=" + pWidth + "px,height=" + pHeight + "px,left=" + pleft + "px,top=" + ptop + "px;";
	if(winName == null) winName = "newWindow"; 
	var getValue = window.open(url, winName, varOption);
	
}

//******************************************************
/**
* 输入框内的提示文字显示与设置
*/
//******************************************************
function inputAreaClick(inputElement, showText) {
	if (inputElement.value == showText) {
		inputElement.value = "";
	}
	inputElement.select;
}

function inputAreaBlur(inputElement, showText) {
	if (inputElement.value == "") {
		inputElement.value = showText;
	}
}

function writeCookie(str) {
	var expdate = new Date();
	SetCookie("oaDesktop", str, expdate, "/");
}

function SetCookie (nameValue, valueValue) {
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (argc > 2) ? argv[2] : null;
	var path = (argc > 3) ? argv[3] : null;
	var domain = (argc > 4) ? argv[4] : null;
	var secure = (argc > 5) ? argv[5] : false;
	document.cookie = nameValue + "=" + escape (valueValue) +
		((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +
		((path == null) ? "" : ("; path=" + path)) +
		((domain == null) ? "" : ("; domain=" + domain)) +
		((secure == true) ? "; secure" : "");
}

//打印
function printDOC() {
	var hkey_root,hkey_path,hkey_key;
	hkey_root="HKEY_CURRENT_USER";
	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	try{
	  var RegWsh = new ActiveXObject("WScript.Shell") ;
	  hkey_key="header" ;
	  RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"") ;
	  hkey_key="footer" ;
	  RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"") ;
	  }
	 catch(e){}
	window.print();
}
//打印按钮
function printBtn() {
	document.all.WEB_PVX.printing.Print(true);
//	window.print();
}

//打印预览
function privewDOC() {
	var hkey_root,hkey_path,hkey_key;
	hkey_root="HKEY_CURRENT_USER";
	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	try{
	  var RegWsh = new ActiveXObject("WScript.Shell") ;
	  hkey_key="header" ;
	  RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"") ;
	  hkey_key="footer" ;
	  RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"") ;
	  }
	 catch(e){}
	var obj = document.all.WebBrowser;
 	obj.ExecWB(7,1);
}

//打印预览按钮
function privewBtn() {
	var printObj = document.getElementById("WEB_PVX");
	try {
		var printViewModelSetObj = document.getElementById("printViewModelSet");
		if(printViewModelSetObj) {
			var setObj = jsonToObject(printViewModelSetObj.value);
			if(setObj != null) {
				if(setObj.portrait != null) printObj.printing.portrait = setObj.portrait == "ZX"; //横向 false; 纵向 true;
			}
		}
	} catch(e) {}
//  printObj.printing.header = "This is 页眉";
//    printObj.printing.footer = "Printing by ScriptX This is 页脚";
//    printObj.printing.portrait = false;		//横向 false; 纵向 true;
//    printObj.printing.leftMargin = 5.0;
//    printObj.printing.topMargin = 50.0;
//    printObj.printing.rightMargin = 5.0;
//    printObj.printing.bottomMargin = 5.0;
    printObj.printing.Preview(); 
}

function writeQuickIdeaDefault() {
	var ideaTextObj = $("ideaText");
	var quickIdeaListObj = $("quickIdeaList");
	if (quickIdeaListObj == null || ideaTextObj == null) return false;
	if (quickIdeaListObj.length == 0) return false;
	var count = document.all.quickIdeaList.length;
	for (var i = 0; i < count; i++) {
		if (quickIdeaListObj.options[i].value == 1) {
			ideaTextObj.value = quickIdeaListObj.options[i].text;
			quickIdeaListObj.selectedIndex = i;
			break;
		}
	}
}

function writeQuickIdea() {
	var ideaTextObj = $("ideaText");
	var quickIdeaListObj = $("quickIdeaList");
	if (quickIdeaListObj == null || ideaTextObj == null) return false;
	var selectedItem = quickIdeaListObj.selectedIndex;
	if (selectedItem == -1) return false;
	ideaTextObj.value = quickIdeaListObj.options[selectedItem].text;
}

function showQueryArea() {
	var queryAreaObj = $("queryArea");
	var quickQueryStateObj = $("quickQueryState");
	queryAreaObj.style.display = "none";
	quickQueryStateObj.value = "display:none";
	if (queryAreaObj.style.display == "none") {
		queryAreaObj.style.display = "";
		quickQueryStateObj.value = "";
	}
}

function getFrameHeight() {
	var obj = $("msgFrame");
	if (obj == null || obj.style == undefined) return true;
	var formHeight = document.body.clientHeight;
	obj.style.height = formHeight - 210;
}

window.onresize = getFrameHeight

var hrefBaseValue = null;

//编辑器文件下载
function downloadFile(downloadSrc, uploadFileName) {
	var obj = document.getElementById("downloadLnk");
	if (hrefBaseValue == null) hrefBaseValue = obj.href;
	obj.href = hrefBaseValue + "?downloadSrc=" + downloadSrc + "&fileName=" + encodeURI(uploadFileName);
	obj.target = "_blank";
	obj.click();

}

//对于HTML编辑部品，打开窗口画面
function openW(elementName){
	if (eWebEditor == null) return;
	eWebEditor.dialogOpen_formInsert(elementName);
}

//替换字符串中全部包含内容
function replaceStr(str, findKey, replaceKey) {
	if (str == null || findKey == null) return str;
	var site = str.indexOf(findKey);
	while (site > -1) {
		str = str.substring(0, site) + replaceKey + str.substring(site + findKey.length);
		site = str.indexOf(findKey);
	}
	return str;
}

//去除主机地址
function removeLocationAddress(html) {
	var hostAdd = window.location.protocol + "//" + window.location.host;
	var findSite = html.indexOf(hostAdd);
	while(findSite > -1) {
		html = html.substring(0, findSite) + html.substring(findSite + hostAdd.length);
		findSite = html.indexOf(hostAdd);
	}
	return html;
}

//***********************************
// 一些通用 方法
//***********************************

//创建下拉列表的一个子项
function createOption(s, txt, v) {
	if (txt == null && v == null) return false;
	v = v == null ? txt : v;
	s.options.add(new Option(txt, v));
}

// 基本信息提示，得到焦点并选定
function baseAlert(theText, notice){
	if(notice) alert(notice);
	try {
		theText.focus();
		theText.select();
	} catch(e) {}
	return false;
}

//获取页面对象
var $ = function(id) {
	var obj = document.getElementById(id);
	if(obj) return obj;
	obj = document.getElementsByName(id)[0];
	return obj;
};
/*
function content_onclick(objId) {
	var obj = document.getElementById(objId);
	if(!obj) return false;
	var others = obj.parentNode.children;
       	for (var i = 0; i < others.length; i++) {
		var ClickTrObj = others[i];
		ClickTrObj.className ="TableDetail2";
		ClickTrObj.children[0].children[0].checked=false;
	    }
    	obj.className = "selectLine";
	obj.children[0].children[0].checked=true;
	// var currentIndex = objId.substring(1, objId.length);
	// var currentTrCheckBoxObj = document.actForm.checkBox[parseInt(currentIndex) + 1];
	// var hasCheckedFlg = (currentTrCheckBoxObj.checked == true);
	//currentTrCheckBoxObj.checked = true;
	// var lastClickTrObj = document.getElementById("d" + lastclickid);
	//if(!lastClickTrObj) {
	//	lastclickid = currentIndex;
	//	return false;
	//}
	// var lastTrCheckBoxObj = document.actForm.checkBox[parseInt(lastclickid) + 1];
    //if(!hasCheckedFlg) lastTrCheckBoxObj.checked = false;
	//lastClickTrObj.className = lastclickid %2 == 0 ? "TableDetail2" : "TableDetail1";
	//lastclickid = currentIndex;
}
*/
//上次选择的行号
var lastclickid = -1;
//点击行
function content_onclick(objId) {
//	var obj = document.getElementById(objId);
//	if(!obj) return false;
//	var currentIndex = objId.substring(1, objId.length);
//	if(lastclickid == currentIndex) return false;
//    obj.className = "selectLine";
//	var currentTrCheckBoxObj = document.actForm.checkBox[parseInt(currentIndex) + 1];
//	var hasCheckedFlg = (currentTrCheckBoxObj.checked == true);
//	currentTrCheckBoxObj.checked = true;
//	var lastClickTrObj = document.getElementById("d" + lastclickid);
//	if(!lastClickTrObj) {
//		lastclickid = currentIndex;
//		return false;
//	}
//	var lastTrCheckBoxObj = document.actForm.checkBox[parseInt(lastclickid) + 1];
//    if(!hasCheckedFlg) lastTrCheckBoxObj.checked = false;
//	lastClickTrObj.className = lastclickid %2 == 0 ? "TableDetail2" : "TableDetail1";
//	lastclickid = currentIndex;
}



//点击全选
function checkAll() {
	var checkBoxObjAry = document.getElementsByName("checkBox");
	var count = checkBoxObjAry.length;
	var selectAllObj = $("selectAll");
	var selectAllFlg = false;
	if(selectAllObj) selectAllFlg = selectAllObj.checked;
	for (var i = 0; i < count; i++) {
		checkBoxObjAry[i].checked = selectAllFlg;
	}
	var lastClickTrObj = document.getElementById("d" + lastclickid);
	if(!lastClickTrObj) return false;
	lastClickTrObj.className = lastclickid %2 == 0 ? "TableDetail2" : "TableDetail1";
	lastclickid = -1;
}

function loadIFrameContent() {
	var frameSectionObj = document.getElementById("frameSection");
	if (frameSectionObj == null) return;
	var frmValueObj = document.getElementById("frmValue");
	if (frmValueObj == null) return;
	var obj = document.frames["frameSection"].document;
	obj.open();
	obj.write(frmValueObj.value);
}

function awokeSettingLoad() {
	var changeObj = "";
	var popUpSelect = "";
	var sectIndex = "";
	var state1 = "";
	var state2 = "";
	var obj1 = "";
	var obj2 = "";
	try {
		if(document.all.beforeCheck.checked){
			changeObj = document.getElementById("beforeSetting");
			changeObj.style.display = "";	
			
		        popUpSelect = document.getElementById("beforeSelect");	
			sectIndex = popUpSelect.selectedIndex;
			if (sectIndex == 0) {
				state1 = "none";
				state2 = "none";
			} else if (sectIndex == 1) {
				state1 = "";
				state2 = "none";
			} else if (sectIndex == 2) {
				state1 = "none";
				state2 = "";
			}
			obj1 = document.getElementById("before1");
			obj2 = document.getElementById("before2");
			obj1.style.display = state1;		
			obj2.style.display = state2;			
		}
	} catch(ex) {
	}
	try {
		if(document.all.endCheck.checked){
			changeObj = document.getElementById("endSetting");
			changeObj.style.display = "";	
				
		        popUpSelect = document.getElementById("endSelect");	
			sectIndex = popUpSelect.selectedIndex;
			if (sectIndex == 0) {
				state1 = "none";
				state2 = "none";
			} else if (sectIndex == 1) {
				state1 = "";
				state2 = "none";
			} else if (sectIndex == 2) {
				state1 = "none";
				state2 = "";
			}
			obj1 = document.getElementById("end1");
			obj2 = document.getElementById("end2");
			obj1.style.display = state1;		
			obj2.style.display = state2;			
		}
	} catch(ex) {
	}
	try {
		if(document.all.beyondCheck.checked){
			changeObj = document.getElementById("beyondSetting");
			changeObj.style.display = "";		
				
		        popUpSelect = document.getElementById("beyondSelect");	
			sectIndex = popUpSelect.selectedIndex;
			if (sectIndex == 0) {
				state1 = "none";
				state2 = "none";
			} else if (sectIndex == 1) {
				state1 = "";
				state2 = "none";
			} else if (sectIndex == 2) {
				state1 = "none";
				state2 = "";
			}
			obj1 = document.getElementById("beyond1");
			obj2 = document.getElementById("beyond2");
			obj1.style.display = state1;		
			obj2.style.display = state2;			
		}
	} catch(ex) {
	}
}

//******************************************
//		提醒设置
//******************************************

function settingChange (categoryName) {
	var checkboxChange = "";
	if (categoryName == "beforeSetting") {
		checkboxChange = document.getElementById("beforeCheck");
	} else if (categoryName == "endSetting") {
		checkboxChange = document.getElementById("endCheck");
	} else if (categoryName == "beyondSetting") {
		checkboxChange = document.getElementById("beyondCheck");
	}
	var playState = "";
	if (checkboxChange.checked) {
		playState = "";	
	} else {
		playState = "none";
	}
	var changeObj = document.getElementById(categoryName);
	changeObj.style.display = playState;		
}

function awokeCategorySelect(awokeCategory) {
	var selectObjName = "";
	var obj1 = "";
	var obj2 = "";
	if (awokeCategory == "before") {
		selectObjName = "beforeSelect";
		obj1 = document.getElementById("before1");
		obj2 = document.getElementById("before2");
	} else if (awokeCategory == "end") {
		selectObjName = "endSelect";
		obj1 = document.getElementById("end1");
		obj2 = document.getElementById("end2");
	} else if (awokeCategory == "beyond") {
		selectObjName = "beyondSelect";
		obj1 = document.getElementById("beyond1");
		obj2 = document.getElementById("beyond2");
	}
	var popUpSelect = document.getElementById(selectObjName);	
	var sectIndex = popUpSelect.selectedIndex;
	var state1 = "";
	var state2 = "";
	if (sectIndex == 0) {
		state1 = "none";
		state2 = "none";
	} else if (sectIndex == 1) {
		state1 = "";
		state2 = "none";
	} else if (sectIndex == 2) {
		state1 = "none";
		state2 = "";
	}
	obj1.style.display = state1;		
	obj2.style.display = state2;			
}