<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<title>员工登陆记录</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<SCRIPT>

		
		
</SCRIPT>

		<FORM name=form2 action="selectemp.do?funid=14" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							
							
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
										&nbsp;员工登陆信息
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
						<FORM name=form1 action="" onsubmit="">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR>
										<TD align="center" width="60" class=category>
											登陆账号
										</TD>
										<TD align="center" width="60" class=category>
											用户名
										</TD>
										<TD align="center" width="60" height=30 class=category>
											登陆次数
										</TD>
										<TD align="center" width="100" class=category>
											账号注册时间
										</TD>
										<TD align="center" width="120" class=category>
											最后一次登陆时间
										</TD>
										<TD align="center" width="100" class=category>
											最后一次登陆IP
										</TD>
									</TR>

									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=center height=25>
													${data.loginName}
												</TD>
												<TD align=center>
											    	${data.userName}
												</TD>
												<TD align=center>
													${data.counts}
												</TD>
												<TD align=center>
													${data.startTime}
												</TD>
												<TD align=center>
													${data.lastLoginTime}
												</TD>
												<TD align=center>
													${data.lastIpPart}
												</TD>
											</TR>
											</c:forEach>
											
											<TR>

											</tr>
									<!--循环结束-->

                                 <tr>
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
					<TD><p:pages url="selectemp.do?deptid=all&funid=14" /></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>

</HTML>
