<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<title>进销存管理系统</title>
		<script>
<!-- Beginning of JavaScript Applet -------------------
function scrollit_r2l(seed)
{ var m1  = "欢迎使用SKYWOLKER软件" ;
       var msg=m1+m2;
       var out = " "; 
       var c = 1; 
 var speed  = 120;
if (seed > 100)
{                seed-=2;
                var cmd="scrollit_r2l(" + seed + ")";   
             timerTwo=window.setTimeout(cmd,speed);}     
    else if (seed <= 100 && seed > 0)
     {                for (c=0 ; c < seed ; c++)
                      {       out+=" ";}   
       out+=msg;         seed-=2;      
   var cmd="scrollit_r2l(" + seed + ")";      
   window.status=out;         
 timerTwo=window.setTimeout(cmd,speed); }        
      else if (seed <= 0) 
{                if (-seed < msg.length) 
                  { 
                       out+=msg.substring(-seed,msg.length);        
                       seed-=2;                        
                       var cmd="scrollit_r2l(" + seed + ")";         
                       window.status=out;                     
       timerTwo=window.setTimeout(cmd,speed);}
       else {               window.status=" ";       
                 timerTwo=window.setTimeout("scrollit_r2l(100)",speed);
}
}
}
scrollit_r2l(100);
// -- End of JavaScript code -->
</script>


	</head>
	<FRAMESET border=0 frameSpacing=0 rows=70,*,32 frameBorder=no cols=*>
		<FRAME id=topFrame title=topFrame name=topFrame src="Main/top.jsp"
			noResize scrolling=no>
		<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=no cols=177,*>
			<FRAME name=left src="Main/menu.jsp" noResize scrolling=yes>
			<FRAME id='right' name=right src="Main/desk.jsp" noResize scrolling=yes>
		</FRAMESET>
		<FRAME id=bottomFrame title=bottomFrame name=bottomFrame
			src="Main/bottom.jsp" noResize scrolling=no>
	</FRAMESET>
	<noframes></noframes>
	
</HTML>