<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

		<script type="text/javascript" src="js/jquery.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" charset="gbk"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/verifyorder.js" charset="gbk"></script>
<title>流程单信息表</title>

</head>
	<body>
	<FORM name="" action="addPurReturnOrderRejection.do" method="post">
			<TABLE  cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD width="100%">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 width="100%"
								align=center border=1>
								<TBODY>
													
								<TR >
										<TD width="100%" height=30 align="center"  colspan="3">
											<h1>新增流程单信息</h1>
										</TD>
									</TR>																				
									<TR >
										<TD width="200px" height=30 align=right> 
											流程单类型：
										</TD>
										<TD width="600px" class=category>
											${verifyOrder.aname}
											<input id="remark" value="${verifyOrder.mark}" type="hidden" />
										</TD>
										<TD width="200px" class=category>
											<input id="adddepartment"  type="button" name="adddepartment" onclick="add1()" value="添加部门"/>
											
										</TD>
									</TR>	
									<TR>
										<TD width="200px" height=30 align=right> 
											标识：
										</TD>
										<TD width="600px" class=category colspan="2">
											${verifyOrder.mark}
										</TD>
									</TR>	
									<tr>
										<td colspan="3">
											<table  width="1245px" border="1" bgcolor="white"  id="department"></table>
										</td>
									</tr>
									<tr align="center">
										<td>
										</td>
										<td align="center" ><font>请根据员工的审核的先后顺序输入由小到大的数字！！（同时审核或多人需一人审核是输入相同的数字）</font></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="3" id="aaa"  >
												
													<c:forEach items="${vOrderEmployee}" var ="voe" varStatus="states">
														<table align='center' >
												<tr id="" align='center' border='1'
													bgcolor='white'>
													<td width='200px'>
														部&nbsp;&nbsp;&nbsp;门： ${voe.department.name }
													</td>
													<td align='left' width='145px'>
														员&nbsp;&nbsp;&nbsp;工：<label id="" value="">	${employeeName[states.index] }</label>
													</td>
													<td>
														<input id="ipt${employeeid[states.index]}" name="" type='text' value="${voe.orderVerify }" style='width: 30px' />
														<input id="" name="" type="button" onclick="delemployee(${voe.department.id},${employeeid[states.index]},${verifyOrder.id})" value="删除"/>
													</td>
												</tr>
											</table>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td align="left"><input type="hidden" id="bmId" value="${dtid}"/><input type="hidden" id="ygId" value="${eid}"/><input type="button" onclick="ssss()" value="确定"/></td>
									</tr>
									<tr >
										<td></td>
											<td id="bbb"  width="1245px">
												<table id="deltable"></table>
											</td>
										<td></td>
									</tr>
									<TR>
										
										<TD colspan="3" align="center">
											<INPUT type="button" name="returnTime" id="returnTime" onclick="addverify1()" value="修改">
											&nbsp;
											
											<INPUT type="reset"  name="returnTime" id="returnTime" value="重置">
										</TD>
									</TR>	
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
		
	</body>
	<script type="text/javascript">
	function delemployee(dtid,emid,order)
	{	

		window.location.href='<%=request.getContextPath()%>/delemployeeVerify.do?dtid='+dtid+'&emid='+emid+'&order='+order+'';
	}
	</script>
</html>