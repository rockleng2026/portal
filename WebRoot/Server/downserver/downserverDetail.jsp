<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
	
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
</head>	
<% request.setCharacterEncoding("gbk");
	response.setCharacterEncoding("gbk");
%>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<BODY>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
				<font>审核流程：</font>　　　　
					   <c:forEach items="${auditingList}" var="adata">
				       <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
				       <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
				       <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
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
											&nbsp;下架单详细信息
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border="1" >
								<TBODY>
									<tr>
										<td width="20%" height="30" align="right">
											单位名称：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${downDetail.customer.customerCompany }
										</td>
										<td width="20%" height="30" align="right">
											业务类型：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${downDetail.businesstype }
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											联系人：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${downDetail.customer.realName }
										</td>
										<td width="20%" height="30" align="right">
											电话：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${downDetail.customer.phone }
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											证件号码：
										</td>
										<td width="30" height="30" align="left"  class=category >
											${downDetail.customer.cardid }
										</td>
										<td width="20%" height="30" align="right">
											公司负责人：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${downDetail.customer.employee.name }
										</td>
									</tr>
									
									<TR>
										<TD width="20%" height=30 align=right>
											下架单号：
										</TD>
										<TD width="30%" class=category>
											${downDetail.downNo}
											<input type="hidden" id="orderNo" name="orderNo" value="${downDetail.downNo}">
											<input type="hidden" id="tab" name="tab" value="DownServer">
											<input type="hidden" id="filed" name="filed" value="auditingFlag">
											<input type="hidden" id="orderName" name="orderName" value="downNo">
										</TD>
										<TD width="20%" height=30 align=right>
											上架单号：
										</TD>
										<TD width="30%" class=category>
											${downDetail.upNo}
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${downDetail.auditingFlag==0||downDetail.auditingFlag==null}">
													未审核
													</c:if>
													<c:if test="${downDetail.auditingFlag==1||downDetail.auditingFlag==2}">
													已审核
													</c:if>
													<c:if test="${downDetail.auditingFlag==8}">审核进行中</c:if>
													</TD>
									</TR>
									<TR>
										<TD width="20%" height=30 align=right>
											服务器名称：
										</TD>
										<TD width="30%" class=category>
											${downDetail.product.property.name}
										</TD>
									</TR>
									<tr >
										<td width="20%" height="30" align="right">
											要下架的IP：
										</td>
										<td colspan="3" height="30" align="left"  class=category>
											${downDetail.serverIp }
										</td>
									</tr>
									<TR>
										<td width="20%"  height=30 align=right >
											下架原因：
										</td>
										<td width="30%"  class=category  align="left" height="30">
											${downDetail.downcause }
										</td>
										<td width="20%"  height=30 align=right >
											配置详情：
										</td>
										<td  width="30" height="30" align="left"  class=category>
											${downDetail.configurationinfo }
										</td>
									</TR>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											机房位置：
										</td>
										<td  width="30%" class=category  >
											${downDetail.serverLocation }
										</td>
										<TD width="20%" height=30 align=right>
											下架类型：
										</TD>
										<TD width="30%" class=category>
											${downDetail.allType.typeName }
										</TD>
									</tr>
									
									
									<tr>
										<td  width="20%"  height=30 align=right >
											系统显示：
										</td>
										<td  width="30%" class=category   class=category >
											${downDetail.system }
										</td>

										<td  width="20%"  height=30 align=right >
											带宽/流量：
										</td>
										<td  width="30%" class=category >
											${downDetail.bandwidthflow }
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											财务结算：
										</td>
										<td  colspan="1" class=category >
											反退金额：${downDetail.returnAmout }
										</td>
										<td  colspan="2" class=category >
											结算帐号：${downDetail.settlementAccount }
										</td>
									</tr>
									
									
									<tr>
										<td width="25%"  height=30 align=right >
											下架日期：
										</td>
										<TD class=category>
											<c:set var="birthDate" scope="request" value="${downDetail.dtime}"  />
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
										</TD>
										<td width="25%"  height=30 align=right >
											费用结清：
										</td>
										<td  width="25" height="30" align="left"  class=category>
											<c:if test="${downDetail.costFlag==0}">
												已经结清
											</c:if>
											<c:if test="${downDetail.costFlag==1}">
												没有结清
											</c:if>
										</td>
									</tr>

									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category> 
											${downDetail.employee.name}
										</TD>
										
										<TD align=right height=30>
										        备注：
										</TD>
										<TD class=category>
											${downDetail.remark }
										</TD>
										
									</TR>         
									
									<TR>
									<c:if test="${quanxian=='quanxian'}">
										<TD height=30 align=right>
											审核状态
										</TD>

										<TD class=category colspan="1">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${downDetail.downNo}','DownServer','auditingFlag','downNo')"/>
										 </c:if>
										<c:if test="${mark != 'mark'}">
									           <c:if test="${flage==0||flage==null}">
									               <input type="button" value="审核" onclick="completemission('${data.id }',2)">
									           </c:if>
									            <c:if  test="${flage==1 ||flage==2}">
									                                  您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：
									             <c:if test="${aot.auditingFlag==1}">通过</c:if>
									             <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									              </c:if>
									        </c:if>
									 	<br>
										</TD>
										</c:if> 
										<TD align=right height=30 >
											下架状态：
										</TD>
										<TD class=category>
											<c:if test="${downDetail.downFlag==0}">
												未下架
											</c:if>
											<c:if test="${downDetail.downFlag==1}">
												已下架
											</c:if>
										</TD>

									</TR>
									                    
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
