<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>库存预警</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<base target="_self"/> 
</head>
<body>
		<FORM name=form2 action="getWarning.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							仓库名称：
							<INPUT name="depotName" id="depotName" value="">&nbsp;&nbsp;
							产品名称：
							<INPUT name="productName" id="productName" value="">&nbsp;&nbsp;
							<INPUT class=button type=submit  value=" 筛选查询 ">
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
										&nbsp;库存预警记录查询
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
										<TD width="10%" class=category>
											行号
										</TD>
										<TD width="20%" class=category>
											仓库
										</TD>
										<TD width="20%" class=category>
											产品名称
										</TD>
										<TD width="20%" class=category>
											规格型号
										</TD>
									
										<TD width="20%" class=category>
											架下数量
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" varStatus="status">
											<c:if test="${data.tmp1<=3}">
											<TR>
												<TD align=middle>
													${status.index+1 }
												</TD>
												<TD align=middle>
													<a href="finddepot.do?id=${data.depot.id }">${data.depot.name}</a>
												</TD>
												<TD align=middle>
													<a href=""></a>${data.property.name}
												</TD>
												<TD align=middle>
													${data.property.model.name}
												</TD>
												<TD align=middle>
													<font color="red">${data.tmp1}</font>
												</TD>
											</TR>
										</c:if>
									</c:forEach>
									<!--循环结束-->
								<tr>
									<TD class=category colSpan=16 height=30 align="right">
								     <p:pages url="getWarning.do"/>
								     
									</TD>
									</tr>
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
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
