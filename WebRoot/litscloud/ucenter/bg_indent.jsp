<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-订单管理）</title>
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
         <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
                <div class="bg_dq">
                    <div class="bg_id">
                       <div class="bg_idt">
                         <div class="bg_idtl">宝贝</div>
                         <div class="bg_idtw">单位（元）</div>
                         <div class="bg_idte">数量</div>
                         <div class="bg_idtr">售后</div>
                         <div class="bg_idtt">实付款</div>
                         <div class="bg_idty">交易状态</div>
                         <div class="bg_idtu">交易操作</div>
                       </div>
                       <div class="bg_idm">
                         <div class="bg_idml"><input name="checkq" type="checkbox" value="全选" style="margin-left:5px;" /> 全选</div>
                         <div class="bg_idmc">批量确认</div>
                         <div class="bg_idmr"><a href="#">上一页</a><a href="#">下一页</a></div>
                       </div>
                       <div class="bg_idc">
                         <div class="bg_idc_t"><input name="check1" type="checkbox" value="选择" style="margin-left:5px; margin-top:5PX; float:left;" />&nbsp;&nbsp;订单编号：&nbsp;&nbsp;  XSDD-418942165489326  &nbsp;&nbsp;   开始时间：2013-02-11 &nbsp;&nbsp; 结束时间：2013-03-22 &nbsp;&nbsp;   陈阳   </div>
                         <DIV class="bg_idc_D">
                            <DIV class="bg_idc_Dl"><img src="litscloud/images/bg_29.png" /></DIV>
                            <DIV class="bg_idc_Dq">
                              <DIV class="bg_idc_Dqt"><a href="#"><img src="litscloud/images/bg_30.png" /></a></DIV>
                              <DIV class="bg_idc_Dqd">ip数量：1 宽带总数：10<br />
服务器配置：I3  Windows2003</DIV>
                            </DIV>
                            <DIV class="bg_idc_Dw">￥1200.0</DIV>
                            <DIV class="bg_idc_De">1</DIV>
                            <DIV class="bg_idc_Dr"><p></p><a href="#">投 诉</a><br />
<a href="#">评 价</a></DIV>
                            <div class="bg_idc_Dt"> <p></p> ￥1200.0 <br />付费类型：季付</div>
                            <div class="bg_idc_Dy"><p></p><a href="#">订单详情</a><br /><a href="#">查看物流</a></div>
                            <div class="bg_idc_Du"><a href="#">订单流程</a></div>
                         </DIV>
                       </div>
                       <div class="bg_idc">
                         <div class="bg_idc_t"><input name="check1" type="checkbox" value="选择" style="margin-left:5px; margin-top:5PX; float:left;" />&nbsp;&nbsp;订单编号：&nbsp;&nbsp;  XSDD-418942165489326  &nbsp;&nbsp;   开始时间：2013-02-11 &nbsp;&nbsp; 结束时间：2013-03-22 &nbsp;&nbsp;   陈阳   </div>
                         <DIV class="bg_idc_D">
                            <DIV class="bg_idc_Dl"><img src="litscloud/images/bg_29.png" /></DIV>
                            <DIV class="bg_idc_Dq">
                              <DIV class="bg_idc_Dqt"><a href="#"><img src="litscloud/images/bg_30.png" /></a></DIV>
                              <DIV class="bg_idc_Dqd">ip数量：1 宽带总数：100<br />
服务器配置： Centos</DIV>
                            </DIV>
                            <DIV class="bg_idc_Dw">￥3500.0</DIV>
                            <DIV class="bg_idc_De">1</DIV>
                            <DIV class="bg_idc_Dr"><p></p><a href="#">投 诉</a><br />
<a href="#">评 价</a></DIV>
                            <div class="bg_idc_Dt"> <p></p> ￥3500.0 <br />付费类型：季付</div>
                            <div class="bg_idc_Dy"><p></p><a href="#">订单详情</a><br /><a href="#">查看物流</a></div>
                            <div class="bg_idc_Du"><a href="#">订单流程</a></div>
                         </DIV>
                       </div>
                       <div class="bg_idc">
                         <div class="bg_idc_t"><input name="check1" type="checkbox" value="选择" style="margin-left:5px; margin-top:5PX; float:left;" />&nbsp;&nbsp;订单编号：&nbsp;&nbsp;  XSDD-418942165489326  &nbsp;&nbsp;   开始时间：2013-02-11 &nbsp;&nbsp; 结束时间：2013-03-22 &nbsp;&nbsp;   陈阳   </div>
                         <DIV class="bg_idc_D">
                            <DIV class="bg_idc_Dl"><img src="litscloud/images/bg_29.png" /></DIV>
                            <DIV class="bg_idc_Dq">
                              <DIV class="bg_idc_Dqt"><a href="#"><img src="litscloud/images/bg_30.png" /></a></DIV>
                              <DIV class="bg_idc_Dqd">ip数量：1 宽带总数：100<br />
服务器配置： Centos</DIV>
                            </DIV>
                            <DIV class="bg_idc_Dw">￥3500.0</DIV>
                            <DIV class="bg_idc_De">1</DIV>
                            <DIV class="bg_idc_Dr"><p></p><a href="#">投 诉</a><br />
<a href="#">评 价</a></DIV>
                            <div class="bg_idc_Dt"> <p></p> ￥3500.0 <br />付费类型：季付</div>
                            <div class="bg_idc_Dy"><p></p><a href="#">订单详情</a><br /><a href="#">查看物流</a></div>
                            <div class="bg_idc_Du"><a href="#">订单流程</a></div>
                         </DIV>
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
