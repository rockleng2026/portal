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
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
function mouseOver()
{
document.getElementById('b1').src ="litscloud/images/bg_44.png"
}
function mouseOut()
{
document.getElementById('b1').src ="litscloud/images/ly_33.gif"
}
function mouseOver()
{
document.getElementById('b2').src ="litscloud/images/ly_32.gif"
}
function mouseOut()
{
document.getElementById('b2').src ="litscloud/images/ly_32.gif"
}
function mouseOver1(a)
{
	if(a==55)
	{
		document.getElementById('yg1').src ="litscloud/images/bg_59.jpg"	
	}
	if(a==56)
	{
		document.getElementById('yg2').src ="litscloud/images/bg_60.jpg"	
	}
	if(a==57)
	{
		document.getElementById('yg3').src ="litscloud/images/bg_61.jpg"	
	}
	if(a==58)
	{
		document.getElementById('yg4').src ="litscloud/images/bg_62.jpg"	
	}
	if(a==1)
	{
		document.getElementById('yg8').src ="litscloud/images/ly_32.gif"	
	}
	if(a==2)
	{
		document.getElementById('yg9').src ="litscloud/images/bg_44.png"	
	}
	if(a==3)
	{
		document.getElementById('yg10').src ="litscloud/images/bg_74.png"	
	}
	if(a==4)
	{
		document.getElementById('yg11').src ="litscloud/images/bg_75.png"	
	}
	
	
}

function mouseOut1(a)
{
	
	if(a==59){
		
		document.getElementById('yg1').src ="litscloud/images/bg_55.jpg"
	}
	if(a==60){
		
		document.getElementById('yg2').src ="litscloud/images/bg_56.jpg"
	}
	if(a==61){
		
		document.getElementById('yg3').src ="litscloud/images/bg_57.jpg"
	}
	if(a==62){
		
		document.getElementById('yg4').src ="litscloud/images/bg_58.jpg"
	}
	
	if(a==5){
		
		document.getElementById('yg8').src ="litscloud/images/ly_32.gif"
	}
	if(a==6){
		
		document.getElementById('yg9').src ="litscloud/images/ly_33.gif"
	}
	if(a==7){
		
		document.getElementById('yg10').src ="litscloud/images/ly_34.gif"
	}
	if(a==8){
		
		document.getElementById('yg11').src ="litscloud/images/ly_35.gif"
	}
	
}
</script>
</head>

<body>
<!-- 头部S -->
<jsp:include page="/litscloud/tpl/top.jsp"></jsp:include>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>
      <div class="ly_m_mys">
        <div class="ly_m_mysn"><ul>
            <li class="ly_anquan">
                <dt><a href="#" onmouseover="mouseOver1('1')" onmouseout="mouseOut1('5')"><img src="litscloud/images/ly_32.gif" id="yg8" /></a></dt>
                <dd>安全稳定<br />数据可靠</dd>
            </li>
            <li class="ly_anquan">
                <dt><a href="#" onmouseover="mouseOver1('2')" onmouseout="mouseOut1('6')"><img src="litscloud/images/ly_33.gif" id="yg9" /></a></dt>
                <dd >BGP独享带宽<br />高速访问</dd>
            </li>
                <li class="ly_anquan">
                 <dt><a href="#" onmouseover="mouseOver1('3')" onmouseout="mouseOut1('7')"><img src="litscloud/images/ly_34.gif" id="yg10" /></a></dt>
                <dd >简单易用<br />弹性伸缩</dd>
            </li>
                 <li class="ly_anquan" style="width:120px;">
                 <dt><a href="#" onmouseover="mouseOver1('4')" onmouseout="mouseOut1('8')"><img src="litscloud/images/ly_35.gif" id="yg11" /></a></dt>
                <dd >按需购买<br />节约成本</dd>
            </li>            
        </ul></div>
      </div>    
     </div>
   <div class="ly_m_mbt">
      <div class="ly_m_mbtc"><a href="serve.html">云<br />服务</a></div>
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
                <div class="ly_m_mfw_bottom_c"><a href="#">立即购买</a></div>
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
                <div class="ly_m_mfw_bottom_c"><a href="#">立即购买</a></div>
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
                <div class="ly_m_mfw_bottom_c"><a href="#">进一步了解</a></div>
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
                <div class="ly_m_mfw_bottom_c"><a href="#">进一步了解</a></div>
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
       <li><a href="#" onmouseover="mouseOver1('55')" onmouseout="mouseOut1('59')"><img src="litscloud/images/bg_55.jpg" id="yg1"  /></a></li>
       <li><a href="#" onmouseover="mouseOver1('56')" onmouseout="mouseOut1('60')"><img src="litscloud/images/bg_56.jpg" id="yg2" /></a></li>
       <li><a href="#" onmouseover="mouseOver1('57')" onmouseout="mouseOut1('61')"><img src="litscloud/images/bg_57.jpg" id="yg3" /></a></li>
       <li><a href="#" onmouseover="mouseOver1('58')" onmouseout="mouseOut1('62')"><img src="litscloud/images/bg_58.jpg" id="yg4" /></a></li>
     </ul></div>
   </div>
  <div class="ly_m_mal">
    <h1>速成美站，专业设计师打造精美网站</h1>
    <ul>
    <li><a href="#"><img src="litscloud/images/ly_46.gif" /></a></li>
    <li><a href="#"><img src="litscloud/images/ly_245.jpg" /></a></li>
    <li><a href="#"><img src="litscloud/images/ly_246.jpg" /></a></li>
    <li><a href="#"><img src="litscloud/images/ly_247.jpg" /></a></li>
    </ul>
  </div> 
   
     <div class="ly_m_mbt">
      <div class="ly_m_mbtc">云<br />平台</div>
   </div>
    <div class="ly_m_mpt">
     <img src="litscloud/images/ly_47.gif" />
     </div>
   </div>
<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
