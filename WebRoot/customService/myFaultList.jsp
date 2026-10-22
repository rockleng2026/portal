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
  <LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
    <base href="<%=basePath%>">
    	<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff 
}
</STYLE>
<SCRIPT language=javascript>
		
		function del(id)
		{
		var url="delMalfunctionDeclare.do?";
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{ id:id },function(data){	
		    		alert(data);
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getMalfunctionDeclare.do?t="+t;
		             }else
		             {
		             	 
		            	 alert("删除失败")
		             }
		            });
		     }
		}


		function orderby(obj)
		{
		var tag = $("#bl").val();
		if(null != tag && tag!= '' && tag == obj.id)
		{
		$("#"+obj.id).attr("href",obj.href.substring(0,obj.href.indexOf("?")));
		}
		}
</SCRIPT>
    <title>故障列表</title>
  </head>
  <BODY>

		<FORM name=form2 action="getMalfunctionDeclare.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							客户名称：
							<INPUT name=cname>
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;故障查询
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										
										
										<TD width="12%" class=category>
											客户名称
											<input type="hidden" id="bl" value="${tag }">
										</TD>
										<TD width="9%" class=category>
											服务器IP
										</TD>
										<TD width="21%" class=category>
											故障描述
										</TD>
										<TD width="18%" class=category>
											<a id="faultTime" href="getMalfunctionDeclare.do?order=faultTime" onclick="orderby(this)">申报故障日期</a>
										</TD>
										<TD width="13%" height=30 class=category>
											处理结果
										</TD>
										<TD width="8%" class=category>
											修改
										</TD>
										<TD width="8%" class=category>
											删除
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR>

												<TD align=center>
													${data.customer.customerName}
												</TD>
												<TD align=center>
													${data.serverIp}
												</TD>
												<TD  style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													${data.descs}
												</TD>
												<TD align=center>
													${data.faultTime}
													</TD>
													<TD style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													
													<c:if test="${data.state ==0}">未处理</c:if>
													<c:if test="${data.state ==1}">${data.solveDepict }</c:if>
													
												</TD>
												<TD >
													<c:if test="${data.state ==0}"><A
														href="upPageMalfunctionDeclare.do?id=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
													</a></c:if>
													<c:if test="${data.state ==1}">已处理的故障信息不可以修改</c:if>
												</TD>
												<TD align=center>
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
											</TR>
											</c:forEach>
											
											<TR>
									<TD class=category colSpan=14 height=30>
									<p:pages url="getMalfunctionDeclare.do"/>
									</TD>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</html>
