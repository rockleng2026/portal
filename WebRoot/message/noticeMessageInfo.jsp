<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>福奥进销存系统--公告阅读</title>
    
 	<META content="MSHTML 6.00.2800.1276" name=GENERATOR>
    <META http-equiv=Content-Type content="text/html; charset=gbk">
    <META http-equiv=Content-Style-Type content=text/css>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0"/>
		<LINK href="<%=path%>/Css/desk/02.css" type=text/css  media=screen rel=stylesheet>
<LINK href="<%=path%>/Css/desk/mainWin.css" type=text/css  media=screen rel=stylesheet>
<LINK href="<%=path%>/Css/desk/mainWin2.css" type=text/css  media=screen rel=stylesheet>
  </head>
  <SCRIPT>
  </SCRIPT>
<body marginwidth="0" topmargin="0" leftmargin="0" marginheight="0" class="Msg_body" >
		<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100% HEIGHT=95%>
			<TR height="45">
				<TD ID=Title_bar>
					<DIV ID=Title_bar_Head>
						<DIV ID=Title_Head>
						</DIV>
						<DIV ID=Title>
							<img border="0" width="13" height="13" src="<%=path%>/images/title_arrow.gif"/>
							<!-- 消息类型 -->
							${data.messagetypeByMessagetype.type }
						</DIV>
						<DIV ID=Title_End>
						</DIV>
						<DIV ID=Title_bar_bg>
						</DIV>
					</DIV>
				</TD>
			</TR>
			<TR HEIGHT=120>
				<TD ID=MsgInfo>
					<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 WIDTH=100%>
						<TR>
							<TD>
								<ul>
									<LI CLASS=MsgTitle>标　　题：
										${data.titleweb }
									</LI>
									<LI CLASS=MsgInfoMiddle>发布时间：
										${fn:substring(data.releasetime, 0, 16)}
									</LI>
									<LI CLASS=MsgInfoMiddle>发 布 者：
										<!-- 发送人模块   先判断是员工或客户再取得姓名 -->
										<c:if test="${(data.messagetypeBySendertype.messagetypeid) == 1}">										
											${employee.name}
										</c:if>
										<c:if test="${(data.messagetypeBySendertype.messagetypeid) == 2}">
											${customer.customerName }
										</c:if>
									</LI>									
								</ul>
							</TD>
							
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD ID=MsgContent VALIGN=top>						
						<div style="margin-left: 15px; font-size: 20px;">
							${data.messagecontent }
						</div>
				</TD>
			</TR>
		</TABLE>

  </body>
</html>
