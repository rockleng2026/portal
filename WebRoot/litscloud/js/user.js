//user login
//$(".loginImg").click(function(){
	// login();
//});
function login(){
	 var userid = $("#userid").val();
	 var passwd = $("#passwd").val();
	 var yanzhengma = $("#yanzhengma1").val();
	 var dl = document.getElementById("dl");
	 if(dl.checked)
	 {
		 document.getElementById("dl1").value="2";
	 }
	 if(yanzhengma==""||yanzhengma==null)
	 {
		 document.getElementById("YZM").innerHTML="验证不能为空";
		 return false;
	 }
	 else
	 {
		 $("#loginform").submit();
	 }
}

function loginPhone()
{
	 var yanzhengma = $("#yanzhengma12").val();
	 if(yanzhengma==""||yanzhengma==null)
	 {
		 document.getElementById("YZM1").value="验证不能为空";
		 return false;
	 }
	 else
	 {
		 $("#loginform1").submit();
	 }
	
}
//login out
function logout(basePath){
	window.location.href=basePath+"litscloud/web/litscloudUserLogoutCustomerServerC.Action";
}
var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function huanyige()
{
	 var res = "";
     for(var i = 0; i < 4 ; i ++) {
         var id = Math.ceil(Math.random()*35);
         res += chars[id];
     }
   document.getElementById("yanzhengma").value=res;

}
function huanyige1()
{
	 var res = "";
     for(var i = 0; i < 4 ; i ++) {
         var id = Math.ceil(Math.random()*35);
         res += chars[id];
     }
   document.getElementById("yanzhengma2").value=res;

}
function tijiao()
{
	if(event.keyCode==13){
		
		login();
	
	}

}