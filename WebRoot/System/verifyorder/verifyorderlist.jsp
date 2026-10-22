<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>审核流程列表</title>

</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post" onsubmit="return checkReturnOrder()">
			<TABLE cellSpacing=0 cellPadding=0 width="1236" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>					
								<TR align="center">
										<TD width="2%" class=category>
											行号
										</TD>
										<TD width="11%" class=category>
											流程单类型
										</TD>
										<TD width="11%" class=category>
											审核部门
										</TD>
										<TD width="3%" class=category>
										修改
										</TD>
										<TD width="3%" class=category>
										删除
										</TD>
										<TD width="5%" class=category>
										查看
										</TD>	
									</TR>
									<c:forEach items="${pages.pageList}" var="data" varStatus="states">
									
									<tr  align="center">
										<TD>
											${states.index+1}
										</TD>
									
										<TD >
											${departments[states.index]}
										</TD>
										<TD>
										${orderType[states.index]}	
											
										</TD>
										<c:forEach items="${order[states.index]}" var="dt">
										<TD>
											<a href="updateVerify.do?order=${dt}" target=right>
												<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath()%>/images/res.gif" align=absMiddle border=0>
											</a>    
										</TD>	
										<TD>
											<a href="javascript:void();" onclick="delVerifyOrder(${dt});"><img src="<%=request.getContextPath()%>/img/del.gif" width="20px" height="20px" border=0 ></a>
										</TD>	
										<TD>
											<a href="selectInfoVerify.do?order=${dt}">查看</a>
										</TD>	
										</c:forEach>									
									</tr>
									</c:forEach>
									
									<tr>
										<td colspan="6"><p:pages url="pageslistVerify.do"/></td>
									</tr>		
								</TBODY>
							</TABLE>
						</TD>
						<TD>
						</TD>
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
		</FORM>
		<script type="text/javascript">
			function delVerifyOrder(vid)
			{
				var str = window.confirm("您确定要删除所选中的数据信息吗？");
				if(str==true)
				{
					var url = "deleteVerify.do";
					$.post(url,{id:vid},function(data){
						if(data=="1")
						{
							alert("删除成功");
							window.location.href="pageslistVerify.do";
						}
						else
						{
							alert("删除失败");
							return ;
						}
					});
				}
				else
				{
					return ;
				}
			}
		</script>
	</body>
</html>