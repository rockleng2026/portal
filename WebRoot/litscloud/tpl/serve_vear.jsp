<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云服务</title>
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
<script type="text/javascript" src="litscloud/js/showdiv.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
</head>

<body>
<div class="ly_body" >
  <!------------------------------------------头部公用代码------------------------------------------------------------>
    <jsp:include page="/litscloud/tpl/top5.jsp"></jsp:include> 
    <!----------------------------------------------------------------内容开始------------------------------------------------------>
     
<div class="ly_wentis" style="margin-top:30px;">
     <div class="ly_wenti_q">
       <div class="ly_wenti_q_r">
              <div class="ly_wenti_q_rt">请在下面输入您的问题</div>
              <div class="ly_wenti_q_rc">
                <div class="ly_wenti_q_rcl"></div>
                <div class="ly_wenti_q_rcc">
                  <div class="ly_wenti_q_rccl"><input type="text" name="wenti_text" class="wenti_text" value="请用一句话简述您的问题，如：忘记密码怎么办？" /></div>
                  <div class="ly_wenti_q_rccr"><a href="#"><img src="litscloud/images/ly_27.gif" /></a></div>
                </div>
                <div class="ly_wenti_q_rcr"></div>
              </div>
         <div class="ly_wenti_q_rd"> 您还可以输入 <span>30</span> 字</div>
        </div>
        <div class="ly_wenti_q_l">
        <a href="#"><img src="litscloud/images/ly_30.gif" />   </a>
        </div>
       </div>
      </div> 
   <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>   
     </div>
          <div class="ly_dh">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > 云服务
      </div>
      <div class="ly_dhjs">
         <h1>适用于社区网站、企业官网、门户网站、电子商务网站、SAAS应用（如：在线ERP，CRM，OA，HR）、游戏类应用等</h1>
         <h2>云服务器基于立云自主研发的飞天大规模分布式计算系统，通过虚拟化技术整合IT资源，为各行业提供互联网基础设施服务。云服务器具有自助管理、数据安全保障、自动故障恢复和防网络攻击等高级功能，能够帮您简化开发部署过程，降低运维成本，构建按需扩展的网站架构，从而更适应互联网应用快速多变的特性。</h2>
               </div>
      
    <div class="ly_n_mbt">
       <div class="ly_n_mbtc" style="line-height:60px;">IDC</div>
    </div>  
    <div class="ly_n_idc"><ul>
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">服务器租用</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_54.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">服务器托管</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_58.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>
          
          
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">大带宽</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_59.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">云主机</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_60.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>
          
          
          <li>
            <div class="ly_n_idcl">
               <div class="ly_n_idcl_t">BGP(多线)+CDN</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_61.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>
              <!------------------------右边-------------------->  
              
               <div class="ly_n_idcl" style="float:right;">
               <div class="ly_n_idcl_t">机柜</div>
               <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
               <div class="ly_n_idcl_p"><img src="litscloud/images/ly_59.jpg" /></div>
               <div class="ly_n_idcl_c"><span>CPU :</span> 	Intel Pentium G620(双核,64位处理器)</div>
               <div class="ly_n_idcl_c"><span>内存 :</span> 	DDR3-1333 2G高速内存</div>
               <div class="ly_n_idcl_c"><p>SATA II 3.0Gb/s 7200RPM 配32MB<br />DataBurst高速缓存TM 容量高达320GB</p><span>硬盘 :</span> 	</div>              
               <div class="ly_n_idcl_c"><span>网卡 :</span> 	高性能网卡</div>
               <div class="ly_n_idcl_d">
                 <div class="ly_n_idcl_dl">
                   <div class="ly_n_idcl_dll"></div>
                   <div class="ly_n_idcl_dlc"><a href="#">马上订购</a></div>
                   <div class="ly_n_idcl_dlr"></div>
                 </div>
                 <div class="ly_n_idcl_dr"><span class="blue"><a href="javascript:spxq(1)">了解详情 >></a></span></div>
               </div>
            </div>  
              
          </li>  
      </ul>
    </div> 
     
     <!---------------------------CDN开始------------------------------>
       <div class="ly_n_mbt">
       <div class="ly_n_mbtc" style="line-height:60px;">CDN</div>
    </div>
     <div class="ly_n_cdn"><ul>
       <li>
         <div class="ly_n_cdn_l">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_62.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <div class="ly_n_cdn_lnrt">CDN网页加速</div>
                 <div class="ly_n_cdn_lnrc">互联网的访问速度取决于众多的因素，包括Internet网络传输质量、国内南北互通问题、网站服务器性能、网站出口带宽、网页程序架构和网页内容类型...</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="#"> >>静态内容加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="#"> >> 动态内容加速</a></span></div>
              </div>
            </div>
         </div>
         <!----------------------右边开始------------------------->
         
         <div class="ly_n_cdn_l" style="float:right;">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_63.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <div class="ly_n_cdn_lnrt">CDN流媒体加速</div>
                 <div class="ly_n_cdn_lnrc">随着宽带接入普及，电影、音乐、体育等媒体点播成为互联网上重要的应用，作为一种新的传媒方式。越来越多的媒体内容提供商通过网络来提供点播与直播服务，网民也可随时随地的通过互联网观看喜欢的内容，所有应用中对网络互联质量和实时性要求高...</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="#"> >>流媒体点播加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="#"> >>流媒体直播加速</a></span></div>
              </div>
            </div>
         </div>         
       </li>
       
       
         <li>
         <div class="ly_n_cdn_l">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_64.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <div class="ly_n_cdn_lnrt">CDN文件传输加速</div>
                 <div class="ly_n_cdn_lnrc">随着互联网业务的不断发展，文件的上传和下载成为互联网上重要的业务之一。网站经常需要让网民便捷的发布文件，同时对于网站发布的内容希望能够提供用户快速的下载...
</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="#"> >>标准下载加速</a></span><span class="blue" style="float:right; text-align:right;"><a href="#"> >>HTTPS加速</a></span></div>
              </div>
            </div>
         </div>
         <!----------------------右边开始------------------------->
         
         <div class="ly_n_cdn_l" style="float:right;">
            <div class="ly_n_idcl_x"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div>
            <div class="ly_n_cdn_ln">
              <div class="ly_n_cdn_lnl"><img src="litscloud/images/ly_65.jpg" /></div>
              <div class="ly_n_cdn_lnr">
                 <div class="ly_n_cdn_lnrt">CDN增值产品</div>
                 <div class="ly_n_cdn_lnrc">具有Internet技术的飞速发展，单纯靠提高单台服务器的性能已不能满足要求，网站开始采用大量的服务器来同时实现Web应用...
</div>
                 <div class="ly_n_cdn_lnrd"><span class="blue"><a href="#"> >>智能DNS服务</a></span><span class="blue" style="float:right; text-align:right;"><a href="#"> >>网页压缩产品</a></span></div>
              <div class="ly_n_cdn_lnrd"><span class="blue"><a href="#"> >>SLL加速产品</a></span><span class="blue" style="float:right; text-align:right;"><a href="#"> >>区域策略产品</a></span></div>   
              </div>
            </div>
         </div>         
       </li>
     
     </ul></div>
   </div>
   <div id="msc" class="msc" style="display: none">

</div>
<div id="jgc" class="jgc" style="display: none">
<div class="zf_xy">
   <div class="zf_xyt"><span><a href="#">关闭</a></span>确认订单</div>
   <div class="zf_xyc"> 
      <div class="zf_gm">
         <div class="zf_gmt">
           <div class="zf_gmt_t">
              <div class="zf_gmt_tq">配置</div>
              <div class="zf_gmt_tw"><select name="fw_lx" style="margin:5px auto;">
                <option value="1">电信</option>
                <option value="2">网通</option>
                <option value="3">移动</option>
             </select></div>
              <div class="zf_gmt_te"><select name="fw_sc" style="margin:5px auto;">
                <option value="1">时长</option>
                <option value="2">年</option>
                <option value="3">月</option>
                <option value="4">日</option>
             </select></div>
              <div class="zf_gmt_tr"><select name="fw_lx" style="margin:5px auto;">
                <option value="1">数量</option>
                <option value="2">1</option>
                <option value="3">2</option>
             </select><strong></strong></div>
              <div class="zf_gmt_tt">价格</div>
           </div>

           <div class="zf_gmt_c">
               <div class="zf_gmt_cq">
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">:</div>
                    <div class="zf_gmt_cqtr">至强5520</div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">内存:</div>
                    <div class="zf_gmt_cqtr">8G</div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">硬盘:</div>
                    <div class="zf_gmt_cqtr">256G</div>
                  </div>
                   <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">操作系统:</div>
                    <div class="zf_gmt_cqtr">windows linux </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">带宽:</div>
                    <div class="zf_gmt_cqtr">百M独享（99%可用） </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">IP地址:</div>
                    <div class="zf_gmt_cqtr"> 一个免费IP   </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">机房:</div>
                    <div class="zf_gmt_cqtr"> 广东电信，山东联通     </div>
                  </div>
                  <div class="zf_gmt_cqt">
                    <div class="zf_gmt_cqtl">网卡:</div>
                    <div class="zf_gmt_cqtr"> 双千兆网卡     </div>
                  </div>    
               </div>
               <div class="zf_gmt_cw">电信</div>
               <div class="zf_gmt_ce">1年</div>
               <div class="zf_gmt_cr">1</div>
               <div class="zf_gmt_ct">19999元</div>
           </div>
           <div class="zf_gmt_d">总费用：<span>19999</span>元</div>
         </div>
         <div class="zf_gmd">
           <div class="zf_gmdl"><a href="#">确 &nbsp; 认</a></div>
           <div class="zf_gmdr"><a href="#">取 &nbsp; 消</a></div>
         </div>
      </div>
   </div>
   <div class="zf_xyd"></div>
</div>
</div>

<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
