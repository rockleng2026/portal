<%@ page language="java" import="java.util.*" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
                <TD width="25%" align="left">${data.starttime }</TD>
                <TD align=right width="10%" height=30>活动结束时间：</TD>
                <TD width="40%" align="left">${data.endtime }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>套餐创建时间：</TD>
                <TD width="25%" align="left">${data.usetime }</TD>
                <TD width="10%" align=right height=30>收费类型：</TD>
                <TD width="40%" align="left">XXXXXXX</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>原价：</TD>
                <TD width="25%" align="left">${data.price }</TD>
                <td width="10%" align=right height=30>实际价格：</td>
                <TD width="40%" align="left">${data.payprice }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>套餐类型：</TD>
                <TD width="25%" align="left">${data.realmtype.name }</TD>
                <td width="10%" align=right height=30></td>
                <TD width="40%"></TD>
              </TR>
              <TR>
                <TD align=right height=30 >套餐描述：</TD>
                <TD colspan="3" align="left"><textarea style="width:500px; height:170px;"> ${data.describe }</textarea></TD>
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
                                	商品类型
                                </td>
                                <td  width="25%" align="center">
                                	商品型号
                                </td>
                                <td  width="25%" align="center">
                                	建立商品日期
                                </td>
                            </tr>
                            <tr>
                            	<td width="25%" align="center" height="30">
                                	滨州机房
                                </td>
                                <td  width="25%" align="center">
                                	机房
                                </td>
                                <td  width="25%" align="center">
                                	AXXXXA
                                </td>
                                <td  width="25%" align="center">
                                	2012-2-23
                                </td>
                            </tr>
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
