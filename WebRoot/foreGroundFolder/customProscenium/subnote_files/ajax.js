
///////ajax///////
function createobject(){
	
	 var xmlhttp;
	 try{
		 xmlhttp=new ActiveXObject("Microsoft.XMLHttp");
	 }
	 catch(e){
	 try{
		 xmlhttp=new XmlHttpRequest();
	 }
	 catch(e){
		 xmlhttp=false;
	 }
    }
	return xmlhttp;
 }

function getwebselect2(){
	var xmlhttp=createobject();
	if(xmlhttp){

		var nameid=document.getElementById('user_name').value;
		xmlhttp.open('get','regcs.asp?name='+nameid+"&n="+Math.random(),true);
		xmlhttp.onreadystatechange=function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			content=unescape(xmlhttp.responsetext);
			//alert(content);
			//weekday.innerHTML=content;
			//return content;
			
			document.getElementById('tidd').value=content;
			if(content==1){
				uname.innerHTML='<img src="images/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>该用户名已被注册！';
				return false;
			}
			else{
				uname.innerHTML='<img src="images/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			}

		}

		else{
			//content.innerHTML='数据正在加载...';
		}
		return true;	
	  }
	  xmlhttp.send(null);
	  
   }
}

function getwebselect3(){
	var xmlhttp=createobject();
	if(xmlhttp){

		var user_code=document.getElementById('user_code').value;
		xmlhttp.open('get','regcs.asp?code='+user_code+"&n="+Math.random(),true);
		xmlhttp.onreadystatechange=function(){
		if(xmlhttp.readyState==4 && xmlhttp.status==200){
			content=unescape(xmlhttp.responsetext);
			//alert(content);
			//weekday.innerHTML=content;
			//return content;
			
			document.getElementById('tidd2').value=content;
			if(content==1){
				code2.innerHTML='<img src="images/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>验证码输入错误！';
				return false;
			}
			else{
				code2.innerHTML='<img src="images/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
			}

		}

		else{
			//content.innerHTML='数据正在加载...';
		}
return true;	
	  }
	  xmlhttp.send(null);
	  
   }
}