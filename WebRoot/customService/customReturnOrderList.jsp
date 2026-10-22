<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>客户退单列表</title>
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
		<FORM name=form2 action="getAllListClientOrder.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							<div align="left" style="display: inline;">
							<INPUT class=button type="submit"  value="查看已审批" onclick="changestate('selectapprove')">&nbsp;&nbsp;
							<input type="hidden" name="selectapprove" id="selectapprove" value=""/>
							<INPUT class=button type="submit"  value="查看已审核" onclick="changestate('selectfinancing')">
							<input type="hidden" name="selectfinancing" id="selectfinancing" value="" />
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							退单号：
							<INPUT name="clientreturnorder" id="clientreturnorder" value="">&nbsp;&nbsp;
							
							<INPUT class=button type=submit  value=" 筛选查询 ">
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
										&nbsp;客户退单记录查询
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
					<TD width="100%">
						<!--startprint-->
						
					<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 >
								<TBODY>
									<TR align="center">
										<TD width="12%" class=category>
											客户退单号
										</TD>
										<TD width="13%" class=category>
											销售订单号
										</TD>
										<TD width="5%" class=category>
											销售人员
										</TD>
										<TD width="5%" class=category>
											客户
										</TD>
										<TD width="11%" class=category>
											客户帐号
										</TD>
										<TD width="12%" class=category>
											退单时间
										</TD>
										<TD width="12%" class=category>
											退单期限
										</TD>
										<TD width="5%" class=category>
											总金额
										</TD>
										<TD width="5%" class=category>
											审批状态
										</TD>
										<TD width="8%" class=category>
											流程跟踪
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="4%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="4%" class=category>
													删除
												</TD>
											</c:if>
											<c:if test="${map.key==4}">
												<TD width="4%" class=category>
													查看
												</TD>
											</c:if>
										</c:forEach>
									</TR>
									<!--循环-->	
									<c:forEach items="${pages.pageList}" var="data">
									<tr align="center">
										<TD>
											${data.clientOrderNum}
										</TD>
										<TD>
											${data.saleOrder.saleOrderNo}
										</TD>
										<TD>
											${data.employeeByEmpId.name}
										</TD>
										<TD>
											${data.customer.customerName}
										</TD>
										<TD>
											${data.account}
										</TD>
										<TD>
											${data.returnTime}
										</TD>
										<TD>
											${data.returnLimitTime}
										</TD>
										<TD>
											<c:if test="${empty data.money}">
												未统计
											</c:if>
											<c:if test="${data.money>=0}">
												${data.money}
											</c:if>
										</TD>
										<TD>
											<c:if test="${data.approveState==0||data.approveState==null}">
												未审核
											</c:if>
											<c:if test="${data.approveState==1||data.approveState==2}">
												已审核
											</c:if>
											<c:if test="${data.approveState==8}">审核进行中</c:if>
										</TD>
										
										<TD>
											<a href="followAuditing.do?orderNo=${data.clientOrderNum}">流程跟踪</a>
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD>
												<c:if test="${data.approveState!=8}">
													<a href="skippageClientOrder.do?clientreturnorderid=${data.id}&&mark=edit" target=right>
														<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath()%>/images/res.gif" align=absMiddle border=0>
													</a> 
												</c:if>   
												<c:if test="${data.approveState==8}">审核进行中</c:if>
												</TD>	
											</c:if>
											<c:if test="${map.key==3}">
												<TD>
												<c:if test="${data.approveState!=8}">
													<a href="javascript:void();" onclick="return deleteClientReturnOrder(${data.id});"><img src="<%=request.getContextPath()%>/img/del.gif" width="20px" height="20px" border=0 ></a>
													
													</c:if>   
												<c:if test="${data.approveState==8}">审核进行中</c:if>
												</TD>	
											</c:if>
											<c:if test="${map.key==4}">
												<TD>
													<a href="skippageClientOrder.do?clientreturnorderid=${data.id}&&mark=find&info=info">查看</a>
												</TD>
											</c:if>
										</c:forEach>
										</tr>
									</c:forEach>
									<tr>
									<TD class=category colSpan=16 height=30 align="right">
								     <p:pages url="getAllListClientOrder.do"/>
									</TD>
									</tr>
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
			function deleteClientReturnOrder(id)
			{
				var str = window.confirm("您确定要删除该条记录");
				if(str == true)
				{
					var url = "deleteClientOrder.do";
					$.post(url,{id:id},function(data){
						if(data=="1")
						{
							alert("删除成功");
							window.location.href="getAllListClientOrder.do";
						}					
						else
						{
							alert("删除失败");
							return ;
						}
					});
				}
			}
			
			function changestate(op)
			{
				$("#"+op).attr("value",1);
			}
		</script>
	</BODY>
</HTML>
