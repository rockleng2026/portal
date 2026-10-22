<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-CDN网页加速_标准下载</title>
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
<div class="ly_body">
   <!------------------------------------------头部公用代码------------------------------------------------------------>
  <jsp:include page="/litscloud/tpl/top6.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

    <div class="ly_imiddle">
  
          <div class="ly_dh" style="height:4px; overflow:hidden;">          
      </div>
      <div class="ly_dhn" style="background-color:#fff;">
      当前位置：<a href="/litscloud/tpl/index.jsp">首页</a> > <a href="/litscloud/tpl/serve.jsp">云服务</a> > 标准下载加速
      </div>
      <div class="ly_m_lmt">
      <div class="ly_m_jst">
        <div class="ly_m_jst_t">CDN文件传输加速</div>
        <div class="ly_m_jst_d"><ul>
          <li><a href="litscloud/tpl/lmtjs_bjxz.jsp"  style="background-image:url(litscloud/images/ly_108.jpg); background-repeat:no-repeat;" ><span>标准下<br />载加速</span></a></li>
          <li><a href="litscloud/tpl/lmtjs_https.jsp" ><span>HTTPS<br />加速</span></a></li>
        </ul></div>
      </div>
     <div class="ly_n_wjsm">
     <span>  标准下载加速</span>
    </div>
    <div class="ly_m_jsj">
       
        <div class="ly_m_jsj_d">          随着互联网的升温，宽带的普及，网络游戏、视频电影、软件补丁等各种应用服务的快速发展，用户利用互联网下载所需文件已经成为一种习惯，在所有的下载方式中，http和Ftp的方式被我们认为是标准也是最为普及的下载方式。但在用户享受互联网提供的丰富内容的同时，内容提供商面临着高昂的服务器带宽运营成本、突发流量无法应对、终端用户下载速度不能保证、无准确全面的日志报表参考等一系列问题！"标准下载加速"服务是速网科技针对普及的http和Ftp的下载方式，利用先进的CDN内容分发网络和技术力量，为各内容提供商量身定制的网络下载加速解决方案。

        </div>
    </div>
    
    <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">标准下载加速服务原理如下：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
    </div>
    <div class="y_m_jsl"><img src="litscloud/images/ly_122.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">客户群体：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><img src="litscloud/images/ly_123.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">标准下载加速服务前:</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><p>    标准下载是网络应用中普遍但又很消耗网络资源的一种服务。在总带宽有限的情况下网站经常会由于下载服务抢占资源导致访问性能下降，而采取措施限制下载带宽，又会使用户的下载达不到理想的质量。</p></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">标准下载加速服务后：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>  
      <div class="y_m_jsl"><p> 用户端的文件下载由速网科技CDN网络边缘的服务器集群完成，大大减少了源站文件下载时的带宽压力。速网科技提供的充足带宽，可以让源站有新的软件版本发布，或更新包推出时无任何后顾之忧。</p></div>      
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">专业化的下载服务：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsfw"><ul>
      <li>专用的下载节点</li>
      <li>高速的下载能力</li> 
     </ul></div>
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">产品特点：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="ly_m_jsd"><ul>
        <li style="width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#" style=" background-image:url(litscloud/images/ly_112.jpg);  background-repeat:no-repeat; display:block; color:#fff;">1</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">先进技术</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
             采用优化的TCP技术完成，提高了文件的上传和内容分发速度的同时，有效的保证数据的安全稳定性；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt"  style="width:133px;"><a href="#">2</a></div>
           <div class="ly_m_jsd_lnc"  style="width:133px;">高速下载</div>
           <div class="ly_m_jsd_lnd"  style="width:133px;"><p  style="width:113px;">
           利用分布式CDN网的带宽优势，提供高速率的下载；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">3</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">各种下载工具</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            支持各种下载工具，如网际快车、网络蚂蚁等，并支持断点续传功能 ；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">4</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">系统分配下载</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            通过智能解析系统分配下载请求，支持各种客户端软件的在线升级；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">5</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">报表统计</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            提供带宽流量数据、节点流量比例、下载统计数据及日志下载服务，报表支持多种格式。</p></div>
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
