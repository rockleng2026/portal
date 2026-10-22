<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />

<title>详情-采购储备</title>
 <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	
	<base href="<%=basePath%>">
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
<title>出库详情</title>
<link href="<%=basePath%>potal/css/stylecrk.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="<%=basePath%>js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=basePath%>js/auditing.js" charset="GBK"></script>
</head>
<body>
<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
  <div class="bk" style="padding-bottom:20px;">
    <div class="bs">
      <div class="bs_t">您的位置：<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>入库列表详情</span></div>
      <div class="rk_cg"><dl>
        <dt>入库单号：</dt><dd>	${storageList.storageNo}</dd><dt>入库日期：</dt><dd>	${storageList.storageDate}</dd>
        <dt>仓库位置：</dt><dd>	${storageList.depot.name}</dd><dt>入库类型：</dt><dd>	${storageList.allType.typeName}</dd>
        <dt>经办人：</dt><dd>${storageList.employee.name}</dd><dt>入库总价：</dt><dd>${storageList.productPriceSum}</dd>
     
       <%-- <c:choose>

									<c:when test="${storageList.allType.typeName eq '新购入库'}">
							
										<!--循环-->
										<c:forEach items="${storageList.storageInfos}" var="data">
												<c:if test="${data.purorder.purOrderNo!=null}">
											 
											  <dt>采购单号：</dt><dd>${data.purorder.purOrderNo}</dd><dt>采购时间</dt><dd>${data.purorder.orderTime}</dd>
											  
											  </c:if>
										</c:forEach>
										<TR>
											<TD class=category colSpan=14 height=30>
											</TD>
										</tr>

									</c:when>
									
									<c:when test="${storageList.allType.typeName eq '客户商品入库'}" >

									
										<c:forEach items="${storageList.storageInfos}" var="data"  begin="0" end="1">

											<c:forEach items="${data.products}" var="product"  begin="0" end="1">
										
										
						
								  <dt>客户姓名：</dt><dd>${storageList.customer.customerName}</dd><dt>入库时间：</dt><dd>${storageList.storageDate}</dd>
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:otherwise>
								
										<c:forEach items="${storageList.storageInfos}" var="infodata">

											<c:forEach items="${infodata.products}" var="products">
						  <dt>入库仓库：</dt><dd>${storageList.depot.name}</dd><dt>入库时间：</dt><dd>${storageList.storageDate}</dd>
											</c:forEach>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								--%>
         <dt>   审核状态：</dt><dd><c:if test="${storageList.storageVerify==0||storageList.storageVerify==null}">
													未审核
													</c:if>
													<c:if test="${storageList.storageVerify==1 ||storageList.storageVerify==2}">
													已审核
													</c:if>
													<c:if test="${storageList.storageVerify==8}">
													审核进行中
													</c:if>
													<input type="hidden" id="orderNo" value="${storageList.storageNo}" />
											<input type="hidden" id="tab" value="Storage">
											<input type="hidden" id="filed" value="storageVerify">
											<input type="hidden" id="orderName" value="storageNo">
													</dd><c:if test="${quanxian=='quanxian'}"><dt>	审核操作:</dt><dd><c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${storageList.storageNo}','Storage','storageVerify','storageNo')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${storageList.storageId }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if></c:if></dd>
     
					
								
						
									
        
        <dt>备注：</dt><p class="rk_cgp">${storageList.storageRemark} </p>
      </dl></div>
      <div class="rk_cgtable">
        <div class="rk_cgtr_t">
          <div class="rk_cgtd_tq">行号</div>
          <div class="rk_cgtd_tw">产品名称</div>
          <div class="rk_cgtd_te">条形码</div>
          <div class="rk_cgtd_tr">产品型号</div>
          <div class="rk_cgtd_tt">所属类别</div>
          <div class="rk_cgtd_ty">数量</div>
          <div class="rk_cgtd_tu">单价</div>
        </div>
  <c:set value="0" var="a1"></c:set>
   <c:set value="0" var="a2"></c:set>
    <c:set value="0" var="a3"></c:set>
     <c:set value="0" var="a4"></c:set>
    <c:choose>

									<c:when test="${storageList.allType.typeName eq '新购入库'}">
							
										<!--循环-->
								<c:forEach items="${storageList.storageInfos}" var="data">

											<c:forEach items="${data.products}" var="product">
										
										
										   <div class="ck_vew_trd">
               				<c:set value="${a2+1}" var="a2"></c:set>
				<div class="ck_vew_tdd_q">${a2}</div>
                <div class="ck_vew_tdd_w">${product.property.name}</div>
                <div class="ck_vew_tdd_e">${product.barcode }</div>
                <div class="ck_vew_tdd_r">${product.property.model.name}</div>
                <div class="ck_vew_tdd_t">${product.property.model.commodityTpye.typeName}</div>
                <div class="ck_vew_tdd_y">1</div>
                <div class="ck_vew_tdd_u">${product.property.pprice}<em>(元)</em></div>
              </div>
												
											</c:forEach>
										</c:forEach>

									</c:when>
									<c:when test="${storageList.allType.typeName eq '其他入库'}">

									<c:forEach items="${storageList.storageInfos}" var="data">

											<c:forEach items="${data.products}" var="product">
										
										
										   <div class="ck_vew_trd">
               				<c:set value="${a2+1}" var="a2"></c:set>
				<div class="ck_vew_tdd_q">${a2}</div>
                <div class="ck_vew_tdd_w">${product.property.name}</div>
                <div class="ck_vew_tdd_e">${product.barcode }</div>
                <div class="ck_vew_tdd_r">${product.property.model.name}</div>
                <div class="ck_vew_tdd_t">${product.property.model.commodityTpye.typeName}</div>
                <div class="ck_vew_tdd_y">${product.property.unit}</div>
                <div class="ck_vew_tdd_u">${product.property.pprice}<em>(元)</em></div>
              </div>
												
											</c:forEach>
										</c:forEach>
									</c:when>
										<c:when test="${storageList.allType.typeName eq '返还入库'}">

									
										<c:forEach items="${storageList.storageInfos}" var="data">

											<c:forEach items="${data.products}" var="product">
										
										
										   <div class="ck_vew_trd">
               				<c:set value="${a2+1}" var="a2"></c:set>
				<div class="ck_vew_tdd_q">${a2}</div>
                <div class="ck_vew_tdd_w">${product.property.name}</div>
                <div class="ck_vew_tdd_e">${product.barcode }</div>
                <div class="ck_vew_tdd_r">${product.property.model.name}</div>
                <div class="ck_vew_tdd_t">${product.property.model.commodityTpye.typeName}</div>
                <div class="ck_vew_tdd_y">${product.property.unit}</div>
                <div class="ck_vew_tdd_u">${product.property.pprice}<em>(元)</em></div>
              </div>
												
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:when test="${storageList.allType.typeName eq '客户商品入库'}">

									
										<c:forEach items="${storageList.storageInfos}" var="data">

											<c:forEach items="${data.products}" var="product">
										
											
										
           				<c:set value="${a3+1}" var="a3"></c:set>
				<div class="ck_vew_tdd_q">${a3}</div>
             	   		<div class="ck_vew_tdd_w">${product.property.name}</div>
               		 <div class="ck_vew_tdd_e">${product.barcode }</div>
               		 <div class="ck_vew_tdd_r">${product.property.model.name}</div>
                		<div class="ck_vew_tdd_t">${product.property.model.commodityTpye.typeName}</div>
            	  	 <div class="ck_vew_tdd_y">1</div>
                	<div class="ck_vew_tdd_u">${product.property.pprice}<em>(元)</em></div>
          
								
											</c:forEach>
										</c:forEach>
									</c:when>
									<c:otherwise>
								
										<c:forEach items="${storageList.storageInfos}" var="infodata">

											<c:forEach items="${infodata.products}" var="products">

											<c:set value="${a4+1}" var="a4"></c:set>
				<div class="ck_vew_tdd_q">${a4}</div>
             	   		<div class="ck_vew_tdd_w">${product.property.name}</div>
               		 <div class="ck_vew_tdd_e">${product.barcode }</div>
               		 <div class="ck_vew_tdd_r">${product.property.model.name}</div>
                		<div class="ck_vew_tdd_t">${product.property.model.commodityTpye.typeName}</div>
            	  	 <div class="ck_vew_tdd_y">1</div>
                	<div class="ck_vew_tdd_u">${product.property.pprice}<em>(元)</em></div>
											</c:forEach>
										</c:forEach>
									</c:otherwise>
								</c:choose>
      </div>
     	
     
           
    </div>
  </div>
</body>
</html>
