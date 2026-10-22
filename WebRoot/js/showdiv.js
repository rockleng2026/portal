
function init(){
 document.onmousemove = mouseMove;
}
var mouseleft = 500;
var mousetop = 500;

function mouseMove(e){
  if(!document.all){
  
   mouseleft=e.pageX;
   mousetop=e.pageY;
  }else{
   mouseleft=document.body.scrollLeft+event.clientX;
   mousetop=document.body.scrollTop+event.clientY;
  }
 
} 
function showDiv(div_id,mdivid) {
    var div_obj = $("#"+div_id);  
    var windowWidth = document.body.clientWidth;      
    var windowHeight = document.body.clientHeight;      
    var popupHeight = div_obj.height();      
    var popupWidth = div_obj.width();
	 $("#"+mdivid).css({"opacity":"0.6","display":"block","position": "absolute","background-color":"#fff"})
	    .width(420)  
	    .height(windowHeight * 0.2)
	    .click(function() {hideDiv(div_id); })
	    .fadeIn(100);
	 div_obj.css({"position": "absolute"})  
	   .animate({left: 300, top: 50, opacity: "show" }, "fast");
    
	}  
	 
	function hideDiv(div_id,mdivid) {  
	    $("#"+mdivid).css({"display":"none"});  
	    $("#" + div_id).animate({left: 0, top: 0, opacity: "hide" }, "slow");  
	}
init();
