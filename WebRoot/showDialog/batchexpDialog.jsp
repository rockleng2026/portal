<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
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
	
	<%String addH=request.getParameter("addH"); %>
	<c:set value="<%=addH %>" var="addH"></c:set>
	<FORM name=form2 action="showDialogWarehousing.do?mark=batchexp&addH=${addH}" method="post">
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
										&nbsp;入库批次查询
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
						<FORM name=form1 action="batchexp.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delBatchexp">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="30%" height=30 class=category>
											批次号
										</TD>
										
										<TD width="15%" class=category>
											类型
										</TD>
										<TD width="15%" class=category>
											型号
										</TD>
										<TD width="15%" class=category>
											单价
										</TD>
										<TD width="12%" class=category>
											数量
										</TD>
									
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data">
											<TR id="tr${data.id }" 
											ondblclick="getvaluebatchexp('${data.id},${data.batch.batchId},${data.commodityTpye.typeName},${data.model.name},${data.price},${data.count},${data.model.model}  ')" 
											 onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=middle height=25>
													${data.batch.batchId}
												</TD>
												<TD align=middle>
													${data.commodityTpye.typeName}
												</TD>
												<TD align=middle>
													${data.model.name}
												</TD>
												<TD align=middle>
													${data.price}
												</TD>
												<TD align=middle>
													${data.count}
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
					<TD><pp:pages1 url="showDialogWarehousing.do?mark=batchexp"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
