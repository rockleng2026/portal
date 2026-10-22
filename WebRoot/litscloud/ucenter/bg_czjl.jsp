<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（交易记录）</title>
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
<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
 $(document).ready(function(){ 
 document.getElementById("a3").className = "aBackgroundImage";
 document.getElementById("a3").style.color= "#000000";
 
 });
 function listTime()
 {
 	$("#listPayDateTime").submit();
 
 }
</script>
</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          
             <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
        <div class="ly_zh">
             <div class="ly_zht">
               <div class="ly_zhtl">充值记录查询</div>
               <div class="ly_zhtr">您当前的可用佘额为：<span>****</span>元</div>
             </div>
             <form id="listPayDateTime" name="listPayDateTime"  action="litscloud/web/listPayDateTimeCustomerServerC.Action" method="post">
             <div class="ly_zhc">
               <INPUT  id="dateTime" name="dateTime" onclick="WdatePicker()" value="${dateTime }"/>
                至
                <INPUT  id="dateTime1" name="dateTime1" onclick="WdatePicker()" value="${dateTime1 }"/>
                 <a href="javascript:void(0)" onclick="listTime()" ><img src="litscloud/images/zf_41.gif" style="margin-right:10px;" /></a>
                
                 充值：<span>300.00</span>元
             </div>
             </form>
             <div class="ly_zhm">
             <div class="ly_zhm_u"><img src="litscloud/images/zf_40.gif" /> 搜索结果是从<span><c:if test="${dateTime==''||dateTime==null}">最初</c:if>${dateTime }</span>开始至<span><c:if test="${dateTime1==''||dateTime1==null}">至今</c:if>${dateTime1 } </span>的记录。</div>
                <div class="ly_zhm_t">
                  <div class="ly_zhm_tq">收款单号</div>
                  <div class="ly_zhm_tw">收款时间</div>
                  <div class="ly_zhm_te">收款金额（元）</div>
                  <div class="ly_zhm_tr">收款渠道</div>
                  <div class="ly_zhm_tt">备注信息</div>
                  <div class="ly_zhm_ty">状态</div>
                </div>
                <div class="ly_zhm_d">
                <c:forEach items="${pages.pageList}" var="data">
                   <div class="ly_zhm_dt">
                     <div class="ly_zhm_dtq">${data.chargeNo }</div>
                     <div class="ly_zhm_dtw">${data.collectionTime }</div>
                     <div class="ly_zhm_dte">${data.accountPayable }</div>
                     <div class="ly_zhm_dtr"> ${data.defrayMode }</div>
                     <div class="ly_zhm_dtt">${data.remark }</div>
                     <div class="ly_zhm_dty"><c:if test="${data.payStat=='1'||data.payStat==''||data.payStat==null}">付款待审核</c:if><c:if test="${data.payStat=='2'}">付款成功</c:if></div>
                   </div>
                   </c:forEach>
                </div>
                <div class="ly_zhm_s">
                <c:if test="${mark=='1'}"><p:pages url="litscloud/web/listPayDateTime1CustomerServerC.Action"/></c:if>
                 <c:if test="${mark=='0'||mark==null||mark==''}"><p:pages url="litscloud/web/listPayCustomerServerC.Action"/></c:if>
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
