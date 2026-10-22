
var submitFlg = false;
var markName_all;
var markName_select;
var parentWin;
var p_name_Ele;
var p_showName_Ele;
var p_idList_Ele;
var p_ctrl;
var firstOpenFlg;
var currentUsersList = ";";
var onLineUsers = "";
var CURRENT_ID = "2";      //当前选择DIV
var KEYWORD_ID = 5;        //关键字查询
var DEPT_ID = "2";         //按部门选择
var LOAD_FLAG = 2;         //首先要加载的列表 类型：整型
var ROLE_ID = 3;           //按岗位选择人员
var GROUP_ID = 4;          //按通讯组选择人员
var buffalo = null;
var allowRepeatFlg = false;	//人员设置是否允许重复
var BranchUserList=";";     //分公司所有人员ID列表


//查询的初始化
function searchOnLoad(){
	var columnArray = ["user_id","name","dept_name"]
	var mySuggest = new liusir.TextSuggest();
	mySuggest.add_suggest('textSuggest','userListService.getUsersByKeyWord',columnArray);
	document.getElementById("textSuggest").focus();
}

function onLoad() {
	
	parentWin = window.opener;
	initChangeData() ;
	init();
	onLineUsers = parentWin.document.getElementById("onlineUsers").value;
	buffalo = new Buffalo(endPoint);
	searchOnLoad();
	p_name_Ele = parentWin.document.getElementById(parentWin.m_name);
	p_showName_Ele = parentWin.document.getElementById(parentWin.m_showName);
	p_idList_Ele = parentWin.document.getElementById(parentWin.m_idList);
	p_ctrl = parentWin.m_ctrl;
	initShowFlgSet();
	firstOpenFlg = parentWin.openFlg;
	markName_all = document.getElementById("markName_all").value;
	markName_select = document.getElementById("markName_select").value;
	changeSelect(LOAD_FLAG,document.getElementById("textSuggest"));
	if (firstOpenFlg) {
		currentUsersList += p_idList_Ele.value.substring(1); 
		if(document.getElementById("rightList") != null){
			receiveCurrentValue();
		}
		receiveParentWindowValue();
	}
	changeSelect(LOAD_FLAG,document.getElementById('groupNameList'));
	try {		
		getTheDeptUser(10, document.getElementById("currentBranchId").value);
	} catch (ex) {
	}
}

//初始化用户的显示设置
/*
	java程序中的顺序
	ctrl += hideDept ? "1" : "0";   部门
	ctrl += hidePersonnel ? "1" : "0";按部门选人
	ctrl += hideGroup ? "1" : "0";  通讯组
	ctrl += hideWhole ? "1" : "0";  按岗位选择人员
	ctrl += hideAll ? "1" : "0";         全体人员
	ctrl += hideAllUserList ? "1" : "0"; 所有人员列表
	ctrl += selectMultipleUser ? "1" : "0"; 可以选择重复的人员
*/
function initShowFlgSet() {
	var deptFlg = p_ctrl.substring(0, 1) == "0";         //选择部门
	var personnelFlg = p_ctrl.substring(1, 2) == "0";    //按部门选人
	var groupFlg = p_ctrl.substring(2, 3) == "0";        //通讯组
	var roleFlg = p_ctrl.substring(3, 4) == "0";         //按岗位选择人员
	var allFlg = p_ctrl.substring(4, 5) == "0";          //全体人员
	var allUserListFlg = p_ctrl.substring(5, 6) == "0";  //所有人员列表
	try {
		allowRepeatFlg = p_ctrl.substring(6, 7) == "1";	//可以选择重复的人员
	} catch(ex) {
		allowRepeatFlg = false;
	}
	if (!deptFlg) document.getElementById("deptUserLI").style.display = "none";
	if (!personnelFlg) document.getElementById("UserByDept").style.display = "none";
	if (!groupFlg) document.getElementById("groupUserLI").style.display = "none";
	if (!roleFlg) document.getElementById("roleUserLI").style.display = "none";
	if (!allUserListFlg) document.getElementById("allUsers").style.display = "none";
	if (!allFlg){     
		document.getElementById("allowSendToAll").style.display = "none";
		document.getElementById("allowSendToAllline").style.display = "none";     	
	}
}

function receiveCurrentValue(){
	var userIdList = p_idList_Ele.value.substring(1);
   	var userNameList = p_showName_Ele.value;
   	if(userIdList == "") return false;
	var userIdArray = userIdList.split(";");
	var userNameArray = userNameList.split(";");
	for(var j = 0;j < userIdArray.length;j++){
   		if(userIdArray[j] == "") continue;
    	createOption(document.getElementById("rightList"), userNameArray[j], userIdArray[j]);
    }
}

function receiveParentWindowValue() {
    document.getElementById("receiveValue").value = "NoValue";
    if (p_idList_Ele == null) return;
    var setValue = currentUsersList;
    if (setValue == ";") return;
    var leftListCurrenObj = document.getElementById("leftList_"+CURRENT_ID);
    if (leftListCurrenObj != null) {
        var count = leftListCurrenObj.length;
        for (var i=0; i<count; i++) {
        	var optObj = leftListCurrenObj.options[i];
        	if(!optObj) continue;
        	if(setValue.indexOf(";" + optObj.value + ";") == -1) continue;
            initMove(i);
            if(!allowRepeatFlg) i = i - 1;	//允许重复时，不删除item
        }
    }
    
    var deptCheckObj = document.getElementsByName("deptCheck");
    if (deptCheckObj != null) {
        var count = deptCheckObj.length;
        for (var i=0; i<count; i++) {
            if (setValue.indexOf(";" + deptCheckObj[i].id + ";") > -1) {
                deptCheckObj.checked = true;
            }
        }
    }
}

//设置初始值时的移动数据 左→右
function initMove(i) {
	if (i < 0) return;
	var s = document.getElementById("leftList_" + CURRENT_ID);
	var t = document.getElementById("rightList");
	if(currentUsersList.indexOf(";" + s.options[i].value + ";") < 0){
		createOptionWidthStyle(t, s.options[i]);
	}
	//允许重复设置时，保留
	if(!allowRepeatFlg) s.remove (i);
}

//发送给全体人员
function sendToAll() {
	if (p_idList_Ele != null) 
	if (isALLUser == "true") {
		p_idList_Ele.value = ";;";
	} else {	
		p_idList_Ele.value = BranchUserList;
	}
	if (p_name_Ele != null) p_name_Ele.value = markName_all;
	if (p_showName_Ele != null) p_showName_Ele.value = markName_all;
	window.close();
}

function submitWrite() {
	writeReceiver(false);
	if (!submitFlg) {
		document.all.actForm.submit();
		submitFlg = true;
	}
}

//向receiver中写入全部接收者id，每个id用“;”分隔
function writeReceiver(closeFlg) {
	var str=";";
	var showName = "";
	var receiveValue = ";";
	var rightListObj = document.getElementById("rightList");
	if (rightListObj != null) {
		var optAry = rightListObj.options;
		var optAryCount = optAry.length;
		for (var i = 0; i < optAryCount; i++) {
			var optText = optAry[i].text;
			var optValue = optAry[i].value;
			if(!allowRepeatFlg && (str.indexOf(";" + optValue + ";") > -1)) continue;
			str += optValue + ";";
			showName += optText + ";";
			receiveValue += optValue + "|" + optText + ";";
		}
	} else if (document.getElementsByName("deptCheck") != null) {
		var objAry = document.getElementsByName("deptCheck");
		for (var i = 0; i < objAry.length; i++) {
			var obj = objAry[i];
			if (obj.checked && str.indexOf(";" + obj.value + ";") == -1) {
				str += obj.value + ";";
				showName += obj.id + ";";
			    receiveValue += obj.value + "|" + obj.id + ";";
			    obj.checked = false;
			}
		}
	}
	var receiveValueObj = document.getElementById("receiveValue");
	var setValue = receiveValueObj.value;
	if (setValue != "NoValue" && setValue != "") {
		var middleSite;		//"|" 
		var lastSite;
		var valueId;
		site = 0;
		while (site != -1) {
			middleSite = setValue.indexOf("|", site + 1);
			if (middleSite == -1) break;
			valueId = setValue.substring(site + 1, middleSite);
			lastSite = setValue.indexOf(";", middleSite + 1);
			if (str.indexOf(";" + valueId + ";") == -1) {
				str += valueId + ";";
				showName += setValue.substring(middleSite + 1, lastSite) + ";";
		    }
		    setValue = setValue.substring(lastSite);
		    if (setValue == "") break;
		    site = 0;
		}
	}
	if (str == ";") {
		str = "";
		receiveValue = "NoValue";
		showName = markName_select;
	}
	if (receiveValueObj.value == "NoValue" || receiveValueObj.value == "") {
    	receiveValueObj.value = receiveValue;
	} else if (receiveValue != "NoValue"){
    	receiveValueObj.value += receiveValue.substring(1);
	}
	if (!closeFlg) return;
	if (p_idList_Ele != null) p_idList_Ele.value = str;
	if (p_name_Ele != null) p_name_Ele.value = showName;
	if (p_showName_Ele != null) p_showName_Ele.value = showName;
	parentWin.openFlg = true;
	window.close();
}

//移动选中人员
//nType = 0: 左边选中的项目移到右边		左→右
//nType = 1: 右边选中的项目移到左边		左←右
//nType = 2: 左边全部移到右边
//nType = 3: 右边全部移到左边
function UserMove (nType) {
	var rightListObj = document.getElementById("rightList");
	var currentLeftListObj = document.getElementById("leftList_" + CURRENT_ID);
    if (nType == 0) return moveItem (currentLeftListObj, rightListObj, false);
    if (nType == 1) return moveItem (rightListObj, currentLeftListObj, false);
    if (nType == 2) return moveItem (currentLeftListObj, rightListObj, true);
    if (nType == 3) return moveItem (rightListObj, currentLeftListObj, true);
}

//移动选中的项目
function moveItem (sObj, tObj, allFlg) {
	alert(sObj+tObj+allFlg);
	if (sObj == null || tObj == null) return false;
	var rightToLeftFlg = (sObj.name == "rightList");	//左←右
    var i = 0;
    while (sObj.length > i) {
    	var sObj_i = sObj.options[i];
    	if(!allFlg && sObj_i.selected == false) {
    		i++;
    		continue;	
    	}
    	//以下为 全移动 或 选中的状态
    	if(rightToLeftFlg){
    		currentUsersList = currentUsersList.replace(";" + sObj_i.value + ";",";");
    	} else{
    		currentUsersList += sObj_i.value + ";";
    	}
    	//不重复时要创建，左到右要创建
    	if(!allowRepeatFlg || !rightToLeftFlg) createOptionWidthStyle(tObj, sObj_i);
    	//不重复时要删除，右到左要删除
        if(!allowRepeatFlg || rightToLeftFlg) {
        	sObj.remove (i);
        } else {
        	i++;	
        }
    }
    sObj.selectedIndex = -1;
    tObj.selectedIndex = -1;
}

//将选中的项目向上移一个项目
function upMove() {
	var slctIndex = document.all.rightList.selectedIndex;
	if (slctIndex == -1 || slctIndex == 0) return false;
	optMove(slctIndex - 1);
	return true;
}

//将选中的项目向下移一个项目
function downMove() {
	var slctIndex = document.all.rightList.selectedIndex;
	if (slctIndex == -1 || slctIndex == document.all.rightList.length - 1) return false;
	optMove(slctIndex + 1);
	return true;
}

//将选中的项目移动
function optMove(changeIndex) {
	var rightListObj = document.getElementById("rightList");
	if(!rightListObj) return false;
	var slctIndex = rightListObj.selectedIndex;
	var itemText = rightListObj.item(changeIndex).text;
	var itemValue = rightListObj.item(changeIndex).value;
	var itemColor = rightListObj.item(changeIndex).style.color;
	rightListObj.item(changeIndex).text = rightListObj.item(slctIndex).text;
	rightListObj.item(changeIndex).value = rightListObj.item(slctIndex).value;
	rightListObj.item(changeIndex).style.color = rightListObj.item(slctIndex).style.color;
	rightListObj.item(slctIndex).text = itemText;
	rightListObj.item(slctIndex).value = itemValue;
	rightListObj.item(slctIndex).style.color = itemColor;
	rightListObj.selectedIndex = changeIndex;
	
}

//选中父部门后，直接改变子部门
function changeSubDept(deptElement) {
	if (deptElement == null) return false;
	var rightListObj = document.getElementById("rightList");
	if(deptElement.checked){
		clearSelect(rightListObj,deptElement.value);
		createOptionWidthStyle(rightListObj,deptElement);
	}else{
		clearSelect(rightListObj,deptElement.value);
	}
	if (!document.all.selectUp.checked){ 
		return false;
	}
	if (!deptElement.checked) {
		notSelectedSubDept(deptElement.value);
	} else {
		selectedSubDept(deptElement.value);
	}
}

//选择checkBox状态
function selectedSubDept(selectedDeptValue) {
	var deptCheckObj = document.getElementsByName("deptCheck");
	var count = deptCheckObj.length;
	for (var i=0; i<count; i++) {
	    var currentDept = deptCheckObj[i];
	    if (selectedDeptValue == currentDept.parentid) {
	    	currentDept.checked = true;
	    	clearSelect($("rightList"),currentDept.value);
	    	createOptionWidthStyle($("rightList"),currentDept);
		selectedSubDept(currentDept.value);
	    }
	}
}

//取消checkBox选中状态
function notSelectedSubDept(selectedDeptValue) {
	var deptCheckObj = document.getElementsByName("deptCheck");
	var count = deptCheckObj.length;
	for (var i=0; i<count; i++) {
		var currentDept = deptCheckObj[i];
		if (selectedDeptValue == currentDept.parentid) {
			currentDept.checked = false;
			clearSelect($("rightList"),currentDept.value);
			notSelectedSubDept(currentDept.value);
		}
	}
}

//删除左边select中的选项
function clearSelect(obj,v){
	if(obj == null) return;
	for(var i = 0;i<obj.length;i++){
		if(obj.options[i].value == v){
			obj.options[i] = null;
		}
	}
}


//字符串链接，之间没有任何符号***************
function StringBuffer() {
	this._strings=new Array();
}

StringBuffer.prototype.append=function(str){
	this._strings.push(str);
};

StringBuffer.prototype.toString=function(){
	return this._strings.join("");
};

//点击不同的选人方式
function menuClick(id) {
	
	var current_obj = document.getElementById("module_" + CURRENT_ID);
	var current_link = document.getElementById("link_" + CURRENT_ID);
	if(!current_obj || !current_link) return false;
	if(id == CURRENT_ID){
		if(current_obj.style.display == "none"){
			current_obj.style.display = '';
			current_link.className = "active";
		} else{
			current_obj.style.display = 'none';
			current_link.className = '';
		}	
	} else{
		current_obj.style.display = 'none';
		current_link.className = '';
		document.getElementById("module_" + id).style.display = '';
		document.getElementById("link_" + id).className = 'active';
	}
	CURRENT_ID = id;
	var tempId;	
	if(id == "10" && document.getElementById("leftList_" + CURRENT_ID).length == 0) {
		//tempId = "";
		tempId = document.getElementById("currentBranchId").value;
		getTheDeptUser(id,tempId);
	} else if (id == DEPT_ID) {
		tempId = document.getElementById("groupNameList").value;
		getTheDeptUser(id,tempId);
	} else if(id == ROLE_ID) {
		tempId = document.getElementById("roleList").value;	
		getTheDeptUser(id,tempId);
	} else if(id == GROUP_ID) {
		tempId = document.getElementById("groupList").value;	
		if(tempId == "") tempId = "WONoSelectionString";
		getTheDeptUser(id,tempId);
	}
	
	receiveParentWindowValue();	
	//设置图标显示样式
	var imgObjs = document.getElementsByTagName("img");
	for (var i = 0; i < imgObjs.length; i++) {
		if (imgObjs[i].src.indexOf("arrow_open.gif") > -1) {
			imgObjs[i].src = imgObjs[i].src.replace("arrow_open.gif", "arrow_close.gif");
		}
	}
	var obj = document.getElementById("link_" + id + "Img");
	obj.src = obj.src.replace("arrow_close.gif", "arrow_open.gif");
}

//当部门切换时
function changeSelect(flagId,obj){
	var paId = obj.value;
	if(flagId == KEYWORD_ID) flagId = "10";
	var selectElement = document.getElementById("leftList_" + flagId);
	if(!selectElement) return false;
	selectElement.length = 0;
	getTheDeptUser(flagId,paId);
}

function initChangeData() {
   var changeAry = document.getElementById("groupNameList");
   for(var i = 0;i<changeAry.length;i++) {
       var str = changeAry[i].value;
	   var strAry = str.split(';');
	   changeAry[i].value = strAry[0];
	   changeAry[i].lcr = strAry[1];
   }
}


//选择人员
function  testSelect() {
	var test_2Obj = document.getElementById("test_2");
	if(!test_2Obj) return false;
	if(test_2Obj.innerHTML == select_user_currentDept ){
		test_2Obj.innerHTML = select_user_currentInnerDept;
	} else {
		test_2Obj.innerHTML = select_user_currentDept;	
	}
	changeSelect(LOAD_FLAG,document.getElementById('groupNameList'));
}

//检索
function getTheDeptUser(flagId,paremetId){
	var deptTree;
	var changeAry = document.getElementById("groupNameList");
	for(var i = 1;i < changeAry.length; i++) {
		if(changeAry[i].selected) deptTree = changeAry[i].getAttribute("lcr");
	}
	if(document.getElementById("test_2").innerHTML == select_user_currentInnerDept){
		paremetId += ";" + deptTree; 
	}
		
	var isALLUser="false";
	var javaMethod = "";
	try {
		isALLUser=parentWin.document.getElementById('isAll').value
	}catch (ex){
	}

	if(isALLUser=="true"){
		if(flagId == KEYWORD_ID){
			javaMethod = "userListService.getUsersByKeyWord";		
		}else {		
			javaMethod = "userListService.getUserList";
		}			
		buffalo.remoteCall(javaMethod, [flagId,paremetId,isALLUser], function(reply) {
	            var resultData = reply.getResult();
	            var sb = new StringBuffer();
	            if(resultData != null && resultData.length > 0){
	            	for(var i = 0;i < resultData.length;i++){
	            		sb.append(resultData[i]["user_id"]);
	            		sb.append("|");
	            		sb.append(resultData[i]["name"]);
	            		sb.append(",");	            	
	        		}
	            }
	            changeTheSelectHtml(flagId,sb.toString());
	        });	
				
	}else{
		if(flagId == KEYWORD_ID){
			javaMethod = "userListService.getUsersByKeyWord";		
		}else {		
			var Branch = document.getElementById("currentDeptTree");
			var branchId=null;

			if(Branch!=null &&flagId==10) paremetId=document.getElementById("currentBranchId").value+ ";" + Branch.value;

			javaMethod = "userListService.getUserList";

		}			
		buffalo.remoteCall(javaMethod, [flagId,paremetId,isALLUser], function(reply) {
		            var resultData = reply.getResult();
		            var sb = new StringBuffer();
		            if(resultData != null && resultData.length > 0){
		            	for(var i = 0;i < resultData.length;i++){
		            		sb.append(resultData[i]["user_id"]);
		            		if(flagId==10) BranchUserList += resultData[i]["user_id"]+";";
		            		sb.append("|");
		            		sb.append(resultData[i]["name"]);
		            		sb.append(",");	            	
		        		}
		            }
		            changeTheSelectHtml(flagId,sb.toString());
		        });	
		
	}	
	
	
	
}

function changeTheSelectHtml(flagId, usersArray){
	if(usersArray == "") return false;
	if(flagId == KEYWORD_ID) flagId = "10";
	var selectElement = document.getElementById("leftList_" + flagId);
	if(!selectElement) return false;
	selectElement.length = 0;
	var userList = usersArray.split(",");
	for(var i = 0;i < userList.length;i++){
		if(userList[i] == "") continue;
		var userId = userList[i].split("|")[0]; 
		var userName = userList[i].split("|")[1];
		if(currentUsersList.indexOf(";" + userId + ";") > -1 && !allowRepeatFlg) continue;	//允许重复时，加入全部数据
		var exitOnlineFlg = exit_online(userId, onLineUsers);
		if(exitOnlineFlg) userName += onLineMark;
		var op = new Option(userName,userId);
		if(exitOnlineFlg) op.style.color = 'red';
		selectElement.options.add(op);
	}
}

//判断一个用户是否在线
function exit_online(user_id,usersList){
	if(usersList == "") return false;
	var userArry = usersList.split(";");
	for(var i = 0;i < userArry.length;i++){
		if(user_id == userArry[i]) return true;
	}
	return false;
}


//创建下拉列表的一个子项
function createOption(s, txt, v) {
	if (txt == null && v == null) return false;
	v = v == null ? txt : v;
	s.options.add(new Option(txt,v));
}

//创建下拉列表的一个子项
function createOptionWidthStyle(s, op_i) {
	if(!s || !op_i) return false;
	var txt = op_i.text;
	var v = op_i.value;
	if (txt == null && v == null) return false;
	v = v == null ? txt : v;
	var op = new Option(txt,v);
	op.style.color = op_i.style.color;
	s.options.add(op);
}


