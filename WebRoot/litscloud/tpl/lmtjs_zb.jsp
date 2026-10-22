<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-CDN流媒体加速_直播</title>
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
      <div class="ly_dhn" style="background-color:#fff;">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 流媒体直播加速
      </div>
      <div class="ly_m_lmt">
      <div class="ly_m_jst">
        <div class="ly_m_jst_t">CDN流媒体加速</div>
        <div class="ly_m_jst_d"><ul>
          <li><a href="litscloud/tpl/lmtjs_db.jsp" ><span>流媒体<br />点播加速</span></a></li>
          <li><a href="litscloud/tpl/lmtjs_zb.jsp" style="background-image:url(litscloud/images/ly_108.jpg); background-repeat:no-repeat;"><span>流媒体<br />直播加速</span></a></li>
        </ul></div>
      </div>
     <div class="ly_n_wjsm">
     <span>  流媒体直播加速</span>
    </div>
    <div class="ly_m_jsj">
       
        <div class="ly_m_jsj_d">流媒体直播加速服务，是将源站采用广播方式通过网络为用户提供实时采集的视频流通过良好的链路发布到速网科技CDN中心网络中，中心网络对直流再进行分层分发，每一路分发的流都通过完备的链路到达位于网络边缘的流媒体服务器机群中，通过流媒体服务器集群为终端用户提供稳定可靠的直播服务。
        </div>
    </div>
    
    <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">流媒体直播加速服务原理如下：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
    </div>
    <div class="y_m_jsl"><img src="litscloud/images/ly_114.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">客户群体：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><img src="litscloud/images/ly_115.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用流媒体点播加速前：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><p>直播是一种新兴的信息传播方法，及时快速的优点使他成为最热门的网络应用之一。直播的优点是可以带来大量用户访问，在眼球就是财富的今天无疑会带来可观的收入。但在获得巨大商机的同时，直播的性质也决定了在某个时段会有大量的集中访问，因此直播对网络和服务器都有非常高的要求，而现有的网络结构跨地域跨运营商的特点制约了其快速发展。而在非直播期间访问量几乎为零，这为运营商的投入成本提出新的疑问。 </p></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用流媒体点播加速后：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>  
      <div class="y_m_jsl"><p> 速网科技流媒体直播加速帮助网站向全国范围内的终端用户提供稳定的网络直播服务，通过速网科技CDN网络节点优化分配，将终端用户对网站的请求定向到离用户最近响应效果最好的流媒体服务节点上，这样无论用户来自哪里，都可以从性能最优的流媒体访问服务器集群中来获得高质量的流媒体内容，同时也不用担心大量用户访问带来的带宽压力。且按照实际流量收费，内容运营商不必再担忧非直播期间带来的成本压力。</p></div> 
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">产品特点：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="ly_m_jsd"><ul>
        <li>
           <div class="ly_m_jsd_lnt"><a href="#" style=" background-image:url(litscloud/images/ly_112.jpg); background-repeat:no-repeat; display:block; color:#fff;">1</a></div>
           <div class="ly_m_jsd_lnc">经济性</div>
           <div class="ly_m_jsd_lnd"><p>
            节省运营成本，无需投入建设高标准的系统及网络环境，依据流量收费不必顾虑非直播期间带来的成本压力 </p></div>
        </li>
        <li style="margin-left:67px;">
           <div class="ly_m_jsd_lnt"><a href="#">2</a></div>
           <div class="ly_m_jsd_lnc">可靠性</div>
           <div class="ly_m_jsd_lnd"><p>
           分层分发保证直播流的传输质量，最大程度减少传输环节对直播效果的影响</p></div>
        </li>
        <li style="margin-left:67px;">
           <div class="ly_m_jsd_lnt" style="width:245px;"><a href="#">3</a></div>
           <div class="ly_m_jsd_lnc" style="width:245px;">扩展性</div>
           <div class="ly_m_jsd_lnd" style="width:245px;"><p style="width:225px;">
            CDN流媒体集群的广泛分布充分体现扩展性优势，助力内容直播的空间范围。</p></div>
        </li>
     </ul></div>       
    </div>
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div> 
   </div>

<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
