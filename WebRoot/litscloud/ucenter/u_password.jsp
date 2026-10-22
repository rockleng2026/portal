<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="bg_t">当前位置：<a href="litscloud/tpl/index.jsp" target="_parent">首页</a>><a href="litscloud/ucenter/index.jsp">会员中心</a></div> 
          <div class="bg_c">
              <div class="bg_ct"><ul>
                <li><a href="litscloud/ucenter/index.jsp" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">我的<br />账户</a></li>
                <li><a href="litscloud/ucenter/my_order.jsp">自助<br />管理</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
                    <li><a href="litscloud/ucenter/index.jsp" style="background-image:url(litscloud/images/bg_06.jpg); color:#000; background-repeat:no-repeat;">个人资料</a></li>
                    <li><a href="litscloud/ucenter/u_pay.jsp">在线支付</a></li>
                    <li><a href="litscloud/ucenter/u_password.jsp">修改密码</a></li>
                    <li><a href="litscloud/ucenter/u_findpass.jsp">忘记密码</a></li>
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
</div>