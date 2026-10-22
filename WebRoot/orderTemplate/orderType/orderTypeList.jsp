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
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
			<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
	<LINK href="<%=request.getContextPath() %>/Css/setMeal/css.css" type="text/css" rel="stylesheet">

  </head>
<body>
	<table width="1000"  border="0" cellpadding="0" cellspacing="0" align="center" >
	<tr>
		<td colspan="10" align="right">         
			<input id="" name="" value="新增单据类型"  type="button"  onclick="add()"/>
		</td>
	</tr>
 <tr>
    <td align="center" colspan="10"><div class="dt01" style="background:url(<%=request.getContextPath() %>/images/setMeal/hdr.gif) repeat-x left center; ">
        <div class="left"><img src="<%=request.getContextPath() %>/images/setMeal/hdrl.gif" /></div>
        <div class="left" style="width:987px;">
          <h3>单据类型列表</h3>
        </div>
        <div class="right"><img src="<%=request.getContextPath() %>/images/setMeal/hdrr.gif" /></div>
      </div></td>
  </tr>
        <tr class="dt03">
        	<td align="center" width="180" height="35">
            	编号
            </td>
            <td align="center" width="120">
            	单据名称
          </td>
            <td align="center" width="180">
            	 申请时间
            </td>
            <td align="center" width="220">
            	详细信息
            </td>
            <td align="center" width="150">
            	修改
            </td>
            <td align="center" width="150">
            	删除
            </td>
        </tr>
        <c:forEach items="${pages.pageList}" var="data"  varStatus="state">
        <tr>
        	<td align="center" width="180" height="30">
            	${state.index+1}
            </td>
            <td align="center" width="120">
            	${data.name}
      </td>
            <td align="center" width="180">
            	${data.temp2}
            </td>
            <td align="center" width="220">
            	<a href="orderTypeorderAction.do?id=${data.id}&mark=1">详细信息</a>
            </td>
            <td align="center" width="150">
            	<a href="orderTypeorderAction.do?id=${data.id}&mark=2">修改</a>
          </td>
            <td align="center" width="150">
            	<input onclick="del(${data.id})" value="删除" type="button" />
            </td>
        </tr>
        </c:forEach>
        <tr>
        	<TD class=category colSpan=6 height=30>
					<p:pages url="orderTypeListorderAction.do"/>
			</TD>
        </tr>
    </table>
</body>
	<SCRIPT type="text/javascript">
		function del(id)
		{
			var url="delOrderTypeorderAction.do";
				$.post(url,{id:id},function(data){
				if(data==0)
				{
					alert("删除成功！！！");
					window.location.href='<%=request.getContextPath() %>/orderTypeListorderAction.do';
				}
				else
				{
					alert("删除失败！！！");
				}
			});
		}
	</SCRIPT>
		<SCRIPT type="text/javascript">
		 function add()
		 {
		   window.location.href='<%=request.getContextPath() %>/orderTemplate/orderType/addOrderType.jsp';
		  }
	 </SCRIPT>
	
	
</html>
