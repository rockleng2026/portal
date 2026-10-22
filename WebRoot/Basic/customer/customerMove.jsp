<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<jsp:include page="/Basic/alldeptEmp.jsp"></jsp:include>
<title>客户交接记录信息表</title>
</head>
<STYLE>
</STYLE>
	<SCRIPT language=javascript>
		// 判断员工是否存在
		function opinionEmpBeing(name)
		{	
			var id=document.getElementById(name).value;
			//var id= $("#"+name).val(); 
			 var url="beingemp.do";
		     if(1==1)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		             	 alert("您输入的员工编号员工存在");
		             }else
		             {
		             	 alert("您输入的员工编号员工不存在");
		             }
		        }
		        );
		     }
		}
function check(){
	var empid1 = $("#empSelect").val();
	var empid2 = $("#oldemp").val();
	var date = $("#date").val();
	if(empid2 == null || empid2 == ''){
		alert("登陆错误！请刷新后重试!");
		return false;
	}
	if(empid1 == null || empid1 == ''){
		alert("请选择接手的员工");
		return false;
	}
	if(date == null || date == ''){
		alert("请选择转交日期");
		return false;
	}
	return true;
}
</SCRIPT>		

<body>
	<FORM name="customerform" action="addCustomerMove.do" method="post" onsubmit="return check()">
			<c:if test="${isShow != 1}">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD>
											&nbsp;添加客户交接资料(带*号的为必填项)
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
							<input type="hidden" name="customer.customerId" id="customer.customerId"  value="${param.customerId}">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>										
									<TR>
										<TD width="25%" height=30 align=right>
											现有负责人员工ID：
										</TD>
										<TD width="75%" class=category>
										         <input type="hidden" name="employeeByOldPrincipal.id" id="oldemp" value="${param.customerId}" />
												部门：<select id="deptSelect" name="deptSelect" onchange="getemp()"></select>
          										员工 :<select id="empSelect" name="employeeByNewPrincipal.id" ></select>		
											&nbsp;
											<FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											交接日期：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" name="movetime" id="date" onfocus="WdatePicker()" onblur="checkValueByRules('date','','date1') ">
											&nbsp;
											<FONT color=#ff0000 id="date1">*</FONT>
										</TD>
									</TR>																		
									<TR>
									<TD width="25%" height=30 align=right>
											交接原因内容：
										</TD>
										<TD width="75%" class=category>
											
											<FCK:editor width="700px;"   inputName="moveCause" instanceName="moveCause" height="300px;">
														<jsp:attribute name="value"></jsp:attribute>
											</FCK:editor> 
											&nbsp;
											<FONT color=#ff0000 id="moveCause1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=submit value="确认提交 ">
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
			</c:if>
			<c:if test="${isShow == 1}">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD>
											&nbsp;查看客户交接信息
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
							<input type="hidden" name="customer.customerId" id="customer.customerId"  value="${param.customerId}">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>										
									<TR>
										<TD width="25%" height=30 align=right>
											客户名称：
										</TD>
										<TD width="75%" class=category>
										        ${data.customer.customerName }
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											公司名称：
										</TD>
										<TD width="75%" class=category>
										        ${data.customer.customerCompany }
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											上个负责的员工ID：
										</TD>
										<TD width="75%" class=category>
										        ${data.employeeByOldPrincipal.name}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											现在负责人员工ID：
										</TD>
										<TD width="75%" class=category>
										        ${data.employeeByNewPrincipal.name}
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											交接日期：
										</TD>
										<TD width="75%" class=category>
											${data.movetime }
										</TD>
									</TR>																		
									<TR>
									<TD width="25%" height=30 align=right>
											交接原因内容：
										</TD>
										<TD width="75%" class=category>
											<div>${data.moveCause }</div>
											
										</TD>
									</TR>	
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=button onclick="javascript:history.go(-1)" value="返回 ">
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
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</c:if>
		</FORM>
</body>
</html>