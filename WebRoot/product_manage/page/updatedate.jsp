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
        <input type="hidden" id="<c:if test="${empty supupdCodestr}">getids</c:if><c:if test="${supupdCodestr !=null}">getids1</c:if>" value=${currentids }>
        <input type="hidden" id="getsupids" value="${currentsupperids }"/>
         <div style="width:700px;height:200px;">
          <table border="0" cellspacing="0" id="superTab" width="100%" height="100%" cellpadding="5"  style="border:1px solid #9fcaea;text-align: center;">
             <tr bgcolor="#9fcaea"><td colspan="2"><span id="setOpertype"><c:out value="${updateClassProper }"></c:out></span></td></tr>
             <c:if test="${supupdCodestr !=null}">
               <s:property value="#request.supupdCodestr" escape="false" />
             </c:if>
             <c:if test="${supupdnamestr !=null}">
                 <s:property value="#request.supupdnamestr" escape="false" />
             </c:if>
             <tr valign="middle" id="addUpdatChild"><td align="right" width="270">当前编码:</td><td align="left"><textarea cols="19" rows="1"  name="gdcodes" id="<c:if test="${empty supupdCodestr}">gdcodes</c:if><c:if test="${supupdCodestr !=null}">childCodes</c:if>" readonly="readonly" >${currentCodes }</textarea></td></tr>
             <tr valign="middle"><td align="right">当前名称:</td><td align="left"><input type="text" name="gdnames"  id="<c:if test="${empty supupdCodestr}">gdnames</c:if><c:if test="${supupdCodestr !=null}">childNames</c:if>" value="${currentnames }"/>&nbsp;&nbsp;<span id="<c:if test="${empty supupdCodestr}">ferrorName</c:if><c:if test="${supupdCodestr !=null}">cerrorName</c:if>"></span></td></tr>
             <tr valign="middle"><td align="right">当前时间:</td><td align="left"><input type="text" name="gdWriteTime" id="<c:if test="${empty supupdCodestr}">gdWriteTime</c:if><c:if test="${supupdCodestr !=null}">writetime</c:if>"  value="<s:date name="date" />" readonly="readonly" /></td></tr>
             <tr ><td colspan="2" style="float:left;" height="120">
                <input type="checkbox" name="<c:if test="${empty supupdCodestr}">gdsuperWritename</c:if><c:if test="${supupdCodestr !=null}">gdchildWritename1</c:if>" id="addColumn" <c:if test="${isaddpropertys==1 }">checked</c:if>/>是否添加类目属性<br/><br/><br/><div id="addButton"><div onclick="return <c:if test="${empty supupdCodestr}">arrs('f',3)</c:if><c:if test="${supupdCodestr !=null}">arrs('c',3)</c:if>" class="ann" id="subdate">修改</div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
             </td>
             </tr>
          </table>
          <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;<c:if test="${empty supupdCodestr}">arrs('f',3)</c:if><c:if test="${supupdCodestr !=null}">arrs('c',3)</c:if>" id="isaddColumn">类目属性&nbsp;&nbsp;&nbsp;&nbsp;</div>
          </div>
           <!-- 显示增加字段 -->
	      <div id="addFields">
	      </div>
           <div style="width: 700px;background-color: #f8f8f8;border: 1px solid #000000;overflow: auto;height: 100px;" id="Resultpreview">
                <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;">效果浏览：</div>
                   <div style="margin-left:40px;" id="Resultpreviews">
                   
                   </div>
           </div>
            <div style="width: 700px;background-color: #f8f8f8;height: 200px;border: 1px solid #000000;overflow: auto;height: 100px; <c:if test="${isaddpropertys==0 }">display:none;</c:if>" id="addProperty">
                   <div style="height:15px;border:1px solid #000000;line-height:25px;background-color:#f8f8f8;font-weight: bold;">已添加属性：<c:if test="${isaddpropertys==1 }"><div class="ann" id="selectOld" onclick="selectOldProperty(<c:if test="${empty supupdCodestr}">'f'</c:if><c:if test="${supupdCodestr !=null}">'c'</c:if>)">修改属性</div></c:if></div>
                   <div style="margin-left:40px;" id="Resultaddproperty">
                   
                   </div>
           </div>
            <div style="width: 700px;height:30px;background-color: #f2f2f2;height: 30px;border: 1px solid #9fcaea;">
	          <div style="margin-left:40%;">
	                <div class="ann" style="margin: 0 auto;" onclick="outMenus()">返回</div>
	           </div>
	         </div>

      </div>
    
  </body>
</html>
