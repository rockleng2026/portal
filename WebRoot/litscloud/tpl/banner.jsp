<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript" src="<%=path %>/litscloud/web/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=path %>/litscloud/web/js/slides.jquery.js"></script>
<script type="text/javascript">
	//保证导航栏背景与图片轮播背景一起显示
	$("#mainbody").removeClass();
	$("#mainbody").addClass("index_bg02");
</script>
<script type="text/javascript">
	$(function(){
		//滚动Banner图片的显示
		$('#slides').slides({
			preload: false,
			preloadImage: '<%=path %>/litscloud/web/images/loading.gif',
			effect: 'fade',
			slideSpeed: 200,
			fadeSpeed: 50,
			play: 3000,
			pause: 100,
			hoverPause: true
		});
        //	$('#js-news').ticker();
    	});
	</script>
<!-- 滚动图片 -->
<div id="slides" class="banner">
<div class="banner_l"><a class="prev" href="#"><img alt="上一页" src="<%=path %>/litscloud/web/images/banner_l.png" width="24" height="43" /></a></div>
<div class="bannerImg">
	<div class="slides_container">
		<div id="banner_pic_1"><img src="<%=path %>/litscloud/web/images/Bann_02.png"/></div>
		<div style="DISPLAY:none" id="banner_pic_2">
			<img src="<%=path %>/litscloud/web/images/Bann_03.png"/>
        </div>		
		<div style="DISPLAY: none" id="banner_pic_3"> 
		<img src="<%=path %>/litscloud/web/images/banner05.jpg"/>
		</div>	
	</div>
</div>
<div class="banner_r"><a class="next" href="#"><img alt="下一页" src="<%=path %>/litscloud/web/images/banner_r.png" width="24" height="43" /></a></div>
</div>