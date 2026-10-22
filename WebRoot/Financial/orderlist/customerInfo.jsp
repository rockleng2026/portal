<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
			<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
				<TBODY>					
					    <TR>
							<TD width="25%" height=30 align="center" colspan="4">
							   <h1>客户详细信息</h1>
							</TD>
						</TR>																				
						<TR>
							<TD width="25%" height=30 align=right>
								客户名称：
							</TD>
							<TD class=category>
								${data.realName}
							</TD>
							<TD height=30 align=right>
							业务负责人：
							</TD>
							<TD class=category>
								${data.employee.name }
							</TD>
						</TR>	
						<TR>
							<TD width="25%" height=30 align=right>
								客户公司名称：
							</TD>
							<TD class=category>
								${data.customerCompany}
							</TD>
							<TD height=30 align=right>
							客户联系地址：
							</TD>
							<TD class=category>
								${data.customerAddress}
							</TD>
						</TR>			
						<TR>
							<TD width="25%" height=30 align=right>
								客户类型：
							</TD>
							<TD class=category>
								${data.customerType}
							</TD>
							<TD height=30 align=right>
							身份证：
							</TD>
							<TD class=category>
								${data.cardid }
							</TD>
						</TR>	
						<TR>
							<TD width="25%" height=30 align=right>
								客户邮编：
							</TD>
							<TD class=category>
								${data.zipCode}
							</TD>
							<TD height=30 align=right>
							客户传真：
							</TD>
							<TD class=category>
								${data.facsimile }
							</TD>
						</TR>	
						<TR>
							<TD width="25%" height=30 align=right>
								电话：
							</TD>
							<TD class=category>
								${data.phone}
							</TD>
							<TD height=30 align=right>
							手机：
							</TD>
							<TD class=category>
								${data.mobilePhone }
							</TD>
						</TR>	
						<TR>
							<TD width="25%" height=30 align=right>
								QQ：
							</TD>
							<TD class=category>
								${data.qq}
							</TD>
							<TD height=30 align=right>
							日期：
							</TD>
							<TD class=category>
								${data.date }
							</TD>
						</TR>	
						<TR>
							<TD width="25%" height=30 align=right>
								调查：
							</TD>
							<TD class=category>
								${data.userFrom}
							</TD>
							<TD height=30 align=right>
							电子邮件：
							</TD>
							<TD class=category>
								${data.email }
							</TD>
						</TR>
						<TR>
							<TD width="25%" height=30 align=right>
								备注说明：
							</TD>
							<TD class=category colspan="3">
								<textarea readonly rows="10" cols="100" id="serverConfiguration" name="serverConfiguration">${data.userNotes}</textarea>
							</TD>
						</TR>	
				</TBODY>
			</TABLE>
			
	</BODY>
</HTML>
