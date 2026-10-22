	<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Customer" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
  <div class="bk" style="height:506px;">
    <div class="bs">
      <div class="bs_t">您的位置：<a href="#">个人办公></a><a href="#">进销存管理></a><a href="#">出入库></a><span>出库列表详情</span></div>
      <div class="bsy">
         <div class="ck_vew_t">
            <dl>
              <dt>出库单号：</dt><dd>${outList.outboundNo}</dd><dt>出库时间：</dt><dd>${outList.time}</dd>
               <dt>仓库位置：</dt><dd>${outList.depot.name}</dd><dt>出库类型：</dt><dd>${outList.allType.typeName}</dd>
                <dt>产品数量：</dt><dd>74565645</dd><dt>产品总价：</dt><dd>8475767</dd>
                 <dt>经办人：</dt><dd>${outList.employee.name}</dd><dt>审核操作：</dt><dd><input type="hidden" id="orderNo" value="${outList.outboundNo}" />
											<input type="hidden" id="tab" value="Outbound">
											<input type="hidden" id="filed" value="auditingState">
											<input type="hidden" id="orderName" value="outboundNo">
    	<c:if test="${quanxian=='quanxian'}">
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${outList.outboundNo}','Outbound','auditingState','outboundNo')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${outList.id }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if>
									</c:if></dd>
                  <dt>出库备注：</dt><p class="ck_bz">${outList.remark}</p>
            </dl>
         </div>
         <div class="ck_vew_d">
            <div class="ck_vew_trt">
               <div class="ck_vew_tdt_q">序列号</div>
               <div class="ck_vew_tdt_w">产品名称</div>
               <div class="ck_vew_tdt_e">产品编码</div>
               <div class="ck_vew_tdt_r">产品型号</div>
               <div class="ck_vew_tdt_t">所属类别</div>
               <div class="ck_vew_tdt_y">商品单位</div>
               <div class="ck_vew_tdt_u">单价</div>
            </div>
            <c:set value="0"  var="num"></c:set>
            	<c:forEach items="${outList.outboundInfos}" var="data" >
            	 <c:set value="${num+1}"  var="num"></c:set>
            <div class="ck_vew_tabled">
              <div class="ck_vew_trd">
                <div class="ck_vew_tdd_q">${num }</div>
                <div class="ck_vew_tdd_w">${data.product.property.name }</div>
                <div class="ck_vew_tdd_e">${data.product.barcode }</div>
                <div class="ck_vew_tdd_r">${data.product.property.model.name}</div>
                <div class="ck_vew_tdd_t">${data.product.property.model.commodityTpye.typeName}</div>
                <div class="ck_vew_tdd_y">${data.product.property.unit}</div>
                <div class="ck_vew_tdd_u">${data.product.property.pprice}<em>(元)</em></div>
              </div>
              </c:forEach>
      
            </div>
             <div>
             
            
         </div>       
      </div>     

									
  </div>
</body>
</html>
