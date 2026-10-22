<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
	<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>  
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>工单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<base target="_self">
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<SCRIPT language=javascript>
		
		function del(id)
		{
		var t=new Date();
		var url="delWorkOrderCfigur.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==0)
		             {
		                 alert("删除成功");
		                 window.location.href="getWorkOrderCfigur.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
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
<body>
		<FORM name=form2 action="getWorkOrderCfigur.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							工单名称：
							<INPUT name=name>
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
										&nbsp;功能提醒查询
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
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="13%" height=30 class=category>
											编号
											<input id="bl" type="hidden" value="${tag }">
										</TD>
										
										<TD width="12%" class=category>
											工单名称
										</TD>
										<TD width="9%" class=category>
											工单上级名称
										</TD>
										<TD width="9%" class=category>
											处理工单总时间/分钟
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

									<c:forEach items="${pages.pageList}" var="data" varStatus="status">
											<TR>
											
												<TD align=center height=25>
													${status.index }
												</TD>
												<TD align=center>
													${data.questionName}
												</TD>
												<TD align=center>
													${data.questioncategory.questionName}
												</TD>
												<TD align=center>
													${data.tmp1}
												</TD>

										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD align=center>
													<a href="updatepageWorkOrderCfigur.do?id=${data.id }" target=right><img style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0/></a>
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
									<!--循环结束-->
									<tr>
								<td class=category colSpan=14 height=30>
										 <p:pages url="getWorkOrderCfigur.do"/>
									</td>
									</tr>
								</TBODY>
							</TABLE>
						</FORM>
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
</HTML>