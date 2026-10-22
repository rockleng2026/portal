<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>

<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

</script>
<div class="bg_t">当前位置：<a href="litscloud/ucenter/index.jsp" target="_parent">首页</a>>会员中心</div> 
          <div class="bg_c">
              <div class="bg_ct"><ul>
                <li><a href="litscloud/ucenter/index.jsp" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">资料<br />管理</a></li>
                <li><a href="litscloud/ucenter/my_order.jsp">交易<br />管理</a></li>
                 <li><a href="litscloud/ucenter/showOrderadd3CDNsaleOrderAction.Action">CDN<br />管理</a></li>
                  <li><a href="litscloud/ucenter/u_zxgd.jsp">服务<br />中心</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc" id="box"><ul>
                    <li><a  id="a1" href="litscloud/ucenter/index.jsp"  >个人资料</a></li>
                    <li><a  id="a2" href="litscloud/ucenter/bg_password.jsp">修改密码</a></li>
                    <li><a id="a4" href="litscloud/ucenter/u_zhanghu.jsp">账户信息</a></li>
                  <!-- 
                    <li><a id="a3" href="litscloud/ucenter/bg_wycz.jsp" >我要充值</a></li>
                    --> 
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
          </div> 

<!-- 
 <script type="text/javascript">
$(document).ready(function(){ 
	$(".c2").click(function(){
	var val=$(this).text();//

	 $(".c2").each(function(){
	  var val1=$(this).text();
	  
	  if(val1==val){//(); :;
		  alert(val1);
		  $(this).css("background-image","url(litscloud/images/bg_01.png)");
	 
	  }else{
	    $(this).css("background-image","");
	  }
	  
	  });
	  
	});
});
>>>>>>> .r3450
</script>
<div class="bg_t">当前位置：<a href="litscloud/tpl/index.jsp" target="_parent">首页</a>><a href="litscloud/ucenter/index.jsp">会员中心</a></div> 
          <div class="bg_c">

         <div class="bg_c">

              <div class="bg_ct"><ul>
                <li><a href="litscloud/ucenter/index.jsp" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">我的<br />账户</a></li>
                
                  <li><a href="litscloud/ucenter/my_order.jsp">自助<br />管理</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>

                    <li><a class="c2" href="litscloud/ucenter/index.jsp" id="menu1_a1">个人资料</a></li>
                    <li><a class="c2" href="litscloud/ucenter/u_pay.jsp" id="menu1_a2" 	>在线支付</a></li>
                    <li><a class="c2" href="litscloud/ucenter/bg_password.jsp" id="menu1_a3" >修改密码</a></li>
                    <li><a class="c2" href="litscloud/ucenter/bg_zhaopass.jsp" id="menu1_a3" >忘记密码</a></li>
                    <li><a class="c2" href="litscloud/ucenter/bg_wycz.jsp" id="menu1_a4">我要充值</a></li>
                     <li><a class="c2" href="litscloud/ucenter/u_zhanghu.jsp" id="menu1_a4">账户信息</a></li>

                     <li><a href="litscloud/ucenter/bg_czjl.jsp" id="menu1_a4">充值记录</a></li>
                     

                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
</div>
-->