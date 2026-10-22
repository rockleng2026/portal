document.writeln("<div id=\"divADtc\" style=\"position:absolute; width:300px; z-index: 99999;\">") ;
document.writeln("<div style=\"display:block; clear:both; height:29px; background:url(http://www.youxi.com/imgAD/mt_top.jpg) no-repeat;\">") ;
document.writeln("<span style=\"float:left;color:#EF4122; line-height:29px; padding-left:15px; font: bold 14px/29px Tahome '宋体';\">温馨提示：</span>") ;
document.writeln("<a  onclick=\"closeDiv()\" style=\"cursor:pointer;margin:6px 4px 0px 0px ; float:right;\"><img src=\"http://www.youxi.com/imgAD/mt_close.gif\" /></a>") ;
document.writeln("</div>") ;
document.writeln("<div style=\"display:block; clear:both;\">") ;
document.writeln("<a target=\"_blank\"   href=\"http://bbs.youxi.com/thread-56070-1-1.html\"><img style=\"border:0px;height:250px;width:300px;\" src=\"http://www.youxi.com/imgAD/bf3.gif\" /></a>") ;
document.writeln("</div>") ;
document.writeln("</div>") ;
window.onload = getMsg;
window.onresize = resizeDiv;
window.onerror = function(){}
//短信提示使用(FHB添加)
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer,i = 0;

var bodyfrm = ( document.compatMode.toLowerCase()=="css1compat" ) ? document.documentElement : document.body;
function getMsg()
{
    try
    {
        divTop = parseInt(document.getElementById("divADtc").style.top,10)
        divLeft = parseInt(document.getElementById("divADtc").style.left,10)
        divHeight = parseInt(document.getElementById("divADtc").offsetHeight,10)
        divWidth = parseInt(document.getElementById("divADtc").offsetWidth,10)
        docWidth = bodyfrm.clientWidth;
        docHeight = bodyfrm.clientHeight;
        document.getElementById("divADtc").style.top = parseInt(bodyfrm.scrollTop,10) + docHeight + 10;// divHeight
        document.getElementById("divADtc").style.left = parseInt(bodyfrm.scrollLeft,10) + docWidth - divWidth
        document.getElementById("divADtc").style.visibility="visible"
        objTimer = window.setInterval("moveDiv()",10)
    }
    catch(e)
    {
    }
}

function resizeDiv()
{
    i+=1
    //if(i>300) closeDiv() //客户想不用自动消失由用户来自己关闭所以屏蔽这句
    try
    {
        divHeight = parseInt(document.getElementById("divADtc").offsetHeight,10)
        divWidth = parseInt(document.getElementById("divADtc").offsetWidth,10)
        docWidth = bodyfrm.clientWidth;
        docHeight = bodyfrm.clientHeight;
        document.getElementById("divADtc").style.top = docHeight - divHeight + parseInt(bodyfrm.scrollTop,10)
        document.getElementById("divADtc").style.left = docWidth - divWidth + parseInt(bodyfrm.scrollLeft,10)
    }
    catch(e)
    {
    }
}

function moveDiv()
{
    try
    {
        if(parseInt(document.getElementById("divADtc").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10)))
        {
            window.clearInterval(objTimer)
            objTimer = window.setInterval("resizeDiv()",1)
        }
        divTop = parseInt(document.getElementById("divADtc").style.top,10)
        document.getElementById("divADtc").style.top = divTop - 100
    }
    catch(e)
    {
    }
}
function closeDiv()
{
    document.getElementById('divADtc').style.visibility='hidden';
}
