<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<HEAD>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>订单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<base target="_self">
<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
<script type="text/javascript">
function dialogInfo(id)
{
	var url="selectSaleOrderInfoOutbound.do";
	$.post(url,{id:id,mark:"server"},function(data){
		
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

function selectsale(id,saleNo,customerCompany,cusName,phone,empName,cusId,ipNum)
		{
		$("#saleOrderid").attr("value",id);
		$("#saleOrderNum").attr("value",saleNo);
		$("#comname").attr("value",customerCompany);
		$("#linkname").attr("value",cusName);
		$("#phone").attr("value",phone);
//		$("#employeename").attr("value",empName);
		$("#employeename").html(empName);
		$("#comid").attr("value",cusId);
		$("#serverIpNum").attr("value",ipNum);
		$("#salePerson").attr("value",empName);
		
		$("#saleOrderNoid").attr("value",id);
		$("#saleOrderNo").attr("value",saleNo);
			$("#dianji").click();
			
		}
		
		
		
function selectsale2(id,saleNo,endTime,price)
		{
		$("#saleOrderid").attr("value",id);
		$("#orderEndTime").attr("value",endTime);
		$("#saleOrderNoid").attr("value",id);
		$("#saleOrderNo").attr("value",saleNo);
		$("#price").attr("value",price);
			$("#dianji").click();
			
		}
//收款单
function selectsale3(id,saleNo,price,empid,empname)
		{
		$("#saleOrderNo").attr("value",saleNo);
		$("#saleOrderNoid").attr("value",id);
		$("#saleOrderNo").attr("value",id);
		$("#accountPayable").attr("value",price);
		$("#PaymentAmount").attr("value",price);
		$("#emp").attr("value",empname);
		$("#empid").attr("value",empid);
			$("#dianji").click();
		}
		
function selectsale4(id,saleNo,customerCompany,cusName,phone,cusId,empName,ipnum){
        $("#saleOrderid").attr("value",id);
		$("#saleOrderNum").attr("value",saleNo);
		$("#comname").attr("value",customerCompany);
		$("#linkname").attr("value",cusName);
		$("#phone").attr("value",phone);
//		$("#employeename").attr("value",empName);
		$("#employeename").html(empName);
		$("#comid").attr("value",cusId);
		$("#serverIpNum").attr("value",ipnum);
//		$("#salePerson").attr("value",empName);
		$("#dianji").click();
}
</script>
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<!--<TD align=right width="95%">
							订单号：
							<INPUT name="saleorderserial" id="saleorderserial"/>
							<INPUT class=button type=submit  onclick="selectinfo('getSaleOrderListClientOrder.do?page=${page }&auditingState=${auditingState }&saleorderserial','saleorderserial')" value=" 查询 ">
							&nbsp;
						</TD>
					--></TR>
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
										&nbsp;订单信息查询
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
										<TD width="20%" class=category>
											订单号2
										</TD>
										<TD width="10%" class=category>
											客户
										</TD>
										<TD width="10%" class=category>
											客户类型
										</TD>
										<TD width="10%" class=category>
											使用状态
										</TD>
										<TD width="10%" class=category>
											开始时间
										</TD>
										
										<TD width="10%" class=category>
											审核状态
										</TD>
										
										<TD width="15%" class=category>
											选择订单
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
											<TR id="tr${data.soId }" ondblclick="getvalue('${data.soId},${data.soNums },${data.customer.customerCompany },${data.customer.realName },${data.customer.phone },${data.customer.customerId }')" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=center height=25>
													${data.soNums}
												</TD>
												<TD align=center>
													${data.customer.realName}
												</TD>
												<TD align=center>
											  	    ${data.customer.customerType}
												</TD>
												<TD align=center>
											        <c:if test="${data.soStat==0}">
											                        等待续费
											        </c:if>
											        <c:if test="${data.soStat==1}">
											                        正常使用
											        </c:if>
											        <c:if test="${data.soStat==2}">
											                         待付款
											        </c:if>
											        <c:if test="${data.soStat==3}">
											                               已付款
											        </c:if>
												</TD>
												<TD align=center>
													${data.soOrderTime}
												</TD>
												
													<TD align=center>
													<c:if test="${data.soStat==3}">
													   审核通过
													</c:if>
													
												</TD>
												
												<TD align=center>
													
													<c:if test="${page == 'addupServer'}">
													<input id="" name="" type="button" onclick="selectsale4('${data.soId }','${data.soNums}','${data.customer.customerCompany}','${data.customer.realName}','${data.customer.phone}','${data.customer.customerId}','${data.customer.employee.name}','${data.ipnum}')" value="选择该订单"/>
													</c:if>
													
												</TD>
											</TR>
											</c:forEach>
											<tr>
												<td class=category colSpan=14 height=30>
												<pp:pages1 url="getSaleOrderListClientOrder.do" param="page=${page }&auditingState=${auditingState}"></pp:pages1>
												</td>
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
