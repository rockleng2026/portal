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
	
		
										<TD width="6%" class=category>
											订单金额
										</TD>
		

										
									</TR>


									<!--循环-->
									
									<c:forEach items="${orderlist}" var="data" >
											<TR>
												
												<TD align=center height=25>
											
													${data.saleOrderNo}
												</TD>
												<TD align=center>
													<a href="infosaleOrder.do?id=${data.id}">${data.customer.realName}</a>
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
											${data.price }
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
						<c:if test="${empty tag}">
							<p:pages url="selectsaleOrder.do?funid=179"/>
						</c:if>
						<c:if test="${not empty tag}">
							<c:if test="${state == '1'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder"/></c:if>
							<c:if test="${state == '0'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder&state=0"/></c:if>
							<c:if test="${state == '2'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder&state=2"/></c:if>
						</c:if>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE> 
	</BODY>
</HTML>
