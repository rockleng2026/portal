<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript" src="<%=path %>/litscloud/js/user.js"></script>
<link href="<%=path %>/tuan/css/css.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=path %>/tuan/js/jquery-1.7.2.min.js'></script>
<script type='text/javascript' src='<%=path %>/tuan/js/tab.js'></script>
<script type="text/javascript">
function logout(basePath){
	window.location.href=basePath+"litscloud/web/litscloudUserLogoutCustomerServerC.Action";
}
</script>
<div class="top">
	<div class="logo"  style="margin-top: 0px;padding-top: 0;"><a href="#" ><img src="<%=path %>/litscloud/images/LOGO.png" /></a></div>
    <div class="nav">
    	<ul>
        	<li><a href="<%=path %>/index.html"  class="menuon" id="a1" onmouseover="slide('a','b','1');" >HOME</a></li>
            <li class="tg"><a href="<%=path %>/tuan/" class="menuno tuangou" id="a2" onmouseover="slide('a','b','2');">团购</a></li>
            <li><a href="<%=path %>/litscloud/web/LitsCloudServer.html" class="menuno" id="a3" onmouseover="slide('a','b','3');" >云服务</a></li>
            <li><a href="<%=path %>/litscloud/web/apply.html" class="menuno" id="a4" onmouseover="slide('a','b','4');" >云应用</a></li>
            <li><a href="<%=path %>/litscloud/web/about.html" class="menuno" id="a5" onmouseover="slide('a','b','5');" >关于我们</a></li>
            <li><a href="<%=path %>/litscloud/ucenter/u_login.jsp" class="menuno" id="a6" onmouseover="slide('a','b','6');" >会员中心</a></li>
        </ul>
    </div>
</div>
<div class="top2">
	<div class="phone"><a  href="http://wpa.qq.com/msgrd?v=3&uin=537029160&Menu=yes" target="_blank"></a></div>
    <div class="nav2">
    <div class="dison" id="userinfo" style="display: block">
    <c:if test="${customer.customerName != null}">
	    	<ul>
	        <li>欢迎你：</li>
	        <li><a href="litscloud/ucenter/u_zhanghu.jsp">${customer.customerName}</a></li>
	        <li></li>
	        <li><a href="litscloud/ucenter/u_zhanghu.jsp">自助管理</a></li>
	        <li><a href="javascript:void(0);" onclick="logout('<%=basePath %>')" title="点我退出登陆">安全登出</a></li>
	        </ul>
	</c:if>
    </div>
    <div class="dison" id="b1">
    	<ul>
        <!-- 
        <li><a href="#">云存储平台</a></li>
        <li><a href="#">视频云平台</a></li>
        <li><a href="#">协同管理云</a></li>
        <li><a href="#">企业私有云</a></li>
        <li><a href="#">政府单位门户</a></li>
        </ul>
         -->
     </div> 
         <div class="disno" id="b2">
    	<ul>
    	<!-- 
        <li><a href="#">云存储平台2</a></li>
        <li><a href="#">视频云平台2</a></li>
        <li><a href="#">协同管理云2</a></li>
        <li><a href="#">企业私有云2</a></li>
        <li><a href="#">政府单位门户2</a></li>
        -->
        </ul>
     </div>
       <div class="disno" id="b3">
    	<ul>
    	<!-- 
        <li><a href="#">云存储平台3</a></li>
        <li><a href="#">视频云平台3</a></li>
        <li><a href="#">协同管理云3</a></li>
        <li><a href="#">企业私有云3</a></li>
        <li><a href="#">政府单位门户3</a></li>
        -->
        </ul>
     </div>  
       <div class="disno" id="b4">
    	<ul>
    	<!-- 
        <li><a href="#">云存储平台4</a></li>
        <li><a href="#">视频云平台4</a></li>
        <li><a href="#">协同管理云4</a></li>
        <li><a href="#">企业私有云4</a></li>
        <li><a href="#">政府单位门户4</a></li>
        -->
        </ul>
     </div>  
       <div class="disno" id="b5">
    	<ul>
    	<!-- 
        <li><a href="#">云存储平台5</a></li>
        <li><a href="#">视频云平台5</a></li>
        <li><a href="#">协同管理云5</a></li>
        <li><a href="#">企业私有云5</a></li>
        <li><a href="#">政府单位门户5</a></li>
        -->
        </ul>
     </div>    
       <div class="disno" id="b6">
    	<ul>
    	<!-- 
        <li><a href="#">云存储平台6</a></li>
        <li><a href="#">视频云平台6</a></li>
        <li><a href="#">协同管理云6</a></li>
        <li><a href="#">企业私有云6</a></li>
        <li><a href="#">政府单位门户6</a></li>
        -->
        </ul>
     </div>   
         
    </div>
</div>