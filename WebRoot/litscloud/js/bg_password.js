function updatePasswod(basePath)
{
	
	var password=document.getElementById("password").value;
	var password1=document.getElementById("password1").value;
	var newPassword=document.getElementById("newPassword").value;
	var okNewPassword=document.getElementById("okNewPassword").value;
	
	if(password==null ||password=="")
	{
		alert("当前密码不能为空");
		return false;
	}
	else	if(password!=password1)
	{
		alert("当前密码错误");
		return false;
	}
	else if(newPassword==null || newPassword=="")
	{
		alert("密码不能为空");
		return false;
	}
	else if(/^[0-9]*$/.test(newPassword))
	{
		alert("密码不能全是数字");
		return false;
	}
	else if(/^[A-Za-z]+$/.test(newPassword))
	{
		alert("密码不能全是英文");
		return false;
	}
	else if(newPassword.length<6)
	{
		alert("密码的长度要大于6位数");
		return false;
	}
	else if(newPassword!=okNewPassword)
	{
		alert("2次输入的密码不一样");
		return false;
	}
	
	$.getJSON("updateNewPasswordCustomerServer.Action",{newPassword:newPassword},function(data){
		if(data==1)
		{
			location.href =basePath+"litscloud/ucenter/updatePasswordWancheng.jsp"
		}
		else
		{
			alert("修改密码失败！！！→_→ ");
		}
	
	});
	
}
function updatePhone(basePath)
{
	var phone=document.getElementById("phone").value;
	if(phone==null||phone=="")
	{
		alert("更换手机号不能为空！！");
		return false;
	}
	else if(!(/(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(phone)))
	{
		alert("手机格式错误！！");
		return false;
		
	}
	$.getJSON("updatePhoneCustomerServer.Action",{phone:phone},function(data){
		if(data==1)
		{
			location.href =basePath+"litscloud/ucenter/updatePhoneYanZheng.jsp";
		}
		else
		{
			alert("修改手机失败！！！→_→ ");
		}
	
	});

}
function updateEmail(basePath)
{
	var email=document.getElementById("email").value;
	if(email==null||email=="")
	{
		alert("更换邮箱号不能为空！！");
		return false;
	}
	else if(!(/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(email)))
	{
		alert("邮箱格式错误！！");
		return false;
		
	}
	var url = "checkFiledCustomerServer.Action";
    $.post(url,{email:email},function(data){
   	if(data=="0")
   	{
   		alert("邮箱也被注册");
   		return false;
   	}
   	else 
   	{
   		$.getJSON("updateEmailCustomerServer.Action",{email:email},function(data){
   			if(data==1)
   			{
   				location.href =basePath+"litscloud/ucenter/updateEmailYanZheng.jsp";
   			}
   			else
   			{
   				alert("修改邮箱失败！！！→_→ ");
   			}
   		
   		});

   	}
	});
	
}
function updateAuthorization(basePath)
{
	var authorization=document.getElementById("authorization").value;
	
	if(authorization==null ||authorization=="")
	{
		alert("授权码不能为空");
		return false;
	}
	
	else if(/^[0-9]*$/.test(authorization))
	{
		alert("授权码不能全是数字");
		return false;
	}
	else if(/^[A-Za-z]+$/.test(authorization))
	{
		alert("授权码不能全是英文");
		return false;
	}
	else if(authorization.length<6||authorization.length>16)
	{
		alert("授权码的长度6~~~16位数");
		return false;
	}
	
	
	$.getJSON("updateAuthorizationCustomerServer.Action",{authorization:authorization},function(data){
		if(data==1)
		{
			location.href =basePath+"litscloud/ucenter/updateAuthorizationYanZheng.jsp"
		}
		else
		{
			alert("修改授权失败！！！→_→ ");
		}
	
	});
	
}

