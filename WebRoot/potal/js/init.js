var winHeight ;
var winWidth  ;
var topdiv = 0	  ;	
var topxdiv = 0	  ;
var dibudiv = 0 ;
var dibuxiadiv = 0 ; 
function init(){
	if (window.innerHeight)
		winHeight = window.innerHeight;
	else if ((document.body) && (document.body.clientHeight))
		winHeight = document.body.clientHeight;
		
	//通过深入Document内部对body进行检测，获取窗口大小
	if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
		{
		//alert(111);
		winHeight = document.documentElement.clientHeight;
		winWidth = document.documentElement.clientWidth;
		}
		//alert(winHeight);
		topdiv = document.getElementById("topdiv").offsetHeight;
		topxdiv = document.getElementById("topxdiv").offsetHeight;
		dibudiv = document.getElementById("dibudiv").offsetHeight;
		dibuxiadiv = document.getElementById("dibuxiadiv").offsetHeight;
		//alert("--"+winHeight+"--"+topdiv+"--"+topxdiv+"--"+dibudiv+"--"+dibuxiadiv);
		document.getElementById("content_iframe").height = winHeight-topdiv-topxdiv-dibudiv-dibuxiadiv-8;
		document.getElementById("middle_content_div").height = winHeight-topdiv-topxdiv-dibudiv-dibuxiadiv;
}
	//window.onresize=function(){
	//init();
	//}
init();
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
$(window).resize(function() {
    //var width = $(this).width();
    //var height = $(this).height();
    //alert(width);
    //alert(height);
    init();
});
$(document).ready(function(){

	$(".btn-slide").click(function(){
		$("#panel").slideToggle("slow");
		$(this).toggleClass("active"); return false;
	});
});