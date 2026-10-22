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
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
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
		var url="delContracta.do?t="+t;
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

								
									<FORM name=form2 action="selectContracta.do" method="post">							
        <TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							合同编号：
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
										&nbsp;合同列表
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
											合同号码
										</TD>
										<TD width="18%" class=category>
											合同名称
											<input type="hidden" id="bl" value="${tag }">
										</TD>
										<TD width="12%" class=category>
											客户
										</TD>
										<TD width="12%" class=category>
											签订合同时间
										</TD>

										<TD width="12%" align="center" class=category>
											合同到期时间
										</TD>
										<TD width="8%" align="center" class=category>
											审核状态
										</TD>
										
										<TD width="8%" align="center" class=category>
											修改
										</TD>
										
										<TD width="8%" align="center" class=category>
											删除
										</TD>
										<TD width="10%" align="center" class=category>
											查看详细
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=center>
													${data.contractNo}
												</TD>
												<TD align=center>
													${data.contractName}
												</TD>
												<TD align=center>
													${data.customer.realName }
												</TD>
												<TD align="center"  style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													${data.signupTime}
												</TD>
												<TD  align="center" style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
													${data.endTime}
												</TD>
												<TD  align="center" style= "WORD-BREAK: break-all; WORD-WRAP: break-word">
												  <c:choose>
												  <c:when test="${data.auditState==0}">
												 		未审核
												  </c:when>
												  <c:otherwise>
												    	已审核
												  </c:otherwise>
												  </c:choose>
												</TD>
												
												<TD align="center">
													<A
														href="goUpdateContracta.do?id=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
													</a>
												</TD>
												
												<TD align=center>
											
												<a href="javascript:void();" onclick="return del(${data.id},'selectContracta.do');"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
												<TD align=center>
											
												<a href="goUpdateContracta.do?info=info&id=${data.id }"
														target=right> 查看详情</a>
												</TD>
											</TR>
											</c:forEach>
											
											<TR>
									<TD class=category colSpan=14 height=30>
									
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
