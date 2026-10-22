<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-云服务(立即购买)</title>
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
<body style="background-color:#0C9;">
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
                    <div class="zf_gmt_cqtl">CPU:</div>
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
</body>
</html>
