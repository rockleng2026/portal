<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="gbk"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<script type="text/javascript">
function logout(basePath){
	window.location.href=basePath+"litscloud/web/litscloudUserLogoutCustomerServerC.Action";
}
</script>
<c:if test="${customer.customerName != null}">
    	<ul>
        <li>»¶Ó­Äã£º</li>
        <li><a href="litscloud/ucenter/u_zhanghu.jsp">${customer.customerName}</a></li>
        <li>µÇÂ½IP£º</li>
        <li>${customer.localip}</li>
        <li><a href="javascript:void(0);" onclick="logout('<%=basePath %>')" title="µãÎÒÍË³öµÇÂ½">µÇ³ö</a></li>
        </ul>
</c:if>