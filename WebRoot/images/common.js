// JavaScript Document
function ProSearch(a,t)
{
	if(t=="focus")
	{
		if($(a).val()=="搜索用户、游戏...")
		{
			$(a).val("");
			$(a).attr("class","TxtFocus")
		}
	}
	else{
		if($(a).val()=="")
		{
			$(a).val("搜索用户、游戏...");
			$(a).attr("class","Txt")
		}
	}
}


function ShowIcondetail(a)
{
	var o = $(a);
	var op =$(a).parent();
	var to =op.children("div");
	to.fadeIn();
}

function HideIcondetail(a)
{
	var o = $(a);
	if(o.css("display")=="block")
	{
		o.fadeOut();
	}
}

function TabMenu(a)
{
	var o = $(a);
	var op = o.parent();

	
	op.children("div").hide();
	o.children("div").show();
	op.children("li").children("a").attr("class","AA_m")
	o.children("a").attr("class","Anow_m")
}
function TabOut(a)
{
    var o = $(a);
//	var op = o.parent();
//	var oop = op.parent();
	o.children("div").hide();
//	op.children("li").children("div").hide();
	
}



function FocusInput()
{
	var o = $("#UserSelect");
	ShowMessageUserSelect();	
}

function ShowMessageUserSelect()
{
	var to = $("#UserSelect");
	to.show();
}

function HideMessageUserSelect()
{
	var o = $("#UserSelect");
	var input1 = $("#Reciever");
	var input2 = $("#RecieverHidden");
	var v1 = "";
	var v2 = "";
	if(o.children().children("input").length > 0)
	{
		for(i=0;i<o.children().children("input").length;i++)
		{
			if(o.children().children("input")[i].checked == true)
			{
				if(v1=="")
				{
					v1 = o.children().children("input")[i].name.replace("s_","");
					v2 = "<"+o.children().children("input")[i].value+">"
				}
				else
				{
					v1 += ","+o.children().children("input")[i].name.replace("s_","");
					v2 += ",<"+o.children().children("input")[i].value+">"
				}
			}
		}
	}
	input2.val(v1);
	input1.val(v2);
	o.hide();
}


function DelFriendApplication(userid)
{
    if(window.confirm("确定要删除此好友吗?"))
    {
        $.get("ajax/AjaxProFriend.aspx?Action=delete&UserID="+userid, function(data){
          window.location.reload();
        });
    }
}
