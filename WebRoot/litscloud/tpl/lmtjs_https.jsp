<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-CDN网页加速_HTTPS</title>
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
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > HTTPS加速
      </div>
      <div class="ly_m_lmt">
      <div class="ly_m_jst">
        <div class="ly_m_jst_t">CDN文件传输加速</div>
        <div class="ly_m_jst_d"><ul>
          <li><a href="litscloud/tpl/lmtjs_bjxz.jsp"  ><span>标准下<br />载加速</span></a></li>
          <li><a href="litscloud/tpl/lmtjs_https.jsp"  style="background-image:url(litscloud/images/ly_108.jpg); background-repeat:no-repeat;"><span>HTTPS<br />加速</span></a></li>
        </ul></div>
      </div>
     <div class="ly_n_wjsm">
     <span>  HTTPS加速</span>
    </div>
    <div class="ly_m_jsj">
       
        <div class="ly_m_jsj_d">      HTTPS是超文本传输协议和SSL/TLS的组合，是安全的HTTP加速，但由于SSL加密算法和密码会造成服务器CPU资源瓶颈，降低服务器性能。使用PowerCDN的HTTPS加速可解决这一问题，通过专用的加密、解密设备，在各个PowerCDN节点上提供加速服务，然后对用户请求的内容进行加密后再请求最近的节点，此时节点会根据专门的私钥将用户请求的内容进行解密，减轻源服务器的认证压力，最终返回给终端用户，HTTPS加速不仅为用户提供了良好的访问过程，同时也保障了数据的安全性。  
 
        </div>
    </div>
    
    <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">HTTPS加速服务原理如下：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
    </div>
    <div class="y_m_jsl"><img src="litscloud/images/ly_120.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">客户群体：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><img src="litscloud/images/ly_121.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">HTTPS加速服务前:</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><p style="text-indent:0px;"> 1、网站的信息服务覆盖广、浏览量大，用户分散，网站源服务器得不到理想的响应速度。<br />
2、面对流量突发情况时，网站很容易成为黑客攻击的目标，网站安全面临威胁。<br />
3、分布在机房的源服务器，如果部分服务器出现故障时，有些用户的请求无法正常响应。</p></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">HTTPS加速服务后：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>  
      <div class="y_m_jsl"><p style="text-indent:0px;">1、通过网络负载均衡技术，将用户的请求定向到最近的节点，让用户实现就近访问。<br />
2、用户请求的过程是加密的，然后节点会用过专用的私钥解密返回给用户，网站的安全得到保障。<br />
3、节点和服务器之间的智能故障转移策略，能有效避免因服务器故障造成网站无法响应的情况发生。</p></div> 
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">产品特点：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="ly_m_jsd"><ul>
        <li style="width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#" style=" background-image:url(litscloud/images/ly_112.jpg); background-repeat:no-repeat; display:block; color:#fff;">1</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">安全</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            请求过程是加密的，保证数据的安全性；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt"  style="width:133px;"><a href="#">2</a></div>
           <div class="ly_m_jsd_lnc"  style="width:133px;">便捷</div>
           <div class="ly_m_jsd_lnd"  style="width:133px;"><p  style="width:113px;">
           加速过程对于客户端和服务器都是完全透明的，可自定义CDN缓存规则；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">3</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">高效</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            遍布全国的高质量节点，专用的加密、解密加速设备，降低源站认证压力；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">4</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">稳定</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            自备健康检查功能，发现故障能智能定向到健康安全的节点；</p></div>
        </li>
        <li style="margin-left:50px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">5</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">快速</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            采用SSD固态硬盘存，比其他硬盘的性能稳定，请求速度快。</p></div>
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
