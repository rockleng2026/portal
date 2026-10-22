<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-官方平台</title>
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
<script type="text/javascript" src="litscloud/js/top.js"></script>

<script type="text/javascript" src="litscloud/js/showdiv.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<style type="text/css">
.msc{
top:0%;
left:0%;
background-color:#0C9;
width: 100%;
height: 500%;
position: absolute;
z-index: 1001;

}
.jgc{
top:150%;
left:15%;
width: 806px;
height: 500px;
position: absolute;
z-index: 10000;
}
</style>
<script type="text/javascript">
function spxq(sgcode){
	
	sgcode1='SP-2013020200010';
	location.href="<%=path %>/litscloud/web/litscloudgetprodutCustomerServerC.Action?page=page&sgcode="+sgcode1+"&tt="+(new Date()).getTime();
	    




	
}
</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body" id="mainbody">
<jsp:include page="/litscloud/tpl/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>
      <div class="ly_m_mys">
        <div class="ly_m_mysn"><ul>
            <li class="ly_anquan">
               <dl><dt><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('1')" onmouseout="mouseOut1('5')"><img src="litscloud/images/ly_32.gif" id="yg8" /></a></dt>
                <dd>安全稳定<br />数据可靠</dd></dl>
            </li>
            <li class="ly_anquan">
               <dl><dt><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('2')" onmouseout="mouseOut1('6')"><img src="litscloud/images/ly_33.gif" id="yg9" /></a></dt>
                <dd >BGP独享带宽<br />高速访问</dd></dl>
            </li>
                <li class="ly_anquan">
                 <dl><dt><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('3')" onmouseout="mouseOut1('7')"><img src="litscloud/images/ly_34.gif" id="yg10" /></a></dt>
                <dd >简单易用<br />弹性伸缩</dd></dl>
            </li>
                 <dl><li class="ly_anquan" style="width:120px;">
                 <dt><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('4')" onmouseout="mouseOut1('8')"><img src="litscloud/images/ly_35.gif" id="yg11" /></a></dt>
                <dd >按需购买<br />节约成本</dd></dl>
            </li>            
        </ul></div>
      </div>    
     </div>
   <div class="ly_m_mbt">
      <div class="ly_m_mbtc"><a href="litscloud/tpl/serve.jsp">云<br />服务</a></div>
   </div>  
      <div class="ly_m_mfw"><ul>
         <li>
           <div class="ly_m_mfw_top">
           <div class="ly_m_meu"><img src="litscloud/images/bg_54.png" /></div>
             <div class="ly_m_mfw_top_t">推荐配置</div>
             <div class="ly_m_mfw_top_c"><ul>
             <li><div class="ly_m_mfw_top_cl">电信 :</div><div class="ly_m_mfw_top_cr">1300/月</div></li> 
             <li><div class="ly_m_mfw_top_cl">联通 :</div><div class="ly_m_mfw_top_cr">1200元/月</div></li> 
             <li><div class="ly_m_mfw_top_cl">CPU :</div><div class="ly_m_mfw_top_cr">I3-530</div></li> 
             <li><div class="ly_m_mfw_top_cl">内存 :</div><div class="ly_m_mfw_top_cr">4G</div></li> 
             <li><div class="ly_m_mfw_top_cl">硬盘 :</div><div class="ly_m_mfw_top_cr">1T	</div></li> 
             <li><div class="ly_m_mfw_top_cl">操作系统 :</div><div class="ly_m_mfw_top_cr">windows linux</div></li> 
             <li><div class="ly_m_mfw_top_cl">带宽 :</div><div class="ly_m_mfw_top_cr">百M独享（99%可用） </div></li> 
             <li><div class="ly_m_mfw_top_cl">IP地址 :</div><div class="ly_m_mfw_top_cr"> 一个免费IP   </div></li> 
             <li><div class="ly_m_mfw_top_cl">机房 :</div><div class="ly_m_mfw_top_cr"> 广东电信，山东联通     </div></li> 
             <li><div class="ly_m_mfw_top_cl">网卡 :</div><div class="ly_m_mfw_top_cr"> 双千兆网卡     </div></li> 
             </ul></div>
             <div class="ly_m_mfw_top_d"></div>
           </div>
           <div class="ly_m_mfw_bottom">
               <div class="ly_m_mfw_bottom_l"></div>
                <div class="ly_m_mfw_bottom_c"><a href="javascript:shopdiv(1)">立即购买</a></div>
                 <div class="ly_m_mfw_bottom_r"></div> 
           </div>
         </li>
         <li>
           <div class="ly_m_mfw_top">
           <div class="ly_m_meu"><img src="litscloud/images/bg_54.png" /></div>
             <div class="ly_m_mfw_top_t">推荐配置</div>
             <div class="ly_m_mfw_top_c"><ul>
             <li><div class="ly_m_mfw_top_cl">电信 :</div><div class="ly_m_mfw_top_cr">1300/月</div></li> 
             <li><div class="ly_m_mfw_top_cl">联通 :</div><div class="ly_m_mfw_top_cr">1200元/月</div></li> 
             <li><div class="ly_m_mfw_top_cl">CPU :</div><div class="ly_m_mfw_top_cr">inter I3 2.8GHz</div></li> 
             <li><div class="ly_m_mfw_top_cl">内存 :</div><div class="ly_m_mfw_top_cr">4G</div></li> 
             <li><div class="ly_m_mfw_top_cl">硬盘 :</div><div class="ly_m_mfw_top_cr">1T	</div></li> 
             <li><div class="ly_m_mfw_top_cl">操作系统 :</div><div class="ly_m_mfw_top_cr">windows linux</div></li> 
             <li><div class="ly_m_mfw_top_cl">带宽 :</div><div class="ly_m_mfw_top_cr">百M独享（99%可用） </div></li> 
             <li><div class="ly_m_mfw_top_cl">IP地址 :</div><div class="ly_m_mfw_top_cr"> 一个免费IP   </div></li> 
             <li><div class="ly_m_mfw_top_cl">机房 :</div><div class="ly_m_mfw_top_cr"> 广东电信，山东联通     </div></li> 
             <li><div class="ly_m_mfw_top_cl">网卡 :</div><div class="ly_m_mfw_top_cr"> 双千兆网卡     </div></li>
             </ul></div>
             <div class="ly_m_mfw_top_d"></div>
           </div>
           <div class="ly_m_mfw_bottom">
               <div class="ly_m_mfw_bottom_l"></div>
                <div class="ly_m_mfw_bottom_c"><a href="javascript:shopdiv(1)">立即购买</a></div>
                 <div class="ly_m_mfw_bottom_r"></div> 
           </div>
         </li>
         <li>
           <div class="ly_m_mfw_top">
             <div class="ly_m_mfw_top_t">下载加速</div>
             <div class="ly_m_mfw_top_c">
               <div class="ly_m_mfw_top_ct"><img src="litscloud/images/bg_52.png"  style="margin-top:8px;"/></div>
               <div class="ly_m_mfw_top_cd">PowerCDN下载加速是为各类音视
频、安装软件及补丁、游戏客户端等
需要被下载的网站内容提供加速服务
的，首先是通过CDN内容分发技术，
将源网站大量内容数据快速、安全和
稳定的分发到各个CDN节点中，然后利
用缓存技术通过......</div>
             </div>
             <div class="ly_m_mfw_top_d"></div>
           </div>
           <div class="ly_m_mfw_bottom">
               <div class="ly_m_mfw_bottom_l"></div>
                <div class="ly_m_mfw_bottom_c"><a href="javascript:spxq(1)">进一步了解</a></div>
                 <div class="ly_m_mfw_bottom_r"></div> 
           </div>
         </li>     
         <li style="margin-right:0px;">
           <div class="ly_m_mfw_top">
             <div class="ly_m_mfw_top_t">HTTPS加速</div>
             <div class="ly_m_mfw_top_c">
                <div class="ly_m_mfw_top_ct"><img src="litscloud/images/bg_53.png"/></div>
               <div class="ly_m_mfw_top_cd">    使用PowerCDN的HTTPS加速可解
决这一问题，通过专用的加密、解密
设备，在各个PowerCDN节点上提供加
速服务，然后对用户请求的内容进行
加密后再请求最近的节点，此时节点
会根据专门的私钥将用户请求的内容
进行解密，减轻源......</div>
             </div>
             <div class="ly_m_mfw_top_d"></div>
           </div>
           <div class="ly_m_mfw_bottom">
               <div class="ly_m_mfw_bottom_l"></div>
                <div class="ly_m_mfw_bottom_c"><a href="javascript:spxq(1)">进一步了解</a></div>
                 <div class="ly_m_mfw_bottom_r"></div> 
           </div>
         </li>
 </ul>     </div> 
 
   <div class="ly_m_mbt">
      <div class="ly_m_mbtc">云<br />应用</div>
   </div>
   <div class="ly_m_myy">
     <div class="ly_m_myy_l">
        <h1>什么是立云云应用</h1>
        <p>   云应用是由立云提供一系列的管理、提高效率、辅助网站推广、
手机互联网应用的销售管理平台丰富的应用资源实现了应用和空间的
完美结合，为用户提供了从基础的建站到互联网垂直、细分化的各种
服务。用户不再为各种繁多的软件安装、配置主机环境而发愁。使中
小企业无需购买硬件设备，无需专业技术人才就能够享受各种优质的
互联网产品服务。</p>
     </div>
     <div class="ly_m_myy_r"><ul>
       <li><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('55')" onmouseout="mouseOut1('59')"><img src="litscloud/images/bg_55.jpg" id="yg1"  /></a></li>
       <li><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('56')" onmouseout="mouseOut1('60')"><img src="litscloud/images/bg_56.jpg" id="yg2" /></a></li>
       <li><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('57')" onmouseout="mouseOut1('61')"><img src="litscloud/images/bg_57.jpg" id="yg3" /></a></li>
       <li><a href="litscloud/msg/no_function.jsp" onmouseover="mouseOver1('58')" onmouseout="mouseOut1('62')"><img src="litscloud/images/bg_58.jpg" id="yg4" /></a></li>
     </ul></div>
   </div>
  <div class="ly_m_mal">
    <h1>速成美站，专业设计师打造精美网站</h1>
    <ul>
    <li><a href="litscloud/msg/no_function.jsp"><img src="litscloud/images/ly_46.gif" /></a></li>
    <li><a href="litscloud/msg/no_function.jsp"><img src="litscloud/images/ly_245.jpg" /></a></li>
    <li><a href="litscloud/msg/no_function.jsp"><img src="litscloud/images/ly_246.jpg" /></a></li>
    <li><a href="litscloud/msg/no_function.jsp"><img src="litscloud/images/ly_247.jpg" /></a></li>
    </ul>
  </div> 
   
     <div class="ly_m_mbt">
      <div class="ly_m_mbtc">云<br />平台</div>
   </div>
    <div class="ly_m_mpt">
     <img src="litscloud/images/ly_47.gif" />
     </div>
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
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div> 
   </div>
<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
