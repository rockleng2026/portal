<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>动态列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<link href="<%=request.getContextPath() %>/Css/Ke_hu.css" type="text/css"  rel="stylesheet"/>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	
</script>
</head>
<body>
<h2 style="margin-top: 10px;">公司最新动态</h2>
     
	<form action="goMoreRecord.do" id="form1" method="post">
      	查询动态&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	当前登录用户可以查看的员工名：
      <SELECT id="empId" name="empId">
      	<option value="-1">所有</option>
		<c:forEach items="${empList }" var="emp">
			<option value="${emp.id }">${emp.name }</option>
		</c:forEach>
      </SELECT>&nbsp;&nbsp;
      	自定义查询关键字：
      <input type="text" id="select" name="select" />&nbsp;&nbsp;
      <input type="submit" value="查询"/>
    </form>
	
<hr/>
	<table>
	<tbody>
		<tr>
		<td>
			<c:if test="${empty pages.pageList}"><h3 align="center">无最新动态</h3><hr/> </c:if>
			<c:forEach items="${pages.pageList}" var="data">
			<div class="yuangongrenwu_line">
				<div class="yuangongrenwu_left_img">
					<a href="goDetailRecord.do?entityName=Employee&entityId=${data.employee.id }"><img border="0px;" src="../img/moren_tuoxiang.jpg" /></a>
				</div>
				<div class="yuangongrenwu_right">
					<div class="yuangongrenwu_right_idName">
						工号：${data.employee.empNo }  &nbsp; 姓名：${data.employee.name } :
						${data.executeTime } 
					</div>
					<div class="yuangongrenwu_right_leirong">
					    &nbsp;&nbsp;
					    <A href="goDetailRecord.do?id=${data.id }&entityName=${data.entityName}&entityId=${data.entityId }">${data.content }</A>
					</div>
				</div>
			</div>
			<hr/>
			</c:forEach>
		</td>
		</tr>
		<TR>
			<TD>
				<p:pages url="goMoreRecord.do"/>
			</TD>
		</TR>
	</TBODY>
	</TABLE>		
</body>
</HTML>
