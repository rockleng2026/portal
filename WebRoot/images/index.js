function loginIndex()
{
    var username=$('#username').val();
    var pwd=$('#pwd').val();
    var code = $('#valicode').val() ;
    $.ajax(
    {
        type: "POST",
        url: url,
        data: 'username='+username+'&pwd='+pwd+'&code='+code,
        success: function(result)
        {
            if(result.toString().toLowerCase() == "true")
            {
                location.href = index_url ;
            }
            else
            {
                location.href= login_url ;
            }
        },
        error:function()
        {
            location.href= login_url ;
        }
    });
}

$('body').keydown(function(e)
 {
    if(e.keyCode==13)
    {
       loginIndex();
    }
})


// JavaScript Document
function TabGame1()
{
	Tabs();
	var game1 = $("#game1");
	var game2 = $("#game2");
	var games1 = $("#games1");
	var games2 = $("#games2");
	game1.show();
	game2.hide();
	games1.hide();
	games2.hide();
}

function TabGame2()
{
	Tabs();
	var game1 = $("#game1");
	var game2 = $("#game2");
	var games1 = $("#games1");
	var games2 = $("#games2");
	game2.show();
	game1.hide();
	games1.hide();
	games2.hide();
}

function TabGame3()
{
	Tabs();
	var game3 = $("#game3");
	var game4 = $("#game4");
	var games3 = $("#games3");
	var games4 = $("#games4");
	games3.hide();
	games4.hide();
	game3.show();
	game4.hide();
}

function TabGame4()
{
	Tabs();
	var game3 = $("#game3");
	var game4 = $("#game4");
	var games3 = $("#games3");
	var games4 = $("#games4");
	games3.hide();
	games4.hide();
	game4.show();
	game3.hide();
}

function TabGame5()
{
	Tabs();
	var game5 = $("#game5");
	var game6 = $("#game6");
	var games5 = $("#games5");
	var games6 = $("#games6");
	games5.hide();
	games6.hide();
	game5.show();
	game6.hide();
}

function TabGame6()
{
	Tabs();
	var game5 = $("#game5");
	var game6 = $("#game6");
	var games5 = $("#games5");
	var games6 = $("#games6");
	games5.hide();
	games6.hide();
	game6.show();
	game5.hide();
}


function TabGame7()
{
	Tabs();
	var game7 = $("#game7");
	var game8 = $("#game8");
	var games7 = $("#games7");
	var games8 = $("#games8");
	games7.hide();
	games8.hide();
	game7.show();
}

function TabGame8()
{
	Tabs();
	var game7 = $("#game7");
	var game8 = $("#game8");
	var games7 = $("#games7");
	var games8 = $("#games8");
	games7.hide();
	games8.hide();
	game8.show();
}

function TabGame9()
{
	Tabs();
	var game9 = $("#game9");
	var games9 = $("#games9");
	var games10 = $("#games10");
	games9.hide();
	games10.hide();
	game9.show();
}

function TabGame10()
{
	Tabs();
	var game9 = $("#game9");
	var game10 = $("#game10");
	var games9 = $("#games9");
	var games10 = $("#games10");
	games9.hide();
	games10.hide();
	game10.show();
}

function TabGame11()
{
	Tabs();
	var game11 = $("#game11");
	var game12 = $("#game12");
	var games11 = $("#games11");
	var games12 = $("#games12");
	games11.hide();
	games12.hide();
	game11.show();
}

function TabGame12()
{
	Tabs();
	var game11 = $("#game11");
	var game12 = $("#game12");
	var games11 = $("#games11");
	var games12 = $("#games12");
	games11.hide();
	games12.hide();
	game12.show();
}
function Tabs()
{
	$("#games1").show();
	$("#games2").show();
	$("#games3").show();
	$("#games4").show();
	$("#games5").show();
	$("#games6").show();
	$("#games7").show();
	$("#games8").show();
	$("#games9").show();
	$("#games10").show();
	$("#games11").show();
	$("#games12").show();
	$("#game1").hide();
	$("#game2").hide();
	$("#game3").hide();
	$("#game4").hide();
	$("#game5").hide();
	$("#game6").hide();
	$("#game7").hide();
	$("#game8").hide();
	$("#game9").hide();
	$("#game10").hide();
	$("#game11").hide();
	$("#game12").hide();
}
///
