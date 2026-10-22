<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
</head>		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>


		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
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
					<TR>
					<font >审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;价格调整记录
										</TD>
										<TD align=right>
											&nbsp;<a href="javascript:history.go(-1);">返回</a>
											
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
											价格调整单号：
										</TD>
										<TD width="75%" class=category>
											${nowpg.priceRegNo}
											<input type="hidden" id="orderNo" value="${nowpg.priceRegNo}" />
											<input type="hidden" id="tab" value="Priceregulation">
											<input type="hidden" id="filed" value="auditingState">
											<input type="hidden" id="orderName" value="priceRegNo">
											<input type="hidden" id="price" value="saleprice"/>  <!-- 存储价格字段 -->
										</TD>
									</TR>
									
									<TR>
										<TD width="25%" height=30 align=right>
											类型：
										</TD>
										<TD width="75%" class=category>
											${nowpg.model.commodityTpye.typeName}
											
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
										     型号：
										</TD>
										<TD class=category>
											${nowpg.model.name}
											
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											审核操作：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${nowpg.auditingState==0||nowpg.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${nowpg.auditingState==1||nowpg.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${nowpg.auditingState==8}">审核进行中</c:if>
											
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											采购价：
										</TD>
										<TD class=category>
											${nowpg.importprice}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											销售价：
										</TD>
										<TD class=category>
											${nowpg.saleprice}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											制定人：
										</TD>
										<TD class=category>
											${nowpg.employee.name}
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											制定时间：
										</TD>
										<TD class=category>
												<c:set var="birthDate" scope="request" value="${nowpg.rtime}"  />
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
										</TD>
									</TR>
									<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 align=right>
											审核状态
										</TD>
										<TD class=category colspan="3">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${nowpg.priceRegNo}','Priceregulation','auditingState','priceRegNo')"/>
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
							历史记录：
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
										<TD width="12%" class=category>
											类型
										</TD>
										<TD width="18%" class=category>
											型号
										</TD>
										<TD width="18%" class=category>
											进货价
										</TD>
										<TD width="18%" class=category>
											销售价
										</TD>
										<TD width="13%"  class=category>
											制定人
										</TD >
										<td width="18%" class=category>
											制定时间
                                        </td>
									</TR>


									<!--循环-->
									<c:forEach items="${historypg}" var="data" >

											<TR>

												<TD align=middle>
													${data.model.commodityTpye.typeName}
												</TD>
												<TD align=middle>
													${data.model.name}
													</TD>
													<TD align=middle>
													${data.importprice }
												</TD>
													<TD align=middle>
													${data.saleprice }
												</TD>
													<TD align=middle>
													${data.employee.name }
											</TD>
											<TD align=middle>
												<c:set var="birthDate" scope="request" value="${data.rtime }"  />
											<%
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
													
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
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
</HTML>
