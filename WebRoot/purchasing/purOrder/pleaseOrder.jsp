<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<base target="_self"/> 
<title>请购单参照</title>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
</head>
	<BODY>

		<FORM name=form2 action="getRejectioning.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							请购单号：
							<INPUT name="applyBuyNo">
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
										&nbsp;请购单查询
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
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
								
										<TD width="20%" class=category>
											请购单号
										</TD>
										<TD width="15%" class=category>
											申请请购日期
										</TD>
										<TD width="10%" class=category>
											申请人
										</TD>
										<td width="50%">自动摘要</td>
										<td width="8%" class=category>
								
											</td>
									</TR>


									<!--循环-->
										<%int i=0; %>
									<c:forEach items="${pages.pageList}" var="data">
											<TR>
												
												<TD align=middle>
													${data.applyBuy}
												</TD>
												<TD align=middle>
													${data.time}
												</TD>
													<TD align=middle>
													${data.employeeByEmployeeId.name }
												</TD>
												<td>
												<c:forEach items="${data.applyBuyinfos }" var="infoData">
												${infoData.commodityTpye.typeName }|${infoData.model.name }|${infoData.count },
												</c:forEach>
												
												</td>
												<td class=category>
								                 <input type="checkbox" name="allplease" id="allplease" value="${data.id }"> 
											</td>
											</TR>
											</c:forEach>
											<TR>
									
											</tr>
									<!--循环结束-->
									<TD class=category colSpan=12 height=30 align="right">
								     <INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<INPUT name="delbut" type=button class=button
															onclick="copys('<%=request.getContextPath() %>/copyIdPurchaseOrder.do')"
															value="复制">
								     	
									</TD>
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
					<TD><p:pages url="pleasePurchaseOrder.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
