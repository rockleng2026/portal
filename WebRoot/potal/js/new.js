// JavaScript Document
var timeout         = 220;
var closetimer		= 0;
var ddmenuitem      = 0;

function jsddm_open()
{	jsddm_canceltimer();
	jsddm_close();
	ddmenuitem = $(this).find('ul').eq(0).css('visibility', 'visible');}

function jsddm_close()
{	if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');}

function jsddm_timer()
{	closetimer = window.setTimeout(jsddm_close, timeout);}

function jsddm_canceltimer()
{	if(closetimer)
	{	window.clearTimeout(closetimer);
		closetimer = null;}}

$(document).ready(function()
{	
    for(var i=0;i<100;i++){
	$('#jsddm'+ i +'> li').bind('mouseover', jsddm_open);
	$('#jsddm'+ i +'> li').bind('mouseout',  jsddm_timer);
}
});
    
    document.onclick = jsddm_close;

function selchid(funid){
	$('#funcid').val(funid);
	$(".top ul li").each(function(){
		   $(this).removeClass("showselt");   
	 });
	document.getElementById("formid").submit();
}
function exits(){
   if(confirm("你确定要退出系统吗?")){
      location.href="closeSystemLogin.do";   
   }
}