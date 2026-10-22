function checkreg()
{
     	if  ((document.regform.userid.value == "") || (document.regform.userid.value.length < 3 )) {
		alert("提示：\n\n用户名不能少于3位！");
		document.regform.userid.focus();
		return false;
	}
     	if  ((document.regform.userpass.value == "") || (document.regform.userpass.value.length < 6 )) {
		alert("提示：\n\n密码至少6位");
		document.regform.userpass.focus();
		return false;
	}
	if (document.regform.name.value == ""){
		alert ("提示：\n\n必须输入姓名！");
		document.regform.name.focus();
		return false;
	}
     	if (document.regform.email.value.length==0) {
                alert("提示：\n\n请填写你的email地址");
				document.regform.email.focus();
                return false;
             }

     	else if ((document.regform.email.value.indexOf("@")<0)||(document.regform.email.value.indexOf(":")!=-1))
                {
                        alert("提示：\n\n您填写的email无效，请填写一个有效的email\n\n");
                        document.regform.email.focus();
                        return false;
                }
	bstring = "0123456789";
		for(i = 0; i < document.regform.telare.value.length; i ++)
		{
			if (bstring.indexOf(document.regform.telare.value.substring(i,i+1))==-1)
			{
				alert('长途区号 只能包含数字');
				document.regform.telare.focus();
				return false;
			}
		}
	if (document.regform.telare.value == ""){
		alert ("提示：\n\n必须输入长途电话区号！");
		document.regform.telare.focus();
		return false;
	}
	if (document.regform.tel.value == ""){
		alert ("提示：\n\n必须输入电话！");
		document.regform.tel.focus();
		return false;
	}
	if (document.regform.tel.value.length <7){
		alert ("提示：\n\n电话必须大于7位！");
		document.regform.tel.focus();
		return false;
	}
	bstring = "0123456789,.+()/-&";
		for(i = 0; i < document.regform.tel.value.length; i ++)
		{
			if (bstring.indexOf(document.regform.tel.value.substring(i,i+1))==-1)
			{
				alert('电话 只能包含数字和,.+()/-&');
				document.regform.tel.focus();
				return false;
			}
		}
}

function checkNumber(str)
{ 
	var Letters = "1234567890";
    	var checkChar;

        for(var i = 0; i < str.length; i ++ )
        {
            	checkChar = str.charAt( i );
            	if (Letters.indexOf( checkChar) == -1)
            	{
                	return true;
            	} 
        }
        return false;
}

function IsValidString(temp)
{
	validStr=new String("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_");
	for(i=0;i<temp.length;i++)
	{
		if(validStr.indexOf(temp.charAt(i))==-1)
		{
			return false;
		}
	}
	return true;
}

var info1="<img src='../images/info2.gif'>"
var info2="<img src='../images/greenaccept1.gif'>"
var info3="<img src='../images/greenaccept.gif'>"
function inuserid(name)
{
	var objQueryStat = document.getElementById("div_name");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "登录帐号(<font color=red>3位到10位</font>),只能是<font color=red>英文或英文和数字的组合</font>";
}

function ProcessLogName(name)
{
	if (name.length>10 |name.length<3)
	{
	   	var objQueryStat = document.getElementById("div_name");
	   	objQueryStat.style.display = "block";
       		objQueryStat.innerHTML = info2 + "登录帐号(<font color=red>3位到10位</font>),只能是<font color=red>英文或英文和数字的组合</font>";
	}
	else
	{
		if (!checkNumber(name))
		{
			var objQueryStat = document.getElementById("div_name");
		   	objQueryStat.style.display = "block";
		   	objQueryStat.innerHTML = info2 + "登录帐号(<font color=red>3位到10位</font>),只能是<font color=red>英文或英文和数字的组合</font>";
		}
		else
		{
			if(IsValidString(name))
			{
				checkuser(name)
			}
			else
			{
		  		var objQueryStat = document.getElementById("div_name");
		  		objQueryStat.style.display = "block";
		  		objQueryStat.innerHTML =  info2 + "登录帐号(<font color=red>3位到10位</font>),只能是<font color=red>英文或英文和数字的组合</font>";

			}
		}

	}
}

var xmlHttp = false;
try
{
    	xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
} 
catch (e) 
{
    	try 
	{
        	xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
  	} 
	catch (e2) 
	{
        	xmlHttp = false;
  	}
}
if (!xmlHttp && typeof XMLHttpRequest != 'undefined') 
{
	var xmlHttp = new XMLHttpRequest(); 
}

function changedWrite()
{
    	if (xmlHttp.readyState == 4)
	{
        	var val = xmlHttp.responseText;
		if(val.indexOf("true")==-1)
		{
		  	var objQueryStat = document.getElementById("div_name");
		  	objQueryStat.style.display = "block";
		  	objQueryStat.innerHTML =  info2 + "您输入的登陆帐号已存在,请重新输入!";
		}
		else
		{
		  	var objQueryStat = document.getElementById("div_name");
		  	objQueryStat.style.display = "block";
		  	objQueryStat.innerHTML =  info3 + "恭喜您,可以正常注册!";
		}
	}
}

function checkuser(val1)
{
	var objQueryStat = document.getElementById("div_name");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML =  "正在检测用户是否存在...";
    	var post=val1;
    	var sLocation = window.location.href;
    	var url = sLocation.substring(0, sLocation.lastIndexOf("/") + 1) + "make.asp?userid=" + post;
    	xmlHttp.open("GET", url, true);
    	xmlHttp.onreadystatechange = changedWrite;
    	xmlHttp.send(null);
}

function inuserpass(name)
{
	var objQueryStat = document.getElementById("div_pwd");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "用户登录时所用密码,由a-z;A-Z;0-9的字母数字组合";
}
function ProcessPwd(pwd)
{
	if(pwd.length > 16|pwd.length < 6)
	{
	   	var objQueryStat = document.getElementById("div_pwd");
	   	objQueryStat.style.display = "block";
       		objQueryStat.innerHTML = info2 + "登录密码长度需要在6-15之间!";	
	}
	else
	{
		if(!IsValidString(pwd))
		{
		   	var objQueryStat = document.getElementById("div_pwd");
		   	objQueryStat.style.display = "block";
		   	objQueryStat.innerHTML = info2 + "登录密码只能包含数字,字母,下划线";		
		}
		else
		{
		  	var objQueryStat = document.getElementById("div_pwd");
		  	objQueryStat.style.display = "block";
		  	objQueryStat.innerHTML =  info3 + "密码格式输入正确!";
		}
	}
}

function inname()
{
	var objQueryStat = document.getElementById("div_cname");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "您的真实姓名,以便联系";
}
function ProcessCname(cname)
{
	if(cname.length>0)
	{
		var objQueryStat = document.getElementById("div_cname");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info3 + "输入正确";
	}
	else
	{
		var objQueryStat = document.getElementById("div_cname");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "此项必填";			
	}
}

function inmail()
{
	var objQueryStat = document.getElementById("div_email");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "务必准确,否则不能收到(域名、主机)密码";
}
function ProcessEmail(Email)
{
	if((document.regform.email.value.indexOf("@")<=0)||(document.regform.email.value.indexOf("@.")>-1)||(document.regform.email.value.indexOf(".")<0)||(document.regform.email.value.indexOf("@")<0)||(document.regform.email.value.indexOf(":")!=-1))
	{
		var objQueryStat = document.getElementById("div_Email");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "邮箱格式输入错误,此项必填,格式user@domain.com";
	}
	else
	{
		checkemail(Email);		
	}
}

function changedMail()
{
    	if (xmlHttp.readyState == 4)
	{
        	var val = xmlHttp.responseText;
		if(val.indexOf("true")==-1)
		{
		  	var objQueryStat = document.getElementById("div_Email");
		  	objQueryStat.style.display = "block";
		  	objQueryStat.innerHTML =  info2 + "您输入的邮箱已被使用,请重新输入!";
		}
		else
		{
		  	var objQueryStat = document.getElementById("div_Email");
		  	objQueryStat.style.display = "block";
		  	objQueryStat.innerHTML =  info3 + "恭喜您,可以正常注册!";
		}
	}
}

function checkemail(val1)
{
	var objQueryStat = document.getElementById("div_Email");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML =  "正在检测邮箱是否被使用...";
    	var post=val1;
    	var sLocation = window.location.href;
    	var url = sLocation.substring(0, sLocation.lastIndexOf("/") + 1) + "make.asp?email=" + post;
    	xmlHttp.open("GET", url, true);
    	xmlHttp.onreadystatechange = changedMail;
    	xmlHttp.send(null);
}

function inqq()
{
	var objQueryStat = document.getElementById("div_qq");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "您的QQ号或者MSN账号,此项必填";
}
function ProcessQq(qq)
{
	if(qq.length>0)
	{
		if (!(checkNumber(qq)))
		{
			var objQueryStat = document.getElementById("div_qq");
			objQueryStat.style.display = "block";
			objQueryStat.innerHTML = info3 + "QQ输入正确";
		}
		else
		{
			if((document.regform.qq.value.indexOf("@")<=0)||(document.regform.qq.value.indexOf("@.")>-1)||(document.regform.qq.value.indexOf(".")<0)||(document.regform.qq.value.indexOf("@")<0)||(document.regform.qq.value.indexOf(":")!=-1))
			{
				var objQueryStat = document.getElementById("div_qq");
				objQueryStat.style.display = "block";
				objQueryStat.innerHTML = info2 + "MSN邮箱格式输入错误,此项必填";
			}
			else
			{
				var objQueryStat = document.getElementById("div_qq");
				objQueryStat.style.display = "block";
				objQueryStat.innerHTML = info3 + "MSN邮箱格式输入正确";
			}
		}

	}
	else
	{
		var objQueryStat = document.getElementById("div_qq");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "您的QQ号或者MSN账号,此项必填";			
	}
}

function inphone()
{
	var objQueryStat = document.getElementById("div_phone");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "带区号技术联系用(<font color=red>>7位</font>),举例:12345678";
}
function inmobile()
{
	var objQueryStat = document.getElementById("div_mobile");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "请输入联系的手机号(<font color=red>11位</font>),举例:13813855888";
}
function ProcessPhonecna(phone)
{
	//要符合电话号码规范
	var myReg = /^[0-9]{1,13}$/; 
  	if(!myReg.test(phone)||phone.length<1||phone.length>10)
  	{
		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "请输入电话国际区号";			
 	 }
	 else
	 {
		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info3 + "您输入的电话国际区号格式正确";
	 }
  
}
function ProcessPhoneare(phone)
{
	//要符合电话号码规范
	var myReg = /^[0-9]{1,13}$/; 
  	if(!myReg.test(phone)||phone.length<1||phone.length>10)
  	{
		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "请输入电话区号,如010";			
 	 }
	 else
	 {
		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info3 + "您输入的电话区号格式正确";
	 }
  
}
function ProcessPhone(phone)
{
	//要符合电话号码规范
	var myReg = /^[0-9]{1,13}$/; 
  	if(!myReg.test(phone)||phone.length<7)
  	{
 		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "格式为:86+区号+7位以上电话号";
 	 }
	 else
	 {
		var objQueryStat = document.getElementById("div_phone");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info3 + "您输入的电话格式正确";
	 }
  
}
function ProcessMoble(phone)
{
	//要符合电话号码规范
	var myReg = /^[0-9]{1,13}$/; 
  	if(!myReg.test(phone)||phone.length<7)
  	{
 		var objQueryStat = document.getElementById("div_mobile");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "请输入联系的手机号(<font color=red>11位</font>),举例:13813855888";
 	 }
	 else
	 {
		var objQueryStat = document.getElementById("div_mobile");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info3 + "您输入的电话格式正确";
	 }
  
}

function incode()
{
	var objQueryStat = document.getElementById("div_code");
	objQueryStat.style.display = "block";
	objQueryStat.innerHTML = info1 + "请输入左边的验证码";
}
function ProcessCode(code)
{
	//要符合电话号码规范
	var myReg = /^[0-9]{1,13}$/; 
  	if(!myReg.test(code)||code.length>4)
  	{
 		var objQueryStat = document.getElementById("div_code");
		objQueryStat.style.display = "block";
		objQueryStat.innerHTML = info2 + "请输入左边的验证码";
 	 }
	 else
	 {
		  var objQueryStat = document.getElementById("div_code");
		  objQueryStat.style.display = "block";
		  objQueryStat.innerHTML =  info3 + "请输入左边的验证码";
	 }
}