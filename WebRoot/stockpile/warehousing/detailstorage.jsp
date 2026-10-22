<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
%>

<html>
	<head>

		<title>新购入库</title>
		
		<jsp:include page="/common/inc_css.jsp" flush="true"></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true"></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true"></jsp:include>
		<script language="javascript">
		function onsumbits()
		{
			var storageNo = $("#storageNo").val(); 
			var dep = encodeURI($("#dep").val(),"utf-8");
			var storageType = $("#storageType").val();
			alert(storageType);
			var emp = encodeURI($("#emp").val(),"utf-8");
			var cus = $("#cus").val();
			var storagetime = $("#storagetime").val();
			var sum = $("#sum").val();
			var remark = encodeURI($("#remark").val(),"utf-8");
			var KCdang = $("#KCdang").val();
			var all=document.getElementsByName('toorders');
			var allId=new Array();
			var j=0;
			for(var i=0;i<all.length;i++){
				allId[j]=all[i].value;
				j++;
			}	
			$.ajax({
				 type:"POST",
				 url:"newSigWarehousing.do?toOrderid="+allId,
				 data:{
					"storageNo":storageNo,
					"dep":dep,
					"storageType":storageType,
					"emp":emp,
					"cus":cus,
					"storagetime":storagetime,
					"sum":sum,
					"remark":remark,
					"KCdang":KCdang
				 },
				 success:function(data)
				 {
					if(data == "1")
					{
						var falg = window.confirm("入库成功，是否导出条形码..");
						if(falg==true)
						{
							parent.location.href = "showdoloadWarehousing.do";
						}
						else
						{
							parent.location.href = "warehousingInfoWarehousing.do";
						}
					}
					if(data == "2")
					{
						alert("入库失败,请于管理员联系..");
					}
				}
				});
		}
	
		</script>
	</head>
	<body>
					
			<div id="resulthight">
				<input type="hidden" id="storageNo" name="storageNo" value="${storageNo}"/>
					<input type="hidden" id="dep" name="dep" value="${dep}"/>
					<input type="hidden" id="storageType" name="storageType" value="${storageType}"/>
					<input type="hidden" id="emp" name="emp" value="${emp }"/>
					<input type="hidden" id="storagetime" name="storagetime" value="${storagetime}"/>
					<input type="hidden" id="sum" name="sum" value="${sum }"/>
					<input type="hidden" id="remark" name="remark" value="${remark}"/>
					<input type="hidden" id="KCdang" name="KCdang" value="${KCdang}"/>
					<% int count=1; %>
				<c:forEach items="${maporder}" var="toorder">
				<div style="text-align: left;font-size: 14px;">到货单<%=count %></div>
				<%
					count++;
				%>
				
				<table style="width: 100%;height: 100%" border="1" align="center" cellspacing="0"　class="tableStyle"  cellpadding="0" id="youshuju" >
	  			  <tr>
	  			   <th align="left">条形码：</th>
		       		<td>
					${toorder.key}
			   </td>
			   </tr>
			   <c:forEach items="${toorder.value}" var="ordervalue">
			   <input type="hidden"  name="toorders" value="${ordervalue.id}b${toorder.key}"/>
			   <tr>
		       <th align="left">到货单ID：</th>
			       <td>
						${ordervalue.toOrderNum}
				   </td>
				   <th align="left">批次ID：</th>
			       <td>
						${ordervalue.piciNo}
				   </td>
				</tr>
				<tr>
				   <th align="left">到货日期：</th>
			       <td>
						${ordervalue.totime}
				   </td>
				    <th align="left">到货日期：</th>
			       <td>
						${ordervalue.totime}
				   </td>
				    <th align="left">采购类型：</th>
			       <td>
						${ordervalue.buytype}
				   </td>
				  </tr><tr>
				   <th align="left">交货人：</th>
			       <td>
						${ordervalue.deliveryer}
				   </td>
				   <th align="left">交货方式：</th>
			       <td>
						${ordervalue.deliverytType}
				   </td>
				   <th align="left">交货地址：</th>
			       <td>
						${ordervalue.deliveryaddress}
				   </td>
				  </tr><tr>
				   <th align="left">联系电话：</th>
			       <td>
						${ordervalue.phone}
				   </td>
				   <th align="left">审批：</th>
			       <td>
						<c:if test="${ordervalue.toOrderVerify ==1}">
							已审批
						</c:if>
						<c:if test="${ordervalue.toOrderVerify ==8}">
							进行中
						</c:if>
						<c:if test="${ordervalue.toOrderVerify ==0}">
							未审批
						</c:if>
				   </td>
				   
				     </tr>
			   </c:forEach>
			
				</table>
				</c:forEach>
				<center><input type="button" onclick="onsumbits();" value="添加"/> <input type="button" onclick="closeWindeows(0)" value="取消"/> <input type="button" onclick="javascript:window.print();" value="打印"/> </center>
			</div>
	</body>
</html>
