	
function countDown(secs){
	var curWwwPath=window.document.location.href;
	  //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
  //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	document.getElementById("jump").value=secs;
    if(--secs>=0)
        setTimeout("countDown("+secs+" )",1000);
    if(secs==0)
    {
    	window.location.href =projectName+"/ucenter/u_login.jsp";
    }
}
countDown(5)