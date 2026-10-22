<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-工单详情）</title>
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
              <div class="bg_wdt">
                 <div class="bg_wdt_t">工单详情</div>
                 <div class="bg_wdt_c">
                   <dl>
                    <dt>客户姓名：</dt>
                    <dd>张三</dd>
                    <dt>产品类型：</dt>
                    <dd>托管主机</dd>
                   </dl> 
                   <dl>
                    <dt>IP/ 帐号：</dt>
                    <dd>192.168.1.200</dd>
                    <dt>产品类型：</dt>
                    <dd>产品瘤</dd>
                   </dl> 
                   <dl>
                    <dt>处理状态：</dt>
                    <dd>运维人员已接收</dd>
                    <dt>产品类型：</dt>
                    <dd>1534654858526</dd>
                   </dl> 
                   <dl>
                    <dt>网站域名：</dt>
                    <dd>www.fihfid.com</dd>
                    <dt>产品类型：</dt>
                    <dd>fafijkhf@163.com</dd>
                   </dl>                   
                 </div>
                 <div class="bg_wdt_c">
                   <div class="bg_wdt_cq">
                      <div class="bg_wdt_cqt">问题描述：</div>
                      <div class="bg_wdt_cqd">    这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理，原
因是这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理，原
因是这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理，原因是这个问题不是很好处理.</div>
                   </div>                 
                 </div>
                 <div class="bg_wdt_c">
                   <div class="bg_wdt_cq">
                      <div class="bg_wdt_cqt">附件信息：</div>
                      <div class="bg_wdt_cqc">
                        <div class="bg_wdt_cqcl">
                          <div class="bg_wdt_cqcll"><img src="litscloud/images/zh_10.gif" /></div>
                          <div class="bg_wdt_cqclr">
                             <div class="bg_wdt_cqclrt"> 分析情况.rar <span>（560k）</span> </div>
                             <div class="bg_wdt_cqclrd"><a href="#">下载</a><a href="#">预览</a><a href="#">转存到中转站</a></div>
                          </div>
                        </div>
                        <div class="bg_wdt_cqcl">
                          <div class="bg_wdt_cqcll"><img src="litscloud/images/zh_11.gif" /></div>
                          <div class="bg_wdt_cqclr">
                             <div class="bg_wdt_cqclrt"> 分析情况.rar <span>（560k）</span> </div>
                             <div class="bg_wdt_cqclrd"><a href="#">下载</a><a href="#">预览</a><a href="#">转存到中转站</a></div>
                          </div>
                        </div>
                        <div class="bg_wdt_cqcl">
                          <div class="bg_wdt_cqcll"><img src="litscloud/images/zh_12.gif" /></div>
                          <div class="bg_wdt_cqclr">
                             <div class="bg_wdt_cqclrt"> 分析情况.rar <span>（560k）</span> </div>
                             <div class="bg_wdt_cqclrd"><a href="#">下载</a><a href="#">预览</a><a href="#">转存到中转站</a></div>
                          </div>
                        </div>
                      </div>
                   </div>                 
                 </div>
                 
               <div class="bg_wdt_m">
                   <div class="bg_wdt_mt">处理描述一：<span>2013-03-21</span> &nbsp;&nbsp;    运维人<span>张三</span>回复:</div>
                   <div class="bg_wdt_md">这个问题不是深圳运维能处理的，请客服人员转接到珠海运维</div>
                   <div class="bg_wdt_mt">处理描述一：<span>2013-03-21</span> &nbsp;&nbsp;    运维人<span>张三</span>回复:</div>
                   <div class="bg_wdt_md">这个问题不是深圳运维能处理的，请客服人员转接到珠海运维</div>
                   <div class="bg_wdt_mt">客服回复：<span>2013-03-21</span> </div>
                   <div class="bg_wdt_md">张先生您的故障意已经处理完毕，请验收！</div>
                   <div class="bg_wdt_mt"> 客户评价：<span>2013-03-21</span> &nbsp;&nbsp;  </div>
                   <div class="bg_wdt_md">我提出的问题处理的非常好，很满意</div>
                   <div class="bg_wdt_mt">  客户评分：<span>2013-03-21</span> &nbsp;&nbsp;  </div>
                   <div class="bg_wdt_md"><img src="litscloud/images/log_40.gif" style="float:left; margin-right:5px;" />
                   <img src="litscloud/images/log_40.gif" style="float:left; margin-right:5px;" />
                   <img src="litscloud/images/log_40.gif" style="float:left; margin-right:5px;" />
                   <img src="litscloud/images/log_40.gif" style="float:left; margin-right:5px;" />
                   <span>5分</span>
                   </div>
               </div>  
                 <div class="bg_wdt_d">
                   <div class="bg_wdt_dl"></div>
                   <div class="bg_wdt_dc"><a href="#">返回工单</a></div>
                   <div class="bg_wdt_dr"></div>
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
