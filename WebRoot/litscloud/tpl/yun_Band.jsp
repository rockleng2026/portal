<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-大宽带</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="litscloud/css/main.css" />
<script type="text/javascript" src="litscloud/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="litscloud/js/slides.jquery.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">

</script>
</head>

<body>
<div class="ly_body" >
  <!------------------------------------------头部公用代码------------------------------------------------------------>
    <jsp:include page="/litscloud/tpl/top6.jsp"></jsp:include> 
    <!----------------------------------------------------------------内容开始------------------------------------------------------>
<div class="ly_imiddle">
     <div class="ly_dh" style="height:4px; overflow:hidden;">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp" target="_parent">首页</a> > <a href="litscloud/tpl/serve.jsp" target="_parent">云服务</a> > 服务器托管
      </div>  
     <div class="ly_band">
        <div class="ly_band_m"><ul>
          <li><a href="#" style="background-image:url(litscloud/images/ly_221.gif); background-repeat:no-repeat; color:#000;">BGP多线机房带宽</a></li>
          <li><a href="#">双线VIP机房带宽</a></li>
          <li><a href="#">电信机房带宽</a></li>
          <li><a href="#"> 联通机房带宽</a></li>   
        </ul></div>
        <div class="ly_band_t"></div>
        <div class="ly_band_c">
            <div class="ly_band_ct">
              <div class="ly_band_ctl"></div>
              <div class="ly_band_ctr"></div>
            </div>
            <div class="ly_band_cd">
               <div class="ly_band_cdt">
                 <div class="ly_band_cdt_l">
                    <div class="ly_band_cdt_lt"></div>
                    <div class="ly_band_cdt_lc">
                      <div class="ly_band_cdt_lct"><img src="litscloud/images/ly_229.jpg" /></div>
                      <div class="ly_band_cdt_lcd">等级：<span>★★★★★</span></div>
                    </div>
                    <div class="ly_band_cdt_ld"></div>
                 </div>
                 <div class="ly_band_cdt_r">
                   <div class="ly_band_cdt_rt">深圳BGP多线机房大带宽</div>
                   <div class="ly_band_cdt_rc">BGP多线云数据中心完全按照国家四星级数据中心标准建造，是中原地区唯一一个云计算BGP多线数据中心，能提供云服务及云部署，适合面向全国范围的电子商务网站、大型门户网站、官方游戏等高端应用，并适合下载、视频音乐等大带宽用户。</div>
                   <div class="ly_band_cdt_rm">典型客户：丹尼斯、酷讯网等</div>
                   <div class="ly_band_cdt_rd"><a href="litscloud/tpl/Band_vew.jsp"><img src="litscloud/images/ly_230.jpg" /></a></div>
                 </div>
               </div>
               <div class="ly_band_cdd">
                  <div class="ly_band_cdd_t"></div>
                  <div class="ly_band_cdd_c">
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">带宽</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1">5M</li>
                          <li class="ly_m2">10M</li>
                          <li class="ly_m3">50M</li>
                          <li class="ly_m4">100M</li>
                          <li class="ly_m5">1G</li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl">月付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>499元</span></li>
                          <li class="ly_m2"><span>1100元</span></li>
                          <li class="ly_m3"><span>6300元</span></li>
                          <li class="ly_m4"><span>13000元</span></li>
                          <li class="ly_m5"><span>130000元</span></li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">年付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>4999元</span></li>
                          <li class="ly_m2"><span>11000元</span></li>
                          <li class="ly_m3"><span>63000元</span></li>
                          <li class="ly_m4"><span>130000元</span></li>
                          <li class="ly_m5"><span>1300000元</span></li>
                        </ul></div>
                     </div>
                       <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl" style="border-bottom:none; height:43px;">赠送</div>
                        <div class="ly_band_cdd_ckr">送1U 托管机位</div>
                     </div>
                     
                  </div>
  
                  
                  <div class="ly_band_cdd_d"></div>
               </div>
            </div>
        </div>
        <div class="ly_band_c">
            <div class="ly_band_ct">
              <div class="ly_band_ctl"></div>
              <div class="ly_band_ctr"></div>
            </div>
            <div class="ly_band_cd">
               <div class="ly_band_cdt">
                 <div class="ly_band_cdt_l">
                    <div class="ly_band_cdt_lt"></div>
                    <div class="ly_band_cdt_lc">
                      <div class="ly_band_cdt_lct"><img src="litscloud/images/ly_229.jpg" /></div>
                      <div class="ly_band_cdt_lcd">等级：<span>★★★★★</span></div>
                    </div>
                    <div class="ly_band_cdt_ld"></div>
                 </div>
                 <div class="ly_band_cdt_r">
                   <div class="ly_band_cdt_rt">深圳洋桥大带宽</div>
                   <div class="ly_band_cdt_rc">四星级数据中心，拥有国内最大的互联网络基础设施，直接接入北京电信兆维国干网、北京电信静安中心国干网，冗余带宽充足，易于扩展，适合面向全国范围的电子商务网站、大型门户网站、官方游戏、政府企业网站、公司内部办公系统、金融等重要单位的灾备服务等高端应用，典型客户像：亿恩科技官网、当当网、优酷、千橡国际、cctv、搜狐、网易等。</div>
                   <div class="ly_band_cdt_rm">典型客户：亿恩科技官网、当当网、优酷、千橡国际、cctv、搜狐、网易等</div>
                   <div class="ly_band_cdt_rd"><a href="litscloud/tpl/Band_vew.jsp"><img src="litscloud/images/ly_230.jpg" /></a></div>
                 </div>
               </div>
               <div class="ly_band_cdd">
                  <div class="ly_band_cdd_t"></div>
                  <div class="ly_band_cdd_c">
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">带宽</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1">5M</li>
                          <li class="ly_m2">10M</li>
                          <li class="ly_m3">50M</li>
                          <li class="ly_m4">100M</li>
                          <li class="ly_m5">1G</li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl">月付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>499元</span></li>
                          <li class="ly_m2"><span>1100元</span></li>
                          <li class="ly_m3"><span>6300元</span></li>
                          <li class="ly_m4"><span>13000元</span></li>
                          <li class="ly_m5"><span>130000元</span></li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">年付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>4999元</span></li>
                          <li class="ly_m2"><span>11000元</span></li>
                          <li class="ly_m3"><span>63000元</span></li>
                          <li class="ly_m4"><span>130000元</span></li>
                          <li class="ly_m5"><span>1300000元</span></li>
                        </ul></div>
                     </div>
                       <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl" style="border-bottom:none; height:43px;">赠送</div>
                        <div class="ly_band_cdd_ckr">送1U 托管机位</div>
                     </div>
                     
                  </div>
  
                  
                  <div class="ly_band_cdd_d"></div>
               </div>
            </div>
        </div>
        <div class="ly_band_c">
            <div class="ly_band_ct">
              <div class="ly_band_ctl"></div>
              <div class="ly_band_ctr"></div>
            </div>
            <div class="ly_band_cd">
               <div class="ly_band_cdt">
                 <div class="ly_band_cdt_l">
                    <div class="ly_band_cdt_lt"></div>
                    <div class="ly_band_cdt_lc">
                      <div class="ly_band_cdt_lct"><img src="litscloud/images/ly_229.jpg" /></div>
                      <div class="ly_band_cdt_lcd">等级：<span>★★★★★</span></div>
                    </div>
                    <div class="ly_band_cdt_ld"></div>
                 </div>
                 <div class="ly_band_cdt_r">
                   <div class="ly_band_cdt_rt">深圳兆维大带宽</div>
                   <div class="ly_band_cdt_rc">五星级数据中心，国际出口在北京是最好的数据中心，是国家金融和证券类的指定灾备中心,目前全国仅此一个，出口为几百G的带宽为您提供可靠带宽保障，兆维数据中心为各大门户的主节点机房。</div>
                   <div class="ly_band_cdt_rm">典型客户：百度，新浪，博客中国，微软，盛大，九城，谷歌等</div>
                   <div class="ly_band_cdt_rd"><a href="litscloud/tpl/Band_vew.jsp"><img src="litscloud/images/ly_230.jpg" /></a></div>
                 </div>
               </div>
               <div class="ly_band_cdd">
                  <div class="ly_band_cdd_t"></div>
                  <div class="ly_band_cdd_c">
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">带宽</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1">5M</li>
                          <li class="ly_m2">10M</li>
                          <li class="ly_m3">50M</li>
                          <li class="ly_m4">100M</li>
                          <li class="ly_m5">1G</li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl">月付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>499元</span></li>
                          <li class="ly_m2"><span>1100元</span></li>
                          <li class="ly_m3"><span>6300元</span></li>
                          <li class="ly_m4"><span>13000元</span></li>
                          <li class="ly_m5"><span>130000元</span></li>
                        </ul></div>
                     </div>
                     <div class="ly_band_cdd_ck" style="background-color:#e6eef7;">
                        <div class="ly_band_cdd_ckl">年付</div>
                        <div class="ly_band_cdd_ckr"><ul>
                          <li class="ly_m1"><span>4999元</span></li>
                          <li class="ly_m2"><span>11000元</span></li>
                          <li class="ly_m3"><span>63000元</span></li>
                          <li class="ly_m4"><span>130000元</span></li>
                          <li class="ly_m5"><span>1300000元</span></li>
                        </ul></div>
                     </div>
                       <div class="ly_band_cdd_ck">
                        <div class="ly_band_cdd_ckl" style="border-bottom:none; height:43px;">赠送</div>
                        <div class="ly_band_cdd_ckr">送1U 托管机位</div>
                     </div>                    
                  </div>
                  <div class="ly_band_cdd_d"></div>
               </div>
            </div>
        </div>
        
        <div class="ly_band_d"></div>
     </div>
      
    <div class="ly_band"  style="margin-bottom:50px;">
        <div class="ly_band_m"><ul>
          <li><a href="#" style="background-image:url(litscloud/images/ly_221.gif); background-repeat:no-repeat; color:#000;">为什么选择我们</a></li>
          <li><a href="#">售前答疑</a></li>
          <li><a href="#">风险提示</a></li>
          <li><a href="#">  客户评价</a></li>   
        </ul></div>
        <div class="ly_band_t"></div>
        <div class="ly_band_u">
           <div class="ly_band_ul">
             <div class="ly_band_ull"><img src="litscloud/images/ly_231.jpg" /></div>
             <div class="ly_band_ulr">
               <div class="ly_band_ulr_t">可靠</div>
               <div class="ly_band_ulr_d"><span>资质规范：</span>国内最早提供服务器租用托管应用的服务商之一，资质齐全，流程规范！做行业内经得起考验的企业！ </div>
               <div class="ly_band_ulr_d"><span>流程规范：</span>各项业务流程标准化、制度化、简单化、流程清晰、全程管控，让您用起来更放心！</div>
             </div> 
           </div>
           
           <div class="ly_band_ul">
             <div class="ly_band_ull"><img src="litscloud/images/ly_232.jpg" /></div>
             <div class="ly_band_ulr">
               <div class="ly_band_ulr_t">快捷</div>
               <div class="ly_band_ulr_d"><span>速度快：</span>所有服务器均放在国家A类、五星、四星级数据中心，覆盖境内境外，保证访问速度！  </div>
               <div class="ly_band_ulr_d"><span>响应快：</span>7*24小时全天候电话、QQ、线上人工客服+客户答疑系统，任何问题都能在第一间响应！</div>
             </div> 
           </div>
           
           
           <div class="ly_band_ul">
             <div class="ly_band_ull"><img src="litscloud/images/ly_234.jpg" /></div>
             <div class="ly_band_ulr">
               <div class="ly_band_ulr_t">放心</div>
               <div class="ly_band_ulr_d"><span>实时服务：</span>300人专业服务管理团队，14年服务经验，服务更专业、更专心、更专注！ </div>
               <div class="ly_band_ulr_d"><span>免费试用：</span>服务器产品可以提供全方位测试服务，免费提供基础技术支持，满意再付款，有保障，更放心！</div>
             </div> 
           </div>
           
           
           
           <div class="ly_band_ul">
             <div class="ly_band_ull"><img src="litscloud/images/ly_233.jpg" /></div>
             <div class="ly_band_ulr">
               <div class="ly_band_ulr_t">贴心</div>
               <div class="ly_band_ulr_d"><span>应客户所需：</span>全面分析客户需求，为各类门户网站、电子商务网站、企业网站等量身定做网络解决方案，实现高效运营！ </div>
               <div class="ly_band_ulr_d"><span>想客户所想：</span>为中小企业、个人提供服务器维护、安全加固，保证服务器的安全稳定运行！</div>
             </div> 
           </div>          
           
        </div>
       <div class="ly_band_d"></div>
     </div>
    
   </div>

<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
