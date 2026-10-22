<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（在线支付支付信息）支付宝支付</title>
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
           <div class="bg_zfxx">
             <div class="bg_zfxx_t">支付信息</div>
             <div class="bg_zfxx_c">
               <div class="bg_zfxx_cl"></div>
               <div class="bg_zfxx_cr"></div>
             </div>
             <div class="bg_zfxx_m">通过[支付宝]支付平台，使用[支付宝]支付</div>
             <div class="bg_zfxx_d">
               <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款人姓名：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款人地址：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款人电话：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款人邮编：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款人金额：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款日期：</div>
                  <div class="bg_zfxx_dtr"><input type="text" name="bg_fkname" class="fkbd" /></div></div>
                  <div class="bg_zfxx_dt">
                  <div class="bg_zfxx_dtl"><span>*</span>付款币种：</div>
                  <div class="bg_zfxx_dtr"><input name="" type="checkbox" value="人民币" /> 人民币</div></div>
                  <div class="bg_zfxx_dd"><a href="#">去网上银行充值</a></div>
               </div>
             </div>
           </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</body>
</html>
