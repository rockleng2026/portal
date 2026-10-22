<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>查看/修改详细单据</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Css/style_s.css">
	<script type="text/javascript" src="js/juqery/lib/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/juqery/lib/jquery.form.js"></script>
	<script type="text/javascript" src="js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="js/auditing.js" charset="GBK"></script>
	<script type="text/javascript">
	function ComPang()
	 {
		var temp="";
		for(var i=1;;i++)
		{
			var ss=document.getElementById("temp"+i).value;
			
			if(ss!=null)
			{
				temp+=ss+"#";
				document.getElementById("temp").value=temp;
			}
			else {
				document.getElementById("temp").value=temp;
				break;
			}
		}
	 }
	</script>
  </head>
<body>
	<div class="con" >
		<div class="righter">
			<div class="line" style="width:90.5%;">
				<font >审核流程：</font>　　　　
					<c:forEach items="${auditingList}" var="adata">
					   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name} >>></font></c:if>
					   <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name} >>></font></c:if>
					   <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name} >>></font></c:if>
					 </c:forEach>
			</div>	
			<!-- 查看 -->
			<c:if test="${showmark=='chakan'}">
				<div class="main_leirong_title" style="width:90.5%;">单据详细信息</div>
				<div class="line" style=" margin-left: 100px; float: left; margin-top: 10px;">
					创建单据时间：${formdetail.time }<br>单据编号：${formdetail.orderNo }
					${formdetail.formtemp.code }
					
					<input type="hidden" id="orderNo" value="${formdetail.orderNo}" />
					<input type="hidden" id="tab" value="FormDetail">
					<input type="hidden" id="filed" value="audtitingFlag">
					<input type="hidden" id="orderName" value="orderNo">
				</div>
				<div class="line" style=" margin-left: 100px; float: left; margin-top: 50px;">
				<!-- 审核流程操作 -->
				   <div>
				   		审核状态：
				   		<c:if test="${formdetail.audtitingFlag==0}">未审</c:if>
						<c:if test="${formdetail.audtitingFlag==1}">审核已通过</c:if>
						<c:if test="${formdetail.audtitingFlag==2}">审核未通过</c:if>
						<c:if test="${formdetail.audtitingFlag==8}">正在审核中</c:if>
				   </div>
				   <c:if test="${quanxian=='quanxian'}">
				   <div>
						<c:if test="${mark=='mark'}">
							<input type="button" value="接收" onClick="incepttime('${formdetail.orderNo}','FormDetail','audtitingFlag','orderNo')"/>
						</c:if>
						<c:if test="${mark != 'mark'}">
						   <c:if test="${flage==0||flage==null}">
						   		<input type="button" value="审核" onclick="completemission('${formdetail.id }',2)">
						   </c:if>
						   <c:if  test="${flage==1 ||flage==2}">
						   		您已经审核过该单据 审核时间：${aot.auditingtime}
						   		<br>审核结果：
						   		<c:if test="${aot.auditingFlag==1}">通过</c:if>
						   		<c:if test="${aot.auditingFlag==2}">未通过</c:if>
						   		<br>审核意见：${aot.tmp }
						   </c:if>
					   </c:if>
					</div>
					</c:if>
				</div>
			</c:if>
			
			<!-- 修改 -->
			<c:if test="${showmark=='xiugai'}">
				<div class="main_leirong_title" style="width:90.5%;">修改单据详细信息</div>
				<div class="line" style=" margin-left: 100px; float: left; margin-top: 50px;">
				创建单据时间：${formdetail.time }
					<form action="editupdateFormDetailAction.do" method="post">
						<input type="hidden" id="id" name="id" value="${formdetail.id }" />
						<input type="hidden" id="delflag" name="delflag" value="${formdetail.delflag }" />
						<input type="hidden" id="audtitingFlag" name="audtitingFlag" value="${formdetail.audtitingFlag }" />
						<input type="hidden" id="time" name="time" value="${formdetail.time }" />
						<input type="hidden" id="formtempid" name="formtempid" value="${formdetail.formtemp.id }"/>
						<input type="hidden" id="employeeid" name="employeeid" value="${formdetail.employee.id }"/>
						<input type="hidden" id="orderNo" name="orderNo" value="${formdetail.orderNo }"/>
					     ${formdetail.formtemp.code }
					    <div style="float:left; margin-left: 88px; clear:both;">
					    <br><br>
					   	 	<input type="hidden" id="temp" name="temp" value="" />
					    	<input type="submit" value="修改详细信息"  onclick="return ComPang()">&nbsp;&nbsp;&nbsp;&nbsp;
					    	<input type="reset" value="重置"/>
					    </div>
					</form>
				</div>
			</c:if>
		</div>
		<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</div>
	
</body>
</html>
