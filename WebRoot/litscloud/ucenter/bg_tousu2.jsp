<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（投诉2-立云介入处理）</title>
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
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心>订单管理>投诉管理</div> 
          
             <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
        
             <div class="bg_ts">
              <div class="bg_tst"><img src="litscloud/images/log_54.gif" /></div>
              <div class="bg_tsd">
                 <div class="bg_tsd_l">
                    <div class="bg_tsd_lt">
                       <div class="bg_tsd_ltt"></div>
                       <div class="bg_tsd_ltc"><img src="litscloud/images/log_56.gif" />立云已介入审核，请耐心等待</div>
                       <div class="bg_tsd_ltd"></div>
                    </div>
                    <div class="bg_tsd_ld">
                       <div class="bg_tsd_ldt"></div>
                       <div class="bg_tsd_ldc">
                          <div class="bg_tsd_ldc_t"><span><a href="#">我要留言</a></span>留言板</div>
                          <div class="bg_tsd_ldc_d">
                             <div class="bg_tsd_ldc_dl">
                                <div class="bg_tsd_ldc_dlc"><img src="litscloud/images/log_62.gif" /></div>
                             </div>
                             <div class="bg_tsd_ldc_dc"></div>
                             <div class="bg_tsd_ldc_dr">
                                <div class="bg_tsd_ldc_drc">
                                  <div class="bg_tsd_ldc_drct">zhang_shang (<span>2013-03-27 11:53:33</span>)</div>
                                  <div class="bg_tsd_ldc_drcd">发货太慢<br /><br /><img src="litscloud/images/log_63.gif" /></div>
                                </div>
                             </div>                             
                          </div>
                       </div>
                       <div class="bg_tsd_ldd"></div>
                    </div>
                 </div>
                 <div class="bg_tsd_r">
                   <div class="bg_tsd_rt">
                     <div class="bg_tsd_rtt"></div>
                     <div class="bg_tsd_rtc">
                        <div class="bg_tsd_rtct"><span><a href="#"><img src="litscloud/images/log_71.gif" /></a></span>投诉内容</div>
                        <div class="bg_tsd_rtcd">
                          <dl><dt>投诉编号：</dt><dd>4001303270001242</dd></dl>
                          <dl><dt>投诉类型：</dt><dd>违背承诺</dd></dl>
                          <dl><dt>投诉状态：</dt><dd>立云已介入</dd></dl>
                          <dl><dt>被投诉人：</dt><dd>浪漫骑士68</dd></dl>
                          <dl><dt>申请时间：</dt><dd>2013-03-27 16:15:22</dd></dl>
                          <dl><dt>补充留言：</dt><dd>发货太慢</dd></dl>
                        </div>
                     </div>
                     <div class="bg_tsd_rtd"></div>
                   </div>
                   <div class="bg_tsd_rd">
                      <div class="bg_tsd_rdt"></div>
                      <div class="bg_tsd_rdc">
                            <div class="bg_tsd_rdct">宝贝信息</div>
                          <div class="bg_tsd_rdcm">
                             <div class="bg_tsd_rdcml"><img src="litscloud/images/bg_29.png" /></div>
                             <div class="bg_tsd_rdcmr">
                               <div class="bg_tsd_rdcmrt">ip数量：1<br /> 
宽带总数：10<br />
服务器配置：<br />
I3  Windows2003</div>
                               <div class="bg_tsd_rdcmrc">付费类型：季付 </div>
                               <div class="bg_tsd_rdcmrd"><ul>
                                 <li><img src="litscloud/images/log_72.gif" /></li>
                                 <li><img src="litscloud/images/log_73.gif" /></li>
                               </ul></div>
                             </div>
                          </div>
                          <div class="bg_tsd_rdcc">买家：<a href="#">冯艳玲</a></div>
                          <div class="bg_tsd_rdcc">单价：1200元</div>
                          <div class="bg_tsd_rdcc">数量：1台</div>
                          <div class="bg_tsd_rdcc">优惠：无优惠</div>
                          <div class="bg_tsd_rdcc">小计：￥<span>1200</span>元</div>
                          <div class="bg_tsd_rdcc" style="background-color:#ebf4fe; font-weight:bold;">订单信息</div>
                         <div class="bg_tsd_rdcc">订单编号：<a href="#">26532132456</a></div>
                          <div class="bg_tsd_rdcc">支付宝：zhds@qq.com</div>
                          <div class="bg_tsd_rdcc">运费：<span>0.00</span>元</div>
                          <div class="bg_tsd_rdcc">总优惠：<span>-50.00</span>元</div>
                          <div class="bg_tsd_rdcc">总计：￥<span>1200</span>元</div>
                          <div class="bg_tsd_rdcd"><span>2013-03-17<br />12:22:22</span>成交时间:</div>  
                      </div>
                      <div class="bg_tsd_rdd"></div>
                   </div>
                 </div>
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
