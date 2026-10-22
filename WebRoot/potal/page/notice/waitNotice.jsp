<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>待审核的公告</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
a{ text-decoration:none; color:#2c5d02}
ul{list-style-type: none;}
.dow{width:740px; height:430px; float:left; padding:10px 10px;}
.sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; }
.sp_nav_tab .nomarl{ width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; background-color:#EAFED9;}
.sp_nav_tab  li { float:left; text-align:center; margin-left:3px;}
.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
.div_top_left{ float:left;}
.div_top_right{ float:right;}
.sp_top_right{ float:right; padding-top:15px;}
.td_left_b{ border-left:1px solid #fff;}
.td_bottom_b{ border-bottom:1px solid #cdcdcd}
.lv{ color:#50a806; line-height:30px; font-size:12px;}
.lv a{color:#50a806;}
.tdtd_p{ padding-bottom:5px;color:#50a804;}
.tdtd_p a{ color:#50a804;}
.tdtd_p a:hover{ color:red;}
.top_hui{ background-color:#51a706; color:#fff; width:53px; height:18px; float:right; text-align:center;valign:middle;}
.top_lv a{ color:#fff;}
.top_lv{ background-color:#7b7b7b; color:#fff; width:53px; height:18px; float:right; text-align:center;valign:middle;}
.top_hui a{color:red;}
.hui a:hover{color:red;}
.toplv{color:#3d8a00}
.topcheng{color:#ff6500}

</style>
  </head>
  
  <body>
 <div class="dow">
<div>
<div class="div_top_left"><span class="toplv">您的位置</span>：首页><span class="topcheng">待审核</span></div>
</div>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <span class="sp_top_right"><span class="top_lv"><a href="sendNotice.jsp">写公告</a></span></span>
    <ul class="sp_nav_tab">
      <li class="active"> 待审核 </li>
      <li  class="sq"></li>
      <li class="nomarl"><a href="noticeListing.jsp">公告列表</a></li>
      <li  class="sq"></li>
      <li  class="nomarl"><a href="deleteNotice.jsp">已删除</a></li>
      <li  class="sq"></li>
      <li  class="nomarl"><a href="draftNotice.jsp">草稿箱</a></li>
    </ul>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#999999">
      <tr>
        <td width="7%" height="25">&nbsp;</td>
        <td width="12%" align="center" class="td_left_b">公告类型</td>
        <td width="8%" align="center" class="td_left_b">通知部门</td>
        <td width="30%" align="center" class="td_left_b">主题</td>
        <td width="13%" align="center" class="td_left_b">时间</td>
        <td width="14%" align="center" class="td_left_b">审核状态</td>
        <td width="16%" align="center" class="td_left_b">操作</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
     <c:forEach items="${list}" var="data">
      <tr name="color">
        <td height="35" align="center" valign="middle" class="td_bottom_b"><strong>
          <label for="checkbox14"><img src="/images/gg_lb.png" alt="" width="19" height="21" /></label>
          </strong></td>
        <td align="center" class="td_bottom_b">
           <c:if test="${data.isRead==0}">
             <c:if test="${data.typeid==1}">
               <strong>公司公告</strong>
             </c:if>
           </c:if>
           <c:if test="${data.isRead==1}">
             <c:if test="${data.typeid==2}">
                                                部门公告
             </c:if>
           </c:if>
           
        </td>
        <td align="center" class="td_bottom_b">
           <c:if test="${data.isRead==0 && data.typeid==2}"> 
             <strong>${data.dept.name}</strong>
           </c:if>
           <c:if test="${data.isRead==1 && data.typeid==1}">
                                        公司公告
           </c:if>
        </td>
        <td align="center" class="td_bottom_b">
            <strong>开源中国社区关于世界末日的精彩回顾...</strong>
        </td>
        <td align="center" class="td_bottom_b">
            <strong>2013-01-29</strong>
        </td>
        <td align="center" class="td_bottom_b">
            <a href="knowNotice.jsp">未审核</a>
        </td>
        <td align="center" class="td_bottom_b">
            <a href="#">撤销</a>&nbsp;&nbsp;<a href="#"><a href="#">详情</a>
        </td>
        </tr>
       </c:forEach>
      
      </table></td>
  </tr>
</table>
</div>  
  </body>
</html>
