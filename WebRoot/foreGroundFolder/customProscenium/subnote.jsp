<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0040)http://www.ebadu.com/manager/subnote.asp -->
<HTML><HEAD><TITLE>提交问题</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META name=description
content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
<META name=keywords 
content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible><LINK rel="shortcut icon" 
href="../users/ico/zhhzw.ico">

<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css"/>
    <LINK rel=stylesheet type=text/css  href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css"/>
<META name=GENERATOR content="MSHTML 8.00.6001.19154"></HEAD>
<BODY leftMargin=0 topMargin=0>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
      <SCRIPT language=javascript>
function Del(Word)
{
	a = Word.indexOf("<");
	b = Word.indexOf(">");
	len = Word.length;
	c = Word.substring(0, a);
	if(b == -1)	b = a;
	d = Word.substring((b + 1), len);
	Word = c + d;
	tagCheck = Word.indexOf("<");
	if(tagCheck != -1)	Word = Del(Word);
	return Word;
}
function checkstr(){
	alert("你好，欢迎进入测试仪。。。");

	if(document.form1.s1.value==""){
		alert("提示：\n\n请选择产品类型！");
		document.form1.s1.focus();
		return false;
	}
	
	if(document.form1.new_addr.value=="no"){
		alert("提示：\n\n您可能没有选择IP或者帐号，如果您没有此项业务，抱歉您不能提交 ");
		document.form1.s1.focus();
		return false;
	}
	




/*	if(document.form1.ip.value==""){
		alert("提示：\n\n请填写IP");
		document.form1.ip.focus();
		return false;
	}
*/	
	if(document.form1.s2.value==""){
		alert("提示：\n\n请选择问题类别！");
		document.form1.s2.focus();
		return false;
	}

	if(document.form1.queren2.checked==false){
		alert("提示：请确认免责声明，否则不予受理! ");
		document.form1.queren2.focus();
		return false;
	}

	if(document.form1.descs.value=="" ||  document.form1.descs.value=="涉及到相关空间域名的时候，请留下相关的帐号或者域名"){
		alert("提示：\n\n请输入问题内容！");
		document.form1.descs.focus();
		return false;
	}
	if(document.form1.queren1.checked==false){
		alert("提示：请确认已正确选择您提交的产品类型与问题类别，否则不予受理! ");
		document.form1.queren1.focus();
		return false;
	}

	if(document.form1.customerphone.value==""){
		alert("提示：请正确填写手机号码！ ");
		document.form1.customerphone.focus();
		return false;
	
	}
	if(document.form1.customerphone.value.length>11){
		alert("提示：请正确填写手机号码！ ");
		document.form1.customerphone.focus();
		return false;
	
	}

	if(document.form1.customerphone_ok.checked==false){
		alert("提示：请确认手机号码，否则您不能及时接受到短信通知! ");
		document.form1.customerphone_ok.focus();
		return false;
	}
	else
	{
		ToCheck = document.form1.descs.value;
		Checked = Del(ToCheck);
		document.form1.descs.value = Checked;
		if(Checked.length < ToCheck.length)
		{
			alert("提示：\n\n您不能输入html代码！");
			document.form1.descs.focus();
			return false;
		}
		else
		{
    		var strs=document.getElementById('new_addr').options[document.getElementById('new_addr').selectedIndex].text;
    		var fo=document.getElementById('pid');
    		fo.value=strs;
    		alert(fo.value);
			return true;
		}
	}

}

function ondel(id){
	if(id==1 && document.form1.descs.value=='涉及到相关空间域名的时候，请留下相关的帐号或者域名'){
		document.form1.descs.value='';
	}
	else if(id==2 && document.form1.descs.value==''){
		document.form1.descs.value='涉及到相关空间域名的时候，请留下相关的帐号或者域名'
	}

}
<!-- 二级联动 Start -->
	var subcat = new Array();
	
					subcat[0] = new Array('14','程序预装/调试','程序预装/调试')
	
					subcat[1] = new Array('14','程序解压/备份','程序解压/备份')
	
					subcat[2] = new Array('14','数据库导入/导出','数据库导入/导出')
	
					subcat[3] = new Array('14','域名解析/绑定','域名解析/绑定')
	
					subcat[4] = new Array('14','域名白名单协助','域名白名单协助')
	
					subcat[5] = new Array('14','非法信息处理协助','非法信息处理协助')
	
					subcat[6] = new Array('11','协助重启','协助重启')
	
					subcat[7] = new Array('11','系统重装','系统重装')
	
					subcat[8] = new Array('12','协助重启','协助重启')
	
					subcat[9] = new Array('12','系统重装','系统重装')
	
					subcat[10] = new Array('24','代理平台故障','代理平台故障')
	
					subcat[11] = new Array('18','域名转入','域名转入')
	
					subcat[12] = new Array('18','域名转出','域名转出')
	
					subcat[13] = new Array('19','无法正常收发邮件','无法正常收发邮件')
	
					subcat[14] = new Array('20','数据库清空','数据库清空')
	
					subcat[15] = new Array('14','网站被挂马协助','网站被挂马协助')
	
					subcat[16] = new Array('14','空间使用其他协助','空间使用其他协助')
	
					subcat[17] = new Array('14','Asp类网站访问报错协助','Asp类网站访问报错协助')
	
					subcat[18] = new Array('18','域名解析/绑定','域名解析/绑定')
	
					subcat[19] = new Array('11','密码破解','密码破解')
	
					subcat[20] = new Array('12','密码破解','密码破解')
	
					subcat[21] = new Array('20','数据库导入/导出','数据库导入/导出')
	
					subcat[22] = new Array('11','无法远程协助','无法远程协助')
	
					subcat[23] = new Array('16','无法远程协助','无法远程协助')
	
					subcat[24] = new Array('24','其他','其他')
	
					subcat[25] = new Array('19','邮局解封/更换申请','邮局解封/更换申请')
	
					subcat[26] = new Array('20','数据库无法连接申告','数据库无法连接申告')
	
					subcat[27] = new Array('14','.Net类网站访问报错协助','.Net类网站访问报错协助')
	
					subcat[28] = new Array('14','PHP类网站访问报错协助','PHP类网站访问报错协助')
	
					subcat[29] = new Array('14','FTP连接故障申告','FTP连接故障申告')
	
					subcat[30] = new Array('14','主机访问故障申告','主机访问故障申告')
	
					subcat[31] = new Array('18','域名续费','域名续费')
	
					subcat[32] = new Array('18','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[33] = new Array('18','其他','其他')
	
					subcat[34] = new Array('14','数据库连接故障申告','数据库连接故障申告')
	
					subcat[35] = new Array('13','协助重启','协助重启')
	
					subcat[36] = new Array('13','系统重装','系统重装')
	
					subcat[37] = new Array('13','密码破解','密码破解')
	
					subcat[38] = new Array('13','无法远程协助','无法远程协助')
	
					subcat[39] = new Array('80','FTP连接故障申告	','FTP连接故障申告')
	
					subcat[40] = new Array('80','FTP连接列表出错','FTP连接列表出错')
	
					subcat[41] = new Array('14','空间解封/关闭申请','空间解封/关闭申请')
	
					subcat[42] = new Array('14','空间升级/更换申请','空间升级/更换申请')
	
					subcat[43] = new Array('14','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[44] = new Array('14','产品咨询','产品咨询')
	
					subcat[45] = new Array('14','其他','其他')
	
					subcat[46] = new Array('11','环境配置协助','环境配置协助')
	
					subcat[47] = new Array('11','主机使用其他协助','主机使用其他协助')
	
					subcat[48] = new Array('11','WEB环境故障协助','WEB环境故障协助')
	
					subcat[49] = new Array('11','系统安全协助','系统安全协助')
	
					subcat[50] = new Array('11','屏蔽端口/IP协助','屏蔽端口/IP协助')
	
					subcat[51] = new Array('11','主机解封申请','主机解封申请')
	
					subcat[52] = new Array('11','主机升级','主机升级')
	
					subcat[53] = new Array('11','域名白名单协助','域名白名单协助')
	
					subcat[54] = new Array('11','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[55] = new Array('11','产品咨询','产品咨询')
	
					subcat[56] = new Array('11','其他','其他')
	
					subcat[57] = new Array('12','环境配置协助','环境配置协助')
	
					subcat[58] = new Array('12','主机其他协助','主机其他协助')
	
					subcat[59] = new Array('12','WEB环境故障协助','WEB环境故障协助')
	
					subcat[60] = new Array('12','系统安全协助','系统安全协助')
	
					subcat[61] = new Array('12','屏蔽端口/IP协助','屏蔽端口/IP协助')
	
					subcat[62] = new Array('12','主机解封申请','主机解封申请')
	
					subcat[63] = new Array('12','主机硬件添加/更换','主机硬件添加/更换')
	
					subcat[64] = new Array('12','托管机器上架/发回','托管机器上架/发回')
	
					subcat[65] = new Array('12','域名白名单协助','域名白名单协助')
	
					subcat[66] = new Array('12','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[67] = new Array('12','产品咨询','产品咨询')
	
					subcat[68] = new Array('12','其他','其他')
	
					subcat[69] = new Array('13','环境配置协助','环境配置协助')
	
					subcat[70] = new Array('13','主机其他协助','主机其他协助')
	
					subcat[71] = new Array('13','WEB环境故障协助','WEB环境故障协助')
	
					subcat[72] = new Array('13','系统安全协助','系统安全协助')
	
					subcat[73] = new Array('13','屏蔽端口/IP协助','屏蔽端口/IP协助')
	
					subcat[74] = new Array('13','主机解封申请','主机解封申请')
	
					subcat[75] = new Array('13','主机升级','主机升级')
	
					subcat[76] = new Array('13','域名白名单协助','域名白名单协助')
	
					subcat[77] = new Array('13','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[78] = new Array('13','产品咨询','产品咨询')
	
					subcat[79] = new Array('13','其他','其他')
	
					subcat[80] = new Array('19','邮局删除协助','邮局删除协助')
	
					subcat[81] = new Array('19','其他','其他')
	
					subcat[82] = new Array('20','数据库更换/删除协助','数据库更换/删除协助')
	
					subcat[83] = new Array('20','其他','其他')
	
					subcat[84] = new Array('80','无法上传/下载申告','无法上传/下载申告')
	
					subcat[85] = new Array('80','其他','其他')
	
					subcat[86] = new Array('128','域名解析/绑定','域名解析/绑定')
	
					subcat[87] = new Array('128','域名白名单协助','域名白名单协助')
	
					subcat[88] = new Array('128','域名备案咨询/协助','域名备案咨询/协助')
	
					subcat[89] = new Array('128','域名转入/转出','域名转入/转出')
	
					subcat[90] = new Array('128','域名过户','域名过户')
	
					subcat[91] = new Array('128','其他','其他')
	
					subcat[92] = new Array('25','其他','其他')
	
	
	//subcat[0] = new Array('10','zzjs一号','1')	
	//subcat[1] = new Array('20','11','11')
	
	function changeselect1(locationid)
	{
	    $.post("getorderlistCustomerServer.Action",{typeId:locationid},function(date)	    
	    {
	    if(date == 1)
	    {
	    $("#new_addr").html("<option value='no' >您没有此项业务</option>");
	    }else if(date==0){
	    alert("请先登录");
	    window.location.href="<%=path%>/foreGroundFolder/customProscenium/login.jsp";
	    }
	     else
	    {
	    $("#new_addr").html(date);
	    }
	   
	    });
		document.form1.issueType.length = 0;
		document.form1.issueType.options[0] = new Option('--请选择--','');
		for (i=0; i<subcat.length; i++)
		{
			if (subcat[i][0] == locationid)
			{document.form1.issueType.options[document.form1.issueType.length] = new Option(subcat[i][1], subcat[i][2]);}
		}
	}
  function getTime(id){
  $.post("geiTimeWorkOrderCfigur.do",{id:id}, function(date){
  if(date ==0 || date =='null' || date == ''){

  $("#normalTime").html("该问题目前还没有得出准确的处理时间  请见谅");
  }else{

  $("#normalTime").html("该问题将在"+date+"分钟之后解决，请您监督");
   }
  });
  }
  
  function returnsucceed(){

	var authorization=document.getElementById("authorization").value;
	if(authorization==""||authorization==null)
	{
		document.getElementById("authorization1").innerHTML="请输入授权码";
		return false;
	}
	var cusnameId=document.getElementById("cusname").value;
		var aa=encodeURI(authorization);
	var url="selectcussaleOrder.do";
	$.post(url,{cusnameId:cusnameId,authorization:aa},function(data){
	if(data==0)
	{
		document.getElementById("authorization1").innerHTML="请选择客户";
		$("#cus").focus();
		return false;
	}else if(data==2)
	{
		document.getElementById("authorization1").innerHTML="授权码错误";
		return false;
	}
	else
	{
		document.getElementById("authorization1").innerHTML="授权码正确";
		return true;
	}
	
	});
}
</SCRIPT>

      <STYLE type=text/css>.STYLE1 {
	COLOR: #ff0000
}
</STYLE>

      <TABLE border=0 cellSpacing=1 cellPadding=2 width="95%" bgColor=#cccccc 
      align=center>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD>&nbsp;当前操作-》<A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/notelist.jsp">提交问题</A></TD></TR></TBODY></TABLE>
      <TABLE style="MARGIN-TOP: 8px; MARGIN-BOTTOM: 8px" border=0 cellSpacing=1 
      cellPadding=2 width="95%" align=center height=37>
        <TBODY>
        <TR>
          <TD width=1000px height=25 vAlign=center align=left><IMG 
            src="subnote_files/ask.gif"></TD></TR></TBODY></TABLE>
      <TABLE style="MARGIN-TOP: 8px; MARGIN-BOTTOM: 8px" border=0 cellSpacing=1 
      cellPadding=3 width="94%" bgColor=#cccccc align=center height=88>
        <TBODY>
        <TR bgColor=#f0f0f0>
          <TD style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold" 
          bgColor=#f0f0f0 height=13 colSpan=6 align=left>常见问题</TD></TR>
        <TR bgColor=#f0f0f0>
          <TD bgColor=#f0f0f0 height=13 width="19%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/iis.jsp" 
            target=right>IIS的建立</A> </TD>
          <TD bgColor=#f0f0f0 height=13 width="20%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/sql_2000.jsp" 
            target=right>Mssql2000安装</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="12%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/jc_php.jsp" 
            target=right>PHP配置</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="14%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/mysql.jsp" 
            target=right>Mysql安装</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="22%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/su.jsp" 
            target=right>报错Service Unavailable</A></TD>
          <TD bgColor=#f0f0f0 height=13 width="13%" align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/serverlogin.jsp" 
            target=right>登陆服务器</A></TD></TR>
        <TR bgColor=#f0f0f0>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/login_aq.jsp" 
            target=right>服务器的基本安全</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/index.jsp" 
            target=right>服务器上默认首页设置</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/pwd.jsp" 
            target=right>服务器修改密码</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/bq.jsp" target=_blank>Bad 
            Request报错</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/phpadmin.jsp" 
            target=right>网站建立与架设phpmyadmin</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/wfcx.jsp" 
            target=right>域名不能访问</A></TD></TR>
        <TR>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/web_jc_servU.jsp" 
            target=_blank>servU安装和建ftp帐户</A></TD>
          <TD bgColor=#f0f0f0 height=13 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/net2.0.jsp" 
            target=_blank>.net2.0安装和权限的设置</A></TD>
          <TD bgColor=#f0f0f0 height=13 colSpan=4 align=left><A 
            href="<%=path%>/foreGroundFolder/customProscenium/manager/sqlimport.jsp" 
            target=_blank>如何通过phpmyadmin导入mysql数据库</A></TD></TR></TBODY></TABLE>

      <TABLE style="MARGIN-TOP: 8px; MARGIN-BOTTOM: 8px" border=0 cellSpacing=1 
      cellPadding=2 width="95%" align=center height=37>
        <TBODY>
        <TR>
          <TD height=25 vAlign=center align=left><IMG 
            src="subnote_files/ask01.gif"></TD></TR></TBODY></TABLE>
      <TABLE style="MARGIN-TOP: 3px" border=0 cellSpacing=1 cellPadding=2 
      width="95%" bgColor=#cccccc align=center>
        <TBODY>
        <TR>
          <TD bgColor=#f0f0f0 height=23 width="19%" colSpan=2 
            align=left>&nbsp;<SPAN 
            style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold">&nbsp;<IMG 
            hspace=0 align=absMiddle src="subnote_files/tips.png" width=17 
            height=20>&nbsp;提交您的问题<FONT 
            color=#ff0000>&nbsp;&nbsp;(带*号为必填项)</FONT>,请详细描述出您的问题,有相关域名也请写上。<A 
            id=top name=top></A></SPAN></TD></TR></TBODY></TABLE>
      <TABLE style="MARGIN-TOP: 3px; DISPLAY: none" border=0 cellSpacing=1 
      cellPadding=2 width="95%" bgColor=#cccccc align=center>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff height=23 width="19%" colSpan=2 align=left><FONT 
            color=#ff0000>&nbsp;新信息：新老顾客您好，有问必答现已升级，主要让您的问题更清晰，更明了；技术们看到问题后，会在该问题指定时间完成，从而真正提高处理问题的效率！八度网络感谢您的支持！</FONT></TD></TR></TBODY></TABLE>
      <form onsubmit="return checkstr();" method=post name=form1 
        action="addconMalfunctionDeclare.Action">
      <TABLE style="MARGIN-TOP: 3px" border=0 cellSpacing=1 cellPadding=2 
      width="95%" bgColor=#cccccc align=center>
        
        <TBODY>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 align=right>
          		&nbsp;产品类型<FONT  color=#ff0000>*</FONT>
          </TD>
          <TD bgColor=#f0f0f0 width="33%">
          		<s:select style="WIDTH: 180px" onchange="producttype('s2',this.value)" name="proudcotType.id" id="s1"  list="#request.orderType" listKey="id" listValue="questionName" value="%{-1,#request.saleorder.allTypeByOrdertype.id}" headerKey="" 
										 headerValue="请选择产品类型" ></s:select>
          </TD>
          </TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 align=right>IP或者帐号<FONT color=#ff0000>*</FONT></TD>
          <TD id=chattext bgColor=#f0f0f0>
          	<SELECT style="WIDTH: 180px" id="new_addr" name="product.id" >
          	</SELECT>
          	<input type="hidden" value="" id="pid" name="pid"/>
          </TD>
         </TR>
         <tr>
         	<TD bgColor=#f0f0f0 align=right>
         		请勾选确认<FONT color=#ff0000>*</FONT>
         	</TD>
         	<TD bgColor=#f0f0f0 width="53%">
         		<FONT color=#ff0000>
         			<INPUT id=queren1 value=queding1 type=checkbox name=queren1/> 
           			 请确认您提交的产品类型与问题类别，否则不予受理!
           		</FONT>
           	</TD>
          </tr>
        <TR bgColor=#ffffff>        
          <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;问题类别<FONT 
            color=#ff0000>*</FONT><FONT color=#ff0000>&nbsp;</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><SELECT style="WIDTH: 180px" name="issueType.id" id="s2" onchange="getTime(this.value)"> 
              <OPTION selected value="">--请选择--</OPTION></SELECT><FONT color=#009F00 id="normalTime"></FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;是否支付费用<FONT 
            color=#ff0000>&nbsp;</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><INPUT id=queren3 disabled value=1 
            type=checkbox name=queren3> <FONT color=#ff0000>产生费用</FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;免责声明<FONT 
            color=#ff0000>*</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><INPUT id="queren2" value=1 CHECKED 
            type=checkbox name="queren2"> <FONT color=#ff0000>免责声明 
            对于会员号下所要求的任何操作而引起的任何影响，我公司均不承担任何责任。</FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;手机号码<FONT 
            color=#ff0000>*</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><INPUT id="customerphone_ok" value=1 
            type=checkbox name="customerphone_ok"> <SPAN 
            class=STYLE1>确认手机号码，方便及时给您短信回复！</SPAN> <LABEL><INPUT id=customerphone 
            value="${customer.mobilePhone}" name="customerphone"> <SPAN 
        class=STYLE1>*</SPAN></LABEL></TD></TR>
         <TR bgColor=#ffffff>
        <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;邮箱号码<FONT 
            color=#ff0000>*</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><INPUT id=customerphone_ok value=1 
            type=checkbox name=customerphone_ok> <SPAN 
            class=STYLE1>确认邮箱，方便及时给您短信回复！</SPAN> <LABEL><INPUT id=yx 
            value="${customer.email }" name="email"><SPAN 
        class=STYLE1>*</SPAN></LABEL></TD></TR>
        
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 width="14%" align=right>&nbsp;&nbsp;网站域名</TD>
          <TD bgColor=#f0f0f0 colSpan=2><INPUT id="wdnr" value=http:// size=40 
            name="wdnr"> <FONT color=#ff0000>方便技术们第一时间处理您的问题。</FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 align=right>&nbsp;问题描述(500字)<FONT 
            color=#ff0000>*</FONT></TD>
          <TD bgColor=#f0f0f0 colSpan=2><TEXTAREA onblur=ondel(2) style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 400px; HEIGHT: 170px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" onclick=ondel(1) name="descs">涉及到相关空间域名的时候，请留下相关的帐号或者域名</TEXTAREA></TD></TR>
          
        <TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							授权码：
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<input id="authorization" name="authorization"  onblur="returnsucceed()" />											
											 	<input name="cusname" id="cusname" type="hidden" value="${customer.customerId}"/>
											&nbsp;&nbsp;
											<FONT id="authorization1" color=#ff0000 >请输入授权码，验证唯一性、真实性</FONT>
						</TD>

					</TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 align=right>&nbsp;特别提醒</TD>
          <TD bgColor=#f0f0f0 colSpan=2>涉及到相关空间域名的时候，请留下相关的帐号或者域名</TD></TR>
        <TR bgColor=#ffffff>
          <TD bgColor=#f0f0f0 colSpan=3>
            <DIV align=center><INPUT class=bt2 value=" 提交留言 " type=submit name=Submit> 
<INPUT class=bt2 value=" 重新填写 " type=reset name=Reset2> 
        </DIV></TD></TR></TBODY></TABLE></form><!--right end-->
</BODY></HTML>
