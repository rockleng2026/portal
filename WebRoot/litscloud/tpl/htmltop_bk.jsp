<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="ly_topt">
	<div class="ly_top_t">
		<div class="ly_top_tl">
			<a href="<%=path %>/index.html" target="_parent"><img
					src="<%=path%>/litscloud/web/images/LOGO.png" class="logo"
					alt="立云终端服务" />
			</a>
		</div>
		<div class="ly_top_tr">
			<div class="ly_top_trt">
				<div class="ly_top_trtc">
					<a href="#"><img
							src="<%=path%>/litscloud/web/images/ly_03.gif" />
					</a>
				</div>
				<c:if test="${customer.customerName == null}">
				<div class="ly_top_trtl">
					Hi,欢迎您！
					<a href="<%=path%>/litscloud/ucenter/u_login.jsp" target="_parent">登录</a> |
					<a href="<%=path%>/litscloud/ucenter/u_login.jsp" target="_parent">注册</a> |
					<a href="javascript:void(0);">忘记密码</a>
				</div>
				</c:if>
				<c:if test="${customer.customerName != null}">
				<div class="ly_top_trtg"  >欢迎您来到立云,<span class="blue_q"><a href="<%=path %>/litscloud/ucenter/index.jsp">${customer.customerName}</a> </span>| 消息 <span class="xiaoxi"><a href="javascript:void(0);">1</a></span> | <a href="javascript:void(0);" target="_parent" onclick="logout('<%= basePath%>')" title="点击退出系统">退出</a></div>
				</c:if>
				</div>
				
			<div class="ly_top_trd">
				<div class="ly_top_trdl">
					<div class="ly_top_trdll"></div>
					<div class="ly_top_trdlc">
						<div class="ly_top_trdlcl">
							<input type="text" name="cz" class="ly_cz" />
						</div>
						<div class="ly_top_trdlcr">
							<input type="button"
								style="width: 37px; height: 30px; background-image: url(<%=path%>/litscloud/web/images/lys_04.gif); background-repeat: no-repeat; border: none;"
								value="" onclick="javascript:void(0);" />
						</div>
					</div>
					<div class="ly_top_trdlr"></div>
				</div>
				<div class="ly_top_trdr">
					<img src="<%=path%>/litscloud/web/images/TEL.png" />
				</div>
			</div>
			<div class="ly_top_trd"></div>
		</div>
	</div>
	<div class="ly_top_d">
		<ul>
			<li>
				<a href="<%=path %>/index.html" target="_parent"
					style="font-family: Arial, Helvetica, sans-serif; color: #2fafea; background-image: url(<%=path%>/litscloud/web/images/ly_05.gif); background-repeat: no-repeat; background-position: center center;">Home</a>
			</li>
			<li>
				<a id="platform" href="<%=path %>/tuan/" target="_parent"><font color="red">团购</font></a>
			</li>
			<li>
				<a id="newserver"  href="<%=path %>/litscloud/web/LitsCloudServer.html" target="">云服务<input id="aaa" value="123" /></a>
			</li>
			<li>
				<a  id="apply" href="<%=path %>/litscloud/web/apply.html" target="_parent">云应用</a>
			</li>
			
			<li>
				<a id="about" href="<%=path %>/litscloud/web/about.html" target="_parent">关于我们</a>
			</li>
			<li>
				<a id="vip" href="<%=path %>/litscloud/ucenter/u_login.jsp" target="_parent">会员中心</a>
			</li>
		
		</ul>
	</div>
</div>