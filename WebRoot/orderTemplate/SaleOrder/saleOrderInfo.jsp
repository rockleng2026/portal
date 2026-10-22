<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
  <script type="text/javascript">
   function add()
   {  
      
       $("#jtip").click(function (){
         var h=0, l=0, w=0, obj = this;
        while(obj != null)
     {
     h += obj.offsetTop -10;
     l += obj.offsetLeft -15;
     obj = obj.offsetParent;
    }

     w = $(this).width();

    $("#alerts").css({'top':h+'px','left':(l+w)+'px'});
     $("#alerts").show();
       
       });
   }
   function orderInfo(id)
   {
      window.open ('<%=request.getContextPath() %>/selecttaocanorderAction.do?type=info&id='+id)
   }
  </script>
  </head>
  
  <body>
<FORM  id ="form1" name=form1 action="" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" 
				border=0 align="center" class="dt04">
    <TBODY>
    <tr>
    	<td>
    		<font >审核流程：</font><br />　　　　　
					<c:forEach items="${auditingList}" var="adata">
									   <c:if test="${adata.auditingFlag==0}"><font >${adata.department.name}>>></font></c:if>
									    <c:if test="${adata.auditingFlag==1}"><font color="red">${adata.department.name}>>></font></c:if>
									     <c:if test="${adata.auditingFlag==2}"><font color="red">${adata.department.name}>>></font></c:if>
					 </c:forEach>
    	</td>
    </tr>
      <TR>
        <TD class="dt05">订单详细信息</TD>
      </TR>
      <TR>
        <TD><TABLE cellSpacing=0 cellPadding=0
								align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right>订单编号： </TD>
                <TD width="25%" align="left">${SaleorderComm.orderNo}</TD>
                <TD width="10%" height=30 align=right>销售人员： </TD>
                <TD width="40%" align="left"><FONT color=#ff0000>&nbsp;&nbsp;部门：${employee.department.name}    员工：${employee.name}</FONT></TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>客户名字：</TD>
                <TD width="25%" align="left">${customer.customerName}</TD>
                <TD align=right width="10%" height=30>套餐名称：</TD>
                <TD width="40%" align="left">${SaleorderComm.setmealComm.name}</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>付费类型：</TD>
                <TD width="25%" align="left">
                <c:if test="${SaleorderComm.payStyle ==1}">月付</c:if>
               <c:if test="${SaleorderComm.payStyle ==2}">季付</c:if>
              <c:if test="${SaleorderComm.payStyle ==3}">半年付</c:if>
             <c:if test="${SaleorderComm.payStyle ==4}">一年付</c:if>
             <c:if test="${SaleorderComm.payStyle ==5}">一次付</c:if>
                </TD>
                <TD width="10%" align=right height=30>价格：</TD>
                <TD width="40%" align="left">${SaleorderComm.price}</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>是否折扣：</TD>
                <TD width="25%" align="left">
                  <c:if test="${SaleorderComm.isDiscount==1}">否</c:if>
                  <c:if test="${SaleorderComm.isDiscount==2}">是</c:if>
                <td width="10%" align=right height=30>折扣描述：</td>
                <TD width="40%" align="left">${SaleorderComm.discountDescribe}</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>审核状态：</TD>
                <TD width="25%" align="left">
                  <c:if test="${SaleorderComm.auditState ==0}">未审</c:if>
                  <c:if test="${SaleorderComm.auditState ==1}">审核同意</c:if>
                 <c:if test="${SaleorderComm.auditState ==2}">审核拒绝</c:if>
                 <c:if test="${SaleorderComm.auditState==8}">接收</c:if>
                </TD>
                <td width="15%" align=right height=30>销售订单录入人员：</td>
                <TD width="35%">${SaleorderComm.inputAdmin}</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>订单续费开始时间：</TD>
                <TD width="20%" align="left">${SaleorderComm.startTime}</TD>
                <td width="10%" align=right height=30>订单下次续费时间：</td>
                <TD width="40%">${SaleorderComm.payNexttime}</TD>
              </TR>
              <TR>
                <TD align=right height=30 >订单描述：</TD>
                <TD colspan="3" align="left"><textarea style="width:500px; height:170px;">${SaleorderComm.describtion}</textarea></TD>
              </TR>
              
                            
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
  	<table   width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                     <td width="5%" align="center">
                        	
                        </td>
                    	<td width="15%" align="center" height="30">
                        	套餐名称
                        </td>
                        <td width="10%" align="center">
                        	活动开始时间
                        </td>
                        <td width="10%" align="center">
                        	活动结束时间
                        </td>
                        <td width="30%" align="center">
                        	套餐描述
                        </td>
                        <td width="10%" align="center">
                        	使用时长
                        </td>
                        <td width="10%" align="center">
                        	原价
                        </td>
                        <td width="10%" align="center">
                        	实际价格
                        </td>
                      
                    </tr>
                    <tr>
                      <td width="5%" align="center">
                        	
                        </td>
                    	<td width="15%" align="center" height="30">
                        	<a href="javascript:void(0)"  onclick="orderInfo(${setmealComm.id})">${setmealComm.name }</a>
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.startTime }
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.endTime }
                        </td>
                        <td width="30%" align="center">
                        	${setmealComm.describe }<a href="javascript:void(0)" id="jtip" onclick="add()">详细信息</a>
								<div id="alerts" style="position: absolute; z-index: 2; width: 400px; height: 100px; background-color: #fff; border: 1px dashed #0166d4; display: none">
									
									
									<div align="right">
									<span onclick=document.getElementById("alerts").style.display="none"
										style="color: #993333; font-weight: bold">关闭</span>
									</div>
									${setmealComm.describe }
								</div>

							</td>
                        <td width="10%" align="center">
                        	1年
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.totalPrice }
                        </td>
                        <td width="10%" align="center">
                        	${setmealComm.payPrice }
                        </td>
                      
                    <tr>
                </table>
                <table>
                	<c:if test="${quanxian=='quanxian'}">
									<TR>
										<TD height=30 >
											审核操作:
											<input type="hidden" id="orderNo" value="${SaleorderComm.orderNo}" />
											<input type="hidden" id="tab" value="SaleorderComm">
											<input type="hidden" id="filed" value="auditState">
											<input type="hidden" id="orderName" value="orderNo">
											<input type="hidden" id="price" value="price"/>  <!-- 存储价格字段 -->
										</TD>
										<TD class=category >
										<c:if test="${mark=='mark'}">
											<input type="button" value="接收" onClick="incepttime('${SaleorderComm.orderNo}','SaleorderComm','auditState','orderNo')"/>
											  </c:if>
											<c:if test="${mark != 'mark'}">
									  <c:if test="${flage==0||flage==null}"><input type="button" value="审核" onclick="completemission('${data.id }',2)"></c:if>
									   <c:if  test="${flage==1 ||flage==2}">您已经审核过该单据 审核时间：${aot.auditingtime}--审核状态：<c:if test="${aot.auditingFlag==1}">通过</c:if>
									   <c:if test="${aot.auditingFlag==2}">未通过</c:if>--审核意见：${aot.tmp }
									   </c:if>
									   </c:if>
									 
										<br></TD>

									</TR>
									</c:if>
                </table>
                <jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
</FORM>
</body>
</html>
