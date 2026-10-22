<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>报溢单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<base target="_self"/> 
</head>
<body>
		<FORM name=form2 action="showDialogOutbound.do?mark=income" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							报溢单号：
							<INPUT name="incomeNo" id="incomeNo" >
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="">
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
										&nbsp;报溢单记录查询
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
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
										<TD width="15%" class=category>
											报溢单号
										</TD>
										<TD width="10%" class=category>
											审核状态
										</TD>
										
										<TD width="10%" class=category>
											经办人
										</TD>
										<TD width="15%" class=category>
											记录时间
										</TD>
										<TD width="10%" class=category>
											总价格
										</TD>
										<TD width="10%" class=category>
											是否已入库
										</TD>
									
									</TR>


									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR ondblclick="getvalue('${data.id},${data.incomeNo }')" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=middle>
												${data.incomeNo }
												</TD>
												<TD align=middle>
													<c:if test="${data.auditingState==0||data.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingState==1}">
													已审核
													</c:if>
												</TD>
											
												
													<TD align=middle>
													${data.employee.name}
												</TD>
													<TD align=middle>
													<c:set var="birthDate" scope="request" value="${data.itime}"  />
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
												</TD>
												<TD align=middle>
													${data.allSum}
												</TD>
												<TD align=middle>
												<c:if test="${data.inmark==0||data.inmark==null}">
													未入库
													</c:if>
													<c:if test="${data.inmark==1}">
													已入库
													</c:if>
													
												</TD>
											</TR>
											</c:forEach>
					
											<TR>
											</tr>
									<!--循环结束-->



									<!-- 
									<TD class=category colSpan=12 height=30 align="right">
								     
								     	<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<INPUT name="delbut" type=button class=button
															onclick="del('delTheDamage.do','queryTheDamage.do')"
															value="删 除">
									</TD>
									 -->
								</TBODY>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD> <pp:pages1 url="showDialogOutbound.do" param="mark=income&num=${num}"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
