var alreadyOpenTableId = null;
var hrefBaseValue = null;

function closeMenu() {
	if (alreadyOpenTableId == null) return;
	alreadyOpenTable = document.getElementById(alreadyOpenTableId);
	targetTableId = alreadyOpenTableId + "d";
	targetTable = document.getElementById(targetTableId);
	targetTable.style.display = "none";
	alreadyOpenTableId = null;
}

function menuClick(tableSrc) {
	var currentTableSrc = tableSrc;
	if (currentTableSrc.id != alreadyOpenTableId) closeMenu();
	targetTableId = currentTableSrc.id+"d";
	targetTable = document.getElementById(targetTableId);
	if (targetTable.style.display == "none") {
		targetTable.style.display = '';
		alreadyOpenTableId = currentTableSrc.id;
	} else {
        targetTable.style.display = "none";
	}
}

function subMenuClick(tableSrc) {
	subTableId = tableSrc.id+"d";
	subTable = document.getElementById(subTableId);
	var tableSrcImgId = tableSrc.id + "_img";
	var tableSrcImg = document.getElementById(tableSrcImgId);
	if (subTable != null) {
		if (subTable.style.display == "none") {
			subTable.style.display = '';
			tableSrcImg.src = SubImgOpen;
		} else {
			subTable.style.display = "none";
			tableSrcImg.src = SubImg;
		}
	}
}

function actionPage(urlValue, urlName, urlTarget) {
	if (urlValue == "") return false;
	var autoEnterObj = document.getElementById("autoEnter");
	autoEnterObj.target = urlTarget;
	var pageNameObj = document.getElementById("pageName");
	if(pageNameObj) pageNameObj.value = urlName;
	if (urlValue.indexOf("act") > -1) {
		var linkEle = document.getElementById(urlValue.substring(3));
		if (linkEle != null) {
			if (linkEle.href == "") {
				alert(errMsg);
				return true;
			}
			linkEle.click();
			return true;
		}
	}
	if (hrefBaseValue == null) hrefBaseValue = autoEnterObj.href;
	//打开 菜单报表
	if(urlValue.indexOf("REPORT_") == 0) {
		var num = hrefBaseValue.indexOf("/OAapp/");
		var url = hrefBaseValue.substring(0, num + 6) + "/jsp/showMenuReport.jsp?reportMainId=" + urlValue.substring(7);
		window.open(url, "showReportWin", "fullscreen,scrollbars");
		return true;
	}	
	//普通链接的跳转
	if (urlValue.indexOf("Oasp") < 0 && urlValue.indexOf("SYSTEMDEFINE") < 0) {
		var temp = autoEnterObj.href;
		autoEnterObj.href = urlValue;
		autoEnterObj.target = "_blank";
		autoEnterObj.click();
		autoEnterObj.href = temp;
		return true;
	}
	autoEnterObj.href = hrefBaseValue + "?PAGEID=" + urlValue;
	window.parent.desktop.location = autoEnterObj.href;	
}

function st_onload() {
	return;
}