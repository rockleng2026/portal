<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>产品中心</title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="cms/ender/css/style.css" rel="stylesheet" type="text/css" />
<script src="cms/ender/js/jquery.js" type="text/javascript"></script>
<script src="cms/ender/js/zzsc.js" type="text/javascript"></script>
<script type="text/javascript" src="cms/ender/js/lrtk.js"></script>
</head>

<body>
<div class="bodyer"> <!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->
   <!-- 头部start -->
      <jsp:include page="menu.jsp?tt=123"></jsp:include>
   <!-- 头部end -->
   <!-- t_bod结束 -->
   <div class="t_cod">
     <!-- 热卖产品 -->
       <div class="bod_width t_cod_mar">
         <h1 class="bod_width t_cod_title">产品中心<br /><span>PRODUCTS CENTER</span></h1>
         <div class="bod_width t_cod_x">
            <div class="t_cod_xl"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
            <div class="t_cod_xr"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
         </div>
       </div>
     <!-- 热卖产品完毕 -->
       <div class="bod_width about_t">
         <div class="about_tl"></div>
         <div class="about_tc"><ul>
           <c:forEach items="${productcenter}" var="ss" varStatus="i">
				<li <c:if test='${classid == ss.classid }'>class="about_tc_xz"</c:if>>
					<a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${ss.classid }">
						${ss.classname }
					</a>
				</li>
			</c:forEach>
			<!-- 
           <li class="about_tc_xz"><a href="#" >汽车地毯</a></li>
           <li><a href="#">3M进口地毯</a></li>
           <li><a href="#">S型防滑地毯</a></li>
           <li><a href="#">抗纹地毯</a></li>
           <li><a href="#">3A,8A8地毯</a></li>
           <li><a href="#">各类综合地毯、地垫</a></li> 
            -->    
         </ul></div>
         <div class="about_tl"></div>
       </div>
       
      <div class="bod_width portact"><ul>
        <c:forEach items="${pages.pageList}" var="data" varStatus="i">
			<li><a href="cms/web/showinfowebproduct.do?cid=${data.cid }" title="${data.title}" target="_blank">
						<c:if test="${data.titlepicThumb == null || data.titlepicThumb == ''}"><img src="cms/ender/image/ed_36.jpg" /> </c:if>
						<c:if test="${data.titlepicThumb != null && data.titlepicThumb != ''}"><img src="${fn:split(data.titlepicThumb,'|')[0]}" alt="标题图片" width="156" height="219"/></c:if></a>
	        	<h1><a href="cms/web/showinfowebproduct.do?cid=${data.cid }" title="点击链接到产品详细参数页面">${data.title }</a></h1>
	        </li>
		</c:forEach>
      </ul></div>
      <div class="portact_d">
        <c:if test="${pages.pageNo<pages.allPage}"><a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${classid }&pageSize=${pages.pageSize }&page=${pages.pageNo+1 }">下一页</a></c:if>
        ${fenye }
        <c:if test="${pages.pageNo>1}"><a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${classid }&pageSize=${pages.pageSize }&page=${pages.pageNo-1 }">上一页</a></c:if>
      </div> 
             
   </div>
   <!-- 内容输出完毕 -->
   <!-- 底部开始 -->
   <jsp:include page="bottum.jsp"></jsp:include>
   <!-- 底部完毕 -->
</div>

</body>
</html>
