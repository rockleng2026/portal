<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>


</head>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
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
											&nbsp;供应商详细信息
										</TD>
										<TD align=right>
											&nbsp;<a href="javascript:history.go(-1);">返回</a>
											
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
										<TD width="25%" height=30 align=right>
											供应商名称：
										</TD>
										<TD width="75%" class=category>
											${supplier.supplierName}
											
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											负责人身份证号码：
										</TD>
										<TD width="75%" class=category>
											${supplier.cardid}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											联系电话：
										</TD>
										<TD class=category>
											${supplier.phone}
											
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司名称：
										</TD>
										<TD class=category>
											${supplier.supplierCompany}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司地址：
										</TD>
										<TD class=category>
											${supplier.supplierAddress}
										
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											供应商手机：
										</TD>
										<TD class=category>
											${supplier.mobilePhone}

										</TD>
									</TR>

									<TR>
										<TD align=right height=30>
											供应商银行帐号：
										</TD>
										<TD class=category>
											${supplier.bankAccount}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商来源：
										</TD>
										<TD class=category>
											${supplier.supplierOrigin}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商Email：
										</TD>
										<TD class=category>
											${supplier.email}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商邮编：
										</TD>
										<TD class=category>
											${supplier.zipCode}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商传真：
										</TD>
										<TD class=category>
											${supplier.facsimile}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商QQ号码：
										</TD>
										<TD class=category>
											${supplier.qq}
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											建立供应商日期：
										</TD>
										<TD class=category>
											${supplier.date}
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
						<TD>i</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
	</BODY>
</HTML>
