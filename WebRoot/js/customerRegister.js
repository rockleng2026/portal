//function reg(){
//		var user_name=document.getElementById('customerName').value;
//		user_name=user_name.replace(/\s+/g,"");
//		if(user_name==""){
//		  uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请正确填写用户名称！';
//		   return false;
//		}
//	   else if(!isNaN(user_name)){
//			//alert('用户名不能全部是数字！');
//			 uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名不能全部是数字！';
//			return false;
//		}
//	   else if(!isNLU(user_name)){
//				uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>只能是英文或是和数字组合！';
//				return false;
//		}
//	   else if(user_name.length<6 || user_name.length>17){
//	   		//alert('用户名长度必须为6 - 16位');
//			uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名长度必须为6 - 16位！';
//			return false;
//	   }
//		else{
//		   //getwebselect2();
//		   var url = "checkFiledCustomerServer.do";
//		   $.post(url,{user_name:user_name},function(data){
//		   	if(data=="0")
//		   	{
//		   		uname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名已存在！';
//		   		return false;
//		   	}
//		   	else
//		   	{
//		   		uname.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//		   		return true;
//		   	}	
//		   });
//		}
//	}
//
//function regpwd(){
//		var user_pwd=document.getElementById('customerPassword').value;		
//		user_pwd=user_pwd.replace(/\s+/g,"");
//		if(user_pwd==""){
//			pwd.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
//			return false;		
//		
//		}
//	    else if(user_pwd.length<6 || user_pwd.length>17){
//	   		//alert('用户名长度必须为6 - 16位');
//			pwd.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码长度必须为6 - 16位！';
//			return false;
//	   }
//	   else{
//			pwd.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//	   }
//		return true;
//
//}
//////////////////////////
//function regpwd2(){
//		var user_pwd=document.getElementById('user_pwd2').value;	
//		var user_pwdup=document.getElementById('customerPassword').value;
//		user_pwdup=user_pwdup.replace(/\s+/g,"");
//		user_pwd=user_pwd.replace(/\s+/g,"");
//		if(user_pwdup==""){
//			pwd2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
//			return false;		
//		
//		}
//	    else if(user_pwdup!=user_pwd){
//			pwd2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
//			return false;
//	   }
//	   else{
//			pwd2.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//	   }
//		return true;
//
//}
/////////////////////////
//
//function regmail(){
//		var user_mail=document.getElementById('email').value;	
//		user_mail=user_mail.replace(/\s+/g,"");
//		if(user_mail==""){
//			mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的邮箱！';
//			return false;			
//		}
//		else if((user_mail.indexOf("@")<0)||(user_mail.indexOf(":")!=-1)){
//			mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱格式不正确！';
//			return false;		
//		
//		}
//	   else{
//	   	    var url = "checkFiledCustomerServer.do";
//		    $.post(url,{email:user_mail},function(data){
//		   	if(data=="0")
//		   	{
//		   		mail.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱已被注册！';
//		   		return false;
//		   	}
//		   	else
//		   	{
//		   		mail.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//		   		return true;
//		   	}
//			});
//	   }
//}
//
//
//function regzsname(){
//	var user_zsname=document.getElementById('realName').value;	
//	user_zsname=user_zsname.replace(/\s+/g,"");
//	if(user_zsname==""){
//		zsname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的姓名！';
//		return false;			
//	}
//	else if(!isChellonese(user_zsname)){
//		zsname.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>真实姓名只能为中文且不能含有空格！';
//		return false;		
//	
//	}
//
//   else{
//		zsname.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//   }
//	return true;
//
//}
/////////////////////////    
//function regtel(){
//   
//	var user_tel=document.getElementById('phone').value;	
//	alert(user_tel);
//	   var flag = false;   
//	   var reg0 =  /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;   //判断 固话   
//	   var reg1 =/^((\(\d{2,3}\))|(\d{3}\-))?(13|15|18)\d{9}$/;                     //判断 手机   
//	   if (reg0.test(user_tel)) flag=true;    
//	   if (reg1.test(user_tel)) flag=true;   
//	   //alert(reg0.test(user_tel)+reg1.test(user_tel));
//	if(user_tel==""){
//		tel.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的电话号码！';
//		return false;			
//	} 
//	else if(reg0.test(user_tel)==0){
//		tel.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的电话号码格式不正确！';
//		return false;		
//	}
//	else{
//		
//   }
//}
//
/////////////////////////    
//function regsj(){
//   
//	var user_sj=document.getElementById('mobilePhone').value;	
//	   var flag = false;   
//	   var reg1 =/^((\(\d{2,3}\))|(\d{3}\-))?(13|15|18)|(14)\d{9}$/;                     //判断 手机   
//	   if (reg1.test(user_sj)) flag=true;   
//	   //alert(reg0.test(user_tel)+reg1.test(user_tel));
//	if(user_sj==""){
//		sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的手机号码！';
//		return false;			
//	} 
//	else if(reg1.test(user_sj)==0){
//		sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的手机号码格式不正确！';
//		return false;		
//	}
//	else{
//	 	 var url = "checkFiledCustomerServer.do";
//	  	 $.post(url,{user_tel:user_sj},function(data){
//	   		if(data=="0")
//	   		{
//	   			sj.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>手机已被存在';
//	   			return false;
//	   		}
//	   		else
//	   		{
//	   			sj.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//	   			return true;
//	   		}
//	   });
//		
//   }
//   
//	return true;
//
//}
/////////////////////////
//
//function regqq(){
//   
//	var user_qq=document.getElementById('qq').value;	
//	
//	if(user_qq==""){
//		qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的QQ号码！';
//		return false;			
//	} 
//	else if(isNaN(user_qq) || user_qq.length<4 || user_qq.length>12){
//		qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的QQ号码格式不正确！';
//		return false;		
//	}		
//	else{
//		 var url = "checkFiledCustomerServer.do";
//	   $.post(url,{user_qq:user_qq},function(data){
//	   		if(data=="0")
//	   		{
//	   			qq.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>QQ已被注册';
//	   			return false;
//	   		}
//	   		else
//	   		{
//	   			qq.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//	   			return true;
//	   		}
//	   });
//		
//   }
//   
//	return true;
//
//}
/////////////////////////
//function regaderr(){
//   
//var user_adrrew=document.getElementById('customerAddress').value;	
//	
//	if(user_adrrew==""){
//		adrrew.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的通讯地址！';
//		return false;			
//	} 
//	else if(!isNaN(user_adrrew)){
//		adrrew.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您输入的地址无效！';
//		return false;		
//	}		
//	else{
//		adrrew.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//   }
//   
//	return true;
//
//}
/////////////////////////
//function regsfz(){
//var user_sfz=document.getElementById('cardid').value;	
//if(user_sfz=="")
//{
//		sfz.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的身份证号码！';
//	   return false;
//}
//else if(isIdCardNo(user_sfz)!=true){
//		sfz.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您的身份证号码有误！';
//	   return false;
//}
//else{
//	    sfz.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//}
//return true;
//} 
//
/////////////////////////
//function regcode(){
//var user_code=document.getElementById('user_code').value;	
////alert(user_code)
//if(user_code=="")
//{
//		code2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入验证码！';
//	   return false;
//}
//else if(isNaN(user_code)){
//		code2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>验证码只能是数字！';
//	   return false;
//
//}
//else{
//	    code2.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
//}
//return true;
//} 
//
//
//
///////////////////////
//
//function onfuos(id){
//if(id=="customerName"){
//	uname.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />6-16个字符，允许字母或和数字、下划线组合，不区分大小写!'
//}
//if(id=="customerPassword"){
//	pwd.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />用户登录时所用密码,6-16个字符，不能含有空格，密码区分大小写！'
//}
//if(id=="email"){
//	mail.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />安全邮箱是<font color=red>找回密码</font>的重要途径，建议您填写常用邮箱!'
//}
//if(id=="realName"){
//	zsname.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />填写您的真实姓名！'
//}
//if(id=="phone"){
//	tel.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写固定电话号码，格式为0551-4202205！'
//}
//if(id=="mobilePhone"){
//	sj.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用手机号码！'
//}
//if(id=="qq"){
//	qq.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写常用的号码！'
//}
//if(id=="customerAddress"){
//	adrrew.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />您可以填写正常的通讯地址！'
//}
//if(id=="cardid"){
//	sfz.innerHTML='<img src="subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />请填写您有效的身份证号码！'
//}
//}
//
//function regs(){
//    alert("dddd");
//	tidd=document.getElementById("tidd").value;
//	tidd2=document.getElementById("tidd2").value;
//	//codeid=document.getElementById('codeid').value=content;
//	//alert(tidd)
//	//alert(tidd);
//	//alert(tidd2);
//	if(reg()&&regpwd()&&regpwd2()&&regmail()&&regsj()&&regqq()&&regcode()){
//		alert(1111111);
//		return true;
//	}
//	return false;
//}






