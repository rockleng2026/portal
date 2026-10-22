<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

	  <p style="height: 30;background: #7BACCD">订单详情${orderid1}</p>
				  	<c:forEach items="${list1}" var="list1">
				  	<c:if test="${list1.soId==orderid1}">
				  <table border="1"  cellpadding="0" cellspacing="0" style="" bordercolor="#787878" align="center" height="250" width="480">
				<tr align="center">
				<td  width="25%">订单编号</td>
				<td width="25%">&nbsp;${list1.soNums}</td>
				<c:forEach items="${list2}" var="list2">
				<c:if test="${list2.sale_orders.soId==list1.soId}">
				<Td rowspan="3" colspan="2" width="50%"><img src="${list2.sale_goods.sgImg}"/></Td>
				</tr>
				<tr align="center">
				<td>商品编码</td>
				<td>&nbsp;${list2.sale_goods.sgcode}</td>
				
				</tr>
				  
				  <tr align="center">
				<td>商品价格</td>
				<td>${list2.sale_goods.sgPrice}</td>
			
				</tr>
				  
				  <tr align="center">
				<td>商品名称</td>
				<td>${list2.sale_goods.sgname}&nbsp;</td>
				<Td>端口号码</Td>
				<Td>&nbsp;</Td>
				</tr>
				  
				  <tr align="center">
				<td width="25%">使用状态</td>
				<td width="25%">&nbsp;</td>
				<Td width="25%">录入人员</Td>
				<Td width="25%">${list2.sale_goods.sgUsername}</Td>
				</tr>
				  
				  <tr align="center"> 
				<td width="25%">录入时间</td>
				<td>${list2.sale_goods.sgtime}&nbsp;</td>
				<Td>发布时间</Td>
				<Td>${list2.sale_goods.sgPuttime}&nbsp;</Td>
				</tr>
				 </c:if>
				   </c:forEach> 
				
				  
				
		
				  
				  </Td>
				  </Tr>
				  <tr> 
				  
   </tr>
   <input type="hidden" id="orderNo" value="${list1.soNums}" />
											<input type="hidden" id="tab" value="Sale_orders">
											<input type="hidden" id="filed" value="soStat">
											<input type="hidden" id="orderName" value="soNums">
    <td align="center">审核状态：</td> <TD class=category colspan="3" id="shenhe">
										<c:if test="${mark=='mark'}"><!-- 编号值      表名，  是否审核，编号字段 -->
											<input type="button" value="接收" onClick="incepttime('${list1.soNums}','Sale_orders','soStat','soNums')"/>
											  </c:if>
										<c:if test="${mark == 'no' && mark!='mark'}">
										  	<c:if test="${flage==0 }">
												<input type="button" value="审核"  onclick="completemission('${list1.soId}',2)">
											</c:if>
											<c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
											   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
										   </c:if>
									   </c:if>
										<br>
                     
										</TD>
				</c:if>
				
				      
				  
				  
				  </c:forEach>
				 
  
				  
				  </table>
							<input type="button" style="margin-left: 300" onclick="closeWindow()" value="关闭"/>
			
			</html>	