<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>采购订单列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(){
       form1.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form1.submit();
    }
    
    //保存按钮的显示和隐藏
		function showbc(){
		  var marker2 = $("#marker2").val();
		  var taskid = $("#taskid").val();
		  if(marker2.length>0 && marker2!="" && taskid!=""){
		     document.getElementById("bc").style.display='block';
		  }else{
		     document.getElementById("bc").style.display='none';
		  }
		}
</script>
<base target="_self"/> 
</head>
<body onload="showbc()">
		<FORM name=form2 action="getPurchaseOrder.do?funid=54" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							采购单号：
							<INPUT name="purNo" id="purNo" >
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="" id="form1" name="form1">
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
										&nbsp;采购单记录查询
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
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="10%" height=30 class=category>
											采购单编号
										</TD>
										<TD width="10%" class=category>
											付款金额(单位：元/RMB)
										</TD>
										<TD width="10%" class=category>
											审核是否通过
										</TD>
										<TD width="10%" class=category>
											供应商
										</TD>
										<TD width="12%" class=category>
											订货时间
										</TD>
										<TD width="12%" class=category>
											交货时间
										</TD>
										<TD width="8%" class=category>
											经办人
										</TD>
										<TD width="8%" class=category>
											详细信息
										</TD>
										<TD width="9%" class=category>
											流程跟踪
										</TD>
										<TD width="6%" class=category>
											修改
										</TD>
										<TD width="8%" class=category>
											删除
										</TD>
									</TR>
									<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							        <input type="hidden" id="taskid" name="taskid" value="${taskid }" />

									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												${data.purOrderNo }
												</TD>
												<TD align=middle>
													${data.price}
												</TD>
												<TD align=middle>
													
													<c:if test="${data.auditingState==0||data.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingState==1||data.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${data.auditingState==3}">审核通过已退货</c:if>
													<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</TD>
												<TD align=middle>
													${data.supplier.supplierName}
												</TD>
													<TD align=middle>
													${data.orderTime}
												</TD>
												<TD align=middle>
													${data.deliveryTime}
												</TD>
												<TD align=middle>
													${data.employee.name}
												</TD>
												<TD align=middle>
													<a href="detailPurchaseOrder.do?cid=${data.id}&purNo=${data.purOrderNo}&info=info">详细信息</a>
												</TD>
												<TD align=center>
													<a href="followAuditing.do?orderNo=${data.purOrderNo }">流程跟踪</a>
												</TD>
												<TD align=middle>
												<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
													<c:if test="${data.auditingState!=8}">
													<IMG style="CURSOR: hand" onclick="valEdit('${data.purOrderNo }','updateShowPurchaseOrder.do?cid=${data.id }')"
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</c:if>
													</c:if>
													</c:forEach>
													<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</TD>
												<TD align=middle>
												<c:if test="${data.auditingState!=8}">
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</c:if>
												<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</TD>
											</TR>
											</c:forEach>
					
											<TR>

											</tr>
									<!--循环结束-->




									<TD class=category colSpan=12 height=30 align="right">
								     
								     	<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
														<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('deletePurchaseOrder.do','getPurchaseOrder.do?funid=54')"
															value="删 除">
															</c:if>
															</c:forEach>
									</TD>
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
					<TD><p:pages url="getPurchaseOrder.do?funid=54"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
