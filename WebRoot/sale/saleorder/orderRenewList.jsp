<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
	<c:if test="${mess != null}">
	<script>

function show_con(){

var obj_nav=document.getElementById("message");
  obj_nav.style.display="none";
}
setTimeout("show_con()",1000)//
</script>
	</c:if>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单列表</title>
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


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
<div id="message" align=center><h2><font color="red"><c:if test="${mess == 'success'}">续费成功</c:if><c:if test="${mess == 'error'}">续费失败</c:if></font></h2></div>

		<FORM name=form2 action="selectsaleOrder.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							订单号：
							<INPUT name=orderNo id="orderNo">
							<INPUT class=button type=submit value=" 查询 ">
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
										&nbsp;订单信息查询
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
									
										<TD width="12%" class=category>
											订单号...
										</TD>
										<TD width="10%" class=category>
											客户
										</TD>
										<TD width="10%" class=category>
											订单类型
										</TD>
										<TD width="10%" class=category>
											使用状态
										</TD>
										<TD width="10%" class=category>
											开始时间
										</TD>
										<TD width="8%" class=category>
											到期时间
										</TD>
										<TD width="9%" class=category>
										详细信息
										</TD>
										<TD width="9%" class=category>
											操作
										</TD>
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR >
												
												<TD align=center height=25>
											
													${data.saleOrderNo}
												</TD>
												<TD align=center>
											
													${data.customer.realName}
												</TD>
												<TD align=center>
											   		${data.allTypeByOrdertype.questionName}
												
												</TD>
												<TD align=center>
											${data.allTypeByPayStatus.typeName}
													
												</TD>
												<TD align=center>
												${data.beginTime}
												

													</TD>
													<TD align=center>
													${data.endTime}
													
												</TD>
												
												
												<TD align=center>
										<a href="infosaleOrder.do?id=${data.id }">详细信息</a>
										</TD>
                                        <td align=center><a href="renewPagesaleOrder.do?id=${data.id }">续费</a></td>
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
					<TD><p:pages url="selectrlsaleOrder.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		
	</BODY>
</HTML>
