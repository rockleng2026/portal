<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云主机</title>
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
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 云主机
      </div>            
      
     <div class="ly_m_bgp">
       <div class="ly_m_bgp_t"></div>
       <div class="ly_m_bgp_c">
      
       <div class="ly_m_bgp_cu"></div>
       <a href="litscloud/tpl/rent_deploy.jsp"><div class="ly_m_bgp_cv"><p></p><span>自定义<br />配置</span></div></a> 
          <div class="ly_m_bgp_ct"><img src="litscloud/images/ly_91.jpg" style="margin-top:15px;" /> 云主机热门机型推荐</div>          
          <div class="ly_m_zjt"><ul>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">入门级</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp" style="background-image:url(litscloud/images/ly_161.jpg);
                 background-repeat:no-repeat; color:#fff; display:block;">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">经济A型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">经济B型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">标准A型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">标准B型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">标准C型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">标准D型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
            <li>
              <div class="ly_m_zjt_l"></div>
              <div class="ly_m_zjt_c">标准E型</div>
              <div class="ly_m_zjt_m">CPU:1核     内存：512M   数据盘：0G   带宽：1M</div>
              <div class="ly_m_zjt_a">
                 <div class="ly_m_zjt_al"><a href="litscloud/tpl/rent_deploy.jsp">69元/月</a></div>
                 <div class="ly_m_zjt_ar"><a href="litscloud/tpl/rent_vear.jsp">详情</a></div>
              </div>
              <div class="ly_m_zjt_r"></div>
            </li>
          </ul></div>
       </div>
       <div class="ly_m_bgp_d"></div>
     </div> 
     
     <div class="ly_n_mbt" style="margin-top:20px;">
       <div class="ly_n_mbtc">温馨<br />提示</div>
    </div>
    <div class="ly_m_wxts">
       <div class="ly_m_wxts_q">
          <div class="ly_m_wxts_qt"><span>1、</span>万网用户可直接用万网账户登录阿里云官网选购云服务器，但目前万网资金账号暂时不能与阿里云互通，
您在购买阿里云云服务器时，需要在阿里云进行充值，然后才能进行购买。</div>
          <div class="ly_m_wxts_qd"> <div class="ly_m_wxts_qdt"><a href="#">如何充值</a></div> </div>
          <div class="ly_m_wxts_qt"><span>2、</span>您在购买阿里云云服务器后，可直接通过阿里云用户中心管理您的云服务器，路径为：阿里云－》用户
中心－》管理控制台</div>
          <div class="ly_m_wxts_qd"> <div class="ly_m_wxts_qdt"><a href="#">云服务管理更多内容</a></div> </div>  
       </div>
    </div>
    
    <div class="ly_m_dys">
       <div class="ly_m_dys_t">云主机的四大优势</div>
       <div class="ly_m_dys_d"><ul>
        <li>
          <dl><img src="litscloud/images/ly_167.gif" /> </dl>
          <dt>安全稳定，数据可靠</dt>
          <dd>故障自动迁移，数据多重副本，有效低御各种网络攻击，免费提供端口、漏洞、挂马等扫描服务。</dd>
        </li>
        <li>
          <dl><img src="litscloud/images/ly_168.gif" /> </dl>
          <dt>BGP独享带宽，高速访问</dt>
          <dd>BGP多线独享带宽，可按天扩容，按需付费，超高性价比，让您的网站访问速度"飞"起来。</dd>
        </li>
        <li>
          <dl><img src="litscloud/images/ly_169.gif" /> </dl>
          <dt>简单易用，弹性伸缩</dt>
          <dd>从创建到运行只需数分钟，快速部署，拥有完整管理权限，高度弹性，可自助快速增减弹性资源。</dd>
        </li>
        <li>
          <dl><img src="litscloud/images/ly_170.gif" /> </dl>
          <dt>按需购买，节约成本</dt>
          <dd>支持多种主流操作系统，自主安装软件，自定义配置资源，按需付费，投入成本核算降低30%-80%。</dd>
        </li>
       </ul></div>
    </div>
        
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
