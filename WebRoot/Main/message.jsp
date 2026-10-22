<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String prjempid=request.getParameter("prjempid");
	String invite=request.getParameter("invite");
	String empname=request.getParameter("empname");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'message.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>

  </head>
  
  <body>
    <!-- 弹出邀请信息 -->
		<div id="fd" style="display:show;filter:alpha(opacity=100);opacity:1;z-index: 10000px" >
        <div class="contentup">
             <table class="msg" style="width: 200px;" cellSpacing=1 cellPadding=4
								align=center border=1>
                <tr>
                   <td colspan="2" align="center"><h3>邀请消息</h3></td>
                </tr>
                <tr>
                   <td align="left">发送人：</td>
                   <td align="right"><%=empname %></td>
                </tr>
                <tr>
                   <td align="left">消息内容：</td>
                   <td align="right"><%=invite %></td>
                </tr>
                <tr>
                   <td align="center" colspan="2">
                       <button style="background-color: #eef7fe;" onclick="changeIsvite(<%=prjempid %>)">同意</button>
                       <button style="background-color: #eef7fe;" onclick="changeIsvite2(<%=prjempid %>)">拒绝</button>
                   </td>
                </tr>
             </table>
        </div></div>
        
        <script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
  </body>
</html>
