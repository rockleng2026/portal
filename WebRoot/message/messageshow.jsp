<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>消息</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
function showInfo(id)
	{
		alert(id);
		//window.showModalDialog("<%=request.getContextPath() %>/workLogs/goDealWorkLog.do?id="+id,obj,"dialogWidth=900px;dialogHeight=600px");
		
		var nowDate = (new Date()).getTime();
		var url = "<%=request.getContextPath() %>/getmessage.do?id="+id+"&dd="+nowDate;
		window.location.href=url;
	}
	function showd(str)
	{
		var obj=new Object();
		obj.name=str;
		window.showModalDialog("<%=request.getContextPath() %>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}
</script>
</head>
<body>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;<c:if test="${mark==0}">未读信息</c:if>
										<c:if test="${mark==1}">已读信息</c:if>
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						
						<FORM name=form1 action="" onsubmit="">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="10%" class=category>
											消息类型
										</TD>
										<TD width="10%" class=category>
											消息标题
										</TD>
										<TD width="55%" class=category>
											消息内容
										</TD>
										<TD width="15%" class=category>
											读取状态
										</TD>
										<TD width="10%" class=category>
											读取
										</TD>
										<TD width="10%" class=category>
											删除
										</TD>
									</TR>
									<!--循环-->
                                   
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>											
												<TD align=middle>
												${data.message.messagetypeByMessagetype.type }
												</TD>
												<TD align=middle>
												${data.message.titleweb }
												</TD>
												<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('${data.message.messageid }')">查看内容</a>
											</TD>	
												<TD align=middle>
													<c:if test="${data.readfalg==1 }">
													${data.receivetime }
													</c:if>
													<c:if test="${data.readfalg==0 }">
													未读取
													</c:if>
												</TD>
												<TD align=middle>
												<c:if test="${mark==0}">
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.message.messageid}" name=duqu>
														</c:if>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.receiverid }" name=ids>
												</TD>
											</TR>
											</c:forEach>
					
											<TR>

											</tr>
									<!--循环结束-->




									<TD class=category colSpan=12 height=30 align="right">
													<c:if test="${mark==0}">
								     					<INPUT id=duall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=duquAll(this.form) type=checkbox value=select
															name=duall>
														全选(读取)
														
														<INPUT name="delbut" type=button class=button
															onclick="duqumess('changestatemessage.do','selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248')"
															value="读取">
															</c:if>
								     					<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选(删除)
														
													<c:if test="${mark==0}">
														<INPUT name="delbut" type=button class=button
															onclick="delmes('delmesflagmessage.do','selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248')"
															value="删 除">
															</c:if>
															<c:if test="${mark==1}">
														<INPUT name="delbut" type=button class=button
															onclick="delmes('delmesflagmessage.do','selmessbyreadflagmessage.do?restypeid=1&readflag=1&funid=247')"
															value="删 除">
															</c:if>
									</TD>
								</TBODY>
							</TABLE>
				</FORM>
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD>
					<c:if test="${mark==0}">
					<p:pages url="selmessbyreadflagmessage.do?restypeid=1&readflag=0&funid=248"/>
					</c:if>
					<c:if test="${mark==1}">
					<p:pages url="selmessbyreadflagmessage.do?restypeid=1&readflag=1&funid=247"/>
					</c:if>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
