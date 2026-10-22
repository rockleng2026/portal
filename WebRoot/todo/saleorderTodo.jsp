<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
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

		<SCRIPT language=javascript>
		
		function del(id)
		{
		var t=new Date();
		var url="delsaleOrder.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==0)
		             {
		                 alert("删除成功");
		                 window.location.href="selectsaleOrder.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
		
		function orderstate(op)
		{
			window.location.href="selectsaleOrder.do?marker=SaleOrder&state="+op;
		}
		
</SCRIPT>
		<FORM name=form2 action="selectsaleOrder.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<td align="right">
							单据审核状态：
							<c:if test="${empty backlogList}">	<input type="button" value=" 查看待审 (0)" onclick="orderstate('1')"/></c:if>
                            	<c:if test="${not empty backlogList}">
                            		<c:forEach items="${backlogList }" var="backlog" varStatus="status">
                            			<c:forEach items="${orderlist}" var="order">
                            				<c:if test="${backlog.verifyOrder.id == order.id}">
                            					<c:if test="${order.entityName == 'SaleOrder'}">
                            			&nbsp; 	<input type="button" value=" 查看待审 (${backlog.tmp})" onclick="orderstate('1')"/>
                            					</c:if>
                            				</c:if>
                            			</c:forEach>
                            		</c:forEach>
                            	</c:if>
                            	&nbsp;<input type="button" value=" 查看未审 " onclick="orderstate('0')" />&nbsp;
                            	<input type="button" value=" 查看已审 " onclick="orderstate('2')"/>
						</td>
						<TD align=right width="50%">
						&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;订单号：
							<INPUT name=orderNo id="orderNo">
							<INPUT class=button type=submit value=" 查询 ">
							<c:if test="${not empty tag}"><INPUT type="hidden" name="marker" value="SaleOrder">
								<INPUT type="hidden" name="state" value="${state }">
							</c:if>
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
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										<c:if test="${empty tag}">&nbsp;订单信息查询</c:if>
										<c:if test="${not empty tag}">&nbsp;
											<c:if test="${state=='1' || state == ''}">查询待审核订单信息</c:if>
											<c:if test="${state == '0'}">查询未审核订单信息</c:if>
											<c:if test="${state == '2'}">查询已审核订单信息</c:if>	
										</c:if>
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
						<FORM name=form1 action="" onsubmit="">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="12%" class=category>
											订单号
										</TD>
										<TD width="10%" class=category>
											客户
										</TD>
										<TD width="10%" class=category>
											订单类型
										</TD>
										<TD width="10%" class=category>
											使用状态
										</TD>
										<TD width="10%" class=category>
											开始时间
										</TD>
										<TD width="8%" class=category>
											到期时间
										</TD>
										<TD width="7%" class=category>
											审核是否通过
										</TD>
										
										<TD width="9%" class=category>
										详细信息
										</TD>
										<TD width="9%" class=category>
										流程跟踪
										</TD>
										<TD width="6%" class=category>
											订单金额
										</TD>
										<TD width="12%" class=category>
											删除/更新订单
										</TD>

										
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR >
												
												<TD align=center height=25>
											
													${data.saleOrderNo}
												</TD>
												<TD align=center>
											
													${data.customer.realName}
												</TD>
												<TD align=center>
											   ${data.allTypeByOrdertype.questionName}
												
												</TD>
												<TD align=center>
											${data.allTypeByPayStatus.typeName}
													
												</TD>
												<TD align=center>
												${data.beginTime}
												

													</TD>
													<TD align=center>
													${data.endTime}
													
												</TD>
												<TD align=center>
													<c:if test="${data.auditingState==0||data.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingState==1 ||data.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${data.auditingState==8}">审核进行中  </c:if>
												</TD>
										<TD align=center>
										<a href="infosaleOrder.do?info=info&id=${data.id }">详细信息</a>
										</TD>
										<TD align=center>
										<a href="followAuditing.do?orderNo=${data.saleOrderNo }">流程跟踪</a>
										</TD>
										<TD align=center>
											${data.price }
										</TD>
										<TD align=center>
											<c:forEach items="${option}" var="data1">
												<c:if test="${data1.key==2}">
												<c:if test="${data.auditingState!=8}">
												<IMG style="CURSOR: hand" onclick="valEdit('${data.saleOrderNo }','updatesaleOrder.do?id=${data.id }')"
														hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
												</c:if>
												<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</c:if>
												<c:if test="${data1.key==3}">
												<c:if test="${data.auditingState!=8}">
												<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												
												</c:if>
												<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</c:if>
											</c:forEach>
										</TD>
									</TR>
									</c:forEach>
								<tr>
								<td class=category colSpan=14 height=30>						</td>
									</tr>
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
					<TD>

					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE> 
	</BODY>
</HTML>
