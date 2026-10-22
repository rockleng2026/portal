<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
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
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;员工信息查询
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
									<TR align="center">
										<TD width="80"  class=category >
											姓名
										</TD>
										<TD width="50"  class=category>
											性别
										       
										</TD>
										<TD width="50"  height=30 class=category >
											年龄
										</TD>
										<TD width="90"  class=category >
											生日
										</TD>
										<TD width="100"  class=category >
											联系电话
										</TD>
										<TD width="60"  class=category >
											学历
										</TD>
										<TD width="100"  class=category >
											所属部门
										</TD>
										<TD width="80" class=category >
											职位
										</TD>
										<TD width="80"  class=category >
											工号
										</TD>
										<TD width="90" class=category >
											入职时间
										</TD>
										
										<TD width="80" class=category >
											详细信息
										</TD>
										<TD width="140" class=category >
											客户信息
										</TD>
										
									</TR>                                
                                    </table>
									<!--循环-->
                             <table id="infotable" class="toptable grid">
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												
												<TD align=center height=25 width="80" >
													${data.name}
												</TD>
												<TD align=center width="50" >
											    <c:if test="${data.sex==1}">男</c:if>
													<c:if test="${data.sex==2}">女</c:if>
												</TD>
												<TD align=center width="50" >
													${data.age}
												</TD>
												<TD align=center width="90" >
													<c:set var="birthDate" scope="request" value="${data.birth}"  />
													${data.birth}
												</TD>
												<TD align=center width="100" >
													${data.tel}
												</TD>
												<TD align=center width="60" >
													${data.education}
												</TD>
												<TD align=center width="100" >
													${data.department.name}
												</TD>
												<TD align=center width="80" >
													${data.groups.groupName}
												</TD>
												<TD align=center width="80" >
													${data.empNo}
												</TD>
												<TD align=center width="90" >
													${data.entryTime}
												</TD>
												
												<TD align=center width="80" >
													<a href="detailemp.do?cid=${data.id}">详细信息</a>
												</TD>
												<td align=center width="140" >
												   <a href="<%=request.getContextPath()%>/customerByEidemp.do?empid=${data.id}&customertype=1">意向客户</a>
												   <a href="<%=request.getContextPath()%>/customerByEidemp.do?empid=${data.id}&customertype=3">客户列表</a>
												</td>
												
											</TR>
											</c:forEach>
											</table>
											<table>
											<TR>
											</tr>
									<!--循环结束-->
                                 <tr>
									
							</TABLE>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD id="page"><p:pages url="departmentemp.do" /></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	
	

	</BODY>
</HTML>
