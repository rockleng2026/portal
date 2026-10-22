<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-订单流程）</title>
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
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->

</head>

<body>
    <!--头部公用代码-->
  <div class="ly_body">
    <!------------------------------------------头部公用代码------------------------------------------------------------>
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!----------------------------------------------------------------内容开始------------------------------------------------------>

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心>订单管理>订单流程</div> 
          <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
         <div class="bg_process">
              <div class="bg_process_t"><c:if test="${sg.soStat==0 || sg.soStat==null || sg.soStat=='' }"><img src="litscloud/images/lc_01.jpg" /></c:if>
              <c:if test="${sg.soStat==1 }"><img src="litscloud/images/lc_02.jpg" /></c:if>
              <c:if test="${sg.soStat==2 || sg.soStat==3 || sg.soStat==4   || sg.soStat==5  }"><img src="litscloud/images/lc_03.jpg" /></c:if>
               <c:if test="${sg.soStat==6 || sg.soStat==7 || sg.soStat==8   || sg.soStat==9  }"><img src="litscloud/images/lc_04.jpg" /></c:if>
                <c:if test="${sg.soStat==10 || sg.soStat==11 || sg.soStat==12}"><img src="litscloud/images/lc_05.jpg" /></c:if>
               </div>
              <div class="bg_process_m"></div>
              <div class="bg_process_c">
                 <div class="bg_process_ct">
                    <div class="bg_process_ctt">
                       <div class="bg_process_cttt">当前订单(${sg.soNums })状态：    	<c:if test="${sg.soStat==0 }"><font size="-1">待审核</font></c:if>
					<c:if test="${sg.soStat==null || sg.soStat=='' }"><font size="-1">待接收</font></c:if>
					<c:if test="${sg.soStat==1 }"><font size="-1">已审核待付款</font></c:if>
					<c:if test="${sg.soStat==2 }"><font size="-1">待付款审核</font></c:if>
					<c:if test="${sg.soStat==3 }"><font size="-1">待生成上架单</font></c:if>
					<c:if test="${sg.soStat==4 }"><font size="-1">待调拨往客服</font></c:if>
					<c:if test="${sg.soStat==5 }"><font size="-1">待客服接收</font></c:if>
					<c:if test="${sg.soStat==6 }"><font size="-1">待客服转运维</font></c:if>
					<c:if test="${sg.soStat==7 }"><font size="-1">待运维接收</font></c:if>
					<c:if test="${sg.soStat==8 }"><font size="-1">待运维上架</font></c:if>
						<c:if test="${sg.soStat==9 }"><font size="-1">待客服确认</font></c:if>
						<c:if test="${sg.soStat==10 }"><font size="-1">订单成功 <a href="javascript:void(0);">待评价</a></font></c:if>
						<c:if test="${sg.soStat==12 }"><font size="-1">订单成功 <a href="javascript:void(0);">已评价</a></font></c:if>
						<c:if test="${sg.soStat==11 }"><font size="-1">上架单待审核</font></c:if></div>
                       <div class="bg_process_cttc">定单流程记录：<br/>
                       <c:forEach items="${plist}" var="plist">
                       <c:if test="${sg.soNums==plist.pnum}">
                                             时间:${plist.begintime }   订单状态:<c:if test="${plist.pstat==0 }"><font size="-1">待审核</font></c:if>
					<c:if test="${plist.pstat==null || plist.pstat=='' }"><font size="-1">待接收</font></c:if>
					<c:if test="${plist.pstat==1 }"><font size="-1">已审核待付款</font></c:if>
					<c:if test="${plist.pstat==2 }"><font size="-1">待付款审核</font></c:if>
					<c:if test="${plist.pstat==3 }"><font size="-1">待生成上架单</font></c:if>
					<c:if test="${plist.pstat==4 }"><font size="-1">待调拨往客服</font></c:if>
					<c:if test="${plist.pstat==5 }"><font size="-1">待客服接收</font></c:if>
					<c:if test="${plist.pstat==6 }"><font size="-1">待客服转运维</font></c:if>
					<c:if test="${plist.pstat==7 }"><font size="-1">待运维接收</font></c:if>
					<c:if test="${plist.pstat==8 }"><font size="-1">待运维上架</font></c:if>
						<c:if test="${plist.pstat==9 }"><font size="-1">待客服确认</font></c:if>
						<c:if test="${plist.pstat==10 }"><font size="-1">订单成功 <a href="javascript:void(0);">待评价</a></font></c:if>
						<c:if test="${plist.pstat==12 }"><font size="-1">订单成功 <a href="javascript:void(0);">已评价</a></font></c:if>
						<c:if test="${plist.pstat==11 }"><font size="-1">上架单待审核</font></c:if>
                       .............
                       
                       
                       </c:if>
                       
                       
                       </c:forEach>
                       
                       </div>
                       <div class="bg_process_cttd"><input type="button" value="备忘" class="button_bw" /></div>
                    </div>
                    <div class="bg_process_ctd">
                      <div class="bg_process_ctdt">物流信息</div>
                      <div class="bg_process_ctdd">
                      <c:if test="${sg.isDelivery == null || sg.isDelivery == '' || sg.isDelivery == 0 }}">
                       <div class="bg_process_ctdd_t">
                         <div class="bg_process_ctdd_tl">发货方式：</div>
                         <div class="bg_process_ctdd_tr">免发货</div>
                       </div>
                       </c:if>
                      
                       <!--  
                       <div class="bg_process_ctdd_t">
                         <div class="bg_process_ctdd_tl">物流公司：</div>
                         <div class="bg_process_ctdd_tr">顺风速运</div>
                       </div>
                       <div class="bg_process_ctdd_t">
                         <div class="bg_process_ctdd_tl">运单号码：</div>
                         <div class="bg_process_ctdd_tr">102775497106</div>
                       </div>
                       <div class="bg_process_ctdd_t">
                         <div class="bg_process_ctdd_tl">物流跟踪：</div>
                         <div class="bg_process_ctdd_dr">2013-01-23 17:12:21 已收件<br />
                         2013-01-23 17:12:21 正在派件<br />
                         <span>2013-01-23 17:12:21 派送成功..</span>  
                         </div>
                       </div>
                       -->
                      <div class="bg_process_cd"><img src="litscloud/images/log_13.gif" style="float:left;" /> 以上信息由物流公司提供，如无跟踪信息或有疑问，请查询<a href="javascript:void(0);">物流公司</a>官方网站或联系起其公示电话</div> 
                      </div> 
                    </div>
                 </div>
              </div>
              <div class="bg_process_d"></div>
              <div class="bg_process_h"><a href="#" onclick="javascript:history.go(-1)">返回</a></div>
          </div>      
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!--_________________________底部公用代码 _______________________________________________-->
 <jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!--------------------------------------------------------------底部结束 -------------------------------------------------------------->
</div>

</body>
</html>
