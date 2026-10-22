<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单套餐列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
  </head>
   <script language="javascript">
   		function del(id, endurl){
   			var date=new Date();
   			var url="delSetMealAction.do?date="+date;
			if(confirm("你确定你要删除该数据吗？")){
				$.post(url,{
					id:id
				},function(data){
					if(data==0){
						alert("删除成功！")
						window.location.href=endurl;
					}else{
						alert("删除失败！");
					}
				}
				);
			}
   		}
   </script>
  <body>
  	<FORM name=form2 action="goListSetMealAction.do" method="post">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" align=center border=0 class="dt04">
    <TBODY>
      <TR>
        <TD align=right height="35"> 套餐名：
          <INPUT type="text" id="mealName" name="mealName"/>
          <INPUT class=button type=submit  value=" 查询 "/>
          &nbsp;<a href="goAddSetMealAction.do">新增套餐</a> </TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
<TABLE cellSpacing=0 cellPadding=0 width="1000" border=0 align="center" class="dt04">
  <TBODY>
    <TR>
      <TD class="dt05">套餐列表
        <input type="hidden" id="selecttage" value="0"></TD>
    </TR>
    <TR>
      <TD><form action="" id="form1" name="form1" method="post">
          <TABLE cellSpacing=0 cellPadding=0 align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR align="center">
                <TD id="tid" width="8%" height="30" > 套餐编号 </TD>
                <TD id="tname" width="8%" > 套餐名 </TD>
                <TD id="trealmtypename" width="10%" > 套餐类型 </TD>
                <TD id="tstarttime" width="10%" > 活动开始时间 </TD>
                <TD id="tendtime" width="10%" align="center" > 活动结束时间 </TD>
                <TD id="tusetime" width="10%" align="center" > 套餐创建时间 </TD>
                <TD id="tchargeType" width="10%" align="center" > 收费类型 </TD>
                <TD id="tprice" width="5%" align="center" > 原价 </TD>
                <TD id="tpayprice" width="5%" align="center" > 实际价格 </TD>
                <TD width="7%" align="center" > 审核状态 </TD>
                <TD width="5%" align="center"> 修改 </TD>
                <TD width="5%" align="center"> 删除 </TD>
                <TD width="10%" align="center"> 查看详细 </TD>
              </TR>
            </TBODY>
          </TABLE>
        </form>
        <table id="infotable" class="toptable grid" cellSpacing=0 cellPadding=0 align=center border=0>
          <tbody>
            <!--循环-->
            <c:if test="${empty pages.pageList}"><tr><td align="center">无套餐</td></tr></c:if>
            <c:if test="${!empty pages.pageList}">
			<c:forEach items="${pages.pageList}" var="data" >
            <TR align="center">
              <TD width="8%" height="50"> ${data.id } </TD>
              <TD width="8%" ><a href="goInfoCDNSetMealAction.do?id=${data.id }" target=right> ${data.name }</a></TD>
              <TD width="10%" >${data.ordertype.name }</TD>
              <TD width="10%"> ${data.startTime } </TD>
              <TD width="10%" align="center" > ${data.endTime } </TD>
              <TD width="10%" align="center" > ${data.buildTime } </TD>
              <TD width="10%" align="center"><!-- 此处判断-->
                <c:if test="${data.chargeMode == '0'}">免费</c:if>
                <c:if test="${data.chargeMode == '1'}">赠送</c:if>
                <c:if test="${data.chargeMode == '2'}">预付</c:if>
                <c:if test="${data.chargeMode == '3'}">后付</c:if>
              </TD>
              <TD width="5%" align="center" > ${data.payPrice } </TD>
              <TD width="5%" align="center"> ${data.totalPrice } </TD>
              <TD width="7%" align="center"><!-- 此处判断-->
                <c:if test="${data.auditState == 0}">未审</c:if>
                <c:if test="${data.auditState == 1}">审核同意</c:if>
                <c:if test="${data.auditState == 2}">审核拒绝</c:if>
                <c:if test="${data.auditState == 3}">已上架</c:if>
                <c:if test="${data.auditState == 8}">接收</c:if>
              </TD>
              <TD width="5%" align="center"><A title="修改" href="goUpdateSetMealAction.do?id=${data.id }" target=right> 修改 </a></TD>
              <TD width="5%" align=center><a title="删除" href="javascript:void();" onclick="return del(${data.id },'goListSetMealAction.do');">删除</a></TD>
              <TD width="10%" align=center><a title="查看详细" href="goInfoSetMealAction.do?id=${data.id }" target=right> 查看详情</a></TD>
            </TR>
            </c:forEach>
            </c:if>
            <!--循环结束-->
          </TBODY>
        </TABLE>
        <!--endprint-->
       </TD>
    </TR>
    <TR>
      <!--分页标签 毋须修改-->
      <TD id="page" height="50"><p:pages url="goListSetMealAction.do"/></TD>
    </TR>
  </TBODY>
</TABLE>
  </body>
</html>
