<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
    <TITLE>OA8000增强版_FUMYSQL5--我的桌面</TITLE>
    <META content="MSHTML 6.00.2800.1276" name=GENERATOR>
    <META http-equiv=Content-Type content="text/html; charset=gbk">
    <META http-equiv=Content-Style-Type content=text/css>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta name="viewport" content="width=device-width,minimum-scale=1.0"/>
    <script language="javascript" src="/htoa/js/stm31.js"></script>
<script language="javascript" src="/htoa/temp/Menu200FILE215952825066V65.js"></script>
<script language="javascript" src="/htoa/js/CN/prototype.js"></script>
<script language="javascript" src="/htoa/js/CN/buffalo.js"></script>
<script language="javascript" src="/htoa/js/CN/desktopTitle.js"></script>
<script language="javascript" src="/htoa/js/desktopMove.js"></script>
<script language="javascript" src="/htoa/js/desktop.js"></script>
<script language="javascript" src="/htoa/js/desktopData.js"></script>
<script language="javascript" src="/htoa/js/desktopFunc.js"></script>
<script language="javascript" src="/htoa/js/pageCommon.js"></script>
<script language="javascript" src="/htoa/js/pictureNews.js"></script>

	<LINK href="/htoa/css/CN/BLUE/desktop.css" type=text/css  media=screen rel=stylesheet>
<LINK href="/htoa/css/comm/BLUE/mode.css" type=text/css  media=screen rel=stylesheet>

	
    <base target="_self">
</HEAD>
<body marginwidth="0" topmargin="0" leftmargin="0" onload="onLoad()" marginheight="0">
<script language=javascript>
	var endPointTop='/OAapp/bfapp';
	var waitingImg='/htoa/image/loading.gif';
	var minImg='/htoa/image/comm/BLUE/desktop/min.gif';
	var revertImg='/htoa/image/comm/BLUE/desktop/revert.gif';
	var loadingImg='/htoa/image/loading.gif';
	var listImg='/htoa/image/comm/BLUE/desktop/list.gif';
	var moreImg='/htoa/image/comm/BLUE/desktop/more.gif';
	var newImg='/htoa/image/new.gif';
	var userId='admin';
	var deptId='^DEPT004047LL';
	var xmlPath='/htoa/js/CN/city/';
	var weatherImgPath='/htoa/image/weather/';
</script>

<form method="post" id="actForm" name="actForm" action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2"><a id="msgQuery" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2.0"></a><a id="fileDownload" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2.1"></a><a id="addressQuery" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2.2"></a><a id="submitVotting" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2.3"></a><a id="viewVotting" href="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.0.2.4"></a><DIV ID=Content>
			<DIV STYLE="width:50%; float:left;" ID=sub>
				
                    <div urlvalue="Oasp2903" functionid="FUNC00005" urlname="新闻" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00005">
                    <DIV ID=Block>
                        <DIV ID=BlockHead>
                            <TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
                                <TR VALIGN=center>
                                    <TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00005.gif" /></TD>
                                    <td>新闻</td>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00005Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00005');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
                                    <TD WIDTH=5></TD>
                                </TR>
                            </TABLE>
                        </DIV>
                        <div class="BlockMemo" id="FUNC00005MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                    </DIV>
                    </div>
                
                    <div urlvalue="Oasp9006" functionid="FUNC00019" urlname="待我审批" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00019">
                    <DIV ID=Block>
                        <DIV ID=BlockHead>
                            <TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
                                <TR VALIGN=center>
                                    <TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00019.gif" /></TD>
                                    <td>待我审批</td>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00019Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00019');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
                                    <TD WIDTH=5></TD>
                                </TR>
                            </TABLE>
                        </DIV>
                        <div class="BlockMemo" id="FUNC00019MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                    </DIV>
                    </div>
                
                    <div urlvalue="Oasp0201" functionid="FUNC00003" urlname="通知" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00003">
                    <DIV ID=Block>
                        <DIV ID=BlockHead>
                            <TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
                                <TR VALIGN=center>
                                    <TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00003.gif" /></TD>
                                    <td>通知</td>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00003Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00003');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
                                    <TD WIDTH=5></TD>
                                </TR>
                            </TABLE>
                        </DIV>
                        <div class="BlockMemo" id="FUNC00003MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                    </DIV>
                    </div>
                
                    <div urlvalue="Oasp5203" functionid="FUNC00025" urlname="桌面新闻" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00025">
                    <DIV ID=Block>
                        <DIV ID=BlockHead>
                            <TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
                                <TR VALIGN=center>
                                    <TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00025.gif" /></TD>
                                    <td>桌面新闻</td>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00025Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00025');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
                                    <TD WIDTH=5></TD>
                                </TR>
                            </TABLE>
                        </DIV>
                        <div class="BlockMemo" id="FUNC00025MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                    </DIV>
                    </div>
                
                    <div urlvalue="Oasp3003" functionid="FUNC00002" urlname="已收文件" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00002">
                    <DIV ID=Block>
                        <DIV ID=BlockHead>
                            <TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
                                <TR VALIGN=center>
                                    <TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00002.gif" /></TD>
                                    <td>已收文件</td>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00002Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00002');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
                                    <TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
                                    <TD WIDTH=5></TD>
                                </TR>
                            </TABLE>
                        </DIV>
                        <div class="BlockMemo" id="FUNC00002MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                    </DIV>
                    </div>
                
			</DIV>
			<DIV STYLE="width:50%; float:right;" ID=right>
				<div functionid="FUNC00007" urlname="公司格言" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00007">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00007.gif" /></TD>
										<td>公司格言</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00007Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00007');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00007MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div><div urlvalue="Oasp2803" functionid="FUNC00004" urlname="公告" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00004">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00004.gif" /></TD>
										<td>公告</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00004Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00004');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00004MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div><div functionid="FUNC00012" urlname="待办提醒" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00012">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00012.gif" /></TD>
										<td>待办提醒</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00012Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00012');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00012MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div><div functionid="FUNC00013" urlname="通讯录查询" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00013">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00013.gif" /></TD>
										<td>通讯录查询</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00013Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00013');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00013MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div><div urlvalue="Oasp3103" functionid="FUNC00001" urlname="短消息" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00001">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00001.gif" /></TD>
										<td>短消息</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00001Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00001');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00001MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div><div urlvalue="Oasp1219" functionid="FUNC00010" urlname="快捷方式" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00010">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="/htoa/image/comm/BLUE/desktop/FUNC00010.gif" /></TD>
										<td>快捷方式</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00010Min" src="/htoa/image/comm/BLUE/desktop/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00010');" alt="刷新" src="/htoa/image/comm/BLUE/desktop/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="/htoa/image/comm/BLUE/desktop/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00010MAX"><img border="0" src="/htoa/image/loading.gif" /></div>
                        </DIV>
						</div>
			</DIV>
            <p></p>
            <p></p>
            <p></p>
		</DIV>
    <input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" /></form>
    <form method="post" name="homeForm" action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.1"><input type="hidden" name="alertMsg" /> <input type="hidden" name="newUrl" /> <input type="hidden" name="newWindow" />
    <input type="hidden" name="confirmMsg" /> <input type="hidden" value="OA8000增强版_FUMYSQL5--我的桌面" name="topTitle" /><input type="hidden" value="desktop" name="pgID" /><input type="hidden" name="returnPage" /><input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" /></form>
    <form method="post" id="menuForm" action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.2.1"><script type="text/javascript" language="JavaScript1.2">
writeMenu(false);
</script>
<input type="hidden" name="url" /><input type="hidden" name="urlName" /><input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" /></form>
</body>
</HTML>