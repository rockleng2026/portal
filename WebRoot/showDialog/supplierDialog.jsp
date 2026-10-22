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
		<title>供应商列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<base target="_self">
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
function selectsupplier(id,name)
{
	$("#sup").attr("value",name);
	$("#supid").attr("value",id);
	$("#dianji").click();
}
</script>
	
<body>
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							供应商名称：
							<INPUT id=name name=name>
							<INPUT class=button type=submit  onclick="selectinfo('showDialogOutbound.do?mark=supplier&name','name')"  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
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
										&nbsp;供应商记录查询
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
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="13%" height=30 class=category>
											编号
										</TD>
										
										<TD width="12%" class=category>
											公司名称
										</TD>
										<TD width="9%" class=category>
											公司地址
										</TD>
										<TD width="21%" class=category>
											供应商来源
										</TD>
										<TD width="12%" class=category>
											供应商负责人
										</TD>
										<TD width="18%" class=category>
											建立日期
										</TD>
										<TD width="10%" class=category>
											选择该供应商
										</TD>
									
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR id="tr${data.id }"  ondblclick="getvalue('${data.id},${data.supplierName }',${data.id })" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'" >
											
												<TD align=middle height=25>
													 ${data.id}
												</TD>
												<TD align=middle>
													${data.supplierCompany}
												</TD>
												<TD align=middle>
													${data.supplierAddress}
												</TD>
												<TD align=middle>
													${data.supplierOrigin}
												</TD>
												<TD align=middle>
													${data.supplierName}
													</TD>
													<TD align=middle>
													${data.date}
												</TD>
												<TD align=middle>
													<input id="" name="" type="button" value="选择该供应商" onclick="selectsupplier('${data.id}','${data.supplierName}')"/>
												</TD>
											
											</TR>
											</c:forEach>
											
									<!--循环结束-->
									
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
					<TD> <pp:pages1 url="showDialogOutbound.do?mark=supplier"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>