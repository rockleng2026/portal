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
	
	<script type="text/javascript">
function dialogInfo(id)
{
	var url="selectcusinfoOutbound.do";
	$.post(url,{id:id,mark:"server"},function(data){
		
			$("#selectinfo").append(data);
			$("#selectList").css("display","none");
			$("#close").css("display","");
	});
}
function closeInfo()
{
	$("#selectinfo").html("");
	$("#close").css("display","none");
	$("#selectList").css("display","");
}

</script>
	<BODY>

	
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							客户名称：
							<INPUT name=cusname id="cusnameaa"  type="text">
							<INPUT class=button type=submit  onclick="selectinfo('showDialogOutbound.do?mark=custom&cusname','cusnameaa')" value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		
			<div id="selectList" name="selectList">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;客户查询
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
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">

								<TBODY>
									<TR align="center">
									
										<TD width="7%" height=30 class=category>
											编号
										</TD>
										<TD width="13%" height=30 class=category>
											账号
										</TD>
										<TD width="8%" class=category>
											客户姓名
										</TD>
										<TD width="9%" class=category>
											客户类型：
										</TD>
										<TD width="10%" class=category>
											负责人
										</TD>
										<TD width="12%" class=category>
											客户电话
										</TD>
										<TD width="18%" class=category>
											客户公司名称
										</TD>
										<TD width="10%" class=category>
											详细信息
										</TD>
										<td width="17%" class=category>
											选择
										</td>
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data">
											<TR id="tr${data.customerId }"  onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=middle height=25>
													${data.customerId}
													
												</TD>
												<TD align=middle>
													${data.customerName}
												</TD>
												<TD align=middle>
													${data.realName}
												</TD>
												<TD align=middle>
													${data.customerType}
												</TD>
												<TD align=middle>
													${data.employee.name}
												</TD>
												<TD align=middle>
													${data.phone}
													</TD>
													<TD align=middle>
													${data.customerCompany}
												</TD>
													<TD align=middle>
													<a href="#" onclick="dialogInfo(${data.customerId  })">	详细信息</a>
												</TD>
												<TD align=middle>
													<input type="button" value="选择该客户" onclick="cusshow('${data.customerCompany}','${data.customerId}','${data.realName}','${data.phone}','${data.cardid}','${data.employee.name}','${data.employee.id}')" />
												</TD>
										
											</TR>
											</c:forEach>				
											<TR>
											<td colspan="9"></td>
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
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD><pp:pages1 url="showDialogOutbound.do?mark=custom"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
				</div>
		
		
				<div >
				<table name="selectinfo" id="selectinfo"  class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
					
				</table>
			</div>
			
	</BODY>
</HTML>
