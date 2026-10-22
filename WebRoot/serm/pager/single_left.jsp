<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%response.setHeader("Pragma","No-cache");response.setHeader("Cache-Control","No-cache");response.setDateHeader("Expires",-10);%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>单个服务器</title>
		<META HTTP-EQUIV="pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
		<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=basePath%>serm/css/jigui.css" rel="stylesheet"
			type="text/css" />
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/icon.css">
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>serm/css/easyui.css">
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery.contextmenu.r2.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=basePath%>serm/js/single_left.js"></script>
			 <script type="text/javascript" src="<%=basePath%>serm/js/upservers.js"></script>
		
		<style type="text/css">

#upserverList{
    overflow:auto;
    display:none;
    float:right;
}
#isShowOrHide{
    display:none;
}
#isorups{
    display:none;
}
</style>

	</head>
	<body>
	<input type="hidden" id="hidPath" value="<%=basePath%>">
    <form action="<%=basePath%>serm/pager/selserverInfomation.jsp" target="yesornoshowIframe" id="iframForms"></form>
	<form target="upserverListIrame" id="ifrForm2"><input type="hidden" name="cassids" id="cassids"/></form>
		<div id="jiguibig">
			<div id="jiguitop"></div>
			<div id="jiguimid">
				<div style="width: 26px; float: left;"></div>
				<!-- 放服务器 -->
				<div id="fuwuqk" id="wmd">
					<s:iterator value="#session.showList" var="lit" status="v">
				  <s:if test="#lit.upflag == 1"><!-- 上架 -->
							<div id="psat<s:property value="#v.index"/>"
								style="position: absolute;left:46px;top:<s:property value="#lit.marknumberstart"/>px;z-index:100;width:157px;height:<s:property value="#lit.marknumberend"/>px;background-color:<s:property value="#lit.flagColor"/>;"
								onclick="showserverInfo(<s:property value="#lit.upserID"/>)" onmouseover="operSers(1,<s:property value="#v.index"/>)" onmouseout="outOperser(1,<s:property value="#v.index"/>)">
								<s:property value="#lit.ipcon"/>
							</div>
							 <div id="isShowOrHide<s:property value="#v.index"/>" style="position: absolute;z-index:1000;left:170px;top:<s:property value="#lit.marknumberstart"/>px;background-color:#ccc;width:auto;height:auto;border-style:double;margin: 0px;padding: 0px;display:none;">
				                 <div id="past<s:property value="#v.index"/>" style="width:100%;height:100%;border-bottom-style:inset;margin: 0px;padding: 0px;" onmouseover="document.getElementById('past<s:property value="#v.index"/>').style.background='green';document.getElementById('isShowOrHide<s:property value="#v.index"/>').style.display='block'" onmouseout="document.getElementById('past<s:property value="#v.index"/>').style.background='';document.getElementById('isShowOrHide<s:property value="#v.index"/>').style.display='none'">
				                   <a href="<%=basePath%>serm/pager/serverChange.jsp?changid=<s:property value="#lit.upserID"/>"
											style="text-decoration: none;width:100px;height:15px;">转移</a>
				                 </div>
				                 <div id="mut<s:property value="#v.index"/>" style="width:100%;height:100%;border-bottom-style:inset;margin: 0px;padding: 0px;" onmouseover="document.getElementById('mut<s:property value="#v.index"/>').style.background='green';document.getElementById('isShowOrHide<s:property value="#v.index"/>').style.display='block'" onmouseout="document.getElementById('mut<s:property value="#v.index"/>').style.background='';document.getElementById('isShowOrHide<s:property value="#v.index"/>').style.display='none'">
				                  <a href="javascript:lowerDown(<s:property value="#lit.upserID"/>)"
											style="text-decoration: none;width:100px;height:15px;">下架</a>
				                 </div>
				             </div>
				             <!-- 
							<div id="past<s:property value="#v.index"/>" class="contextMenu">
								<ul>
									<li id="item_1">
										<a href="<%=basePath%>serm/pager/serverChange.jsp?changid=<s:property value="#lit.upserID"/>"
											style="text-decoration: none;width:100px;height:15px;">转移</a>
									</li>
									<li id="item_1">
										<a href="javascript:lowerDown(<s:property value="#lit.upserID"/>)"
											style="text-decoration: none;width:100px;height:15px;">下架</a>
									</li>
								</ul>
							</div>
							 -->
				    </s:if>
					<s:elseif test="#lit.upflag == 2"><!-- 下架 -->
							<div id="waitin<s:property value="#v.index"/>"
								style="position: absolute;left:46px;top:<s:property value="#lit.marknumberstart"/>px;z-index:100;width:157px;height:<s:property value="#lit.marknumberend"/>px;background-color:<s:property value="#lit.flagColor"/>;" onclick="showserverInfo(<s:property value="#lit.upserID"/>)" onmouseover="operSers(2,<s:property value="#v.index"/>)" onmouseout="outOperser(2,<s:property value="#v.index"/>)">
							<s:property value="#lit.ipcon"/>
							</div>
							 <div id="isorups<s:property value="#v.index"/>" style="position: absolute;z-index:1000;left:170px;top:<s:property value="#lit.marknumberstart"/>px;background-color:#ccc;width:auto;height:auto;border-style:double;margin: 0px;padding: 0px;display:none;">
				                 <div id="watn<s:property value="#v.index"/>" style="width:100%;height:100%;border-bottom-style:inset;margin: 0px;padding: 0px;" onmouseover="document.getElementById('watn<s:property value="#v.index"/>').style.background='green';document.getElementById('isorups<s:property value="#v.index"/>').style.display='block';" onmouseout="document.getElementById('watn<s:property value="#v.index"/>').style.background='';document.getElementById('isorups<s:property value="#v.index"/>').style.display='none';">
				                    <a href="javascript:upserv(<s:property value="#lit.upserID"/>,<s:property value="#lit.upflag"/>)"
											style="text-decoration: none;width:100%;height:100%;">上架</a>
				                 </div>
				             </div>
							<!--
							<div id="watn<s:property value="#v.index"/>" class="contextMenu">
								<ul>
									<li id="item_1">
										<a href="javascript:upserv(<s:property value="#lit.upserID"/>,<s:property value="#lit.upflag"/>)"
											style="text-decoration: none;width:100px;height:15px;">上架</a>
									</li>
									<li id="item_1">
										<a href="javascript:stormRoom(<s:property value="#lit.upserID"/>)"
											style="text-decoration: none;width:100px;height:15px;">入库</a>
									</li>
								</ul>
							</div>
							-->
				</s:elseif>
					</s:iterator>
				</div>
				 <div style="position: absolute;z-index:1000;left:252px;top:36px;background-color:#ccc;width:auto;height:auto;border-style:double;margin: 0px;padding: 0px;">
				        <div id="dv1" style="width:100%;height:100%;border-bottom-style:inset;margin: 0px;padding: 0px;" onmouseover="document.getElementById('dv1').style.background='green'" onmouseout="document.getElementById('dv1').style.background=''">
				            <a href="javascript:writeUpserver(<s:property value="#session.cabinet.caid" />)" style="text-decoration: none;width:100%;height:100%px;">新增上架单</a>
				        </div>
				  </div>
				<!--  
				<div id="writerInFo" class="contextMenu">
								<ul>
									<li id="item_1">
										<a href="javascript:writeUpserver(<s:property value="#session.cabinet.caid" />)"
											style="text-decoration: none;width:100px;height:15px;">新增上架单</a>
									</li>
								</ul>
				</div>
				-->
				<!-- 刻度 -->
				<div id="kedu">
					<table width="49" border="0" cellpadding="0"
						cellspacing="0">
						<s:iterator begin="#session.casize" end="1" step="-1" var="si">
							<tr>
								<td class="kedut">
								    <div style="height:9px;font-size:7px;">
									<s:property value="#si" />
									</div>
								</td>
							</tr>
						</s:iterator>
					</table>

				</div>
			</div>
			<div id="jiguibut"></div>
		</div>

	     	<div style="width:40px;height: 200px;float: left;">
	     	</div>

		<div id="yesornoshow" style="float:right;"><!-- 信息的 -->
			<iframe name="yesornoshowIframe" scrolling="auto" width="690" height="700" frameborder="0"></iframe>
		</div>
		<div id="upserverList">
		   <iframe name="upserverListIrame" scrolling="auto" width="800" height="700" frameborder="0"></iframe>
		</div>
	
	</body>
</html>
