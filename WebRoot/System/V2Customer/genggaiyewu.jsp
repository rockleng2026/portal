<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>更改业务人员的弹出框</title>
<style type="text/css"> 
.l{width:760px; margin:0 auto; font-size:12px}
img{border:0}
.l dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow7{width:760px; height:230px; float:left;background: white;}
.dow7_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow7_top span{float:right; padding-right:10px; padding-top:1px;}
.dow7_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow7_nr{width:758px; border:1px solid #455c32; height:202px; float:left}
.tc_form7{width:750px; float:left; line-height:23px;}
.tc_form7 dd{width:530px; float:left; text-align:right;}
.tc_form7 dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form7 dt span{width:50px; float:right}
.tc_form7 dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.l .text{width:145px; height:19px; border:1px solid #b2b2b2}
.foot7{padding-right:15px}
.foot7 a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot7 a:hover{background:#5da500; color:#FFFFFF}
.tc_top7{background:#7b7b7b; color:#FFFFFF}
.tc_foot7b7{border-bottom:1px solid #c3c3c3}
.tc_foot7b7 a{text-decoration:none; color:#ff9002; clear:both}
.tc_foot7b7 a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb7{border-right:1px solid #c3c3c3}
 
 
</style>
</head>
 
<body class="l">
<div class="dow7">
<div class="dow7_top">
<span><a href="javascript:f3();">×</a></span>
员工信息列表
</div>
<div class="dow7_nr">
<table width="100%" border="0" cellspacing="0" height="202" cellpadding="0">
  <tr>
    <td height="32" colspan="8" align="right">
	<dl class="tc_form7">
	<dd>员工姓名</dd>
	<dt><span><a href="#">查询</a></span><input name="" type="text" class="text" /></dt>
	
	</dl>
	</td>
    </tr>
  <tr>
    <td width="56" height="26" align="center" class="tc_top7 tc_rightb7">工号</td>
    <td width="78" height="26" align="center" class="tc_top7 tc_rightb7">姓名</td>
    <td width="52" height="26" align="center" class="tc_top7 tc_rightb7">性别</td>
    <td width="86" height="26" align="center" class="tc_top7 tc_rightb7">学历</td>
    <td width="132" height="26" align="center" class="tc_top7 tc_rightb7">联系电话</td>
    <td width="127" height="26" align="center" class="tc_top7 tc_rightb7">部门</td>
    <td width="112" height="26" align="center" class="tc_top7 tc_rightb7">职位</td>
    <td width="93" height="26" align="center" class="tc_top7">操作</td>
  </tr>
  <tr>
    <td width="56" height="26" align="center" class="tc_rightb7 tc_foot7b7">19033</td>
    <td width="78" height="26" align="center" class="tc_rightb7 tc_foot7b7">小夏</td>
    <td width="52" height="26" align="center" class="tc_rightb7 tc_foot7b7">男</td>
    <td width="86" height="26" align="center" class="tc_rightb7 tc_foot7b7">本科</td>
    <td width="132" height="26" align="center" class="tc_rightb7 tc_foot7b7">13268829668</td>
    <td width="127" height="26" align="center" class="tc_rightb7 tc_foot7b7">销售部</td>
    <td width="112" height="26" align="center" class="tc_rightb7 tc_foot7b7">业务</td>
    <td width="93" height="26" align="center" class="tc_foot7b7"><a href="#">选择该员工</a></td>
  </tr>
  <tr>
    <td width="56" height="26" align="center" class="tc_rightb7 tc_foot7b7">19033</td>
    <td width="78" height="26" align="center" class="tc_rightb7 tc_foot7b7">小夏</td>
    <td width="52" height="26" align="center" class="tc_rightb7 tc_foot7b7">男</td>
    <td width="86" height="26" align="center" class="tc_rightb7 tc_foot7b7">本科</td>
    <td width="132" height="26" align="center" class="tc_rightb7 tc_foot7b7">13268829668</td>
    <td width="127" height="26" align="center" class="tc_rightb7 tc_foot7b7">销售部</td>
    <td width="112" height="26" align="center" class="tc_rightb7 tc_foot7b7">业务</td>
    <td width="93" height="26" align="center" class="tc_foot7b7"><a href="#">选择该员工</a></td>
  </tr>
  <tr>
    <td width="56" height="26" align="center" class="tc_rightb7 tc_foot7b7">19033</td>
    <td width="78" height="26" align="center" class="tc_rightb7 tc_foot7b7">小夏</td>
    <td width="52" height="26" align="center" class="tc_rightb7 tc_foot7b7">男</td>
    <td width="86" height="26" align="center" class="tc_rightb7 tc_foot7b7">本科</td>
    <td width="132" height="26" align="center" class="tc_rightb7 tc_foot7b7">13268829668</td>
    <td width="127" height="26" align="center" class="tc_rightb7 tc_foot7b7">销售部</td>
    <td width="112" height="26" align="center" class="tc_rightb7 tc_foot7b7">业务</td>
    <td width="93" height="26" align="center" class="tc_foot7b7"><a href="#">选择该员工</a></td>
  </tr>
  <tr>
    <td width="56" height="26" align="center" class="tc_rightb7 tc_foot7b7">19033</td>
    <td width="78" height="26" align="center" class="tc_rightb7 tc_foot7b7">小夏</td>
    <td width="52" height="26" align="center" class="tc_rightb7 tc_foot7b7">男</td>
    <td width="86" height="26" align="center" class="tc_rightb7 tc_foot7b7">本科</td>
    <td width="132" height="26" align="center" class="tc_rightb7 tc_foot7b7">13268829668</td>
    <td width="127" height="26" align="center" class="tc_rightb7 tc_foot7b7">销售部</td>
    <td width="112" height="26" align="center" class="tc_rightb7 tc_foot7b7">业务</td>
    <td width="93" height="26" align="center" class="tc_foot7b7"><a href="#">选择该员工</a></td>
  </tr>
  <tr>
    <td height="35" colspan="8" align="right" class="foot7">[ 共 200 条记录    <a href="#">首页</a>    <a href="#">上一页</a>   <a href="#">下一页</a>    <a href="#">尾页</a>    页数：1/30页         ] </td>
    </tr>
</table>
 
</div>
 
 
</div>
</body>
</html>
