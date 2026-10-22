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
    
    <title>套餐详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">

  </head>
    <script type="text/javascript">
		function goUpdate(goUrl){
			window.location.href = goUrl;
		}
		function setMealPro(url)
		{
		　 　window.open(url);
		}
	</script>
  <body>
  	<FORM  id ="form1" name=form1 action="" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" 
				border=0 align="center" class="dt04">
    <TBODY>
      <TR>
        <TD class="dt05">套餐详情</TD>
      </TR>
      <TR>
        <TD><TABLE cellSpacing=0 cellPadding=0
								align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right>套餐编号： </TD>
                <TD width="25%" align="left">${data.id }</TD>
                <TD width="10%" height=30 align=right>套餐名称： </TD>
                <TD width="40%" align="left">${data.name }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>活动开始时间：</TD>
                <TD width="25%" align="left">${data.startTime }</TD>
                <TD align=right width="10%" height=30>活动结束时间：</TD>
                <TD width="40%" align="left">${data.endTime }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>套餐创建时间：</TD>
                <TD width="25%" align="left">${data.buildTime }</TD>
                <TD width="10%" align=right height=30>收费类型：</TD>
                <TD width="40%" align="left"><c:if test="${data.chargeMode == '0'}">免费</c:if>
                  <c:if test="${data.chargeMode == '1'}">赠送</c:if>
                  <c:if test="${data.chargeMode == '2'}">收费中预付</c:if>
                  <c:if test="${data.chargeMode == '3'}">后付</c:if></TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>原价：</TD>
                <TD width="25%" align="left">${data.totalPrice }</TD>
                <td width="10%" align=right height=30>实际价格：</td>
                <TD width="40%" align="left">${data.payPrice }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>套餐类型：</TD>
                <TD width="25%" align="left">${data.ordertype.name }</TD>
                <td width="10%" align=right height=30></td>
                <TD width="40%"></TD>
              </TR>
              <TR>
                <TD align=right height=30 >套餐描述：</TD>
                <TD colspan="3" align="left"><textarea style="width:450px; height:150px;"> ${data.describe }</textarea></TD>
              </TR>
              <tr>
                <td width="25%" align=right height=30>包含属性：</td>
                <TD width="25%" colspan="3" align="left">
                	<c:forEach items="${smProList }" var="smp"><a title="点击查看详细" onclick="setMealPro('goSetMealProAction.do?id=${smp.id }&type=info')"> ${smp.name }</a>&nbsp;&nbsp;&nbsp;&nbsp; </c:forEach>
                </TD>
              </tr>
              <TR>
                <TD height=50>&nbsp;</TD>
                <TD colspan="3" align="left"><INPUT class=button type="button" onClick="goUpdate('goUpdateSetMealAction.do?id=${data.id }');" value=" 修改 ">
                  <INPUT class=button type="button" onClick="history.go(-1);" value=" 返回  "></TD>
              </TR>
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
  </body>
</html>
