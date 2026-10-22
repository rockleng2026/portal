<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>入库单详细信息</title>
		<base target="_self">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK">
</script>
		<script src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"
			type="text/javascript">
</script>
	</head>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/date2.js" charset="GBK">
</script>

	<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css
		rel=stylesheet>
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
				<font>审核流程${adata.auditingFlag}：</font>
				<c:forEach items="${auditingList}" var="adata">
					<c:if test="${adata.auditingFlag==0}">
						<font>${adata.department.name}>>></font>
					</c:if>
					<c:if test="${adata.auditingFlag==1}">
						<font color="red">${adata.department.name}>>></font>
					</c:if>
					<c:if test="${adata.auditingFlag==2}">
						<font color="red">${adata.department.name}>>></font>
					</c:if>
				</c:forEach>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;入库单详细信息
									</TD>
									<TD align=right>
										&nbsp;
										<a href="javascript:history.go(-1);">返回</a>

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
										入库单号：
									</TD>
									<TD width="75%" class=category>
										${storageList.storageNo}
										<input type="hidden" id="orderNo"
											value="${storageList.storageNo }">
										<FONT color=#ff0000>*</FONT>
										<input type="hidden" id="tab" value="Storage">
										<input type="hidden" id="filed" value="storageVerify">
										<input type="hidden" id="orderName" value="storageNo">
										<input type="hidden" id="price" value="productPriceSum">
									</TD>
								</TR>

								<TR>
									<TD align=right height=30>
										入库类型：
									</TD>
									<TD class=category>
										${storageList.allType.typeName}

									</TD>
								</TR>
								<TR>
									<TD align=right height=30>
										服务器状态：
									</TD>
									<c:forEach items="${storageList.storageInfos}" var="data1">

											<c:forEach items="${data1.products}" var="product">
									<TD class=category>
									
									<a href="selectUpserver.do?cid=${product.id }"><c:if test="${product.usestate ==1}">使用</c:if></a>
									<c:if test="${product.usestate ==2}">未使用</c:if>
									
									</TD>
									</c:forEach>
									</c:forEach>
								</TR>
								<TR>
									<TD align=right height=30>
										经手人：
									</TD>
									<TD class=category>
										${storageList.employee.name}
									</TD>
								</TR>
								<c:if test="${storageList.customer.realName!=null}">
								<TR>
									<TD align=right height=30>
										客户：
									</TD>
									<TD class=category>
										
											${storageList.customer.realName}
									
									</TD>
								</TR>
								</c:if>
								<TR>
									<TD align=right height=30>
										入库时间：
									</TD>
									<TD class=category>
										${storageList.storageDate}
									</TD>
								</TR>
								<TR>
									<TD align=right height=30>
										仓库：
									</TD>
									<TD class=category>
										${storageList.depot.name}
									</TD>
								</TR>
								<TR>
									<TD align=right height=30>
										总价格：
									</TD>
									<TD class=category>
										${storageList.productPriceSum}
									</TD>
								</TR>
								<TR>
									<TD align=right height=30>
										备注：
									</TD>
									<TD class=category>
										${storageList.storageRemark}
									</TD>
								</TR>

								<TR>
									<TD align=right height=30>
										审核：
									</TD>
									
										<TD class=category>
									<c:if test="${storageList.storageVerify==0||storageList.storageVerify==null}">
													未审核
													</c:if>
													<c:if test="${storageList.storageVerify==1 ||storageList.storageVerify==2}">
													已审核
													</c:if>
													<c:if test="${storageList.storageVerify==8}">
													审核进行中
													</c:if>
										</TD>
										 
								</TR>
								<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核操作:
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${storageList.storageNo}','Storage','storageVerify','storageNo')"/>
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
						入库详单信息：
						<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
							align=center border=1>

							<TBODY>
								<c:choose>

									<c:when test="${storageList.allType.typeName eq '新购入库'}">
										<TR align="center">
											<TD width="18%" class=category>
												到货单号
											</TD>
											<TD width="18%" class=category>
												批次号
											</TD>
										</TR>
										<!--循环-->
										<c:forEach items="${storageList.storageInfos}" var="data">

											<TR>

												<TD align=center>
													${data.toOrder.toOrderNum}
												</TD>
												<TD align=center>
													${data.toOrder.piciNo}
												</TD>

											</TR>
										</c:forEach>
										<TR>
											<TD class=category colSpan=14 height=30>
											</TD>
										</tr>

									</c:when>
									<c:when test="${storageList.allType.typeName eq '报益入库'}">


										<TR>
											<TD align=center height=30 width="200">
												报益单号
											</TD>
										</TR>
										<c:forEach items="${storageList.storageInfos}" var="infodata">

											<tr id="tr" align=center >
												<td>
													${infodata.income.incomeNo }
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:when test="${storageList.allType.typeName eq '客户商品入库'}">

										<TR>
											<TD align=center height=30 width="100">
												商品名称
											</TD>
											<TD align=center height=30 width="100">
												商品型号
											</TD>
											<TD align=center height=30 width="100">
												条形码
											</TD>
										</TR>
										<c:forEach items="${storageList.storageInfos}" var="data">

											<c:forEach items="${data.products}" var="product">

												<tr>
													<td align=center>

														${product.property.name}

													</td>
													<td align=center>
														<a href="getPropertyInfoCommodity.do?id=${product.id}">${product.property.model.name }</a>

													</td>
													<td align=center>

														${product.barcode }
													</td>
												</tr>
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<TR>
											<TD align=center height=30 width="200">
												条形码
											</TD>
											<TD align=center height=30 width="200">
												商品型号
											</TD>
										</TR>
										<c:forEach items="${storageList.storageInfos}" var="infodata">

											<c:forEach items="${infodata.products}" var="products">

												<tr>
													<td align=center >
														${products.barcode}
													</td>
													<td align=center >
														${products.property.model.name }
													</td >
												</tr>
											</c:forEach>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								<TR>
									<TD>
										<IMG alt=""
											src="<%=request.getContextPath() %>/images/r_4.gif">
									</TD>
									<TD></TD>
									<TD>
										<IMG alt=""
											src="<%=request.getContextPath() %>/images/r_3.gif">
									</TD>
								</TR>
							</TBODY>

						</TABLE>
						<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
</HTML>
