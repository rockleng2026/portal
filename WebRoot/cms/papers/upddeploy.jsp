<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>推荐配置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="./cms/css/admin.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
    <script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="./cms/js/upddeploy.js"></script>
</head>
<body>
<div id="weizhi">
<div id="weizhiwz">当前位置&nbsp;>>&nbsp;内容部&nbsp;>>&nbsp;增加配置</div>
</div>
<div class="conSet">
<form action="" id="forms" method="post">
<input type="hidden" id="errorName" />
<input type="hidden" id="strname" value="${strname }"/>
<input type="hidden" name="rec_part.pid" value="${rec_part.pid }"/>
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="space tableBg">
 <tr>
  <td align="left" nowrap  style="width:150px; text-indent:15px; background-color:#FFF;">参数位置：</td>
  <td align="left" nowrap  style="width:200px;background-color:#FFF;"><input type=text name="rec_part.part_name" id="pname" maxlength="20" value="${rec_part.part_name }">
  </td>
  <td align="left" nowrap  style="background-color:#FFF;"><span id="ers1" style="color:red;"></span>
</td>
 </tr>
 <tr>
  <td align="left" nowrap class="bg0" style="width:150px; text-indent:15px;">英文缩写：</td>
  <td align="left" nowrap class="bg0" style="width:200px;"><input type=text name="rec_part.eng_name" id="engname" style="width:200" 
  maxlength="20"  value="${rec_part.eng_name }">
</td>
  <td align="left" nowrap class="bg0" style="color:#707070;"><span id="ers2" style="color:red;"></span>请填写名称的英文缩写 系统会根据此来配置变量</td>
 </tr>
  <tr>
  <td align="left" nowrap  style="width:150px; text-indent:15px;background-color:#FFF;">所属模块：</td>
  <td align="left" nowrap  style="width:200px;background-color:#FFF;"><input type=text name="rec_part.mid" id="mid" style="width:200" maxlength="20" value="${rec_part.mid }">
</td>
  <td align="left" nowrap style="background-color:#FFF;color:#707070;"><span id="ers3" style="color:red;"></span>1-首页引用  2-栏目页 3-内容页引用   4-最新页面   5-全局引用
</td>
 </tr>
  <tr>
  <td align="left" nowrap class="bg0" style="width:150px; text-indent:15px;">所属类型（站点）：</td>
  <td align="left" nowrap class="bg0">
   <input type="text" value="${siteengname }" />
   <input type="hidden" id="typeid" name="rec_part.typeid" value="${sitekey }" />
   
   <!-- 
   <select id="typeid" name="rec_part.typeid" style="width:100px;">
      <option value="010">all</option>
   </select>
    -->
  </td>
  <td align="left" nowrap class="bg0">
    此处不可编辑<span id="ers4" style="color:red;"></span>
  </td>
 </tr>
 <tr>
  <td align="left" nowrap  style="width:150px; text-indent:15px;background-color:#FFF;">最大数量：</td>
  <td align="left" nowrap style="width:200px;background-color:#FFF;"><input type=text name="rec_part.part_num" id="pnum"  value="${rec_part.part_num }"
  style="width:200" maxlength="2">
  </td>
  <td align="left" nowrap style="background-color:#FFF;color:#707070;"><span id="ers5" style="color:red;"></span>*限制2位数字</td>
 </tr>
  <tr>
  <td align="left" nowrap class="bg0" style="width:150px; text-indent:15px;">备注：</td>
  <td colspan="2" align="center" nowrap class="bg0" style="width:200px;"><textarea rows="10" cols="60" id="temp" name="rec_part.temp">${rec_part.temp }</textarea>
</td>
  </tr>
  <tr>
  <td colspan="3" align="center" class="bg1"><input type="button" id="buts" class="save_but" value="保 存" onclick="checkForm();">
</td>
  </tr>
 </table>
 </form>
</div>

</body>
</html>
