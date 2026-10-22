<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>服务器列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<base target="_self">
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

	
<body>
		<FORM name=form2 action="showDialogOutbound.do?mark=supplier" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							服务器名称：
							<INPUT name=name>
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
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
										&nbsp;服务器查询
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
									
										<TD width="13%" height=30 class=category>
											唯一编码
										</TD>
										
										<TD width="12%" class=category>
											服务器名称
										</TD>
										<TD width="9%" class=category>
											购买日期
										</TD>
										<TD width="21%" class=category>
											购买价格
										</TD>
										<TD width="12%" class=category>
											配置信息
										</TD>
										<TD width="18%" class=category>
											建立日期
										</TD>
									
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR id="tr${data.id }"  ondblclick="getvalue('${data.id}-${data.property.name }',${data.id })" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'" >
											
												<TD align=center height=25>
													 ${data.barcode}
												</TD>
												<TD align=center>
														${data.property.name}
												</TD>
												<TD align=center>
												
												</TD>
												<TD align=center>
													${data.property.temp2}
												</TD>
												<TD align=center>
													${data.property.temp3}
													</TD>
													<TD align=center>
													${data.property.temp4}
												</TD>
											
											</TR>
											</c:forEach>
											
									<!--循环结束-->
									
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
					<TD> <p:pages url="getserverServerMonitoring.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>