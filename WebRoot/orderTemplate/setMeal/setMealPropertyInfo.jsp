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
    
    <title>套餐属性详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=path %>/js/juqery/lib/jquery-1.4.2.min.js"></script>
  </head>
  <script type="text/javascript">
		function goUpdate(goUrl){
			window.location.href = goUrl;
		}

		function showInfo(id)
		{
			var nowDate = (new Date()).getTime();
			var url = "<%=request.getContextPath() %>/commodity/infoCommodity.do?id="+id+"&dd="+nowDate;
			$("#showContent").load(url);
			$("#closeContent").html("×");
		}
		function cleanC(){
			$("#showContent").html("<br/>");
			$("#closeContent").html("");
		}
</script>
  <body>
  	<FORM  id ="form1" name=form1 action="" method="post" onsubmit="return addValidators()">
  <TABLE cellSpacing=0 cellPadding=0 width="1000"  align="center" border=0 class="dt04">
    <TBODY>
      <TR>
        <TD class="dt05">套餐属性详情 </TD>
      </TR>
      <TR>
        <TD><TABLE cellSpacing=0 cellPadding=0 align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR>
                <TD width="25%" height=30 align=right>套餐属性编号： </TD>
                <TD width="25%" align="left">${data.id }</TD>
                <TD width="10%" height=30 align=right>套餐属性名： </TD>
                <TD width="40%" align="left">${data.name }</TD>
              </TR> 
              <TR>
                <TD align=right width="25%" height=30>包含产品：</TD>
                <TD width="25%" align="left"><a title="点击查看详细" onclick="showInfo(${data.product.property.id})">${data.product.property.name }&nbsp;[${data.product.property.model.name }]</a></TD>
                <TD align=right width="10%" height=30>价格：</TD>
                <TD width="40%" align="left">${data.price }</TD>
              </TR>
              <TR>
                <TD align=right width="25%" height=30>数量：</TD>
                <TD width="25%" align="left">${data.num }</TD>
                <td width="10%" align=right height=30>单位：</td>
                <TD width="40%" align="left" colspan="3">${data.unit }</TD>
              </TR>
              <TR>
                <TD height=30>&nbsp;</TD>
                <TD height="50" colspan="3" align="left"><INPUT class=button type="button" onClick="goUpdate('goSetMealProAction.do?id=${data.id }&type=update');" value=" 修改 ">
                  <INPUT class=button type="button" onClick="history.go(-1);" value=" 返回  "></TD>
              </TR>
            </TBODY>
          </TABLE></TD>
      </TR>
    </TBODY>
  </TABLE>
  <div id="closeContent" onclick="cleanC()" title="点击关闭"></div>
  <div id="showContent"></div>
</FORM>
  </body>
</html>
