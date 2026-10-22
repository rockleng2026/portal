<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（支付输入错误）</title>
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
         <div class="bg_zf">
              <div class="bg_zft"><span>您好，欢迎使用支付宝付款！<a href="#">支付遇到问题？</a></span><img src="litscloud/images/zf_01.gif" /></div>
              <div class="bg_zfm">
                 <div class="bg_zfmt"></div>
                 <div class="bg_zfmc">
                   <div class="bg_zfmcl">
                    <div class="bg_zfmct"><img src="litscloud/images/zf_08.gif" />您正在使用即时到帐交易<img src="litscloud/images/zf_09.gif" /></div>
                    <div class="bg_zfmcc">立云预付款录款</div>
                    <div class="bg_zfmcd">商品描述：万网预付款<br />
收款方：深圳立云科技有限公司<br />
交易金额：2000.00元<br />
交易类型： <img src="litscloud/images/zf_08.gif" />  即时到帐交易</div></div>
 <div class="bg_zfmcr">￥<span>2000.00</span>元</div>
                 </div>
                 <div class="bg_zfmd"></div>
              </div> 
              <div class="bg_zfu">
                 <div class="bg_zful">
                    <div class="bg_zful_t"></div>
                    <div class="bg_zful_c">
                       <div class="bg_zful_ct">我有支付宝账户，轻松付款：</div>
                       <div class="bg_zful_cc">
                          <div class="bg_zful_cct">
                            <div class="bg_zful_cctl">支付宝账户：</div>
                            <div class="bg_zful_cctr">
                                <div class="bg_zful_cctrt"><input type="text" class="bg_yxhm" name="bg_yxhm" value="邮箱地址或手机号码" /> <a href="#">忘记账户名</a></div>
                                <div class="bg_zful_cctrd"><img src="litscloud/images/bg_39.jpg" /> 请输入正确的Email地址或11位手机号码。</div>
                            </div>
                          </div>
                          <div class="bg_zful_cct">
                            <div class="bg_zful_cctl">支付密码：</div>
                            <div class="bg_zful_cctr">
                                <div class="bg_zful_cctrt"><input type="password" class="bg_yxhm" name="bg_yxhm" value="" /> <a href="#">忘记密码？</a></div>
                                <div class="bg_zful_cctrd"><img src="litscloud/images/bg_39.jpg" /> 请填写支付密码。</div>
                            </div>
                          </div>
                          <div class="bg_zful_cct">
                            <div class="bg_zful_cctl">验证码：</div>
                            <div class="bg_zful_cctr">
                                <div class="bg_zful_cctrt"><input type="text" class="bg_yzms" name="bg_yzms" value="" /> <img src="litscloud/images/bg_20.png" style="float:left; margin-right:5px;" /> <a href="#">看不清，换一张？</a></div>
                                <div class="bg_zful_cctrd"><img src="litscloud/images/bg_39.jpg" /> 请填写验证码。</div>
                            </div>
                          </div>
                       </div>
                       <div class="bg_zful_cd"><a href="#">下一步</a></div>
                    </div>
                    <div class="bg_zful_d"></div>
                 </div>
                 
                 <div class="bg_zful" style="float:left; margin-left:5px;">
                    <div class="bg_zful_t"></div>
                    <div class="bg_zful_c">
                       <div class="bg_zful_ct">我没有支付宝账户，也能付款：</div>
                       <div class="bg_zful_cm">支持国内众多主流银行，有卡就能付！</div>
                       <div class="bg_zful_cc">
                          <div class="bg_zful_cct">
                            <div class="bg_zful_cctl">邮箱或手机号：</div>
                            <div class="bg_zful_cctr">
                                <div class="bg_zful_cctrt"><input type="text" class="bg_yxhm" name="bg_yxhm" value="邮箱地址或手机号码" /> <a href="#">忘记账户名</a></div>
                                <div class="bg_zful_cctrd"><img src="litscloud/images/bg_39.jpg" /> 请填写邮箱或手机号。</div>
                            </div>
                          </div>
                          <div class="bg_zful_cct">
                            <div class="bg_zful_cctl">验证码：</div>
                            <div class="bg_zful_cctr">
                                <div class="bg_zful_cctrt"><input type="text" class="bg_yzms" name="bg_yzms" value="" /> <img src="litscloud/images/bg_20.png" style="float:left; margin-right:5px;" /> <a href="#">看不清，换一张？</a></div>
                                <div class="bg_zful_cctrd"><img src="litscloud/images/bg_39.jpg" /> 请填写验证码。</div>
                            </div>
                          </div>
                       </div>
                       <div class="bg_zful_cd"><a href="#">下一步</a></div>
                    </div>
                    <div class="bg_zful_d"></div>
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
