<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Pragma" content="no-cache">
		<title>Insert title here</title>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/editTable.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/lhgdialog/lhgcore.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/lhgdialog/lhgdialog.min.js"></script>
		<script language="javascript"
			src="<%=request.getContextPath()%>/lhgdialog/lhgdialogCommon.js"></script>



		<c:if test="${oneStorage eq null}">
			<script>

$(function(){
   $("#storageType").removeAttr('disabled')
});

	function show(){          
			var storageNo = $("#RKBum").val(); 
			var dep =  encodeURI(encodeURI($("#dep").val(),"utf-8"));
			var storageType = $("#storageType").children('option:selected').val();
			alert(storageType);
			var emp =  encodeURI(encodeURI($("#emp").val(),"utf-8"));
			var cus = $("#cus").val();
			var storagetime = $("#storagetime").val();
			var sum = $("#sum").val();
			var remark = encodeURI(encodeURI($("#remark").val(),"utf-8"));

			var all=document.getElementsByName('toOrderNum');
			var allId=new Array();
			var j=0;
			for(var i=0;i<all.length;i++){
				allId[j]=all[i].value;
				j++;
			}
			alert(allId[0]);
			alert(2);
			var url = "detailstorageWarehousing.do?storageNo="+storageNo+"&dep="+dep+"&storageType="+storageType+"&emp="+emp+"&cus="+cus+"&storagetime="+storagetime+"&sum="+sum+"&remark="+remark+"&allid="+allId;
			showWindwoButton('ids','入库添加详细','800','550',url);          
	}  
</script>

		</c:if>
		<LINK href="<%=request.getContextPath()%>/Css/style.css" type=text/css
			rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY onload="tabload()">
		<FORM name=form1 action="findBatchexpCodeWarehousing.do" method="post"
			onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;入库单资料(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border="1">

								<input type="hidden" value="${oneStorage.storageId }" id="sid"
									name="storageId" />
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											入库单号：
										</TD>
										<TD width="75%" class=category>
											<c:if test="${oneStorage!=null}">
												<INPUT readonly="readonly" style="WIDTH: 200px" id="RKBum"
													name="storageNo" value="${oneStorage.storageNo }">
											</c:if>
											<c:if test="${oneStorage==null}">
												<INPUT readonly="readonly" style="WIDTH: 200px" id="RKBum"
													name="storageNo" value="${RKNo }">
											</c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库：
										</TD>
										<TD class=category align="left">
											<input name="dep" id="dep" readonly="readonly"
												onblur="checkValueByRules('dep','','depMsg')"
												value="${oneStorage.depot.name}"
												onclick="completemission('showDialogWarehousing.do?mark=depot','')">
											<input id="depId" type="hidden"
												value="${oneStorage.depot.id}" name="depot.id" />
											<FONT color=#ff0000>*</FONT><FONT id="depMsg" color=#ff0000></FONT>
										</TD>
									</TR>

									<TR>
										<TD align=right height=30>
											入库类型：
										</TD>
										<TD class=category>
											<c:if test="${oneStorage eq null}">
												<s:select onchange="begin(this)"
													onblur="checkValueByRules('storageType','','storageTypeMsg')"
													id="storageType" name="allType.id" cssClass="category"
													list="#request.typeList" listKey="id" listValue="typeName"
													value="%{-1,#request.oneStorage.allType.id}" headerKey="-1"
													headerValue="请选择">
												</s:select>
											</c:if>
											<c:if test="${oneStorage ne null}">
												<INPUT type="hidden" name="allType.id"
													value="${oneStorage.allType.id }">
												<INPUT id="typename" readonly="readonly" name="type"
													value="${oneStorage.allType.typeName }">
											</c:if>
											<FONT color=#ff0000>*</FONT><FONT id="storageTypeMsg"
												color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category>
											<input id="emp" value="${oneStorage.employee.name }"
												readonly="readonly"
												onblur="checkValueByRules('emp','','empMsg')"
												onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											<input id="empid" type="hidden"
												value="${oneStorage.employee.id }" name="employee.id" />
											<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<tr id="customerone">
										<td align=right height=30>
											客户：
										</td>
										<td class=category>
											<input id="cus" value="${oneStorage.customer.customerName}"
												onclick="completemission('showDialogOutbound.do?mark=custom','')"
												readonly="readonly">

											<input name="customer.customerId" id="cusid" type="hidden"
												value="${oneStorage.customer.customerId}" />
											&nbsp;

											<FONT color=#ff0000 id="cusMsg">客户入库需填写</FONT>
										</td>
									</tr>

									<TR>
										<TD align=right height=30>
											入库时间：
										</TD>
										<TD class=category>

											<INPUT id="storagetime" style="WIDTH: 150px" id="time"
												name="storageDate" value="${oneStorage.storageDate }"
												onclick="WdatePicker()" readonly="readonly">

											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
											<FONT color=#ff0000 id="orderMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											总价格：
										</TD>
										<TD class=category>

											<input id="sum" readonly="readonly"
												value="${oneStorage.productPriceSum }"
												name="productPriceSum" />
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											<s:textarea cols="50" id="remark" name="storageRemark"
												rows="7" value="%{#request.oneStorage.storageRemark}"></s:textarea>
											格式要求:入库类型+用途
										</TD>
									</TR>






									<tr>
										<td colspan="6">
											<!-- 客户商品入库 -->
											<div id="customerTask" style="display: none">
												<table border="1" bgcolor="white" id="customerTabs">
													<tr>
														<td colspan="4">
															<input class=button type="button" value="添加产品"
																onclick="editTab('customerTabs')">
														</td>
													</tr>

													<TR>

														<TD align=center height=30 width="200">
															商品型号
														</TD>
														<TD align=center height=30 width="200">
															条形码
														</TD>
														<td align=center height=30 width="50">
															删除
														</td>
													</TR>
													<%
														int i = 0;
													%>
													<c:if test="${oneStorage!=null}">
														<c:forEach items="${oneStorage.storageInfos}" var="data">
															<c:forEach items="${data.products}" var="product">
																<%
																	i++;
																%>
																<tr id="tr<%=i%>">
																	<td>
																		<input type="text" id='toOrderNum<%=i%>'
																			name="toOrderNum"
																			value="${product.property.model.name  }"
																			readonly="readonly" />

																	</td>
																	<td>

																		<input value="${product.barcode }" readonly="readonly" />
																	</td>
																	<td>
																		<input value="删除" class="button" type="button"
																			onclick='delStorageInfoData("${data.storageInfoId}","<%=i%>", "kh","客户商品入库")'></input>
																	</td>
																</tr>
															</c:forEach>
														</c:forEach>
													</c:if>
													<tr>
														<td>
															<input type="hidden" id="selId" value="<%=i%>" />

															<input type="hidden" id="sedit"
																value="${oneStorage.storageId }" />
														</td>

													</tr>

												</table>
												<table>
													<tr>
														<td width="200"></td>
														<TD class=category>
															<c:if test="${oneStorage==null}">
																<INPUT class=button type="submit" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;<INPUT class=button type=reset
																	value="重置 ">
															</c:if>
															<c:if test="${oneStorage!=null}">
																<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>

															&nbsp;&nbsp;&nbsp;&nbsp;
														</TD>
													</tr>
												</table>
											</div>

											<!-- 其他入库 -->

											<div id="totherTask" style="display: none">
												<table border="1" bgcolor="white" id="totherTabs">
													<tr>
														<td>

															<input class=button type="button" value="添加产品"
																onclick="editTab('totherTabs')">
														</td>
														<td></td>
													</tr>

													<TR>
														<TD align=center height=30 width="200">
															条形码
														</TD>
														<TD align=center height=30 width="200">
															商品型号
														</TD>
														<TD align=center height=30 width="50">
															删除
														</TD>
													</TR>
													<%
														int k = 1;
													%>
													<c:if test="${oneStorage!=null}">
														<c:forEach items="${oneStorage.storageInfos}"
															var="infodata">
															<c:forEach items="${infodata.products}" var="products">
																<%
																	k++;
																%>
																<tr id="tr<%=k%>">
																	<td>
																		<input type="text" id="barcode<%=k%>" name="barcodes"
																			value="${products.barcode}" readonly="readonly" />

																		<input type="hidden" id="code<%=k%>" name="code" />
																	</td>
																	<td>
																		<input type="text" id='toOrderNum<%=k%>'
																			name="toOrderNum"
																			value="${products.property.model.name }"
																			readonly="readonly" />
																	</td>

																	<td>
																		<input value="删除" class="button" type="button"
																			onclick='delStorageInfoData("${infodata.storageInfoId}","<%=k%>", "py","其他入库")'></input>
																	</td>
																</tr>
															</c:forEach>
														</c:forEach>
													</c:if>
													<tr>
														<td>
															<input type="hidden" id="selId" value="<%=k%>" />

															<input type="hidden" id="sedit"
																value="${oneStorage.storageId }" />
														</td>
													</tr>
												</table>
												<table>
													<tr>
														<td width="200"></td>
														<TD class=category>
															<c:if test="${oneStorage==null}">
																<INPUT class=button type="submit" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;<INPUT class=button type=reset
																	value="重置 ">
															</c:if>
															<c:if test="${oneStorage!=null}">
																<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>

															&nbsp;&nbsp;&nbsp;&nbsp;
														</TD>
													</tr>
												</table>
											</div>


											<!-- 新购入库 -->
											<div id="newTask" style="display: none">
												<table border="1" bgcolor="white" id="editTabs"
													name="editTabs">
													<tr>
														<td>

															<input class=button type="button" value="添加产品"
																onclick="editTab('warehousingaddtable')">
														</td>
													</tr>

													<TR>
														<TD align=center height=30 width="200">
															批次
														</TD>
														<TD align=center height=30 width="200">
															到货单号
														</TD>
														<TD align=center height=30 width="50">
															删除
														</TD>
													</TR>
													<%
														int j = 2;
													%>
													<c:if test="${oneStorage!=null}">
														<c:forEach items="${oneStorage.storageInfos}"
															var="infodata">
															<%
																j++;
															%>
															<tr id="tr<%=j%>">
																<td>
																	<input type="text" id="piciNo<%=j%>" name="piciNo"
																		value="${infodata.toOrder.piciNo }"
																		readonly="readonly" />

																	<input type="hidden" id="toOrderId<%=j%>"
																		name="toOrderIds" value="${infodata.toOrder.id }" />

																	<input type="hidden" id="code<%=j%>" name="code" />
																</td>
																<td>
																	<input type="text" id='toOrderNum<%=j%>'
																		name="toOrderNum"
																		value="${infodata.toOrder.toOrderNum  }"
																		readonly="readonly" />
																</td>

																<td>
																	<input value="删除" class="button" type="button"
																		onclick='delStorageInfoData("${infodata.storageInfoId}","<%=j%>", "${infodata.toOrder.id }","新购入库" )'></input>
																</td>
															</tr>
														</c:forEach>
													</c:if>
													<tr>
														<td>
															<input type="hidden" id="selId" value="<%=j%>" />

															<input type="hidden" id="sedit"
																value="${oneStorage.storageId }" />
														</td>
													</tr>

												</table>

												<table>
													<tr>
														<td width="200"></td>
														<TD class=category>
															<c:if test="${oneStorage==null}">
																<INPUT class=button type="button" value="下一步 "
																	onclick="show();">
											&nbsp;&nbsp;&nbsp;&nbsp;<INPUT class=button type=reset
																	value="重置 ">
															</c:if>
															<c:if test="${oneStorage!=null}">
																<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>

															&nbsp;&nbsp;&nbsp;&nbsp;
														</TD>

													</tr>

												</table>
											</div>
											<!-- 报益入库 -->
											<div id="surplusTask" style="display: none">
												<table border="1" bgcolor="white" id="surplusabsTabs">
													<tr>
														<td>

															<input class=button type="button" value="添加产品"
																onclick="editTab('surplusabsTabs')">
														</td>
														<td></td>
													</tr>

													<TR>
														<TD align=center height=30 width="200">
															报益单号
														</TD>
														<TD align=center height=30 width="50">
															删除
														</TD>
													</TR>
													<%
														int c = 3;
													%>
													<c:if test="${oneStorage!=null}">
														<c:forEach items="${oneStorage.storageInfos}"
															var="infodata">
															<%
																c++;
															%>
															<tr id="tr<%=c%>">
																<td>
																	<input type="text" id="income<%=c%>" name="income"
																		value="${infodata.income.incomeNo }"
																		readonly="readonly" />

																	<input type="hidden" id="incomeid<%=c%>"
																		name="incomeids" value="${infodata.income.id }" />
																</td>
																<td>
																	<input value="删除" class="button" type="button"
																		onclick='delStorageInfoData("${infodata.storageInfoId}","<%=c%>", "${infodata.income.id }","报益入库")'></input>
																</td>
															</tr>
														</c:forEach>
													</c:if>
													<tr>
														<td>
															<input type="hidden" id="selId" value="<%=c%>" />

															<input type="hidden" id="sedit"
																value="${oneStorage.storageId }" />
														</td>


													</tr>

												</table>
												<table>
													<tr>
														<td width="200"></td>
														<TD class=category>
															<c:if test="${oneStorage==null}">
																<INPUT class=button type="submit" value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;<INPUT class=button type=reset
																	value="重置 ">
															</c:if>
															<c:if test="${oneStorage!=null}">
																<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>

															&nbsp;&nbsp;&nbsp;&nbsp;
														</TD>
													</tr>
												</table>
											</div>
										</td>
									</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>

									</TR>
								</TBODY>
							</TABLE>
							<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
						</TD>
						<TD>
							<br>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD>
							<br>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>

		</FORM>
		<script type="text/javascript">
		window.onload = function()
		{
		var val = $.trim($("#typename").val());
		begin(val);
		}
		
		function begin(str)
		{
		var tag;
		if(typeof(str)=="string")
            {
            tag = str;
            }else
            {
		 tag = $("#"+str.id).find("option:selected").text();
		 }
		 
		if(tag == '新购入库')
		{
		$("#sum").attr("readonly","readonly");
		$("#totherTask")[0].style.display ="none";
		$("#customerTask")[0].style.display ="none";
		$("#surplusTask")[0].style.display ="none";
		$("#newTask")[0].style.display ="";
		$("#customerone").hide();
		return;
		}else if(tag == '客户商品入库')
		{
		$("#sum").removeAttr("readonly");
		$("#newTask")[0].style.display ="none";
		$("#surplusTask")[0].style.display ="none";
		$("#totherTask")[0].style.display ="none";
		$("#customerTask")[0].style.display ="";
		$("#customerone").show();
		return;
		}else if(tag == "报益入库")
		{
		$("#sum").removeAttr("readonly");
		$("#customerTask")[0].style.display ="none";
		$("#newTask")[0].style.display ="none";
		$("#totherTask")[0].style.display ="none";
		$("#surplusTask")[0].style.display ="";
		$("#customerone").show();
		
		}
		else 
		{
		$("#sum").removeAttr("readonly");
		$("#customerTask")[0].style.display ="none";
		$("#surplusTask")[0].style.display ="none";
		$("#newTask")[0].style.display ="none";
		$("#totherTask")[0].style.display ="";
		$("#customerone").show();
		}
		} 
		</script>
	</BODY>
</HTML>
