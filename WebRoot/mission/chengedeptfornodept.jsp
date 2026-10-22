<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<base href="<%=basePath%>">

		<title>My JSP 'chengedeptment.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">


		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>Css/missionuse.css" />
			<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	
	function change1(value1){
	alert(value1);
	if(value1==7){
	document.getElementById("sel1").style.display="none";
	document.getElementById("sel2").style.display="none";
	document.getElementById("sel3").style.display="none";
	document.getElementById("sel4").style.display="block";
	}else if(value1==6){
	document.getElementById("sel1").style.display="block";
	document.getElementById("sel2").style.display="none";
	document.getElementById("sel3").style.display="none";
	document.getElementById("sel4").style.display="none";
	}
	else if(value1==5){
	document.getElementById("sel1").style.display="none";
	document.getElementById("sel2").style.display="block";
	document.getElementById("sel3").style.display="none";
	document.getElementById("sel4").style.display="none";
	}
	else{
	document.getElementById("sel1").style.display="none";
	document.getElementById("sel2").style.display="none";
	document.getElementById("sel3").style.display="block";
	document.getElementById("sel4").style.display="none";
	
	
	
	}
	
	}
	</script>
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<h3>
					临时部门人员管理 - 福奥科技
				</h3>
			</div>
			<table class="tb tb2 " id="tips">
				<tr>
					<th class="partition">
						技巧提示       
					</th>
					<th class="partition">
						<a  href="getallmissiontype.do" >返回部门信息列表</a>
					</th>
					
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
							<li>
								“临时部门人员管理 ”管理部门被删除后的没有部门的人员。
							</li>
							<li>
								选择相应的部门后，选择相应的人员。进行分配到指定部门
							</li>
							<li>
								选择要添加部门到那个级别。将下拉选择级别，显示出这个级别的部门
							</li>
						</ul>
					</td>
				</tr>
			</table>
			<form action="setpositionmissiontype" name="cpform" method="post"
				autocomplete="off" id="cpform">
				<input type="hidden" name="formhash" value="ff5905c1" />
				<input type="hidden" id="formscrolltop" name="scrolltop" value="" />
				<input type="hidden" name="anchor" value="" />
				<table class="tb tb2 fixpadding">
					<tr class="header">
						<th></th>
						<th>
							显示顺序
						</th><td width="100"></td>
						<th>
							当前用户
						</th>
						<th>
							所属部门
						</th>
						<th>
							由上级版块继承
						</th>
					</tr>
					<tr class="hover">
						<td class="td25">
							<input type="checkbox" class="checkbox" name="delete[]" value="1" />
						</td>
						<td class="td28">
							<input type="text" class="txt" name="displayordernew[1]"
								value="0" size="2" />
						</td>
						<td width="100"></td>
						<td>
							${emp.name }
						</td>
						<td>
							${emp.department.name }
						</td>
						<td>
							否
						</td>
					</tr>
					<c:set value="1" var="namenum"></c:set>
					 
						
						<tr class="hover">
							<td class="td25" >
							人员:
							</td>
							<td class="td28" >
								<select name="" id="sel" style="display: block">
									  <c:forEach items="${deptlist0 }" var="deptlist0">
										<option value="${deptlist0.id }">
											${deptlist0.name }
										</option>	
										</c:forEach>
								</select>
							</td>
							<td align="right">
							分配到部门:
							</td>
							<td width="200"><select name="" id="sel1" style="display: none">

									  <c:forEach items="${deptlist }" var="deptlist">
									    <c:if test="${deptlist.islevel==6}">
										<option value="${deptlist.id }">
											${deptlist.name }
										</option>	
										</c:if>
										</c:forEach>
								</select>
								<select name="" id="sel2" style="display:none" >
									  <c:forEach items="${deptlist }" var="deptlist1">
									  <c:if test="${deptlist1.islevel==5}">
									  
										<option value="${deptlist1.id }">
											${deptlist1.name}
										</option>	
										</c:if>
										</c:forEach>
								  </select>
									<select name="" id="sel3" style="display: none" >
									  <c:forEach items="${deptlist }" var="deptlist2">
									  <c:if test="${deptlist2.islevel==4}">
									  
										<option value="${deptlist2.id }">
											${deptlist2.name}
										</option>	
										</c:if>
										</c:forEach>
								   </select>
								   	<select name="" id="sel4" style="display: block" >
									  <c:forEach items="${deptlist }" var="deptlist3">
									  <c:if test="${deptlist3.islevel==7}">
									  
										<option value="${deptlist3.id }">
											${deptlist3.name}
										</option>	
										</c:if>
										</c:forEach>
								   </select>
								</td>
								
							<td>
							
								<select name="seljb" id="sel5" onchange="change1(this.value)">
								        <option value="7">
											第七级别
										</option>
										<option value="6">第六级别</option>
										<option value="5">第五级别</option>
										<option value="4">第四级别</option>
								</select>
							</td>
							<td></td>
						</tr>
					


				
				</table>
			<input type="button" class="btn" id="submit_modsubmit" name="modsubmit" onclick="submit1();"  value="分配" /> 
			</form>
	
		</div>
	<script type="text/javascript">
	function submit1(){
	var employeid=$("#sel").val();
	var depval;
	if($("#sel5").val()==7){
	depval=$("#sel4").val();
	}else if($("#sel5").val()==6){
	depval=$("#sel1").val();
	
	}else if($("#sel5").val()==5){
	
	depval=$("#sel2").val();
	
	}else if($("#sel5").val()==4){
	
	depval=$("#sel3").val();
	
	
	}
	 $.ajax({
           type:'post',
           url:'setemployyemissiontype.do',
           data:{employeeid:employeid,workpositionid:depval},
           success:function(res){
              location.reload();
           }
     });
	 
	}
	
	</script>
	
	</script>
	
	</body>
	
</html>
