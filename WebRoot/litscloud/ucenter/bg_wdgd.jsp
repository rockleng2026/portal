<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-我的工单）</title>
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
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心</div> 
          
             <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
        <div class="bg_wd">
             <div class="ly_xxt">
               <div class="ly_xxtl">工单查询</div>        
             </div>
             <div class="bg_wdc">
               <div class="bg_wdc_l">IP/账号： <select name="ip_zh" style="width:121px; border:solid 1px #c9c9c9;">
                  <option value="1">192.168.2.3</option>
                  <option value="2">192.168.3.3</option>
                  <option value="4">192.168.5.10</option>
               </select></div>
               <div class="bg_wdc_l">产品类型： <select name="ip_cp" style="width:121px; border:solid 1px #c9c9c9;">
                  <option value="1">htcone</option>
                  <option value="2">htcone</option>
                  <option value="4">htcone</option>
               </select></div>
               <div class="bg_wdc_l">问题类型 ：<select name="ip_wt" style="width:121px; border:solid 1px #c9c9c9;">
                  <option value="1">主机坏了</option>
                  <option value="2">上不了网</option>
                  <option value="4">流量不足</option>
               </select></div>
               <div class="bg_wdc_c"><select name="ip_wt" style="width:160px; border:solid 1px #c9c9c9; margin-top:2px;">
                  <option value="1">选择时间范围</option>
                  <option value="2">2011-01-12</option>
                  <option value="3">2011-01-12</option>
               </select></div>
               <div class="bg_wdc_r"><a href="#"><img src="litscloud/images/zf_41.gif" /></a></div>
             </div>
             <div class="bg_wdm">
                <div class="bg_wdm_t">
                   <div class="bg_wdm_tq">选择</div>
                   <div class="bg_wdm_tw">产品类型</div>
                   <div class="bg_wdm_te">IP/帐号</div>
                   <div class="bg_wdm_tr">问题类型</div>
                   <div class="bg_wdm_tt">处理状态</div>
                   <div class="bg_wdm_ty">创建时间</div>
                   <div class="bg_wdm_tu">操作</div>
                </div>
                <div class="bg_wdm_d">
                   <div class="bg_wdm_dt">
                      <div class="bg_wdm_dtq"><input name="dd_xz" type="checkbox" value="选中" class="dd_xz" checked="checked" /></div>
                      <div class="bg_wdm_dtw">托管主机</div>
                      <div class="bg_wdm_dte">2013032501489
</div>
                      <div class="bg_wdm_dtr">重新安装</div>
                      <div class="bg_wdm_dtt">已接收</div>
                      <div class="bg_wdm_dty"><p></p>2013-03-25<br /> 17:05:21</div>
                      <div class="bg_wdm_dtu"><a href="#">删除</a><br /><a href="#">评价</a><br /><a href="#">详情</a><br /></div>
                   </div>
                   <div class="bg_wdm_dt">
                      <div class="bg_wdm_dtq"><input name="dd_xz" type="checkbox" value="选中" class="dd_xz" checked="checked" /></div>
                      <div class="bg_wdm_dtw">托管主机</div>
                      <div class="bg_wdm_dte">2013032501489
</div>
                      <div class="bg_wdm_dtr">重新安装</div>
                      <div class="bg_wdm_dtt">已接收</div>
                      <div class="bg_wdm_dty"><p></p>2013-03-25<br /> 17:05:21</div>
                      <div class="bg_wdm_dtu"><a href="#">删除</a><br /><a href="#">评价</a><br /><a href="#">详情</a><br /></div>
                   </div>
                   <div class="bg_wdm_dt">
                      <div class="bg_wdm_dtq"><input name="dd_xz" type="checkbox" value="选中" class="dd_xz"/></div>
                      <div class="bg_wdm_dtw">托管主机</div>
                      <div class="bg_wdm_dte">2013032501489
</div>
                      <div class="bg_wdm_dtr">重新安装</div>
                      <div class="bg_wdm_dtt">已接收</div>
                      <div class="bg_wdm_dty"><p></p>2013-03-25<br /> 17:05:21</div>
                      <div class="bg_wdm_dtu"><a href="#">删除</a><br /><a href="#">评价</a><br /><a href="#">详情</a><br /></div>
                   </div>
                   <div class="bg_wdm_dt">
                      <div class="bg_wdm_dtq"><input name="dd_xz" type="checkbox" value="选中" class="dd_xz" /></div>
                      <div class="bg_wdm_dtw">托管主机</div>
                      <div class="bg_wdm_dte">2013032501489
</div>
                      <div class="bg_wdm_dtr">重新安装</div>
                      <div class="bg_wdm_dtt">已接收</div>
                      <div class="bg_wdm_dty"><p></p>2013-03-25<br /> 17:05:21</div>
                      <div class="bg_wdm_dtu"><a href="#">删除</a><br /><a href="#">评价</a><br /><a href="#">详情</a><br /></div>
                   </div>
                </div>
                <div class="bg_wdm_s">
                  <div class="bg_wdm_sl"><input name="qx_xz" type="checkbox" value="全选" style="float:left; margin-right:15px; margin-top:3px;" />
                   <a href="#">全选</a>
                   <a href="#">反选</a>
                   <a href="#">删除</a>
                  </div>
                  <div class="bg_wdm_sr">
                     <div class="ly_zhm_sd">打印]</div>
                  <div class="ly_zhm_sz">转到<input type="text" name="zy" class="zy" /> 页</div>
                  <div class="ly_zhm_ss">页数：1/15</div>
                  <div class="ly_zhm_sw"><a href="#">尾页</a></div>
                  <div class="ly_zhm_sx"><a href="#">下一页</a></div>
                  <div class="ly_zhm_sx"><a href="#">上一页</a></div>
                  <div class="ly_zhm_sw"><a href="#">首页</a></div>
                  <div class="ly_zhm_sd" style="width:90px;">[共96条记录</div>
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
