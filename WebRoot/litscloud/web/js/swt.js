// JavaScript Document
lastScrollY=0; 
function  heartBeat(){ 
var diffY; 
if (document.documentElement && document.documentElement.scrollTop) 
diffY = document.documentElement.scrollTop; 
else if (document.body) 
diffY = document.body.scrollTop 
else 
    {/*Netscape   stuff*/} 

//alert(diffY); 
percent=.1*(diffY-lastScrollY); 
if(percent>0)percent=Math.ceil(percent); 
else percent=Math.floor(percent); 
document.getElementById("leftDIV").style.top=parseInt(document.getElementById("leftDIV").style.top)+percent+"px";
document.getElementById("rightDIV").style.top=parseInt(document.getElementById("leftDIV").style.top)+percent+"px";

lastScrollY=lastScrollY+percent;
//alert(lastScrollY);
}

sidebar1= "<div id=leftDIV style='left:0px; PosITION:absolute; TOP:370px;'></div>" 
sidebar2= "<div id=rightDIV style='left:0px; PosITION:absolute; TOP:370px;'><a href='#'><img src=./images/ly_28.png width=247 height=246  id=EccoolAD onclick=wenti()></a></div>"







document.write(sidebar1); 
document.write(sidebar2); 

//ɾ󣬶Ļƶ
window.setInterval("heartBeat()",1); 
//-->









