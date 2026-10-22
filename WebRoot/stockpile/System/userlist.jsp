<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'userlis.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="Css/admin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/system.js"></script>
	</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
	<body>
	  <div class="currentlySet" >
<font size="3">
		当前位置&nbsp;>>>&nbsp;权限管理&nbsp;>>&nbsp;用户列表 →  →  → 
		<a href="customerListSystem.do" >客户列表</a>&nbsp;/&nbsp;
		<a href="userListSystem.do?mark=employee" >员工列表</a></font></div>
		
		<div id="kehu" class="conSet">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
						<a href="<%=request.getContextPath() %>/Basic/customer/ClientwillMessage.jsp?funid=117">新增客户</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;客户列表记录查询
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
			<table width="60%" border="0" align="center" cellpadding="3"
				cellspacing="1" class="space tableBg">
				<tr>
					<td align="center" nowrap style="width: 50px" class="bg1">
						客户ID
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						客户帐号
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						客户名称
					</td>
					<td align="center" nowrap style="width: 180px" class="bg1">
						客户身份证
					</td>
					<td align="center" nowrap style="width: 150px" class="bg1">
						客户联系方式
					</td>
					<td align="center" nowrap style="width: 180px" class="bg1">
						客户邮件
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						客户QQ
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						创建时间
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						状态
					</td>
					<td align="center" nowrap style="width: 100px" class="bg1">
						操作
					</td>
				</tr>
				<c:forEach items="${pages.pageList}" var="data" varStatus="status">
				<tr>
					<td align="center" nowrap  class="bg0">${status.index+1 }</td>
					<td align="center" nowrap  class="bg0">${data.customerName }</td>
					<td align="center" nowrap  class="bg0">${data.realName }</td>
					<td align="center" nowrap  class="bg0">${data.cardid }</td>					
					<td align="center" nowrap  class="bg0">${data.mobilePhone }</td>
					<td align="center" nowrap  class="bg0">${data.email }</td>
					<td align="center" nowrap  class="bg0">${data.qq }</td>
					<td align="center" nowrap  class="bg0">${data.date }</td>
					<td align="center" nowrap  class="bg0">
						<c:if test="${data.isLoginAccount == 0}"><font color="red"><a title="该账户还为开通，赶紧为其开通账户哦" href="<%=request.getContextPath() %>/System/openedAccount.jsp?id=${data.customerId}&customername=${data.realName}">账户未开通</a></font></c:if>
						<c:if test="${data.isLoginAccount == 1}">账户已开通</c:if>
						<c:if test="${data.isLoginAccount == 2}"><font color="blue">账户未激活</font></c:if>
					</td>
					<td align="center" nowrap class="bg0">
						<c:if test="${data.employee.id == null || data.employee.id == 0}">
						<a href="godealCustomer.do?id=${data.customerId}" title="分配给跟单人员">分配</a>
						</c:if>
						<!-- <a href="getCustomer.do?id=${data.customerId}" >修改</a> -->
						
						<a  href="javascript:void();" onclick="return del(${data.customerId});" >删除</a>
					</td>
				</tr>
				</c:forEach>
				<tr>
					<TD nowrap class="bg0" colSpan=16 height=30 align="right"><p:pages url="customerListSystem.do"/></TD>
				</tr>
			</table>
			</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		
		<script type="text/javascript">
		
		function del(id)
		{
		var t=new Date();
		var url="delCustomer.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="customerListSystem.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
		</script>
	</body>
</html>
