<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>单据类型管理列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
function del(id)
		{
		var t=new Date();
		var url="deldocmark.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==0)
		             {
		                 alert("删除成功");
		                 window.location.href="getpagedocmark.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
</script>
</head>
<body>
		<FORM name=form2 action="getpagedocmark.do?funid=276" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							单据标识：
							<INPUT name="payNo" >
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
										&nbsp;收款单记录查询
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
						
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="20%" class=category>
											流程单据名称
										</TD>
										<TD width="30%" class=category>
											流程单据标识
										</TD>
										<TD width="20%" class=category>
											修改
										</TD>
										<TD width="20%" class=category>
											删除
										</TD>
									</TR>
									<!--循环-->
                                   
									<c:forEach items="${pages.pageList}" var="data" >
										

											<TR>
											
												<TD align=middle>
												${data.aname }
												</TD>
												<TD align=middle>
													${data.mark }
												</TD>
												
												<TD align=middle>
												<c:if test="${fn:indexOf(data.mark,'-')!=-1}">
												<A
														href="skipupdatedocmark.do?id=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
												</TD>
												<TD align=middle>
												<c:if test="${fn:indexOf(data.mark,'-')!=-1}">
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
													</c:if>
												</TD>
											</TR>
											
											</c:forEach>
					
											<TR>

											</tr>
									<!--循环结束-->




									<TD class=category colSpan=12 height=30 align="right">
									</TD>
								</TBODY>
							</TABLE>
				
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD><p:pages url="getpagedocmark.do?funid=276"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
