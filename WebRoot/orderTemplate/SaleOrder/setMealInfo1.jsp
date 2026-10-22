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
    
    <title>套餐详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	

  </head>
  <script type="text/javascript">

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
                 
                  <TD align=right width="25%" height=30>套餐类型：</TD>
                <TD width="25%" align="left">${setmeal.ordertype.name }</TD>
                <TD width="10%" height=30 align=right>套餐名称： </TD>
                <TD width="40%" align="left">${setmeal.name }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>活动开始时间：</TD>
                <TD width="25%" align="left">${setmeal.startTime }</TD>
                <TD align=right width="10%" height=30>活动结束时间：</TD>
                <TD width="40%" align="left">${setmeal.endTime}</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>套餐创建时间：</TD>
                <TD width="25%" align="left">${setmeal.buildTime}</TD>
                <TD width="10%" align=right height=30>收费类型：</TD>
                
                <TD width="40%" align="left">
                	<c:if test="${setmeal.chargeMode ==1}">免费</c:if>
                	<c:if test="${setmeal.chargeMode ==2}">赠送</c:if>
                	<c:if test="${setmeal.chargeMode ==3}">预付</c:if>
                	<c:if test="${setmeal.chargeMode ==4}">后付</c:if>
                </TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>原价：</TD>
                <TD width="25%" align="left">${setmeal.totalPrice }</TD>
                <td width="10%" align=right height=30>实际价格：</td>
                <TD width="40%" align="left">${setmeal.payPrice }</TD>
              </TR>
             
              <TR>
                <TD align=right height=30 >套餐描述：</TD>
                <TD colspan="3" align="left"><textarea style="width:500px; height:170px;"> ${setmeal.describe }</textarea></TD>
              </TR>
              <tr><td colspan="4" height="15"></td></tr>
             <!-- <tr>
                <td width="25%" align="center" colspan="4" class="dt07">产品明细</td>
              </tr>-->
 				<tr>
                	<td colspan="4">
                    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
                        	<tr class="dt07">
                            	<td width="25%" align="center"  height="30">
                                	商品名称
                                </td>
                                <td  width="25%" align="center">
                                	价格
                                </td>
                                <td  width="25%" align="center">
                                	数量
                                </td>
                                <td  width="25%" align="center">
                                	单位
                                </td>
                            </tr>
                            <c:forEach items="${setmealproperty}" var="mealproperty">
                            <tr>
                            	<td width="25%" align="center" height="30">
                                	${mealproperty.name }
                                </td>
                                <td  width="25%" align="center">
                                	${mealproperty.price }
                                </td>
                                <td  width="25%" align="center">
                                	${mealproperty.num }
                                </td>
                                <td  width="25%" align="center">
                                	${mealproperty.unit }
                                </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </td>
                </tr>
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
  
</FORM>
</body>
</html>
