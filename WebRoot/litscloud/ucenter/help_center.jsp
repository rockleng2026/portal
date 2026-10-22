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

      <div class="ly_imiddle">
     
       <div class="ly_dh" style="height:4px;overflow:hidden;">          
      </div>
      <div class="ly_baise">
      <div class="ly_dhn">
      当前位置：<a href="index.html">首页</a> > 帮助中心</div>  
      <div class="ly_help">
         <div class="ly_help_t">
            <div class="ly_help_tm">
               <div class="ly_help_tml"></div>
               <div class="ly_help_tmc">标题一</div>
               <div class="ly_help_tmr"></div>
            </div>
         </div>
         <div class="ly_help_c">作者：<span>李四</span>  &nbsp;&nbsp;&nbsp;&nbsp;  发表时间：<span>2013-03-26</span>   &nbsp;&nbsp;&nbsp;&nbsp;   浏览次数：<span>464</span></div>
         <div class="ly_help_m">

    服务器所在地: 江西
    服务器CPU类型: 其它CPU类型
    服务器内存大小: 4G
    服务器线路环境: 双线切换(电信+网通)

    江西省: 南昌 NANCHANG
    服务器硬盘类型: SATAII
    付费方式: 月付
    带宽标准: 6-10M

    服务器支持CPU个数: 1
    服务器硬盘容量: 其它服务器硬盘容量
    服务器结构: 1U

产品配置

    CPU: Intel酷睿2双核 E5200
    内存: 2G DDR800 KinSton
    硬盘:160GB 7200RPM SAT
    主板: Gigabyte G31-ES2</div>
         <div class="ly_help_d">
           <div class="ly_help_dm">
               <div class="ly_help_dl"></div>
               <div class="ly_help_dc"><a href="#">返 &nbsp; 回</a></div>
               <div class="ly_help_dr"></div>
           </div>
         </div>
      </div>
   </div>   
   </div>
<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>
