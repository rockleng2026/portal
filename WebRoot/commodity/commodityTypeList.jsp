<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>商品类型信息</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>

		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<SCRIPT language=javascript>
		
		function del(id)
		{
		var t=new Date();
		var url="delcommodityTpye.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==0)
		             {
		                 alert("删除成功");
		                 window.location.href="selectPagecommodityTpye.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}

</SCRIPT>



		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>

		<FORM name=form2 action="selectPagecommodityTpye.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" >
						</TD>
						<TD align=right width="95%">
							商品名称：
							<INPUT name=tname>
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
										&nbsp;商品类型查询
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
									
										
										
										<TD width="12%" class=category>
											商品类型名称
										</TD>
										<TD width="9%" class=category>
											创建商品类型时间
										</TD>
										<TD width="21%" class=category>
											创建商品类型员工
										</TD>
										
										<TD width="8%" class=category>
											修改
										</TD>
										<TD width="8%" class=category>
											删除
										</TD>
										<TD width="8%" class=category>
											详细信息
										</TD>
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >


											<TR>

												<TD align=center>
													${data.typeName}
												</TD>
												<TD align=center>
													${data.time}
												</TD>
												<TD align=center>
													${data.employee.name}
													</TD>
											
												<TD align=center>
													<A
														href="updatePagecommodityTpye.do?id=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif"  border=0>
													</a>
												</TD>
												<TD align=center>
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
												<TD align=center>
													<a href="infocommodityTpye.do?id=${data.id }">详细信息</a>
												</TD>
											</TR>
											</c:forEach>
											
											<TR>
									<TD class=category colSpan=14 height=30>
									<p:pages url="selectPagecommodityTpye.do"/>
									</TD>
											</tr>
									<!--循环结束-->
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
