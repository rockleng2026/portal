<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>福奥进销存-我的桌面</TITLE>
		<META content="MSHTML 6.00.2800.1276" name=GENERATOR>
		<META http-equiv=Content-Type content="text/html; charset=gbk">
		<META http-equiv=Content-Style-Type content=text/css>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0" />
		<script language="javascript" src="../js/desk/stm31.js"></script>
		<script language="javascript"
			src="../js/desk/Menu200FILE215952825066V65.js"></script>
		<script language="javascript" src="../js/desk/prototype.js"></script>
		<script language="javascript" src="../js/desk/buffalo.js"></script>
		<script language="javascript" src="../js/desk/desktopTitle.js"></script>
		<script language="javascript" src="../js/desk/desktopMove.js"></script>
		<script language="javascript" src="../js/desk/desktop.js"></script>
		<script language="javascript" src="../js/desk/desktopData.js"></script>
		<script language="javascript" src="../js/desk/desktopFunc.js"></script>
		<script language="javascript" src="../js/desk/pageCommon.js"></script>
		<script language="javascript" src="../js/desk/pictureNews.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>

		<LINK href="../Css/desk/desktop.css" type=text/css media=screen
			rel=stylesheet>
		<LINK href="../Css/desk/mode.css" type=text/css media=screen
			rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>
		<base target="_self">

		<SCRIPT type="text/javascript">
    	function refresh(){
			//alert('refreshX');
			var t=new Date();
			var url="getmyreceivemission.do?t="+t;
			//alert('123');
		   	$.post(url,{},
		   		function(data)
		        {
		        	//alert(data);
		        	////alert('funs');
		            //window.location.href = location;
		            //location.reload();
		           // alert('funs');
		        }
		    );
		}
	</script>
	</HEAD>
	<body marginwidth="0" topmargin="0" leftmargin="0" onload="onLoad()"
		marginheight="0">
		<script language="javascript">
	var endPointTop='/OAapp/bfapp';
	var waitingImg='../images/desk/loading.gif';
	var minImg='../images/desk/min.gif';
	var revertImg='../images/desk/revert.gif';
	var loadingImg='../images/desk/loading.gif';
	var listImg='../images/desk/list.gif';
	var moreImg='../images/desk/more.gif';
	var newImg='../images/desk/new.gif';
	var userId='admin';
	var deptId='^DEPT004047LL';
	var xmlPath='/htoa/js/CN/city/';
	var weatherImgPath='../images/desk/weather/';
</script>






















		<form method="post" id="actForm" name="actForm"">
			<DIV ID=Content>
				<!-- 左边左面开始 -->
				<DIV STYLE="width: 50%; float: left;" ID=sub>
					<!--任务安排开始 -->
					<div urlvalue="Oasp2903" functionid="FUNC00005" urlname="任务安排"	recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00005">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
									WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25>
											<img border="0" width="15" height="15"
												src="../images/desk/FUNC00019.gif" />
										</TD>
										<td>
											任务安排
										</td>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
												id="FUNC00005Min" src="../images/desk/min.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="location.reload();" alt="刷新"
												src="../images/desk/refresh.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
												src="../images/desk/close.gif" />
										</TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
							<div style="padding: 0pt;" urlname="任务安排" urlvalue="Oasp2803"	recordcount="5" class="BlockMemo" id="FUNC00004MAX">
							<div id="BlockDetail">
									<ul>
										<!-- 循环开始 -->
										<c:if test="${empty pagesMission.pageList}">
											<li class="DetailLine">
												无工作任务安排
											</li>
										</c:if>
										<c:forEach items="${pagesMission.pageList}" var="nrmission">
											<li class="DetailLine">
												<div class="DetailLineInfo">
													<img src="../images/desk/list.gif" border="0" height="8"
														width="8">
													<A
														href="getmyreceivemission.do?missionId=${nrmission.mission.taskId }">${nrmission.mission.name
														}</A>
												</div>
												<div class="DetailLineTime1">
													${fn:substring(nrmission.buildTime, 0, 16) }&nbsp;
												</div>
												<div class="DetailLineName">
													${nrmission.mission.missiontype.name }&nbsp;
												</div>
												<div class="DetailLineName">
													${nrmission.mission.employee.name }&nbsp;
												</div>
											</li>
										</c:forEach>

										<!--循环结束-->
									</ul>
							</div>
							</div>
							<div id="BlockFoot">
								<div id="BlockFootMore">
									<img src="../images/desk/more.gif" border="0" height="8"
										width="9">
									<a href="getmyreceivemission.do">更多...</a>
								</div>
							</div>
						</div>
					</div>
					<!--任务安排结束 -->

					<!-- 待办提醒开始 -->
					<div urlvalue="Oasp9006" functionid="FUNC00019" urlname="待办提醒"	recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00019">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
									WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25>
											<img border="0" width="15" height="15"
												src="../images/desk/FUNC00019.gif" />
										</TD>
										<td>
											待办审核单据提醒
										</td>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
												id="FUNC00019Min" src="../images/desk/min.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="location.reload();" alt="刷新"
												src="../images/desk/refresh.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
												src="../images/desk/close.gif" />
										</TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
							
							<div style="padding: 0pt;" urlname="待办审核" urlvalue="Oasp2803"	recordcount="5" class="BlockMemo" id="FUNC00004MAX">
								<c:if test="${empty backlogList}">
									<li class="DetailLine">
										无待办审核
									</li>
								</c:if>
								<c:if test="${not empty backlogList}">
									<c:forEach items="${backlogList }" var="backlog"
										varStatus="status">
										<c:forEach items="${orderlist}" var="order">
											<c:if test="${backlog.verifyOrder.id == order.id}">
												<input type="button"
													onclick="urllist('${order.ordertype.temp2}')"
													value="${order.ordertype.aname }(${backlog.tmp})"
													style="height: 30px; border: 0px; background-image: url(../images/desk/awokeBtn_bg.gif); background-repeat: repeat-x;" />
											</c:if>
										</c:forEach>
									</c:forEach>
								</c:if>
							</div>
							<div id="BlockFoot">
								<div id="BlockFootMore">
									<img src="../images/desk/more.gif" border="0" height="8"
										width="9">
									<a href="#">更多...</a>
								</div>
							</div>
						</DIV>
					</div>
					<!-- 待办提醒结束 -->

					<!-- 今日任务开始 -->
					<div urlvalue="Oasp0201" functionid="FUNC00003" urlname="工作日程计划"
						recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00003">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
									WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25>
											<img border="0" width="15" height="15"
												src="../images/desk/FUNC00003.gif" />
										</TD>
										<td>
											工作日程计划
										</td>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
												id="FUNC00003Min" src="../images/desk/min.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="location.reload();" alt="刷新"
												src="../images/desk/refresh.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
												src="../images/desk/close.gif" />
										</TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
							<div style="padding: 0pt;" class="BlockMemo" id="FUNC00003MAX">
								<div>
									<ul>
										<!-- 循环开始 -->
										<c:if test="${empty pagesPlan.pageList}">
											<li class="DetailLine">
												无工作日程安排
											</li>
										</c:if>
										<c:forEach items="${pagesPlan.pageList}" var="plan">
											<li class="DetailLine">
												<div class="DetailLineInfo">
													<A
														href="goListworknotepad.do?planStyle=
												<c:if test="${plan.plantype == 5}">0</c:if>
												<c:if test="${plan.plantype ==0 || plan.plantype ==1 || plan.plantype ==2 || plan.plantype ==3 || plan.plantype ==4 }">1</c:if>
												">
														<c:if test="${plan.plantype == 6}">2</c:if> <c:if
															test="${fn:length(plan.subjecttitle)>=40}">${fn:substring(plan.subjecttitle,0,40 )}...</c:if>
														<c:if test="${fn:length(plan.subjecttitle)< 40}">${fn:substring(plan.subjecttitle,0,40 )}</c:if>
													</A>
												</div>
												<div class="DetailLineName">
													<c:if test="${plan.plantype == 5}">日程记事</c:if>
													<c:if test="${plan.plantype == 6}">日程提醒</c:if>
													<c:if
														test="${plan.plantype ==0 || plan.plantype ==1 || plan.plantype ==2 || plan.plantype ==3 || plan.plantype ==4 }">日程计划</c:if>
													&nbsp;
												</div>
												<div class="DetailLineName">
													${plan.employee.name }&nbsp;
												</div>
											</li>
										</c:forEach>
										<!--循环结束-->
									</ul>
								</div>
							</div>
							<div id="BlockFoot">
								<div id="BlockFootMore">
									<img src="../images/desk/more.gif" border="0" height="8"
										width="9">
									<a href="goListworknotepad.do?planStyle=0">更多...</a>
								</div>
							</div>
						</DIV>
					</div>
					<!-- 今日任务结束 -->
					
					<!-- 日志审批提醒 -->
					<div urlvalue="Oasp9006" functionid="FUNC00019" urlname="日志审批提醒"
						recordcount="7" minflg="0" class="DesktopBlock" id="FUNC00019">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
									WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25>
											<img border="0" width="15" height="15"
												src="../images/desk/FUNC00019.gif" />
										</TD>
										<td>
											日志审批提醒
										</td>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
												id="FUNC00019Min" src="../images/desk/min.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="location.reload();" alt="刷新"
												src="../images/desk/refresh.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
												src="../images/desk/close.gif" />
										</TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
							<div style="padding: 0pt;" class="BlockMemo" id="FUNC00003MAX" recordcount="7">
								<div>
									<ul>
										<!-- 循环开始 -->
										<c:if test="${empty ensurelist.pageList}">
											<li class="DetailLine">
												无新批阅
											</li>
										</c:if>
										<c:forEach items="${ensurelist.pageList}" var="log">
											<li class="DetailLine">
												<div class="DetailLineInfo">
													<A
														href="goSeeReply2WorkLog.do?id=${log.id }">${log.logNo
														}</A>
												</div>
												<div class="DetailLineName">
													新的批注&nbsp;
												</div>
												<div class="DetailLineName">
													${log.replyTime }&nbsp;
												</div>
											</li>
										</c:forEach>
										<!--循环结束-->
										<!-- 循环开始 -->
										<c:if test="${empty replylist.pageList}">
											<li class="DetailLine">
												无日志批阅
											</li>
										</c:if>
										<c:forEach items="${replylist.pageList}" var="log">
											<li class="DetailLine">
												<div class="DetailLineInfo">
													<A
														href="goAddNewReplyWorkLog.do?logNo=${log.orderNo }&audid=${log.id }">${log.orderNo
														}</A>
												</div>
												<div class="DetailLineName">
													${log.employeeByEmpId.name }&nbsp;
												</div>
												<div class="DetailLineName">
													${log.incepttime }&nbsp;
												</div>
											</li>
										</c:forEach>
										<!--循环结束-->
									</ul>
								</div>
							</div>
						</DIV>
					</div>
					<!-- 日志审批提醒结束 -->
				</DIV>
				<!-- 左边桌面结束 -->

				<!-- 右边桌面开始 -->
				<DIV STYLE="width: 50%; float: right;" ID=right>

					<!-- 公司格言开始 -->
					<div functionid="FUNC00007" urlname="公司格言" recordcount="5"
						minflg="0" class="DesktopBlock" id="FUNC00007">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
									WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25>
											<img border="0" width="15" height="15"
												src="../images/desk/FUNC00007.gif" />
										</TD>
										<td>
											公司格言
										</td>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
												id="FUNC00007Min" src="../images/desk/min.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="location.reload();" alt="刷新"
												src="../images/desk/refresh.gif" />
										</TD>
										<TD WIDTH=14>
											<img width="11" height="11" border="0"
												onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
												src="../images/desk/close.gif" />
										</TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
							<div style="height: auto; padding: 0pt;" urlname="公司格言"
								urlvalue="" recordcount="5" class="BlockMemo" id="FUNC00007MAX">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody>
										<tr height="3">
											<td colspan="5"></td>
										</tr>
										<tr height="5">
											<td width="3px"></td>
											<td class="AdageTopLeft" width="5"></td>
											<td class="BlockDetailByAdage"></td>
											<td class="AdageTopRight" width="5"></td>
											<td width="3"></td>
										</tr>
										<tr>
											<td width="3px"></td>
											<td class="BlockDetailByAdage"></td>
											<td class="BlockDetailByAdage" align="left" height="121px;">
												<strong><font color="#0a0a8f" face="楷体_GB2312"
													size="4">1、努力了不一定成功，放弃了注定失败。</font>
												</strong>
												<br />
												<strong><font color="#0a0a8f" face="楷体_GB2312"
													size="4">2、思路决定出路，心态决定状态。</font>
												</strong>
												<br />
												<strong><font color="#0a0a8f" face="楷体_GB2312"
													size="4">3、计划你的工作，工作你的计划。</font>
												</strong>
												<br />
												<strong><font color="#0a0a8f" face="楷体_GB2312"
													size="4">4、以诚待人，以勤创业。</font>
												</strong>
												<br />
												<strong><font color="#0a0a8f" face="楷体_GB2312"
													size="4">5、强化竞争意识，营造团队精神。</font>
												</strong>
											</td>
											<td class="BlockDetailByAdage"></td>
											<td width="3px"></td>
										</tr>
										<tr height="5">
											<td width="3px"></td>
											<td class="AdageBottomLeft" width="5"></td>
											<td class="BlockDetailByAdage"></td>
											<td class="AdageBottomRight" width="5"></td>
											<td width="3"></td>
										</tr>
										<tr>
											<td colspan="5" height="3"></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div id="BlockFoot">
								<div id="BlockFootMore"></div>
							</DIV>
						</div>

						<!-- 公告开始 -->
						<div urlvalue="Oasp2803" functionid="FUNC00004" urlname="公告"
							recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00004">
							<DIV ID=Block>
								<DIV ID=BlockHead>
									<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
										WIDTH=100%>
										<TR VALIGN=center>
											<TD WIDTH=25>
												<img border="0" width="15" height="15"
													src="../images/desk/FUNC00004.gif" />
											</TD>
											<td>
												公告
											</td>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
													id="FUNC00004Min" src="../images/desk/min.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="location.reload();" alt="刷新"
													src="../images/desk/refresh.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
													src="../images/desk/close.gif" />
											</TD>
											<TD WIDTH=5></TD>
										</TR>
									</TABLE>
								</DIV>
								<div style="padding: 0pt;" urlname="公告" urlvalue="Oasp2803"
									recordcount="5" class="BlockMemo" id="FUNC00004MAX">
									<div id="BlockDetail">
										<ul>
											<!-- 循环开始 -->
											<c:if test="${empty pagesNotice.pageList}">
												<li class="DetailLine">
													无系统公告
												</li>
											</c:if>
											<c:forEach items="${pagesNotice.pageList}" var="data">
												<li class="DetailLine">
													<div class="DetailLineInfo">
														<img src="../images/desk/list.gif" border="0" height="8"
															width="8">
														<A href="getmessage.do?id=${data.messageid }">${data.titleweb
															}</A>

													</div>
													<div class="DetailLineTime">
														${fn:substring(data.releasetime, 5, 10) }
													</div>
													<div class="DetailLineName">
														<!-- 发送人模块   先判断是员工或客户再取得姓名 -->
														<c:if
															test="${(data.messagetypeBySendertype.messagetypeid) == 1}">
															<c:forEach items="${employeeList}" var="emp">
																<c:if test="${data.sender == emp.id }">
																	${emp.name }
																</c:if>
															</c:forEach>
														</c:if>
														<c:if
															test="${(data.messagetypeBySendertype.messagetypeid) == 2}">

															<c:forEach items="${customerList}" var="cus">
																<c:if test="${data.sender == cus.customerId }">
																	${cus.customerName }
																</c:if>
															</c:forEach>
														</c:if>
														<!-- 消息类型 -->
														${data.messagetypeByMessagetype.type }
													</div>
												</li>
											</c:forEach>
											<!--循环结束-->

										</ul>
									</div>

								</DIV>
								<div id="BlockFoot">
									<div id="BlockFootMore">
										<img src="../images/desk/more.gif" border="0" height="8"
											width="9">
										<a href="allNoticemessage.do">更多...</a>
									</div>
								</div>
							</DIV>
						</div>
						<!-- 公告结束 -->

						<div functionid="FUNC00012" urlname="待我审批" recordcount="5"
							minflg="0" class="DesktopBlock" id="FUNC00012">
							<DIV ID=Block>
								<DIV ID=BlockHead>
									<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
										WIDTH=100%>
										<TR VALIGN=center>
											<TD WIDTH=25>
												<img border="0" width="15" height="15"
													src="../images/desk/FUNC00012.gif" />
											</TD>
											<td>
												公司最新动态
											</td>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
													id="FUNC00012Min" src="../images/desk/min.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="location.reload();" alt="刷新"
													src="../images/desk/refresh.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
													src="../images/desk/close.gif" />
											</TD>
											<TD WIDTH=5></TD>
										</TR>
									</TABLE>
								</DIV>
								<div style="padding: 0pt;" urlname="公司最新动态" urlvalue="Oasp2803"
									recordcount="5" class="BlockMemo" id="FUNC00004MAX">
									<div id="BlockDetail">
										<ul>
											<c:if test="${empty pagesExe.pageList}">
												<li class="DetailLine">
													无可查看动态
												</li>
											</c:if>
											<!-- 循环开始 -->
											<c:forEach items="${pagesExe.pageList}" var="data">
												<li class="DetailLine">
													<!-- 动态内容 -->
													<div class="DetailLineInfo">
														<img src="../images/desk/list.gif" border="0" height="8"
															width="8">
														${data.employee.name } &nbsp;&nbsp;&nbsp;&nbsp;
														<A
															href="goDetailRecord.do?id=${data.id }&entityName=${data.entityName}&entityId=${data.entityId }">${data.content
															}</A>

													</div>
													<!-- 操作时间 -->
													<div class="DetailLineName">
														${data.executeTime }
													</div>
												</li>
											</c:forEach>
											<!--循环结束-->
										</ul>
									</div>
								</div>
								<div id="BlockFoot">
									<div id="BlockFootMore">
										<img src="../images/desk/more.gif" border="0" height="8"
											width="9">
										<a href="goMoreRecord.do">更多...</a>
									</div>
								</div>
							</DIV>
						</div>

						<div functionid="FUNC00013" urlname="即将到期事项提醒" recordcount="7"
							minflg="0" class="DesktopBlock" id="FUNC00013">
							<DIV ID=Block>
								<DIV ID=BlockHead>
									<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
										WIDTH=100%>
										<TR VALIGN=center>
											<TD WIDTH=25>
												<img border="0" width="15" height="15"
													src="../images/desk/FUNC00013.gif" />
											</TD>
											<td>
												即将到期事项提醒
											</td>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化"
													id="FUNC00013Min" src="../images/desk/min.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="refreshMode('FUNC00013');" alt="刷新"
													src="../images/desk/refresh.gif" />
											</TD>
											<TD WIDTH=14>
												<img width="11" height="11" border="0"
													onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭"
													src="../images/desk/close.gif" />
											</TD>
											<TD WIDTH=5></TD>
										</TR>
									</TABLE>
								</DIV>
								<div style="padding: 0pt;" urlname="即将到期事项提醒"
									urlvalue="Oasp2803" recordcount="7" class="BlockMemo"
									id="FUNC00004MAX">
									<div id="BlockDetail">
										<ul>
											<c:if test="${empty expiresList}">
												<li class="DetailLine">
													无提醒
												</li>
											</c:if>
											<%=request.getSession().getAttribute("username") %>			
											<%=request.getSession().getAttribute("ts") %>		
											<!-- 循环开始 -->
											<c:forEach items="${expiresList}" var="temp">
												<li class="DetailLine">
													<!-- 动态内容 -->
													<div class="DetailLineInfo">
														<img src="../images/desk/list.gif" border="0" height="8"
															width="8">
														<a
															href="selectTodo.do?eitTable=${temp.enitName}&ids=${temp.ids  }"; >
															${temp.name }(${temp.number}) </a>
													</div>

												</li>
											</c:forEach>
											<!--循环结束-->
										</ul>
									</div>
								</div>
							</DIV>
						</div>
						<!--<div urlvalue="Oasp3103" functionid="FUNC00001" urlname="短消息" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00001">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="../images/desk/FUNC00001.gif" /></TD>
										<td>短消息</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00001Min" src="../images/desk/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00001');" alt="刷新" src="../images/desk/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="../images/desk/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00001MAX"><img border="0" src="../images/desk/loading.gif" /></div>
                        </DIV>
						</div>
						<div urlvalue="Oasp1219" functionid="FUNC00010" urlname="快捷方式" recordcount="5" minflg="0" class="DesktopBlock" id="FUNC00010">
						<DIV ID=Block>
							<DIV ID=BlockHead>
								<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100% WIDTH=100%>
									<TR VALIGN=center>
										<TD WIDTH=25><img border="0" width="15" height="15" src="../images/desk/FUNC00010.gif" /></TD>
										<td>快捷方式</td>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="最小化" id="FUNC00010Min" src="../images/desk/min.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="refreshMode('FUNC00010');" alt="刷新" src="../images/desk/refresh.gif" /></TD>
										<TD WIDTH=14><img width="11" height="11" border="0" onclick="alert('桌面不允许用户自行关闭或最小化。');" alt="关闭" src="../images/desk/close.gif" /></TD>
										<TD WIDTH=5></TD>
									</TR>
								</TABLE>
							</DIV>
                            <div class="BlockMemo" id="FUNC00010MAX"><img border="0" src="../images/desk/loading.gif" /></div>
                        </DIV>
						</div>
			</DIV>		 -->
						<!-- 页脚开始 -->

						<!-- 页脚结束 -->
					</DIV>
				</DIV>
				<input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" />
		</form>

		<form method="post" name="homeForm"
			action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.1">
			<input type="hidden" name="alertMsg" />
			<input type="hidden" name="newUrl" />
			<input type="hidden" name="newWindow" />
			<input type="hidden" name="confirmMsg" />
			<input type="hidden" value="福奥进销存系统--我的桌面" name="topTitle" />
			<input type="hidden" value="desktop" name="pgID" />
			<input type="hidden" name="returnPage" />
			<input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" />
		</form>
		<form method="post" id="menuForm"
			action="/OAapp/WebObjects/OAapp.woa/wo/com.oa8000.proj.root.Desktop/8AS0LZF0YgvSGYmPxP1QI0/56.0.11.2.1">
			<script type="text/javascript" language="JavaScript1.2">
			writeMenu(false);
		</script>
			<input type="hidden" name="url" />
			<input type="hidden" name="urlName" />
			<input type="hidden" name="wosid" value="8AS0LZF0YgvSGYmPxP1QI0" />
		</form>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR align="center">
				<TD vAlign=bottom height="50%">
					<TABLE cellSpacing=0 cellPadding=0 width="90%" align=center
						border=0>
						<TBODY>
							<tr align="center">
								<td>
									&nbsp;
								</td>
							</tr>
							<TR>
								<TD align=right height=25>
									产品开发：福奥科技
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
					<DIV style="COLOR: #003300; TEXT-ALIGN: right">
						-----------------------------------------------
					</DIV>
					<DIV style="HEIGHT: 30px; TEXT-ALIGN: right">
						Copyright (c) 2007-2008 . All Rights Reserved .
					</DIV>
				</TD>
			</TR>
		</TABLE>
		

		
	</body>
	<script type="text/javascript">
	function urllist(url)
	{
		window.location.href = url;
	}
</script>
</HTML>