<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（评价宝贝）</title>
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
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->

</head>

<body>
    <!--头部公用代码-->
  <div class="ly_body">
    <!------------------------------------------头部公用代码------------------------------------------------------------>
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心>订单管理>评价宝贝</div> 
          <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
          <div class="bg_ping">
              <div class="bg_ping_t">评价宝贝</div>
              <div class="bg_ping_cc">
                <div class="bg_ping_cl"></div>
                <div class="bg_ping_cr"></div>
              </div>
              <div class="bg_ping_d">
                 <div class="bg_ping_dt"></div>
                 <div class="bg_ping_dc">
                     <div class="bg_ping_dct">
                       <div class="bg_ping_dctl">
                          <div class="bg_ping_dctlt"></div>
                          <div class="bg_ping_dctlc">
                             <div class="bg_ping_dctlcc"><img src="litscloud/images/log_36.gif" /></div>
                          </div>
                          <div class="bg_ping_dctlm"></div>
                          <div class="bg_ping_dctld">IP数量：1 宽带总数：10<br />服务器配置：I3  Windows2003</div>
                       </div> 
                       <div class="bg_ping_dctr">
                           <div class="bg_ping_dctr_t">
                               <div class="bg_ping_dctr_tm">
                                  <div class="bg_ping_dctr_tml"><input name="pfxz" type="radio" value="很满意" /><img src="litscloud/images/log_29.gif" /></div>
                                  <div class="bg_ping_dctr_tmr"><div class="bg_ping_dctr_tmrh"><p></p>卖家<br />+1分</div></div>
                               </div>
                               
                               <div class="bg_ping_dctr_tm">
                                  <div class="bg_ping_dctr_tml"><input name="pfxz" type="radio" value="一般" /><img src="litscloud/images/log_30.gif" /></div>
                                  <div class="bg_ping_dctr_tmr"><div class="bg_ping_dctr_tmrb"><p></p>卖家<br />不加分</div></div>
                               </div>
                               
                               
                               <div class="bg_ping_dctr_tm">
                                  <div class="bg_ping_dctr_tml"><input name="pfxz" type="radio" value="很差" /><img src="litscloud/images/log_31.gif" /></div>
                                  <div class="bg_ping_dctr_tmr"><div class="bg_ping_dctr_tmrj"><p></p>卖家<br />-1分</div></div>
                               </div>
                               
                           </div>
                           <div class="bg_ping_dctr_c">请输入您的评价信息：</div>
                           <div class="bg_ping_dctr_m">
                             <textarea name="pl_pl" class="pl_pl"></textarea>
                           </div>
                           <div class="bg_ping_dctr_d">
                             <div class="bg_ping_dctr_dl"><a href="#">晒图片</a></div>
                             <div class="bg_ping_dctr_dc">可以晒五张</div>
                             <div class="bg_ping_dctr_dr"><input name="pl_gk" type="radio" value="公开评论" /><span>公开评论</span>
                               <input name="pl_gk" type="radio" value="匿名评论" />匿名评论</div>
                           </div>
                       </div>  
                     </div>                     
                     
                     <div class="bg_ping_dcd">
                        <div class="bg_ping_dcd_l">
                           <div class="bg_ping_dcd_ll"></div>
                           <div class="bg_ping_dcd_lc">店铺动态评分</div>
                           <div class="bg_ping_dcd_lr"></div>                         
                        </div>
                        <div class="bg_ping_dcd_r">
                          <div class="bg_ping_dcd_rt"> 
                           <div class="bg_ping_dcd_rtl">宝贝与描述相符</div>
                           <div class="bg_ping_dcd_rtc"><ul>
                             <li style="background-image:url(litscloud/images/log_40.gif);"></li>
                             <li style="background-image:url(litscloud/images/log_40.gif);"></li>
                             <li style="background-image:url(litscloud/images/log_40.gif);"></li>
                             <li style="background-image:url(litscloud/images/log_40.gif);"></li>
                             <li></li>
                           </ul></div>
                           <div class="bg_ping_dcd_rtr"><span>4分</span>-质量不错，与卖家描述基本一致，还是挺满意的</div>
                          </div>
                          <div class="bg_ping_dcd_rt"> 
                           <div class="bg_ping_dcd_rtl">卖家服务态度</div>
                           <div class="bg_ping_dcd_rtc"><ul>
                             <li style="background-image:url(litscloud/images/log_41.gif);"></li>
                             <li style="background-image:url(litscloud/images/log_41.gif);"></li>
                             <li></li>
                             <li></li>
                             <li></li>
                           </ul></div>
                           <div class="bg_ping_dcd_rtr"><span>2分</span>-卖家有点不赖烦，承诺的服务也兑现不了</div>
                          </div>
                          <div class="bg_ping_dcd_rt"> 
                           <div class="bg_ping_dcd_rtl">卖家的发货速度</div>
                           <div class="bg_ping_dcd_rtc"><ul>
                             <li></li>
                             <li></li>
                             <li></li>
                             <li></li>
                             <li></li>
                           </ul></div>
                           <div class="bg_ping_dcd_rtr">&nbsp;</div>
                          </div>
                          <div class="bg_ping_dcd_rt"> 
                           <div class="bg_ping_dcd_rtl">物流发货速度</div>
                           <div class="bg_ping_dcd_rtc"><ul>
                             <li></li>
                             <li></li>
                             <li></li>
                             <li></li>
                             <li></li>
                           </ul></div>
                           <div class="bg_ping_dcd_rtr">&nbsp;</div>
                          </div>  
                        </div>
                     </div>
                     
                     <div class="bg_ping_an"><a href="#">发表评论</a></div>
                 </div>
                 <div class="bg_ping_dd"></div>
              </div>
          </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
 <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
