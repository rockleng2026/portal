<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'noticeMessageList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
  </head>
<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
  <body>
<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor="#FFF" border="0">
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
										&nbsp;所有公告
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
									
										<TD width="20%" class=category>
											公告标题
										</TD>
										<TD width="30%" class=category>
											公告内容
										</TD>
										<TD width="15%" class=category>
											发送人
										</TD>
										<TD width="15%" class=category>
											类型
										</TD>
										<TD width="20%" class=category>
											发送时间
										</TD>
									</TR>
									<!--循环-->
                                   
									<c:forEach items="${pages.pageList}" var="data" >											
											<TR>											
												<TD align="middle">
													<!--  <input type="hidden" id="id" name="id" value="${data.messageid }"/>-->
													<A href="getmessage.do?id=${data.messageid }">${data.titleweb }</A>
												</TD>												
												<TD align="middle">																										
													<c:if test="${fn:length(data.messagecontent)>40}">
														<a href="getmessage.do?id=${data.messageid }">${fn:substring(data.messagecontent, 0, 40)}...</a>
													</c:if>
													<c:if test="${fn:length(data.messagecontent)<40}">
														<a href="getmessage.do?id=${data.messageid }">${data.messagecontent }</a>
													</c:if>
												</TD>
												<td align="middle">
													<!-- 发送人模块   先判断是员工或客户再取得姓名 -->
													<c:if test="${(data.messagetypeBySendertype.messagetypeid) == 1}">
														<c:forEach items="${employeeList}" var="emp" >
															<c:if test="${data.sender == emp.id }">
																${emp.name }
															</c:if>
														</c:forEach>
													</c:if>
													<c:if test="${(data.messagetypeBySendertype.messagetypeid) == 2}">
														<c:forEach items="${customerList}" var="cus" >
															<c:if test="${data.sender == cus.customerId }">
																${cus.customerName }
															</c:if>
														</c:forEach>
													</c:if>
												</td>
												<TD align="middle">
													${data.messagetypeByMessagetype.type }
												</TD>
												<TD align="middle">
													${fn:substring(data.releasetime, 0, 16) }
												</TD>
											</TR>		
									</c:forEach>					
									<tr>
										<TD nowrap class="bg0" colSpan=5 height=30 align="right"><p:pages url="allNoticemessage.do"/></TD>
									</tr> 	
									<!--循环结束-->
								</TBODY>
									
							</TABLE>
					</FORM>
						<!--endprint-->
					</TD>					
				</TR>
				
			</TBODY>
		</TABLE>		
  </body>
</html>
