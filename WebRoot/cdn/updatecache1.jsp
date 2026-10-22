<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>缓存-更新</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
			<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	</head>
	<script type="text/javascript">
    window.onload = function()
		{
			//missiontypelist('typeid','','');
		}
 	function cdnsubmit(){
 		//var typeid = $("#typeid").val();
 		var name = $("#name").val();
 		var description1 = $("#urllist").val();
 		var description=encodeURI(description1);
 		var server=$("#server").val();
 		var duankou=$("#duankou").val();
 		var type=$("#type").val();

 		
 		if(server==0)
 		{
			alert("清选择服务器");
			$("#server").focus();
			return;
 	 	}
 		if(duankou=='')
 		{
			alert("清选择端口");
			$("#duankou").focus();
			return;
 	 	}
 		if(name == ''){
 			alert("请填写域名名称!");
 			$("#name").focus();
 			return;
 		}
 		var Expression=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
 		var objExp=new RegExp(Expression);
 		if(objExp.test(name)==false){
 			alert("域名不合法");
 			return;
 		}
 		
 		if(description == ''){
 			alert("请填缓存地址!");
 			$("#urllist").focus();
 			return;
 		}
 		if(type == 0){
 			alert("请选择缓存类型!");
 			$("#type").focus();
 			return;
 		}
 		
 		
 		$.post("clearCache1mission.Action",{
 	 		name:name,
 	 		urllist:description,
 	 		server:server,
 	 		duankou:duankou,
 	 		type:type},function(data){
			if(data=='0')
			{
				alert("操作成功");
			location.reload();
			}
			else if(data=='1')
			{
				alert("网络错误");
				location.reload();
			}
			else if(data=='2')
			{
				alert("参数错误");
				location.reload();
			}
			else if(data=='3')
			{
				alert("服务未开启");
				location.reload();
				}
			else if(data=='4')
			{
				alert("服务器出错！！请稍后在试");
				location.reload();
				}
 	 		});
 	}
 </script>
	<body>
		<div style="margin-left: 60px">
			<div style="float: left; width: 1040px;">
					<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
						border=0>
						<TBODY>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
								</TD>
								<TD width="100%" background=<%=request.getContextPath()%>
									/images/r_0.gif>
									<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
										<TBODY>
											<TR>
												<TD style="font-size: 12px; color: red;">
													&nbsp;缓存更新(带*号的为必填项)
												</TD>
												<TD align=right>
													&nbsp;
												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
								</TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
										align="center" border=1 style="font-size: 14px;">
										<TBODY>
											<TR>
												<TD width="80px;" height=30 align=right align="left">

												</TD>
												<TD>
													&nbsp; CDN服务器：
													<select id="server" name="server"
														style="width: 200px;">
														<option value="0">请选择</option>
														<c:forEach items="${cdnpp}" var="data">
														<option value="${data.panelPointIp }">
															${data.panelPointIp }
														</option>
														</c:forEach>
													</select>
													端口<input id="duankou" name="duankou" style="size: 50px" value="8088" />
												</TD>
											</TR>
											<!-- 
									<TR>
										<TD width="10%" height=30 align=right>
											接收人：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="receiver" id="receiver" readonly="readonly">
										</TD>
									</TR>
									 -->
											<TR>
												<TD width="10%" height=30 align=right>
													网站域名：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 95%" name="name" id="name" value="http://" />
											</TD>
											</TR>
											<TR>
												<TD width="25%" height=30 align="center">
													清除缓存地址：<br /><font color="red">(多个地址请用|分割)</font><br />
													刷新目录：<br /><font color="red">/目录路径/目录名称/</font><br />
													刷新文件：<br /><font color="red">/文件路径/文件名称.后缀</font><br />
													增加刷新文件：<br /><font color="red">/文件路径/文件名称.后缀</font><br />
													
												</TD>
												<TD width="75%" class=category>
													<textarea rows="20" cols="70" name="urllist"
														id="urllist"></textarea><FONT color=#ff0000>*</FONT>
												</TD>
											</TR>
											
												<TR>
												<TD height=30>
													&nbsp;
												</TD>
												<TD class=category>
												<SELECT id="type" name="type" value="this.value">
													<option value="0">请选择类型</option>
													<option value="1">刷新目录</option>
													<option value="2">刷新内容</option>
													<option value="3">删除目录</option>
													<option value="4">删除内容</option>
													<option value="5">增加刷新内容</option>
												</SELECT>
													<INPUT class=button type="button" value="确认提交 "
														onclick="cdnsubmit()">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<INPUT class=button type=reset value=" 重置 ">

												</TD>
											</TR>
											
										</TBODY>
										
									</TABLE>
									<table  class="toptable grid" cellSpacing=1 cellPadding=4
										align="center"  style="font-size: 14px;">
									<tr align="center">
										<td width="8%">
										 处理人员
										</td>
										<td width="15%">
										 缓存域名
										</td>
										<td width="22%">
										 缓存内容
										</td>
										<td width="10%">
										操作功能
										</td>
										<td width="15%">
										地域、线路
										</td>
										<td width="10%">
										操作结果
										</td>
										<td width="20%">
										 操作时间
										</td>
									</tr>
										<c:forEach items="${updatecache}" var="data">
										
										<tr align="center">
										<td >
										 <c:if test="${data.customer==null}">公司员工</c:if>
													<c:if test="${data.customer!=null}">${data.customer.realName}</c:if>
										</td>
										<td >
										${data.domain }
										</td>
										<td >
											${data.content }
										</td>
										<td>
											${data.tmp }
										</td>
										<td>
											${data.tmp1 }
										</td>
										<td >
										<c:if test="${data.result=='0'}">处理成功</c:if>
													<c:if test="${data.result=='-1'}">网络错误</c:if>
													<c:if test="${data.result=='-2'}">参数错误</c:if>
													<c:if test="${data.result=='-3'}">网络出错</c:if>
													<c:if test="${data.result=='-4'}">服务出错</c:if>
													<c:if test="${data.result=='1'}">服务未开启</c:if>
													<c:if test="${data.result=='500'}">服务器错误</c:if>
										</td>
										<td >
										 ${data.time }
										</td>
									</tr>
											</c:forEach>
									</table>
								</TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
								</TD>
								<TD></TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
								</TD>
							</TR>
						</TBODY>
					</TABLE>
			</div>
		</div>
	</body>
</html>