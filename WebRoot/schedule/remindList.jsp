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
    <TITLE>福奥进销存--日程提醒</TITLE>
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
					日程提醒
				</DIV>
				<DIV ID=Title_End>
				</DIV>
				<DIV ID=Title_bar_bg style="width:23px;">
				</DIV>
			</DIV>
			
		</DIV>
		<DIV ID=MainArea>
			
					<TABLE WIDTH=100% BORDER=0 CELLSPACING=2 CELLPADDING=2>
						<TR>
							<TD VALIGN=TOP></TD>
							<TD VALIGN=TOP WIDTH=200 CLASS=cal_bg></TD>
						</TR>
						<TR>
							<TD COLSPAN=2>
				<DIV STYLE="width:95%"><TABLE ALIGN=LEFT CELLPADDING=0 CELLSPACING=5 BORDER=0>
					<TR ALIGN="center" HEIGHT=27>
						
					</TR>
				</TABLE></div>
		<DIV ID=MainArea STYLE="width:95%;float: left;">
		<div style="width: 85%;float: left;">
			<TABLE id="t1" width="100%;" BORDER=0 CELLSPACING=0 CELLPADDING=0 CLASS=TableStyle style="text-align: center;">
				<TR ALIGN=center VALIGN=middle  ID=TableTitle>
					<TD WIDTH=50 HEIGHT=25>标识</TD>
					<TD WIDTH=60 HEIGHT=25>分类</TD>
					<TD WIDTH=115>提醒时间</TD>
					<TD WIDTH=40>重复</TD>
					<TD WIDTH=50>重要等级</TD>
					<TD WIDTH=60>状态</TD>
					<TD WIDTH=150>操作</TD>
				</TR>
				<tbody ID=TableData>
					<!--循环-->
					<c:if test="${empty pages.pageList}"><tr><td>无相关提醒</td><td><input type="button" onClick="window.location='goAddworknotepad.do'" value="新建"></td></tr></c:if>
					<c:if test="${!empty pages.pageList}">
					<c:forEach items="${pages.pageList}" var="data" >											
						<TR class="TableDetail1" align="left">
							<TD WIDTH=100 HEIGHT=25>
							${data.subjecttitle }
							</td>
							<Td align="left">
								<c:if test="${(data.subjectstyle) == 0}">0</c:if>
								<c:if test="${(data.subjectstyle) == 1}">1</c:if>
								<c:if test="${(data.subjectstyle) == 2}">2</c:if>
								<c:if test="${(data.subjectstyle) == 3}">3</c:if>
								<c:if test="${(data.subjectstyle) == 4}">4</c:if>
							</Td>
							<TD WIDTH=115 align="left">${data.remindtime }</TD>
							<TD width="40" align="left">
								<c:if test="${(data.remainSet)==0}">
									永不
								</c:if>
								<c:if test="${(data.remainSet)==1}">
									每日
								</c:if>
								<c:if test="${(data.remainSet)==2}">
									每周
								</c:if>
								<c:if test="${(data.remainSet)==3}">
									每两周
								</c:if>
								<c:if test="${(data.remainSet)==4}">
									每月
								</c:if>
								<c:if test="${(data.remainSet)==5}">
									每年
								</c:if>
							</TD>
							<TD width="50" align="left">
								<c:if test="${(data.importantLevel)==0}">
									不重要
								</c:if>
								<c:if test="${(data.importantLevel)==1}">
									一般
								</c:if>
								<c:if test="${(data.importantLevel)==2}">
									重要
								</c:if>
							</TD>
							<TD  align="left"><c:if test="${(data.state) == 0}">
									启用
								</c:if>
								<c:if test="${(data.state) == 1}">
									停止
								</c:if>
							</td>
							<TD width="150" align="left">
									<td>
									<a href="showworknotepad.do?style=1&schedulId=${data.id }" title="点击修改">
										修改
									</a>
									<a href="showworknotepad.do?style=1&schedulId=${data.id }" title="点击查看">
										查看
									</a>
									暂停/启用|删除
							</td>									
						</TR>		
					</c:forEach>
					</c:if>				
					<tr>
						<!-- 自定义分页标签 -->
						<TD nowrap class="bg0" colSpan=7 height=30 align="right"><p:pages url="goListworknotepad.do?planStyle=1"/></TD>
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
						var url = "selectByDateworknotepad.do?planStyle=2&selectDate=" + dp.cal.getDateStr();
						 $.post(url,function(data)
				         {
				            $("#t1").html(data);
				        });
					    //window.location.href="goListworknotepad.do?planStyle=1&selectDate=" + dp.cal.getDateStr();
					}
				 })
				 </script>
		</DIV>
		</TD>
		</TR>
	</TABLE>
	</DIV>
</body>
</HTML>
