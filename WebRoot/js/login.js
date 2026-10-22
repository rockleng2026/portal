

function login(){
	var UserLogin=document.forms[0];
    if(UserLogin.loginName.value==""){
    	alert("请输入用户名!");
    	UserLogin.loginName.focus();
    	return;
    }
    if(UserLogin.password.value==""){
    	alert("请输入密码!");
    	UserLogin.password.focus();
    	return;
    }
    if(UserLogin.ValCode.value == "")
		{
			alert("请输入验证码！");
			UserLogin.ValCode.focus();
			return;
		}
	document.forms[0].action="UserLogin.do";
	document.forms[0].submit();
}

function login2(){
	var UserLogin=document.forms[0];
    if(UserLogin.loginName.value==""){
    	alert("请输入用户名!");
    	UserLogin.loginName.focus();
    	return;
    }
    if(UserLogin.password.value==""){
    	alert("请输入密码!");
    	UserLogin.password.focus();
    	return;
    }
    if(UserLogin.ValCode.value == "")
		{
			alert("请输入验证码！");
			UserLogin.ValCode.focus();
			return;
		}
	document.forms[0].action="User2Login.do";
	document.forms[0].submit();
}
function login3(){
	var UserLogin=document.forms[0];
    if(UserLogin.loginName.value==""){
    	alert("请输入用户名!");
    	UserLogin.loginName.focus();
    	return;
    }
    if(UserLogin.password.value==""){
    	alert("请输入密码!");
    	UserLogin.password.focus();
    	return;
    }
    if(UserLogin.ValCode.value == "")
		{
			alert("请输入验证码！");
			UserLogin.ValCode.focus();
			return;
		}
	document.forms[0].action="potalsLogin.do";
	document.forms[0].submit();
}