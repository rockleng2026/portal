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
    
    <title>订单套餐属性列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
  </head>
  <script type="text/javascript">
  	function taocan()
	{
　		　window.open ('goListSetMealProAction.do');
	}
	
   	function del(id, endurl){
   		var date=new Date();
   		var url="delSetMealProAction.do?date="+date;
   			if(confirm("你确定要删除该数据吗？")){
   				$.post(url,{
   					id:id
   				},function(data){
   					if(data==0){
   						alert("删除成功！");
   						window.location.href = endurl;
   					}else{
   						alert("删除失败！");
   					}
   				}
   				)
   			}
   	}
  </script>
  <body>
  	<FORM name=form2 action="goListSetMealProAction.do" method="post">
  <TABLE cellSpacing=0 cellPadding=0 width="1000" align=center border=0 class="dt04">
    <TBODY>
      <TR>
        <TD align=right height="35"> 套餐属性名：
          <INPUT type="text" id="propertyName" name="propertyName"/>
          <INPUT class=button type=submit  value=" 查询 "/>
          &nbsp;<a href="goAddSetMealProAction.do">新增套餐属性</a></TD>
      </TR>
    </TBODY>
  </TABLE>
</FORM>
<TABLE cellSpacing=0 cellPadding=0 width="1000" border=0 align="center">
  <TBODY>
    <TR>
      <TD class="dt05"> 套餐属性列表 </TD>
    </TR>
    <TR>
      <TD class="dt04"><form action="" id="form1" name="form1" method="post">
          <TABLE cellSpacing=0 cellPadding=0 align=center border=0 width="100%" class="dt06">
            <TBODY>
              <TR align="center">
                <TD id="tid" width="10%" height="30" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 套餐属性编号 </TD>
                <TD id="tname" width="10%" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 套餐属性名 </TD>
                <TD id="tflow" width="10%" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 产品名 </TD>
                <TD id="tflow" width="10%" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 产品类型 </TD>
                <TD id="tbandwidth" width="10%" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 数量 </TD>
                <TD id="thitnum" width="10%" align="center" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 单位 </TD>
                <TD id="thitnum" width="10%" align="center" onmouseover="showInput(this)" onMouseOut="displayIput(this)"> 价格</TD>
                <TD width="10%" align="center"> 修改 </TD>
                <TD width="10%" align="center"> 删除 </TD>
                <TD width="10%" align="center"> 查看详细 </TD>
              </TR>
            </TBODY>
          </TABLE>
        </form>
        <table id="infotable" cellSpacing=0 cellPadding=0 align=center border=0 width="1000">
          <tbody>
            <!--循环-->
            <c:if test="${empty pages.pageList}"><tr><td align="center">无套餐属性</td></tr></c:if>
            <c:if test="${!empty pages.pageList}">
			<c:forEach items="${pages.pageList}" var="data" >
            <TR align="center">
              <TD width="10%" height="30"> ${data.id } </TD>
              <TD width="10%" ><a href="goSetMealProAction.do?id=${data.id }&type=info" target=right> ${data.name }</a></TD>
              <TD width="10%" > ${data.product.property.name } </TD>
              <TD width="10%" > ${data.product.property.model.name } </TD>
              <TD width="10%" > ${data.num } </TD>
              <TD width="10%" align="center" > ${data.unit }</TD>
              <TD width="10%" align="center" > ${data.price } </TD>
              <TD width="10%" align="center"><A title="修改" href="goSetMealProAction.do?id=${data.id }&type=update" target=right>修改</A></TD>
              <TD width="10%" align=center><a title="删除" href="javascript:void();" onclick="return del(${data.id },'goListSetMealProAction.do');">删除</a></TD>
              <TD width="10%" align=center><a title="查看详情" href="goSetMealProAction.do?id=${data.id }&type=info" target=right> 查看详情</a></TD>
            </TR>
            </c:forEach>
            </c:if>
            <!--循环结束-->
          </TBODY>
        </TABLE>
        <!--endprint-->
        </TD>
      <TD></TD>
    </TR>
    <TR>
      <!--分页标签 毋须修改-->
      <TD id="page" height="50" class="dt04"><p:pages url="goListSetMealProAction.do"/></TD>
    </TR>
  </TBODY>
</TABLE>
  </body>
</html>
