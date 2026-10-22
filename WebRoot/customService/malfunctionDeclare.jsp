<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>客户故障申报</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function returnsucceed(){

	var authorization=document.getElementById("authorization").value;
	if(authorization==""||authorization==null)
	{
		document.getElementById("authorization1").innerHTML="请输入授权码";
		return false;
	}
	var cusnameId=document.getElementById("cusname").value;
		var aa=encodeURI(authorization);
	var url="selectcussaleOrder.do";
	$.post(url,{cusnameId:cusnameId,authorization:aa},function(data){
	if(data==0)
	{
		document.getElementById("authorization1").innerHTML="请选择客户";
		$("#cus").focus();
		return false;
	}else if(data==2)
	{
		document.getElementById("authorization1").innerHTML="授权码错误";
		return false;
	}
	else
	{
		document.getElementById("authorization1").innerHTML="授权码正确";
		return true;
	}
	
	});
}
</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="addMalfunctionDeclare.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;添加故障申报单(带*号的为必填项)
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
										<TD width="25%" height=30 align=right>客户名称：<FONT color=#ff0000>*</FONT></TD>
										<TD width="75%" class=category>
												<input id="cus" onblur="checkValueByRules('cus','','cusMsg')" value="${ cout.customer.customerName}"
												onclick="completemission('showDialogOutbound.do?mark=custom','')">
											   	<input name="customer.customerId" id="cusname" type="hidden" value="${ cout.customer.customerId}"/>
											<FONT color=#ff0000 id="cusMsg"></FONT>
										</TD>
									</TR>
									<TR>
							         <TD width="25%" height=30 align=right>
							          		&nbsp;产品类型<FONT  color=#ff0000>*</FONT>
							          </TD>
							          <TD width="75%" class=category>
							          		<s:select  onchange="producttype2('s2',this.value)" name="proudcotType.id" id="s1"  list="#request.orderType" listKey="id" listValue="questionName" value="%{-1,#request.saleorder.allTypeByOrdertype.id}" headerKey="" 
											 headerValue="请选择产品类型"  onblur="checkValueByRules('s1','','s1Msg')" ></s:select>
											 <FONT color=#ff0000 id="s1Msg"></FONT>
							          </TD>
							          </TR>
							        <TR>
							          <TD width="25%" height=30 align=right>IP或者帐号<FONT color=#ff0000>*</FONT></TD>
							          <TD id=chattext  width="75%" class=category>
							          	<SELECT style="WIDTH: 180px" id="new_addr" name="pid" onblur="checkValueByRules('new_addr','','new_addrMsg')" >
							          	</SELECT>
							          	<FONT color=#ff0000 id="new_addrMsg"></FONT>
							          </TD>
							         </TR>
									<TR>        
							          <TD width="25%" height=30 align=right>&nbsp;问题类别<FONT 
							            color=#ff0000>*</FONT><FONT color=#ff0000>&nbsp;</FONT></TD>
							          <TD width="75%" class=category><SELECT style="WIDTH: 180px" name="issueType.id" id="s2" onchange="getTime(this.value)"> 
							              <OPTION selected value="">--请选择--</OPTION></SELECT><FONT color=#009F00 id="normalTime"></FONT></TD>
							        </TR>
									<TR>
										<TD width="25%" height=30 align=right>
											授权码：<FONT color=#ff0000>*</FONT>
										</TD>
										<TD class=category colspan="3">
											<input id="authorization" name="authorization" type="password"  onblur="returnsucceed()" />											
											
											&nbsp;&nbsp;
											<FONT id="authorization1" color=#ff0000 >请输入客户给予的授权码，验证唯一性、真实性</FONT>
										</TD>
									</TR>	
									<!-- 
									<TR>
										<TD align=right height=30>
											服务器IP：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" id="serverIp" name="ip" value="${cout.serverIp }" onblur="checkValueByRules('serverIp','','serverIpMsg')"/>
											<FONT color=#ff0000 id="serverIpMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									 -->
									<TR>
										<TD align=right height=30>
											故障单填写人：<FONT color=#ff0000>*</FONT>
										</TD>
										<TD class=category>
											<%=request.getSession().getAttribute("loginName") %>
											<input id ="declareR" name="declareR" type="hidden" value="<%=request.getSession().getAttribute("loginName") %>"/>
										</TD>
									</TR>
									
									<TR>
										
										<TD align=right height=30>
											出现故障时间：<FONT color=#ff0000>*</FONT>
										</TD>
										<TD class=category>
										 <INPUT id="faultTime" onblur="checkValueByRules('faultTime',['birth'],'timeMsg')"  style="WIDTH: 150px" name="faultTime2"
												onclick="WdatePicker()" value="${cout.faultTime }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="timeMsg"></FONT>点击输入框获取时间
										</TD>
									</TR>
									
									<tr>
									<td align=right>故障描述：<FONT color=#ff0000>*</FONT>
										</TD>
										<TD class=category>
											<textarea id="descs" rows="10" cols="100" name="descs" onblur="checkValueByRules('descs','','descsMsg')">${cout.descs }</textarea>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="descsMsg"></FONT></TD></tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<c:if test="${cout == null}"><INPUT  class=button type=submit value=" 确认添加 "></c:if>
											<c:if test="${cout != null}"><INPUT  class=button type=submit value=" 确认修改 "><INPUT name = "id" type="hidden" value = "${cout.id }"></c:if>
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
