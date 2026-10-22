<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>DWR测试</title>
        <script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/DwrDept.js"></script> 
        <script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script> 	
        <script type="text/javascript" src="dwr/util.js"></script> 
        <script type="text/javascript">
			function changeDEPT(obj,value){
				var val=obj.value;
				if(val.length>0){
					DwrDept.getEmpByDeptid(value,changeEmpdata);
				}else{
					var str="<select name=\"emp\" ><option value=\"\">--所有--</option></select>";
					document.getElementById("empSelect").innerHTML=str;
				}		
			}
			function changeEmpdata(data){
				document.getElementById("empSelect").innerHTML=data;
			}
        </script>	
</head>
<body>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD align=right height=30>
							业务负责人：
						</TD>
						<TD class=category>
							 	部门：
							 	<select id="deptSelect" name="deptSelect" onchange="changeDEPT(this,this.value)">
							 	   <c:forEach var="dept" items="${department}">
							 	       <option value="${dept.id}">${dept.name}</option>
							 	   </c:forEach>							 	    
							 	</select>
								员工 :
								<span id="empSelect">
									 <select id="es" name="emp" >
									   <option value="-1">--所有--</option>
									 </select>								     
								</span>
								<FONT id="cardid1" color=#ff0000>*</FONT>	
						</TD>
					</TR>
				</TBODY>
			</TABLE>
</body>
</html>