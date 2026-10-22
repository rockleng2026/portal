<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云主机自定义配置</title>
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

   <div class="ly_imiddle" >
          <div class="ly_dh" style="height:4px; overflow:hidden;">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 云主机自定义配置
      </div>        
        
      <div class="ly_m_jbt" style="margin-bottom:30px;"><span>云主机自定义配置</span></div>
    <div class="ly_m_jszc">
   <div class="ly_m_jbtu"><ul>
       <li style="background-image:url(litscloud/images/ly_192.gif);"><img src="litscloud/images/zh_15.gif" /> 蚌埠电信</li>
       <li><img src="litscloud/images/zh_15.gif" />天长电信</li>
       <li><img src="litscloud/images/zh_16.gif" />铜陵联通</li>
       <li><img src="litscloud/images/zh_17.gif" />天长双线</li>
       <li><img src="litscloud/images/zh_20.gif" />香港新世界</li>
       <li><img src="litscloud/images/zh_18.gif" />韩国服务器</li>
       <li><img src="litscloud/images/zh_19.gif" />美国服务器</li>
       <li style="width:130px; background-image:none; float:right;"><span class="blue"><a href="#">教我DIY</a> | <A href="#">购买须知</A></span></li>
     </ul></div>   
      <div class="ly_m_jszc_t"></div>
        <div class="ly_m_jsq">
           <div class="ly_m_zjq">
              <div class="ly_m_zjq_t">
                <div class="ly_m_zjq_tl">
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">CPU：</div>
                      <div class="ly_m_zjq_tl_cpu_r"><ul>
                        <li><a href="#" style="background-image:url(litscloud/images/ly_197.gif); color:#fff;">1核</a></li>
                        <li><a href="#">2核</a></li>
                        <li><a href="#">4核</a></li>
                        <li><a href="#">8核</a></li>
                        <li style="width:125px; background-image:none;"><span>Xeon 2.26GHz</span></li>
                      </ul></div>
                    </div>
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">内存：</div>
                      <div class="ly_m_zjq_tl_cpu_r"><ul>
                        <li><a href="#" style="background-image:url(litscloud/images/ly_197.gif); color:#fff;">512MB</a></li>
                        <li><a href="#">1GB</a></li>
                        <li><a href="#">1.5GB</a></li>
                        <li><a href="#">2GB</a></li>
                        <li><a href="#">4GB</a></li>
                      </ul></div>
                    </div>
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">硬盘：</div>
                      <div class="ly_m_zjq_tl_cpu_r">免费赠送（linux送20GB，Windows送40GB）</div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_sjp">
                        <div class="ly_m_zjq_tl_sjp_l">数据盘：</div>
                        <div class="ly_m_zjq_tl_sjp_c">
                          <div class="ly_m_zjq_tl_sjp_ct"><img src="litscloud/images/ly_200.gif" /></div>
                          <div class="ly_m_zjq_tl_sjp_cd">当前选择：0GB(以10GB为步长增加)</div> 
                        </div>
                        <div class="ly_m_zjq_tl_sjp_r"><span>0</span>&nbsp; GB</div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_sjp">
                        <div class="ly_m_zjq_tl_sjp_l">带宽：</div>
                        <div class="ly_m_zjq_tl_sjp_c">
                          <div class="ly_m_zjq_tl_sjp_ct"><img src="litscloud/images/ly_199.gif" /></div>
                          <div class="ly_m_zjq_tl_sjp_cd">当前选择：1Mbps(以1Mbps为步长增加)</div> 
                        </div>
                        <div class="ly_m_zjq_tl_sjp_r"><span>1</span>&nbsp; Mbps</div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_qy">
                       <div class="ly_m_zjq_tl_qy_l">区域：</div>
                       <div class="ly_m_zjq_tl_qy_r"><select name="ly_qy" class="ly_qy">
                         <option value="1">华东青岛</option>
                         <option value="2">华西四川</option>
                         <option value="3">华南湖南</option>
                       </select>&nbsp;<a href="#">查看我的产品区域</a>不同区域之间内网不互通，请查看<a href="#">区域选择帮助</a></div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_qy">
                       <div class="ly_m_zjq_tl_qy_l">操作系统：</div>
                       <div class="ly_m_zjq_tl_qy_r"><select name="ly_qy" class="ly_qy" style="width:505px;">
                         <option value="1">Windows 标准版</option>
                         <option value="2">Windows7 标准版</option>
                         <option value="3">Windows8 标准版</option>
                       </select>&nbsp;<a href="#">教我选择</a><br />若您选择Windows（标准版），报价中已包含正版激活费用.</div>
                    </div>
                    
                </div>
                <div class="ly_m_zjq_tr">
                   <div class="ly_m_zjq_trt">您选择的云主机</div>
                   <div class="ly_m_zjq_trc">
                     <div class="ly_m_zjq_trc_t">您还没有选择任何服务器哦！</div>
                     <div class="ly_m_zjq_trc_m">您共选择了<span>0</span>台服务！</div>
                     <div class="ly_m_zjq_trc_c">总费用：<span>0</span>	元</div>
                     <div class="ly_m_zjq_trc_u">确认订单</div>
                     <div class="ly_m_zjq_trc_d"><input name="fwxy" class="ly_fwxy"  type="checkbox" value="" checked="checked" /> 《立云服务协议》</div>
                   </div>
                   <div class="ly_m_zjq_trd"></div>
                </div>
              </div>
              <div class="ly_m_zjq_c">
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">购买数量：</div>
                     <div class="ly_m_msl_r"><select name="ly_msl" class="ly_msl" style="width:90px;">
                         <option value="1">1</option>
                         <option value="2">2</option>
                         <option value="3">3</option>
                         <option value="3">4</option>
                         <option value="3">5</option>
                       </select></div>
                   </div>
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">购买时长：</div>
                     <div class="ly_m_msl_r"><select name="ly_an" class="ly_an" style="width:90px;">
                         <option value="1">按年</option>
                         <option value="2">按月</option>
                         <option value="3">按日</option>
                         <option value="3">按时</option>
                         <option value="3">按分</option>
                       </select>
                       <select name="ly_year" class="ly_year" style="width:90px;">
                         <option value="1">1年</option>
                         <option value="2">2年</option>
                         <option value="3">3年</option>
                         <option value="3">4年</option>
                         <option value="3">5年</option>
                       </select>
                       </div>
                   </div>
              </div>
              <div class="ly_m_zjq_d">
               <div class="ly_m_msl">
                     <div class="ly_m_msl_l">费用：</div>
                     <div class="ly_m_msl_r"><span>690</span> &nbsp;元 （根据您的配置，自动报价） </div>
                   </div>
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">&nbsp;</div>
                     <div class="ly_m_msl_r"><div class="ly_m_msl_rt"><a href="#">提  交</a></div></div>
                   </div>
              </div>
           </div>
        </div>
    </div>     
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>   
     <div class="ly_m_jbt"><span>机房实景图片</span></div>
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div>
       <div class="ly_m_jft_d"><ul>
         <li><img src="litscloud/images/xl_07.gif" /></li>
         <li><img src="litscloud/images/xl_08.gif" /></li>
         <li><img src="litscloud/images/xl_09.gif" /></li>
         <li><img src="litscloud/images/xl_10.gif" /></li>
       </ul></div>
    </div>
    <div class="ly_n_weibu" style="margin-bottom:50px;" ></div>
    
    <div class="ly_yundun">
        <div class="ly_yundun_q">
            <div class="ly_yundun_ql">
                <div class="ly_yundun_qlt"><img src="litscloud/tpl/images/ly_203.gif" /></div>
                <div class="ly_yundun_qld">云盾安全</div>
     
            </div>
            <div class="ly_yundun_qr">
              <div class="ly_yundun_qrt">
                <span>免费开通云盾服务</span><span style="font-size:14px;">(完成订购后，可登录云盾控制台进行启用、关停、配置更新等详细操作)</span><br />
                云盾是为云主机用户提供的安全增值服务，拥有云主机的用户都可获得全面的安全保障。云盾包含安全体检和安全管家两类服务，分别提供网站安全检查和一站式安全管家服务。
              </div>
              <div class="ly_yundun_qrd">
                <div class="ly_yundun_qrdl"><input name="ktfu" type="checkbox" value="" checked="checked" /> 开通安全管家服务 <a href="#"><img src="litscloud/tpl/images/ly_204.gif"  /></a></div>
                <div class="ly_yundun_qrdl"><input name="ktfu" type="checkbox" value="" checked="checked" /> 开通安全体验服务 <a href="#"><img src="litscloud/tpl/images/ly_204.gif" /></a></div> 
              </div>
            </div>
        </div>
    </div>
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
