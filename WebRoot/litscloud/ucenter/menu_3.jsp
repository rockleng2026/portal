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
                 <li><a href="litscloud/ucenter/showOrderadd3CDNsaleOrderAction.Action" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">CDN<br />管理</a></li>
                  <li><a href="litscloud/ucenter/u_zxgd.jsp">服务<br />中心</a></li>
             
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
                    <li><a id="a1" href="litscloud/ucenter/showOrderadd3CDNsaleOrderAction.Action" >CDN添加</a></li>
                    <li><a id="a2" href="litscloud/selectRealmNameCDNsaleOrderAction.Action?cusID=${customer.customerId}" >带宽图显示</a></li>
                    <li><a id="a3" href="CDNFlowControl1aCDNsaleOrderAction.Action?cusID=${customer.customerId}" >流量图显示</a></li>
                    <li><a id="a4" href="CDNFlowControl2aCDNsaleOrderAction.Action?cusID=${customer.customerId}" >请求次数显示</a></li>
                    <li><a id="a5" href="selectJieDian1mission.Action"   >内容刷新</a></li>  
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
</div> 