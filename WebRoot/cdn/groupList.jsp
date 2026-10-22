<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
        request.setCharacterEncoding("UTF-8");
%>
        
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户CDN节点配置列表</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
		
		<script type="text/javascript">
		function delGroup(id)
		{
			if(confirm("确定要删除记录吗？")==true)
			{
				$.post("delGroupCDNsaleOrderAction.do",{id:id},function(data){
				if(data==0)
				{
					alert("删除成功");
					location.reload();
				}
					
				});
			}
		}
	 
        </script>
		
		
		<link type="text/css" rel="stylesheet"	href="<%=basePath%>Css/missionuse.css" />
	</head>
	<body>
	
	<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<hr style="width:300px; float:left; height:1px; position:absolute; margin-top:32px;" size="3" color="#20a3f6" />
             <span><img src="<%=basePath %>images/home.png" width="30" height="30"></span>
				<h3 style="line-height:35px;">
					CDN分组管理                
				</h3>
			</div>
			<table class="tb tb2 " id="tips">
				<tr style="border-bottom:dashed 1px #deeffb;">
					<th class="partition">
						<span><img src="<%=basePath %>images/idea_group.png" width="20" height="20" ></span>技巧提示
					</th>
					<th class="partition"style="text-align:right;">
						<a href="addAreaTypeCDNsaleOrderAction.do" style="color: red">添加CDN分组</a>&nbsp;&nbsp;&nbsp;<a href="selectGroupCDNsaleOrderAction.do">返回CDN分组信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
						<li>
								添加分组：在右上角有"<font color='red'>添加CDN分组</font>"的字样   点击进入添加页面
							</li>
							<li>
								分组名称：每个组的名称 
							</li>
							<li>
								节&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点：该组下面有哪些对应的节点
							</li>
							<li>
								操&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作：在里面可以进行修改、删除的操作
							</li>
							
						</ul>
					</td>
				</tr>
			</table>
			<div class="itemtitle">
                
				<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
				<span><img src="<%=basePath %>images/notes.png" width="20" height="20" /></span> 
				<p style="float:left; margin-right:50px; line-height:22px;">	</p>  
				
				</h3>
				
			</div>
			<div class="itemtitle" >
				
				<a href="javascript:void(0)" style="float:left;margin-right:10px;background-image:url(images/IP_01.png); display: block;width: 84px;height: 31px;text-decoration:none;text-align:center;line-height:30px;">
				<span  style="color:#fff;font-size:12px;margin-left:16px;">分组列表</span></a>
				

						

			</div>
			<form action="addoreditWorkPosition.do" method="post" id="form0"
				name="form0">
				<s:token name="register0"></s:token>
				<input type="hidden" id="mark" name="mark" value="new" />
				<table align="center" border="0" width="440px;" class="tb tb2">
						<tr >
						<th width="30%" >
							<b>分组名称</b>
						</th>
						
						<th width="40%"  >
							<b>节&nbsp;&nbsp;点</b>
						</th>
						
						<th align="center" style="text-align:center;" width="30%">
							<b>操&nbsp;&nbsp;作</b>
						</th>
					</tr>
                   

						<c:forEach items="${pages.pageList}"  var="data" varStatus="sid">
				<tr>
				<td >
					${data.groupName }
				</td>
				<td >
					${data.panelPointId }
				</td>
				<td align="center" style="text-align:center;" width="30%">
					<a href="addSelectGroup1CDNsaleOrderAction.do?id=${data.id }">修改</a>
					<a href="javascript:void" onclick="delGroup(${data.id})">删除</a>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="3">
					<p:pages url="selectGroupCDNsaleOrderAction.do"/>
				</td>
			</tr>
				</table>
			</form>
		<div>
		</div>

	</body>

</html>