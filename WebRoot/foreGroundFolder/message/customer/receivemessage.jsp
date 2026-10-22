<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'receivemessage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script language="javascript" src="<%=path%>/js/message/stm31.js"></script>
		<script language="javascript" src="<%=path%>/js/message/Menu200FILE20277716565B27D.js"></script>
		<script language="javascript" src="<%=path%>/js/message/systemMsg.js"></script>
		<script language="javascript" src="<%=path%>/js/message/pageCommon.js"></script>
		<script language="javascript" src="<%=path%>/js/message/general.js"></script>
		<LINK href="<%=path%>/Css/message/CN/CNmainWin.css" type=text/css media=screen rel=stylesheet>
		<LINK href="<%=path%>/Css/message/query.css" type=text/css media=screen rel=stylesheet>
		<LINK href="<%=path%>/Css/message/02.css" type=text/css media=screen rel=stylesheet>
		<LINK href="<%=path%>/Css/message/bluemainWin.css" type=text/css media=screen rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
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
	</head>

	<body>
	<div>
	<ul id="nav">
<li><a href="selmessbyreadflagmessage.Action?restypeid=2&readflag=0" target="right" _fcksavedurl="http://www.52css.com/">未读短消息</a></li>
<li><a href="selmessbyreadflagmessage.Action?restypeid=2&readflag=1" _fcksavedurl="http://www.52css.com/">已读短消息</a></li>
</ul></div>
		<FORM id=actForm method=post name=actForm action="">
			<DIV id=Title_bar align="left">
				<DIV id=Title_bar_Head>
					<DIV id=Title_Head></DIV>
					<DIV id=Title align="left">
						<IMG border=0 src="/htoa/image/title_arrow.gif"  height=13>
						&nbsp;&nbsp;已发消息
					</DIV>
					<DIV id=Title_End></DIV>
					<DIV id=Title_bar_bg></DIV>
				</DIV>
			</DIV>
			<DIV id=MainArea>
				<TABLE class=TableStyle border=0 cellSpacing=0 cellPadding=0
					width="100%">
					<TBODY>
						<TR id=TableTitle vAlign=center align=middle>
							<TD style="BORDER-LEFT: #000 0px solid" width=26>
								<INPUT onclick=checkAll(); type=checkbox name=selectAll>
							</TD>
							<TD width=25>
								<IMG src="<%=path%>/foreGroundFolder/message/customer/images/priority.gif">
							</TD>
							<TD width=35>
								<IMG border=0
									src="<%=path%>/foreGroundFolder/message/customer/images/attachmenttitle1.gif">
							</TD>
							<TD>
								标题 &nbsp;
								<A
									href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3102/hOBv8tXTfYsSS8bXA9CdGg/11.0.11.0.19.2.0"
									name="Push to toggle sorting order according to null"
									border="0"> <IMG border=0
										alt="Push to toggle sorting order according to null"
										align=middle src="<%=path%>/foreGroundFolder/message/customer/images/wr.gif"
										width=10 height=9>
								</A>
							</TD>
							<TD width=180>
								收件人
							</TD>
							<TD width=180>
								发送时间 &nbsp;
								<A
									href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3102/hOBv8tXTfYsSS8bXA9CdGg/11.0.11.0.23.2.0"
									name="Push to toggle sorting order according to null"
									border="0"><IMG border=0
										alt="Push to toggle sorting order according to null"
										align=middle src="<%=path%>/foreGroundFolder/message/customer/images/wr.gif"
										width=10 height=9>
								</A>
							</TD>
						</TR>
						<TBODY id=TableData>
						<c:forEach items="${pages.pageList }" var="data" varStatus="status">
							<TR id=d0 class=TableDetail2 onclick="content_onclick('d${status.index }');">
								<TD width="26" style="PADDING-BOTTOM: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px" align=middle>
									<INPUT onclick=window.event.cancelBubble=true value=${data.receiverid } type=checkbox name=ids id="ids" >
								</TD>
								<TD width="25" align=middle>
									<IMG src="<%=path%>/foreGroundFolder/message/customer/images/priority.gif"> &nbsp;
								</TD>
								<TD width="35" align=middle> &nbsp; 	</TD>
								<TD  width=280> <A href="readMessByCustomermessage.Action?rid=${data.receiverid }">${data.message.titleweb }</A> </TD>
								<TD  width=180> 
									<c:forEach items="${emplist}" var="emp">
										<c:if test="${data.message.sender==emp.id}">${emp.name }</c:if>
									</c:forEach>
								 </TD>
								<TD  width=180> ${data.message.releasetime } </TD>
							</TR>
						</c:forEach>
							<tr>
								<td class=TableDetail1  colspan="6"><p:pages url="selmessbyreadflagmessage.Action?restypeid=2&readflag=1"/></td>
							</tr>
							<tr>
								<td class=TableDetail1  colspan="6">&nbsp;&nbsp;
									<INPUT value=d7 type=checkbox name="aaaa" id="aaaa" onclick="selected('ids')">	<input type="button" value="全部删除" onclick="del('delmesflagmessage.Action','selmessbyreadflagmessage.Action?restypeid=2&readflag=0')" />&nbsp;
								</td>
							</tr>
							
						</TBODY>
				</TABLE>
			</DIV>
			<INPUT value=hOBv8tXTfYsSS8bXA9CdGg type=hidden name=wosid>
		</FORM>
	</body>
	<script type="text/javascript">
		function selected(id)
		{
			var chkall = $('#aaaa').attr('checked');
			if(chkall == true)
			{
				$("input[name='"+id+"']").each(function(){
					$(this).attr('checked',true);
				});
			}
			else
			{
				$("input[name='checkBox']").each(function(){
					$(this).attr('checked',false);
				});
			}
		}
	
	</script>
</html>
