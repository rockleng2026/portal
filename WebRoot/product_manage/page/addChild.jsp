<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'add.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/json2.js"></script>
    <script type="text/javascript" src="<%=basePath%>product_manage/js/add.js" charset="GBK"></script>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>product_manage/css/classTypeManage1.css">

  </head>
  
  <body>
  <input type="hidden" id="path" value="<%=basePath%>">
  <s:bean name="java.util.Date" id="date"></s:bean>
      <div id="addorUpdSuppers">
       <input type="hidden" name="goodsdicts.gdWritename" id="gdWritename">
        <input type="hidden" id="getids1">
         <input type="hidden" id="getsupids" value="${ids1 }">
      <form action="<%=basePath%>pdm/addSupperGoodsClassprojt.do" method="post" id="goodClassPjt">
         <div style="width:700px;height:200px;">
           <table border="0" cellspacing="0" id="childTab"  cellpadding="5" width="100%" height="100%"  style="border:1px solid #9fcaea;text-align: center;">
             <tr bgcolor="#9fcaea"><td colspan="2"><span id="setChildOpertype">增加子类</span></td></tr>
             <tr valign="middle"><td align="right" width="270">父类编码:</td><td align="left"><textarea cols="19" rows="1"  id="superCodes" readonly="readonly" >${supcodes }</textarea></td></tr>
             <tr valign="middle"><td align="right">父类名称:</td><td align="left"><input type="text" id="superNames" readonly="readonly"  value="${supnames }"/></td></tr>
             <tr valign="middle"><td align="right">子类编码:</td><td align="left"><textarea cols="19" rows="1" id="childCodes" readonly="readonly" >${classcods }</textarea></td></tr>
             <tr valign="middle"><td align="right">子类名称:</td><td align="left"><input type="text" id="childNames"/>&nbsp;&nbsp;<span id="cerrorName"></span></td></tr>
             <tr valign="middle"><td align="right">录入时间:</td><td align="left"><input type="text" id="writetime" value="<s:date name="date" />" readonly="readonly"/></td></tr>
              <tr ><td colspan="2" style="float:left;" height="120">
                <input type="checkbox" name="gdchildWritename1" id="addColumn" >是否添加类目属性<br/><br/><br/><div id="addButton"><div onclick="return arrs('c',1)" class="ann" id="subdate">提交</div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
             </td>
             </tr>
          </table>
          <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;display: none;" id="isaddColumn">类目属性&nbsp;&nbsp;&nbsp;&nbsp;<div class="ann" onclick="return addnewsuperColumn('c')" id="addallproperty">添加</div></div>
          </div>
           <!-- 显示增加字段 -->
	      <div id="addFields">
	      </div>
           <div style="width: 700px;background-color: #f8f8f8;height: 20px;border: 1px solid #000000;overflow: auto;height: 100px;" id="Resultpreview">
                <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;">效果浏览：</div>
                   <div style="margin-left:40px;" id="Resultpreviews">
                   
                   </div>
           </div>
            <div style="width: 700px;background-color: #f8f8f8;height: 20px;border: 1px solid #000000;overflow: auto;height: 100px;display: none;" id="addProperty">
                   <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;">已添加属性：</div>
                   <div style="margin-left:40px;" id="Resultaddproperty">
                   
                   </div>
           </div>
            <div style="width: 700px;height:30px;background-color: #f2f2f2;height: 30px;border: 1px solid #9fcaea;">
	          <div style="margin-left:40%;">
	                <div class="ann" style="margin: 0 auto;" onclick="outMenus()">返回</div>
	           </div>
	         </div>
           </form>
      </div>
    
  </body>
</html>
