<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<HTML>
<HEAD>
    <TITLE>OA8000增强版_FUMYSQL5--发送消息</TITLE>
    <META content="MSHTML 6.00.2800.1276" name=GENERATOR>
    <META http-equiv=Content-Type content="text/html; charset=gbk">
    <META http-equiv=Content-Style-Type content=text/css>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta name="viewport" content="width=device-width,minimum-scale=1.0"/>
    <script language="javascript" src="<%=request.getContextPath() %>/js/message/pageCommon.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/message/Menu200FILE20277716565B27D.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/message/stm31.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/message/OaPubptPersonnelSelector.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/message/general.js"></script>
<script language="javascript" src="<%=request.getContextPath() %>/js/message/3101.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>	
	<LINK href="<%=request.getContextPath() %>/Css/message/bluemainWin.css" type=text/css  media=screen rel=stylesheet>
<LINK href="<%=request.getContextPath() %>/Css/message/comm_blue_mainWin.css" type=text/css  media=screen rel=stylesheet>
	<style type="text/css">
* {
font-size:12px;
text-align:center;
}
body {
background:#f0f0f0;
}
#nav {
width:700px;
margin:20px auto 0 auto;
}
#nav li {
display: inline;
list-style-type: none;
}
#nav li a:link,#nav li a:visited {
float:left;
margin-right:2px;
padding:3px 8px 3px 8px;
text-decoration: none;
color:#fff;
background:gray;
border-top:1px solid #fff;
border-right:1px solid #333;
border-bottom:1px solid #333;
border-left:1px solid #fff;
}
#nav li a:hover {
padding:2px 8px 4px 8px;
border-top:1px solid #333;
border-right:1px solid #fff;
border-bottom:1px solid #fff;
border-left:1px solid #333;
}
#nav li a#current {
color:#gray;
}
</style>
    <base target="_self">
</HEAD>
<body marginwidth="0" topmargin="0" leftmargin="0" marginheight="0" class="Msg_body">

	<a id="autoHref" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3101/J1C744DgaA7E0tiKObdEkg/78.0.11.0.3.0"></a><input id="onlineUsers" type="hidden" disabled="disabled" value=";admin;systemadmin;user;T4FX;G38R;administrator;" name="onlineUsers" />
	<form method="post" id="actForm" name="actForm" action="">
		<table id=MainArea2 style="float:left;height:auto">
			<tr>
				<td>
					<center>
						<table BORDER=1 CELLPADDING=0 CELLSPACING=0 WIDTH=95% HEIGHT=450px style="padding:3px;border: #91c0e3 1px solid" class=msgBorder>
							<tr>
								<td>
									<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100% HEIGHT=100% style="background-color:#ffffff">
									<TR>
											<TD  HEIGHT=30 CLASS=Msg_read_title_bg></TD>
											<TD CLASS=Msg_read_title_bg>
												如果我们公司哪些服务做的不到位，请您在此提出您的建议和意见，我们的工作人员会在48小时内答复您，谢谢您的合作！
											</TD>
											<TD CLASS=Msg_read_title_bg></TD>
										</TR>
										<TR>
											<TD CLASS=Msg_read_title_bg></TD>
											<TD HEIGHT=60 CLASS=Msg_read_title_bg>
												<TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0>
													<TR CLASS=ItemTitleFont>
														<TD WIDTH=60 align="left">标题</TD>
														<TD align="center" width="50%"><input class="InputStyle" type="text" value="无标题" name="title" id="title"/></TD>
														<TD  width="43%" WIDTH=9> 问题类别： <select><option value="建议">建议</option><option value="投诉">投诉</option></select> </TD>
													</TR>
												</TABLE>
											</TD>
											<TD CLASS=Msg_read_title_bg></TD>
										</TR>
										<TR>
											<TD WIDTH=30></TD>
											<TD>
												<TABLE HEIGHT=100% BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=100%>													
													<tr>
															<td WIDTH=60></td>
															<TD WIDTH=800></TD>
															<TD></TD>															
														</tr>
													<TR CLASS=ItemTitleFont>
														<TD WIDTH=60 VALIGN=top CLASS=ItemTitleFont>
															内容
														</TD>
														<TD>
																<textarea class="InputAreaStyle" id="messagecontent" name="messagecontent"   onkeydown= "javascript:if(event.ctrlKey && event.keyCode==13)check();"></textarea>
															</TD>
														<TD></TD>
													</TR>
													<TR CLASS=ItemTitleFont>
														<TD HEIGHT=8></TD>
														<TD COLSPAN=2>&nbsp;按Ctrl+回车键发送消息</TD>
													</TR>
												</TABLE>
											</TD>
											<TD WIDTH=20></TD>
										</TR>
									</TABLE>
								</td>
							</tr>
						</table>
					</center>
				</td>
			</tr>
		</table>
	<input type="hidden" name="wosid" value="J1C744DgaA7E0tiKObdEkg" /></form><form method="post" name="homeForm" action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3101/J1C744DgaA7E0tiKObdEkg/78.0.11.1"><input type="hidden" value="请选择接收人。" name="alertMsg" /> <input type="hidden" name="newUrl" /> <input type="hidden" name="newWindow" />
    <input type="hidden" name="confirmMsg" /> <input type="hidden" value="OA8000增强版_FUMYSQL5--发送消息" name="topTitle" /><input type="hidden" value="3101" name="pgID" /><input type="hidden" name="returnPage" /><input type="hidden" name="wosid" value="J1C744DgaA7E0tiKObdEkg" /></form>
    <form method="post" id="menuForm" action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3101/J1C744DgaA7E0tiKObdEkg/78.0.11.2.1"><script type="text/javascript" language="JavaScript1.2">
writeMenu(false);
</script>
<input type="hidden" name="url" /><input type="hidden" name="urlName" /><input type="hidden" name="wosid" value="J1C744DgaA7E0tiKObdEkg" /></form>
</body>

<script type="text/javascript">
	function check(){
		var title = encodeURI(document.getElementById("title").value);
		var messagecontent = encodeURI(document.getElementById("messagecontent").value);
		if(title=="")
		{
			alert("标题不能为空！");
			return false;
		}
		if(messagecontent == "")
		{
			alert("内容不能为空！");
			return false;
		}
		
		if(messagecontent!=""&&title!="")
		{
			var url = "addMessByCustomermessage.Action";
			$.post(url,{title:title,messagecontent:messagecontent},function(data){
				if(data=="0")
				{
					alert("发送成功，谢谢您对我们公司的支持，谢谢！");
					window.location.href="<%=request.getContextPath() %>/foreGroundFolder/customProscenium/customerservicer.jsp";
				}
				else
				{
					alert("发送失败！");
					return false;
				}
			});
		}
	}

	
</script>
</HTML>
