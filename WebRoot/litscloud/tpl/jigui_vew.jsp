<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-机柜详情</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="litscloud/css/main.css" />
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
       <div class="ly_dh" style="height:4px; overflow:hidden">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp" target="_parent">首页</a> > <a href="litscloud/tpl/serve.jsp" target="_parent">云服务</a> > 机柜详细
      </div>  
      <div class="ly_tuo">
        <div class="ly_tuo_t"></div>
        <div class="ly_tuo_c">
          <div class="ly_tuo_q">
            <div class="ly_tuo_qt">
                <div class="ly_tuo_qtl">
                  <div class="ly_tuo_qtl_t"></div>
                  <div class="ly_tuo_qtl_c"><div class="ly_tuo_qtl_cq"><img src="litscloud/images/ly_238.jpg" /></div></div>
                  <div class="ly_tuo_qtl_d"></div>
                </div>
                <div class="ly_tuo_qtr">
                  <div class="ly_tuo_qtr_t">深圳BGP多线机房（高端）</div>
                  <div class="ly_tuo_qtr_c">速度测试: <span>106.3.45.195</span></div>
                  <div class="ly_tuo_qtr_d">√ 华中地区最大的IDC服务商，为您提供多种IDC资源选择<br />
√ 真正提供7×24小时不间断机房现场服务<br />
√ 无限次安装系统、无限次快速重启服务器，免费提供基础安全设置
</div>
                </div>
            </div>
            <div class="ly_tuo_qd"><ul>
               <li><span>出口带宽:</span>机房带宽总出口40G</li>
               <li><span>机柜数量:</span>共计500个机柜，首批启用120个机柜 </li>
               <li><span>机房面积:</span>面积达到1000多平方米四星级机房</li>
               <li><span>机柜型号:</span>标准42U机柜，10A电源，电可按需扩展</li>
               <li><span>电力保障:</span>双路通信供电系统+UPS+柴油发电机</li>
               <li><span>独享服务:</span>提供5M-1000M独享带宽支持</li>
               <li><span>服务保障:</span>专业技术工程师真正7×24现场服务</li>
               <li><span>安全保障:</span>配备消防、保安、空调等一流设施</li>       
            </ul></div>
          </div>
        </div>
        <div class="ly_tuo_d"></div>
      </div>
      
       <div class="ly_tuo">
        <div class="ly_tuo_t"></div>
        <div class="ly_tuo_c" style="padding-top:20px; padding-bottom:20px;">
            <div class="ly_band_cdd">
                  <div class="ly_band_cdd_v"></div>
                  <div class="ly_band_cdd_o">
                    <div class="ly_band_cdd_oq" style="background-color:#e6eef7;">
                       <div class="ly_band_cdd_oql"><span>机柜尺寸</span></div>
                       <div class="ly_band_cdd_oqq"><span>年付</span></div>
                       <div class="ly_band_cdd_oqw"><span>带宽</span></div>
                       <div class="ly_band_cdd_oqe"><span>增送IP数</span></div>
                       <div class="ly_band_cdd_oqr"><span>设备限数</span></div>
                       <div class="ly_band_cdd_oqt"><span>电力（安）</span></div>
                    </div>
                    
                    <div class="ly_band_cdd_oq">
                       <div class="ly_band_cdd_oql">标准42U</div>
                       <div class="ly_band_cdd_oqq">60000元/年</div>
                       <div class="ly_band_cdd_oqw">10M独享</div>
                       <div class="ly_band_cdd_oqe">20个</div>
                       <div class="ly_band_cdd_oqr">不限</div>
                       <div class="ly_band_cdd_oqt">10A</div>
                    </div>
                    
                     <div class="ly_band_cdd_oq" style="background-color:#e6eef7;">
                       <div class="ly_band_cdd_oql">标准42U</div>
                       <div class="ly_band_cdd_oqq">70000元/年</div>
                       <div class="ly_band_cdd_oqw">20M独享</div>
                       <div class="ly_band_cdd_oqe">20个</div>
                       <div class="ly_band_cdd_oqr">不限</div>
                       <div class="ly_band_cdd_oqt">10A</div>
                    </div>
                    
                     <div class="ly_band_cdd_oq">
                       <div class="ly_band_cdd_oql" style="border-bottom:none; height:41px;">特价42U</div>
                       <div class="ly_band_cdd_oqq" style="border-bottom:none; height:41px;">75000元/年</div>
                       <div class="ly_band_cdd_oqw" style="border-bottom:none; height:41px;">30M独享</div>
                       <div class="ly_band_cdd_oqe" style="border-bottom:none; height:41px;">20个</div>
                       <div class="ly_band_cdd_oqr" style="border-bottom:none; height:41px;">不限</div>
                       <div class="ly_band_cdd_oqt" style="border-bottom:none; height:41px;">10A</div>
                    </div>
                    
                  </div>                  
                  <div class="ly_band_cdd_r"></div>
               </div>
        </div>
        <div class="ly_tuo_d"></div>
       </div> 
       
     <div class="ly_m_jbt"><span style="color:#787777;">机房简介</span></div>  
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
    
    
    <div class="ly_zhu">
      <div class="ly_zhup"><ul>
         <li><a href="#"><img src="litscloud/images/xl_11.gif" /></a></li>
         <li><a href="#"><img src="litscloud/images/xl_12.gif" /></a></li>
         <li><a href="#"><img src="litscloud/images/xl_13.gif" /></a></li>
         <li><a href="#"><img src="litscloud/images/xl_14.gif" /></a></li>
         <li><a href="#"><img src="litscloud/images/xl_15.gif" /></a></li>
      </ul></div> 
    </div>  
       
     
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
