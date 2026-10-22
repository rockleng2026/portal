<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-添加CDN订单）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/handlejson.js"></script>
<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/cascadingmenu.js"></script>
<script type="text/javascript" 	src="litscloud/js/cdn.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->

<script type="text/javascript">
$(document).ready(function(){
 	
 	 document.getElementById("a2").className = "aBackgroundImage";
	  document.getElementById("a2").style.color= "#000000";
 });
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
          <div class="bg_wd" > <!-- 945框架 -->
             <div class="ly_xxt">
             <span class="bg_tjan"><a href="<%=path %>/litscloud/ucenter/showOrderadd3CDNsaleOrderAction.Action" >添  加</a></span>
               <div class="ly_xxtl">CDN订单列表</div>        
             </div>
              <!-- 列表开始 -->
              <div class="cdn_web">
                <table width="100%" class="cdn_lb" border="0" cellpadding="0" cellspacing="0">
                  <thead>  <!-- 代表表格头部 -->
                  <tr class="cdn_lbbo" style="background:#dcdcdc;">
                    <th width="30%">源站域名</th>
                    <th width="10%">套餐类型</th>
                    <th width="10%">服务状态</th>
                    <th width="10%">审核状态</th>
                    <th width="15%">申请时间</th>
                    <th width="15%">实际价格</th>
                    <th width="10%">操作</th>
                  </tr>
                  </thead>
                <tfoot>  <!-- 代表表格底部 -->
                <tr>
                  <td colspan="7" style="border:none;width:945px;text-align:right;" class="fenye"> <p:pages url="showcdnlist3CDNsaleOrderAction.Action" tag="lits_cdn_web"/> </td>
                </tr> 
                </tfoot>
                <tbody> <!-- 表格内容内容 --> 
                <c:forEach items="${pages.pageList}"  var="data" varStatus="sid" >
	             <tr> 
	               <td width="30%">${data.cuRealmName }</td>
	                    <td width="10%">
	                    <c:if test="${data.setmeal.chargeType=='0' }">免费</c:if>
						<c:if test="${data.setmeal.chargeType=='1' }">赠送</c:if>
						<c:if test="${data.setmeal.chargeType=='2' }">预付费</c:if>
						<c:if test="${data.setmeal.chargeType=='3' }">后付费</c:if>
					</td>
                    <td width="10%">
                    	<c:if test="${data.serverFlag==1 }">开启</c:if>
						<c:if test="${data.serverFlag==2 }">关闭</c:if>
					</td>
                    <td width="10%">
                    	<c:if test="${data.auditingState==0 }">未审核</c:if>
						<c:if test="${data.auditingState==1 }">审核通过</c:if>
						<c:if test="${data.auditingState==2 }">审核未通过</c:if>
						<c:if test="${data.auditingState==8 }">审核中</c:if>
                    </td>
                    <td width="15%">${data.time }</td>
                    <td width="15%">￥${data.price }</td>
                    <td width="10%"><a href="<%=path %>/litscloud/ucenter/showOrder3CDNsaleOrderAction.Action?id=${data.id }">查看详情</a>
                 </td>
                </tr>
                </c:forEach>
               </tbody>
               </table>
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