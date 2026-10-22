<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.util.Pages"%>
<%@page import="com.fuao.fajxc.vo.NewFunction"%>
<%@page import="com.fuao.fajxc.dao.newproject.TaskProject"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>打印条形码</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<style type="text/css">
	     .zjstyle{
	         border:1px solid blue;
	         background-color: white;
	     }
	</style>
	<script type="text/javascript">
		function btnstor()
		{
			window.location.href = "warehousingInfoWarehousing.do";
		}
	</script>
	
  </head>
  
<body onload="setdivwidth();">
	<center><b>商品条形码</b></center>
	<form action="doloadWarehousing.do" method="post">
	<div id="resulthight">
    	<table style="width:100%; text-align: center;" border="1" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
    		<tr>
    			<td colspan="8"><input type="button" onclick="javascript:btnstor();"  value="入库单"/>&nbsp;&nbsp;&nbsp;<input type="submit"  value="打印"/></td>
    		</tr>
			<tr>
			 <th>条形码</th>
			 <th>商品名称</th>
			 <th>商品类型名称</th>
			 <th>入库时间</th>
			 <th>入库类型</th>
			 <th>使用状态</th>
			 <th>仓库 </th>
			 <th>执行人</th>
			</tr>
			<c:if test="${purOrderInfos != null}">
				<c:forEach items="${purOrderInfos}" var="pro">
					<tr>
						<td>${pro.barcode}</td>
						<td>${pro.property.name}</td>
						<td>${pro.property.model.name}</td>
						<td>${pro.property.time}</td>
						<td>${pro.storageInfo.storage.allType.typeName}</td>
						<td>
							<c:if test="${pro.usestate == 1}">
								使用
							</c:if>
							<c:if test="${pro.usestate == 2}">
								未使用
							</c:if>
							<c:if test="${pro.usestate == 3}">
								以实际出库
							</c:if>
							<c:if test="${pro.usestate == 4}">
								上架
							</c:if>
						</td>
						<td>${pro.depot.name}</td>
						<td>${pro.storageInfo.storage.employee.name }</td>
					</tr>
				</c:forEach>
				<tr><td colspan="8"><input type="button" onclick="javascript:btnstor();"  value="入库单"/>&nbsp;&nbsp;&nbsp;<input type="submit"  value="打印"/></td></tr>
			</c:if>
			<c:if test="${purOrderInfos == null}">
				<tr>
					<td colspan="8">查无数据</td>
				</tr>
			</c:if>
		</table>
	</div></form>
	</body>
</html>
