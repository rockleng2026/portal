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
		<title>上架单列表</title>
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
function serverselect(id,ips,serverName,typename,xinghao,tx,serverLocation,upNo)
{
		var url="findServiceLocationOutbound.do";
		  			$("#serverId").attr("value",id);
		  			$("#productid").attr("value",id);
		  			$("#server").attr("value",serverName);
			       $("#serverLocation").attr("value",serverLocation);
			       $("#upNo").attr("value",upNo);
			        var num=$("#num").val();
			        if(num==null||num==undefined)
			        {
			       if(serverLocation !=null && serverLocation != '')
			       {
					alert(ips);
					var ipli=ips.split(',');
					
					var ipss="";
					alert(ipli.length);
					for(var i=0;i<ipli.length;i++)
					{
						
						//var s=ipli[i].split(',');
						//alert(s[0]+s[1]);
						ipss+="<input type='checkbox' id='serverIp' checked='checked'  name='serverIp' value="+ipli[0]+" />"+ipli+"&nbsp;&nbsp;";
					}  
						document.getElementById("liip").innerHTML=ipss;
					
					}
					}
					 $("#serverName").attr("value",serverName);
					
				
					 if(num!=null&&num!=undefined)
					 {
					 	$("#code"+num+"").attr("value",tx);
					 	$("#codeId"+num+"").attr("value",id);
					 	$("#pname"+num+"").attr("value",serverName);
					 	$("#pmodel"+num+"").attr("value",xinghao);
					 	$("#ptype"+num+"").attr("value",typename);
					 	$("#models"+num+"").attr("value",id);
					 	$("#model"+num+"").attr("value",xinghao);
					 	$("#barcode"+num+"").attr("value",tx);
					 }
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
						<TD align=right width="95%">
							条件查询：
							<INPUT name="saleorderserial" id="saleorderserial"/>
							<INPUT class=button type=submit  onclick="selectinfo('getSaleOrderListClientOrder.do?page=${page }&auditingState=${auditingState }&saleorderserial','saleorderserial')" value=" 查询 ">
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
										&nbsp;上架单信息查询
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
											客户
										</TD>
										<TD width="10%" class=category>
											机房
										</TD>
										<TD width="10%" class=category>
											ip
										</TD>
										<TD width="10%" class=category>
											宽带
										</TD>
										<TD width="10%" class=category>
											到期时间
										</TD>
										<TD width="10%" class=category>
											上架状态
										</TD>
										<TD width="10%" class=category>
											业务员
										</TD>
										<TD width="10%" class=category>
											详细信息
										</TD>
										<TD width="15%" class=category>
											选择订单
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
											<TR id="tr${data.id }"  onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												<TD align=center height=25>
													${data.customer.realName}
												</TD>
												<TD align=center>
													${data.serverLocation}
												</TD>
												<TD align=center>
											  	    ${data.serverIp}
												</TD>
												<TD align=center>
											        ${data.bandwidthAmount}
												</TD>
												<TD align=center>
													<c:if test="${data.upFlag==1||data.upFlag==2}">
													已上架
													</c:if>
												</TD>
												<TD align=center>
												    <c:set var="birthDate" scope="request" value="${data.downtime}"  />
											<%
											
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
												</TD>
												<TD align=center>
													${data.saleOrder.employee.name}
												</TD>
												<TD align=center>
													<a href="detailedUpserver.do?cid=${data.id }&upNo=${data.upNo }&info=info">详细情况</a>
												</TD>
												<td>
												<input id="" name="" type="button" onclick="serverselect('${data.product.id }','${data.serverIp }','${data.product.property.name}','${data.product.property.model.commodityTpye.typeName}','${data.product.property.model.name}','	${data.product.barcode}','${data.serverLocation }','${data.upNo }')" value="选择该订单"/>
												</td>
											</TR>
											</c:forEach>
											<tr>
												<td class=category colSpan=14 height=30>
												<pp:pages1 url="showDialogOutbound.do" param="mark=upserver&&state=${state }&funid=200"></pp:pages1>
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
