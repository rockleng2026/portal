<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-CDN流媒体加速</title>
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
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 流媒体点播加速
      </div>
      <div class="ly_m_lmt">
      <div class="ly_m_jst">
        <div class="ly_m_jst_t">CDN流媒体加速</div>
        <div class="ly_m_jst_d"><ul>
          <li><a href="litscloud/tpl/lmtjs_db.jsp" style="background-image:url(litscloud/images/ly_108.jpg); background-repeat:no-repeat;"><span>流媒体<br />点播加速</span></a></li>
          <li><a href="litscloud/tpl/lmtjs_zb.jsp"><span>流媒体<br />直播加速</span></a></li>
        </ul></div>
      </div>
     <div class="ly_n_wjsm">
     <span>  流媒体点播加速</span>
    </div>
    <div class="ly_m_jsj">
        <div class="ly_m_jsj_t">标准点播加速</div>
        <div class="ly_m_jsj_d">  流媒体点播加速服务是将源站大量的流媒体内容（视频、声音和数据等）通过良好的链路传输到速网科技流媒体专用存储设备中，并通过速网科技CDN网络本身具有的协同性能，同步分发到位于各地的速网科技CDN小网络中的专用流媒体访问服务器上，这些服务器位于各省市主要运营商网络节点。速网科技CDN网络中智能网络分配技术将终端用户对网站的请求指向响应效果最好的流媒体服务节点上，通过这些流媒体服务节点，向用户提供稳定可靠的流媒体点播服务。
        </div>
    </div>
    
    <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">流媒体点播加速服务原理如下：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
    </div>
    <div class="y_m_jsl"><img src="litscloud/images/ly_110.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">客户群体：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><img src="litscloud/images/ly_111.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用流媒体点播加速前：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><p>目前众多流媒体网站为便于同意的服务与管理，都采用集中式的服务，即所有的服务器集中托管在一个数据中心内。网上视频点播会加大服务器的负载并会消耗巨大的带宽资源，同时对整个的网络传输环节也有很高的要求，在我国现有的网络环境中，访问量的快速增加会给流媒体服务器与网站的带宽带来巨大的压力，ICP向全国范围内的互联网用户提供视频点播服务事实上是相当困难的。 </p></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用流媒体点播加速后：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>  
      <div class="y_m_jsl"><p>将源站大量流媒体内容分发到速网科技各地专用流媒体访问服务器中，大大减少了原网上点播带给服务器的负载，节省了带宽资源，并有效的绕开了网络上的各个拥塞节点，带给用户高质量高效率的流媒体点播服务。 </p></div> 
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">产品特点：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="ly_m_jsd"><ul>
        <li>
           <div class="ly_m_jsd_lnt"><a href="#" style=" background-image:url(litscloud/images/ly_112.jpg); background-repeat:no-repeat; display:block; color:#fff;">1</a></div>
           <div class="ly_m_jsd_lnc">先进技术理念</div>
           <div class="ly_m_jsd_lnd"><p>
            智能网络分配技术将用户请求指向响应效果最佳的流媒体服务群；高速传输的流媒体缓存内容服务的实现，有效解决在线播放流断续不流畅的问题。</p></div>
        </li>
        <li style="margin-left:67px;">
           <div class="ly_m_jsd_lnt"><a href="#">2</a></div>
           <div class="ly_m_jsd_lnc">支持格式多样</div>
           <div class="ly_m_jsd_lnd"><p>
           系统支持Windows Media、Real Media、Apple QuickTime 等多种流媒体格式。</p></div>
        </li>
        <li style="margin-left:67px;">
           <div class="ly_m_jsd_lnt" style="width:245px;"><a href="#">3</a></div>
           <div class="ly_m_jsd_lnc" style="width:245px;">充足的带宽储备及存储空间</div>
           <div class="ly_m_jsd_lnd" style="width:245px;"><p style="text-align:center; width:225px;">
            提供用户满意的视听享受 。</p></div>
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
