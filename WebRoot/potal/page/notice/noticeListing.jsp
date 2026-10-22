<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>公告列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
  </head>
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
a{ text-decoration:none;}
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
.lv a:hover{ color:red;}
.tdtd_p{ padding-bottom:5px;color:#50a804;}
.tdtd_p a{ color:#50a804;}
.tdtd_p a:hover{ color:red;}
.top_hui{ background-color:#51a706; color:#fff; width:53px; height:18px; float:right; text-align:center;valign:middle;}
.top_lv a{ color:#fff;}
.top_lv{ background-color:#7b7b7b; color:#fff; width:53px; height:18px; float:right; text-align:center;valign:middle;}
.top_hui a{ color:#fff;}
.toplv{color:#3d8a00}
.topcheng{color:#ff6500}
</style>  

<script type="text/javascript">
   //公告详情
   function detail(id){
      window.location.href="detailnotice.do?nid="+id;
   }
   
   //待审核
   function daishenhe(){
      window.location.href="noAppnotice.do?flag=1";
   }
   
   //公告列表
   function noticelist(){
      window.location.href="listNtnotice.do?flag=0";
   }
   //进入草稿箱
   function draft(){
     window.location.href="draftListnotice.do?flag=2";
   }
   
   //待审核--详情
   function noAppDetail(id){
      var info = 'info';
      window.location.href = "noAppDetailnotice.do?id="+id+"&info="+info;
   }
   
   //待审核--撤销
   function resetNotice(id){
     window.location.href = "resetNoticenotice.do?id="+id;
   }
   
   //待审核--编辑
   function edit(id){
     window.location.href = "editNoticenotice.do?id="+id;
   }
   
   //状态未审核成功--详情
   function successDetail(id){
     var info = 'info';
     window.location.href = "successDetailnotice.do?id="+id+"&info="+info;
   }
   
   
    //审核失败--编辑
   function reSend(id){
     window.location.href = "reSendnotice.do?id="+id;
   }
   
</script>

  <body>
   <div class="dow">
<div>
<div class="div_top_left"><span class="toplv">您的位置</span>：首页><span class="topcheng">公告列表</span></div><div class="div_top_right"></div>
</div>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <span class="sp_top_right"><span class="top_lv"><a href="<%=request.getContextPath()%>/sendnotice.do">写公告</a></span></span>
    <ul class="sp_nav_tab">
       <li  <c:if test="${flag==1}">class='active'</c:if>  <c:if test="${flag!=1}">class='nomarl'</c:if>   >
           <a href="javascript:daishenhe();">待审核</a>
       </li>
      <li  class="sq"></li>
      <li  <c:if test="${flag==0}">class='active'</c:if> <c:if test="${flag!=0}">class='nomarl'</c:if>   >
          <a href="javascript:noticelist();">公告列表</a></li>
      <li  class="sq"></li>
      <li  <c:if test="${flag==2}">class='active'</c:if> <c:if test="${flag!=2}">class='nomarl'</c:if> >
          <a href="javascript:draft();">草稿箱</a></li>
    </ul>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#999999" >
      <tr >
        <td width="10%" align="center" height="25">公告</td>
        <td width="12%" align="center" class="td_left_b">公告类型</td>
        <td width="12%" align="center" class="td_left_b">发起部门</td>
        <td width="16%" align="center" class="td_left_b">主题</td>
        <td width="15%" align="center" class="td_left_b">时间</td>
        <c:if test="${flag==1}">
        <td width="12%" align="center" class="td_left_b">状态</td>  
        </c:if>
        <c:if test="${flag==1}">
        <td width="20%" align="center" class="td_left_b">操作</td>  
        </c:if>
         <c:if test="${flag==2}">
        <td width="20%" align="center" class="td_left_b">操作</td>  
        </c:if>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
   <c:if test="${demo==1}"> 
   <c:forEach items="${pages.pageList}" var="data">
   
      <tr name="color">
        <td width="10%" height="35" align="center" valign="middle" class="td_bottom_b">
        <strong>
          <label for="checkbox2"><img src="<%=request.getContextPath()%>/potal/page/notice/images/gg_lb.png" width="19" height="21" /></label>
        </strong>
        <input type="hidden" id="nid" name="nid" value="${data.notice.id}"/>

        </td>
          
        <td width="12%" align="center" class="td_bottom_b">
             <c:if test="${data.notice.isRead==0}">
                  <c:if test="${data.notice.typeid==1}">
                     <strong>公司公告</strong>
                  </c:if>
                  <c:if test="${data.notice.typeid==2}">
                     <strong>部门公告</strong>
                  </c:if>
             </c:if>
            
            <c:if test="${data.notice.isRead==1}">
                  <c:if test="${data.notice.typeid==1}">
                                                          公司公告
                  </c:if>
                  <c:if test="${data.notice.typeid==2}">
                                                        部门公告
                  </c:if>
             </c:if>
        </td>
        <td width="12%" align="center" class="td_bottom_b">
           <c:if test="${data.notice.isRead==0}">
              <strong>${data.notice.startDept.name}</strong>
           </c:if>
           <c:if test="${data.notice.isRead==1}">
              ${data.notice.startDept.name}
           </c:if>
        </td>
        <td align="center" class="td_bottom_b" width="16%">
          <c:if test="${data.notice.isRead==0}">
             <strong>
               <a href="javascript:detail(${data.notice.id});">${data.notice.title}</a>
             </strong>
          </c:if>
          <c:if test="${data.notice.isRead==1}">
            <a href="javascript:detail(${data.notice.id});">${data.notice.title}</a>
          </c:if>
         </td>
        <td width="15%" align="center" class="td_bottom_b">
          <c:if test="${data.notice.isRead==0}">
               <strong>${data.notice.sendTime}</strong>
          </c:if>
          <c:if test="${data.notice.isRead==1}">
               ${data.notice.sendTime}
          </c:if>
        </td>
        
        <c:if test="${flag==1}">
          <td width="12%" align="center" class="td_bottom_b">
             <c:if test="${data.notice.audtitingFlag==0}">
                                        未审核
             </c:if>
             <c:if test="${data.notice.audtitingFlag==1}">
                                        审核成功
             </c:if>
             <c:if test="${data.notice.audtitingFlag==2}">
                                        审核失败
             </c:if>
             <c:if test="${data.notice.audtitingFlag==3}">
                                        已撤销
             </c:if>
             <c:if test="${data.notice.audtitingFlag==8}">
                                        已接收
             </c:if>
          </td>
        </c:if>
        
        <c:if test="${flag==1}">
           <td width="20%" align="center" class="td_bottom_b">
             <c:if test="${data.notice.audtitingFlag==0 || data.notice.audtitingFlag==8}">
                    <a href="javascript:resetNotice(${data.notice.id});">撤销</a> &nbsp;
                    <a href="javascript:noAppDetail(${data.notice.id});">详情</a>
             </c:if>
             <c:if test="${data.notice.audtitingFlag==3}">
                <a href="javascript:detail(${data.notice.id});">详情</a>
             </c:if>
             
             <c:if test="${data.notice.audtitingFlag==1}">
               <a href="javascript:successDetail(${data.notice.id});">详情</a>
             </c:if>
             
             <c:if test="${data.notice.audtitingFlag==2}">
               <a href="javascript:edit(${data.notice.id});">编辑</a>&nbsp;
               <a href="javascript:detail(${data.notice.id});">详情</a>
             </c:if>
           </td>
        </c:if>
        
        <c:if test="${flag==2}">
           <td width="20%" align="center" class="td_bottom_b">
              <a href="javascript:edit(${data.notice.id});">编辑</a>
           </td>
        </c:if>
      </tr>
   </c:forEach>
    </c:if>  
     
     
     
     <c:if test="${demo==2}"> 
   <c:forEach items="${pages.pageList}" var="data">
   
      <tr name="color">
        <td width="10%" height="35" align="center" valign="middle" class="td_bottom_b">
        <strong>
          <label for="checkbox2"><img src="<%=request.getContextPath()%>/potal/page/notice/images/gg_lb.png" width="19" height="21" /></label>
        </strong>
        <input type="hidden" id="nid" name="nid" value="${data.id}"/>

        </td>
          
        <td width="12%" align="center" class="td_bottom_b">
             <c:if test="${data.isRead==0}">
                  <c:if test="${data.typeid==1}">
                     <strong>公司公告</strong>
                  </c:if>
                  <c:if test="${data.typeid==2}">
                     <strong>部门公告</strong>
                  </c:if>
             </c:if>
            
            <c:if test="${data.isRead==1}">
                  <c:if test="${data.typeid==1}">
                                                          公司公告
                  </c:if>
                  <c:if test="${data.typeid==2}">
                                                        部门公告
                  </c:if>
             </c:if>
        </td>
        <td width="12%" align="center" class="td_bottom_b">
           <c:if test="${data.isRead==0}">
              <strong>${data.startDept.name}</strong>
           </c:if>
           <c:if test="${data.isRead==1}">
              ${data.startDept.name}
           </c:if>
        </td>
        <td align="center" class="td_bottom_b" width="16%">
          <c:if test="${data.isRead==0}">
             <strong>
               <a href="javascript:detail(${data.id});">${data.title}</a>
             </strong>
          </c:if>
          <c:if test="${data.isRead==1}">
            <a href="javascript:detail(${data.id});">${data.title}</a>
          </c:if>
         </td>
        <td width="15%" align="center" class="td_bottom_b">
          <c:if test="${data.isRead==0}">
               <strong>${data.sendTime}</strong>
          </c:if>
          <c:if test="${data.isRead==1}">
               ${data.sendTime}
          </c:if>
        </td>
        
        <c:if test="${flag==1}">
          <td width="12%" align="center" class="td_bottom_b">
             <c:if test="${data.audtitingFlag==0}">
                                        未审核
             </c:if>
             <c:if test="${data.audtitingFlag==1}">
                                        审核成功
             </c:if>
             <c:if test="${data.audtitingFlag==2}">
                                        审核失败
             </c:if>
             <c:if test="${data.audtitingFlag==3}">
                                        已撤销
             </c:if>
             <c:if test="${data.audtitingFlag==8}">
                                        已接收
             </c:if>
          </td>
        </c:if>
        
        <c:if test="${flag==1}">
           <td width="20%" align="center" class="td_bottom_b">
             <c:if test="${data.audtitingFlag==0 || data.audtitingFlag==8}">
                    <a href="javascript:resetNotice(${data.id});">撤销</a> &nbsp;
                    <a href="javascript:noAppDetail(${data.id});">详情</a>
             </c:if>
             <c:if test="${data.audtitingFlag==3}">
                <a href="javascript:detail(${data.id});">详情</a>
             </c:if>
             
             <c:if test="${data.audtitingFlag==1}">
               <a href="javascript:successDetail(${data.id});">详情</a>
             </c:if>
             
             <c:if test="${data.audtitingFlag==2}">
               <a href="javascript:reSend(${data.id});">编辑</a>&nbsp;
               <a href="javascript:detail(${data.id});">详情</a>
             </c:if>
           </td>
        </c:if>
        
        <c:if test="${flag==2}">
           <td width="20%" align="center" class="td_bottom_b">
              <a href="javascript:edit(${data.notice.id});">编辑</a>
           </td>
        </c:if>
      </tr>
   </c:forEach>
    </c:if>   
      </table>
      </td>
  </tr>
</table>
     <tr>
	   <c:if test="${flag==0}">
		 <td id="pageNo" colspan="8">
		   <p:pages url="listNtnotice.do?flag=0" />
		 </td>
	   </c:if>
	   
	   <c:if test="${flag==1}">
		 <td id="pageNo" colspan="8">
		   <p:pages url="noAppnotice.do?flag=1" />
		 </td>
	   </c:if>
	   
	   <c:if test="${flag==2}">
		 <td id="pageNo" colspan="8">
		   <p:pages url="draftListnotice.do?flag=2" />
		 </td>
	   </c:if>
	</tr>

</div>
  </body>
</html>
