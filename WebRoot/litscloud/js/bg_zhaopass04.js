function updatePassword(basePath)
{
	   var	password1=document.getElementById("password1").value;
	   var	password=document.getElementById("password").value;
	 
	   if(password1==null||password1=="")
	   {
	   		alert("重置密码不能为空！！");
	   		return false;
	   }
	   else if(password1.length<6)
	   {
		   	alert("重置密码不能小于6位数")
		   	return false;
	   }
	    else if(password.length>17)
	   {
		   	alert("重置密码不能大于17位数")
		   	return false;
	   }
	   if(password==null||password=="")
	   {
	   		alert("确认密码不能为空！！");
	   		return false;
	   }
	   else if(password.length<6)
	   {
		   	alert("确认密码不能小于6位数")
		   	return false;
	   }
	    else if(password.length>17)
	   {
		   	alert("确认密码不能大于17位数")
		   	return false;
	   }
	   if(password!=password1)
	   {
	   	alert("2次输入的密码不一样");
	   	return false;
	   }
	
	
	   $.getJSON("zhaoHuiPasswordCustomerServer.Action",{password:password},function(data){
		if(data==1)
		{
			
			location.href =""+basePath+"litscloud/ucenter/bg_zhaopass05.jsp";
		}
		else
		{
			alert("修改失败！！！→_→ ");
		}
	
	});
}