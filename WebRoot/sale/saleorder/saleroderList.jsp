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
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY onload="showbc()">
	<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(){
       form1.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form1.submit();
    }
</script>

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
		
		//字段查找
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
			var customer = $("#customer").val();
			var realname =encodeURI(customer,"utf-8");
			var orderType = $("#orderType").val();
			var questionname=encodeURI(orderType,"utf-8");
			var typeName = $("#typeName").val();
			var typen=encodeURI(typeName,"utf-8");
			var beginTime = $("#beginTime").val();
			var endTime = $("#endTime").val();
			var salename = encodeURI($("#salename").val(),"utf-8");
			var price = $("#price").val();
			var state=encodeURI($("#state").val(),"utf-8");
			 $.ajax({
				  type: "get",
				  url: "getOrderListsaleOrder.do?type2=1&tage=y",
				  data:
					  {
					  "saleOrderNo":saleOrderNo,
					  "customer.realName":realname,
					  "allTypeByOrdertype.questionName":questionname,
					  "allTypeByPayStatus.typeName":typen,
					  "beginTime":beginTime,
					  "endTime":endTime,
					  "salename":salename,
					  "price":price,
					  "auditingState":state,
					  "pageNo":pageNo
					  },
				  success: function(data){						  
				      data1 = data.split("#");
					  $("#orderList").html(data1[0]);
					  alert(data1[1]);
					  $("#page").html(data1[1]);
					  }
				 });
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
		
		//关闭子窗体,刷新父窗体
		function reload(){
		  window.close();
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
                            					<c:if test="${order.ordertype.temp1 == 'SaleOrder'}">
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
						<FORM name=form1 id="form1" action="getOrderListsaleOrder.do?type2=1&tage=y" method="post">						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR align="center">				
									    <TD width="5%" class=category id="" >
											选择
										</TD>				
										<TD width="12%" class=category id="tsaleOrderNo"  onmouseover="showInput(this)"  onMouseOut="displayIput(this)" >
											订单号
											<input id="saleOrderNo" name="saleOrderNo" style="width:80%; display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tcustomer" width="10%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户
											<input id="customer"  name="customer.realName" style="width:80%;display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="torderType" width="8%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											订单类型
											<input id="orderType"  width="100%" name="allTypeByOrdertype.questionName" style="width:80%;display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="ttypeName" width="8%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											使用状态
											<input id="typeName"  width="10%" name="allTypeByPayStatus.typeName" style="width:80%;display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tbeginTime" width="8%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											开始时间
											<input id="beginTime"  width="10%" name="beginTime" style="width:80%;display: none"  onclick="WdatePicker()" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tendTime" width="8%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											到期时间
											<input id="endTime"  width="8%" name="endTime" style="width:80%;display: none"  onclick="WdatePicker()"  onkeyup="selectcustomer(1)"/>
										</TD>
										<TD width="7%" class=category id="tstate"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											审核是否通过
											<input id="state"  width="8%" name="state" style="width:80%;display: none"  onkeyup="selectcustomer(1)"/>
										</TD>
										
										<TD width="8%" class=category>
										详细信息
										</TD>
										<TD width="8%" class=category >
										流程跟踪
										</TD>
										<TD id="tprice" width="6%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											订单金额
											<input id="price" name="price"  width="6%" style="width:80%;display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD id="tsalename" width="6%" class=category  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											负责人员
											<input id="salename" name="salename"  width="6%" style="width:80%;display: none" onkeyup="selectcustomer(1)"/>
										</TD>
										<TD width="12%" class=category>
											删除/更新订单
										 <input type="hidden" id="marker2" name="marker2" value="${marker }" />
							             <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
										</TD>
									</TR>
								</TBODY>
								<tbody id="orderList">
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>		
											    <TD align=center>
											     <input type="checkbox" id="ids" name="ids" value="${data.id }"/>
											    </TD>										
												<TD align=center height=25>		
												  <input type="hidden" id="${data.id}" value="${data.id}"/>									
													<a href="infosaleOrder.do?id=${data.id}">${data.saleOrderNo}</a>
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
													<c:if test="${data.auditingState==3}">待用户确认  </c:if>
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
											${data.customer.employee.name }
										</TD>
										<TD align=center>
											<IMG style="CURSOR: hand" onclick="valEdit('${data.saleOrderNo }','updatesaleOrder.do?id=${data.id }')"
														hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
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
									  <td colspan="13" align="right">
									 <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
									   <input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
									</td>
									</tr>
								</tbody>
									<tr>
									<td class=category colSpan=14 height=30></td>
									</tr>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					<TD>
					</TD>
				</TR>
				
				<TR>
					<TD colspan="3" id="page">
						<c:if test="${empty tag}">
							<p:pages url="selectsaleOrder.do?funid=179"/>
						</c:if>
						<c:if test="${not empty tag}">
							<c:if test="${state == '1'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder"/></c:if>
							<c:if test="${state == '0'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder&state=0"/></c:if>
							<c:if test="${state == '2'}"><p:pages url="selectsaleOrder.do?marker=SaleOrder&state=2"/></c:if>
						</c:if>
					</TD>
				</TR>
			</TBODY>
		</TABLE> 
	</BODY>
</HTML>
