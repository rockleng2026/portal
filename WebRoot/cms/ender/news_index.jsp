<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>联系我们</title>
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
<div class="bodyer"><!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->
   <!-- 头部start -->
      <jsp:include page="menu.jsp"></jsp:include>
   <!-- 头部end -->
   <!-- t_bod结束 -->
   <div class="t_cod">
     <!-- 热卖产品 -->
       <div class="bod_width t_cod_mar">
         <h1 class="bod_width t_cod_title" name="gps_hydt">行业动态<br /><span>INDUSTRY DYNAMICS</span></h1>
         <div class="bod_width t_cod_x">
            <div class="t_cod_xl"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
            <div class="t_cod_xr"><span><img src="cms/ender/image/ed_09.gif" alt="img" /></span></div>
         </div>
       </div>
     <!-- 热卖产品完毕 -->
       <div class="bod_width about_t">
         <div class="about_tl"></div>
         <div class="about_tc"><ul>
           <c:forEach items="${industrynews}" var="ss" varStatus="i">
				<li <c:if test='${classid == ss.classid }'>class="about_tc_xz"</c:if>>
					<a href="cms/web/showlistwebnews.do?match_name=webnews&classid=${ss.classid }#gps_hydt">${ss.classname }</a>
				</li>
			</c:forEach>
         </ul></div>
         <div class="about_tl"></div>
       </div>
       
      <div class="bod_width par_m">
         <!-- 标题信息 -->
         <div class="bod_width quft_t"><span class="quft_title">文章列表</span></div>
         <!-- 内容区域 -->
         <div class="bod_width quft_d">            
            <c:forEach items="${pages.pageList}" var="data" varStatus="i">
				<div class="new_t"><span>发布日期：${data.senddate }&nbsp;&nbsp;&nbsp; 浏览次数：<c:if test="${data.readnum == null || data.readnum == '' }">未知</c:if><c:if test="${data.readnum != '' }">${data.readnum}</c:if>&nbsp;&nbsp;&nbsp; 状态：<em>${data.ftitle }</em></span>${i.index+1 }、${data.title }</div>
	            <div class="new_c">
	              ${data.smalltext }
            	</div>				
			</c:forEach>
            
           <!-- 
            <div class="new_d">第 <span>5/10</span> 页 <a href="#">尾页</a> <a href="#">首页</a>  <a href="#">下一页</a> <a href="#">上一页</a> </div>
            -->
            <div class="portact_d">
		        <c:if test="${pages.pageNo<pages.allPage}"><a href="cms/web/showlistwebnews.do?match_name=webnews&&classid=${classid }&pageSize=${pages.pageSize }&page=${pages.pageNo+1 }">下一页</a></c:if>
		        ${fenye }
		        <c:if test="${pages.pageNo>1}"><a href="cms/web/showlistwebnews.do?match_name=webnews&classid=${classid }&pageSize=${pages.pageSize }&page=${pages.pageNo-1 }">上一页</a></c:if>
		      </div>
          </div>
      </div> 
     
             
   </div>
   <!-- 内容输出完毕 -->
   <!-- 底部开始 -->
   <jsp:include page="bottum.jsp"></jsp:include>
   <!-- 底部完毕 -->
</div>

</body>
</html>