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
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
    <base href="<%=basePath%>">
    	<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff 
}
</STYLE>
<SCRIPT language=javascript>
		
		function del(id,endurl)
		{
		var t=new Date();
		var url="delMalfunctionDeclare.do?t="+t;
		     if(confirm("你确定要删除该数据吗？"))
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==0)
		             {
		                 alert("删除成功");
		                 window.location.href=endurl;
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
    <title>故障列表</title>
  </head>
  <BODY>

									<c:if test="${mark==8}">
									<FORM name=form2 action="commutatorMalfunctionDeclare.do" method="post">
									</c:if>
									<c:if test="${mark==9}">
									<FORM name=form2 action="selectMalfunctionDeclare.do?tag=<%=request.getAttribute("tag") %>" method="post">
									</c:if>
									<c:if test="${mark!=8 && mark!=9}">
									<FORM name=form2 action="getMalfunctionDeclare.do" method="post">
									</c:if>
		
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
										<TD width="15%" class=category>
											故障单号
										</TD>
										<TD width="8%" class=category>
											客户名称
											<input type="hidden" id="bl" value="${tag }">
										</TD>
										<TD width="12%" class=category>
											报修产品名称
										</TD>
										<TD width="12%" class=category>
											问题类型
										</TD>
										<TD width="12%" class=category>
											<!--  <a id="faultTime" href="getMalfunctionDeclare.do?order=faultTime" onclick="orderby(this)">-->申报故障日期<!-- </a> -->
										</TD>
										<TD width="10%" align="center" height=30 class=category>
											处理状态
										</TD>
										<TD width="8%" align="center" class=category>
											详细情况
										</TD>
										<TD width="8%" align="center" class=category>
											接收状态
										</TD>
										<!--  
										<TD width="8%" align="center" class=category>
											修改
										</TD>
										-->
										<TD width="8%" align="center" class=category>
											删除
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=center>
													${data.conkOutNo}
												</TD>
												<TD align=center>
													${data.customer.customerName}
												</TD>
												<TD align=center>
													${data.product.property.model.name }
												</TD>
												<TD align="center"  style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													${data.issueType.questionName}
												</TD>
												<TD align=center>
													${data.faultTime}
													</TD>
													<TD align="center" style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													<c:if test="${data.state ==0}">未处理</c:if>
													<c:if test="${data.state ==1}">已接收</c:if>
													<c:if test="${data.state ==2}">${data.employee.department.name }${data.employee.name }处理中</c:if>
													<c:if test="${data.state ==3}">${data.employee.department.name }${data.employee.name }处理完成</c:if>
													<c:if test="${data.state ==4}">已处理</c:if>
													<c:if test="${data.state ==7}">${empDetial.employee.department.name }${empDetial.employee.name}已接收</c:if>
													<c:if test="${data.state =='-1'}">退回故障单</c:if>
													<c:if test="${data.state ==5}">已评价</c:if>
												</TD>
												<TD  align="center" style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													<A
														href="detailMalfunctionDeclare.do?id=${data.id }&mark=<%=request.getAttribute("mark") %>"
														target=right>查看详细
													</a>
												</TD>
												<TD  align="center" style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
												  <c:choose>
												  <c:when test="${data.state==0}">
												 		未接收
												  </c:when>
												  <c:otherwise>
												    	已接收
												  </c:otherwise>
												  </c:choose>
												</TD>
												<!--  
												<TD align="center">
													<A
														href="upPageMalfunctionDeclare.do?id=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
													</a>
												</TD>
												-->
												<TD align=center>
												<c:if test="${mark==8}">
												<a href="javascript:void();" onclick="return del(${data.id},'commutatorMalfunctionDeclare.do');"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</c:if>
												<c:if test="${mark==9}">
												<a href="javascript:void();" onclick="return del(${data.id},'selectMalfunctionDeclare.do?tag=<%=request.getAttribute("tag") %>');"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</c:if>
												<c:if test="${mark!=8 && mark!=9}">
												<a href="javascript:void();" onclick="return del(${data.id},'getMalfunctionDeclare.do');"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</c:if>
												</TD>
											</TR>
											</c:forEach>
											
											<TR>
									<TD class=category colSpan=14 height=30>
									<c:if test="${mark==8}">
									<p:pages url="commutatorMalfunctionDeclare.do"/>
									</c:if>
									<c:if test="${mark==9}">
									<p:pages url="selectMalfunctionDeclare.do" key="tag" value="${tag}"/>
									</c:if>
									<c:if test="${mark!=8 && mark!=9}">
									<p:pages url="getMalfunctionDeclare.do"/>
									</c:if>
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
