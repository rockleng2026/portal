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
<SCRIPT type="text/javascript">
function selectDep(id,name)
{
		
	$("#dep").attr("value",name);
	$("#depId").attr("value",id);
	$("#dianji").click();
}
</SCRIPT>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>

	<BODY>

			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							仓库名称：
							<INPUT name=cname id="cname">
							<INPUT class=button type=submit onclick="selectinfo('showDialogOutbound.do?mark=depot&cname','cname')" value=" 查询 ">
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
										&nbsp;仓库查询
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


									<TR align="center" >
									
										
										
										<TD width="12%" class=category>
											仓库名称
										</TD>
										<TD width="9%" class=category>
											仓库地址
										</TD>
										<TD width="21%" class=category>
											仓库容量
										</TD>
										<TD width="18%" class=category>
											建立仓库日期
										</TD>
										<TD width="13%" height=30 class=category>
											仓库管理员
										</TD>
										<TD width="15%" height=30 class=category>
											选择仓库
										</TD>
										
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR id="tr${data.id }"  onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">

												<TD align=middle>
													${data.name}
												</TD>
												<TD align=middle>
													${data.address}
												</TD>
												<TD align=middle>
													${data.capacity}
												</TD>
												<TD align=middle>
													${data.time}
													</TD>
													<TD align=middle>
													${data.employee.name }
												</TD>
												<TD align=middle>
													<input id="" name="" type="button" onclick="selectDep('${data.id}','${data.name}')" value="选择该仓库"/>
												</TD> 
												
											</TR>
											</c:forEach>
											
											<TR>
									<TD class=category colSpan=14 height=30>
									
									</TD>
											</tr>
									<!--循环结束-->
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
					<TD><pp:pages1 url="showDialogOutbound.do?mark=depot"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>

	</BODY>
</HTML>
