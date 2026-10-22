<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'customerreadmessage.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<LINK href="<%=path%>/Css/message/CNmainWin.css" type=text/css  media=screen rel=stylesheet>
<LINK href="<%=path%>/Css/message/02.css" type=text/css  media=screen rel=stylesheet>
<LINK href="<%=path%>/Css/message/comm_blue_mainWin.css" type=text/css  media=screen rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
	</head>

	<body>
		<FORM id=actForm method=post name=actForm
			action=/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3104/otON9r0C5s4Ah8KxsNWmj0/10.0.11.0>
			<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" height="500">
				<TBODY>
					<TR HEIGTH="45">
						<TD id=Title_bar>
							<DIV id=Title_bar_Head>
								<DIV id=Title_Head></DIV>
								<DIV id=Title>
									<IMG border=0 src="/htoa/image/title_arrow.gif" width=13
										height=13>
									消息阅读
								</DIV>
								<DIV id=Title_End></DIV>
								<DIV id=Title_bar_bg></DIV>
							</DIV>
							<DIV id=Title_bar_Tail>
								<DIV id=Title_FuncBar>
									<UL>
										<LI class=line></LI>
										<LI class=title>
											<A
												href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3104/otON9r0C5s4Ah8KxsNWmj0/10.0.11.0.5.1.0.0"
												name=BTN20398520728PEDX></A>
											<DIV class=Btn onclick="history.go(-1)">
												返回
											</DIV>
										</LI>
									</UL>
								</DIV>
							</DIV>
						</TD>
					</TR>
					<TR height=120>
						<TD id=MsgInfo>
							<A
								href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.oasp31.Oasp3104/otON9r0C5s4Ah8KxsNWmj0/10.0.11.0.9.1"
								name=downloadLnk></A>
							<INPUT id=functionName type=hidden name=functionName>
							<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											<UL>
												<LI class=MsgTitle>
													${message.titleweb}
													<LI class=MsgInfoMiddle>
														发送时间： ${message.releasetime }
														<LI class=MsgInfoMiddle>
															发送者： ${customerName }
											</UL>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD id=MsgContent vAlign=top>
							<TEXTAREA style="height: 300" readOnly name=0.11.0.30.1.1>${message.messagecontent }</TEXTAREA>
						</TD>
					</TR>
					<TR>
						<TD>
							&nbsp;&nbsp;
							<input type="button" value="删除" onclick="del('delmesflagmessage.Action','selmessbyreadflagmessage.Action?restypeid=2&readflag=0')"/>&nbsp;
							<!-- 
							<c:if test="${readflag == 0}">
							<input type="button" onclick="duqumess('changestatemessage.Action','selmessbyreadflagmessage.Action?restypeid=2&readflag=0')" value="标为已读" />
							</c:if>
							 -->
							<div style="display: none;">
							<input checked="checked" type="checkbox" name="duqu" id="duqu" value="${rid }"  />
							<input checked="checked" type="checkbox" name="ids" id="ids" value="${rid }"  />
							</div>
						</TD>
						
					</TR>
				</TBODY>
			</TABLE>
			<INPUT value=otON9r0C5s4Ah8KxsNWmj0 type=hidden name=wosid>
		</FORM>
	</body>
</html>
