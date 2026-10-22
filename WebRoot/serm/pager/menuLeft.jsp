<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>菜单</title> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
		<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/style.css"/>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.contextmenu.r2.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>serm/js/menu.js"></script>
    <script src="<%=basePath%>serm/js/myjs.js" type="text/javascript"></script>
</head>
<body>

  <div id="bigDiv">
	<ul id="leftMenu">
	    <s:iterator value="#session.houseList" var="ho" status="st">
	    <s:set value="#ho.showcode" name="pto"/>
	     <s:set value="#ho.showcode.substring(0,2)" name="pfls"/>
	    <s:if test="#ho.showcode.substring(2,4)=='00'">
		  <li class="li1"> 
		        <div id="m<s:property value="#st.index"/>" style="width:100%;height:100%;">
				    <s:property value="#ho.houseName"/>
			    </div>
				 <div class="contextMenu" id="p<s:property value="#st.index"/>" style="width:100%;height:100%;text-align: center;">
			          <ul>
			          <li id="item_1"><a href="<%=basePath%>serm/pager/addCa.jsp?electid=<s:property value="#ho.houid"/>" target="mainFrame" style="text-decoration:none;width:100px;height:15px;">增加机柜</a></li>
			           <li id="item_1"><a href="<%=basePath%>cms/show_delCabint.do?electid=<s:property value="#ho.houid"/>" target="mainFrame" style="text-decoration:none;width:100px;height:15px;">删除机房</a></li>
			         </ul>
		          </div>
		    </li> 
		</s:if>
		<li class="li2">
		<ul>
	      <s:iterator value="#session.cabList" var="hca" status="ms">
	           <s:if test="#hca.elehid == #ho.houid">
				<li>               
		          <div id="x<s:property value="#ms.index"/>">
				     <a href="<%=basePath%>serm/pager/innit.jsp?caid=<s:property value="#hca.cabID"/>" target="mainFrame" style="width:190px;height:32px; "><s:property value="#hca.cabName"/></a>
				  </div>
				  <div class="contextMenu" id="co<s:property value="#ms.index"/>" style="width:100%;height:100%;text-align: center;">
			          <ul>
			          <li id="item_1"><a href="<%=basePath%>cms/show_updateCaUI.do?caid=<s:property value="#hca.cabID"/>" target="mainFrame" style="text-decoration:none;width:100px;height:15px;">修改机柜</a></li>
			          <li id="item_1"><a href="<%=basePath%>cms/show_delCabinet.do?caid=<s:property value="#hca.cabID"/>" target="mainFrame" style="text-decoration:none;width:100px;height:15px;">删除机柜</a></li>
			         </ul>
		          </div>
				</li>
				</s:if>
		  </s:iterator>
		</ul>
		</li>
      </s:iterator>
	</ul>
	  <div class="contextMenu" id="houses" style="width:100%;height:100%;text-align: center;">
	     <ul>
	          <li id="item_1"><a href="<%=basePath%>serm/pager/addEle.jsp" target="mainFrame" style="text-decoration:none;width:100px;height:15px;">增加机房</a></li>
	    </ul>
     </div>
	</div>
	</body>
</html>