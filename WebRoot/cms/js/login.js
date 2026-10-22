
$(function(){
    $('#yhm').focus();
});

function changeCode(obj){
	var pm=$('#paths').val();
	var timenow = new Date().getTime();
	obj.src=pm+"cms/changesLogin.do?d="+timenow;
}
function subs(){
	if($('#yhm').val()==""){
	  	$('#errname').html("用户名不能为空");
	  	$('#yhm').focus();
	}else if($('#mima').val()==""){
		$('#errname').html("");
		$('#errpass').html("密码不能为空");
		$('#mima').focus();
	}else if($('#yzm').val()==""){
		$('#errname').html("");
		$('#errpass').html("");
		$('#errcode').html("验证码不能为空");
		$('#yzm').focus();
	}else{
		$('#errname').html("");
		$('#errpass').html("");
		$('#errcode').html("");
		$('#loginForm').submit();
	}
}
