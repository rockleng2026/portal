<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
	<HEAD>
		<title>福奥科技----欢迎您！十分抱歉，您当前下载的文档已过期，或已被更名或删除！</title>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<STYLE type=text/css>
INPUT {
	FONT-SIZE: 12px
}

TD {
	FONT-SIZE: 12px
}

.p2 {
	FONT-SIZE: 12px
}

.p6 {
	FONT-SIZE: 12px;
	COLOR: #1b6ad8
}

A {
	COLOR: #1b6ad8;
	TEXT-DECORATION: none
}

A:hover {
	COLOR: red
}
</STYLE>

		<META content="Microsoft FrontPage 5.0" name=GENERATOR>
	</HEAD>
	<BODY oncontextmenu="return false" onselectstart="return false">
		<P align=center>
		</P>
		<P align=center>
		</P>
		<TABLE cellSpacing=0 cellPadding=0 width=540 align=center border=0>
			<TBODY>
				<TR>
					<TD vAlign=top height=270>
						<DIV align=center>
							<BR>
							<IMG height=211 src="<%=path%>/images/error/error.gif" width=329>
							<BR>
							<BR>
							<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0>
								<TBODY>
									<TR>
										<TD>
											<FONT class=p2>&nbsp;&nbsp;&nbsp; <FONT color=#ff0000><IMG
														height=13 src="<%=path%>/images/error/emessage.gif"
														width=12>&nbsp;无法下载文件的原因是：</FONT>
											</FONT>
										</TD>
									</TR>
									<TR>
										<TD height=8></TD>
										<TR>
											<TD>
												<P>
													<FONT color=#000000><BR> ${message}，请与相关人员联系，谢谢</FONT>!
												</P>
											</TD>
										</TR>
								</TBODY>
							</TABLE>
						</DIV>
					</TD>
				</TR>
				<TR>
					<TD height=5></TD>
					<TR>
						<TD align=middle>
							<CENTER>
								<TABLE cellSpacing=0 cellPadding=0 width=480 border=0>
									<TBODY>
										<TR>
											<TD width=6>
												<IMG height=26 src="<%=path%>/images/error/left.gif" width=7>
											</TD>
											<TD background="<%=path%>/images/error/bg.gif">
												<DIV align=center>
													<FONT class=p6> <A href="javascript:history.go(-1)">返回上页</A>
														| <A
														href="javascript:parent.location.href='safetyExitSystem.do'"
														target="_top">退出系统</A>
													</FONT>
												</DIV>
											</TD>
											<TD width=7>
												<IMG src="<%=path%>/images/error/right.gif">
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</CENTER>
						</TD>
					</TR>
			</TBODY>
		</TABLE>
		<P align=center>
		</P>
		<P align=center>
		</P>
	</BODY>
</HTML>
