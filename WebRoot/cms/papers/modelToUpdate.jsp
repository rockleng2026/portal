<%@ page contentType="text/html; charset=gbk"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>模块信息修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
  </head>
 
  
  <body bgcolor="#eeeeee">
     <form action="<%=path%>/cms/updatemodelModel.do" method="post">
       <table align="center">
         <tr>
           <input type="hidden" name="model.modelid" value="${model.modelid}" />
           <td align="right">模块名称:</td>
           <td>
            <input type="text" name="model.modelname" id="name" value="${model.modelname}"/>
           <td>
            <div id="modelname"></div>
           </td>
         </tr>
         <tr>
           <td align="right">模块昵称:</td>
           <td>
             <input type="text" name="model.modelalias" value="${model.modelalias}"/>
           </td>
         </tr>
         <tr>
           <td align="right">ICO:</td>
           <td><input type="text" name="model.modelico" value="${model.modelico}"/></td>
         </tr>
         <tr>
           <td align="right">URL:</td>
           <td><input type="text" name="model.modelurl" value="${model.modelurl}"/></td>
         </tr>
         <tr>
           <td colspan="4" align="center"><input type="submit" value="保存"/></td>
         </tr>
       </table>
     </form>
  </body>
</html>
