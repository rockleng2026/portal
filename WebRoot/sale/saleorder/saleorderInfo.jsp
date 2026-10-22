<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>新添订单</title>
<script type="text/javascript">
function openwin(sbh) {
window.open ("/FAJxc/mission/addfj.jsp?sbh="+sbh+"&mark=mark", "newwindow", "height=700, width=1000, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");

}
</script>

</head>
	<body>
	
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
					<font >审核流程：</font>　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
					 
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">

						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>					
								<TR>
										<TD width="25%" height=30 align="center" colspan="4">
											
											<h1>订单详细信息</h1>
											订单编号：
											
											${saleorder.saleOrderNo}
											<input type="hidden" id="orderNo" value="${saleorder.saleOrderNo}" />
											<input type="hidden" id="tab" value="SaleOrder">
											<input type="hidden" id="filed" value="auditingState">
											<input type="hidden" id="orderName" value="saleOrderNo">
											<input type="hidden" id="price" value="price"/>  <!-- 存储价格字段 -->
										</TD>
									</TR>																				
									<TR>
										<TD width="25%" height=30 align=right>
											客户名称：
										</TD>
										<TD class=category>
											${saleorder.customer.realName}
										</TD>
										<TD height=30 align=right>
										销售员工：
										</TD>
										<TD class=category>
											${saleorder.customer.employee.name }
										</TD>
									</TR>	
								<tr><td  align="right">机柜</td>
								<td class=category>${saleorder.property.name }</td>
								<TD align=right height=30>
										   审核是否通过：
										</TD>
										
										<TD class=category>
										<c:if test="${saleorder.auditingState==0||saleorder.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${saleorder.auditingState==1 ||saleorder.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${saleorder.auditingState==8}">审核进行中</c:if>
										</TD>
										
										
										</tr>
				<TR>
										<TD width="25%" height=30 align=right>
											机位大小：
										</TD>
										<TD class=category>
											${saleorder.spaceSize }
										</TD>
										<TD height=30 align=right>
										机器数量：
										</TD>
										<TD class=category>
											${saleorder.productNum }
											
										</TD>
									</TR>	
									<TR>
										<TD width="25%" height=30 align=right>
											IP数量：
										</TD>
										<TD class=category>
											${saleorder.ipNum}
										</TD>
										<TD height=30 align=right>
										带宽总数：
										</TD>
										<TD class=category>
											${saleorder.bw}
											
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											订单价格：
										</TD>
										<TD class=category >
											${saleorder.price}
										</TD>	
											<TD width="25%" height=30 align=right>
											订单类型：
										</TD>
										<TD class=category>
										${saleorder.allTypeByOrdertype.questionName}
										</TD>
																			
									</TR>	
									<TR>
								
										<TD height=30 align=right>
										付费类型：
										</TD>
										<TD class=category>
										${saleorder.allTypeByPayStyle.typeName }
										</TD>
										<TD width="25%" height=30 align=right>
											付费状态：
										</TD>
										<td>
										${ saleorder.allTypeByPayStatus.typeName}
										</TD>
									</TR>	
									
									<TR>
										<TD width="25%" height=30 align=right>
											开始时间：
										</TD>
										<TD class=category>
											${saleorder.beginTime}
										</TD>
										<TD height=30 align=right>
										到期时间：
										</TD>
										<TD class=category>
											${saleorder.endTime}
										</TD>
									</TR>	
									<TR>
									
										<TD height=30 align=right>
										服务器配置描述：
										</TD>
									<td class=category colspan="3">
									<textarea readonly rows="10" cols="100" id="serverConfiguration" name="serverConfiguration">${saleorder.serverConfiguration}</textarea>
									
									</td>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											备注：
										</TD>
										<TD class=category >
											${saleorder.description}
										</TD>
											
										<TD  align="right">
											经办人：
										</TD>	
										<td>${saleorder.inputAdmin }</td>
									</TR>
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作:
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark' && saleorder.auditingState==0}">
											<input type="button" value="接收" onClick="incepttime('${saleorder.saleOrderNo}','SaleOrder','auditingState','saleOrderNo')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if>
									 
										<br></TD>

									</TR>
									</c:if>
				</TBODY>
			</TABLE>
			</TD>
			</TR>
			</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</body>
	
</html>