<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'regist.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="/<%=objectname %>/js/customerRegister.js"></script>
	<link href="<%=basePath%>IDCServ/css/main.css" rel="stylesheet" type="text/css" />
	<!--   是否为数字、字母或下划线-->   
<script>
   function isNLU(ui){    
      var valid=/^\w+$/; 
      return(valid.test(ui)) 
   } 
   function reg(){
       	
		var user_name=document.getElementById('customerName').value;
		user_name=user_name.replace(/\s+/g,"");
		if(user_name==""){
		  uname.append='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请正确填写用户名称！';
		   return false;
		}
	   else if(!isNaN(user_name)){
			//alert('用户名不能全部是数字！');
			 uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名不能全部是数字！';
			return false;
		}
	   else if(!isNLU(user_name)){
				uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>只能是英文或是和数字组合！';
				return false;
		}
	   else if(user_name.length<6 || user_name.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名长度必须为6 - 16位！';
			return false;
	   }
		else{
			 var url = "checkFiledCustomerServer.Action";
			   $.post(url,{user_name:user_name},function(data){
			   	if(data=="0")
			   	{
			   		uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名已存在！';
			   		return false;
			   	}
			   	else
			   	{
			   		$("#tidd").attr("value","1");
			   		uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="1<%=basePath%>foreGroundFolder/customProscenium/<%=basePath%>foreGroundFolder/customProscenium/subnote_files" align="absmiddle" hspace="2"/>';
			   		return true;
			   	}	
			   });
		}
	}

function regpwd(){
		var user_pwd=document.getElementById('customerPassword').value;		
		user_pwd=user_pwd.replace(/\s+/g,"");
		if(user_pwd==""){
			pwd.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
			return false;		
		
		}
	    else if(user_pwd.length<6 || user_pwd.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			pwd.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码长度必须为6 - 16位！';
			return false;
	   }
	   else{
			pwd.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
			pwd2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
			return false;		
		
		}
	    else if(user_pwdup!=user_pwd){
			pwd2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
			return false;
	   }
	   else{
			pwd2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;

}
///////////////////////

function regmail(){
		var user_mail=document.getElementById('email').value;	
		user_mail=user_mail.replace(/\s+/g,"");
		if(user_mail==""){
			mail.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的邮箱！';
			return false;			
		}
		else if((user_mail.indexOf("@")<0)||(user_mail.indexOf(":")!=-1)){
			mail.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱格式不正确！';
			return false;		
		
		}
	   else{
		   var url = "checkFiledCustomerServer.Action";
		    $.post(url,{email:user_mail},function(data){
		   	if(data=="0")
		   	{
		   		mail.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱已被注册！';
		   		return false;
		   	}
		   	else
		   	{
		   		$("#tiemail").attr("value","1");	
		   		mail.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
			zsname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的姓名！';
			return false;			
		}
		else if(!isChellonese(user_zsname)){
			zsname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>真实姓名只能为中文且不能含有空格！';
			return false;		
		
		}

	   else{
			zsname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
			tel.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的电话号码！';
			return false;			
		} 
		else if(reg0.test(user_tel)==0){
			tel.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的电话号码格式不正确！';
			return false;		
		}
		else{
			tel.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
			sj.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的手机号码！';
			return false;			
		} 
		else if(reg1.test(user_sj)==0){
			sj.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的手机号码格式不正确！';
			return false;		
		}
		else{
			var url = "checkFiledCustomerServer.Action";
		  	 $.post(url,{user_tel:user_sj},function(data){
		   		if(data=="0")
		   		{
		   			sj.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>手机已被存在';
		   			return false;
		   		}
		   		else
		   		{
		   			$("#tisj").attr("value","1");
		   			sj.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
		   			return true;
		   		}
		   });
	   }
	   

}
///////////////////////

function regqq(){
       
		var user_qq=document.getElementById('qq').value;	
		
		if(user_qq==""){
			qq.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的QQ号码！';
			return false;			
		} 
		else if(isNaN(user_qq) || user_qq.length<4 || user_qq.length>12){
			qq.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的QQ号码格式不正确！';
			return false;		
		}		
		else{
			 var url = "checkFiledCustomerServer.Action";
			   $.post(url,{user_qq:user_qq},function(data){
			   		if(data=="0")
			   		{
			   			qq.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>QQ已被注册';
			   			return false;
			   		}
			   		else
			   		{
			   			$("#tiqq").attr("value","1");
			   			qq.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			   			return true;
			   		}
			   });
	   }
	   

}
///////////////////////
function regaderr(){
       
	var user_adrrew=document.getElementById('customerAddress').value;	
		
		if(user_adrrew==""){
			adrrew.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的通讯地址！';
			return false;			
		} 
		else if(!isNaN(user_adrrew)){
			adrrew.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的地址无效！';
			return false;		
		}		
		else{
			adrrew.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
	   
		return true;

}
///////////////////////
function regsfz(){
	var user_sfz=document.getElementById('cardid').value;	
	if(user_sfz=="")
	{
			sfz.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的身份证号码！';
		   return false;
	}
	else if(isIdCardNo(user_sfz)!=true){
			sfz.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您的身份证号码有误！';
		   return false;
	}
	else{
		    sfz.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	}
	return true;
} 

///////////////////////
function regcode(){
	var user_code=document.getElementById('user_code').value;	
	//alert(user_code)
	if(user_code=="")
	{
			code2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入验证码！';
		   return false;
	}
	else if(isNaN(user_code)){
			code2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>验证码只能是数字！';
		   return false;
	
	}
	else{
			getwebselect3();
		    code2.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	}
	return true;
} 



/////////////////////

function onfuos(id){
	if(id=="customerName"){
		uname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />6-16个字符，允许字母或和数字、下划线组合，不区分大小写!'
	}
   if(id=="customerPassword"){
		pwd.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />用户登录时所用密码,6-16个字符，不能含有空格，密码区分大小写！'
	}
   if(id=="email"){
		mail.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />安全邮箱是<font color=red>找回密码</font>的重要途径，建议您填写常用邮箱!'
	}
   if(id=="realName"){
		zsname.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />填写您的真实姓名！'
	}
   if(id=="phone"){
		tel.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写固定电话号码，格式为0551-4202205！'
	}
   if(id=="mobilePhone"){
		sj.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用手机号码！'
	}
   if(id=="qq"){
		qq.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用的号码！'
	}
   if(id=="customerAddress"){
		adrrew.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写正常的通讯地址！'
	}
   if(id=="cardid"){
		sfz.innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />请填写您有效的身份证号码！'
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
text.innerHTML="";  
break;  
case 2:  
Lcolor=Mcolor=M_color;  
Hcolor=O_color; 
strength_L.innerHTML="";
text.innerHTML="";  
document.getElementById("text").style.color=M_color;    
break;  
default:  
Lcolor=Mcolor=Hcolor=H_color;  
strength_M.innerHTML="";  
text.innerHTML=""; 
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
   			
   		}else{
			var url = "checkFiledCustomerServer.Action";
		  	 $.post(url,{authorization:authorization},function(data){
		   		if(data=="0")
		   		{
		   		document.getElementById("authorization1").innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>授权码已存在，请更换一个。';
		   			return false;
		   		}
		   		else
		   		{
		   			$("#tisj").attr("value","1");
		   			document.getElementById("authorization1").innerHTML='<img src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>可以使用';
		   			return true;
		   		}
		   });
	   }
   }
 </script>
 <STYLE type="text/css">

input{
border:1px solid #000000;
 }
 p,span{
 display: inline;
 margin-left: 0px;
 size: -1;
 font-size: x-small;
 }
 td{

 text-align: left;
 }
 
 
 </STYLE>
 	<SCRIPT type=text/javascript src="<%=basePath%>foreGroundFolder/customProscenium/<%=basePath%>foreGroundFolder/customProscenium/subnote_files/jquery-1.4a2.min.js"></SCRIPT>
	<SCRIPT type=text/javascript src="<%=basePath%>foreGroundFolder/customProscenium/<%=basePath%>foreGroundFolder/customProscenium/subnote_files/global__3132109.js"></SCRIPT>
</head>
  <body>
  <div >
  <br/><br/><br/>
<p align="center" style="margin-left: 650"><h2>注册</h2></p>
<BR/>
  <hr size="+4" style="color: black;margin-left: 535;" width="600"/>
  <br/>
   &nbsp;&nbsp;&nbsp;&nbsp;<h5 align="center" style="size: -1;display: inline;margin-left: 500">已有一个账号，请点击这里<a href="<%=basePath%>IDCServ/loggin.jsp">登录</a>(带<span class="dd1008">*</span>号为必填项)</h5>
 <FORM id=form1  method=post name="form1" action="customerRegisterCustReg.Action">
<s:token name="register"></s:token>
  
  <table border="0" cellpadding="0" cellspacing="0" width="80%" align="center">
  
   <tr height="10">
    <td  rowspan="15" align="right" width="400" height="550"><img src="<%=basePath%>IDCServ/image/111.jpg" height="550"/ ></td>
         <td width="100" height="10"><span class="dd1008">*</span>用&nbsp;户&nbsp;名：</td>
          <td width="600" align="left"  height="10">
           <INPUT onblur=reg() style="border:1px solid #000000;" id=customerName
			class=input_out onfocus="onfuos('customerName')"
			onmousemove="this.className='input_move'"
			onmouseout="this.className='input_out'" maxLength=10
			type=text name=customerName><span id=uname></span>
			<INPUT id=tidd type=hidden name=tidd value="">
          </td>
         
     </tr>
      <tr>
       <td><span class="dd1008">*</span>密&nbsp;&nbsp;&nbsp;&nbsp;码:</td>
          <td>
            <INPUT onblur=regpwd() style="border:1px solid #000000;"
			id=customerPassword class=input_out
			onfocus="onfuos('customerPassword')"
			onmousemove="this.className='input_move'"
			onkeyup=pwStrength(this.value)
			onmouseout="this.className='input_out'" maxLength=15
			type=password name=customerPassword><SPAN id=pwd></SPAN>
         </td>
     </tr>
       <tr>
        <td>
          &nbsp;密码强度：</td> <td>
            <span id="strength_L" style=" margin-left:0.1px;background-color:#FBD4A1;width:45px; text-align:center;color:#FAFAFA">弱</span><span id="strength_M" style=" margin-left:1;background-color:#FBD4A1;width:45px; text-align:center;color:#FAFAFA">中</span><span id="strength_H" style=" margin-left:1;background-color:#FBD4A1;width:45px; text-align:center;color:#FAFAFA">强</span>
       
         
          <SPAN style="MARGIN-LEFT: 5px" id=text></SPAN>
          </td>
        
      </tr>
     <tr>
     <td><span class="dd1008">*</span>确认密码：</td>
          <Td>
          <INPUT onblur=regpwd2() style=" border:1px solid #000000;" id=user_pwd2
			class=input_out onfocus=""
			onmousemove="this.className='input_move'"
			onmouseout="this.className='input_out'" type=password
			name=user_pwd2><SPAN id=pwd2></SPAN>
          </Td>
        
     </tr>
        <tr>
       <Td>
         <span class="dd1008">*</span>电子邮件：</Td>
         <Td>
            <INPUT onblur=regmail() style="WIDTH: 240px;border:1px solid #000000;" id=email
				class=input_out onfocus="onfuos('email')"
				onmousemove="this.className='input_move'"
				onmouseout="this.className='input_out'" type=text name=email><SPAN id=mail></SPAN>
			    <INPUT id=tiemail type=hidden name=tiemail value="">
       </Td>
        
     </tr>
      <tr>
       <Td>
          <span class="dd1008">*</span>手机号码：</Td>
          <td>
            <INPUT onblur=regsj() style="WIDTH: 240px;" id=mobilePhone
			class=input_out onfocus="onfuos('mobilePhone')"
			onmousemove="this.className='input_move'"
			onmouseout="this.className='input_out'" type=text
			name=mobilePhone><SPAN id=sj></SPAN>
		   <INPUT id=tisj type=hidden name=tisj value="">
          </td>
        
     </tr>
      <Tr>
       
          <td><span class="dd1008">*</span>QQ&nbsp;号&nbsp;码：</td>
         <Td>
            <INPUT onblur=regqq() style="WIDTH: 240px;border:1px solid #000000;" id=qq
				class=input_out onfocus="onfuos('qq')"
				onmousemove="this.className='input_move'"
				onmouseout="this.className='input_out'" type=text name=qq><SPAN id=qq></SPAN>
			<INPUT id=tiqq type=hidden name=tiqq value="">
          </Td>
       
      </tr>
       <Tr>
        <Td><span class="dd1008">*</span>授&nbsp;权&nbsp;码：</td>
         <Td>
									<input id="authorization" style="border: 1px solid #000000;"
										name="authorization" onblur="returndetermine()" type="text" />
									<SPAN id=authorization1 name="authorization1">5~~8为字符（用于验证客户是否授权给内部人员。比如:填写订单）</SPAN>
        </Td>
      </tr>
     <Tr>
        <td>&nbsp;调 &nbsp;&nbsp;&nbsp;查:</td>
          <td>
             <font color="#019C96" size="-1">您从何处得知本站:</font> <SELECT id=user_from name=user_from onchange="changesel()">
				<OPTION selected value="">
					下拉选择
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
			
     </Tr>
     <Tr>
        <td>&nbsp;答&nbsp;&nbsp;&nbsp;&nbsp;案：</td>
       
              
         </td>
         <td>  
           <INPUT onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
				style="border:1px solid #000000;" id=user_from2 class=input_out
				onfocus="this.className='input_on';this.onmouseout=''"
				onmousemove="this.className='input_move'"
				onmouseout="this.className='input_out'" type=text
				name=user_from2 >
				
         
    </Tr>
   <script type="text/javascript">
    function changesel(){
    
    var x=$("#user_from").find("option:selected").text();
    document.getElementById("user_from2").value=x;
    
    }
   
   </script>
      <tr>
        <Td><span class="dd1008">*</span>验&nbsp;证&nbsp;码：</Td>
          <td>
           <input type="text" id="user_code" name="user_code"
			class="input_out" onMouseMove="this.className='input_move'"
			onMouseOut="this.className='input_out'" />
         <INPUT id=tidd2 type=hidden name=tidd2>
         </td>
       
     </tr>
    <tr>
        <Td></Td>
          <Td>
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
        </Td>
        
     </tr>
     <Tr>
         <Td>&nbsp;备注说明：</Td>
         <td>
          <INPUT
			onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
			style="WIDTH: 240px" id=user_notes class=input_out
			onfocus="this.className='input_on';this.onmouseout=''"
			onmousemove="this.className='input_move'"
			onmouseout="this.className='input_out'" type=text
			name=user_notes>
         </td>
     </Tr>
     <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
     <tr>
     <td>&nbsp;</td><td>
     &nbsp;&nbsp; <input  class="dd0707"   type=submit  value=""  name=Submit />
    &nbsp;&nbsp;&nbsp;&nbsp;<input 
	type="reset" class="dd0708" value=" " name=Submit2 >
	</td>
	</tr>
    </table>
  </div>
  <div class="dd0704">
   
	
  </div>


</form>
<NOSCRIPT>
			<DIV style="DISPLAY: inline">
				<IMG
					style="BORDER-BOTTOM-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; BORDER-LEFT-STYLE: none"
					alt="" src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/1019822948.gif" width=1 height=1>
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
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/01.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.chinamobile.com/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/02.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.cnc.com.cn/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/03.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.xinnet.cn/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/04.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.dns.com.cn/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/05.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.onlinedown.net/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/06.png" width=78
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="http://www.cnnic.net.cn/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/07.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.99bill.com/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/08.png" width=69
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.alipay.com/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/09.png" width=88
												height=31>
										</A>
									</TD>
									<TD vAlign=center align=middle>
										<A href="https://www.tenpay.com/" target=_blank><IMG
												class=b_bk border=0 src="<%=basePath%>foreGroundFolder/customProscenium/subnote_files/10.png" width=88
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
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="50%" align=center>
			<TBODY>
				<TR>
					<TD height=8></TD>
				</TR>
			</TBODY>
		</TABLE>

  </body>
</html>
