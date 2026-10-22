
function RegSubmit()
{
    chk_user();
    chk_pwd();
    chk_rpwd();
    chk_email();

    if($('#chkAgree').attr("checked"))    
    {
        if( $("#code").val() == "" )
        {
            $("#tdValideCode").html('<p class="formtip_n">验证码不能为空</p>') ;
        }
        else
        {
            //记录推广ID
            var href = window.location.href;
            var index = href.lastIndexOf("pubid=");
            var userid="";
             var reg = new RegExp("^-?[0-9]\\d*$");
            if(index>-1)//判断是否找到
            {
                userid = href.substring(index+6);
            }
            if(reg.test(userid))//判断是否为整数
            {
                $("#pubid").val(userid.replace("-",""));
            }
            var value="pubname=";
            if(href.indexOf('pubname=')>-1)
            {
                var vlengt=value.length;
                var v = href.indexOf('pubname=');
                var vv = href.substring(v+vlengt);
                $("#pubname").val(vv);
            }
            
            $("#f_form").submit() ;
        }
    }
    else
    {
        $("#tdAgree").html('请同意注册协议') ;
    }
}

var Ischk = true ;

function FocusEmail(a)
{
	$("#EmailTip").attr("class","Tips");
	$("#EmailTip").html("请填写正确的邮箱地址!");
	$(a).attr("class","txt1");
}

function BlurEmail()
{
    if(!Ischk)
    {
        return ;
    }
	var g = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	if(!g.test($("#Email").val()))
	{
		$("#EmailTip").attr("class","No");
		$("#EmailTip").html("您的邮箱格式填写错误！");
		$("#Email").attr("class","txt");
		$("#e_h").val(0);
	}
	else{
         $.ajax({
           type: "POST",
           url: "CheckReg.aspx",
           data: "Type=Email&Email="+$("#Email").val(),
           success: function(msg){
            
             if(msg=="true")
             {
		        $("#EmailTip").attr("class","No");
		        $("#EmailTip").html("此Email地址已被占用");
		        $("#Btn").attr("disabled","disabled");
		        $("#Email").attr("class","txt");
		        $("#e_h").val(0);
             }
             else{
		        $("#EmailTip").attr("class","Ok");
		        $("#EmailTip").html("");
		        $("#Email").attr("class","txt");
		        $("#e_h").val(1);
             }
           }
         });
    	
	}

}

function FocusUserName(a)
{
	$("#UserNameTip").attr("class","Tips");
	$("#UserNameTip").html("用户名为6-12位字母或数字!");
	$(a).attr("class","txt1");
}

function BlurUserName()
{
    if(!Ischk)
    {
        return ;
    }
    BlurEmail();
	var g = /^\w{6,12}$/;
	if(!g.test($("#UserName").val()))
	{
		$("#UserNameTip").attr("class","No");
		$("#UserNameTip").html("用户名填写错误！");
		$("#UserName").attr("class","txt");
		$("#u_h").val(0);
	}
	else{
         $.ajax({
           type: "POST",
           url: "CheckReg.aspx",
           data: "Type=UserName&UserName="+$("#UserName").val(),
           success: function(msg){
             if(msg=="true")
             {
		        $("#UserNameTip").attr("class","No");
		        $("#UserNameTip").html("此用户名已被占用");
		        $("#UserName").attr("class","txt");
		        $("#u_h").val(0);
             }
             else{
		        $("#UserNameTip").attr("class","Ok");
		        $("#UserNameTip").html("");	
		         $("#Btn").removeAttr("disabled");
		         $("#UserName").attr("class","txt");
		         $("#u_h").val(1);
             }
           }
         });
	}
	
}


function FocusPassword(a)
{
	$("#PasswordTip").attr("class","Tips");
	$("#PasswordTip").html("密码为6-12位字母或数字!");
	$(a).attr("class","txt1");
}

function BlurPassword()
{
    BlurEmail();
    BlurUserName();
	var g = /^\w{6,12}$/;
	if(!g.test($("#Password").val()))
	{
		$("#PasswordTip").attr("class","No");
		$("#PasswordTip").html("密码填写错误！");
		$("#Password").attr("class","txt");
		$("#p_h").val(0);
	}
	else{
		$("#PasswordTip").attr("class","Ok");
		$("#PasswordTip").html("");	
		 $("#Btn").removeAttr("disabled");
		 $("#Password").attr("class","txt");
	}
	
}


function FocusPassword1(a)
{
	$("#Password1Tip").attr("class","Tips");
	$("#Password1Tip").html("密码为6-12位字母或数字!");
	$(a).attr("class","txt1");
}

function BlurPassword1()
{
    BlurPassword();
    BlurEmail();
    BlurUserName();
	var g = /^\w{6,12}$/;
	if(!g.test($("#Password1").val()))
	{
		$("#Password1Tip").attr("class","No");
		$("#Password1Tip").html("密码填写错误！");
		$("#Password1").attr("class","txt");
		$("#p_h").val(0);
	}
	else{
		if($("#Password").val()!=$("#Password1").val())
		{
			$("#Password1Tip").attr("class","No");
			$("#Password1Tip").html("两次填写的密码不同！");
			$("#Password1").attr("class","txt");
			$("#p_h").val(0);
		}
		else
		{
			$("#Password1Tip").attr("class","Ok");
			$("#Password1Tip").html("");
			 $("#Btn").removeAttr("disabled");
			 $("#Password1").attr("class","txt");
			 $("#p_h").val(1);
		}
	}
	
}

function BlurSex()
{
    if($("#Sex1")[0].checked==false && $("#Sex2")[0].checked==false)
    {
	    $("#SexTip").attr("class","No");
	    $("#SexTip").html("请选择性别!");
    }
    else{
	    $("#SexTip").attr("class","Ok");
	    $("#SexTip").html("");
	    $("#Btn").removeAttr("disabled");
    }

}

function FocusCode(a)
{
	$("#CodeTip").attr("class","Tips");
	$("#CodeTip").html("请填写正确的验证码!");
	$(a).attr("class","txt1");
}

function BlurCode()
{
    BlurEmail();
    BlurUserName();
    BlurPassword();
    BlurPassword1();
	var g = /^[a-z]\w{5,12}$/;
	if($("#Code").val()=="")
	{
		$("#CodeTip").attr("class","No");
		$("#CodeTip").html("请填写验证码！");
		$("#Code").attr("class","txt");
		$("#c_h").val(0);
	}
	else{
     $.ajax({
       type: "POST",
       url: "CheckReg.aspx",
       data: "Type=Code&Code="+$("#Code").val(),
       success: function(msg){
         if(msg=="true")
         {
			$("#CodeTip").attr("class","Ok");
			$("#CodeTip").html("");
			 $("#Btn").removeAttr("disabled");
			 $("#Code").attr("class","txt");
			 $("#c_h").val(1);
         }
         else{
			$("#CodeTip").attr("class","No");
			$("#CodeTip").html("验证码错误!");
			$("#Code").attr("class","txt");
			$("#c_h").val(0);
         }
       }
     });
	}
	
}


function SubmitReg()
{
        BlurEmail();
		BlurUserName();
        BlurPassword();
        BlurPassword1();
        BlurCode();
        if($("#e_h").val()!="1" || $("#u_h").val()!="1" || $("#p_h").val()!="1" || $("#c_h").val()!="1")
        {
	        return;
        }
        var Sex =1;
        if($("#Sex1")[0].checked == true)
        {
            Sex =0;
        }
        
        if($("#Rule")[0].checked == false)
        {
	        $("#Warn").html("您必须同意注册条款！");
	        $("#Warn").attr("class","WarnNo");
	        $("#Warn").css("display","block");
            return;
        }
        
        $("#Btn").hide();
        $("#Loading").show();
        $("#Warn").hide();
        //window.open("checkreg.aspx?"+"Type=Submit&Email="+$("#Email").val()+"&UserName="+$("#UserName").val()+"&Password="+$("#Password").val()+"&Sex="+Sex);
        //return;
        
        //记录推广ID
        var href = window.location.href;
        var index = href.lastIndexOf("pubid=");
        var userid="";
         var reg = new RegExp("^-?[0-9]\\d*$");
        if(index>-1)//判断是否找到
        {
            userid = href.substring(index+6);
        }
        if(reg.test(userid))//判断是否为整数
        {
            $("#pubid").val(userid.replace("-",""));
        }
        var value="pubname=";
        if(href.indexOf('pubname=')>-1)
        {
            var vlengt=value.length;
            var v = href.indexOf('pubname=');
            var vv = href.substring(v+vlengt);
            $("#pubname").val(vv);
        }
        
        var comtype ="";
        if($("#comType")[0]!=null)
        {
            comtype = $("#comType").val();
        }
        var uid ="";
        if($("#uid")[0]!=null)
        {
            uid = $("#uid").val();
        }
        
       Ischk = false ;
         $.ajax({
           type: "POST",
           url: "SaveReg.aspx",
           data: "Type=Submit&Email="+$("#Email").val()+"&Username="+$("#UserName").val()+"&Pwd="+$("#Password").val()+"&Rpwd="+$("#Password1").val()+"&Sex="+Sex+"&Code="+$("#Code").val()+"&uid="+uid+"&comType="+comtype+"&truename=-&cardtype=0&cardnum=0",
           success: function(msg)
           {
            //alert(msg);
            //return;
             if(msg=="true")
             {
                Ischk = false ;
			    window.location.href="http://www.youxi.com/game.aspx";
             }
             else
             {
                Ischk = true ;
                switch(msg)
                {
                    case "email_x":
                        $("#EmailTip").attr("class","No");
			            $("#EmailTip").html("邮箱格式错误！");
			        break;
                    case "email_has":
			            $("#EmailTip").attr("class","No");
			            $("#EmailTip").html("邮箱地址已经存在！");
			        break;
                    case "username_has":
			            $("#UserNameTip").attr("class","No");
			            $("#UserNameTip").html("此用户名已被注册！");
			        break;
                    case "username_x":
			            $("#UserNameTip").attr("class","No");
			            $("#UserNameTip").html("帐号只能含有字母和数字(6-12位)");
			        break;
                    case "username_length":
			            $("#UserNameTip").attr("class","No");
			            $("#UserNameTip").html("用户名长度应为6-12位！");
			        break;
                    case "username_has":
			            $("#UserNameTip").attr("class","No");
			            $("#UserNameTip").html("用户名已经存在！");
			        break;
                    case "pwd_length":
			            $("#PasswordTip").attr("class","No");
			            $("#PasswordTip").html("密码长度应为6-12位！");
			        break;
                    case "pwd_w":
			            $("#PasswordTip").attr("class","No");
			            $("#PasswordTip").html("两次输入的密码不同！");
			        break;
                    case "pwd_x":
			            $("#PasswordTip").attr("class","No");
			            $("#PasswordTip").html("密码格式错误！");
			        break;
                    case "send_erro":
			            $("#Warn").html("注册过程中发送邮件错误！");
			            $("#Warn").attr("class","WarnNo");
			            $("#Warn").css("display","block");
			        break;
                    case "erro":
			            $("#Warn").html("注册过程中发生错误！");
			            $("#Warn").attr("class","WarnNo");
			            $("#Warn").css("display","block");
			        break;
                }
			    $("#Loading").hide();
			    $("#Btn").show();
			    
             }
           },
           error:function()
           {
                Ischk = true ;
           }
         });
}