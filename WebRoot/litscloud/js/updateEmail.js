function open1(){
	//location.href ="<%=request.getContextPath()%>/litscloud/ucenter/bg_zhaopass03.jsp";
	
	tt=(new Date()).getTime();
	$.getJSON("faEmailCustomerServer.Action?tt="+tt,{},function(data){
	if(data==1)
	{
	document.getElementById("typediv1").style.display="block";//显示
	document.getElementById("daojishi1").style.display="block";//显示
	document.getElementById("daojishi2").style.display="none";//显示
		countDown(59);
	}
		
	
	});
}
function yanZhengMa(basePath){
	//location.href ="<%=request.getContextPath()%>/litscloud/ucenter/bg_zhaopass03.jsp";
		var suijima=document.getElementById("suijima").value;
	$.getJSON("yanZhengMa2CustomerServer.Action",{suijima:suijima},function(data){
		if(data==1)
		{
			location.href =basePath+"litscloud/ucenter/updateEmailWanCheng.jsp"
		}
		else
		{
			alert("验证码错误！！！→_→ ");
		}
	
	});
}
function countDown(secs){
	document.getElementById("jump").value=secs;
    if(--secs>=0)
        setTimeout("countDown("+secs+" )",1000);
    if(secs==0)
    {
        document.getElementById("daojishi1").style.display="none";//显示
        document.getElementById("daojishi2").style.display="block";//显示
    }
}
document.onkeydown = function()

{

　　if(event.keyCode==116) {

　　　　event.keyCode=0;

　　　　event.returnValue = false;

　　}

}

document.oncontextmenu = function() {event.returnValue = false;}
