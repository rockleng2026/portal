<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar" %>
<%@page import="java.util.Date"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
	<%@ taglib uri="/struts-tags" prefix="s" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ page import="com.fuao.fajxc.util.Cookies" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK"> 
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		
		<script type="text/javascript">
		//显示转接部门
		function divdisplay()
		{
			$("#zhuanjie").show();
			$("#bzdiv").hide();
		}
		//显示本部门处理
		function divdisplay2(str)
		{
		
			$("#clwc"+str+"").show();
			$('.tarea'+str+'').removeAttr("readonly");
			$("#bzdiv").hide();
		}
		
		
		//显示问题退回
		function divdisplay3(str)
		{
			$('.tarea'+str+'').removeAttr("readonly");
			$("#bzdiv").hide();
			$("#tuihui").show();
		}
		
		//已转部门退回
		function divdisplay4(str)
		{
			$('.tarea'+str+'').removeAttr("readonly");
			$("#bmcl").hide();
			$("#bmth").show();
		}
		//已转部门处理
		function divdisplay5(str)
		{
			$('.tarea'+str+'').removeAttr("readonly");
			$("#bmcl").hide();
			$("#clwc"+str+"").show();
		}
		//转接部门处理
		function divdisplay6(str)
		{
			$('.tareas'+str+'').removeAttr("readonly");
			$("#bmcl").hide();
			$("#clwcs"+str+"").show();
		}
		
		//已转部门退回
		function divdisplay7(str)
		{
			$('.tareas'+str+'').removeAttr("readonly");
			$("#bmcl").hide();
			$("#bmth").show();
		}
		//转接
		function dis1()
		{
			$("#zjzj").hide();
			$("#zjgkh").hide();
			$("#zjaa").show();
		}
		
		//转交客户
		function dis2()
		{
			$("#zjzj").hide();
			$("#zjgkh").show();
			$("#zjaa").hide();
		}
		function empazj2(){
		$("#selemp").html("");
		$("#selemp").html("<option value='-1' style='width: 100px'>请选择</option>");
		var operid=$("#seldep").val();
		$.ajax({
           type:'post',
           url:'getOperationzjmissiontype.do',
           data:{operid:operid},
           success:function(data){
               $("#selemp").append(data);
           }
        });
		}
		
		function empzj1(){
		$("#selemp").html("<option value='-1' style='width: 100px'>请选择</option>");
		$("#seldep").html("");
		$("#seldep").html("<option value='-1' style='width: 100px'>请选择</option>");
		var did=$("#empzj").val();
		$.ajax({
           type:'post',
           url:'getOperationzj2MalfunctionDeclare.do',
           data:{did:did},
           success:function(data){
               $("#seldep").append(data);
           }
        });
		
		}
		
</script>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM name=form1 action="" method="post" onsubmit="return addValidators()" >
		
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
											&nbsp;故障转接
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
										<TD width="10%" height=30 align=right>
											故障单号:
										</TD>
										<TD width="25%" class=category>
											${empDetial.conkOutNo }
										</TD>
										<TD width="10%" height=30 align=right>
											客户名称：
										</TD>
										<TD width="55%" class=category>
											${empDetial.customer.customerName}
										</TD>
									</TR>
									<TR>
										<TD width="15%" height=30 align=right>
											客户电话：
										</TD>
										<TD width="35%" class=category>
											${empDetial.customerphone }
										</TD>
										<TD width="15%" height=30 align=right>
											网站域名：
										</TD>
										<TD width="35%" class=category>
											${empDetial.wdnr}
										</TD>
									</TR>
									<TR>
									<TD align=right width="15%" height=30>
											产品名称：
										</TD>
										<TD width="35%" class=category>
											${empDetial.product.property.model.name }
										</TD>
										<TD align=right width="15%" height=30>
											故障类型：
										</TD>
										<TD width="35%" class=category>
										${empDetial.issueType.questionName }
										</TD>
										
									</TR>
									<TR>
									<TD align=right width="15%" height=30>
											E-mail：
										</TD>
										<TD width="35%" class=category>
											${empDetial.email }
										</TD>
										<TD align=right width="15%" height=30>
											IP：
										</TD>
										<TD width="35%" class=category>
										${empDetial.ip }
										</TD>
										
									</TR>
									<TR>
									<TD align=right width="15%" height=30>
											故障处理状态：
										</TD>
										<TD width="35%" class=category>
											<c:if test="${empDetial.state ==0}">未处理</c:if>
											<c:if test="${empDetial.state ==1}">客服已接收</c:if>
											<c:if test="${empDetial.state ==2}">${empDetial.employee.department.name }${empDetial.employee.name}处理中</c:if>
											<c:if test="${empDetial.state ==3}">${empDetial.employee.department.name }${empDetial.employee.name}处理完成</c:if>
											<c:if test="${empDetial.state ==4}">已处理</c:if>
											<c:if test="${empDetial.state ==7}">${empDetial.employee.department.name }${empDetial.employee.name}已接收</c:if>
											<c:if test="${empDetial.state =='-1'}">退回故障单</c:if>
											<c:if test="${empDetial.state ==5}">已评价</c:if>
										</TD>
										<TD align=right width="15%" height=30>
											产品类型：
										</TD>
										<TD width="35%" class=category>
											${empDetial.proudcotType.questionName }
										</TD>
										
									</TR>
								
									<TR>
										
									<TD width="25%"  height=30 align=right>
										客户评价:
										</TD>
								     <TD width="25%" class="category">
										<c:if test="${empDetial.appraise == 1 }"><span style='color:#009F00'>满意</span></c:if>
									    <c:if test="${empDetial.appraise == 2 }"><span style='color:#009F00'>一般</span></c:if>
									    <c:if test="${empDetial.appraise == 3 }"><span style='color:#009F00'>不满意</span></c:if>
									</TD>
									<TD width="25%" align="right"  height=30>
										客户意见与建议：
										</TD>
								     <TD width="25%" align="left" class=category>
										${empDetial.leavess }
									</TD>
									</TR>
									<TR>
										<TD width="25%" align="right"  height=30>
										回送客户时间：
										</TD>
								     <TD width="25%" align="left" class=category>
										${empDetial.endTim }
									</TD>
									<TD width="25%"  height=30  align="right">
										接收时间：
										</TD>
								     <TD width="25%" class="category" align="left">
									   ${empDetial.receiveTime}
									</TD>
									</TR>
									<%int i=-1; int j=0; %>
									<c:forEach items="${empDetial.conkoutAsks}" var="data1" varStatus="status">
									<!-- 获得未解决id -->
									<c:if test="${empty data1.parentId || data1.parentId==0}">
									<c:if test="${data1.state==0 }">
									<c:set var="parentid" value="${data1.id}" scope="request"></c:set>
									</c:if>
									<% i++;%>
									<TR>
									<TD align=right width="15%" height=40>
											用户描述：
										</TD>
										<TD width="25%" class=category>
											<label>${data1.descs }</label> 
											<br/>提问时间：${data1.faultTime }
										</TD>
										
										<TD align=right width="15%" height=40>
											处理描述
										</TD>
										<TD width="45%" class=category>
										处理描述：
										<%
												   Cookies ck = new Cookies();
												   String depid =ck.getCookie(request, "departmentId");
												   String empid=ck.getCookie(request,"employeeId");
												 %>
											<input type="hidden" value="<%=depid %>" id="dep" >
											<input type="hidden" value="<%=empid %>" id="emp" >
											
											
											
										<c:if test="${empty data1.solveDepict }">
											<textarea class="tarea<%=i %>" id="handleDetail<%=i %>"  rows="4" cols="40" <c:if test="${empDetial.state==0 ||empDetial.state==1 || empDetial.state==2 || empDetial.state==7}"> readonly="readonly" </c:if>>${data1.solveDepict }</textarea>
											
											<div id="clwc<%=i %>" <c:if test="${empDetial.state==1 || empDetial.state==0 || empDetial.state==2 || empDetial.state==7}"> style='display:none' </c:if>>
										    <c:if test="${ empty data1.resolveTime && not empty data1.inceptTime }">
										    <input class="button" style="height: 25px;width: 60px;" value="处理完成" type="button" onclick="changeover('${empDetial.conkOutNo}',3,'changeoverMalfunctionDeclare.do','selectMalfunctionDeclare.do?tag=0',<%=i %>)"/></c:if>
										    </div>
										<br/>
										
									   	 </c:if>
									   	 <c:if test="${not empty data1.solveDepict}">
									   	 <label style="color: red">${data1.solveDepict }</label><br/>
									   	 接收人：${data1.employeeByEmpTakeId.department.name }${data1.employeeByEmpTakeId.name } &nbsp;&nbsp;&nbsp;<br/>
									   	 接收时间 ${data1.inceptTime }<br/>
									   	 处理人：${data1.employeeByEmpId.department.name }${data1.employeeByEmpId.name}<br/>
									   	 处理时间：${data1.resolveTime }<br/> 
									   	 </c:if>
									   
									   
									   
									   	 <c:forEach items="${empDetial.conkoutAsks}" var="data2" varStatus="status2">
									   	 <c:if test="${data2.parentId==data1.id && data2.isMain!=2}">
									 <hr/>
									   	<c:choose>
									   	  <c:when test="${ empty data2.resolveTime && not empty data2.corrincomTime }">
									   	  <textarea class="tareas<%=j %>" id="detial<%=j %>"  rows="4" cols="40" <c:if test="${empDetial.state==0 ||empDetial.state==1 || empDetial.state==2 || empDetial.state==7}">readonly="readonly"</c:if>>${data2.solveDepict }</textarea>
									   	 <div id="clwcs<%=j %>" <c:if test="${empDetial.state==1 || empDetial.state==0 || empDetial.state==2 || empDetial.state==7}">style='display:none'</c:if>>
										    <input class="button" style="height: 25px;width: 60px;" value="处理完成s" type="button" onclick="handde('${empDetial.conkOutNo}',3,'changeoverMalfunctionDeclare.do','selectMalfunctionDeclare.do?tag=0',<%=j %>)"/>
										     <br/>处理人：${data2.employeeByEmpId.name }
										    <%j++; %>
										   </c:when>
										   <c:otherwise>
										   <c:if test="${not empty data2.solveDepict }">
										   处理描述：<label style="color: red">${data2.solveDepict }</label>
										   <br/>
										    接收人：${data2.employeeByEmpId.department.name }${data2.employeeByEmpId.name } &nbsp;&nbsp;&nbsp;<br/>
									   	 接收时间 ${data2.corrincomTime }<br/>
									   	 处理人：${data2.employeeByEmpId.department.name }${data2.employeeByEmpId.name}<br/>
									   	 处理时间：${data2.resolveTime }<br/> 
										   </c:if>
										   </c:otherwise>
										    </c:choose>
									   	 </div>
									   	<br/>
									   	 </c:if>
									   	 <c:if test="${data2.isMain==2}">
									   	 <c:set value="${data2.solveDepict}" var="solve" scope="request"></c:set>
									   	 </c:if>
									   	 </c:forEach>
										</TD>
										
									</TR>
									
									</c:if>
										</c:forEach>
			
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
	
			<TABLE border="0" style="margin: 22px;">
			<%
			   request.setAttribute("mark",request.getParameter("mark"));
			 %>
		
			<TR>
			<TD align="center">
				<c:if test="${empDetial.state==0 && mark==8}">
				<input type="button" value="接收" style="height: 25px;width: 50px;"  onclick="changeover('${empDetial.conkOutNo}',1,'changeoverMalfunctionDeclare.do','detailMalfunctionDeclare.do?id=${empDetial.id }&mark=<%=request.getParameter("mark") %>')">
				</c:if>
				<c:if test="${empDetial.state==1 && mark==8}">
				<div id="bzdiv">
				<input type="button" value="本部门处理" onclick="divdisplay2(<%=i %>),getflag(1);"/>
				<input type="button" value="转接运维部处理" onclick="divdisplay(),getflag(2);"/>
				<input type="button" value="工单存在问题，需退回" onclick="divdisplay3(<%=i %>)"/>

				</div>
				</c:if>
				<div id="zjaa" style="display: none">
				<c:if test="${empDetial.state==3}">
			<s:select onchange="handemp('seldep','getdeptEmpDepartment.do')" list="%{#request.departmentList}" name="seldep" id="seldep"  listKey="id" listValue="name" cssClass="category" headerKey="" headerValue="请选择" value="%{-1}"></s:select>&nbsp;&nbsp;&nbsp;
			<select id="selemp">
			<option value="">请选择</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="button" style="height: 25px;width: 50px;" value="转接" type="button" onclick="nextdep('${empDetial.id }','${empDetial.conkOutNo}',2,'nextdepMalfunctionDeclare.do','commutatorMalfunctionDeclare.do',${parentid })"/>
			</c:if>
			</div>
			</TD>
			<TD align="left">
			<div id="zhuanjie" style="display: none">
			<c:if test="${empDetial.state==1 }">
			<select id="empzj"  onchange="empzj1();" >
			<option value="-1" style="width: 100px">请选择</option>
			<c:forEach items="${departmentList2}" var="data">
			<option value="${data.id }" style="width: 100px">${data.name }</option>
			</c:forEach>
			</select>
			<select id="seldep" name="depaid" onchange="empazj2();">
			<option value="-1" style="width: 100px">请选择</option>
			</select>
			<select id="selemp" name="emplid">
			<option value="-1" style="width: 100px">请选择</option>
			</select>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="button" style="height: 25px;width: 50px;" value="转接" type="button" onclick="changeover('${empDetial.conkOutNo}',2,'changeover2MalfunctionDeclare.do','commutatorMalfunctionDeclare.do')"/>
			</c:if>
			</div>
			
			
			
			<div id="tuihui" style="display:none">
			<input type="button" value="退回h" onclick="changeover('${empDetial.conkOutNo}',-1,'changeoverMalfunctionDeclare.do','commutatorMalfunctionDeclare.do',<%=i %>)"/>
			</div>
			
			<div>
			<c:if test="${empDetial.state==2 && mark==9}">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="接收" style="height: 25px;width: 50px;"  onclick="changeover('${empDetial.conkOutNo}',7,'changeoverMalfunctionDeclare.do','detailMalfunctionDeclare.do?id=${empDetial.id }&mark=<%=request.getParameter("mark") %>')">
			</c:if>
			</div>
			<c:if test="${empDetial.state==7&&mark==9}">
			<div id="bmcl">
			<% if(j==0){ %>
			<input type="button" value="本部门处理a" onclick="divdisplay5(<%=i %>)"/>
			<input type="button" value="工单存在问题，需退回a" onclick="divdisplay4(<%=i %>)"/>
			<% }else{ %>
			<input type="button" value="本部门处理s" onclick="divdisplay6(<%=j-1 %>)"/>
			<input type="button" value="工单存在问题，需退回s" onclick="divdisplay7(<%=j-1 %>)"/>
			<% } %>
			
			</div>
			<div id="bmth" style="display:none">
			<% if(j==0){ %>
			<input type="button" value="退回" onclick="changeover('${empDetial.conkOutNo}',-1,'changeoverMalfunctionDeclare.do','selectMalfunctionDeclare.do?tag=0',<%=i %>)"/>
			<%}else{ %>
			<input type="button" value="退回s" onclick="goback('${empDetial.conkOutNo}',-1,'changeoverMalfunctionDeclare.do','selectMalfunctionDeclare.do?tag=0',<%=j-1 %>)"/>
			<%} %>
			</div>
			</c:if>
			</TD>
			<td align="center"><c:if test="${empDetial.state==3&&mark!=9}">
			<div id="zjgkh" style="display: none">
			<input class="button" style="height: 25px;width: 60px;" value="转交客户" type="button" onclick="changeover('${empDetial.conkOutNo}',4,'changeoverMalfunctionDeclare.do','commutatorMalfunctionDeclare.do','',${parentid},${empDetial.id})"/>
			<br/><textarea id="kefudetail"  rows="4" cols="40" >${data2.solveDepict }</textarea>
			</c:if>
			</div>
			<div id="zjzj">
			<c:if test="${empDetial.state==3 && mark==8}">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input value="转接" type="button" onclick="dis1()" />
			&nbsp;&nbsp;
			<input value="转交客户" type="button" onclick="dis2()"/>
			</c:if>
			</div>
			<c:if test="${mark==10}">
			客服回复：<textarea  rows="4" cols="40" readonly="readonly">${solve }</textarea>
			</c:if>
			</td>
			</TR>
			</TABLE>
		</FORM>
<div id="dialog" title="错误信息提示">
       <p></p>
</div>
	</BODY>
</HTML>
