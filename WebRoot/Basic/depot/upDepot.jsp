<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>修改仓库信息</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>

		<FORM id ="form1" name="updateDepot" action="updatedepot.do" method="post" onsubmit="return addValidators()">

		
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
											&nbsp;修改供应商资料(带*号的为必填项)
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
										<TD width="25%" height=30 align=right>仓库名称：</TD>
										<TD width="75%" class=category>
											<INPUT  onblur="checkValueByRules('name','','nameMsg')" style="WIDTH: 200px" id="name" name="name" value="${depot.name}"/>
											&nbsp;
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库地址：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" id="address" name="address" onblur="checkValueByRules('address','','addressMsg')" value="${depot.address}"/>
											&nbsp;
											<FONT color=#ff0000 id="addressMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库容量：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="capacity" id="capacity"  onblur="checkValueByRules(this,['num'],'capacityMsg')" value="${depot.capacity}">
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="capacityMsg" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库管理员：
										</TD>
										<TD class=category>
										<input id="emp" value="${depot.employee.name }" onblur="checkValueByRules('emp','','empMsg')" onclick="returnSome('showDialogOutbound.do?mark=employee','emp','empid')">
											   	<input id="empid" name="admin" type="hidden" value="${depot.employee.id }" />
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
					
										<TR>
										<TD align=right height=30>
											建立仓库日期：
										</TD>
										<TD class=category>
											<INPUT id="time" onblur="checkValueByRules('time',['birth'],'timeMsg')"  style="WIDTH: 150px" name="time"
												onclick="WdatePicker()" value="${depot.time}"/>
											&nbsp;
											<font id="timeMsg" color=#ff0000></font><FONT color=#ff0000>*</FONT> 点击输入框获取时间
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=submit value=" 确认修改 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="hidden" name="id" value="${depot.id }">
											<input type="hidden" name="del" value="${depot.del }">
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
						<TD>i</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>	
	</BODY>
</HTML>
