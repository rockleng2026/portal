<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加合同</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<c:if test="${contract == null}">
		<script type="text/javascript">
		
 $(document).ready(function(){
         $.post("getContractNOContracta.do",{id:1},function(date){
		$("#contractNo").val("HT-"+date);
		
		});           
            }); 	
                  
 		</script>
		
		</c:if> 
		
	</HEAD>
	<BODY >
		<FORM  id ="form1" name=form1 action="addContracta.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;添加合同(带*号的为必填项)
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
										<TD width="15%" height=30 align=right>
											合同编号：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('contractNo','','contractNoMsg')" style="WIDTH: 200px" id="contractNo" name="contractNo" value="${contract.contractNo }" readonly="readonly">
											&nbsp;<input type="hidden" id="id" name="id" value="${contract.id }"/>
											<input type="hidden" id="contractAccessory" name="contractAccessory" value="${contract.contractAccessory }"/>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="contractNoMsg"></FONT>
										</TD>
										<TD width="15%" height=30 align=right>
											合同名称：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('contractName','','contractNameMsg')" style="WIDTH: 200px" id="contractName" name="contractName" value="${contract.contractName }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="contractNameMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											签约日期：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('signupTime','','signupTimeMsg')" style="WIDTH: 200px" id="signupTime" name="signupTime" value="${contract.signupTime }" onclick="WdatePicker()">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="signupTimeMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											客户名称：
										</TD>
										<TD width="35%" class=category>
											<INPUT onclick="completemission('showDialogOutbound.do?mark=custom','')" readonly="readonly" 
											onblur="checkValueByRules('customer','','customerMsg')" style="WIDTH: 200px" id="customer" name="health" value="${contract.customer.customerCompany}">
											&nbsp;<input type="hidden" id="cusname" name="customer.customerId" value="${contract.customer.customerId}">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="customerMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											对方代表：
										</TD>
										<TD width="35%" class=category>
										<input id="dfdb" name="dfdb" readonly="readonly" value="${contract.customer.realName }" />
										</TD>
										<TD align=right width="15%" height=30>
											我方代表：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('employeeByEmpId','','employeeByEmpIdMsg')" style="WIDTH: 200px" id="employeeByEmp"
											 name="employeeByEmp" value="${contract.employeeByEmpId.name}" 
											 onclick="completemission('showDialogWarehousing.do?mark=employee&page=contact1','')">
											 <input type="hidden" id="employeeByEmpId" name="employeeByEmpId.id" value="${contract.employeeByEmpId.id}">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="employeeByEmpIdMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											生效日期：
										</TD>
										<TD width="25%" class=category>
											<INPUT style="WIDTH: 200px" id="comeTime" name="comeTime" value="${contract.comeTime }" onblur="checkValueByRules('comeTime','','comeTimeMsg')" onclick="WdatePicker()">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT id="comeTimeMsg" color=#ff0000></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											终止日期：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('endTime','','endTimeMsg')" style="WIDTH: 200px" id="endTime" name="endTime" value="${contract.endTime}" onclick="WdatePicker()">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="endTimeMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right height=30>
										是否开票：
										</td>
								 		 <TD width="25%" class=category>
											<select name="isInvoice">
											<option value="Y">是</option>
											<option value="N" <c:if test="${contract.isInvoice =='N' }"> checked</c:if>>否</option>
											</select>
										</TD>
									<TD align=right width="15%" height=30>
											合同金额：
										</TD>
										<TD width="35%" class=category>
										<INPUT style="WIDTH: 150px" id="contractMoney" name="contractMoney" value="${contract.contractMoney}">
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											合同状态：
										</TD>
										<td width="25%" class="category" onblur="checkValueByRules('contractState','','depMsg')">
										<select id="contractState" name="contractState">
										<option value="" <c:if test="${contract.contractState =='' }">selected="selected"</c:if>>--请选择--</option>
										<option value="未开始" <c:if test="${contract.contractState =='未开始' }">selected="selected"</c:if>>未开始</option>
										<option value="进行中" <c:if test="${contract.contractState =='进行中' }">selected="selected"</c:if>>进行中</option>
										<option value="过期" <c:if test="${contract.contractState =='过期' }">selected="selected"</c:if>>过期</option>
										
										</select>
										
										<FONT color=#ff0000 >*</FONT><FONT color=#ff0000 id="depMsg"></FONT> 
									    </td>
										<TD align=right width="15%" height=30>
											收款期限：
										</TD>
										<TD width="35%" class=category>
											<INPUT  style="WIDTH: 200px" id="gatheringTime" name="gatheringTime" value="${contract.gatheringTime}" onclick="WdatePicker()">
											
										</TD>
									</TR>
										<TD align=right width="15%" height=30>
											备注：
										</TD>
								     <td width="25%" class="category" )">
											<INPUT  style="WIDTH: 200px" id="remark" name="remark" value="${contract.remark}">
										
										
									 </td>
									<TD align=right width="15%" height=30>
										
										</TD>
										<TD width="35%" class=category>
										
										</TD>
									</TR>
									
									
									<TR>
										<TD height=30>
											合同内容
										</TD>
										<TD class=category colspan="3">
									<textarea rows="10" cols="150" name="contractContent">${contract.contractContent }</textarea>
											
										</TD>
										
									</TR>
									<TR>
										<TD height=30>
											上传合同附件
										</TD>
										<TD class=category colspan="3">
									
										<br></TD>
										
									</TR>																													
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category colspan="3">
										<c:if test="${contract==null}">
											<INPUT class=button type=submit value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${contract!=null}">
											<INPUT class=button type=submit value="确认修改 ">									
											</c:if>
											<INPUT class=button type=reset value=" 重置 ">
											<c:if test="${contract!=null}">											
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT color="red">修改附件上传时请将原来的附件删除</FONT>
											</c:if>
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>									
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
		<jsp:include page="uploanContractfile.jsp"></jsp:include>
	</BODY>
</HTML>
