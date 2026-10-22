<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加供应商</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript"	src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
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
		<FORM  id ="form1" name=form1 action="addsupplierr.do" method="post" onSubmit="return addValidators()">
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
											&nbsp;添加供应商资料(带*号的为必填项)
										</TD>
										<TD align=right>&nbsp;
											
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
										<TD width="25%" height=30 align=right>供应商名称：</TD>
										<TD width="75%" class=category>
											<INPUT onBlur="checkValueByRules('supplierName','checknamesupplierr.do','nameMsg')"  style="WIDTH: 200px" id="supplierName" name="supplierName" />
											&nbsp;
												<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											负责人身份证号码：
										</TD>
										<TD width="75%" class=category>
											<INPUT id="cardid" style="WIDTH: 200px" onBlur="checkValueByRules(this,['cardno'],'cardidMsg')" name="cardid" />
											&nbsp;
											<FONT color=#ff0000 id='cardidMsg'></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											联系电话：
										</TD>
										<TD class=category>
											<INPUT id="phone" style="WIDTH: 200px" name="phone" onBlur="checkValueByRules(this,['tel'],'phoneMmsg')">
											&nbsp;
											<font id="phoneMmsg" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司名称：
										</TD>
										<TD class=category>
											<INPUT id="supplierCompany" onblur="checkValueByRules('supplierCompany','','supplierCompanyMmsg')"  style="WIDTH: 300px" id="supplierCompany" name="supplierCompany"/>
											&nbsp;
											<FONT color=#ff0000 id='supplierCompanyMmsg'></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司地址：
										</TD>
										<TD class=category>
											<INPUT id="supplierAddress"  onblur="checkValueByRules('supplierAddress','','supplierAddressMmsg')" style="WIDTH: 300px" id="supplierAddress" name="supplierAddress"/>
											&nbsp;
											<FONT color=#ff0000 id="supplierAddressMmsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											供应商手机：
										</TD>
										<TD class=category>
											<INPUT  style="WIDTH: 300px" name="mobilePhone" id="mobilePhone"  onblur="checkValueByRules('mobilePhone',['phone'],'mobilePhoneMmsg')"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="mobilePhoneMmsg"></FONT>
										</TD>
									</TR>

									<TR>
										<TD align=right height=30>
											供应商银行帐号：
										</TD>
										<TD class=category>
											<INPUT id="bankAccount" style="WIDTH: 150px" name="bankAccount" onBlur="checkValueByRules(this,['num'],'bankAccountMmsg')"/>
											&nbsp;
											<FONT color=#ff0000 id="bankAccountMmsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商来源：
										</TD>
										<TD class=category>
											<input name="supplierOrigin"/>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商Email：
										</TD>
										<TD class=category>
											<input id="email" name="email" onBlur="checkValueByRules(this,['email'],'emailMmsg')"/>
											<FONT color=#ff0000 id="emailMmsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商邮编：
										</TD>
										<TD class=category>
											<input id="zipCode" onBlur="checkValueByRules(this,['zip'],'zipMmsg')" name="zipCode"/>
											<FONT color=#ff0000 id="zipMmsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商传真：
										</TD>
										<TD class=category>
											<input id="facsimile" name="facsimile" onBlur="checkValueByRules(this,['tel'],'facsimileMmsg')"/>
											<font color=#ff0000 id="facsimileMmsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商QQ号码：
										</TD>
										<TD class=category>
											<input name="qq"  />
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											建立供应商日期：
										</TD>
										<TD class=category>
											<INPUT onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="WIDTH: 150px" id="date" name="date"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
										</TD>
									</TR>
									<TR>
										<TD height=30>&nbsp;
											
										</TD>
										<TD class=category>
											<INPUT  class=button type=submit value=" 确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT type=hidden value=<%=loginName %> name="admin">
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
