// JavaScript Document
function mouseOver1(a)
{
	if(a==55)
	{
		document.getElementById('yg1').src ="litscloud/web/images/bg_59.jpg"	
	}
	if(a==56)
	{
		document.getElementById('yg2').src ="litscloud/web/images/bg_60.jpg"	
	}
	if(a==57)
	{
		document.getElementById('yg3').src ="litscloud/web/images/bg_61.jpg"	
	}
	if(a==58)
	{
		document.getElementById('yg4').src ="litscloud/web/images/bg_62.jpg"	
	}
	if(a==1)
	{
		document.getElementById('yg8').src ="litscloud/web/images/ly_302.gif"
		document.getElementById('tc1').style.display="block"
	}
	if(a==2)
	{
		document.getElementById('yg9').src ="litscloud/web/images/bg_44.png"
		document.getElementById('tc2').style.display="block"
	}
	if(a==3)
	{
		document.getElementById('yg10').src ="litscloud/web/images/bg_74.png"
		document.getElementById('tc3').style.display="block"
	}
	if(a==4)
	{
		document.getElementById('yg11').src ="litscloud/web/images/bg_75.png"
		document.getElementById('tc4').style.display="block"
	}
	
	
} 

function mouseOut1(a)
{
	
	if(a==59){
		
		document.getElementById('yg1').src ="litscloud/web/images/bg_55.jpg"
	}
	if(a==60){
		
		document.getElementById('yg2').src ="litscloud/web/images/bg_56.jpg"
	}
	if(a==61){
		
		document.getElementById('yg3').src ="litscloud/web/images/bg_57.jpg"
	}
	if(a==62){
		
		document.getElementById('yg4').src ="litscloud/web/images/bg_58.jpg"
	}
	
	if(a==5){
		
		document.getElementById('yg8').src ="litscloud/web/images/ly_32.gif"
		document.getElementById('tc1').style.display="none"
	}
	if(a==6){
		
		document.getElementById('yg9').src ="litscloud/web/images/ly_33.gif"
		document.getElementById('tc2').style.display="none"
	}
	if(a==7){
		
		document.getElementById('yg10').src ="litscloud/web/images/ly_34.gif"
		document.getElementById('tc3').style.display="none"
	}
	if(a==8){
		
		document.getElementById('yg11').src ="litscloud/web/images/ly_35.gif"
		document.getElementById('tc4').style.display="none"
	}
	
}
function wenti()
{
	document.getElementById("ly_wentis").style.display="block";//显示
	document.getElementById("rightDIV").style.display="none";//显示
	
	
	
	}
function wentig()
{
	document.getElementById("ly_wentis").style.display="none";//显示
	document.getElementById("rightDIV").style.display="block";//显示
	
	}	
function lygg()
{
	document.getElementById("ceng1").style.display="block";//显示
	document.getElementById("ceng2").style.display="none";//影藏
	document.getElementById("ceng3").style.display="none";//影藏
	document.getElementById("ceng4").style.display="none";//影藏
	
	}
function rdhd()
{
	document.getElementById("ceng1").style.display="none";//显示
	document.getElementById("ceng2").style.display="block";//影藏
	document.getElementById("ceng3").style.display="none";//影藏
	document.getElementById("ceng4").style.display="none";//影藏
	
	}
function hydt()
{
	document.getElementById("ceng1").style.display="none";//显示
	document.getElementById("ceng2").style.display="none";//影藏
	document.getElementById("ceng3").style.display="block";//影藏
	document.getElementById("ceng4").style.display="none";//影藏
	
	}
function qyxw()
{
	document.getElementById("ceng1").style.display="none";//显示
	document.getElementById("ceng2").style.display="none";//影藏
	document.getElementById("ceng3").style.display="none";//影藏
	document.getElementById("ceng4").style.display="block";//影藏
	
	}
function lygg1(){
      window.location.href="litscloud/web/news.html?flag=1";
   }
   
   function lygg2(){
      window.location.href="litscloud/web/news.html?flag=2";
   }
   
   function lygg3(){
      window.location.href="litscloud/web/news.html?flag=3";
   }
   
   function lygg4(){
      window.location.href="litscloud/web/news.html?flag=4";
   }
   
   
   
   
   function lygga(a){
      window.location.href="litscloud/web/news_vew_v"+a+".html?flag=1";
   }
   
   function rdhdb(b){
      window.location.href="litscloud/web/news_vew_v"+b+".html?flag=2";
   }
   
   function hydtc(c){
      window.location.href="litscloud/web/news_vew_v"+c+".html?flag=3";
   }
   
   function qyxwd(d){
      window.location.href="litscloud/web/news_vew_v"+d+".html?flag=4";
   }
//点击购买
function shopdiv(sgcode){//gen
  //sgcode1='SP-2013020200010';
   alert(111);
   var  url="litscloud/web/litscloudgetprodutCustomerServerC.Action?sgcode="+sgcode+"&tt="+(new Date()).getTime();
    	 $("#jgc").show();	
    	 $("#jgc").load(url);
}
function colsediv(){
	 $("#jgc").hide();	
}