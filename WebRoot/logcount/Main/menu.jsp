<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>导航菜单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	<link rel="StyleSheet" href="<%=path %>/Main/menu/menu.css" type="text/css" />
	-->
	<link rel="StyleSheet" href="Css/dtree.css" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/dtree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>

  </head>
  
<body onload="showMessage()">
<!-- 当前登录员工id -->
<input type="hidden" id="eid" name="eid" value="${emp.id }"/>

<div class="dtree">

	<p><a href="javascript: dd.openAll();">全部展开</a>&nbsp;&nbsp;||&nbsp;&nbsp;<a href="javascript: dd.closeAll();">全部收缩</a></p>

</div>
	<script type="text/javascript">	
		var ddh = 0;
		var ddw = 0;
		dd= new dTree('dd');
		dd.add('0','-1','菜单功能树');
	</script>
	<c:forEach items="${infolist}" var="data" varStatus="status">
		<c:if test="${data.functionId==(data.functionId)}">
			<script>
			dd.add('${data.functionId}','${data.superId}','${data.linkFunctionName}','${data.linkFunctionPage}','','right','${data.imagepath}','','');
			</script>
		</c:if>
	</c:forEach>
	<script>document.write(dd);</script>
	
	<!-- 弹窗模块 -->
     <script language="JavaScript">
     	//异步刷新
     	function showMessage()
		{
			var eid = $("#eid").val();
			//alert("["+eid+"]");
			
			var t=new Date();
			var url="quartzSelectLogin.do?t="+t;
	         $.post(url,{
	           	id:eid
		        },function(data)
		        {
		        	//alert(data);
		            if(data == 0){
		                getMsg();		                
		            }else if(data != 0){
		            	//alert("木有新任务")
		            }
		        }
		     );
		}
		</script>	
  </body>
</html>
