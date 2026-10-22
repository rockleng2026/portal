<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>填写处理结果</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addResultMalfunctionDeclare.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;填写处理结果
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
											<TR>
										<TD width="25%" height=30 align=right>客户名称：</TD>
										<TD width="75%" class=category>
												${ cout.customer.customerName}
											<input type ="hidden" value = "${cout.id }" name="id">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											服务器IP：
										</TD>
										<TD width="75%" class=category>
											${cout.serverIp }
										</TD>
									</TR>
									<tr>
									<td align=right>故障描述：
										</TD>
										<TD class=category>
											<textarea readonly="readonly"
											 rows="10" cols="100" name="desc" border="0"  >${cout.descs }</textarea>
											
									</TD></tr>
									<TR>
										<TD align=right height=30>
											故障处理员工：
										</TD>
										<TD class=category>
											<%=request.getSession().getAttribute("loginName") %>
											<input id ="declareR" name="declareR" type="hidden" value="<%=request.getSession().getAttribute("loginName") %>"/>
										</TD>
									</TR>
									
									<TR>
										
										<TD align=right height=30>
											处理故障时间：
										</TD>
										<TD class=category>
										 <INPUT id="endTim" onblur="checkValueByRules('endTim',['birth'],'timeMsg')"  style="WIDTH: 150px" name="endTim"
												onclick="WdatePicker()"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="timeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									
									
									<tr>
									<td align=right>处理结果：
										</TD>
										<TD class=category >
											<textarea rows="10" cols="100" name="solveDepict" ></textarea>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="adminMsg"></FONT></TD></tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<INPUT  class=button type=submit value=" 确认添加 ">
											
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
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
		</FORM>
	</BODY>
</HTML>
