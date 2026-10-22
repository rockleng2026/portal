function GetGameList(gameID)
{
     $.ajax({
                type:"POST",
                url:gameurl,
                data:"gameID="+gameID,
                success:function(result)
                {
                    $("#ddlGame").html(result) ;
                },
                error:function(err)
                {
                    alert("网络繁忙，请刷新再试！");
                }
        })
}

function GetServerList(gameID,serverID)
{
     $.ajax({
                type:"POST",
                url:serverurl,
                data:"gameid="+gameID+"&serverid="+serverID,
                success:function(result)
                {
                    $("#ddlServer").html(result) ;
                },
                error:function(err)
                {
                    alert("网络繁忙，请刷新再试！");
                }
        })
}
function GameChange(obj)
{
    var gameID = $("#ddlGame").val()
    GetServerList(gameID,-1) ;
    GetMoneyCardList(gameID,payPluginID) ;
    if(gameID > 0 )
    {
        $("#lblGameName").html(document.getElementById("ddlGame").options[document.getElementById("ddlGame").selectedIndex].text) ;
    }
}

function GetMoneyCardList(gameID,payPluginID)
{
    $.ajax({
                type:"POST",
                url:moneyCardUrl,
                data:"gameid="+gameID+"&payPluginID="+payPluginID,
                success:function(result)
                {
                    $("#ddlMoneyCard").html(result) ;
                },
                error:function(err)
                {
                    alert("网络繁忙，请刷新再试！");
                }
        })
}

function GetCoinNum()
{
    var gameID = $("#ddlGame").val()
    var moneyCardID = $("#ddlMoneyCard").val() ;
    $.ajax({
                type:"POST",
                url:coinNumUrl,
                data:"moneyCardID="+moneyCardID+"&gameID="+gameID+"&payPluginID="+payPluginID,
                success:function(result)
                {
                    $("#ltlCoinNumMsg").html(result) ;
                },
                error:function(err)
                {
                    alert("网络繁忙，请刷新再试！");
                }
        })
}
function ShowPayDesp(payname,userName)
{
    $.ajax({
                type:"POST",
                url:"",
                data:"payname="+payname+"&userName="+userName,
                success:function(result)
                {
                    $("#divPayDesp").html(result) ;
                },
                error:function(err)
                {
                    alert("网络繁忙，请刷新再试！");
                }
        })
}

function ChangePayType(obj,payID,payName,payTitle,username)
{
    payPluginID = payID;
    payPluginTitle = payTitle ;
    payPluginName = payName ;
    $("#ltlPayTitle").html(payTitle);
    ShowPayDesp(payName,username) ;
    $("#divPayPluginList>a").attr("class","paynav")
    $("#divPayPluginList").children("a").attr("class","paynav")
    $(obj).attr("class","paynav_now") ;
    
   // $("#divPayStart").show() ;
    //$("#divPayEnd").hide() ;
  
}


//验证输入帐号的正确性
function CheckUserName2()
{
    var username='';
    var email='';

	if(username==$('#txtUserName').val())
	{
        return false;
	}
	else
	{
		username=$('#txtUserName').val();
	}
    if($('#txtUserName').val().length>12||$('#txtUserName').val().length<6)
    {
        
		$('#ltlMsgUser').html('帐号应在6-12位之间！');
        return false;
    }
    if(/\W/.test($('#txtUserName').val()))
    {
		$('#ltlMsgUser').html('帐号只能含有字母和数字！');
		return false;
    }
    
    var chk_url = "queryUserInfo.do";
    $.ajax(
    {
        type: "POST",
		url: chk_url,
		data: 'UserName='+$.trim($('#txtUserName').val()),
		success: function(result)
		{
			if(result == "false")
			{
				alert("xxx");
				$('#ltlMsgUser').html($('#txtUserName').val() + '不存在！');
				return false;
			}
			else
			{
				alert("yyy");
			   $('#ltlMsgUser').html("<font style=\"color:Green\">"+ $('#txtUserName').val() + '存在！'+"</font>");
				return true ;
			   
			}
		},
		error:function()
		{
			return false;
		}
    });

}

function CheckUserNameAagin()
{
    if($('#txtUserNameAgain').val().length>12||$('#txtUserNameAgain').val().length<6 ||  $('#txtUserNameAgain').val()!=$('#txtUserName').val())
    {
       $('#ltlMsgUserAgain').html('两次输入的帐号不相等！请核对后重新输入！');
       return false ;
    }
    else
    {
        $('#ltlMsgUserAgain').html("<font style=\"color:Green\">"+"两次输入的帐号相等!"+"</font>");
        return true ;
    }
}

function ShowPostPage()
{
    CheckPostData() ;
   
}
function BindData()
{
    gameName = document.getElementById("ddlGame").options[document.getElementById("ddlGame").selectedIndex].text
    serverName = document.getElementById("ddlServer").options[document.getElementById("ddlServer").selectedIndex].text
    $("#ltlPayName").html(payPluginTitle) ;
    $("#ltlUserName").html($("#txtUserName").val()) ;
    $("#ltlGameName").html(gameName) ;
    $("#ltlServerName").html(serverName) ;
    $("#ltlMoney").html(document.getElementById("ddlMoneyCard").options[document.getElementById("ddlMoneyCard").selectedIndex].text) ;
    
    $("#OptGID").val($("#ddlGame").val()) ;
    $("#ServerID").val($("#ddlServer").val()) ;
    $("#Username").val($.trim($("#txtUserName").val())) ;
    $("#MoneyCardID").val($("#ddlMoneyCard").val()) ;
    $("#pd_frpid").val(pd_frpid) ;
    $("#payName").val(payPluginName) ;
    if($("#txtCardNum").val() !="" && $("#txtCardPwd").val() !="")
    {
        $("#CardNum").val($("#txtCardNum").val()) ;
        $("#CardPwd").val($("#txtCardPwd").val()) ;
    }
    show_center('divPostPage',28);
}
function CancelPostPage()
{
    close_center('divPostPage',28);
}

function CheckPostData()
{
    var gameIDSel   =  $("#ddlGame").val() ;
    if(gameIDSel <= 0 )
    {
        alert("请选择游戏") ;
        return false;
    }
    var serverIDSel =  $("#ddlServer").val() ;
    if(serverIDSel <= 0 )
    {
        alert("请选择区服") ;
        return false ;
    }
    var moneyIDSel = $("#ddlMoneyCard").val() ;
    if(moneyIDSel <=0 )
    {
        alert("请选择充值金额") ;
        return false;
    }
    var userName = $("#txtUserName").val() ;
    var userNameAgain = $("#txtUserNameAgain").val() ;
    if(userName == "" || userNameAgain == "")
    {
        alert("用户名不能为空！") ;
        return false;
    }
    else if(userName != userNameAgain)
    {
        alert("请用户名填写一致！") ;
        return false;
    }
    var cardNum = $("#txtCardNum").val() ;
    var cardPwd = $("#txtCardPwd").val() ;
    if(cardNum =="" || cardPwd == "")
    {
        alert("请填写充值卡卡号和密码！") ;
        return false ;
    }
    return CheckRole(userName,serverIDSel) ;
}
function CheckRole(userName,serverID)
{
    $.ajax(
    {
        type: "POST",
		url: checkRoleUrl,
		data: 'username='+userName+"&ServerID="+serverID,
		//async:true ,
		success: function(result)
		{ 
			if(result.toString().toLowerCase()!="true")
			{
			    if(result.toLowerCase().indexOf("http://") == 0)
			    {
			        
			        var url = result.split(',')[0];   
			        var msg = result.split(',')[1];   
			        if(confirm(msg))
			        {
			            //location.target="_blank" ;
			            location = url ;
			            //window.open(url) ;
			           // $("#submit_game").attr("action",url) ;
			           // $("#submit_game").submit() ;
			        }
			    }
			    else
			    {
			        alert(result) ;
			    }
				return false;
			}
			else
			{
			    BindData() ;
			    return true ;
			}
			
		},
		error:function()
		{
			//alert('数据加载错误');
			return false;
		}
    });

}

function ChangeBank(obj)
{
    pd_frpid = $(obj).val() ;
}

function StartPay()
{
    CancelPostPage() ;
    $("#divPayStart").hide() ;
    $("#divPayEnd").show() ;
    $("#sumbit_pay").submit() ;
    
}

function HidePayMsg()
{
    $("#divPayStart").show() ;
    $("#divPayEnd").hide() ;
}