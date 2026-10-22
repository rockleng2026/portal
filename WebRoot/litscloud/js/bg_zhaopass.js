function yanZheng(basePath1)
{
	//litscloud/ucenter/bg_zhaopass02.jsp
	var youxiang=document.getElementById("youxiang").value;
	var yanzhengma=document.getElementById("yanzhengma1").value;
	if(youxiang==null||youxiang=="")
	{
		document.getElementById("YX").innerHTML="邮箱不能为空！→_→ ";
		
		return false;
	}
	else if(!(/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(youxiang)))
	{
		document.getElementById("YX").innerHTML="邮箱格式不对→_→";
		return false;
	}
	else if(yanzhengma==""||yanzhengma==null)
	{
		document.getElementById("YZM").innerHTML="验证码不能为空";
		return false;
	}
	else
	{
		$.getJSON("litscloud/web/selectEmailCustomerServerC.Action",{youxiang:youxiang,yanzhengma:yanzhengma},function(data){
			if(data==1)
			{
				location.href =basePath1+"litscloud/ucenter/bg_zhaopass02.jsp"
			}
			else if(data ==2)
			{
				document.getElementById("YZM").innerHTML="验证码错误";
			}
			else
			{
				alert("找回密码失败！！！→_→ ");
			}
		
		});
		;
	}
}
var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function huanyige()
{
	 var res = "";
     for(var i = 0; i < 4 ; i ++) {
         var id = Math.ceil(Math.random()*35);
         res += chars[id];
     }
   document.getElementById("yanzhengma").value=res;

}