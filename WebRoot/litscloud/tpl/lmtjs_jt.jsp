<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-CDN网页加速_静态</title>
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
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 静态页面加速
      </div>
      <div class="ly_m_lmt">
      <div class="ly_m_jst">
        <div class="ly_m_jst_t">CDN网页加速</div>
        <div class="ly_m_jst_d"><ul>
          <li><a href="litscloud/tpl/lmtjs_dt.jsp"  ><span>动态页<br />面加速</span></a></li>
          <li><a href="litscloud/tpl/lmtjs_jt.jsp"  style="background-image:url(litscloud/images/ly_108.jpg); background-repeat:no-repeat;"><span>静态页<br />面加速</span></a></li>
        </ul></div>
      </div>
     <div class="ly_n_wjsm">
     <span>  静态页面加速</span>
    </div>
    <div class="ly_m_jsj">
       
        <div class="ly_m_jsj_d">      静态页面加速服务是指 -CDN网络和客户源文件服务器形成良好的互动，即将源站的网页内容：html文件、flash动画、及各种文件类型的图片缓存于速网科技-CDN中心网络中，这些文件的特点在于更新的频率较低，用缓存技术将文件cache在速网科技CDN的边缘节点上，即可满足终端用户就近访问的需求。文件可以通过定期和不定期的方式在CDN节点上进行更新：定期更新时CDN中心网络主动更新源站数据，再通过智能解析系统将内容进行优化分配到各CDN网络节点；不定期更新可以通过速网科技后台管理系统进行主动推送完成。<br />
    
  &nbsp;&nbsp;&nbsp;&nbsp;   静态页面加速服务是速网科技CDN服务的基本应用，也是使用最为广泛的服务，对各种静态内容，采用速网科技CDN静态加速产品可以达到很好的加速效果。
 
        </div>
    </div>
    
    <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">静态页面加速服务原理如下：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
    </div>
    <div class="y_m_jsl"><img src="litscloud/images/ly_118.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">客户群体：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><img src="litscloud/images/ly_119.jpg" /></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用静态页面加速服务前：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="y_m_jsl"><p> 内容集中放置的管理方式，虽方便对网站的管理与维护，但互联网的终端用户分布于不同的地区和网络内，分散的用户访问受到互联网复杂 的网络状况的影响，访问效果得不到保证；用户的集中访问特别是网站推广活动等引起的突发流量，造成源站负载的访问压力过大，带宽使用紧张；站点安全得不到保障，若被黑客攻击会影响用户访问，甚至会中断网站的服务，给网站造成巨大经济损失</p></div>
     <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">使用静态页面加速服务后：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>  
      <div class="y_m_jsl"><p>速网科技CDN中心网络边缘的各CDN节点不仅满足了客户内容良好的扩展，减少访问压力；而且实现了用户的就近访问，提供了更好的访问质量，在目前中国互联互通的难题下有效的改善了互联网用户体验；并能防治黑客的攻击，预防单点故障，不影响全局访问。</p></div> 
      <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt">产品特点：</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
     </div>
     <div class="ly_m_jsd"><ul>
        <li style="width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#" style=" background-image:url(litscloud/images/ly_112.jpg); background-repeat:no-repeat; display:block; color:#fff;">1</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">提升性</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            跨越网络互联通瓶颈，用户实现就近访问，提升用户访问品质</p></div>
        </li>
        <li style="margin-left:14px; width:133px;">
           <div class="ly_m_jsd_lnt"  style="width:133px;"><a href="#">2</a></div>
           <div class="ly_m_jsd_lnc"  style="width:133px;">扩展性</div>
           <div class="ly_m_jsd_lnd"  style="width:133px;"><p  style="width:113px;">
           源站无需为突发流量购置多余设备</p></div>
        </li>
        <li style="margin-left:14px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">3</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">可靠性</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            局部问题不影响整体布局，保证用户的访问正常</p></div>
        </li>
        <li style="margin-left:14px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">4</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">安全性</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            由CDN节点替代源站被直接访问，有效保护源服务器避免遭到黑客攻击</p></div>
        </li>
        <li style="margin-left:14px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">5</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">方便性</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            加速了页面的响应速度同时，用户访问也是透明化的，无需修改源站内容</p></div>
        </li>
        <li style="margin-left:14px; width:133px;">
           <div class="ly_m_jsd_lnt" style="width:133px;"><a href="#">6</a></div>
           <div class="ly_m_jsd_lnc" style="width:133px;">报表统计</div>
           <div class="ly_m_jsd_lnd" style="width:133px;"><p style="width:113px;">
            提供带宽流量数据、流量缓存数据、节点流量比例、页面访问的统计数据及日志下载，报表支持多种格式</p></div>
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
