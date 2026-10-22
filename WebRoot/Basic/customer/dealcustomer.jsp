<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Insert title here</title>
		<script type="text/javascript" src="images/date2.js" charset="utf-8"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>	
<title>客户分配</title>
</head>
<script type="text/javascript">
function setemp(){
	var emp= $("#empSelect").val();
	$("#vendition").attr("value")=emp;
}
function dealcustomer(){
    
	var id = $("#customerId").val();
	var empid = $("#empSelect").val();
	var customerType2 = $("#customerType2").val();
	var customerType = $("#customerType").val();
	
	if(customerType2 == null || customerType2 == ""){
		alert("请选择客户类型!");
		return false;
	}
	if(empid == null || empid == ""){
		alert("请先分配员工");
		return false;
	}
	var url = "dealCustomer.do?tt="+(new Date()).getTime();
	$.post(url,{id:id,empid:empid,customerType:customerType,customerType2:customerType2},
	function(data){
	  if(data == 0){
	     alert("分配成功");
	     window.location.href="customerListSystem.do";
	  }else{
	  	alert("未知错误!");
	  	return false;
	  }
	});
}
</script>
<body>
			<FORM name="customerform" action="
			<c:if test="${data.customerId !=null}">
			dealCustomer.do
			</c:if>
			" method="post" onsubmit="return addValidators()">
			<input type="hidden" name="del" value="0"/>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;分配客户资料
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<input type="hidden" name="customerId" id="customerId"  value="${data.customerId}">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											客户姓名：
										</TD>
										<TD width="75%" class=category>
										<input type="hidden" name ="customerName" id="customerName" value="${data.customerName }">
											<INPUT style="WIDTH: 200px" name="realName" id="realName" value="${data.realName}">
											&nbsp;
											<FONT id="customerName1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											租用类别：
										</TD>
										<TD class=category>
											<select name="customerType" id="customerType" value="${data.customerType}">											
											<option value="租用" <c:if test="${data.customerType=='租用'}">selected</c:if>>租用</option>
											<option value="托管" <c:if test="${data.customerType=='托管'}">selected</c:if>>托管</option>
											<option value="百独" <c:if test="${data.customerType=='百独'}">selected</c:if>>百独</option>
											<option value="CDN" <c:if test="${data.customerType=='CDN'}">selected</c:if>>百共</option>
											<option value="网站建设" <c:if test="${data.customerType=='网站建设'}">selected</c:if>>百共</option>
											<option value="VPS" <c:if test="${data.customerType=='VPS'}">selected</c:if>>百共</option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户类型：<FONT id="customerName1" color=#ff0000>*</FONT>
										</TD>
										<TD class=category>
										 <input type="radio" id="customerType2" name="customerType2" value="1" <c:if test="${data.customerType2=='1'}">checked="checked"</c:if>>意向客户
										 <input type="radio" id="customerType2" name="customerType2" value="2" <c:if test="${data.customerType2=='2'}">checked="checked"</c:if>>试用客户
										 <input type="radio" id="customerType2" name="customerType2" value="3" <c:if test="${data.customerType2=='3'}">checked="checked"</c:if>>正式客户
										 <input type="radio" id="customerType2" name="customerType2" value="4" <c:if test="${data.customerType2=='4'}">checked="checked"</c:if>>审核客户
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											业务负责人：<FONT id="customerName1" color=#ff0000>*</FONT>
										</TD>
										<TD class=category>
										        
											 	部门：
											 	         <select id="deptSelect" name="deptSelect" onchange="getemp()">
											 	            <option value="${dept.id }">${dept.name }</option>
											 	         </select>
          										员工 :<select id="empSelect" name="employee.id" value="${data.employee.id}" >
          										<c:if test="${data!=null}"><option value="${data.employee.id}">${data.employee.name }</option></c:if>
          										</select>	
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户身份证号：
										</TD>
										<TD class=category>
											<input type="text" name="cardid" id="cardid" value="${data.cardid}">
											&nbsp;
											<FONT id="cardid1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户公司名称：
										</TD>
										<TD class=category>
											<input type="text" name="customerCompany" id="customerCompany" value="${data.customerCompany}">
											&nbsp;
											<FONT id="customerCompany1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户地址：
										</TD>
										<TD class=category>
											<input type="text" name="customerAddress" id="customerAddress" value="${data.customerAddress}">
											&nbsp;
											<FONT id="customerAddress1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户电话:
										</TD>
										<TD class=category>
											<input type="text" name="phone" id="phone"  value="${data.phone}">
											&nbsp;
											<FONT id="phone1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户手机:
										</TD>
										<TD class=category>
											<input type="text" name="mobilePhone" id="mobilePhone" value="${data.mobilePhone}">
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户邮箱:
										</TD>
										<TD class=category>
											<input type="text" name="email" id="email" value="${data.email}"  >
											&nbsp;
											<FONT id="email1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户邮编:
										</TD>
										<TD class=category>
											<input type="text" name="zipCode" id="zipCode" value="${data.zipCode}">
											&nbsp;
											<FONT id="zipCode1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											建立客户日期:
										</TD>
										<TD class=category>
											<input type="text" name="date" id="date" value="${data.date}" onfocus="WdatePicker()" >
											&nbsp;
											<FONT id="date1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户传真:
										</TD>
										<TD class=category>
											<input type="text" name="facsimile" id="facsimile" value="${data.facsimile}" >
											&nbsp;
											<FONT id="facsimile1" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											客户QQ:
										</TD>
										<TD class=category>
											<input type="text" name="qq" id="qq" value="${data.qq}">
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=button onclick="dealcustomer()" value="确认分配">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT type=hidden value=ok name=hid1>
											<INPUT type=hidden value=58 name=id>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
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
</html>