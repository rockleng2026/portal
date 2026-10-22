<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-订单管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery-1.7.2.min.js"></script>

 <script type="text/javascript">
     function xiangqing(soid){
	  
	location.href = "<%=path %>/litscloud/litscloudgetOrderCustomerServerC.Action?soid="+soid+"&tt="+(new Date()).getTime();
	  //var url = "<%=path %>/litscloud/ucenter/bg_indentvew.jsp?tt="+(new Date()).getTime();
	 //var url = "<%=path %>/litscloud/ucenter/u_order_info.jsp?tt="+(new Date()).getTime();
	  //alert(url);
	 //	$('#d3').load(url);
     }
 function topage(page1,pall){
   	  	//alert(page1);
    	 var url = "<%=path %>/litscloud/litscloudgetOrderCustomerServerC.Action?pageNo="+page1+"&pagenum="+pall+"&tt="+(new Date()).getTime();
   	  //var url = "<%=path %>/litscloud/ucenter/bg_indentvew.jsp?tt="+(new Date()).getTime();
   	 //var url = "<%=path %>/litscloud/ucenter/u_order_info.jsp?tt="+(new Date()).getTime();
   	  //alert(url);
   	 	$('#d3').load(url);
  }
</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top2.jsp"></jsp:include>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <!-- 菜单2S -->
          <jsp:include page="/litscloud/ucenter/menu_4.jsp"></jsp:include>
          <!-- 菜单2E -->
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc" id="d3">
			 </div>
   <script type="text/javascript">
	  //alert(1245);  
	  var url = "<%=path %>/litscloud/litscloudgetOrderCustomerServerC.Action?tt="+(new Date()).getTime();
	 //var url = "<%=path %>/litscloud/ucenter/my_orderlist2.jsp?tt="+(new Date()).getTime();
	  //alert(url);
	 $('#d3').load(url);
	</script>   			

          <div class="bg_dd"></div>
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
