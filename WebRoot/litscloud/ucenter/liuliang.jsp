<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/litscloud/js/updateCU.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
				<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/FusionCharts.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/EJSChart.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCo	mmand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
 $(document).ready(function(){
 	var realmName=document.getElementById("realmName").value; 
 	$.post("liuliangtuCDNsaleOrderAction.Action",{realmName:realmName},function(data){
 	var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/MSLine.swf","myid","936","347");//单Y 单曲线
	
	mychart.setDataXML(data);
	mychart.render("chartdiv1");
 		
 	});
 });

</script>
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
          <div class="bg_t">当前位置：<a href="index.html" target="_parent">首页</a>>会员中心</div> 
          <div class="bg_c">
              <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include>
          </div> 
          <div class="bg_wd" > <!-- 945框架 -->
             
              <!-- 列表开始 -->
              <div class="cdn_web">
                <div class="llt_t"><dl>  <!-- 频道选择 -->
                  <dt>频道：</dt><dd>
                  <select name="xz" class="llt_xz" id="realmName">
                  
                  <c:forEach items="${cdnso}" var="data" >
                  <option value="${data.cuRealmName }">${data.cuRealmName }</option>
                  </c:forEach>
                  </select>&nbsp;&nbsp;<input type="image" src="<%=basePath%>/litscloud/images/ll_01.gif" /></dd>
                </dl>
                <dl><dt>时间范围：</dt><dd><select name="xz" class="llt_sj"><option selected="selected">请选择</option>
                  <option value="2013-06-12">2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  </select>
                  <span>至</span>
                  <select name="xz" class="llt_sj"><option selected="selected">请选择</option>
                  <option value="2013-06-12" >2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  <option value="2013-06-12">2013-06-12</option>
                  </select>
                  <input type="image" src="<%=basePath%>/litscloud/images/zf_41.gif" name="search" style="float:left;" />
                  </dd></dl>
                </div>
                 <div class="llt_m">  <!-- 所有频道 -->
                   <span>2013-03-15 10:26:33 - 2013-05-22 16:33:45</span>
                   <img src="<%=basePath%>/litscloud/images/ll_03.gif" alt="所有频道" style="float:left;" />所有频道
                 </div>
                 <div class="llt_c">  <!-- 流量统计图 -->
                   <div class="cdn_li_t" style="text-indent:0px;">用户访问流量统计图</div>
                <div class="cdn_li_c"><img src="<%=basePath%>/litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="llt_ct">www.dkege.com</div>
                <div class="llt_cc">网站流量（单位：KB）</div>
                <div class="llt_cd" id="chartdiv1"></div>
                <div class="llt_ct">www.dkege.com</div>
                <div class="llt_cc">网站流量（单位：GB）</div>
                <div class="llt_cd"><img src="<%=basePath%>/litscloud/images/ll_02.gif" alt="统计图" /></div>
                 </div>
                 <div class="llt_d"> <!-- 网站前十位访问 -->
                <div class="cdn_li_t" style="text-indent:0px;">前十位访问者</div>
                <div class="cdn_li_c"><img src="<%=basePath%>/litscloud/images/log_15.gif"  alt="xx"/></div>
                <div class="llt_dt">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="llt_table">
                  <tr><th class="bd_left">网民IP</th><th>流量百分比</th><th>Hits数量</th><th>百分比</th></tr>
                  <tr><td class="bd_left">88.56.69.23</td><td>98.480%</td><td>630</td><td>96.486%</td></tr>
                  <tr><td class="bd_left">88.56.69.23</td><td>98.480%</td><td>630</td><td>96.486%</td></tr>
                  <tr><td class="bd_left">88.56.69.23</td><td>98.480%</td><td>630</td><td>96.486%</td></tr>
                  <tr><td class="bd_left">88.56.69.23</td><td>98.480%</td><td>630</td><td>96.486%</td></tr>
                  </table>
                </div>
                 </div>
              </div>
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
