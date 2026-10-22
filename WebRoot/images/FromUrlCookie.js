
var refurl="";
writeCookie("fromUrl") ;
function writeCookie(cookie_name)
{
    //alert("a1:::"+document.referrer);
    var cookievlaue = GetCookie(cookie_name) ;
    //alert("a2:::"+cookievlaue);
    if(cookievlaue == null)//指定cookie不存在
    { 
        //if(fromurlB.indexOf(".myyouxi.com") > -1 && fromurlB.indexOf(".youxi.com") > -1)//指定历史url地址中不包含平台地址
    	//{
		
		//return;
        //}
        var fromurl = document.referrer ;
        document.cookie=cookie_name+"="+fromurl;
        refurl=cookie_name+"="+fromurl;
        //alert(refurl);
        return;
    }
    else//指定cookie存在
    {
        var fromurlB = document.referrer ;
	//alert("fromurlB :::"+fromurlB);
        if(fromurlB.length == 0)
        {
	   refurl=cookie_name+"="+cookievlaue;
           return;
        }
    	//alert(fromurl.indexOf(".myyouxi.com") == -1 && fromurl.indexOf(".youxi.com") == -1);
    	if(fromurlB.toLowerCase().indexOf(".myyouxi.com") == -1 && fromurlB.toLowerCase().indexOf(".youxi.com") == -1)//指定历史url地址中不包含平台地址
    	{
		//alert("b1::"+fromurlB);
//alert(cookievlaue != fromurlB);
		if(cookievlaue != fromurlB)//不等于当前cookie中的推广地址
        	{
			//alert(document.cookie);
	    		Clearcookie('fromUrl');
            		document.cookie=cookie_name+"="+fromurlB;
            		//alert("b2::"+document.cookie);
            		refurl=cookie_name+"="+fromurlB;
		}
		else
{
	refurl=cookie_name+"="+cookievlaue;
//alert(refurl);
}
    	}
    }
}

function GetCookie(name) 
{ 
    var m=document.cookie; 
    //alert("m:"+m) ;
    var re1=new RegExp("(?!\w)"+name+"=[^;]+","");  
    //alert("re1:"+re1) ;
    var re2=new RegExp("^"+name+"=",""); 
    //alert("re2:"+re2) ;
    try 
    {   
	//alert("bbb:");
        
	//if(m.match(re1) == null)
	   //return null;		

        var a=m.match(re1)[0]; 
        refurl=a;
//alert("refurl:"+refurl) ;
    } 
    catch(e) 
    { 
	//alert(e);
        return null 
    } 
    eval("var o="+a.replace(re2,"{").replace(/&/g,"',").replace(/=/g,":\'")+"'}"); 
    return o; 
 } 


function Setcookie (name, value) 
{  
        //设置名称为name,值为value的Cookie 
        var argc = SetCookie.arguments.length; 
        var argv = SetCookie.arguments;     
        var path = (argc > 3) ? argv[3] : null;   
        var domain = (argc > 4) ? argv[4] : null;   
        var secure = (argc > 5) ? argv[5] : false;   
         
         
        document.cookie = name + "=" + value +  
        ((path == null) ? "" : ("; path=" + path)) +   
        ((domain == null) ? "" : ("; domain=" + domain)) +     
        ((secure == true) ? "; secure" : ""); 
} 

function DeleteCookie (name) 
{  
    //删除名称为name的Cookie 
    var exp = new Date();   
    exp.setTime (exp.getTime() - 1);   
    var cval = GetCookie (name);   
    document.cookie = name + "=" + cval + "; expires=" + exp.toGMTString(); 
} 

function Clearcookie(name)   //清除COOKIE 
    { 
    var temp=document.cookie.split(";"); 
    var loop3; 
    var ts; 
    for (loop3=0;loop3<temp.length;loop3++)
        { 
        	ts=temp[loop3].split("=")[0]; 
        	if (ts.indexOf(name)!=-1) 
            		DeleteCookie(ts);     //如果ts含“mycat”则执行清除 
        }  
    } 

function getCookieVal (offset) 
{       //取得项名称为offset的cookie值 
    var endstr = document.cookie.indexOf (";", offset);   
    if (endstr == -1) 
        endstr = document.cookie.length;   
        return unescape(document.cookie.substring(offset, endstr)); 
} 

function GetCookie (name) 
{  //取得名称为name的cookie值 
        var arg = name + "=";   
        var alen = arg.length;   
        var clen = document.cookie.length;   
        var i = 0;   
        while (i < clen) {     
        var j = i + alen;     
        if (document.cookie.substring(i, j) == arg)       
                return getCookieVal (j);     
                i = document.cookie.indexOf(" ", i) + 1;     
                if (i == 0) break;    
        }   
        return null; 
}