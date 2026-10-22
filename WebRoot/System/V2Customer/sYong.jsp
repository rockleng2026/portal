<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>试用新增</title>
<style type="text/css"> 
.po{width:453px; margin:0 auto; font-size:12px}
img{border:0}
.tc_box2{width:451px; height:429px; float:left; border:1px solid #d1d1d1;background: white;}
.tc_top2{width:441px; height:23px; line-height:23px; padding-left:10px; background:#295a00; color:#FFFFFF; font-size:12px; margin-bottom:6px;}
.tc_top2 span{float:right; padding-right:15px; padding-top:1px;}
.tc_top2 a{text-decoration:none; font-size:14px; font-weight:bold; color:#FFFFFF}
.text2{width:180px; height:19px; border:1px solid #d1d1d1; overflow:hidden}
.rea2{width:216px; height:69px; border:1px solid #d1d1d1; overflow:hidden}
.xl3{width:120px; background:url(xl3.jpg) no-repeat; height:21px; overflow:hidden; border:1px solid #d1d1d1}
.an2{width:58px; height:24px; background:#549201; border:none; color:#FFFFFF; font-weight:bold; margin-left:18px;}
</style>
</head>
 
<body class="po">
<div class="tc_box2">
<div class="tc_top2">
<span><a href="javascript:;" onclick="f2()">×</a></span>添加客户试用记录
</div>
<div class="tc_nr">
<table width="451" height="398" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="118" align="right">试用服务器IP：</td>
    <td><input name="" type="text2" class="text2" /></td>
  </tr>
  <tr>
    <td width="118" align="right">服务器配置：</td>
    <td><text2area2 class="rea2"></text2area2></td>
  </tr>
  <tr>
    <td width="118" align="right">宽带（M）</td>
    <td><select name="" class="xl2"></select>&nbsp;</td>
  </tr>
  <tr>
    <td width="118" align="right">是否购买：</td>
    <td><input name="" type="radio" value="" />是<input name="" type="radio" value="" />否</td>
  </tr>
  <tr>
    <td width="118" align="right">试用开始时间：</td>
    <td><input name="" type="text"  class="text2"/></td>
  </tr>
  <tr>
    <td width="118" align="right">试用结束时间：</td>
    <td><input name="" type="text" class="text2" /></td>
  </tr>
  <tr>
    <td width="118" align="right">备注：</td>
    <td><textarea name="" cols="" rows="" class="rea2" ></textarea></td>
  </tr>
  <tr>
    <td width="118" align="right">&nbsp;</td>
    <td><form id="form1" name="form1" method="post" action="">
      <label>
        <input type="submit" name="Submit" value="提交" class="an2" />
        </label>
      <label>
      <input type="reset" name="Submit2" value="重置"  class="an2 "/>
      </label>
    </form></td>
  </tr>
</table>
 
</div>
 
</div>
 
 
</body>
</html>
