<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<title>$(formname }查询页面</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function formquery(stateId)
	{
		window.location.href="formdatalistBusinessAction.do?state="+stateId;
	}
	function addfj(sbh)
	{
		window.location.href="uploadfiles.jsp?sbh="+sbh;
	}
</script>
</head>

<body>
		<FORM name=form2 action="formdatalistBusinessAction.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<a href="javascript:void(0);" onclick="addfj('${sbh }')" title="点击单独添加附件">添加附件</a>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;${sbh  }-附件列表
									</TD>
									<TD align=right>
										
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
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR  id="tr${data.id}">
												<TD width="50" align=middle>
												行号
												</TD>
												<TD align=middle>
												附件名称
												</TD>
												<TD align=middle>
												附件后缀
												</TD>
												<td align=middle>
													操作
												</td>
											</TR>
									<!--循环-->                             
									<c:forEach items="${pages.pageList}" var="data" varStatus="status">
											<TR  id="tr${data.id}">
												<TD width="50" align=middle>
												${status.index+1 }
												</TD>
												<TD align=middle>
												${data.fjmc }
												</TD>
												<TD align=middle>
												${data.fjhz }
												</TD>
												<TD align=middle>
													<a href="<%=request.getContextPath() %>${data.fjlj }">下载</a>
													<a href="<%=request.getContextPath() %>/form/afterform/viewfj.jsp?path=${data.fjlj }" target="_blank" >查看</a>
												</TD>
											</TR>
											</c:forEach>
											<TR>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
						<!--endprint-->
					</TD>
					<TD>
					<br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD><p:pages url="fjlistcommonaction.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<jsp:include page="floatdiv.jsp"></jsp:include>
	</BODY>
</HTML>
