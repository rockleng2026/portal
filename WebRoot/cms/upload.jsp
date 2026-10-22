<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>


<%
String path = request.getContextPath();
String fwq_saveUrl=request.getRealPath("/")+"YHJL";//服务器存放路径   配置到资源文件中
// 新建一个SmartUpload对象
SmartUpload su = new SmartUpload();
// 上传初始化
su.initialize(pageContext);
// 设定上传限制
// 1.限制每个上传文件的最大长度。
su.setMaxFileSize(999999999);
// 2.限制总上传数据的长度。
//su.setTotalMaxFileSize(20000);
// 3.设定允许上传的文件（通过扩展名限制）,仅允许doc,txt文件。
su.setAllowedFilesList("gif,jpg,bmp,txt,doc,xls,htm,html,tmp,JPG,TMP");
// 4.设定禁止上传的文件（通过扩展名限制）,禁止上传带有exe,bat,jsp,htm,html扩展名的文件和没有扩展名的文件。
su.setDeniedFilesList("exe,bat");
// 上传文件
su.upload();
// 将上传文件全部保存到指定目录
java.io.File save_file=new java.io.File(fwq_saveUrl);
if(!save_file.exists()){ 
	save_file.mkdirs(); 
}
String url=save_file.getAbsolutePath();
su.save(url);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'upload.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    This is my JSP page. <br>
  </body>
</html>
