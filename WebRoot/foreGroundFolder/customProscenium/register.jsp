<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String name = request.getSession().getServletContext().getRealPath("/");	//tomcat   项目路径
		String objectname = "";
		int webapps = name.indexOf("webapps");
		int htdocs = name.indexOf("htdocs");
		if(webapps>0)
		{
			objectname = name.substring(webapps+8, name.length()-1);
		}
		if(htdocs>0)
		{
			objectname = name.substring(htdocs+7, name.length()-1);
		}
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<!-- saved from url=(0033)http://www.ebadu.com/user/reg.asp -->
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE>客户注册</TITLE>
		<LINK rel=stylesheet type=text/css href="subnote_files/reg.css">
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		 <script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript" src="/<%=objectname %>/js/customerRegister.js"></script>
		<SCRIPT language=javascript>
		/*是否为数字、字母或下划线*/   
   function isNLU(ui){    
      var valid=/^\w+$/; 
      return(valid.test(ui)) 
   } 
   function reg(){
       	
		var user_name=document.getElementById('customerName').value;
		user_name=user_name.replace(/\s+/g,"");
		if(user_name==""){
		  uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请正确填写用户名称！';
		   return false;
		}
	   else if(!isNaN(user_name)){
			//alert('用户名不能全部是数字！');
			 uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名不能全部是数字！';
			return false;
		}
	   else if(!isNLU(user_name)){
				uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>只能是英文或是和数字组合！';
				return false;
		}
	   else if(user_name.length<6 || user_name.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名长度必须为6 - 16位！';
			return false;
	   }
		else{
			 var url = "checkFiledCustomerServer.Action";
			   $.post(url,{user_name:user_name},function(data){
			   	if(data=="0")
			   	{
			   		uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名已存在！';
			   		return false;
			   	}
			   	else
			   	{
			   		$("#tidd").attr("value","1");
			   		uname.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			   		return true;
			   	}	
			   });
		}
	}

function regpwd(){
		var user_pwd=document.getElementById('customerPassword').value;		
		user_pwd=user_pwd.replace(/\s+/g,"");
		if(user_pwd==""){
			pwd.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
			return false;		
		
		}
	    else if(user_pwd.length<6 || user_pwd.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			pwd.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码长度必须为6 - 16位！';
			return false;
	   }
	   else{
			pwd.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;

}
////////////////////////
function regpwd2(){
		var user_pwd=document.getElementById('user_pwd2').value;	
		var user_pwdup=document.getElementById('customerPassword').value;
		user_pwdup=user_pwdup.replace(/\s+/g,"");
		user_pwd=user_pwd.replace(/\s+/g,"");
		if(user_pwdup==""){
			pwd2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
			return false;		
		
		}
	    else if(user_pwdup!=user_pwd){
			pwd2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
			return false;
	   }
	   else{
			pwd2.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;

}
///////////////////////

function regmail(){
		var user_mail=document.getElementById('email').value;	
		user_mail=user_mail.replace(/\s+/g,"");
		if(user_mail==""){
			mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的邮箱！';
			return false;			
		}
		else if((user_mail.indexOf("@")<0)||(user_mail.indexOf(":")!=-1)){
			mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱格式不正确！';
			return false;		
		
		}
	   else{
		   var url = "checkFiledCustomerServer.Action";
		    $.post(url,{email:user_mail},function(data){
		   	if(data=="0")
		   	{
		   		mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱已被注册！';
		   		return false;
		   	}
		   	else
		   	{
		   		$("#tiemail").attr("value","1");	
		   		mail.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
		   		return true;
		   	}
			});
		   
	   }

}
///////////////////////
function isChellonese(temp){ 
　　var re=/[^\u4e00-\u9fa5]/; 
　　if(re.test(temp)) return false; 
　　return true; 
} 
function regzsname(){
		var user_zsname=document.getElementById('realName').value;	
		user_zsname=user_zsname.replace(/\s+/g,"");
		if(user_zsname==""){
			zsname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的姓名！';
			return false;			
		}
		else if(!isChellonese(user_zsname)){
			zsname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>真实姓名只能为中文且不能含有空格！';
			return false;		
		
		}

	   else{
			zsname.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;

}
///////////////////////    
function regtel(){
       
		var user_tel=document.getElementById('phone').value;	
		   var flag = false;   
		   var reg0 =  /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;   //判断 固话   
		   var reg1 =/^((\(\d{2,3}\))|(\d{3}\-))?(13|15|18)\d{9}$/;                     //判断 手机   
		   if (reg0.test(user_tel)) flag=true;    
		   if (reg1.test(user_tel)) flag=true;   
		   //alert(reg0.test(user_tel)+reg1.test(user_tel));
		if(user_tel==""){
			tel.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的电话号码！';
			return false;			
		} 
		else if(reg0.test(user_tel)==0){
			tel.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的电话号码格式不正确！';
			return false;		
		}
		else{
			tel.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
	   
		return true;

}

///////////////////////    
function regsj(){
       
		var user_sj=document.getElementById('mobilePhone').value;	
		   var flag = false;   
		   var reg1 =/^((\(\d{2,3}\))|(\d{3}\-))?(13|15|18)|(14)\d{9}$/;                     //判断 手机   
		   if (reg1.test(user_sj)) flag=true;   
		   //alert(reg0.test(user_tel)+reg1.test(user_tel));
		if(user_sj==""){
			sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的手机号码！';
			return false;			
		} 
		else if(reg1.test(user_sj)==0){
			sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的手机号码格式不正确！';
			return false;		
		}
		else{
			var url = "checkFiledCustomerServer.Action";
		  	 $.post(url,{user_tel:user_sj},function(data){
		   		if(data=="0")
		   		{
		   			sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>手机已被存在';
		   			return false;
		   		}
		   		else
		   		{
		   			$("#tisj").attr("value","1");
		   			sj.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
		   			return true;
		   		}
		   });
	   }
	   

}
///////////////////////

function regqq(){
       
		var user_qq=document.getElementById('qq').value;	
		
		if(user_qq==""){
			qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的QQ号码！';
			return false;			
		} 
		else if(isNaN(user_qq) || user_qq.length<4 || user_qq.length>12){
			qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的QQ号码格式不正确！';
			return false;		
		}		
		else{
			 var url = "checkFiledCustomerServer.Action";
			   $.post(url,{user_qq:user_qq},function(data){
			   		if(data=="0")
			   		{
			   			qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>QQ已被注册';
			   			return false;
			   		}
			   		else
			   		{
			   			$("#tiqq").attr("value","1");
			   			qq.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			   			return true;
			   		}
			   });
	   }
	   

}
///////////////////////
function regaderr(){
       
	var user_adrrew=document.getElementById('customerAddress').value;	
		
		if(user_adrrew==""){
			adrrew.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的通讯地址！';
			return false;			
		} 
		else if(!isNaN(user_adrrew)){
			adrrew.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的地址无效！';
			return false;		
		}		
		else{
			adrrew.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
	   
		return true;

}
///////////////////////
function regsfz(){
	var user_sfz=document.getElementById('cardid').value;	
	if(user_sfz=="")
	{
			sfz.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的身份证号码！';
		   return false;
	}
	else if(isIdCardNo(user_sfz)!=true){
			sfz.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您的身份证号码有误！';
		   return false;
	}
	else{
		    sfz.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	}
	return true;
} 

///////////////////////
function regcode(){
	var user_code=document.getElementById('user_code').value;	
	//alert(user_code)
	if(user_code=="")
	{
			code2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入验证码！';
		   return false;
	}
	else if(isNaN(user_code)){
			code2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>验证码只能是数字！';
		   return false;
	
	}
	else{
			getwebselect3();
		    code2.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	}
	return true;
} 



/////////////////////

function onfuos(id){
	if(id=="customerName"){
		uname.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />6-16个字符，允许字母或和数字、下划线组合，不区分大小写!'
	}
   if(id=="customerPassword"){
		pwd.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />用户登录时所用密码,6-16个字符，不能含有空格，密码区分大小写！'
	}
   if(id=="email"){
		mail.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />安全邮箱是<font color=red>找回密码</font>的重要途径，建议您填写常用邮箱!'
	}
   if(id=="realName"){
		zsname.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />填写您的真实姓名！'
	}
   if(id=="phone"){
		tel.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写固定电话号码，格式为0551-4202205！'
	}
   if(id=="mobilePhone"){
		sj.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用手机号码！'
	}
   if(id=="qq"){
		qq.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用的号码！'
	}
   if(id=="customerAddress"){
		adrrew.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写正常的通讯地址！'
	}
   if(id=="cardid"){
		sfz.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />请填写您有效的身份证号码！'
	}
}

//密码函数
//CharMode函数  
//测试某个字符是属于哪一类.  
function CharMode(iN){  
if (iN>=48 && iN <=57) //数字  
return 1;  
if (iN>=65 && iN <=90) //大写字母  
return 2;  
if (iN>=97 && iN <=122) //小写  
return 4;  
else  
return 8; //特殊字符  
}  

//bitTotal函数  
//计算出当前密码当中一共有多少种模式  
function bitTotal(num){  
modes=0;  
for (i=0;i<4;i++){  
if (num & 1) modes++;  
num>>>=1;  
}  
return modes;  
}  

//checkStrong函数  
//返回密码的强度级别  




function checkStrong(sPW){  
if (sPW.length<=4)  
return 0; //密码太短  
Modes=0;  
for (i=0;i<sPW.length;i++){  
//测试每一个字符的类别并统计一共有多少种模式.  
Modes|=CharMode(sPW.charCodeAt(i));  
}  

return bitTotal(Modes);  

}  

//pwStrength函数  
//当用户放开键盘或密码输入框失去焦点时,根据不同的级别显示不同的颜色  

function pwStrength(pwd){  
O_color="#eeeeee";  
L_color="#FF0000";  
M_color="#FF9900";  
H_color="#33CC00";  
if (pwd==null||pwd==''){  
Lcolor=Mcolor=Hcolor=O_color; 
text.innerHTML="";  
}  
else{  
S_level=checkStrong(pwd);  
switch(S_level) {  
case 0:  
Lcolor=Mcolor=Hcolor=O_color;  
document.getElementById("text").style.color=L_color; 
case 1:  
Lcolor=L_color; 
Mcolor=Hcolor=O_color;  
text.innerHTML="较弱";  
break;  
case 2:  
Lcolor=Mcolor=M_color;  
Hcolor=O_color; 
strength_L.innerHTML="";
text.innerHTML="中等";  
document.getElementById("text").style.color=M_color;    
break;  
default:  
Lcolor=Mcolor=Hcolor=H_color;  
strength_M.innerHTML="";  
text.innerHTML="很强"; 
document.getElementById("text").style.color=H_color;  
}  
}  




document.getElementById("strength_L").style.background=Lcolor;  
document.getElementById("strength_M").style.background=Mcolor;  
document.getElementById("strength_H").style.background=Hcolor;  
return;  
} 

function regs(){
    //alert("dddd");
	tidd=document.getElementById("tidd").value;
	tidd2=document.getElementById("tidd2").value;
	tiemail=document.getElementById("tiemail").value;
	tisj=document.getElementById("tisj").value;
	tiqq=document.getElementById("tiqq").value;
	//codeid=document.getElementById('codeid').value=content;
	//alert(tidd)
	//alert(tidd);
	//alert(tidd2);
	if(tidd=="1"&&regpwd()&&regpwd2()&&tiemail=="1"&&tisj=="1"&&tiqq=="1"&&regcode()){
		return true;
	}
	else
	{
			return false;
	}
}

</SCRIPT>

		<SCRIPT type=text/javascript>
   function code(){
   		document.form1.img.src="../Include/Getcode.asp?"+Math.random();
   }
   function returndetermine()
   {
   		var authorization=document.getElementById("authorization").value;
   		if(authorization==""||authorization==null)
   		{
   			document.getElementById("authorization1").innerHTML="请输入授权码！！！";
   			
   		}
   }
</SCRIPT>

		<STYLE type=text/css>
.color {
	COLOR: #ff0033
}

A:link {
	COLOR: #ff9900;
	TEXT-DECORATION: none
}

A:visited {
	COLOR: #ff9900;
	TEXT-DECORATION: none
}

A:hover {
	COLOR: #3399cc;
	TEXT-DECORATION: underline
}

A:active {
	COLOR: #3399cc;
	TEXT-DECORATION: none
}

.button {
	BACKGROUND-IMAGE: url(<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/17.gif);
	BORDER-BOTTOM-STYLE: none;
	BORDER-RIGHT-STYLE: none;
	WIDTH: 55px;
	BORDER-TOP-STYLE: none;
	HEIGHT: 26px;
	BORDER-LEFT-STYLE: none
}

BODY {
	MARGIN-BOTTOM: 0px;
	MARGIN-LEFT: 0px;
	MARGIN-RIGHT: 0px
}
</STYLE>

		<META name=GENERATOR content="MSHTML 8.00.6001.19154">
	</HEAD>
	<BODY bgcolor="gray">
		<LINK rel="shortcut icon" href="ico/ebadu.ico">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel=stylesheet type=text/css href="subnote_files/nav06.css">
		<!--幻灯片+导航代码 -->
		<LINK rel=stylesheet type=text/css href="subnote_files/base.css">
		<TABLE border=0 cellSpacing=0 cellPadding=0 width=973 align=center
			height=50>
			<TBODY>
				<TR>
					<TD vAlign=top width=552 align=left>
					</TD>
					<TD class=top_rk width=421 align=middle>
						<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%"
							align=right>
							<TBODY>
								<TR>
									<TD vAlign=center align=right>
										<!--<a href="zc.asp"><img src="images/zhuce.png" width="34" height="17" border="0" align="absmiddle" /></a>-->
										<!--&nbsp;<a href="../OldWeb/User/" target="_blank"></a>-->
										<TABLE border=0 cellSpacing=0 cellPadding=0 width="96%"
											height=34>
											<TBODY>
												<TR>
													<TD vAlign=center width="20%" align=middle>
														<A
															href="<%=path%>/foreGroundFolder/customProscenium/login.jsp"><IMG
																border=0 vspace=2 src="subnote_files/dl01.gif" width=64
																height=20>
														</A>
													</TD>
													<TD vAlign=center width="20%" align=middle>
														<A
															href="<%=path%>/foreGroundFolder/customProscenium/register.jsp"><IMG
																border=0 vspace=2 align=middle
																src="subnote_files/dl02.gif" width=64 height=20>
														</A>
													</TD>
													<TD vAlign=center width="60%" align=middle>
														<A class=top_font href="#">全国服务器供应商前十强</A>
													</TD>
												</TR>
											</TBODY>
										</TABLE>
									</TD>
								</TR>
								<TR>
									<TD colSpan=5>
										<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%"></TABLE>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<DIV align=center>
			<!--
<DIV id=idContainer2 class=container align=center> 
<TABLE id=idSlider2 border=0 cellSpacing=0 cellPadding=0 width=973 
  align=center><TBODY>
  <TR>
    <TD class=td_f><IMG src="subnote_files/201108.jpg" width=973 height=302></TD>
    <TD class=td_f><IMG src="subnote_files/YS01.jpg" width=973 height=302></TD>
    <TD class=td_f><IMG src="subnote_files/YS02.jpg" width=973 height=302></TD>
    <TD class=td_f><IMG src="subnote_files/YS.jpg" width=973 
  height=302></TD></TR></TBODY></TABLE> 
<UL id=idNum class=num></UL></DIV>-->
			<STYLE type=text/css>
.container {
	WIDTH: 973px;
	HEIGHT: 302px
}

.container A IMG {
	WIDTH: 973px;
	HEIGHT: 302px
}

.container IMG {
	BORDER-BOTTOM-STYLE: none;
	BORDER-RIGHT-STYLE: none;
	BORDER-TOP-STYLE: none;
	BORDER-LEFT-STYLE: none
}

.td_f A IMG {
	PADDING-BOTTOM: 0px;
	MARGIN: 0px;
	PADDING-LEFT: 0px;
	PADDING-RIGHT: 0px;
	PADDING-TOP: 0px
}

.num {
	POSITION: absolute;
	WIDTH: 90px;
	FLOAT: right;
	TOP: 270px;
	LEFT: 850px
}

.num LI {
	BACKGROUND-IMAGE:
		url(http://www.ebadu.com/user/images/flash/flashbutton.gif);
	TEXT-ALIGN: center;
	LINE-HEIGHT: 15px;
	LIST-STYLE-TYPE: none;
	MARGIN: 1px;
	WIDTH: 15px;
	BACKGROUND-REPEAT: no-repeat;
	FONT-FAMILY: Arial;
	BACKGROUND-POSITION: -15px 0px;
	FLOAT: left;
	HEIGHT: 15px;
	COLOR: #86a2b8;
	FONT-SIZE: 12px;
	CURSOR: pointer
}

.num LI.on {
	LINE-HEIGHT: 15px;
	WIDTH: 15px;
	BACKGROUND: url(http://www.ebadu.com/user/images/flash/flashbutton.gif)
		no-repeat;
	HEIGHT: 15px;
	COLOR: #ffffff
}
</STYLE>
		</DIV>
		<SCRIPT type=text/javascript src="subnote_files/jquery-1.4a2.min.js"></SCRIPT>
		<SCRIPT type=text/javascript src="subnote_files/global__3132109.js"></SCRIPT>
		<A name=reg></A>
		<TABLE class=register border=0 cellSpacing=0 cellPadding=0 width=973
			align=center height=111>
			<TBODY>
				<TR>
					<TD height=35 vAlign=top>
						<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD class=title height=35 align=left>
										注册通行证
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD class=content vAlign=top>
						<FORM id=form1  method=post name="form1"
							action="customerRegister1CustReg.Action">
							<s:token name="register"></s:token>
							<TABLE class=reg-table border=0 cellSpacing=0 width=782
								align=right>
								<TBODY>
									<TR>
										<TD class=reg-item width=112 align=right>
											<SPAN class=color>*</SPAN> 用户名称：
										</TD>
										<TD vAlign=center width=250 align=left>
											<INPUT onblur=reg() style="WIDTH: 240px" id=customerName
												class=input_out onfocus="onfuos('customerName')"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" maxLength=10
												type=text name=customerName>
											<LABEL>
												<INPUT id=tidd type=hidden name=tidd value="">
											</LABEL>
											<LABEL></LABEL>
										</TD>
										<TD vAlign=center width=414 align=left>
											<SPAN id=uname></SPAN>
										</TD>
									</TR>
									<TR>
										<TD class="reg-item top" align=right>
											<SPAN class=color>*</SPAN> 用户密码：
										</TD>
										<TD align=left>
											<INPUT onblur=regpwd() style="WIDTH: 240px"
												id=customerPassword class=input_out
												onfocus="onfuos('customerPassword')"
												onmousemove="this.className='input_move'"
												onkeyup=pwStrength(this.value)
												onmouseout="this.className='input_out'" maxLength=15
												type=password name=customerPassword>
										</TD>
										<TD align=left>
											<SPAN id=pwd></SPAN>
										</TD>
									</TR>
									<TR>
										<TD class="reg-item top" align=right>
											&nbsp;
										</TD>
										<TD colSpan=2 align=left>
											<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%"
												height=22>
												<TBODY>
													<TR>
														<TD width="12%" align=left>
															密码强度：
														</TD>
														<TD width="88%" align=left>
															<TABLE style="DISPLAY: inline" border=0 cellSpacing=0
																cellPadding=1 width=120 height=2>
																<TBODY>
																	<TR align=middle bgColor=#eeeeee>
																		<TD id=strength_L bgColor=#eeeeee width="25%"></TD>
																		<TD id=strength_M bgColor=#eeeeee width="29%"></TD>
																		<TD id=strength_H bgColor=#eeeeee width="32%"></TD>
																	</TR>
																</TBODY>
															</TABLE>
															<SPAN style="MARGIN-LEFT: 5px" id=text></SPAN>
														</TD>
													</TR>
												</TBODY>
											</TABLE>
										</TD>
									</TR>
									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN> 确定密码：
										</TD>
										<TD align=left>
											<INPUT onblur=regpwd2() style="WIDTH: 240px" id=user_pwd2
												class=input_out onfocus=""
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=password
												name=user_pwd2>
										</TD>
										<TD align=left>
											<SPAN id=pwd2></SPAN>
										</TD>
									</TR>
									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN> 电子邮件：
										</TD>
										<TD align=left>
											<INPUT onblur=regmail() style="WIDTH: 240px" id=email
												class=input_out onfocus="onfuos('email')"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=text name=email>
											<INPUT id=tiemail type=hidden name=tiemail value="">
										</TD>
										<TD align=left>
											<SPAN id=mail></SPAN>
										</TD>
									</TR>


									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN> 手 &nbsp;&nbsp;&nbsp;机：
										</TD>
										<TD align=left>
											<INPUT onblur=regsj() style="WIDTH: 240px" id=mobilePhone
												class=input_out onfocus="onfuos('mobilePhone')"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=text
												name=mobilePhone>
											<INPUT id=tisj type=hidden name=tisj value="">
										</TD>
										<TD align=left>
											<SPAN id=sj></SPAN>
										</TD>
									</TR>
									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN> QQ 号 码：
										</TD>
										<TD align=left>
											<INPUT onblur=regqq() style="WIDTH: 240px" id=qq
												class=input_out onfocus="onfuos('qq')"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=text name=qq>
											<INPUT id=tiqq type=hidden name=tiqq value="">
										</TD>
										<TD align=left>
											<SPAN id=qq></SPAN>
										</TD>
									</TR>
									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN>  授 权 码：
										</TD>
										<TD align=left>
											<input id="authorization" name="authorization" onblur="returndetermine()" type="text"/>
										</TD>
										<TD align=left>
											<SPAN id=authorization1 name="authorization1">5~~8为字符（用于验证客户是否授权给内部人员。比如:填写订单）</SPAN>
										</TD>
									</TR>
									<TR>
										<TD class=reg-item align=right>
											<SPAN class=color>*</SPAN> 验 证 码：
										</TD>
										<TD class=validatetd align=left>
											<input type="text" id="user_code" name="user_code"
												class="input_out" onMouseMove="this.className='input_move'"
												onMouseOut="this.className='input_out'" />
											<LABEL>
												<LABEL>
													<INPUT id=tidd2 type=hidden name=tidd2>
												</LABEL>
											</LABEL>
											<%
												String imgpath = request.getProtocol().substring(0, 4)
														.toLowerCase()
														+ "://"
														+ request.getServerName()
														+ ":"
														+ request.getServerPort();
											%>
											<IMG
												SRC="<%=imgpath%><%=request.getContextPath()%>/servlet/Img">
										</TD>
										<TD class=validatetd align=left>

											<SPAN id=code2></SPAN>
										</TD>
									</TR>
									<TR>
										<TD align=right>
											<SPAN class=reg-item>调 &nbsp;&nbsp;&nbsp;查</SPAN>：
										</TD>
										<TD height=25 colSpan=2 align=left>
											<SELECT id=user_from name=user_from>
												<OPTION selected value="">
													您是从何处得知本站
												</OPTION>
												<OPTION value=百度>
													百度
												</OPTION>
												<OPTION value=Google>
													Google
												</OPTION>
												<OPTION value=Soso>
													Soso
												</OPTION>
												<OPTION value=草根站长>
													草根站长
												</OPTION>
												<OPTION value=虚拟主机评测网>
													虚拟主机评测网
												</OPTION>
												<OPTION value=锋网源码>
													锋网源码
												</OPTION>
												<OPTION value=非凡软件站>
													非凡软件站
												</OPTION>
												<OPTION value=天空软件站>
													天空软件站
												</OPTION>
												<OPTION value=创意素材库>
													创意素材库
												</OPTION>
												<OPTION value=驱动中国>
													驱动中国
												</OPTION>
												<OPTION value=数码资源网>
													数码资源网
												</OPTION>
												<OPTION value=模板天下>
													模板天下
												</OPTION>
												<OPTION value=站酷>
													站酷
												</OPTION>
												<OPTION value=华军软件园>
													华军软件园
												</OPTION>
												<OPTION value=壹聚教程>
													壹聚教程
												</OPTION>
												<OPTION value=站长下载>
													站长下载
												</OPTION>
												<OPTION value=源码站>
													源码站
												</OPTION>
												<OPTION value=下载站>
													下载站
												</OPTION>
												<OPTION value=论坛>
													论坛
												</OPTION>
												<OPTION value=朋友介绍>
													朋友介绍
												</OPTION>
												<OPTION value=其他>
													其他
												</OPTION>
											</SELECT>
											<INPUT
												onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
												style="WIDTH: 240px" id=user_from2 class=input_out
												onfocus="this.className='input_on';this.onmouseout=''"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=text
												name=user_from2>
										</TD>
									</TR>
									<TR>
										<TD align=right>
											<SPAN class=reg-item>备注说明</SPAN>：
										</TD>
										<TD height=25 colSpan=2 align=left>
											<INPUT
												onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
												style="WIDTH: 240px" id=user_notes class=input_out
												onfocus="this.className='input_on';this.onmouseout=''"
												onmousemove="this.className='input_move'"
												onmouseout="this.className='input_out'" type=text
												name=user_notes>
										</TD>
									</TR>
									<TR>
										<TD align=right></TD>
										<TD colSpan=2 align=left>
											<LABEL>
												<INPUT class=button value="提 交" type="submit" name=Submit>
											</LABEL>
											<INPUT class=button
												onclick=javascript:location.href=location.href value="重 置"
												type=reset name=Submit2>
											
											<LABEL></LABEL>
										</TD>
									</TR>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
									<tr>
										<td colspan="3">
											&nbsp;
										</td>
									</tr>
								</TBODY>
							</TABLE>
						</FORM>
					</TD>
				</TR>
				<TR>
					<TD class=content vAlign=top>
						<IMG src="subnote_files/login_bg2.jpg" width=973 height=10>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<NOSCRIPT>
			<DIV style="DISPLAY: inline">
				<IMG
					style="BORDER-BOTTOM-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; BORDER-LEFT-STYLE: none"
					alt="" src="subnote_files/1019822948.gif" width=1 height=1>
			</DIV>
		</NOSCRIPT>
	<TABLE border=0 cellSpacing=0 cellPadding=0 width="50%" align=center>
			<TBODY>
				<TR>
					<TD height=7></TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width=973 align=center
			height=61>
			<TBODY>
				<TR>
					<TD class=b_hzhb vAlign=center width=10 align=middle>
						<TABLE border=0 cellSpacing=0 cellPadding=0 height=52>
							<TBODY>
								<TR>
									<TD vAlign=center align=middle>
										<A href="http://www.chinatelecom.com.cn/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/01.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.chinamobile.com/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/02.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.cnc.com.cn/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/03.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.xinnet.cn/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/04.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.dns.com.cn/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/05.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.onlinedown.net/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/06.png" width=78
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.cnnic.net.cn/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/07.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.99bill.com/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/08.png" width=69
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.alipay.com/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/09.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.tenpay.com/" target=_blank><IMG
												class=b_bk border=0 src="subnote_files/10.png" width=88
												height=31>
										</A>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="50%" align=center>
			<TBODY>
				<TR>
					<TD height=7></TD>
				</TR>
			</TBODY>
		</TABLE>
		<TABLE border=0 cellSpacing=0 cellPadding=0 align=center>
			<TBODY>
				<!-- 
				<TR>
					<TD colSpan=7>
						<IMG src="subnote_files/help_top.png" width=973 height=11>
					</TD>
				</TR>
				<TR>
					<TD>
						<A href="http://www.ebadu.com/user/about_client.asp" target=_blank><IMG
								border=0 src="subnote_files/help01_01.gif">
						</A>
					</TD>
					<TD>
						<A href="http://www.ebadu.com/user/about_zffs.asp"><IMG
								border=0 src="subnote_files/help01_02.gif">
						</A>
					</TD>
					<TD>
						<A href="http://www.ebadu.com/user/help.asp"><IMG border=0
								src="subnote_files/help01_03.gif">
						</A>
					</TD>
					<TD>
						<A href="http://www.ebadu.com/user/dl.asp"><IMG border=0
								src="subnote_files/help01_04.gif">
						</A>
					</TD>
					<TD>
						<A href="http://www.ebadu.com/user/xffw.asp"><IMG border=0
								src="subnote_files/help01_05.gif">
						</A>
					</TD>
					<TD>
						<A href="http://www.ebadu.com/Manager/Subnote.asp"><IMG
								border=0 src="subnote_files/help01_06.gif">
						</A>
					</TD>
				</TR>
				<TR>
					<TD colSpan=6>
						<IMG src="subnote_files/help_bottom.png" width=973 height=14>
					</TD>
				</TR>
				 -->
			</TBODY>
		</TABLE>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="50%" align=center>
			<TBODY>
				<TR>
					<TD height=8></TD>
				</TR>
			</TBODY>
		</TABLE>
		<div id="Footer" align="center">
			<div class="FooterL"></div>
			<div class="FooterM">
				<div class="FooterMenu">
					<span class="Green">友情合作:</span><a href="http://www.yx30.com"
						target="_blank">游戏山林</a>|
					<a href="http://www.bz169.com" target="_blank">山东联通 </a>|
					<a href="http://www.cngidc.com/100m/" target="_blank">百独服务器租用</a>|
					<a href="http://ehd.fuaotech.com/live.html" target="_blank">网络高清直播</a>
					<a href="http://www.fuaotech.com/aboutparnter.html">投资合作 </a>|
					<a href="http://www.fuaotech.com/aboutjob.html">正在招聘 </a>|
					<a href="http://www.fuaotech.com/aboutconnectus.html">联系福奥 </a>|
					<br />
					&nbsp;&nbsp;&nbsp;&nbsp;2008-2011 FUAO INC.&nbsp;&nbsp; ALL RIGHTS
					RESERVED. &nbsp;&nbsp; 粤ICP备05004695号
					<span class="Green">深圳公司:0755-33666800 深圳·宝安中心区F518时尚创意园
						F7-201<br /> 山东公司:0755-33666800 山东·滨州国际大厦4层<br /> 北京公司:
						010-82517828 北京·中关村硅谷电脑城 </span>
				</div>
			</div>
			<div class="FooterR"></div>
		</div>
		<!-- 左边客服 -->
		<!--
		<SCRIPT type=text
		/javascript src="subnote_files/kf.htm"></SCRIPT>
		-->


	</BODY>
</HTML>
