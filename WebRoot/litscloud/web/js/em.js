<script type="text/javascript">
<!--
//Moveobj
function bind(o,ev,fn){
if (document.all)o.attachEvent('on'+ev,fn);
else o.addEventListener(ev,fn,false);
}
function setCookie(name,value,time){
var exp = new Date();
exp.setTime(exp.getTime() + 30*24*60*60*1000);
document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
function getCookie(name){
var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
if(arr=document.cookie.match(reg)) return unescape(arr[2]);
else return null;
}

function Move_autoset1def(moveobj){
var login1tit1 = new Array("0","500","1000","2000");
var bNum1 =5 ,mNum1 =127 , iNum1 = 4 , icolength1 = 6;
//分别 bNum1 起始距离距moveobj内侧左部的长度 ，mNum1 单位长度，iNum1 单位数 0-1-2-3，icolength1 图标距离的1/2。

var eNum = bNum1 + mNum1 * (iNum1-1);
var $D = new Function('str','return document.getElementById(str);');
var $event = new Function('e','return (!e)?window.event:e;');
var checknowleft1 = function(z1){return ((z1<bNum1)?bNum1:((z1>eNum)?eNum:(((z1-bNum1)%mNum1>11)?z1+mNum1-(z1-bNum1)%mNum1:z1-(z1-bNum1)%mNum1)));}
var nowseat1 = 0,drag_=false;
var Move_autoset1 = function(iNum1){
$D(moveobj).getElementsByTagName("div")[0].style.left = iNum1*mNum1+bNum1+"px";
$D("login1-tit1").innerHTML = login1tit1[iNum1];
$D("login1-type1").value = iNum1;//向hidden的login1-type里添加参数值
} 

nowseat1 = (getCookie("nowseat1")==null)?0:getCookie("nowseat1");
Move_autoset1(nowseat1);
$D(moveobj).getElementsByTagName("div")[0].onmouseover = function(){
var x1,y1,z1;
this.onmousedown=function(e1){
drag_=true;
with(this){
var temp0=style.left.replace("px","")*1,temp1=offsetLeft,temp2=offsetTop;
x1=$event(e1).clientx1;
y1=$event(e1).clienty1;
z1=temp0;
document.onmousemove=function(e1){
//this.selection.empty();
if(!drag_)return false;
with(this){
z1 = temp0 + $event(e1).clientx1-x1;
z1 = (z1<bNum1)?bNum1:((z1>eNum)?eNum:z1);
style.left=z1+"px";
}
}
document.onmouseup=function(e1){
drag_ = false;
var nowleft = checknowleft1(z1);
nowseat1 = (nowleft-bNum1)/mNum1;
Move_autoset1(nowseat1);
setCookie('nowseat1',(nowleft-bNum1)/mNum1);
}
}
}
}
$D(moveobj).onmouseover = function(){
this.onmousedown=function(e1){
if(drag_)return false;
with(this){
var icoobj = getElementsByTagName("div")[0];
var temp0 = icoobj.offsetLeft;
var x1=$event(e1).clientx1;
var nowleft = checknowleft1(bNum1+mNum1*nowseat1+(x1-temp0)-icolength1);
document.onmouseup=function(e1){
nowseat1 = (nowleft-bNum1)/mNum1;
Move_autoset1(nowseat1);
setCookie('nowseat1',(nowleft-bNum1)/mNum1);
}
}
}
}
}

bind(window,"load",new Function('Move_autoset1def("moveico1")'));

//-->
</script>