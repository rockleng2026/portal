<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
    <TITLE>福奥进销存--工作日程</TITLE>
    <META content="MSHTML 6.00.2800.1276" name=GENERATOR>
    <META http-equiv=Content-Type content="text/html; charset=gbk">
    <META http-equiv=Content-Style-Type content=text/css>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0"/>

	<LINK href="<%=path %>/Css/desk/mainWin.css" type=text/css  media=screen rel=stylesheet>
	<LINK href="<%=path %>/Css/desk/mainWin2.css" type=text/css  media=screen rel=stylesheet>
	<LINK href="<%=path %>/Css/desk/02.css" type=text/css  media=screen rel=stylesheet>
	<LINK href="<%=path %>/Css/desk/calendar.css" type=text/css  media=screen rel=stylesheet>
	<LINK href="<%=path %>/Css/desk/query.css" type=text/css  media=screen rel=stylesheet>
	
	<script type="text/javascript" src="<%=path %>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
    <base target="_self">
</HEAD>
<body marginwidth="0" topmargin="0" leftmargin="0" marginheight="0">
		<DIV ID=Title_bar>
			<DIV ID=Title_bar_Head>
				<DIV ID=Title_Head>
				</DIV>
				<DIV ID=Title>
					<img border="0" width="13" height="13" src="<%=path %>/images/title_arrow.gif" />
					工作日程
				</DIV>
				<DIV ID=Title_End>
				</DIV>
				<DIV ID=Title_bar_bg style="width:23px;">
				</DIV>
			</DIV>
			
		</DIV>
		<DIV ID=MainArea>
			<CENTER>
					<DIV>
						<DIV>
							<ul CLASS=PannelUl STYLE="height:19px">
								<LI STYLE="width: 600px;float: left;padding: 0px;">
									<div class="FuncBtn">
									<DIV CLASS=FuncBtnHeadNoBottom>
									</DIV>
									<DIV CLASS=FuncBtnMemoNoBottom>
										列表查看
									</DIV>
									<DIV CLASS=FuncBtnTailNoBottom >										
									</DIV>
									</div>
								</LI>
							</ul>
						</DIV>
						<DIV STYLE="float:left; width:100%;padding-top: 0px">
							<ul CLASS=Pannel>
								<LI CLASS=Pannel_no_select_point STYLE="width: 80px;">&nbsp;</LI>
								<LI CLASS=Pannel_no_select_point STYLE="width:80px;">&nbsp;</LI>
								<LI CLASS=Pannel_no_select_point STYLE="width: 80px;">&nbsp;</LI>
								<LI CLASS=Pannel_select_point STYLE="width: 56px;">&nbsp;</LI>
							</ul>
						</DIV>
					</DIV>
				
					<TABLE WIDTH=100% BORDER=0 CELLSPACING=2 CELLPADDING=2>
						<TR>
							<TD VALIGN=TOP></TD>
							<TD VALIGN=TOP WIDTH=200 CLASS=cal_bg></TD>
						</TR>
						<TR>
							<TD COLSPAN=2><CENTER>
				<DIV STYLE="width:95%"><TABLE ALIGN=LEFT CELLPADDING=0 CELLSPACING=5 BORDER=0>
					<TR ALIGN=middle HEIGHT=27>
						
					</TR>
				</TABLE></div>
		<DIV ID=MainArea STYLE="width:95%;float: left;">
		  <div style="width: 85%;float: left;">
			<TABLE id="t1" WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0 CLASS=TableStyle style="text-align: center;">
				<TR ALIGN=center VALIGN=middle  ID=TableTitle>
					<TD WIDTH=50 HEIGHT=25>日程标识</TD>
					<TD WIDTH=50 HEIGHT=25>日程归类</TD>
					<TD WIDTH=15% HEIGHT=25>开始时间</TD>
					<TD WIDTH=15%>结束时间</TD>
					<TD WIDTH=8%>重要等级</TD>
					<TD WIDTH=8%>操作</TD>
				</TR>
				<tbody ID=TableData>
					<!--循环-->
					<c:if test="${empty pages.pageList}"><tr><td>无相关日程</td><td><input type="button" onClick="window.location='goAddworknotepad.do'" value="新建"></td></tr></c:if>
					<c:if test="${!empty pages.pageList}">
					<c:forEach items="${pages.pageList}" var="data" >											
						<TR class="TableDetail1">	
							<TD  HEIGHT=23>${data.subjecttitle }</TD>
							<TD  HEIGHT=23>${data.subjectstyle }</TD>
							<TD  HEIGHT=23>${data.begintime }</TD>
							<TD >${data.endtime }</TD>
							<TD >
								<c:if test="${(data.importantLevel)==0}">
									不重要
								</c:if>
								<c:if test="${(data.importantLevel)==1}">
									一般
								</c:if>
								<c:if test="${(data.importantLevel)==2}">
									<FONT color=#ff0000>重要</FONT>
								</c:if>
							</TD>
							<td>
									<a href="showworknotepad.do?style=1&schedulId=${data.id }" title="点击修改">
										修改
									</a>
									<a href="showworknotepad.do?style=1&schedulId=${data.id }" title="点击查看">
										查看
									</a>
							</td>										
						</TR>
					</c:forEach>
					</c:if>					
					<tr>
						<TD nowrap class="bg0" colSpan=5 height=30 align="right"><p:pages url="goListworknotepad.do?planStyle=0"/></TD>
					</tr> 	
					<!--循环结束-->					
        		</tbody>
			</TABLE>
			</div>
			<div id="div1" style="width: 15%;float: left;"></div>
				 <script>
				 WdatePicker({eCont:'div1',
				 	onpicked:function(dp)
					{
						var url = "selectByDateworknotepad.do?planStyle=0&selectDate=" + dp.cal.getDateStr();
						 $.post(url,function(data)
				         {
				            $("#t1").html(data);
				        });
					    //window.location.href="goListworknotepad.do?planStyle=0&selectDate=" + dp.cal.getDateStr();
					}
				 })
				 </script>
		</DIV>
		</CENTER></TD>
				</TR>
		</TABLE>
	</CENTER>
	</DIV>	
</body>
</HTML>
