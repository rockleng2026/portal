<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
</head>		
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>


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
											&nbsp;上架单详细信息
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
						<TD>						
						</TD>
						<TD>
	
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											组装服务器单号：
										</TD>
										<TD width="75%" class=category>
											${oneAss.assemblyNo}
											
											
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											Cpu：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByCpuId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											主板：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByMainBoardId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											内存：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByMemoryId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											硬盘：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByHdId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											机箱：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByCrateId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											电源：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByPowerId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											网卡：
										</TD>
										<TD width="75%" class=category>
											${oneAss.productByNetworkCardId.property.name}
										
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category>
											${oneAss.employee.name}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											类型：
										</TD>
										<TD class=category>
											${oneAss.model.commodityTpye.typeName}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											型号：
										</TD>
										<TD class=category>
											${oneAss.model.name}
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
										       仓库：
										</TD>
										<TD class=category>
											${oneAss.depot.name}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											组装时间：
										</TD>
										<TD class=category>
											
													<c:set var="birthDate" scope="request" value="${oneAss.atime}"  />
											<%
											
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
										</TD>
									</TR>
									
								<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											${oneAss.remark}
										</TD>
									</TR>
									
									
								</TBODY>
							</TABLE>
							
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
	</BODY>
</HTML>
