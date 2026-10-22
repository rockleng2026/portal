<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>交接新增</title>
<style type="text/css"> 
.b{width:453px; margin:0 auto; font-size:14px;  font-family:"微软雅黑"}
dl,dd,dt{padding:0px; margin:0px;}
img{border:0}
.tc_box3{width:451px; height:322px; border:1px solid #d1d1d1; float:left;background: white;}
.tc_top3{width:441px; height:23px; background:#295a00; float:left; padding-left:10px; font-size:12px; color:#FFFFFF; line-height:23px; margin-bottom:20px;}
.tc_top3 span{float:right; padding-right:10px; padding-top:1px;}
.tc_top3 a{font-size:16px; font-weight:bold; text-decoration:none; color:#FFFFFF}
.tc_nr3{width:380px; float:left; padding-left:20px;}
.text3{width:135px; height:19px; border:1px solid #d1d1d1; overflow:hidden; padding-left:5px; font-size:12px;}
.rea3{width:244px; height:120px; border:1px solid #d1d1d1; overflow:hidden; font-size:12px; padding:5px;}
.an3{width:58px; height:24px; background:#549201; border:none; color:#FFFFFF; font-weight:bold; margin-left:18px;}
.ywry3{float:left}
.ywry3 dd{float:left}
.ywry3 dt{width:49px; height:23px; background:#7b7b7b; float:left; text3-align:center; color:#FFFFFF; font-size:12px; line-height:23px; margin-left:10px;}
</style>
</head>
 
<body class="b">
<div class="tc_box3">
<div class="tc_top3"><span><a href="javascript:;" onclick="f2()">×</a></span>新增客户交接记录</div>
<div class="tc_nr3">
<table width="400" height="264" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="100" align="center" valign="middle">业务人员：</td>
    <td valign="middle">
	<dl class="ywry3">
	<dd><input type="text3"  class="text3" value="艾雪"/></dd>
	<dt><a href="javascript:genggai();" >更改</a></dt>
	</dl>
	</td>
  </tr>
  <tr>
    <td width="100" align="center">交接日期：</td>
    <td><input name="" type="text3"  class="text3" value="2012-09-26"/></td>
  </tr>
  <tr>
    <td width="100" align="center" valign="top">交接原因：</td>
    <td><textarea name="" cols="" rows="" class="rea">最近很忙交给另一个业务负责</textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><form id="form1" name="form1" method="post" action="">
      <label>
        <input type="submit" name="Submit" value="提交" class="an3" />
        </label>
      <label>
      <input type="reset" name="Submit2" value="重置"  class="an3 "/>
      </label>
    </form>
    </td>
  </tr>
</table>
 
</div>
 
</div>
 
 
</body>
</html>
