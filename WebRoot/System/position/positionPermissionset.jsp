<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.FunctionInfo"%>
<%@page import="com.fuao.fajxc.dao.position.PositionDao"%>
<%@page import="com.fuao.fajxc.vo.pagefunction"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	PositionDao positiondao=(PositionDao)request.getAttribute("positiondao");
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>岗位权限设置</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="<%=path %>/Css/admin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path %>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=path %>/js/permission.js" charset="gbk"></script>
	</head>
	
	<script type="text/javascript">
	
		window.onload =function()
		{
			var functionIds = "${functionIds}";
			var permissions = "${permissions}";
			
			var functionIdArray = functionIds.split(",");
			var permissionArray = permissions.split(",");
			for(var i=0;i<functionIdArray.length;i++)
			{
				$("input[@name='checkName'][@value='"+functionIdArray[i]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			for(var j=0;j<permissionArray.length;j++)
			{
				$("input[@name='checkPermission'][@value='"+permissionArray[j]+"']").each(function(){
					$(this).attr("checked",true);
				});
			}
			$("#showOrHiddenDiv1").show();
		};
		
	</script>

	<body>
		<div class="currentlySet">
			<font size="2">
				当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;岗位列表&nbsp;>&nbsp;设置岗位权限 </font>
		</div>
<table align="center" width="800px" border="0" align="center" cellpadding="3" cellspacing="1" class="space tableBg">
	<tr nowrap class="bg0" hight="40">
		<td style="line-height: 40px;" align="center">
			<font size="3" color="blue">
			<c:forEach items="${superfunctionlist}" var="head">	&nbsp;<a href="javascript:void(0)" onclick="showDiv('${head.functionId}')">${head.linkFunctionName}</a>&nbsp;</c:forEach> 
		</font>
		</td>
	</tr>
	<tr>
		<td align="right" nowrap class="bg0" >
			是否全选<input id=chkall name=chkall type="checkbox" onclick="checkAll('checkName','checkPermission')" />&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
		<form action="" name="role">
		  <%
		      List superfunctionlist=(List)request.getSession().getAttribute("superfunctionlist");
		      for(int i=0;i<superfunctionlist.size();i++){
		    	  FunctionInfo dataindex=(FunctionInfo)superfunctionlist.get(i);
		  %>
		    <div id="showOrHiddenDiv<%=dataindex.getFunctionId() %>" style="display:none; float: none; width: 800px;">
			<div class="conSet">
				<table width="800px" border="0" align="center" cellpadding="3" cellspacing="1" class="space tableBg">
				    <%
				       for(int j=0;j<superfunctionlist.size();j++){
				    	   FunctionInfo superdata=(FunctionInfo)superfunctionlist.get(j);
				    	   if(superdata.getFunctionId()==dataindex.getFunctionId()){
				    		   
				    %>
				        <tr>
							<td align="left" nowrap class="bg0">
							<%=superdata.getFunctionId() %><input type="checkbox" name="checkName" id="checkName" value="<%=superdata.getFunctionId() %>">
							 <font size="4px;" color="#3366CC"><%=superdata.getLinkFunctionName() %></font>
							</td>
							<td align="right" nowrap class="bg0" > </td>
						</tr>
						<%
						   List funcntionlist=(List)request.getSession().getAttribute("funcntionlist");
						   for(int m=0;m<funcntionlist.size();m++){
							   FunctionInfo data=(FunctionInfo)funcntionlist.get(m);
							   if(data.getSuperId().equals(superdata.getFunctionId())){
						%>
						     <tr>
									<td align="left" nowrap class="bg0">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<%=data.getFunctionId() %><input type="checkbox" name="checkName" id="checkName" value="<%=data.getFunctionId() %>" onclick="selectSuperId('<%=superdata.getFunctionId() %>')">
										<font size="2.5px;" color="#CC9900"><%=data.getLinkFunctionName() %></font>
									</td>
									<td nowrap class="bg0">
									    <%
									       if(data.getLinkFunctionPage()!=null){
									    %>
									       <%=data.getFunctionId() %>
									        <%
									           List pagefunctionlist=positiondao.pagefunctionlist(data.getFunctionId());
									           if(pagefunctionlist!=null && pagefunctionlist.size()>0){
									           for(int x=0;x<pagefunctionlist.size();x++){
									        	   pagefunction pagefunction=(pagefunction)pagefunctionlist.get(x);   
									        %>
									           <input type="checkbox" id="checkPermission" name="checkPermission" value="<%=data.getFunctionId()+"."+pagefunction.getOnlyflag() %>" onclick="selectSuperId('<%=data.getFunctionId() %>,<%=superdata.getFunctionId() %>')"><%=pagefunction.getName() %>
									        <%}}else{ %>
									                             暂无操作功能
									        <%} %>
									    <%} %>
									</td>
							  </tr> 
							  <%
							      for(int n=0;n<funcntionlist.size();n++){
							    	  FunctionInfo data1=(FunctionInfo)funcntionlist.get(n);
							    	  if(data1.getSuperId().equals(data.getFunctionId())){
							  %>
							         <tr>
										<td align="left" nowrap class="bg0">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<%=data1.getFunctionId() %><input type="checkbox" name="checkName" id="checkName" value="<%=data1.getFunctionId() %>" onclick="selectSuperId('<%=data.getFunctionId() %>,<%=superdata.getFunctionId() %>')">
											   <%=data1.getLinkFunctionName() %>
										</td>
										<td nowrap class="bg0">
										<%
										   if(data1.getLinkFunctionPage()!=null){
										%>
										    <%=data.getFunctionId() %>
									        <%
									           List pagefunctionlist=positiondao.pagefunctionlist(data1.getFunctionId());
									           if(pagefunctionlist!=null && pagefunctionlist.size()>0){
									           for(int y=0;y<pagefunctionlist.size();y++){
									        	   pagefunction pagefunction=(pagefunction)pagefunctionlist.get(y);   
									        %>
									           <input type="checkbox" id="checkPermission" name="checkPermission" value="<%=data1.getFunctionId()+"."+pagefunction.getOnlyflag() %>" onclick="selectSuperId('<%=data1.getFunctionId() %>,<%=data.getFunctionId() %>,<%=superdata.getFunctionId() %>')"><%=pagefunction.getName() %>
									        <%}}else{ %>
									                             暂无操作功能
									        <%} %>
										<%} %>
    									</td>
									</tr>
									<%
								      for(int a=0;a<funcntionlist.size();a++){
								    	  FunctionInfo data2=(FunctionInfo)funcntionlist.get(a);
								    	  if(data2.getSuperId().equals(data1.getFunctionId())){
								    %>
								          <tr>
												<td align="left" nowrap class="bg0">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<%=data2.getFunctionId() %><input type="checkbox" name="checkName" id="checkName" value="<%=data2.getFunctionId() %>"  onclick="selectSuperId('<%=data1.getFunctionId() %>,<%=data.getFunctionId() %>,<%=superdata.getFunctionId() %>')">
													  <%=data2.getLinkFunctionName() %>
												</td>
												<td nowrap class="bg0">
												    <%
												        if(data2.getLinkFunctionPage()!=null){
												    %>
												       <%=data.getFunctionId() %>
												        <%
												           List pagefunctionlist=positiondao.pagefunctionlist(data2.getFunctionId());
												           if(pagefunctionlist!=null && pagefunctionlist.size()>0){
												           for(int y=0;y<pagefunctionlist.size();y++){
												        	   pagefunction pagefunction=(pagefunction)pagefunctionlist.get(y);   
												        %>
												           <input type="checkbox" id="checkPermission" name="checkPermission" value="<%=data2.getFunctionId()+"."+pagefunction.getOnlyflag()%>" onclick="selectSuperId('<%=data2.getFunctionId()%>,<%=data1.getFunctionId() %>,<%=data.getFunctionId() %>,<%=superdata.getFunctionId() %>')"><%=pagefunction.getName() %>
												        <%}}else{ %>
												                             暂无操作功能
												        <%} %>
												    <%} %>
												</td>
										 </tr>
								    <%}} %>
							  <%}} %>
						<%}} %>
				    <%}} %>
				</table>
			</div>
			</div>
		  <%} %>
</form>
		</td>
	</tr>
	<tr nowrap class="bg0">
		<td nowrap class="bg0" align="center">
		    <input type="hidden" id="path" value="<%=path %>">
			<input type="button" onclick="checkPositionFunction(${positionid})" value="提交"/>&nbsp;&nbsp;
    		<input type="button" value="重置" onclick="checkcancel()"/>
		</td>
	</tr>
</table>
	</body>
</html>
