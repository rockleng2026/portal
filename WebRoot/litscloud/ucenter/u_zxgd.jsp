<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-订单管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
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
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <!-- 菜单2S -->
          <jsp:include page="/litscloud/ucenter/menu_4.jsp"></jsp:include>
          <!-- 菜单2E -->
          <div class="bg_zx">
             <div class="bg_zxt">
                <div class="bg_zxtl">产品类型：</div>
                <div class="bg_zxtr"><select name="zx_cplx" class="zx_cplx">
                  <option value="1">自由主机</option>
                  <option value="2">自由主机2</option>
                  <option value="3">自由主机3</option>
                </select></div>
             </div>
             <div class="bg_zxt">
                <div class="bg_zxtl">IP或者帐号：</div>
                <div class="bg_zxtr"><select name="zx_zh" class="zx_cplx">
                  <option value="1">-----请选择-----</option>
                  <option value="2">wangtowang</option>
                  <option value="3">towangto</option>
                </select></div>
             </div>
             <div class="bg_zxt">
                <div class="bg_zxtl">请勾选确认：</div>
                <div class="bg_zxtr"><input name="zx_gx" type="radio" value="确认" />请确认您提交的产品类型与问题类别，否则不予受理!</div>
             </div>
              <div class="bg_zxt">
                <div class="bg_zxtl">问题类别：</div>
                <div class="bg_zxtr"><select name="zx_lb" class="zx_cplx">
                  <option value="1">-----请选择-----</option>
                  <option value="2">主机什么的？</option>
                  <option value="3">什么配置的？</option>
                </select></div>
             </div>
              <div class="bg_zxt">
                <div class="bg_zxtl">是否支付费用：</div>
                <div class="bg_zxtr"><input name="zx_zf" type="radio" value="是" />产生费用</div>
             </div>
            <div class="bg_zxt">
                <div class="bg_zxtl">免费声明：</div>
                <div class="bg_zxtr"><input name="zx_mfsm" type="radio" value="免费" />免费声名对于会员号下所要求的任何操作而引起的任何影响，我公司均不承担任何责任</div>
             </div> 
            <div class="bg_zxt">
                <div class="bg_zxtl">手机号码：</div>
                <div class="bg_zxtr"><input name="zx_sjhm" type="radio" value="手机号码" />确认手机号码，方便给您短信回复！ <span>48565653266</span></div>
             </div>
            <div class="bg_zxt">
                <div class="bg_zxtl">邮箱号码：</div>
                <div class="bg_zxtr"><input name="zx_email" type="radio" value="邮箱" />确认邮箱，方便给您短信回复！ <span>48565653@qq.com</span></div>
             </div>
             <div class="bg_zxt">
                <div class="bg_zxtl">网站域名：</div>
                <div class="bg_zxtr"><input type="text" name="zx_wzym" class="zx_wzym" value="http://" />方便技术人员第一时间处理您的问题。</div>
             </div> 
             <div class="bg_zxt">
                <div class="bg_zxtl">问题描述：</div>
                <div class="bg_zxtm">
                  <textarea name="zx_wtms" class="zx_wtms">涉及到相关空间域名的时候，请留下相关的帐号或者域名</textarea>
                </div>                
             </div>   
             <div class="bg_zxt">
                <div class="bg_zxtl">授权码：</div>
                <div class="bg_zxtr"><input type="text" name="zx_wzym" class="zx_wzym" value="5485344" />请输入授友码验证唯一性，真实性</div>
             </div>  
             <div class="bg_zxd">
                <div class="bg_zxdl"><a href="javascript:alert('暂未开通!');">提交</a></div> 
                <div class="bg_zxdr"><a href="javascript:void(0);">重置</a></div> 
             </div> 
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
