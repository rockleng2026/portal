<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
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
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.7.2.min.js"></script>
<!--<script type="text/javascript">
$(document).ready(function(){ 
			var tt = (new Date()).getTime();
		   var url = "litscloud/litscloudgetOrderCustomerServerC.Action";
		   $("#d3").load(url);
		   });
</script>
  -->
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
          <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include>
          <!-- 菜单2E -->
          <div class="ind_vew">
               <div class="ind_vew_t"><span>订单类型：购买订单</span>订单详情</div>
               <div class="ind_vew_c">
                  <div class="ind_vew_ct">订单信息</div>
                  <div class="ind_vew_cc">
                    <div class="ind_vew_ccl"></div>
                    <div class="ind_vew_ccr"></div>
                  </div>
                  <div class="ind_vew_cm">
                     <div class="ind_vew_cmt">
                        <c:forEach items="${solist3 }" var="solist">
                          	<c:if test="${solist.soNums eq soid}">
                       <div class="ind_vew_cmtl"><span>订单编号：</span>${solist.soNums }</div>
                       <div class="ind_vew_cmtr"><span>订单创建时间：</span>${solist.soOrderTime }</div>
                       </c:if></c:forEach>
                     </div>
                     <div class="ind_vew_cmd">
                       <div class="ind_vew_cmdt">
                          <div class="ind_vew_cmdtq">宝贝</div>
                          <div class="ind_vew_cmdtw">单位（元）</div>
                          <div class="ind_vew_cmdte">数量</div>
                          <div class="ind_vew_cmdtr">售后</div>
                          <div class="ind_vew_cmdtt">实付款</div>
                          <div class="ind_vew_cmdty">交易状态</div>
                          <div class="ind_vew_cmdtu">实际操作</div>
                       </div>
                          <c:forEach items="${solist3 }" var="solist">
                          	<c:if test="${solist.soNums eq soid}">
                       <div class="bg_idc">
                         <div class="bg_idc_t"> &nbsp;&nbsp;订单编号：&nbsp;&nbsp;  ${solist.soNums } &nbsp;&nbsp;   开始时间：${solist.soOrderTime } &nbsp;&nbsp;  ${solist.customer.realName   }  </div>
                 
                       </div>	<c:forEach items="${list1 }" var="list1">
						<c:if test="${list1.sale_orders.soId eq solist.soId}">
                         
                         <DIV class="bg_idc_D">
                            <DIV class="bg_idc_Dl"><img src="litscloud/images/bg_29.png" /></DIV>
                            <DIV class="bg_idc_Dq">
                              <DIV class="bg_idc_Dqt"><a href="#"><img src="litscloud/images/bg_30.png" /></a></DIV>
                              <DIV class="bg_idc_Dqd">商品名称:${list1.sale_goods.sgname}<br />
商品编号:${list1.sale_goods.sgcode}</DIV>
                            </DIV>
                            <DIV class="bg_idc_Dw">￥${list1.sale_goods.sgPrice}</DIV>
                            <DIV class="bg_idc_De">${solist.count}</DIV>
                            <DIV class="bg_idc_Dr"><p></p><br />
</DIV>
                            <div class="bg_idc_Dt">${list1.sale_goods.sgPrice*solist.count}</div>
                            <div class="bg_idc_Dy">	审核状态：<c:if test="${solist.soStat==0 }">待审核</c:if>
					<c:if test="${solist.soStat==null || solist.soStat=='' }">待接收</c:if>
					<c:if test="${solist.soStat==1 }">已审核待付款</c:if>
					<c:if test="${solist.soStat==2 }">待付款审核</c:if>
					<c:if test="${solist.soStat==3 }">待生成上架单</c:if>
					<c:if test="${solist.soStat==4 }">待调拨往客服</c:if>
					<c:if test="${solist.soStat==5 }">待客服接收</c:if>
					<c:if test="${solist.soStat==6 }">待客服转运维</c:if>
					<c:if test="${solist.soStat==7 }">待运维接收</c:if>
					<c:if test="${solist.soStat==8 }">待运维上架</c:if>
						<c:if test="${solist.soStat==9 }">待客服确认</c:if>
						<c:if test="${solist.soStat==10 }">上架单待审核</c:if><br/><a href="javascript:void(0);">查看物流</a></div>
                            <div class="bg_idc_Du"><a href="javascript:void(0);">*</a></div>
                         </DIV>
                          </c:if>
				
					</c:forEach>
                      
				</c:if>
                       </c:forEach>
      
                     </div>
                  </div>
                  <!--上架信息-->
                  <div class="ind_vew_ct">上架信息</div>
                  <div class="ind_vew_cc">
                    <div class="ind_vew_ccl"></div>
                    <div class="ind_vew_ccr"></div>
                  </div>
                  <c:if test="${upserver==null }">暂无</c:if>
                  <c:forEach items="${upserver }" var="upserver">
                  <div class="ind_vew_s">
                    <dl>
                      <dt>上架单号：</dt>
                      <dd>${upserver.upNo }</dd>
                      <dt>销售单号：</dt>
                      <dd>${upserver.soOrders.soNums }</dd>
                    </dl>
                    <dl>
                      <dt>上架员工：</dt>
                      <dd>${upserver.employee.name }</dd>
                      <dt>维护口令：</dt>
                      <dd>${upserver.maintenancePass }</dd>
                    </dl>
                    <dl>
                      <dt>审核状态：</dt>
                      <dd><c:if test="${upserver.audtitingFlag==0 }">未审核</c:if><c:if test="${upserver.audtitingFlag==1 }">审核通过</c:if></dd>
                      <dt>上架状态：</dt>
                      <dd><c:if test="${upserver.upFlag==0 }">下架</c:if><c:if test="${upserver.upFlag==1 }">上架</c:if><c:if test="${upserver.upFlag==2 }">故障</c:if></dd>
                    </dl>
                    <dl>
                      <dt>上架时间：</dt>
                      <dd>${upserver.uptime }</dd>
                      <dt>下架时间 ：</dt>
                      <dd>${upserver.downtime }</dd>
                    </dl>
                    <dl>
                      <dt>带宽数量：</dt>
                      <dd>${upserver.bandwidthAmount }</dd>
                      <dt>带宽限制：</dt>
                      <dd>${upserver.bandwidthThrottling }</dd>
                    </dl>
                    <dl>
                      <dt>IP地址：</dt>
                      <dd>${upserver.serverIp }</dd>
                      <dt>IP数量：</dt>
                      <dd>${upserver.ipnum }</dd>
                    </dl>
                    <dl>
                      <dt>备&nbsp;&nbsp;注：</dt>
                      <dd style="height:50px; line-height:25px;">${upserver.temp }</dd>
                      <dt>刻&nbsp;&nbsp;度：</dt>
                      <dd>${upserver.marknum }</dd>
                    </dl>
                  </div>
                  </c:forEach>
                 
                  <!--运维信息-->
                    <div class="ind_vew_ct">运维信息</div>
                  <div class="ind_vew_cc">
                    <div class="ind_vew_ccl"></div>
                    <div class="ind_vew_ccr"></div>
                  </div>
                  <c:if test="${upserver==null || upserver=='' }">暂无</c:if>
                  <c:if test="${operate != null }">
                  <c:forEach items="${operate }" var="operate">
                  <div class="ind_vew_s">
                    <dl>
                      <dt>上架员工：</dt>
                      <dd>${operate.employee.name }</dd>
                      <dt>上架时间：</dt>
                      <dd>${operate.uptime }</dd>
                    </dl>
                    <dl>
                      <dt>下架时间：</dt>
                      <dd>${operate.downtime }</dd>
                      <dt>所属仓库：</dt>
                      <dd>${operate.depot.name } </dd>
                    </dl>
                    <dl>
                      <dt>商品名称：</dt>
                      <dd>${operate.product. }</dd>
                      <dt>IP地址：</dt>
                      <dd>${operate.ipAddress }</dd>
                    </dl>
                    <dl>
                      <dt>机房/房间：</dt>
                      <dd>${operate.housesAndRooms }</dd>
                      <dt>机&nbsp;&nbsp;柜：</dt>
                      <dd>${operate.cabinet }</dd>
                    </dl>
                    <dl>
                      <dt>交换机房名称：</dt>
                      <dd>${operate.jhj }</dd>
                      <dt>端口&nbsp;号：</dt>
                      <dd>${operate.port}</dd>
                    </dl>
                    <dl>
                      <dt>备&nbsp;&nbsp;注：</dt>
                      <dd style="width:500px; ">深圳机房卉不蛣蛣地时候喜鹊煖是地革是法律   </dd>
                    </dl>
                  </div>
                  </c:forEach>
                   </c:if>
                  <!--物流信息 -->
                  <div class="ind_vew_ct">物流</div>
                  <div class="ind_vew_cc">
                    <div class="ind_vew_ccl"></div>
                    <div class="ind_vew_ccr"></div>
                  </div>
                  <div class="ind_vew_h"><ul>
                     <c:forEach items="${solist3 }" var="solist">
                          	<c:if test="${solist.soNums eq soid}">
                    <li><span>收货地址:</span>${solist.sgAddress }</li>
                    <li><span>运送方式:</span>${solist.sgDelivtype }</li>
                    </c:if></c:forEach>
                  </ul></div>
               </div>
               <div class="ind_vew_d"></div>
               
                 <div class="bg_process_h"><a href="#" onclick="litscloud/litscloudgetOrderCustomerServerC.Action">返回</a></div>
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
