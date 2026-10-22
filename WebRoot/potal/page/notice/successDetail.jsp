<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>待审核公告详情</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
  </head>
  <style type="text/css">
<!--
body { width:760px; margin:0 auto; font-size:12px;}
.main { width:760px; margin:0 auto;}
.wzdh { line-height:30px;}
.wz_ls { color:#398602;}
.wz_cs { color:#ff6702;}
.dsh_xq { width:750px; line-height:25px; color:#fff; padding-left:10px; font-weight:bold; background-color:#295a01;}
.xq_nr { width:745px; background-color:#f3f3f3; padding-left:15px; padding-bottom:10px;}
.xq_zt { line-height:40px; font-weight:bold; font-size:14px;}
.xq_yh { line-height:25px; margin-top:10px; border-bottom:1px dashed #7e7e7e; width:730px;}
.tz_nr { width:715px; height:350px; overflow-y:auto; line-height:20px; padding-left:10px; padding-top:10px; background-color:#fff; border:1px solid #285900; margin-top:10px;}
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; width:48px; line-height:22px; text-align:center; float:right;margin-right:330px; border:0; margin-top:10px;}
.gb_bt1{ background-color:#4FA805; font-weight:bold; color:#fff; width:48px; line-height:22px; text-align:right; float:right;margin-right:30px; border:0; margin-top:10px;}
.gb_bt_h{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:50px; line-height:20px; text-align:center; float:left;margin-left:10px; border:0}
.gb_bt_h_z{ background-color:#7b7b7b; font-weight:bold; color:#fff; width:75px;line-height:20px;text-align:center; float:left;margin-left:10px; border:0}
.td_bottom_m{ margin-bottom:5px;}
.td_top_m{ margin-top:10px;}
.fon{ padding-top:3px;}
a{ text-decoration:none; color:#285b00}
a:hover{ color:#ff6801;}
.cheng{color:#ff6602}
-->
</style>

<script type="text/javascript">
   //返回
  function goback(){
   window.history.go(-1);
 }
  
  //待审核
   function daishenhe(){
      window.location.href="noAppnotice.do?flag=1";
   }
   
            //查看附件
 function xzfj(fj){
     window.location.href="downloadTaskUpload.do?url="+fj;
 } 
</script>



  <body>
   <div class="main">
<div class="wzdh">
<span class="wz_ls">您的位置：
</span>
首页&gt;
<span class="wz_cs">
待审核详情
</span>
</div>
</div>
<div class="main">
<div class="dsh_xq">
待审核详情
</div>
</div>
<div class="main">
<div class="xq_nr">
<span class="xq_zt">
主题：${data.title}
</span>
<div class="xq_yh">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="45%">公告类型：
        <c:if test="${data.typeid==1}">
                            公司公告
        </c:if>
        <c:if test="${data.typeid==2}">
                            部门公告
        </c:if>
      </td>
      <td width="55%">发起时间：${data.sendTime}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="45%">发起部门：${data.startDept.name}</td>
            <td width="55%">通知部门：
              <c:forEach items="${list}" var="list">
                 ${list.dept.name},
              </c:forEach>
            </td>
          </tr>
        </table>
      
    </tr>
  </table>
</div>
<div class="xq_yh"></div>
<div class="tz_nr">
   ${data.content}
</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="10%" height="35" align="right">审核状态：</td>
    <td width="90%">
       <c:if test="${aot.auditingFlag==1}">
                      审核通过
       </c:if>
       <c:if test="${aot.auditingFlag==2}">
                      审核未通过
       </c:if>
    </td>
  </tr>
  <tr>
    <td align="right" valign="top">审核意见：</td>
    <td><label for="textarea"></label>
      <textarea name="textarea" id="textarea" cols="75" rows="10">${aot.tmp}</textarea></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class="td_bottom_m">
    <td width="19%" align="right"><br /><span  class="gb_bt_h_z">附件信息</span><br /></td>
    <td width="81%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr class="td_bottom_m">
        <td width="10%" align="right" valign="top" class="fon"></td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="21%" rowspan="2" align="left">
                  <c:forEach items="${fjlist}" var="data">
                     <img src="<%=request.getContextPath()%>/potal/page/notice/images/ygxx_rar.png" width="20" height="20" />${data.fjmc} <a href="javascript:xzfj('${data.fjlj}');">预览下载</a>,
                  </c:forEach>
                </td>
                </tr>
              </table></td>
            
            
            </tr>
          </table></td>
      </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="button" name="fanHui" id="fanHui" value="返回" class="gb_bt" onclick="goback()" />
    <input type="submit" name="fanHui2" id="fanHui2" value="确认" class="gb_bt1" onclick="daishenhe();"/></td>
  </tr>
</table>


</div>
  </body>
</html>
