<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-我的工单删除）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color:#999;">
 <div class="ly_gd">
    <div class="ly_gdt"><span><a href="#">关闭</a></span>温馨提示</div>
    <div class="ly_gdc">
       <div class="ly_gdc_t">
         <div class="ly_gdc_tl"><img src="images/zh_13.gif" /></div>
         <div class="ly_gdc_tr">
           <div class="ly_gdc_trt">您确定要删除该工单么？</div>
           <div class="ly_gdc_trd">删除后将永久删除，不可恢复哦！</div>
         </div>
       </div>
       <div class="ly_gdc_d">
         <div class="ly_gdc_dl"><a href="#">确 &nbsp; 认</a></div>
         <div class="ly_gdc_dr"><a href="#">取 &nbsp; 消</a></div>
       </div>
    </div>
    <div class="ly_gdd"></div>
 </div>
   
</body>
</html>
