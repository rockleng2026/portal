<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<script type="text/javascript">
  function projectInfo(id){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id;
		}
		
  function waitProject(){
  		  window.location.href="<%=request.getContextPath()%>/waitProjectApprovalProject.do";
  }
  
  function getProject(){
          window.location.href="<%=request.getContextPath()%>/listnewProject.do";
  }
</script>
  
  <body>
    
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center" valign="middle">
    <table border="0px" align="center" style="margin:0 atuo" >
          <tr align="left"><div style="left: 0px"><h1><font color="#2366A8">项目“${newproject.projectname}”的审批流程如下：</font></h1></div></tr>
          <tr>
	           <td><img src="<%=request.getContextPath() %>/newproject/img/01.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/02.jpg" onclick="projectInfo('${newproject.id}')" title="点击查看该项目详细信息"/></td>
	           <td>提交审批</td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/03.jpg" onclick="waitProject();" title="点击查看待审批项目详细信息"/></td>
	         <c:if test="${newapp.appstatus==0}">
	         <c:if test="${len==1}">
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td><font color="#2366A8">审批中......</font></td>
	         </c:if>
	         <c:if test="${len==2}">
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td><font color="#2366A8">项目上报</font></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td><font color="#2366A8">审批中......</font></td>
	         </c:if>
	         </c:if>
	         <c:if test="${newapp.appstatus!=0}">
	         <c:if test="${len==1}">
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td><font color="#2366A8">审批通过</font></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/myproject.jpg" onclick="getProject();" title="点击查看我的项目详细信息"/></td>
	         </c:if>
	         <c:if test="${len==2}">
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td>项目上报</td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/04.jpg"/></td>
	           <td><font color="#2366A8">审批通过</font></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/jiantou.jpg"/></td>
	           <td><img src="<%=request.getContextPath()%>/newproject/img/myproject.jpg" onclick="getProject();" title="点击查看我的项目详细信息"/></td>
	         </c:if>
	         </c:if>
           </tr>
           <tr>
	           <td align="center">${newproject.launcher}</td>
	           <td></td>
	           <td align="center">${newproject.projectname}</td>
	           <td></td>
	           <td></td>
	           <td></td>
	         <c:if test="${newapp.appstatus==0}">
	         <c:if test="${len==1}">
	           <td></td>
	           <td align="center">${appName}</td>
	           <td></td>
	         </c:if>
	         <c:if test="${len==2}">
	           <td></td>
	           <td align="center">${appld1}</td>
	           <td></td>
	           <td></td>
	           <td align="center">${appld2}</td>
	           <td></td>
	         </c:if>
	         </c:if>
	         <c:if test="${newapp.appstatus!=0}">
	         <c:if test="${len==1}">
	           <td></td>
	           <td align="center">${appName}</td>
	           <td></td>
	           <td></td>
	           <td></td>
	         </c:if>
	         <c:if test="${len==2}">
	           <td></td>
	           <td align="center">${appld1}</td>
	           <td></td>
	           <td></td>
	           <td align="center">${appld2}</td>
	           <td></td>
	           <td></td>
	           <td></td>
	         </c:if>
	         </c:if>
           </tr>
           
    </table>
    </td></tr></table>
    
  </body>
</html>
