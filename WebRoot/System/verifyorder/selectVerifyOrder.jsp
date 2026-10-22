<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<script type="text/javascript" src="js/jquery.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<title>流程单信息表</title>

</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD align=right>
											
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
						<TD width="100%">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 width="100%"
								align=center border=1>
								<TBODY>
													
								<TR>
										<TD width="100%" height=30 align="center" colspan="3">
											<h1>流程单详情</h1>
										</TD>
									</TR>																				
									<TR >
										<TD width="200px" height=30 align=right> 
											流程单类型：
										</TD>
										<TD width="600px" class=category>
											&nbsp;${verifyOrder.aname}
										</TD>
										<TD width="200px" class=category>
											
										</TD>
									</TR>	
									<TR >
										<TD width="200px" height=30 align=right> 
											标识：
										</TD>
										<TD width="600px" class=category colspan="2">
											&nbsp;${verifyOrder.mark}
										</TD>
									</TR>	
									<tr>
										<td colspan="3">
											<table  border="1" bgcolor="white"  width="100%" id="department" >
											
												<tr>
													<td colspan="3" align="center">
														<FONT color=#ff0000><h3><c:if test="${verifyState==0}">顺序审核</c:if><c:if test="${verifyState==1}">审核顺序相同时，只需一人审核，其他按顺序审核</c:if><c:if test="${verifyState==2}">审核顺序相同时，必须审核但不分先后顺序，其他按顺序审核</c:if></h3></FONT>
													</td>
												</tr>
												<c:if test="${empOrdept==true}">
													<tr>
														<TD width="19%" height=30 align=right> 
															部&nbsp;门&nbsp;：
														</TD>
														<TD width="20%" height=30 align="center"> 
															审核人：
														</TD>
														<TD width="20%" height=30 align="left"> 
															顺序
														</TD>
													</tr>
														<c:forEach items="${vOrderEmployee}" var ="voe" varStatus="states">
														<tr>
															<TD width="19%" height=30 align=right> 
																${voe.department.name }
															</TD>
															<TD width="20%" height=30 align="center"> 
																${employeeName[states.index] }
															</TD>
															<TD width="20%" height=30 align="left"> 
																${voe.orderVerify }
															</TD>
															</tr>
														</c:forEach>
												</c:if>
												<c:if test="${empOrdept==false}">
													<tr>
														<TD width="30%" height=30 align=right> 
															审核部门
														</TD>
														<TD width="30%" height=30 align="left"> 
															顺序
														</TD>
														<td></td>
													</tr>
														<c:forEach items="${vOrderDepartment}" var ="dept">
														<tr>
															<TD width="30%" height=30 align=right> 
																${dept.department.name }
															</TD>
															<TD width="30%" height=30 align="center" colspan="2"> 
																${dept.orderVerify }
															</TD>
															</tr>
														</c:forEach>
												</c:if>
											</table>
										</td>
									</tr>
									
								</TBODY>
							</TABLE>
						</TD>
						<TD>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		
	</body>
</html>