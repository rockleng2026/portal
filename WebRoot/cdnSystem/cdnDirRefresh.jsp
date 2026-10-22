<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'cdnRefresh.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <SCRIPT type="text/javascript">
  	function update(id,url,dateTime)
  	{
  		document.getElementById("updateUrl").style.display="block";
  		document.getElementById("id").value=id;
  		document.getElementById("url").value=url;
  		document.getElementById("dateTime").value=dateTime;
  		
  	}
  	function quxiao()
  	{
  		document.getElementById("updateUrl").style.display="none";
  	}
  	function yanZheng()
  	{
  		if(document.getElementById("url").value==""||document.getElementById("url").value==null)
  		{
  			alert("url不能为空");
  			return false;
  		}
  		else if(document.getElementById("dateTime").value==""||document.getElementById("dateTime").value==null)
  		{
  			alert("刷新时间不能为空");
  			return false;
  		}
  	}
  	function del(delId)
  	{
  	if(confirm("确定要该记录吗？")==true)
  	{
  		$.post("cdnSystem/delDirCdnSystemAction.Action",{delId:delId},function(data){
  				if(data=="1")
  				{
					alert("删除成功！！！");  				
  				}
  				else
  				{
  					alert("删除失败！！！");
  				}
  				location.reload();
  			});
  	}
  	/*
  		if(confirm("确定要该记录吗？"))
  		{
  		alert("aaa");
  			$.post("cdnSystem/delUrlCdnSystemAction.Action",delId:delId,function(data){
  				alert(data);
  				location.reload();
  			});
  		}
  		*/
  	}
  </SCRIPT>
  
  <body>
  	<table align="center" width="700px" >
  	<tr>
  		<td align="center" colspan="3">
  			<div id="updateUrl" style="display: none">
  			<form id="form1" name="form1" action="cdnSystem/updateDirCdnSystemAction.Action" method="post">
  				<table width="500px">
  					<tr>
  						<td align="center" width="40%">url目录</td>
  						<td align="center" width="30%">刷新时间</td>
  						<td align="center" width="30%">保存/取消修改</td>
  					</tr>
  					<tr>
  						<td align="center" width="40%"><input type="hidden" id="id" name="id" /><input type="text" id="url" name="url" /></td>
  						<td align="center" width="30%">
  						<select id="dateTime" name="dateTime" value="this.value">
							<option value="5000毫秒">5000毫秒</option>
							<option value="12小时" >12小时</option>
							<option value="24小时">24小时</option>
							<option value="7天">7天</option>
						</select>
  							
  						</td>
  						<td align="center" width="30%"><input type="submit" value="保存" onclick="return yanZheng()" />/<input type="button" value="取消" onclick="quxiao()" /></td>
  					</tr>
  				</table>
  			</form>
  			</div>
  		</td>
  	</tr>
  		<tr>
  			<td colspan="3" align="center"><h1>url目录列表</h1>
  			<a href="<%=path %>/cdnSystem/addCdnDir.jsp">增加 ————————</a>
  			
  			</td>
  		</tr>
  		<tr>
  			<td width="40%" align="center">url</td>
  			<td width="30%" align="center">刷新时间</td>
  			<td width="30%" align="center">删除/修改</td>
  			
  		</tr>
  		<c:forEach items="${pages.pageList}"  var="data" >
  		<tr>
  			<td width="40%" align="center">${data.url }</td>
  			<td width="30%" align="center">${data.dateTime }</td>
  			<td width="30%" align="center"><input type="button" onclick="update(${data.id},'${data.url }','${data.dateTime }')" value="修改"/>/<input type="button" onclick="del(${data.id})" value="删除"/></td>
  		</tr>
  		</c:forEach>
  		<TR>
			<TD id="page" colspan="3" align="center"><p:pages url="cdnSystem/selectDirCdnSystemAction.Action"/></TD>
		</TR>
  	</table>
  </body>
</html>
