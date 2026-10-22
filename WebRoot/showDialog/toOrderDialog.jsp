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
<script type="text/javascript">
function selectto(id,no,pno)
{
	var num =$("#num").val();
	$("#piciNo"+num+"").attr("value",no);
	$("#toOrderNum"+num+"").attr("value",pno);
	$("#toOrderId"+num+"").attr("value",id);
		$("#dianji").click();
}
</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
	<FORM name=form2 action="getpageToOrder.do?mark=toOrder" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							批次号：
							<INPUT name="name">
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
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;到货单批次查询
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
						<input type="hidden" name="method" value="delBatchexp">
						<input type="hidden" name="num" id="num" value="${num }">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
								<TBODY>
									<TR align="center">
									
										<TD width="15%" class=category>
											批次号
										</TD>
									
										<TD width="20%" height=30 class=category>
											到货单号
										</TD>
										<TD width="10%" class=category>
											经办人
										</TD>
										<TD width="10%" class=category>
											经办部门
										</TD>
										<TD width="12%" class=category>
											到货日期
										</TD>
										<TD width="12%" class=category>
											选择该订单
										</TD>
									
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data">
											<TR id="tr${data.id }" 
											ondblclick=" getvalueToOrder(' ${data.id},${data.toOrderNum},${data.piciNo} ')" 
											 onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												
												<TD align=middle>
													${data.piciNo}
												</TD>
												<TD align=middle height=25>
													${data.toOrderNum}
												</TD>
												<TD align=middle>
													${data.employee.name}
												</TD>
												<TD align=middle>
													${data.department.name}
												</TD>
												<TD align=middle>
													${data.totime }
												</TD>
												<TD align=middle>
													<input id="" name="" type="button" value="选择该订单" onclick="selectto(' ${data.id}','${data.piciNo}','${data.toOrderNum}')"/>
												</TD>
										
											</TR>
											</c:forEach>				
											<TR>
											<td colspan="9"></td>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD><pp:pages1 url="showDialogWarehousing.do" param="mark=batchexp&num=${num}"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
