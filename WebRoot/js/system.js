
//注销管理员权限
function distroy(uid, mark) {
	var str = "你确定要注销该用户吗？";
	if (mark == "0") {
		str = "你确定要开通该用户吗？";
	}
	if (window.confirm(str) == true) {
		var url = "functionStatusSystem.do";
		$.post(url, {
			userid : uid,
			state : mark
		}, function(data) {
			if (data == 0 || data == 1) {
				window.location.href = "userListSystem.do?mark=customer";
			} else {
				alert("网络问题，请稍候再试！");
			}
		});
	}
}

//添加菜单项
function addMenuFunctions()
{
	var flg=0;
	var linkFunctionName = encodeURI($("#linkFunctionName").val());
	var superId = $("#superId").val();
	var linkFunctionPage = $("#linkFunctionPage").val();
	var imagepath = $("#imagepath").val();
	var description = encodeURI($("#description").val());
	var ver=$("input:radio[name='versionFlag']:checked");
	if(ver.length==0){
		$("#versionFlagMsg").html("该项不能为空");
		document.getElementById("versionFlag").focus();
		flg=1;
		return ;
	}
	if(linkFunctionName=="")
	{
		$("#linkFunctionNameMsg").html("该项不能为空");
		document.getElementById("linkFunctionName").focus();
		flg=1;
		return ;
	}
	if(flg==0)
	{
		var url = "saveMenu.do";
		var values=$("input:radio[name='versionFlag']:checked").val();
		//alert("val="+values);
		$.post(url,{linkFunctionName:linkFunctionName,superId:superId,linkFunctionPage:linkFunctionPage,imagepath:imagepath,description:description,"versionFlag":values},function (data){
			if(data=="1"){
				alert("新增菜单项成功");
				window.location.href="menuManagerMenu.do";
			}
			else if(data=="2")
			{
				alert("新增模块成功");
				window.location.href="selectFunctionsSystem.do";
			}
			else
			{
				alert("操作菜单项失败");
				return ;
			}
		});
	}
	
}

//修改模块
function editFunctionSystem()
{
	
	var functionid = $("#functionid").val();
	var linkFunctionName = encodeURI($("#linkFunctionName").val());
	var superId = $("#superId").val();
	var linkFunctionPage = $("#linkFunctionPage").val();
	var imagepath = $("#imagepath").val();
	var description = encodeURI($("#description").val());

	var url = "updateMenu.do";
	
	$.post(url,{functionid:functionid,linkFunctionName:linkFunctionName,superId:superId,linkFunctionPage:linkFunctionPage,imagepath:imagepath,description:description},function (data){
		
		if(data=="3")
		{
			alert("修改模块成功");
			window.location.href="selectFunctionsSystem.do";
		}
		else
		{
			alert("操作菜单项失败");
			return ;
		}
	});
}

//添加组成员
function addGroup()
{
	
	var groupid = $("#groupid").val();
	var groupName = encodeURI($.trim($("#groupName").val()));
	var superGroupId = $("#superGroupId").val();
	var permissionGrade = encodeURI($.trim($("#permissionGrade").val()));
	var description = encodeURI($("#description").val());
				
	//alert(permissionGrade);
	var pipei = "请选择";
	if(groupName==null||groupName=="")
	{
		$("#groupNameMsg").html("该项不能为空！");
		document.getElementById("groupName").focus();
		return ;
	}
	else if(permissionGrade==encodeURI(pipei))
	{
		$("#permissionGradeMsg").html("请选择权限等级！");
		document.getElementById("permissionGrade").focus();
		return;
	}
	else
	{
		var url = "addOrUpdateGroup.do";
		$.post(url,{groupid:groupid,groupName:groupName,superGroupId:superGroupId,permissionGrade:permissionGrade,description:description},function(data){
			if(data=="1")
			{
				alert("添加组成员成功");
				window.location.href = "groupListGroup.do";
			}
			else
			{
				alert("操作失败");
			}
		});
		
	}
}

//修改组成员
function editGroup()
{
	var groupid = $("#groupid").val();
	var groupName = encodeURI($("#groupName").val());
	var superGroupId = $("#superGroupId").val();
	var permissionGrade = encodeURI($("#permissionGrade").find("option:selected").text());
	var description = encodeURI($("#description").val());
				
	var url = "addOrUpdateGroup.do";
	$.post(url,{groupid:groupid,groupName:groupName,superGroupId:superGroupId,permissionGrade:permissionGrade,description:description},function(data){
		if(data=="2")
		{
			alert("修改组成员成功");
			window.location.href = "groupListGroup.do";
		}
		else
		{
			alert("操作失败");
		}
	});
}



