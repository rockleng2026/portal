<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>批量审批列表</title>
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
		<FORM name=form2 action="approveClientOrder.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							退单号：
							<INPUT name="clientreturnorder" id="clientreturnorder" value="">&nbsp;&nbsp;
							<c:if test="${mark=='approve'}"><input type="hidden" name="mark" id="mark" value="approve"/></c:if>
							<c:if test="${mark=='cancel'}"><input type="hidden" name="mark" id="mark" value="cancel"/></c:if>
							<INPUT class=button type=submit  value=" 筛选查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="batchOptionClientOrder.do" method="post" onsubmit="return checkBatch()">
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
										&nbsp;
										<c:if test="${mark=='approve'}">批量审批记录查询</c:if>
										<c:if test="${mark=='cancel'}">批量取消审批记录查询</c:if>
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
								align=center border=1 width="100%">
								<TBODY>
									<TR align="center">
										<TD width="5%" class=category>行号</TD>
										<TD width="10%" class=category>客户退单号</TD>
										<TD width="15%" class=category>退单日期</TD>
										<TD width="10%" class=category>客户名称</TD>
										<TD width="10%" class=category>退货人</TD>
										<TD width="10%" class=category>退货人电话</TD>
										<TD width="10%" class=category>退货原因</TD>
										<TD width="10%" class=category>总金额	</TD>
										<TD width="10%" class=category>业务员</TD>
										<TD width="10%" class=category>自动摘要</TD>
									</TR>
									<!--循环-->	
									<c:forEach items="${pages.pageList}" var="data" varStatus="states">
									<tr align="center">
										<TD><INPUT id=ids style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type=checkbox value="${data.id }" name=ids></TD>
										<TD>${states.index+1}</TD>
										<TD>${data.clientOrderNum}</TD>
										<TD>${data.returnTime}</TD>
										<TD>${data.customer.customerName}</TD>
										<TD></TD>
										<TD>${data.customer.mobilePhone}</TD>
										<TD>${data.returnReason}</TD>
										<TD>${data.money}</TD>
										<TD>${data.employeeByEmpId.name}</TD>
										<TD>${data.saleOrder.spaceSize}</TD>
									</tr>
									</c:forEach>
									<TD class=category colSpan=12 height=30 align="right">

										<INPUT id=chkall
											style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											onclick=CheckAll(this.form) type=checkbox value=select
											name=chkall>
										全选
										
											<c:if test="${mark=='approve'}"><input type="submit" value="  批准  "><input type="hidden" name="mark" id="mark" value="approve"/><input type="hidden" name="state" id="state" value="1" /></c:if>
											<c:if test="${mark=='cancel'}"><input type="submit" value="  取消批准  "><input type="hidden" name="mark" id="mark" value="cancel"/><input type="hidden" name="state" id="state" value="0" /></c:if>
									<p:pages url="batchOptionClientOrder.do"/>
									</TD>
									<!-- 
									<tr >
									
									<TD class=category colSpan=9 height=30 align="right">
								   		&nbsp;<INPUT  id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" onclick=CheckAll(this.form) type=checkbox value="" name=chkall>全选</div>
									</TD>
									<td colSpan=14 class=category height=30 align="center">
										
										<c:if test="${mark=='approve'}"><input type="submit" value="  批准  "><input type="hidden" name="mark" id="mark" value="approve"/><input type="hidden" name="state" id="state" value="1" /></c:if>
										<c:if test="${mark=='cancel'}"><input type="submit" value="  取消批准  "><input type="hidden" name="mark" id="mark" value="cancel"/><input type="hidden" name="state" id="state" value="0" /></c:if>
									</td>
									<tr>
									<TD class=category colSpan=16 height=30 align="right">
								     <p:pages url="batchOptionClientOrder.do"/>
									</TD>
									</tr>
									 -->
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
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
		<script type="text/javascript">
			function checkBatch()
			{
				var flag = $("input[type='checkbox']").is(':checked');
				if(flag)
				{
					var str = window.confirm("您确定提交所选择的信息吗？")
					if(str==true)
					{
						return true;
					}
					else
					{
						return false;
					}
				}
				else
				{
					alert("您还没选择！");
					return false;			
				}
				
			}
		</script>
	</BODY>
</HTML>
