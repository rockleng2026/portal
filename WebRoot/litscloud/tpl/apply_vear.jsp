<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云应用子页面</title>
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
  <jsp:include page="/litscloud/tpl/top5.jsp"></jsp:include>
   <div class="ly_zy" style="margin-bottom:0px;">
        <div class="ly_zyl"></div>
        <div class="ly_zyc"><ul>
           <li class="fwq_zy"><a href="apply.html#yyy" target="_parent">云应用</a></li>
           <li class="fwq_zy"><a href="apply.html#yylb" target="_parent">应用列表</a></li>
           <li class="fwq_zy"><a href="apply.html#wzjs" target="_parent">网站建设</a></li>
        </ul></div>
        <div class="ly_zyr"></div>
        </div>
        <div class="apply_banner"><img src="litscloud/images/bg_68.jpg" /></div>
      <!----------------------------------------------------------------问题开始------------------------------------------------------>
<div class="ly_wentis">
     <div class="ly_wenti_q">
       <div class="ly_wenti_q_r">
              <div class="ly_wenti_q_rt">请在下面输入您的问题</div>
              <div class="ly_wenti_q_rc">
                <div class="ly_wenti_q_rcl"></div>
                <div class="ly_wenti_q_rcc">
                  <div class="ly_wenti_q_rccl"><input type="text" name="wenti_text" class="wenti_text" value="请用一句话简述您的问题，如：忘记密码怎么办？" /></div>
                  <div class="ly_wenti_q_rccr"><a href="#"><img src="litscloud/images/ly_27.gif" /></a></div>
                </div>
                <div class="ly_wenti_q_rcr"></div>
              </div>
         <div class="ly_wenti_q_rd"> 您还可以输入 <span>30</span> 字</div>
        </div>
        <div class="ly_wenti_q_l">
        <a href="#"><img src="litscloud/images/ly_30.gif" />   </a>
        </div>
       </div>
      </div> 
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

    <div class="ly_imiddle">
     <div class="ly_m">
      <div class="ly_m_mt"></div>   
     </div>
          <div class="ly_dh">          
      </div>
      <div class="ly_dhn">
      当前位置：<a href="/litscloud/tpl/index.jsp">首页</a> > 云应用
      </div>
      
    <div class="ly_n_mbt">
       <div class="ly_n_mbtc"><a name="yyy"><p></p>云<br />应用</a></div>
    </div>  
    <div class="ly_n_apply">
        <div class="ly_n_apply_t">
           <div class="ly_m_myy">
              <div class="ly_m_myy_l">
                 <h1>什么是立云云应用</h1>
 <p>   云应用是由立云提供一系列的管理、提高效率、辅助网站推广、
手机互联网应用的销售管理平台丰富的应用资源实现了应用和空间的
完美结合，为用户提供了从基础的建站到互联网垂直、细分化的各种
服务。用户不再为各种繁多的软件安装、配置主机环境而发愁。使中
小企业无需购买硬件设备，无需专业技术人才就能够享受各种优质的
互联网产品服务。</p>              </div>
           <div class="ly_m_myy_r"><ul>
       <li><a href="#" onmouseover="mouseOver1('55')" onmouseout="mouseOut1('59')"><img src="litscloud/images/bg_55.jpg" id="yg1"  /></a></li>
       <li><a href="#" onmouseover="mouseOver1('56')" onmouseout="mouseOut1('60')"><img src="litscloud/images/bg_56.jpg" id="yg2" /></a></li>
       <li><a href="#" onmouseover="mouseOver1('57')" onmouseout="mouseOut1('61')"><img src="litscloud/images/bg_57.jpg" id="yg3" /></a></li>
       <li><a href="#" onmouseover="mouseOver1('58')" onmouseout="mouseOut1('62')"><img src="litscloud/images/bg_58.jpg" id="yg4" /></a></li>
     </ul></div>
         </div>
        </div>
        <div class="ly_n_apply_d">
           <div class="y_n_apply_dt">
               <div class="ly_n_apply_dtt"><a name="yylb"></a>应用列表</div>
               <div class="ly_n_apply_dtd"><div class="ly_n_idcl_x" style="margin:0px;"><div class="ly_n_idcl_xl"></div><div class="ly_n_idcl_xr"></div></div></div>
           </div>
           <div class="y_n_apply_dd"><ul>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_70.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管客户]</div>
                <div class="y_n_apply_dds">用友-立云专版在线CRM</div>
                <div class="y_n_apply_ddq"><span>3980</span> 元起</div>
             </li>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_71.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管购通]</div>
                <div class="y_n_apply_dds">立云在线客服软件</div>
                <div class="y_n_apply_ddq"><span>1200</span> 元起</div>
             </li>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_72.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管推广]</div>
                <div class="y_n_apply_dds">AFS立云版</div>
                <div class="y_n_apply_ddq"><span>6000</span> 元起</div>
             </li>
             <li style="margin:0px;">
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_73.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管货]</div>
                <div class="y_n_apply_dds">用友-立云专版在线进销存</div>
                <div class="y_n_apply_ddq"><span>348</span> 元起</div>
             </li>
           </ul>
           <ul>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_74.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管钱]</div>
                <div class="y_n_apply_dds">用友-立云专版在线记帐</div>
                <div class="y_n_apply_ddq"><span>348</span> 元起</div>
             </li>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_75.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管钱]</div>
                <div class="y_n_apply_dds">小富婆-个人在线记帐</div>
                <div class="y_n_apply_ddq"><span>18</span> 元</div>
             </li>
             <li>
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_76.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[管效率]</div>
                <div class="y_n_apply_dds">赛普云OA-立云版</div>
                <div class="y_n_apply_ddq"><span>600</span> 元起</div>
             </li>
             <li style="margin:0px;">
                <div class="y_n_apply_ddp">
                   <div class="y_n_apply_ddp_t"></div>
                   <div class="y_n_apply_ddp_c"><img src="litscloud/images/ly_77.jpg" /></div>
                   <div class="y_n_apply_ddp_d"></div>                   
                </div>
                <div class="y_n_apply_ddn">[手机应用]</div>
                <div class="y_n_apply_dds">追信-手机应用建设</div>
                <div class="y_n_apply_ddq"><span>6000</span> 元起</div>
             </li>
           </ul>           
           </div>
        </div>
    </div>     
    <div class="ly_n_weibu"></div>  
 
    <div class="ly_n_mbt">
       <div class="ly_n_mbtc"><a name="wzjs" style="line-height:"><p></p>网站<br />建设</a></div>
    </div> 
    <DIV class="ly_n_wj"><ul>
        <li><a href="#"><img src="litscloud/images/bg_69.jpg" /></a></li>
       <li><a href="#"><img src="litscloud/images/bg_70.jpg" /></a></li>
       <li><a href="#"><img src="litscloud/images/bg_71.jpg" /></a></li>
       <li><a href="#"><img src="litscloud/images/bg_72.jpg" /></a></li>
    </ul></DIV>
    <div class="ly_n_wjsm">
       <a href="#">查看更多产品</a>
    </div>
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>


<!--_________________________底部公用代码 _______________________________________________-->
    <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>
</body>
</html>
