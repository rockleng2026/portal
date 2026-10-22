<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="bg_t">当前位置：<a href="litscloud/ucenter/index.jsp" target="_parent">首页</a>>会员中心</div> 
<div class="bg_c">
              <div class="bg_ct"><ul>
                 <li><a href="litscloud/ucenter/index.jsp" >资料<br />管理</a></li>
                <li><a href="litscloud/ucenter/my_order.jsp" >交易<br />管理</a></li>
                 <li><a href="litscloud/ucenter/showOrderadd3CDNsaleOrderAction.Action">CDN<br />管理</a></li>
                  <li><a href="litscloud/ucenter/u_zxgd.jsp"  style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">服务<br />中心</a></li>
             
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
              <li><a href="litscloud/ucenter/u_zxgd.jsp" style="background-image:url(litscloud/images/bg_06.jpg); color:#000; background-repeat:no-repeat;" >在线工单</a></li>
         
           </ul></div>
                 <div class="bg_cdr"></div>
              </div>
</div> 