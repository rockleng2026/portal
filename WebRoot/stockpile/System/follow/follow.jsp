<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>流程跟踪</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function showd(str)
	{
		var obj=new Object();
		obj.name=str;
		window.showModalDialog("<%=request.getContextPath() %>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}
</script>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>

		
		
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
										&nbsp;流程跟踪
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
									
										<TD width="18%" class=category>
											单号
										</TD>
										<TD width="10%" class=category>
											审核状态
										</TD>
										<TD width="15%" class=category>
											接收时间
										</TD>
										<TD width="10%" class=category>
											接收人
										</TD>
										<TD width="15%" class=category>
											审核时间
										</TD>
										<TD width="10%" class=category>
											审核人
										</TD>
										<TD width="10%" class=category>
											审核意见
										</TD >
										<TD width="10%" class=category>
										操作
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${alist}" var="data" >
											<TR >
												
												<TD align=center height=25>
											
													${data.orderNo}
												</TD>
												<TD align=center>
													<c:if test="${data.auditingFlag==0||data.auditingFlag==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingFlag==1 }">
													已审核
													</c:if>
												</TD>
												<TD align=center>
											   ${data.incepttime}
												
												</TD>
												<TD align=center>
												${data.employeeByInceptemp.name}
													
												</TD>
												<TD align=center>
												${data.auditingtime}
													</TD>
													<TD align=center>
													${data.employeeByEmpId.name}
													
												</TD>
												<TD align="center">
												
												<c:if test="${fn:length(data.tmp)>20}">
													${fn:substring(data.tmp, 0, 20)}...<a style="color: red;cursor: hand;" onclick="showd('${data.tmp }')">详细</a>
													</c:if>
													<c:if test="${fn:length(data.tmp)<20}">
													${data.tmp }<a style="color: red;cursor: hand;" onclick="showd('${data.tmp }')">详细</a>
													</c:if>
												</TD>
												<TD>
													<a href="fjlistcommonaction.do?sbh=${data.sbh }&isok=1">附件列表</a>
												</TD>
											</TR>
											</c:forEach>

	<tr>
								<td class=category colSpan=14 height=30>
										
									</td>
									</tr>
								</TBODY>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
