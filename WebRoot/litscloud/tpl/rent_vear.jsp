<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云主机详情</title>
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
/*<![CDATA[*/
#login {width:590px;height:30px;}
#login .top {margin-top:2px; margin-left:6px; width:120px; text-align:right; line-height:30px; color:#6b6a6a; font-family:Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; float:left; height:30px;}
#login h2 { font-size:14px; color:#7fb133; font-weight:bold; font-family:"微软雅黑"; line-height:30px;text-align:left; text-align:center; width:83px; height:30px; background-image:url(images/ly_198.gif); background-repeat:no-repeat; float:left;}
#moveico { margin-top:8px; background:url(images/ly_243.jpg) no-repeat; width:408px; height:24px; float:left;}
#moveico div {position: relative;float:left;left:13px; top:-4px;background:url(images/ly_244.png) no-repeat; width:17px; height:25px;}

#login input { height:16px; color:#666;}
#login .userchk { width:16px;}
#login .userinput { width:92px; border:1px #cbdca8 solid;}
#login .usersub { width:52px;height:18px; background:url(images/12446171100.gif) no-repeat; border:0;  line-height:22px; color:#454545; font-size:12px;}
#login span { margin-left:8px;}
#login ul {width:160px;margin:0 auto;}
#login li { clear:left; height:21px; line-height:21px; text-align:left;overflow:hidden;}
#login li.other {border-top:2px #e0ecc8 solid;  margin-top:3px;text-indent: 6px;}
#login a#loginhelp {position: relative; top:-18px;left:145px;display:block; width:12px; height:12px; background:#f7fcfc url(images/12446171100.gif) no-repeat -60px 0; }

/*]]>*/
</style>
<script type="text/javascript">
<!--

//Moveobj

function bind(o,ev,fn){
if (document.all)o.attachEvent('on'+ev,fn);
else o.addEventListener(ev,fn,false);
}
function setCookie(name,value,time){
var exp = new Date();
exp.setTime(exp.getTime() + 30*24*60*60*1000);
document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
function getCookie(name){
var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
if(arr=document.cookie.match(reg)) return unescape(arr[2]);
else return null;
}

function Move_autosetdef(moveobj){
var logintit = new Array("0","500","1000","2000");
var bNum =5 ,mNum =127 , iNum = 4 , icolength = 6;
//分别 bNum 起始距离距moveobj内侧左部的长度 ，mNum 单位长度，iNum 单位数 0-1-2-3，icolength 图标距离的1/2。

var eNum = bNum + mNum * (iNum-1);
var $D = new Function('str','return document.getElementById(str);');
var $event = new Function('e','return (!e)?window.event:e;');
var checknowleft = function(z){return ((z<bNum)?bNum:((z>eNum)?eNum:(((z-bNum)%mNum>11)?z+mNum-(z-bNum)%mNum:z-(z-bNum)%mNum)));}
var nowseat = 0,drag_=false;
var Move_autoset = function(iNum){
$D(moveobj).getElementsByTagName("div")[0].style.left = iNum*mNum+bNum+"px";
$D("login-tit").innerHTML = logintit[iNum];
$D("login-type").value = iNum;//向hidden的login-type里添加参数值
} 

nowseat = (getCookie("nowseat")==null)?0:getCookie("nowseat");
Move_autoset(nowseat);
$D(moveobj).getElementsByTagName("div")[0].onmouseover = function(){
var x,y,z;
this.onmousedown=function(e){
drag_=true;
with(this){
var temp0=style.left.replace("px","")*1,temp1=offsetLeft,temp2=offsetTop;
x=$event(e).clientX;
y=$event(e).clientY;
z=temp0;
document.onmousemove=function(e){
//this.selection.empty();
if(!drag_)return false;
with(this){
z = temp0 + $event(e).clientX-x;
z = (z<bNum)?bNum:((z>eNum)?eNum:z);
style.left=z+"px";
}
}
document.onmouseup=function(e){
drag_ = false;
var nowleft = checknowleft(z);
nowseat = (nowleft-bNum)/mNum;
Move_autoset(nowseat);
setCookie('nowseat',(nowleft-bNum)/mNum);
}
}
}
}
$D(moveobj).onmouseover = function(){
this.onmousedown=function(e){
if(drag_)return false;
with(this){
var icoobj = getElementsByTagName("div")[0];
var temp0 = icoobj.offsetLeft;
var x=$event(e).clientX;
var nowleft = checknowleft(bNum+mNum*nowseat+(x-temp0)-icolength);
document.onmouseup=function(e){
nowseat = (nowleft-bNum)/mNum;
Move_autoset(nowseat);
setCookie('nowseat',(nowleft-bNum)/mNum);
}
}
}
}
}

bind(window,"load",new Function('Move_autosetdef("moveico")'));

//-->
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
      <div class="ly_dhn">
      当前位置：<a href="litscloud/tpl/index.jsp">首页</a> > <a href="litscloud/tpl/serve.jsp">云服务</a> > 云主机详情
      </div> 
      <div class="ly_dhjs">
         <h1>适用于社区网站、企业官网、门户网站、电子商务网站、SAAS应用（如：在线ERP，CRM，OA，HR）、游戏类应用等</h1>
         <h2> 云服务器基于立云自主研发的飞天大规模分布式计算系统，通过虚拟化技术整合IT资源，为各行业提供互联网基础设施服务。云服务器具有自助管理、数据安全保障、自动故障恢复和防网络攻击等高级功能，能够帮您简化开发部署过程，降低运维成本，构建按需扩展的网站架构，从而更适应互联网应用快速多变的特性。</h2>
               </div>           
        <div class="ly_rent_dl">
           <div class="ly_rent_dlr">马上注册</div>
           <div class="ly_rent_dll">已有云账号？ <span class="blue"><a href="#">马上登陆</a></span></div>
        </div>
       <div class="ly_rent_xz"><ul>
          <li style="background-image:url(litscloud/images/ly_185.gif);"><p></p><a href="#">价格<br />总览</a></li>
          <li style="background-image:url(litscloud/images/ly_186.gif);"><p></p><a href="#">云服务<br />器推荐</a></li>
          <li style="background-image:url(litscloud/images/ly_187.gif);"><p></p><a href="#">技术<br />优势</a></li>
          <li style="background-image:url(litscloud/images/ly_188.gif);"><p></p><a href="#">产品<br />详情</a></li>
          <li style="background-image:url(litscloud/images/ly_189.gif);"><p></p><a href="#">客户<br />案列</a></li>
          <li style="background-image:url(litscloud/images/ly_190.gif);"><p></p><a href="#">机房<br />照片</a></li>
          <li style="background-image:url(litscloud/images/ly_191.gif);"><p></p><a href="#">产品使<br />用帮助</a></li>
       </ul></div>  
        
      <div class="ly_m_jbt" style="margin-bottom:30px;"><span>云主机价格计算器</span></div>
    <div class="ly_m_jszc">
     <div class="ly_m_jbtu"><ul>
       
        <li><a class="c1" href="javascript:changediv('d1')" ><img src="litscloud/images/zh_15.gif" />蚌埠电信</a></li>
            <li><a class="c1" href="javascript:changediv('d2')"><img src="litscloud/images/zh_16.gif" />天长电信</a></li>
            <li><a class="c1" href="javascript:changediv('d3')"><img src="litscloud/images/zh_16.gif" />铜陵联通</a></li>
            <li><a class="c1" href="javascript:changediv('d4')"><img src="litscloud/images/zh_17.gif" />天长双线</a></li>
            <li><a class="c1" href="javascript:changediv('d5')"><img src="litscloud/images/zh_20.gif" />香港新世界</a></li>
            <li><a class="c1" href="javascript:changediv('d6')"><img src="litscloud/images/zh_18.gif" />韩国服务器</a></li>
            <li><a class="c1" id="c1" href="javascript:changediv('d7')"><img src="litscloud/images/zh_19.gif" />美国服务器</a></li>
       <li style="width:130px; background-image:none; float:right;"><span class="blue"><a href="#">教我DIY</a> | <A href="#">购买须知</A></span></li>
     </ul></div>     
      <div class="ly_m_jszc_t"></div>
        <div class="ly_m_jsq">
           <div class="ly_m_zjq">
              <div class="ly_m_zjq_t">
                <div class="ly_m_zjq_tl">
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">CPU：</div>
                      <div class="ly_m_zjq_tl_cpu_r"><ul>
                        <li><a href="#" style="background-image:url(litscloud/images/ly_197.gif); color:#fff;">1核</a></li>
                        <li><a href="#">2核</a></li>
                        <li><a href="#">4核</a></li>
                        <li><a href="#">8核</a></li>
                        <li style="width:125px; background-image:none;"><span>Xeon 2.26GHz</span></li>
                      </ul></div>
                    </div>
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">内存：</div>
                      <div class="ly_m_zjq_tl_cpu_r"><ul>
                        <li><a href="#" style="background-image:url(litscloud/images/ly_197.gif); color:#fff;">512MB</a></li>
                        <li><a href="#">1GB</a></li>
                        <li><a href="#">1.5GB</a></li>
                        <li><a href="#">2GB</a></li>
                        <li><a href="#">4GB</a></li>
                      </ul></div>
                    </div>
                    <div class="ly_m_zjq_tl_cpu">
                      <div class="ly_m_zjq_tl_cpu_l">硬盘：</div>
                      <div class="ly_m_zjq_tl_cpu_r">免费赠送（linux送20GB，Windows送40GB）</div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_sjp">
                        <div class="ly_m_zjq_tl_sjp_l">数据盘：</div>
                        <div class="ly_m_zjq_tl_sjp_c">
                        <div class="ly_m_zjq_tl_sjp_ct">
                        <div id="login" class="Box">
                        <form action="" method="post">
                       <div id="moveico"><div></div></div>
                       <div class="top"><h2 class="active" id="login-tit"></h2>&nbsp; GB</div>
                       <input type="hidden" id="login-type" name="stype" value="0" />
                        </form>
                         </div>
                         </div>
                         <div class="ly_m_zjq_tl_sjp_cd"><ul>
                            <li>0G</li>
                            <li style="text-indent:25px;">500G</li>
                            <li style="text-indent:48px;">1000G</li>
                            <li style="text-align:right;">2000G</li>
                         </ul></div>
                       </div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_sjp">
                        <div class="ly_m_zjq_tl_sjp_l">带宽：</div>
                        <div class="ly_m_zjq_tl_sjp_c">
                          <div class="ly_m_zjq_tl_sjp_ct"><img src="litscloud/images/ly_199.gif" /></div>
                          <div class="ly_m_zjq_tl_sjp_cd">当前选择：1Mbps(以1Mbps为步长增加)</div> 
                        </div>
                        <div class="ly_m_zjq_tl_sjp_r"><span>1</span>&nbsp; Mbps</div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_qy">
                       <div class="ly_m_zjq_tl_qy_l">区域：</div>
                       <div class="ly_m_zjq_tl_qy_r"><select name="ly_qy" class="ly_qy">
                         <option value="1">华东青岛</option>
                         <option value="2">华西四川</option>
                         <option value="3">华南湖南</option>
                       </select>&nbsp;<a href="#">查看我的产品区域</a>不同区域之间内网不互通，请查看<a href="#">区域选择帮助</a></div>
                    </div>
                    
                    <div class="ly_m_zjq_tl_qy">
                       <div class="ly_m_zjq_tl_qy_l">操作系统：</div>
                       <div class="ly_m_zjq_tl_qy_r"><select name="ly_qy" class="ly_qy" style="width:505px;">
                         <option value="1">Windows 标准版</option>
                         <option value="2">Windows7 标准版</option>
                         <option value="3">Windows8 标准版</option>
                       </select>&nbsp;<a href="#">教我选择</a><br />若您选择Windows（标准版），报价中已包含正版激活费用.</div>
                    </div>
                    
                </div>
                <div class="ly_m_zjq_tr">
                   <div class="ly_m_zjq_trt">您选择的云主机</div>
                   <div class="ly_m_zjq_trc">
                     <div class="ly_m_zjq_trc_t">您还没有选择任何服务器哦！</div>
                     <div class="ly_m_zjq_trc_m">您共选择了<span>0</span>台服务！</div>
                     <div class="ly_m_zjq_trc_c">总费用：<span>0</span>	元</div>
                     <div class="ly_m_zjq_trc_u">确认订单</div>
                     <div class="ly_m_zjq_trc_d"><input name="fwxy" class="ly_fwxy"  type="checkbox" value="" checked="checked" /> 《立云服务协议》</div>
                   </div>
                   <div class="ly_m_zjq_trd"></div>
                </div>
              </div>
              <div class="ly_m_zjq_c">
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">购买数量：</div>
                     <div class="ly_m_msl_r"><select name="ly_msl" class="ly_msl" style="width:90px;">
                         <option value="1">1</option>
                         <option value="2">2</option>
                         <option value="3">3</option>
                         <option value="3">4</option>
                         <option value="3">5</option>
                       </select></div>
                   </div>
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">购买时长：</div>
                     <div class="ly_m_msl_r"><select name="ly_an" class="ly_an" style="width:90px;">
                         <option value="1">按年</option>
                         <option value="2">按月</option>
                         <option value="3">按日</option>
                         <option value="3">按时</option>
                         <option value="3">按分</option>
                       </select>
                       <select name="ly_year" class="ly_year" style="width:90px;">
                         <option value="1">1年</option>
                         <option value="2">2年</option>
                         <option value="3">3年</option>
                         <option value="3">4年</option>
                         <option value="3">5年</option>
                       </select>
                       </div>
                   </div>
              </div>
              <div class="ly_m_zjq_d">
               <div class="ly_m_msl">
                     <div class="ly_m_msl_l">费用：</div>
                     <div class="ly_m_msl_r"><span>690</span> &nbsp;元 （根据您的配置，自动报价） </div>
                   </div>
                   <div class="ly_m_msl">
                     <div class="ly_m_msl_l">&nbsp;</div>
                     <div class="ly_m_msl_r"><div class="ly_m_msl_rt"><a href="#">提  交</a></div></div>
                   </div>
              </div>
           </div>
        </div>
    </div>     
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>    
        
     <div class="ly_m_bgp">
       <div class="ly_m_bgp_t"></div>
       <div class="ly_m_bgp_c">
       <div class="ly_m_bgp_cu"></div>
       <div class="ly_m_bgp_ch"><ul>
            <li><a href="#" style="color:#fff; background-image:url(images/ly_106.jpg); background-repeat:no-repeat;"><img src="images/zh_15.gif" />蚌埠电信</a></li>
            <li><a href="#"><img src="images/zh_15.gif" />天长电信</a></li>
            <li><a href="#"><img src="images/zh_16.gif" />铜陵联通</a></li>
            <li><a href="#"><img src="images/zh_17.gif" />天长双线</a></li>
            <li><a href="#"><img src="images/zh_20.gif" />香港新世界</a></li>
            <li><a href="#"><img src="images/zh_18.gif" />韩国服务器</a></li>
            <li><a href="#"><img src="images/zh_19.gif" />美国服务器</a></li>
          </ul></div>
          <div class="ly_m_bgp_ct"><img src="litscloud/images/ly_91.jpg" style="margin-top:15px;" /> BGP+CDN热门机型推荐</div>
          
          <div class="ly_m_bgp_cd">
            <div class="ly_m_bgp_cdt"></div>
            <div class="ly_m_bgp_cdc">
               <div class="ly_m_bgp_cdc_n"><ul>
                 <li>
                   <div class="ly_m_bgp_cdc_nt">
                      <div class="ly_m_bgp_cdc_ntt"><span><a href="#" style="color:#ff6600;">热销中</a></span><p>蚌埠电信E5200</p></div>
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
                    <div class="ly_m_bgp_cdc_ndc"><a href="#">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                      <div class="ly_m_bgp_cdc_ntt"><span><a href="#" style="color:#ff6600;">热销中</a></span><p>蚌埠电信E5200</p></div>
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
                    <div class="ly_m_bgp_cdc_ndc"><a href="#">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li> 
                      <li>
                   <div class="ly_m_bgp_cdc_nt">
                      <div class="ly_m_bgp_cdc_ntt"><span><a href="#" style="color:#ff6600;">热销中</a></span><p>蚌埠电信E5200</p></div>
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
                    <div class="ly_m_bgp_cdc_ndc"><a href="#">立即购买</a></div>
                    <div class="ly_m_bgp_cdc_ndr"></div>
                   </div>
                 </li>               
               </ul></div>
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
    <div class="ly_m_jbt"><span>产品详情</span></div> 
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div> 
       <div class="ly_m_jft_u"><ul>
         <li>
          <dl><img src="litscloud/images/ly_172.gif" /></dl>
          <dt>安全稳定，数据可靠</dt>
          <span>在无地震等重大自然灾害下，云服务器数据可靠性可达99.999%，让您的数据安全无忧！</span>
          <dd> 数据安全：采用大规模分布式计算系统，每份数据多个副本；单份损坏可以在短时间内快速恢复，保证数据安全。<br />
 
网络安全：安全组之间采用防火墙隔离；可杜绝ARP攻击和MAC欺骗；有效防护DDoS攻击,可进行端口入侵扫描，
   挂马扫描，漏洞扫描等。<br />

系统稳定：可用性高达99.9%，支持云服务器故障自动迁移，恢复速度快，云服务器信息不变 （IP信息，磁盘等）。
</dd>
         </li>
                  <li>
          <dl><img src="litscloud/images/ly_173.gif" /></dl>
          <dt>性能卓越，弹性伸缩</dt>
           <span>采用绿色节能多线路机房，中国电信、联通、教育网等多线接入，保证全国用户高速访问。</span>          
          <dd>   多线路独享带宽：千兆光纤，业内最低价扩容带宽，独享带宽有效解决带宽瓶颈,性价比远高于传统带宽共享。 
<br />
  灵活扩容：计算资源可弹性伸缩；可以按需变更服务器的配置。云服务器支持套餐升级、带宽灵活按天升级
（无需停机）等，随时满足您的业务发展需求。


</dd>
         </li>
            <li>
          <dl><img src="litscloud/images/ly_174.gif" /></dl>
          <dt>节约成本，简单易用</dt>
          <span>支持多种主流操作系统，让您以服务的方式使用计算及存储资源，按需取用，按需付费，无需购买大量
设备，相比于传统主机投入成本降低30%-80%。</span>
          <dd> 
  完整管理权限：云服务器从创建到启动只需数分钟，您拥有超级管理员权限，轻松部署各种互联网应用。通过Web
管理方式对云服务器进行停机、启动、重启、重置和修改密 码等操作。<br />
 
  按需购买：云服务器配置按需购买，灵活满足不断变化的应用需求。建议搭配RDS使用，内网流量免费。
<br /> 
 高效的运维与客服:免费7X24小时客服支持；部署和备份/恢复更快捷，节省宝贵时间；数据和服务更可靠、更安全，
轻松帮您节省20%-70%人力运维成本。

</dd>
         </li>
   
       </ul></div>
     <div class="ly_n_weibu"></div>   
      <div class="ly_m_jbt"><span>客户案例</span></div> 
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div>
       <div class="ly_m_kal">
         <div class="ly_m_kal_t">
           <div class="ly_m_kal_tl"><img src="litscloud/images/ly_176.gif" /></div>
           <div class="ly_m_kal_tc"><img src="litscloud/images/ly_177.gif" /> </div>
           <div class="ly_m_kal_tm">IT007（小熊在线）创立于2001年，是云南地区第一家专业IT网络媒体，也是迄今为止云南最大最专业的IT网站。在云南IT网络广告市场拥有超过90%的市场占有率，具备完善的公司架构和丰富的客户资源。<br /><br /> 

购买服务：云服务器 + 关系型数据库
</div>
           <div class="ly_m_kal_tr"><img src="litscloud/images/ly_175.gif" /></div>
         </div>
         <div class="ly_m_kal_d">
           <div class="ly_m_kal_dt"></div>
           <div class="ly_m_kal_dc">
             <div class="ly_m_kal_dcn"><span>客户使用心得：</span><br />
  &nbsp;&nbsp;&nbsp;"页面打开很快，网站成员和读者都很满意。阿里云的工单方式比起传统IDC和机房封闭式的霸道管理
人性化了很多，另外在解决问题时客户的电话很及时。希望网站在阿里云上能发展的更好。"
</div>
           </div>
           <div class="ly_m_kal_dd"></div>
         </div>
       </div>
     </div>
     <div class="ly_n_weibu"></div>
     
     <div class="ly_m_jbt"><span>机房实景图片</span></div>
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div>
       <div class="ly_m_jft_d"><ul>
         <li><img src="litscloud/images/xl_07.gif" /></li>
         <li><img src="litscloud/images/xl_08.gif" /></li>
         <li><img src="litscloud/images/xl_09.gif" /></li>
         <li><img src="litscloud/images/xl_10.gif" /></li>
       </ul></div>
     </div>
    <div class="ly_n_weibu" ></div>
   
   <div class="ly_m_jbt"><span>产品使用帮助</span></div> 
     <div class="ly_m_jft">
       <div class="ly_m_jft_t"></div>
       <div class="ly_m_cpb">
         <div class="ly_m_cpb_n">
           <div class="ly_m_cpb_nl">
             <div class="ly_m_cpb_nlt">操作指南</div>
             <div class="ly_m_cpb_nlc">
               <div class="ly_m_cpb_nlcl"></div>
               <div class="ly_m_cpb_nlcr"></div>
             </div>
             <div class="ly_m_cpb_nld"><ul>
               <li><a href="#">远程连接for linux</a></li>
               <li><a href="#">Linux FTP服务配置</a></li>
               <li><a href="#">远程连接for Windows</a></li>
               <li><a href="#">Windows FTP服务配置</a></li>
             </ul></div>
           </div>
           <div class="ly_m_cpb_nl">
             <div class="ly_m_cpb_nlt">资料中心</div>
             <div class="ly_m_cpb_nlc">
               <div class="ly_m_cpb_nlcl"></div>
               <div class="ly_m_cpb_nlcr"></div>
             </div>
             <div class="ly_m_cpb_nld"><ul>
               <li><a href="#">云服务器用户管理指南</a></li>
               <li><a href="#">云服务器技术白支书</a></li>
             </ul></div>
           </div>
           <div class="ly_m_cpb_nl">
             <div class="ly_m_cpb_nlt">常见问题</div>
             <div class="ly_m_cpb_nlc">
               <div class="ly_m_cpb_nlcl"></div>
               <div class="ly_m_cpb_nlcr"></div>
             </div>
             <div class="ly_m_cpb_nld"><ul>
               <li><a href="#">ip类相关问题</a></li>
               <li><a href="#">机房有关问题</a></li>
               <li><a href="#">配置升级相关问题</a></li>
               <li><a href="#">操作系统相关问题</a></li>
               <li><a href="#">带宽相关问题</a></li>		
             </ul></div>
           </div>
           <div class="ly_m_cpb_nr">
               <div class="ly_m_cpb_nrt"><a href="#">更多...</a></div>
               <div class="ly_m_cpb_nrd"></div>
           </div>
           
         </div>
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
