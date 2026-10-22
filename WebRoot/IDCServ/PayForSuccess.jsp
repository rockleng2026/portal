<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'PayForSuccess.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"/>
    <script type="text/javascript">
      window.onload=function(){
          document.getElementById("form1").submit();
      }
    </script>
  </head>
  
  <body>
     <form action="<%=basePath%>customFlowCustomerServer.do" method="post" id="form1">
          <input type="hidden" name="salnos" value="<%=request.getSession().getAttribute("salsnos") %>">
     </form>
  </body>
</html>
