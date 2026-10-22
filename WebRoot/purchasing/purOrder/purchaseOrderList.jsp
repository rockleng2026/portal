<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag1.tld" prefix="pp" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>采购订单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
function getvalue(id,NO,deliveryTime,price)
{
	window.returnValue=id+","+NO+","+deliveryTime+","+price;
	window.close();
}
function selectpo(id,no)
{
	$("#purOrderid").attr("value",id);
	$("#purOrderNO").attr("value",no);
	var url="selectpoOutbound.do";
	$.post(url,{id:id},function(data){
		$("#editTabs").append(data);
	});
	$("#dianji").click();
}

function dialogInfo(id)
{

	var url="selectpoinfoOutbound.do";
	$.post(url,{id:id},function(data){
		
			$("#selectinfo").append(data);
			$("#selectList").css("display","none");
			$("#close").css("display","");
	});
}
function closeInfo()
{
	$("#selectinfo").html("");
	$("#close").css("display","none");
	$("#selectList").css("display","");
}
</script>
<base target="_self"/> 
</head>
<body>
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							采购单号：
							<INPUT name="payNo" id="payNo">
							<INPUT class=button type=submit onclick="selectinfo('getPurchaseOrder.do?is=is&purNo','payNo')"   value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<div id="selectList" name="selectList">
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
								align=center border=1 width="100%">

								<TBODY>
									<TR align="center">
										<TD width="10%" height=30 class=category>
											采购单编号
										</TD>
										<TD width="10%" class=category>
											付款金额(单位：元/RMB)
										</TD>
										
										<TD width="5%" class=category>
											审核是否通过
										</TD>
										<TD width="10%" class=category>
											供应商的
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
										<TD width="10%" class=category>
											详细信息
										</TD>
										<TD width="10%" class=category>
											选择该订单
										</TD>
									</TR>
									<!--循环-->                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR onclick="gettr(${data.id});" id="tr${data.id}" ondblclick="getvalue('${data.id},${data.purOrderNo },${data.deliveryTime},${data.price}');">
												<TD align=middle>
												${data.purOrderNo }
												</TD>
												<TD align=middle>
													${data.price}
												</TD>
												
												<TD align=middle>
													${data.auditingState}
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
													<a href="#" onclick="dialogInfo(${data.id })">	详细信息</a>
												</TD>
												<TD align=middle>
													<input id="" name="" type="button" onclick="selectpo('${data.id}','${data.purOrderNo }')" value="选择该订单" />
												</TD>
											</TR>
											</c:forEach>
											<TR>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
						<!--endprint-->
					</TD>
					<TD>
					<br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD><pp:pages1 url="getPurchaseOrder.do?is='is'"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		<div>
		<table name="selectinfo" id="selectinfo"  class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
					
				</table>
			</div>
	</BODY>
</HTML>
