<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>采购价格一览表</title>
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
		<FORM name=form2 action="getScheduleOfValues.do?funid=57" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							商品型号：
							<INPUT name="purNo" >
							<INPUT class=button type=submit  value="查询 ">
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
										&nbsp;商品价格明细查询
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
									
										<TD width="12%" height=30 class=category>
											日期
										</TD>
										<TD width="18%" class=category>
											供应商
										</TD>
										<TD width="15%" class=category>
											商品型号
										</TD>
										<TD width="15%" class=category>
											商品类型
										</TD>
										<TD width="10%" class=category>
											付款金额(单位：元/RMB)
										</TD>
										<TD width="10%" class=category>
											经办人
										</TD>
										<TD width="10%" class=category>
											折扣
										</TD>
										<TD width="10%" class=category>
											删除
										</TD>
									</TR>


									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												${data.purOrder.orderTime }
												</TD>
												<TD align=middle>
													${data.purOrder.supplier.supplierName}
												</TD>
												<TD align=middle>
													${data.model.name}
													</TD>
													<TD align=middle>
													${data.model.commodityTpye.typeName}
												</TD>
													<TD align=middle>
													${data.price}
												</TD>
												<TD align=middle>
													${data.purOrder.employee.name}
												</TD>
												<TD align=middle>
													${data.discount}
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</TD>
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
														<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('deleteScheduleOfValues.do','getScheduleOfValues.do?funid=57')"
															value="删 除">
															</c:if>
															</c:forEach>
									</TD>
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
					<TD> <p:pages url="getScheduleOfValues.do?funid=57"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
