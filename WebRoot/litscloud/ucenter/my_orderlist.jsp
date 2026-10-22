<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_id">
                       <div class="bg_idt">
                         <div class="bg_idtl">宝贝</div>
                         <div class="bg_idtw">单位（元）</div>
                         <div class="bg_idte">数量</div>
                         <div class="bg_idtr">售后</div>
                         <div class="bg_idtt">实付款</div>
                         <div class="bg_idty">交易状态</div>
                         <div class="bg_idtu">交易操作</div>
                       </div>
                        <div >
                         <div class="bg_idtl">&nbsp;</div>
                         <div class="bg_idtw">&nbsp;&nbsp;</div>
                         <div class="bg_idte">&nbsp;</div>
                         <div class="bg_idtr">&nbsp;</div>
                         <div class="bg_idtt"><a href="javascript:topage(${pageNo-1},${gageNoall} }) ">上一页</a></div>
                         <div class="bg_idty"><a href="javascript:topage(${pageNo+1},${gageNoall}) ">下一页</a></div>
                         <div class="bg_idtu"></div>
                       </div>
                       <c:forEach items="${solist3 }" var="solist">
                       <div class="bg_idc">
                         <div class="bg_idc_t"><input name="check1" type="checkbox" value="选择" style="margin-left:5px; margin-top:5PX; float:left;" />&nbsp;&nbsp;订单编号：&nbsp;&nbsp;  ${solist.soNums } &nbsp;&nbsp;   订单生成时间：${solist.soOrderTime } &nbsp;&nbsp; </div>
                       </div>	
                       <c:forEach items="${list1 }" var="list1">
						<c:if test="${list1.sale_orders.soId eq solist.soId}">
                         
                         <DIV class="bg_idc_D">
                            <DIV class="bg_idc_Dl">
                            	<c:if test="${list1.sale_goods.sgThumb == null || list1.sale_goods.sgThumb == '' }"><img src="litscloud/images/bg_29.png" /></c:if>
                            	<c:if test="${list1.sale_goods.sgThumb != null && list1.sale_goods.sgThumb != '' }"><img src="${fn:split(list1.sale_goods.sgThumb,'|')[0]}" width="76" height="76"/></c:if>
                            		
                            </DIV>
                            <DIV class="bg_idc_Dq">
                              <DIV class="bg_idc_Dqt"><a href="javascript:void(0);" title="绿色保障服务"><img src="litscloud/images/bg_30.png" /></a></DIV>
                              <DIV class="bg_idc_Dqd">商品名称:<a href="litscloud/web/detailOfGoods2CustomerServerC.Action?sgcode='${list1.sale_goods.sgcode }'" target="_blank" title="${list1.sale_goods.sgname }">
                              <c:choose> 
							     <c:when test="${fn:length(list1.sale_goods.sgname) > 13}"> 
							      <c:out value="${fn:substring(list1.sale_goods.sgname, 0, 13)}..." /> 
							     </c:when> 
							     <c:otherwise> 
							      <c:out value="${list1.sale_goods.sgname}" /> 
							     </c:otherwise>
							   </c:choose>
                              </a><br />
                              	商品编号:${list1.sale_goods.sgcode}<br />
								商品规格:<c:if test="${list1.sale_orders.spec == null || list1.sale_orders.spec == ''}">暂无</c:if>
								<c:if test="${list1.sale_orders.spec != null && list1.sale_orders.spec != ''}">${list1.sale_orders.spec }</c:if>
								</DIV>
                            </DIV>
                           <DIV class="bg_idc_Dw">￥${list1.sale_orders.sgPrice}</DIV>
                            <DIV class="bg_idc_De">${list1.soOrderNumber }(${list1.sale_goods.sgUnit })</DIV>
                            <DIV class="bg_idc_De">
<a href="javascript:void(0);" title="暂未开放">评 价</a></DIV>
                            <div class="bg_idc_Dy"> ￥${list1.sale_orders.prices} <br /></div>
                            <div class="bg_idc_Dy"><p></p><a href="javascript:xiangqing('${solist.soNums }')">订单详情</a><br />
                            	<c:if test="${solist.soStat==0 }"><font size="-1">待审核</font></c:if>
					<c:if test="${solist.soStat==null || solist.soStat=='' }"><font size="-1">待接收</font></c:if>
					<c:if test="${solist.soStat==1 }"><font size="-1">已审核待付款</font></c:if>
					<c:if test="${solist.soStat==2 }"><font size="-1">待付款审核</font></c:if>
					<c:if test="${solist.soStat==3 }"><font size="-1">待生成上架单</font></c:if>
					<c:if test="${solist.soStat==4 }"><font size="-1">待调拨往客服</font></c:if>
					<c:if test="${solist.soStat==5 }"><font size="-1">待客服接收</font></c:if>
					<c:if test="${solist.soStat==6 }"><font size="-1">待客服转运维</font></c:if>
					<c:if test="${solist.soStat==7 }"><font size="-1">待运维接收</font></c:if>
					<c:if test="${solist.soStat==8 }"><font size="-1">待运维上架</font></c:if>
						<c:if test="${solist.soStat==9 }"><font size="-1">待客服确认</font></c:if>
						<c:if test="${solist.soStat==10 }"><font size="-1">订单成功 <a href="javascript:void(0);">待评价</a></font></c:if>
						<c:if test="${solist.soStat==12 }"><font size="-1">订单成功 <a href="javascript:void(0);">已评价</a></font></c:if>
						<c:if test="${solist.soStat==11 }"><font size="-1">上架单待审核</font></c:if></div>
                            <div class="bg_idc_Du"><a href="<%=path %>/pdm/getprocessproductManager.Action?sgnum=${solist.soNums }">订单流程</a>	
                            <c:if test="${solist.soStat==1 }"><a href="litscloud/tpl/bg_paymoney.jsp?sgnum=${solist.soNums }&price=${list1.sale_goods.sgPrice}">去付款</a></c:if></div>
                         </DIV>
					   </c:if>
						</c:forEach>
                     </c:forEach>
                    </div>               
                </div>  
             </div>
             <div class="bg_dd"></div>
          </div>      
      </div>  
    
</div>