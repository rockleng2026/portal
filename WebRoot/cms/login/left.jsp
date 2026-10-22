<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"> 
    <title>left</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>cms/css/style.css" type="text/css" rel="stylesheet" />
	<script src="<%=basePath%>cms/js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>cms/js/myjs.js" type="text/javascript"></script>
</head>

<body>
 <div id="left">
  <div id="nav-title"></div>
  	<ul id="leftMenu">
  	<s:iterator value="#session.modelist" var="mod" status="g">
  	    <s:set value="#mod.modelico.substring(0,2)" var="co" />
  	    <s:if test="#mod.modelico.substring(2,6) == '0000'">
		   <li class="li1"><s:property value="#mod.modelname"/></li>
		</s:if>
		<li class="li2_1">
		<ul>
			<li>
			   <ul>
			   <s:iterator value="#session.modelist" var="sos" status="m">
				    <s:if test="#sos.modelico.substring(4,6) == '00' && #sos.modelico.substring(0,2) == #co && #sos.modelico.substring(2,6)!='0000'">
				   		 <s:set value="#sos.modelico.substring(0,4)" var="up" />
				   		<li class="li1_m">
				   			<s:property value="#sos.modelname"/>
				   		</li>
				   	</s:if>
				 <li class="li2">
					<ul>
					  <s:iterator value="#session.modelist" var="tot" status="p">
					    <s:if test="#tot.modelico.substring(0,4) == #up && #tot.modelico.substring(4,6) != '00'">
					       <s:if test="#tot.modelalias == 'mblb'">
					           <li><a href="<%=basePath%>cms/<s:property value="#tot.modelurl"/>" target="framemain"><s:property value="#tot.modelname"/></a></li>
					       </s:if>
					       <s:else>
							<li><a href="<%=basePath%>cms/papers/<s:property value="#tot.modelurl"/>" target="framemain"><s:property value="#tot.modelname"/></a></li>
						   </s:else>
						</s:if>
					 </s:iterator>
					</ul>
					</li>
						</s:iterator>
			   </ul>
			</li>
		</ul>
		</li>
		</s:iterator>
	</ul>
  </div>
</body>

</html>
