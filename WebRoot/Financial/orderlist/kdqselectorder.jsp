<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
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
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
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

		function showInput(obj){

			var v = $("#"+obj.id).find("input,select").get(0); 

		    var inputid = v.id;
		    $("#"+inputid).css("display","");		
		}
		
		function displayIput(obj){
		  var v = $("#"+obj.id).find("input,select").get(0); 
		    var inputid = v.id;
		    var vals = $("#selecttage").val();
		    if(vals != '1'){
		    $("#"+inputid).css("display","none");
		    }
		}

		function selectcustomer(pageNo){		

			$("#form1 select").css("display","none");
			var saleOrderNo = $("#saleOrderNo").val();
			var upserverNo = $("#upserverNo").val();
			var customer = $("#customer").val();
			var realname =encodeURI(customer,"utf-8");
			var orderType = $("#ordertype").val();
			var questionname=encodeURI(orderType,"utf-8");
			var beginTime = $("#begintime").val();
			var endTime = $("#uptime").val();
			var downtime = $("#downtime").val;
			var salename=$("#salename").val();
			var sale=encodeURI(salename,"utf-8");
			var paystyle=$("#paystyle").val();
			var typename=encodeURI(paystyle,"utf-8");
			var price = $("#price").val();	
			
			//var formdata = $("#form1").serialize();
			//alert(formdata);
			//formdata = encodeURI(formdata);

			 $.ajax({
				  type: "post",
				  url: "kdqsaleOrder.do?tage=s&pageNo="+pageNo,
				  data: {
					  "saleOrderNo":saleOrderNo,
					  "upserverNo":upserverNo,
					  "realName":realname,
					  "questionname":questionname,
					  "beginTime":beginTime,
					  "endTime":endTime,
					  "downtime":downtime,
					  "saleName":sale,
					  "typeName":typename,
					  "price":price,
					  "allTypeByPayStatus.type":1
					  },
				  success: function(data){						  
				      
					  data1 = data.split("#");
					  
					  $("#orderList").html(data1[0]);
					  $("#page").html(data1[1]);
					  }
				 });
			 
		}
		function orderOut(){
		   //alert("order");
		   location.href="exportorderssaleOrder.do?oper=part";
		}

</SCRIPT>

	
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
										<a href="javascript:orderOut();" style="margin-left:40px;border:0px;">数据导出</a>
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
						<FORM name=form1 id="form1" action="kdqsaleOrder.do" method="post">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

							<tbody>
									<TR align="center">
									
										<TD width="12%" class=category id="tsaleOrderNo"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
											订单号
											<input id="saleOrderNo" name="saleOrderNo" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
										<TD width="12%" class=category id="tupserverNo"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
											上架单号
											<input id="upserverNo" name="upserverNo" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
										<TD width="10%" class=category id="tcustomer"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
											客户
											<input id="customer" name="customer" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
										<TD width="8%" class=category id="tordertype"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)"  >
											订单类型
											<input id="ordertype" name="allTypeByOrdertype.questionName" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
										<TD width="8%" class=category>
											使用状态
											<input type="hidden" id="paystatus" name="allTypeByPayStatus.type" value="1">
										</TD>
										<TD width="8%" class=category id="tbegintime"  >
											开始时间
											<input id="begintime" name="beginTime" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
										<TD width="8%" class=category id="tuptime" >
											上架时间
											<input id="uptime" name="uptime" style="width:80%; display: none"  onchange="selectcustomer(1)"/>
										</TD>
										<TD width="8%" class=category id="tdowntime">
											下架时间
											<input id="downtime" name="downtime" style="width:80%; display: none"  onchange="selectcustomer(1)"/>
										</TD>
	                                    <TD width="8%" class=category id="tsalename"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
	                                                                                                          销售人员
	                                        <input id="salename" name="employee.name" style="width:80%; display: none" onchange="selectcustomer(1)"/>                                                                  
	                                    </TD>
	                                    <TD width="8%" class=category id="tpaystyle"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
	                                                                                                          合同类别
	                                        <input id="paystyle" name="allTypeByPayStyle.typeName" style="width:80%; display: none" onchange="selectcustomer(1)"/>                                                                  
	                                    </TD>
		
										<TD width="6%" class=category id="tprice"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
											订单金额
											<input id="price" name="price" style="width:80%; display: none" onchange="selectcustomer(1)"/>
										</TD>
									</TR>
								</tbody>	
	                               <tbody id="orderList">
									<!--循环-->
									<%
									   List<Map<String, String>> listmap=(List<Map<String, String>>)request.getAttribute("listmap");
									   for(int i=0;i<listmap.size();i++){
									       Map<String,String> map=listmap.get(i);
									 %>
											<TR>
												<TD align=center height=25>
											          <a href="infosaleOrder.do?id=<%=map.get("id") %>"><%=map.get("saleOrderNo") %></a>
												</TD>
												<TD align=center height=25>
											          <a href="detailedUpserver.do?cid=<%=map.get("upId") %>&upNo=<%=map.get("upserverNo") %>&info=info"><%=map.get("upserverNo") %></a>
												</TD>
												<TD align=center>
													<a href="updateCustomersaleOrder.do?customer.customerId=<%=map.get("cid") %>&employee.id=<%=map.get("eid") %>"><%=map.get("customer") %></a>
												</TD>
												<TD align=center id="ordertype">
											       <span><%=map.get("ordertype")%></span>
												
												</TD>
												<TD align=center>
											<!--  ${data.allTypeByPayStatus.typeName} -->
													快到期
												</TD>
												<TD align=center>
												    <span> <%=map.get("begintime")%></span>												

													</TD>
													<TD align=center>
													<span><%=map.get("uptime")%></span>
													
												</TD>
												<TD align=center>
													<span><%=map.get("downtime")%></span>
													
												</TD>
												<TD align=center>
												  <span> <%=map.get("salename")%></span>
												</TD>
												<TD align=center>
												   <%=map.get("paystyle") %>
												</TD>
										<TD align=center>
											<%=map.get("price") %>
										</TD>
					
									</TR>
									<%} %>
								</tbody>
								<tr>
								<td class=category colSpan=14 height=30>						</td>
									</tr>
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
					<TD id="page">
							<p:pages url="kdqsaleOrder.do?allTypeByPayStatus.type=1&funid=14"/>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE> 
	</BODY>
</HTML>
