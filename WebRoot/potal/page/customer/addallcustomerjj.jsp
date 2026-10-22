<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>无标题文档</title>
<style type="text/css">
body{width:453px; font-size:14px;  font-family:"微软雅黑"}
dl,dd,dt{padding:0px; margin:0px;}
img{border:0}
.tc_box1{width:451px; height:322px; border:1px solid #d1d1d1; float:left}
.tc_top1{width:441px; height:23px; background:#295a00; float:left; padding-left:10px; font-size:12px; color:#FFFFFF; line-height:23px; margin-bottom:20px;}
.tc_top1 span{float:right; padding-right:10px; padding-top:7px;}
.tc_top1 a{font-size:16px; font-weight:bold; text-decoration:none; color:#FFFFFF}
.tc_nr1{width:380px; float:left; padding-left:20px;}
.text1{width:135px; height:19px; border:1px solid #d1d1d1; overflow:hidden; padding-left:5px; font-size:12px;}
.rea1{width:244px; height:120px; border:1px solid #d1d1d1; overflow:hidden; font-size:12px; padding:5px;}
.an1{width:58px; height:24px; background:#549201; border:none; color:#FFFFFF; font-weight:bold; margin-left:18px;}
.ywry1{float:left}
.ywry1 dd{float:left}
.ywry1 dt{width:49px; height:23px; background:#7b7b7b; float:left; text-align:center; color:#FFFFFF; font-size:12px; line-height:23px; margin-left:10px;}
</style>
<script type="text/javascript">
         function uppeople(){
         $("#hidemp").hide();
         $("#showemp").show();
         $("#t1").hide();
         var url="getemplistNewportalCustomer1.do";
           $.post(url,{},function(data){
          $("#showemp").html("");
           $("#showemp").append(data);
		    
		  });
         }
         </script>
</head>

<body onload="uppeople()">
<div class="tc_box1">
<div class="tc_top1"><span><a href="javascript:removeDiv0()"  ><img src="<%=basePath%>potal/images/customer/xx.png"  /></a></span>新增客户交接记录</div>
<div class="tc_nr1">
<form action="customerMoveallNewportalCustomer1.do?custid=<%=request.getParameter("custid") %>" method="post"  >
<table width="400" height="264" border="0" cellpadding="0" cellspacing="0">
    <tr><td>&nbsp;&nbsp;业务人员:</td><td>&nbsp;&nbsp;${emp.name}</td></tr><input type="hidden" name="employeeName" value="${emp.id}"></input>
   <tr> 
   <td width="100" height="44" align="center">接收人员：</td>
   <td  height="44" width="250" align="left"><div id="hidemp"></div><div id="showemp" style="display: none"></div><a href="javascript:uppeople();" class="gengai" id="t1" style="display: block">选择</a></td>
    <td height="44" align="left"></td>
	
  </tr>
  <tr>
    <td width="100" align="center">交接日期：</td>
        <%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 

java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

String str_date1 = formatter.format(currentTime); //将日期时间格式化 
     %>
    <td colspan="2"><input name="date1" type="text"  class="text1" value="<%=str_date1 %> "/></td>
  </tr>
  <tr>
    <td width="100" align="center" valign="top">交接原因：</td>
    <td  colspan="2"><textarea name="jiaojie" cols="" rows="" class="rea1"></textarea></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td  colspan="2">
      <label>
        <input type="submit" name="Submit" value="提交" class="an1" />
        </label>
      <label>
      <input type="reset" name="Submit2" value="重置"  class="an1 "/>
      </label>
    
    </td>
  </tr>
</table>
</form>
</div>

</div>


</body>
</html>
