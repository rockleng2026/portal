<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<DIV id=xixi onmouseover=toBig() onmouseout=toSmall() style="z-index: 9999">
<TABLE style="FLOAT: left" border=0 cellSpacing=0 cellPadding=0 width=157>
  <TBODY>
  <TR>
    <TD class=main_head height=39 vAlign=top>&nbsp;</TD></TR>
  <TR>
    <TD class=info vAlign=top>
      <TABLE class=qqtable border=0 cellSpacing=0 cellPadding=0 width=120 
      align=center>
        <TBODY>
        <TR>
          <TD height=5></TD></TR>
        <TR>
          <TD height=35 align=middle><a target=blank href=""><img border="0" SRC=http://wpa.qq.com/pa?p=1:419728285:12 alt="点击这里给我发消息"></a></TD></TR>
        <TR>
          <TD height=35 align=middle><a target=blank href=""><img border="0" SRC=http://wpa.qq.com/pa?p=1:1156588509:12 alt="点击这里给我发消息"></a></TD></TR>
          <TR>
          <TD height=35 align=middle><a target=blank href=""><img border="0" SRC=http://wpa.qq.com/pa?p=1:1156588509:12 alt="点击这里给我发消息"></a></TD></TR>
          <TR>
          <TD height=35 align=middle><a target=blank href=""><img border="0" SRC=http://wpa.qq.com/pa?p=1:1156588509:12 alt="点击这里给我发消息"></a></TD></TR>
        <TR>
          <TD height=5></TD></TR>
        <TR>
          <TD align=middle>&nbsp;</TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD class=down_kefu vAlign=top><img src="<%=path %>/images/kfimages/img3-5_5.gif" border="0" /></TD></TR></TBODY></TABLE>
<DIV class="Obtn"></DIV></DIV>
<SCRIPT language=javascript>
		fakf=function (id,_top,_left){
		var me=id.charAt?document.getElementById(id):id, d1=document.body, d2=document.documentElement;
		d1.style.height=d2.style.height='100%';me.style.top=_top?_top+'px':0;me.style.left=_left+"px";//[(_left>0?'left':'left')]=_left?Math.abs(_left)+'px':0;
		me.style.position='absolute';
		setInterval(function (){me.style.top=parseInt(me.style.top)+(Math.max(d1.scrollTop,d2.scrollTop)+_top-parseInt(me.style.top))*0.1+'px';},10+parseInt(Math.random()*20));
		return arguments.callee;
		};
		window.onload=function (){
		fakf
		('xixi',100,-152)
		}
	</SCRIPT>

<SCRIPT language=javascript>
			lastScrollY=0; 
			var InterTime = 1;
			var maxWidth=-1;
			var minWidth=-152;
			var numInter = 8;
			
			var BigInter ;
			var SmallInter ;
			
			var o =  document.getElementById("xixi");
				var i = parseInt(o.style.left);
				function Big()
				{
					if(parseInt(o.style.left)<maxWidth)
					{
						i = parseInt(o.style.left);
						i += numInter;	
						o.style.left=i+"px";	
						if(i==maxWidth)
							clearInterval(BigInter);
					}
				}
				function toBig()
				{
					//alert("1");
					clearInterval(SmallInter);
					clearInterval(BigInter);
					BigInter = setInterval(Big,InterTime);
				}
				function Small()
				{
					
					if(parseInt(o.style.left)>minWidth)
					{
						i = parseInt(o.style.left);
						i -= numInter;
						o.style.left=i+"px";
						
						if(i==minWidth)
							clearInterval(SmallInter);
					}
				}
				function toSmall()
				{
					//alert("2");
					clearInterval(SmallInter);
					clearInterval(BigInter);
					SmallInter = setInterval(Small,InterTime);
					
				}
</SCRIPT>