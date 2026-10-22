<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-服务器租用</title>
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

</script>
</head>

<body>
<div class="ly_body" id="mainbody">
 <!------------------------------------------头部公用代码------------------------------------------------------------>
  <jsp:include page="/litscloud/tpl/top4.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

   <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>   
     </div>
          <div class="ly_dh">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a>>  <a href="litscloud/tpl/serve.jsp">云服务</a> > 服务器租用
      </div>            
      
     <div class="ly_m_bgp">
       <div class="ly_m_bgp_t"></div>
       <div class="ly_m_bgp_c">
       <div class="ly_m_bgp_cu"></div>
         <div class="ly_m_bgp_ch"><ul>
      
            <li><a class="c1" href="javascript:changediv('d1')" ><img src="litscloud/images/zh_15.gif" />蚌埠电信</a></li>
            <li><a class="c1" href="javascript:changediv('d2')"><img src="litscloud/images/zh_16.gif" />天长电信</a></li>
            <li><a class="c1" href="javascript:changediv('d3')"><img src="litscloud/images/zh_16.gif" />铜陵联通</a></li>
            <li><a class="c1" href="javascript:changediv('d4')"><img src="litscloud/images/zh_17.gif" />天长双线</a></li>
            <li><a class="c1" href="javascript:changediv('d5')"><img src="litscloud/images/zh_20.gif" />香港新世界</a></li>
            <li><a class="c1" href="javascript:changediv('d6')"><img src="litscloud/images/zh_18.gif" />韩国服务器</a></li>
            <li><a class="c1" id="c1" href="javascript:changediv('d7')"><img src="litscloud/images/zh_19.gif" />美国服务器</a></li>
          </ul></div>
          <div class="ly_m_bgp_ct"><img src="litscloud/images/ly_91.jpg" style="margin-top:15px;" /> 服务器热门机型推荐</div>        
          <div class="ly_m_bgp_cd">
            <div class="ly_m_bgp_cdt"></div>
            <div class="ly_m_bgp_cdc">
            
                 
              <!-- 蚌埠电信 --> <div class="ly_m_bgp_cdc_n" id="d1" style="display: block"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 蚌埠电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
             <!-- 天长电信 -->  <div class="ly_m_bgp_cdc_n" id="d2" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长电信E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
               <!-- 铜陵联通 -->  <div class="ly_m_bgp_cdc_n" id="d3" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="litscloud/msg/no_function.jsp">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 铜陵联通 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
               <!-- 天长双线 -->  <div class="ly_m_bgp_cdc_n" id="d4" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 天长双线 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                <!-- 香港新世界 -->  <div class="ly_m_bgp_cdc_n" id="d5" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 香港新世界E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                <!-- 韩国服务器 -->  <div class="ly_m_bgp_cdc_n" id="d6" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">  韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">  韩国服务器E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
                  <!-- 美国服务器 -->  <div class="ly_m_bgp_cdc_n" id="d7" style="display: none"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                   <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts">美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                    <div class="ly_m_meu" style="margin-left:192px;"><img src="litscloud/images/bg_54.png" /></div>
                     <div class="ly_m_bgp_cdc_nts"> 美国服务器 E5200</div>
                      <div class="ly_m_bgp_cdc_ntc">
                          <dl>CPU: <span>Intel酷睿2双核 E5200</span></dl>
                          <dl>内存: <span>2G DDR800 KinSton</span></dl>
                          <dl>硬盘: <span>160GB 7200RPM SAT</span></dl>
                          <dl>主板: <span>Gigabyte G31-ES2C</span></dl>
                          <dl>标准: <span>1U IOK 服务器机箱</span></dl>
                          <dl>网络: <span>百兆共享/15M独享/1个IP</span></dl>
                          <dl>防护: <span>金盾8GB防火墙实时防护</span></dl>
                          <dl>BGP（多线）带宽: <span>50M</span></dl>
                          <dl>CDN带宽: <span>10M</span></dl>
                      </div>
                      <div class="ly_m_bgp_cdc_ntm">
                         <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">价格：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>480</span> 元/月<br />
                            <span>1400</span> 元/季<br />
                            <span>4999</span> 元/年
                            </div>
                         </div>
                          <div class="ly_m_bgp_cdc_ntm_h">
                            <div class="ly_m_bgp_cdc_ntm_hl">含税价：</div>
                            <div class="ly_m_bgp_cdc_ntm_hr"><span>5350</span> 元/年</div>
                         </div>   
                      </div>
                      <div class="ly_m_bgp_cdc_ntd"></div>
                   </div>
                   <div class="ly_m_bgp_cdc_nd">
                    <div class="ly_m_bgp_cdc_ndl"></div>
                    <div class="ly_m_bgp_cdc_ndc"><a href="javascript:shopdiv()">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
            </div>               </ul></div>
            </div>
            <div class="ly_m_bgp_cdd"></div>
          </div>
       </div>
       <div class="ly_m_bgp_d"></div>
     </div>
    <div class="ly_m_jbt"><span>技术优势</span></div>
    <div class="ly_m_jszc">
      <div class="ly_m_jszc_t"></div>
      <div class="ly_m_jszc_d">
        <div class="ly_m_jszc_dt">深圳立云网络和客户签定标准的《服务品质协议》(Service Level Agreement)，向客户提供7×24全面的技术服务与支持。<br />
包括：</div>
        <div class="ly_m_jszc_dd"><ul>
          <li>高速、可靠的ChinaNet联连，并保证客户网络系统的联通性达到99％以上；</li>
          <li>7×24的网络联接状况监控、服务器运行状态、流量监测；</li>
          <li>7×24的系统管理和技术支持服务；</li>
          <li>紧急情况下第一时间的响应与支持；</li>
          <li>根据用户需求提供独占的带宽；</li>
          <li>双路高压供电，提供100％的电力保证；</li>
          <li>7×24的恒温恒湿环境；</li>
          <li>智能UPS系统；</li>
          <li>操作系统和应用程序的安装；</li>
          <li>根据客户需要提供免费教程;</li>
          <li>8G硬件防护保证您的服务器避免恶意攻击;</li>
        </ul></div>
      </div>
    </div>   
    <div class="ly_n_weibu"></div>
    <div class="ly_m_jbt"><span>机房简介</span></div> 
    <div class="ly_m_jfjj">
      <div class="ly_m_jfjj_t"></div>
      <div class="ly_m_jfjj_c">
         <div class="ly_m_jfjj_ckh">
           <dl>典型客户</dl>
           <dt>酷讯网   丹尼斯</dt>
         </div>
         <div class="ly_m_jfjj_ckh">
           <dl>机房等级</dl>
           <dt>★★★★★</dt>
         </div>
         <div class="ly_m_jfjj_ckh">
           <dl>机房运营时间</dl>
           <dt style="color:#000;">一年</dt>
         </div>
         <div class="ly_m_jfjj_cgk">
         <dl>机房概况</dl>
         <dt><p>亿恩科技郑州BGP多线云数据中心完全按照国家四星级数据中心标准建造，6层独立楼宇，抗震级别8级
以上，预计建设机柜共计500个，首批投入运营共计120个，后期随时可以按需扩展。根据公司多年机房运营
经验，本着高标准、高质量、高环保的原则建设，机房网络核心设施全部采用华为高端系列设备，并配备4G
金盾硬件防火墙，同时接入电信、联通、移动、教育网四条线路，通过BGP技术真正实现互联互通。</dt>
         </p></div>
         <div class="ly_m_jfjj_cbz">
           <dl>电力保障</dl>
           <dt><p>机房电力系统方面独立建有专用变电站，从发电厂分两路输送到变电站，此外智能UPS供电系统及大型
电池组可持续供电5个小时以上，柴油发电机功率达到1200千瓦，保障机房99.99%电力供应。</p></dt>
         </div>
         <div class="ly_m_jfjj_cbz">
           <dl>空调系统</dl>
           <dt><p>    机房空调系统方面全面采用多台下送风式大功率专业精密空调，保障每个机柜的冷气供应和流通，确保
做到恒温恒湿，最大限度保证服务器硬件正常运行。</p></dt>
         </div>
         <div class="ly_m_jfjj_cbz">
           <dl>门禁系统</dl>
           <dt><p>    机房安防监控方面大楼一体化网络监控，数字电视大屏幕无盲区显示，重点区域双屏显示。楼体内多处
设防火探头及烟雾传感器，全方位消防系统和报警系统。机房需登记或持卡方能进入。</p></dt>
         </div>
         <div class="ly_m_jfjj_cbz">
           <dl>防尘防水</dl>
           <dt><p>    此外机房的防尘防静电系统也是建设的一个亮点，全采用防静电机柜，铺设防静电地板。工作人员操作
全部穿着防静电工作服及手套进行操作</p></dt>
         </div>
         <div class="ly_m_jfjj_cys">
         <dl>机房优势</dl>
         <dt><p>1、完全垄断运营，自派工程师7×24小时全天候响应请求，服务响应及时，随叫随到；<br /> 
2、中原地区唯一一个云计算BGP多线数据中心机房，也是国内带宽最为充足的BGP机房之一，互通线路较多，
互通性好； <br />
3、提供MRTG流量实时监控系统，7×24小时实时监控服务器运行状态；<br />  
4、可根据需要提供基本维护、完全代维、cdn、负载均衡、云部署等多种解决方案；<br /> 
5、数据中心地处中原，网络带宽升级性价比更高； <br />
6、机房只面向政府和企业等品质用户，杜绝虚机和其他任何容易引起攻击用户，给客户提供最高品质的网络
享受。
</p></dt>
         </div>
      </div>
      <div class="ly_m_jfjj_d"></div>
    </div>
     <div class="ly_m_jbt"><span>机房实景图片</span></div>
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div>
       <div class="ly_m_jft_d"><ul>
         <li><img src="litscloud/images/xl_06.gif" /></li>
         <li><img src="litscloud/images/xl_03.gif" /></li>
         <li><img src="litscloud/images/xl_04.gif" /></li>
         <li><img src="litscloud/images/xl_05.gif" /></li>
       </ul></div>
      </div>
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div> 
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
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
