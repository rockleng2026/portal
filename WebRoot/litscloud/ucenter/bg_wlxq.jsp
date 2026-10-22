<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（我要充值）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->

</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心>订单管理>订单详情</div> 
          
             <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
        
             <div class="bg_wl">
               <div class="bg_wlt">
                  <div class="bg_wltt"></div>
                  <div class="bg_wltc">
                     <div class="bg_wltcl">订单编号： 200178493841632 创建时间： 2013-03-10 17:52   shimhwachen</div>
                     <div class="bg_wltcr"><a href="#">和我联系</a></div>
                  </div>
                  <div class="bg_wltm">我的留言： 请尽快发货，谢谢。。 </div>
                  <div class="bg_wltd"></div>
               </div>
               <div class="bg_wlc">
                  <div class="bg_wlct"></div>
                  <div class="bg_wlcc">物流编号： 200178493841632</div>
                  <div class="bg_wlcm">发货方式：自己联系 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 物流公司：申通E物流 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 运单号码：568955170442</div>
                  <div class="bg_wlcd"></div>
               </div>
               <div class="bg_wlm">物流动态</div>
               <div class="bg_wls">
                    <div class="bg_wlst"></div>
                    <div class="bg_wlsc">
                       <div class="bg_wlsm">
                          <div class="bg_wlsm_t">
                             <div class="bg_wlsm_tc">
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">卖家已发货</div>
                                </div>
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">【广东广州东川点】的收件员【女昌南】已收件</div>
                                </div>
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">【广东广州东川点】的收件员【女昌南】已收件</div>
                                </div>
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">快件已到达【广东广州中转部】扫描员是【王海飞】</div>
                                </div>
                                <div class="bg_wlsm_tct" style="background-color:#e7e7e7;">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">由【广东广州公司】发往【广东保安公司】</div>
                                </div>
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">快件已到达</div>
                                </div>
                                <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr">快件已到达</div>
                                </div>
                                <div class="bg_wlsm_tct" style="background-color:#e7e7e7;">
                                   <div class="bg_wlsm_tctl">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctc">
                                       <div class="bg_wlsm_tctct">【广东省王海飞】正在派件</div>
                                       <div class="bg_wlsm_tctcd">信息来源：<a href="#">申通E物流</a> &nbsp; 运单号：42252200</div>
                                   </div>
                                </div>
                                 <div class="bg_wlsm_tct">
                                   <div class="bg_wlsm_tctl" style="color:#1b730c;">2013-03-16 23:37:40</div>
                                   <div class="bg_wlsm_tctr" style="color:#1b730c;">已签收，签收人是：XXX <img src="litscloud/images/log_97.gif" /></div>
                                </div>
                             </div>
                          </div>
                          <div class="bg_wlsm_c"><img src="litscloud/images/log_13.gif" />以上信息部分来源于第三方，您可以通过鼠标展开每条信息并查看其来源</div>
                          <div class="bg_wlsm_d">
                              <div class="bg_wlsm_dt">宝贝信息</div>
                              <div class="bg_wlsm_dd">
                               <dl>
                                 <dt><img src="litscloud/images/bg_29.png" /></dt>
                                 <dd>1200.00*1</dd>
                               </dl>
                              </div>
                          </div>
                       </div> 
                        
                    </div>
                    <div class="bg_wlsd"></div>
               </div> 
               <div class="bg_wld">
                   <div class="bg_wld_t"></div>
                   <div class="bg_wld_c">
                      <div class="bg_wld_cc">收货信息： 广东省深圳市宝安区深圳市宝安中心区坪洲地铁D出口渔业旧村1巷40号，李四， 13713959642，518102

<br />发货信息： 广东省广州市越秀区大南路82号，510000，陈生，13580389971 
</div>
                   </div>
                   <div class="bg_wld_d"></div>
               </div>
            </div> 

      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
