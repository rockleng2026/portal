<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>修改供应商信息</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
        <script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
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

		<FORM id ="form1" name="form1" action="updatesupplierr.do" method="post" onsubmit="return addValidators()">

		
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
										<TD width="25%" height=30 align=right>供应商名称：</TD>
										<TD width="75%" class=category><!-- onblur="checkValueByRules('supplierName','checknamesupplierr.do','nameMsg')" -->
											<INPUT   style="WIDTH: 200px" id="supplierName" name="supplierName"  value="${supplier.supplierName}"/>
											&nbsp;
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											负责人身份证号码：
										</TD>
										<TD width="75%" class=category>
											<INPUT id="cardid" style="WIDTH: 200px" onblur="checkValueByRules(this,['cardno'],'cardidMsg')" name="cardid" value="${supplier.cardid}"/>
											&nbsp;
											<FONT color=#ff0000 id='cardidMsg'></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											联系电话：
										</TD>
										<TD class=category>
											<INPUT id="phone" style="WIDTH: 200px" name="phone" onblur="checkValueByRules(this,['tel'],'phoneMmsg')" value="${supplier.phone}" onblur="return test()">
											&nbsp;
											<font id="phoneMmsg" color="red"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司名称：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('supplierCompany','','supplierCompanyMmsg')"  style="WIDTH: 300px" id="supplierCompany" name="supplierCompany" value="${supplier.supplierCompany}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><font color=#ff0000 id="supplierCompanyMmsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商公司地址：
										</TD>
										<TD class=category>
											<INPUT  onblur="checkValueByRules('supplierAddress','','supplierAddressMmsg')" style="WIDTH: 300px" id="supplierAddress" name="supplierAddress" value="${supplier.supplierAddress}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><font color=#ff0000 id="supplierAddressMmsg"></font>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											供应商手机：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 300px" name="mobilePhone" id="mobilePhone"  onblur="checkValueByRules('mobilePhone',['phone'],'mobilePhoneMmsg')" value="${supplier.mobilePhone}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><font color=#ff0000 id="mobilePhoneMmsg"></font>
										</TD>
									</TR>

									<TR>
										<TD align=right height=30>
											供应商银行帐号：
										</TD>
										<TD class=category>
											<INPUT id="bankAccount" style="WIDTH: 150px" name="bankAccount" onblur="checkValueByRules(this,['num'],'bankAccountMmsg')" value="${supplier.bankAccount}"/>
											&nbsp;
											<FONT color=#ff0000 id="bankAccuntMmsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商来源：
										</TD>
										<TD class=category>
											<input name="supplierOrigin" value="${supplier.supplierOrigin}"/>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商Email：
										</TD>
										<TD class=category>
											<input id="email" name="email" onblur="checkValueByRules(this,['email'],'emailMmsg')" value="${supplier.email}"/>
											<font color=#ff0000 id="emailMmsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商邮编：
										</TD>
										<TD class=category>
											<input id="zipCode" onblur="checkValueByRules(this,['zip'],'zipMmsg')" name="zipCode" value="${supplier.zipCode}"/>
											<font color=#ff0000 id="zipMmsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商传真：
										</TD>
										<TD class=category>
											<input id="facsimile" name="facsimile" onblur="checkValueByRules(this,['tel'],'facsimileMmsg')" value="${supplier.facsimile}" />
											<font color=#ff0000 id="facsimileMmsg"></font>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											供应商QQ号码：
										</TD>
										<TD class=category>
											<input name="qq" value="${supplier.qq}"/>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											建立供应商日期：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('date',['birth'],'dateMmsg')" style="WIDTH: 150px" id="date" name="date"
												onclick="WdatePicker()" value="${supplier.date}"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="dateMmsg"></FONT> 
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
											<INPUT type=hidden value=<%=loginName %> name="admin">
											<input type="hidden" name="id" value="${supplier.id }">
											<input type="hidden" name="del" value="${supplier.del }">
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
						<TD>&nbsp;</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>	
	</BODY>
</HTML>
