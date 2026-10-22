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
		var t=new Date();
		var url="delServerMonitoring.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="selectServerMonitoring.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}

</SCRIPT>
    <title>故障列表</title>
  </head>
  <BODY>

		<FORM name=form2 action="selectdepot.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
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
										&nbsp;服务器监控记录
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
											服务器唯一标识
										</TD>
										<TD width="12%" class=category>
											服务器名称
										</TD>
										<TD width="9%" class=category>
											服务器IP
										</TD>
										<TD width="21%" class=category>
											监控时间
										</TD>
										<TD width="18%" class=category>
											监控记录
										</TD>
										<TD width="13%" height=30 class=category>
											监控员工
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="8%" class=category>
													删除
												</TD>
											</c:if>
										</c:forEach>
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR>
											<TD align=center>
													${data.product.barcode}
												</TD>

												<TD align=center>
													${data.product.property.name}
												</TD>
												<TD align=center>
													${data.serverIp}
												</TD>
												<TD  >
													${data.time}
												</TD>
												<TD  style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													${data.monitorLog}
													</TD>
													<TD >
													
												${data.employee.name }
													
												</TD>
												<c:forEach items="${option}" var="map">
													<c:if test="${map.key==2}">
														<TD align=center>
															<A href="uppageServerMonitoring.do?id=${data.id }"
															target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
															</a>
														</TD>
													</c:if>
													<c:if test="${map.key==3}">
														<TD align=center>
															<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
														</TD>
													</c:if>
												</c:forEach>
											</TR>
											</c:forEach>
											<TR>
									<TD class=category colSpan=14 height=30>
									<p:pages url="selectServerMonitoring.do"/>
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
