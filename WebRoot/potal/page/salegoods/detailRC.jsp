<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>资源核实单详细</title>
<style>
.bb{ width:575px; font-size:14px; border:1px solid #666666}
.main1 { width:575px; margin:0 auto;}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.dow{width:575px; height:230px; float:left}
.dow1_top{width:575px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden; margin-bottom:10px;}
.dow1_top span{float:right; padding-right:10px; padding-top:1px;}
.dow1_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
	 ul ,ul li{ margin:0px; padding:0px; list-style:none;}
	.sp_nav_tab{ border-bottom:1px solid #295A00; height:26px; }
	.sp_nav_tab .nomarl{ width:105px; line-height:25px; margin-top:1px; border:1px solid #295A00; border-bottom-width:0; background-color:#EAFED9;}
	.sp_nav_tab  li { float:left; text-align:center; margin-left:20px;}
	.sp_nav_tab    .sq{ width:8px; height:8px; background-color:#295A00; margin-top:9px;}
	.sp_nav_tab .active{ background-color:#fff;width:95px; line-height:25px; border:1px solid #295A00; border-bottom-width:0; position:relative;  margin-top: 1px;}
	.font_color_hui{ color:#8c8c8c;}
	.font_color_lv{ color:#295a01;}
.dow1_top {width:565px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.gb_btrw{ background-color:#4FA805; font-weight:bold; scolor:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:auto; border:0} 
</style>
  </head>
  
 <body class="bb">
<div class="main1"  style="background-color:#ffffff;border:1px solid #666666;">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    
    
    
    <div class="dow1_top"><span><a href="javascript:yingcangall();">×</a></span> 资源核查单详情 </div>
    <br />
    </td>
  </tr>
</table>



<ul class="sp_nav_tab">
<li class="nomarl">基本信息</li>
</ul>
<br />
<table width="100%" border="0" cellspacing="8" cellpadding="0">
  <tr>
    <td width="27%" align="right" class="font_color_hui">资源审核编号：</td>
    <td width="16%">&nbsp;&nbsp;&nbsp;${trc.rvid}</td>
    <td width="14%" align="right" class="font_color_hui">申请人：</td>
    <td width="43%">&nbsp;&nbsp;&nbsp;${trc.empid.name}</td>
  </tr>
  <tr>
    <td align="right" class="font_color_hui">地区：</td>
    <td>&nbsp;&nbsp;&nbsp;${trc.city.name}</td>
    <td align="right" class="font_color_hui">仓库：</td>
    <td>&nbsp;&nbsp;&nbsp;${trc.depot.name}</td>
  </tr>
  <tr>
    <td align="right" class="font_color_hui">创建时间：</td>
    <td>&nbsp;&nbsp;&nbsp;${trc.starttime}</td>
    <td align="right" class="font_color_hui">状态：</td>
    <td>&nbsp;&nbsp;&nbsp;
    		<c:if test="${rc.isstate == '0'}">未审批</c:if>
          	<c:if test="${rc.isstate == '1'}">已审批</c:if>
          	<c:if test="${rc.isstate == '2'}">已回复</c:if> 
          	<c:if test="${rc.isstate == '3'}">拒审批</c:if>
          	<c:if test="${rc.isstate == '4'}">已撤销</c:if>
    </td>
  </tr>
  </table>

<ul class="sp_nav_tab">
<li class="nomarl">商品属性</li>
</ul>
<table width="100%" border="0" cellspacing="0" cellpadding="15">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td width="25%" align="right" class="font_color_hui">商品名称：</td>
          <td width="27%">&nbsp;&nbsp;${sg.sgname}</td>
          <td width="19%" align="right" class="font_color_hui">商品编码：</td>
          <td width="29%">&nbsp;&nbsp;${sg.sgcode }</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">商品录入人：</td>
          <td>&nbsp;&nbsp;${sg.sgUsername}</td>
          <td align="right" class="font_color_hui">商品价格：</td>
          <td>&nbsp;&nbsp;${sg.sgPrice}</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">商品规格：</td>
          <td>&nbsp;&nbsp;${sg.sgNorms}</td>
          <td align="right" class="font_color_hui">商品单位：</td>
          <td>&nbsp;&nbsp;${sg.sgUnit}</td>
        </tr>
        <tr>
          <td align="right" class="font_color_hui">商品详情：</td>
          <td>&nbsp;&nbsp;${sg.sgDetails}</td>
          <td align="right">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="10" cellpadding="0">
  <tr>
    <td align="center"><input type="button" style="CURSOR:pointer;" onclick="javascript:yingcang2();" name="button2" id="button2" class="gb_btrw" value="关闭" /></td>
    </tr>
</table>
</div>

</body>
</html>
