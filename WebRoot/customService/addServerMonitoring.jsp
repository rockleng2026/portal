<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加服务器监控记录</title>
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
		<FORM  id ="form1" name=form1 action="addorupServerMonitoring.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;服务器监控记录(带*号的为必填项)
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
										<TD align=right height=30>
											服务器名称：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" id="server" name="server" value="${sm.product.property.name }" 
											
											onblur="checkValueByRules('server','','serveridMsg')" 
											onclick="completemission('showDialogOutbound.do?mark=commodity&server=server','')"
											/>
											<input type="hidden" id="productid" name="productid" value="${sm.product.id }">
												<font id="liip" style="display: none;">  </font>
											<FONT color=#ff0000 id="serveridMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
											<TR>
										<TD align=right height=30>
											服务器IP：
										</TD>
										<TD width="75%" class=category>
										
											<INPUT style="WIDTH: 200px" id="serverIp" name="serverIp" value="${sm.serverIp }" onblur="checkValueByRules('serverIp','','serverIpMsg')"/>
											<FONT color=#ff0000 id="serverIpMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											监控员工：
										</TD>
										<TD class=category>
											<%=request.getSession().getAttribute("loginName") %>
											<input id ="declareR" name="declareR" type="hidden" value="<%=request.getSession().getAttribute("loginName") %>"/>
										</TD>
									</TR>
									
									<TR>
										
										<TD align=right height=30>
											监控时间：
										</TD>
										<TD class=category>
										 <INPUT id="time" onblur="checkValueByRules('time',['birth'],'timeMsg')"  style="WIDTH: 150px" name="time"
												onclick="WdatePicker()" value="${sm.time }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="timeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									
									<tr>
									<td align=right>监控描述：
										</TD>
										<TD class=category>
											<textarea rows="10" cols="100" name="monitorLog" >${sm.monitorLog }</textarea>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="adminMsg"></FONT></TD></tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<c:if test="${sm == null}"><INPUT  class=button type=submit value=" 确认添加 "></c:if>
											<c:if test="${sm != null}"><INPUT  class=button type=submit value=" 确认修改 "><input type="hidden" name="id" value="${sm.id }"/></c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
						</TD>
						<TD></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD>s</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
