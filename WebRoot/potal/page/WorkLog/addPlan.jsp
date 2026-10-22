<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加便签</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
<style type="text/css">
	body{width:760px; margin:0 auto; font-size:12px}
	img{border:0}
	dl,dd,dt,p,input{padding:0px; margin:0px;}
	.dow{width:692px; height:230px; float:left}
	.dow_top{width:692px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
	.dow_top span{float:right; padding-right:10px; padding-top:1px;}
	.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
	.dow_nr{width:700px; border:1px solid #455c32;float:left}
	.tc_form{width:750px; float:left; line-height:23px;}
	.tc_form dd{width:530px; float:left; text-align:right;}
	.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
	.tc_form dt span{width:50px; float:right}
	.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
	.text{width:145px; height:19px; border:1px solid #b2b2b2}
	.foot{padding-right:15px}
	.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
	.foot a:hover{background:#5da500; color:#FFFFFF}
	.tc_top{background:#7b7b7b; color:#FFFFFF}
	.tc_footb{border-bottom:1px solid #c3c3c3}
	.tc_footb a{text-decoration:none; color:#ff9002; clear:both}
	.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
	.tc_rightb{border-right:1px solid #c3c3c3}
	.zysh { background-color:#7c7c7c; color:#fff; line-height:20px; width:70px; text-align:center; margin-right:150px;}
	.jcjg { width:541px; height:75px; background-color:#f0f0f0; border:1px solid #adadad; line-height:20px;}
	.jcjg span { color:#fa905e;}
	.xhbt { color:#fe0000;}
	<!-- 按钮 -->
.gb_bt{ background-color:#4FA805; font-weight:bold; color:#fff; line-height:25px; 
text-align:center; margin-left:auto; margin-right:auto; border: 2px solid #4FA805;cursor:hand; margin:3px;}
<!-- 表格里面的按钮  -->
.gb_bb{background-color:#4FA805; font-weight:bold; color:#fff; line-height:18px; 
text-align:center; border: 1px solid #4FA805;cursor:hand;margin:3px 7px;}
 a{text-decoration: none;}
</style>

<script type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>


  </head>
  
<body>
<div class="dow">
<div class="dow_top">
<span><a href="#">×</a></span>
&nbsp;&nbsp;&nbsp;新增一行日志
</div>
<div class="dow_nr">
<form id="form1" name="form1" method="post" action="">
<table width="100%"  border="0" cellspacing="0"  cellpadding="0">
   <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="16%" height="35" align="right">发起人：</td>
        <td width="35%" height="35" align="left"><input type="text" name="mobanmingcheng" readonly="readonly"  value="${emp.name }" /></td>
        <td width="14%" height="35" align="right">完成效果：</td>
        <td width="35%" height="35" align="left">
          <label>
             <input type="radio" name="radiobutton" value="radiobutton" checked="checked" />
          </label>
        		完成　
        <label>
        <input type="radio" name="radiobutton" value="radiobutton" />
        </label>
                           未完成
        </td>
      </tr>
      <tr>
        <td height="35" align="right">参与人：</td>
        <td height="35" align="left">
	    　　　<select name="participator" id="participator0">
				<option value="无">
					无
				</option>
				<option value="美工">
					美工
				</option>
				<option value="开发组">
					开发组
				</option>
				<option value="销售部">
					销售部
				</option>
			</select>
		</td>
        <td height="35" align="right">延期时间：</td>
        <td height="35" align="left"><input type="text" name="lianxiren" /></td>
      </tr>
      <tr>
        <td height="35" align="right">开始时间：</td>
        <td height="35" align="left"><input type="text" name="lianxidianhua" /></td>
        <td height="35" align="right">上传附件：</td>
        <td height="35" align="left"><input type="text" name="xiaoshourenyuan" /> <input class="qr" type="submit" name="Submit3" value="浏览" /></td>
      </tr>
      <tr>
        <td height="35" align="right">结束时间：</td>
        <td height="35" align="left"><input type="text" name="lianxidianhua2" /></td>
        <td height="35" align="right">&nbsp;</td>
        <td height="35" align="left">&nbsp;</td>
      </tr>
    </table></td>
    </tr>
   <tr>
    <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="right" valign="top">工作内容：</td>
        <td>
          <textarea name="shangpinxinxi" cols="70" rows="8" wrap="physical"></textarea>
      </td>
      </tr>
      <tr>
	  <td width="16%" align="right" valign="top">效果描述：</td>
        <td width="84%"><textarea name="shangpinxinxi" cols="70" rows="8" wrap="physical"></textarea></td>
    
      </tr>
    </table>      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td colspan="4" align="right">&nbsp;</td>
          </tr>
        
    </table>    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        
          </tr>
      
    </table></td>
    </tr>
	
	<tr>
    <td align="center" height="50"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><table  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50"><div class="gb_bt">确认</div></td>
    <td width="105"><div class="gb_bt">取消</div></td>
  </tr>
</table>
</td>
  </tr>
</table></td>
    </tr>
</table>
  </form>    
</div>
</div> 
  </body>
</html>
