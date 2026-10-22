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
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">

function div1(){
	document.getElementById("cdn_ml").style.display="block";
	document.getElementById("cdn_nr").style.display="none";	
	}
function div2(){
	document.getElementById("cdn_ml").style.display="none";
	document.getElementById("cdn_nr").style.display="block";	
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
          <div class="bg_t">当前位置：<a href="<%=path %>/index.html" target="_parent">首页</a>>会员中心</div> 
          <jsp:include page="/litscloud/ucenter/menu_2.jsp"></jsp:include> 
          <div class="bg_wd">
             <div id="cdn_ml"  style="display:none;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div2()">内容刷新</a></li>
               <li><a onclick="div1()"  style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;" >目录刷新</a></li>
             </ul></div>             
             <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">每个内容一行，以协议http://开头，如（http://或者mms://）开头。 <span>例如：http://www.baidu.com/images/</span><br /><span>注意：推送的内容要区分大小写！</span></div>              
              <div class="ugx_m"><textarea class="ugx_text"></textarea></div>
              <div class="ugx_y"><span>内容是否预取</span> <input type="radio" name="nei" value="是" /> <label>是</label><input type="radio" value="否" name="nei"  /> <label>否</label></div> 
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>               
             </div>
             </div>
             
             
             <div id="cdn_nr" style="display:block;">
             <div class="cdn_t"><ul>
               <li><a  onclick="div2()"  style="background-image:url(litscloud/images/cdn_01.gif); color:#fff;">内容刷新</a></li>
               <li><a onclick="div1()">目录刷新</a></li>
             </ul></div>             
               <div class="cdn_c">
             <div class="ugx_t">尊敬的用户：您今天可以推送的内容数目为500个！</div>        
             <div class="ugx_c">每个内容一行，以协议http://开头，如（http://或者mms://）开头。 <span>例如：http://www.baidu.com/index.html</span><br /><span>注意：推送的内容要区分大小写！</span></div>              
              <div class="ugx_m"><textarea class="ugx_text"></textarea></div>
     
              <div class="ugx_d">延迟时间：<input type="text" value="1" name="times" class="times" /> <select class="sele_ys">
              <option value="分钟">分钟</option>
              <option value="小时">小时</option>
              <option value="天">天</option>
              </select><span>如果需要将内容延迟推送，请在这里设置，默认不延迟推送。</span></div>               
             </div>
             </div>
             
             
             <div class="cdn_d"> 
                <input type="submit" value="提 交" class="cdn_sub" />
                <input type="reset" value="重 置" class="cdn_sub" />
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