<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="java.util.List"%>
<%@page import="com.fuao.fajxc.vo.CustomerMove"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdiv.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
			
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
									<% List<CustomerMove> movelist=(List<CustomerMove>)request.getAttribute("movelist"); %>
										&nbsp;您成功移交了<b style="color: red;"><%=movelist.size() %></b>个客户到负责人<%=movelist.get(0).getEmployeeByNewPrincipal().getName() %>下。
										以下是客户的信息：
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
				    <TD></TD>
					<TD>
						<!--startprint-->
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">									
										<TD width="18%" height=30 class=category>
											编号
										</TD>
										<TD width="13%" class=category>
											客户姓名
										</TD>
										<TD width="13%" class=category>
											原来负责人
										</TD>
										<TD width="13%" class=category>
											新的负责人
										</TD>
										<TD width="15%" class=category>
											移交时间
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${movelist}" var="customermove">
											<TR>
												<TD align=middle height=25>
													${customermove.id}
												</TD>
												<TD align=middle>
													${customermove.customer.realName}
												</TD>
												<TD align=middle>
													${customermove.employeeByOldPrincipal.name}
												</TD>
												<TD align=middle>
													${customermove.employeeByNewPrincipal.name}
												</TD>
												<TD align=middle>
													${customermove.movetime}
												</TD>
											</TR>
									</c:forEach>	
									<!--循环结束-->
								</TBODY>
							</TABLE>
					</TD>
					<td></td>
				</TR>
				<tr>
				  <td colspan="3">
					    <input type="button" id="ret" onclick="javascript:history.go(-2);" value="返回" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>
				  </td>
				</tr>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
