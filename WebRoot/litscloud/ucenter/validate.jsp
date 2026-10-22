<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Customer"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	 Customer cus =(Customer)request.getSession().getAttribute("customer");
%>
<script type="text/javascript">
  if( '<%=cus %>' == null){
    window.location.href="<%=path %>/litscloud/ucenter/u_login.jsp";
  }
</script>

