<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>跟进弹出框</title>
<style type="text/css">

.op{width:453px; margin:0 auto; font-size:14px;  font-family:"微软雅黑";}

img{border:0}

.tc_box1{width:451px; height:322px; border:1px solid #d1d1d1; float:left;background: white;}

.tc_top1{width:441px; height:23px; background:#295a00; float:left; padding-left:10px; font-size:12px; color:#FFFFFF; line-height:23px; margin-bottom:20px;}

.tc_top1 span{float:right; padding-right:10px; padding-top:8px;}

.tc_top1 a{font-size:16px; font-weight:bold; text-decoration:none; color:#FFFFFF}

.tc_nr1{width:400px; margin:0 auto;}

.text1{width:180px; height:19px; border:1px solid #d1d1d1; overflow:hidden}

.rea1{width:254px; height:130px; border:1px solid #d1d1d1; overflow:hidden}

.an1{width:58px; height:24px; background:#549201; border:none; color:#FFFFFF; font-weight:bold; margin-left:18px;}

</style>

</head>



<body class="op" >

<div class="tc_box1">

<div class="tc_top1"><span><a href="javascript:f2()"><img src="<%=path%>/System/V2Customer/images/xx.jpg" /></a></span>新增客户跟进记录</div>

<div class="tc_nr1" >

<table width="400" height="264" border="0" cellpadding="0" cellspacing="0">

  <tr>

    <td width="100" align="center" valign="middle">跟进日期：</td>

    <td valign="middle"><input type="text"  class="text1" value="2012-11-30"/>&nbsp;</td>

  </tr>

  <tr>

    <td width="100" align="center">跟进方式：</td>

    <td><input name="" type="checkbox" value="" />面谈<input type="checkbox" value="" checked="checked" />

    电话<input name="" type="checkbox" value="" />短信<input name="" type="checkbox" value="" />其他</td>

  </tr>

  <tr>

    <td width="100" align="center" valign="top">跟进内容：</td>

    <td><text1area1 name="" cols="" rows="" class="rea1">需要公司位置提供服务器</text1area1></td>

  </tr>

  <tr>

    <td>&nbsp;</td>

    <td><form id="form1" name="form1" method="post" action="">

      <label>

        <input type="submit" name="Submit" value="提交" class="an1" />

        </label>

      <label>

      <input type="reset" name="Submit2" value="重置"  class="an1 "/>

      </label>

    </form>

    </td>

  </tr>

</table>



</div>



</div>





</body>

</html>

