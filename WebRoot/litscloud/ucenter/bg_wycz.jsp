<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（我要充值）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
  $(document).ready(function(){ 
  	document.getElementById("a3").className = "aBackgroundImage";
 document.getElementById("a3").style.color= "#000000";
	
	});
</script>
</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
         <!--   <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心</div> -->
          
             <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include> 
        
           <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_pay">
                       <div class="bg_pay_l">
                            <div class="bg_wy">
                              <div class="bg_wyt">
                                 <div class="bg_wyt_t"><span>提示：</span>1、充值成功后仅账户佘额，不会自动结算订单，如果您有未付款订单，请您务必到“未付款订单管理”
中选择订单结算，充值完成后请点击这里<a href="#">申请发票</a><br />
<span>2、帐户佘额不能用于购买立云服务器，如需购买立云阿里云服务器，请您直接将款项支付给立云</span></div>
                                <div class="bg_wyt_c">账户余额：<span>0.00</span> 元</div>
                                <div class="bg_wyt_c">充值金额：<input type="text" name="bg_czje" class="bg_czje" />元</div>
                              </div>
                              <div class="bg_wyc">请选择充值方式</div>
                              <div class="bg_wym">
                                 <div class="bg_wym_l"></div>
                                 <div class="bg_wym_r"></div>
                              </div>
                              <div class="bg_wyd">
                                  <div class="bg_wyd_t"></div>
                                  <div class="bg_wyd_c">
                                      <div class="bg_wyd_ct"><span>选择银行：</span><input name="bg_yhl" type="radio" value="个人银行" style="margin-right:3px; margin-left:10px;" />个人网上银行充值 &nbsp;&nbsp; <input name="bg_yhl" type="radio" value="企业一行" />企业网上银行充值</div>
                                      <div class="bg_wyd_cd"><ul>
                                         <li><input name="bg_yhxz" type="radio" style="float:left;" value="中国工商银行" checked="checked" /><img src="litscloud/images/044.gif" /></li>
                                         <li><input name="bg_yhxz" type="radio" style="float:left;" value="中国农业银行" /><img src="litscloud/images/046.gif" /></li>
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="中国建设银行" /><img src="litscloud/images/045.gif" /></li>
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="招商银行" /><img src="litscloud/images/051.gif" /></li>
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="中国银行" /><img src="litscloud/images/052.gif" /></li>
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="微商银行" /><img src="litscloud/images/053.gif" /></li> 
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="中国邮政" /><img src="litscloud/images/050.gif" /></li> 
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="支付宝" /><img src="litscloud/images/055.gif" /></li> 
                                          <li><input name="bg_yhxz" type="radio" style="float:left;" value="财付通" /><img src="litscloud/images/066.gif" /></li>   
                                      </ul></div>
                                      <div class="bg_wyd_cc"><a href="#">确 &nbsp; 认</a></div>
                                  </div>
                              
                                  <div class="bg_wyd_d"></div>
                              </div>
                              
                            </div>                            
                       </div>
                       <div class="bg_pay_r">
                         <div class="bg_pay_rc">
                            <div class="bg_pay_rct">立云公告</div>
                            <div class="bg_pay_rcc"><ul>
                               <li><a href="#">[通知]<span>OSS服务部分VIP下线通知</span></a></li>
                               <li><a href="#">[通知]<span>3月19日23:00起OSS服务升级</span></a></li>
                               <li><a href="#">[通知]<span>3月20日11:00起云服务升级</span></a></li>
                               <li><a href="#">[通知]3月网站备案信息抽查评估通知</a></li>
                               <li><a href="#">[通知]3月15日20:00起SLB服务升级</a></li>
                               <li><a href="#">[通知]3月14日22:00起云监控升级</a></li>
                            </ul></div>
                            <div class="bg_pay_rcm">
                              <a href="#"><img src="litscloud/images/bg_17.png" /></a>
                            </div>
                            <div class="bg_pay_rct" style="margin-top:20px;">热点活动</div>
                            <div class="bg_pay_rcd"><ul>
                               <li><a href="#"><span>免费备案，还送时间啦</span></a></li>
                               <li><a href="#"><span>第二波免费数据迁移倒计时</span></a></li>
                               <li><a href="#">推荐云服务器，送集分宝</a></li>
                            </ul></div>
                            <div class="bg_pay_rct" style="margin-top:10px;">热点话题<span class="blue"><a href="#" style="font-size:12px;">去论坛</a></span></div>
                            <div class="bg_pay_rcb"><ul>
                              <li><dl><a href="#">简述云服务器对比VPS</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">如何提高网站的打开速度</a></dl><dt>来自：<span>wanghaifei</span></dt></li>
                              <li><dl><a href="#">CPU、内存多少才够用？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">网站访问速度快才是硬道理</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">如何节省网站访问流量？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">阿里云弹性计算服务篇</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">云服务器配置满意度调查，说出来！</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">"尖舌"上的更换操作系统，为啥换？</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                              <li><dl><a href="#">云服务器教程征集令，说出你的困惑。</a></dl><dt>来自：<span>dreamdoo</span></dt></li>
                            </ul></div>
                         </div>
                       </div>
                    </div>
                </div>  
                
             </div>
             <div class="bg_dd"></div>
          </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
