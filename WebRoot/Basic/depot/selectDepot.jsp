<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>查询仓库信息</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>

		<FORM id ="form1" name="updateDepot" action="updatedepot.do" method="post" onsubmit="return addValidators()">

		
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
											&nbsp;查询仓库资料
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>仓库名称：</TD>
										<TD width="75%" class=category>
											${depot.name}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库地址：
										</TD>
										<TD width="75%" class=category>
											${depot.address}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库容量：
										</TD>
										<TD class=category>
											${depot.capacity}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库管理员：
										</TD>
										<TD class=category>
											${depot.employee.name }
										</TD>
									</TR>
					
										<TR>
										<TD align=right height=30>
											建立仓库日期：
										</TD>
										<TD class=category>
											${depot.time}
										</TD>
									</TR>
								</TBODY>
							</TABLE>
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
		</FORM>	
	</BODY>
</HTML>
