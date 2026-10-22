<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（账户信息）</title>
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

</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">         
             <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include> 
           <div class="ly_xx">
             <div class="ly_xxt">
               <div class="ly_xxtl">账户信息查询</div>
               <div class="ly_xxtc">您当前的帐号佘额为：<span>0.00</span> 元       您目前是：会员客户 &nbsp;&nbsp;&nbsp;<a href="#"><img src="litscloud/images/zh_01.gif" style=" margin-top:5px;" /></a> </div>         
             </div>
             <div class="ly_xxc">
               <div class="ly_xxc_l"><img src="litscloud/images/zh_02.gif" /></div>
               <div class="ly_xxc_r">
                  <div class="ly_xxc_rt">姓名：<span>冰柠檬</span> &nbsp;<a href="#"> <img src="litscloud/images/zh_03.gif" /></a></div>
                  <div class="ly_xxc_rt">帐户名：<span>fjfjdijfie-wq@163.com</span> &nbsp;<a href="#">修改</a>｜<a href="#">开启手机登陆</a></div>
                   <div class="ly_xxc_rt">立云帐户名：<a href="#"><span>uefhif-mefj</span></a></div>
               </div>
             </div>
             <div class="ly_xxm">
                <div class="ly_xxm_t">帐户的可用佘额</div>
                <div class="ly_xxm_m"></div>
                <div class="ly_xxm_c">
                  <div class="ly_xxm_ct">
                     <dl>
                     <dt>预付款佘额：</dt>
                     <dd>0.00</dd>
                     <dt>保证金佘额：</dt>
                     <dd>0.00</dd>
                     </dl>
                  </div>
                  <div class="ly_xxm_ct">
                     <dl>
                     <dt>可用返点：</dt>
                     <dd>0.00</dd>
                     <dt>包销款佘额：</dt>
                     <dd>0.00</dd>
                     </dl>
                  </div>
                  <div class="ly_xxm_ct">
                     <dl>
                     <dt>可打印发票佘额：</dt>
                     <dd>0.00</dd>
                     <dt>未支付单佘额：</dt>
                     <dd>0.00</dd>
                     </dl>
                  </div>
                  <div class="ly_xxm_ct">
                     <dl>
                     <dt>可用积分：</dt>
                     <dd>0.00</dd>
                     </dl>
                  </div>
                </div>
                <div class="ly_xxm_d"></div>
             </div>
             <div class="ly_xxd">
               <div class="ly_xxd_l">
                 <div class="ly_xxd_ll"><img src="litscloud/images/zh_06.gif" /></div>
                 <div class="ly_xxd_lr">
                    <div class="ly_xxd_lrt">手机 （<span>137****6922</span>）</div>
                    <div class="ly_xxd_lrc">已绑定</div>
                    <div class="ly_xxd_lrd"><a href="#">修改</a> | <a href="#">其他手机服务</a></div>
                 </div>
               </div>
               <div class="ly_xxd_l">
                 <div class="ly_xxd_ll"><img src="litscloud/images/zh_08.gif" /></div>
                 <div class="ly_xxd_lr">
                    <div class="ly_xxd_lrt">实名认证</div>
                    <div class="ly_xxd_lrc">待升级</div>
                    <div class="ly_xxd_lrd"><a href="#">查看</a> | <a href="#">升级</a></div>
                 </div>
               </div>
               <div class="ly_xxd_l">
                 <div class="ly_xxd_ll"><img src="litscloud/images/zh_07.gif" /></div>
                 <div class="ly_xxd_lr">
                    <div class="ly_xxd_lrt">数字证书</div>
                    <div class="ly_xxd_lrc">已申请，未安装</div>
                    <div class="ly_xxd_lrd"><a href="#">取消</a> | <a href="#">安装</a></div>
                 </div>
               </div>               
             </div>
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
