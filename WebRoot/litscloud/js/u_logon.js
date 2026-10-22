   function isNLU(ui){    
      var valid=/^\w+$/; 
      return(valid.test(ui)) 
   } 
   function reg(){
       	
		var user_name=document.getElementById('customerName').value;
		user_name=user_name.replace(/\s+/g,"");
		if(user_name==""){
		  uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请正确填写用户名称！';
		   return false;
		}
	   else if(!isNaN(user_name)){
			//alert('用户名不能全部是数字！');
			 uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名不能全部是数字！';
			return false;
		}
	   else if(!isNLU(user_name)){
				uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>只能是英文或是和数字组合！';
				return false;
		}
	   else if(user_name.length<6 || user_name.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名长度必须为6 - 16位！';
			return false;
	   }
		else{
			 var url = "checkFiledCustomerServer.Action";
			   $.post(url,{user_name:user_name},function(data){
			   	if(data=="0")
			   	{
			   		uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名已存在！';
			   		return false;
			   	}
			   	else
			   	{
			   		$("#tidd").attr("value","1");
			   		uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			   		return true;
			   	}	
			   });
		}
	}

function regpwd(){
		var user_pwd=document.getElementById('customerPassword').value;		
		user_pwd=user_pwd.replace(/\s+/g,"");
		if(user_pwd==""){
			pwd.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
			return false;		
		
		}
	    else if(user_pwd.length<6 || user_pwd.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			pwd.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码长度必须为6 - 16位！';
			return false;
	   }
	   else{
			pwd.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
			pwd2.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
			return false;		
		
		}
	    else if(user_pwdup!=user_pwd){
			pwd2.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
			return false;
	   }
	   else{
			pwd2.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;

}
///////////////////////

function regmail(){
		var user_mail=document.getElementById('email').value;	
		user_mail=user_mail.replace(/\s+/g,"");
		if(user_mail==""){
			$("#mail").html('<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的邮箱！');
			return false;			
		}
		else if((user_mail.indexOf("@")<0)||(user_mail.indexOf(":")!=-1)){
			$("#mail").html('<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱格式不正确！');
			return false;		
		
		}
		 else{
			   //alert(1111);
			   var url = "checkFiledCustomerServer.Action";
			    $.post(url,{email:user_mail},function(data){
			   	//alert(data);
			   	if(data=="0")
			   	{
			   		$("#mail").html('<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱已被注册！');
			   		return false;
			   	}
			   	else
			   	{
			   		$("#tiemail").attr("value","1");	
			   		$("#mail").html('<img src="foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>');
			   		return true;
			   	}
				});
			   
		   }
	 

}







function onfuos(id){
	if(id=="customerName"){
		uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />6-16个字符组成!'
	}
   if(id=="customerPassword"){
		pwd.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />密码6-16个字符组成！'
	}
   if(id=="email"){
		mail.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_02.gif" width="17" height="17" hspace="2" border="0" align="absmiddle" />安全邮箱是<font color=red>找回密码</font>的重要途径!'
	}
}






  
   function aa()
   {
   		
   		var customerName=document.getElementById("customerName").value;
   		
   		
		   
   		var customerPassword=document.getElementById("customerPassword").value;
   		var user_pwd2=document.getElementById("user_pwd2").value;
   		var email=document.getElementById("email").value;
   		 $.post("checkFiledCustomerServer.Action",{user_name:customerName},function(data){
   		
			   	if(data=="0")
			   	{
			   		uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>用户名已存在！';
			   		return false;
			   		
			   	}
   		else if(customerName==""||customerName==null)
   		{
   		 uname.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请正确填写用户名称！';
   			return false;
   		}
   		else if(customerPassword==""||customerPassword==null)
   		{
   			pwd.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
   			return false;
   		}
   		else if(user_pwd2==""||user_pwd2==null)
   		{
   			pwd2.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
   			return false;
   		}
   		else if(customerPassword!=user_pwd2)
   		{
   			pwd2.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
   			return false;
   		}
   		else if(email==""||email==null)
   		{
   			mail.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的邮箱！';
   			return false;
   		}
   		else if(!(/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(email)))
   		{
   			mail.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱格式不正确！';
   			return false;
   		}
   		else {
   			var url = "checkFiledCustomerServer.Action";
		    $.post(url,{email:email},function(data){
		   	if(data=="0")
		   	{
		   		mail.innerHTML='<img src="foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>邮箱已被注册！';
		   		return false;
		   	}
	   		else
	   		{
		   		$("#regform").submit();
		   		
	   		}
			});
   		}
   		
   		 });
		
   }
