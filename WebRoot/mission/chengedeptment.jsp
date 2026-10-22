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
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">


		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>Css/missionuse.css" />
		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<h3>
					${deptname }----岗位人员管理
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
								“岗位设置”得到此部门下的人员信息，得到此部门拥有的职位信息，然后对这个人员进行职位管理
							</li>
							<li>
								如果想增加新的职位，请返回上页面进行增加职位，在对人员进行岗位设置
							</li>
							<li>
								添加人员功能。将下拉显示出没有部门的员工，可以把员工分配到这个部门
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
				<table class="tb tb2 fixpadding" border="0">
					<Tr class="header">

						<tr>
							<td colspan="4">
								<font size="+1"><b>对岗位设置人员</b>
								</font>
							</td>
						</tr>
						<tr>

							<th width="35%" align="right">
							
							
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;选择岗位(岗位类型)
							</th>
							<th width="25%">
								选择部门人员
							</th>
							<th width="40%">
								操作(<a class="faq"href="javascript:showdiv1()">添加新岗位人员</a>)
							</th>

						</tr>

						<c:set value="1" var="namenum"></c:set>


						<tr id="t1" >
							<div id="d1" style="display: block">
							<td width="35%">
								
						  &nbsp;&nbsp;	  &nbsp;&nbsp;	  &nbsp;&nbsp;	  &nbsp;&nbsp;
									<select name="${employee.id }" id="sel" style="width: 180"
									onchange="selchange();">
									<option value="0">
										-------
									</option>
									<c:forEach items="${workposition }" var="workposition">
										<option value="${workposition.id }">
											${workposition.name }<c:if test="${workposition.ispersonman==1}">（主管)</c:if><c:if test="${workposition.ispersonman!=1}">（主岗)</c:if>
										</option>
									</c:forEach>
								</select>
							</td>

							<td width="25%">
							
								<select name="${employee.id }" id="sel1" style="width: 80" onchange="changeempid()">
									<option value="0">
										-------
									</option>
									<c:forEach items="${employeelist }" var="employeelist">
										<option value="${employeelist.id }">
											${employeelist.name }
										</option>
									</c:forEach>
								</select>
							</td>
							<td width="40%">
								<input type="button" class="btn" id="submit_modsubmit"
									name="modsubmit" onclick=
	submit1();;
value="提交" />
							</td>
								</div>
							</tR>
						
							<Tr id="t2" style="display: none">
							<div id="d2" style="display: none">
							
							<td width="25%">
								<input type="text" class="txt" id="empno" value="" readonly="readonly" width="150" />
							</td>

							<td width="25%">
							<input type="hidden" value="" id="empid"/>
						  <input type="text" class="txt" id="empname" value="" readonly="readonly" width="150" />
							</td>

							<td width="25%">
							<input type="hidden" value="" id="deptid"/>
							<input type="hidden" value="" id="workpositionid"/>
							<input type="text" class="txt" id="workposition" readonly="readonly" value="" width="150" />
								<select  id="seltwo" style="width: 160" onchange="seltwo1()">
									<option value="0">
										-------
									</option>
									<c:forEach items="${workposition }" var="workposition1">
										<option value="${workposition1.id }">
											${workposition1.name }
										</option>
									</c:forEach>
								</select>
							</td>
							<td width="25%" align="left">
								<input type="button" class="btn" id="submit_modsubmit"
									name="modsubmit" onclick=submit2();;
value="修改" /><input type="button" class="btn" id="submit_modsubmit"
									name="modsubmit" onclick=
	submit3();;
value="删除" />
							</td>
							</div>
						</tr>

						<tr>
							<td colspan="4">
								<font size="+1"><b>部门岗位人员列表</b>
								</font>
							</td>
						</tr>
						<tr align="center">



							<th width="25%" align="center">
								部门岗位
							</th>
							<th align="center" width="75%" colspan="3">
								&nbsp;&nbsp;&nbsp;&nbsp;部门人员(点击人名超链接进行编辑)
							</th>

						</tr>
						<c:forEach items="${workposition }" var="workposition">


							<c:forEach items="${dlist3}" var="dlist3">


								<c:if test="${workposition.id==dlist3.workposition.id}">

									<c:if test="${num1!=workposition.id}">
										<c:set value="${workposition.id}" var="num1"></c:set>
										<tr align="center">



											<th width="25%" align="center">
												${workposition.name }<c:if test="${dlist3.workposition.ispersonman==1}">(主管职位)</c:if>
											</th>
											<th width="75%" colspan="3" align="center">
												<c:forEach items="${dlist4}" var="dlist41">
													<c:if
														test="${dlist3.workposition.id==dlist41.workposition.id}">
														<a class="faq"
															href="javascript:showdiv('${dlist41.employee.name}',${dlist41.employee.id},${dlist41.employee.empNo},'${dlist41.workposition.name}',${dlist41.workposition.id},${dlist41.id},${dlist41.workposition.ispersonman})">${dlist41.employee.name}<c:if test="${dlist41.positiontype==1}">(主岗)</c:if><c:if test="${dlist41.positiontype==2}">(分岗)</c:if><c:if test="${dlist41.positiontype==3}">(分管)</c:if><c:if test="${dlist41.positiontype==4}">(主管)</c:if></a>
													</c:if>
												</c:forEach>
												<input type="hidden" value="" id="positiontype"/>
											</th>

										</tr>
										<Tr>
											<td colspan="4"></td>
										</Tr>
									</c:if>
								</c:if>
							</c:forEach>
						</c:forEach>
				</table>
				
			</form>
		</div>
	</body>


	<script type="text/javascript">
	function  changeempid(){
	
	var a=$("#sel1").val();
	document.getElementById("empid").value=a;
	
	}
	function  changeworkid(){
	var a1=$("#sel").val();
	document.getElementById("workpositionid").value=a1;}
	
	function showdiv(empname,empid,empNo,deptname,deptid,empwopostionid,a) {
	  $("#positiontype").val(a);
	 document.getElementById("empid").value=empid;
	 	 document.getElementById("deptid").value=empid;
	  document.getElementById("empno").value=empNo;
	  document.getElementById("empname").value=empname;
	  document.getElementById("workposition").value=deptname;
	   document.getElementById("workpositionid").value=empwopostionid;
	  document.getElementById("t1").style.display="none";
  document.getElementById("t2").style.display="block";
		
	}
	function seltwo1(){
	var a=$("#seltwo").find("option:selected").text();
	var x=$("#seltwo").val();
	document.getElementById("deptid").value=x;
	document.getElementById("workposition").value=a;
	}
	 function showdiv1(){
	 
	   document.getElementById("t2").style.display="none";
  document.getElementById("t1").style.display="block";
	 
	 }
	function selchange() {

		document.getElementById("sel1").style.display = "block";
		$("#sel1").change(function() {
			document.getElementById("input1").value = $("#sel1").val();
		});

	}
	function submit1() {
		var val0 = $("#zwlx").val();
		var val = $("#sel1").val();
		var val1 = $("#sel").val();
		$.ajax( {
			type : 'post',
			url : 'changeworkpositionmissiontype.do',
			data : {
				employeeid : val,
				workpositionid : val1,
				value1:val0
			},
			success : function(res) {
			    if(res=="false"){
			     alert("该员工已存在该职位,请不要重复添加！");
			    }else if(res=="false1"){
			    
			      alert("主管岗位已有人员请删除后添加");
			    location.reload();
			    }else if(res=="false3"){
			    alert("此岗位为主管岗位，请选择主管岗位类型");
			
			    }else if(res=="false2"){
			    alert("此人员已有主岗，请不要重复添加");
			 
			    }else if(res=="false4"){
			    alert("此岗位不是主管岗位，请选择非主管类型");
			 
			    }
				location.reload();
			}
		});
	}
		function submit2() {
		 var a=$("#positiontype").val();
		var val = $("#empid").val();
		var val1 = $("#deptid").val();
		var val2 = $("#workpositionid").val();
		$.ajax( {
			type : 'post',
			url : 'editworkpositionmissiontype.do',
			data : {
				employeeid : val,
				workpositionid : val1,
				workpositionempid:val2,
				workid:a
			},
			success : function(res) {
			 if(res=="false"){
			     alert("该员工已存在该职位,请不要重复添加！");
			    }else if(res=="false1"){
			    
			      alert("主管岗位已有人员请删除后添加");
			    location.reload();
			    }
				location.reload();
			}
		});
	}
	function submit3() {
	    if(confirm("确定要卸除这个人的岗位吗？")==true){
		var val = $("#empid").val();
		var val1 = $("#deptid").val();
		var val2 = $("#workpositionid").val();
		$.ajax( {
			type : 'post',
			url : 'delworkpositionmissiontype.do',
			data : {
				employeeid : val,
				workpositionid : val1,
				workpositionempid:val2
			},
			success : function(res) {
			 
				location.reload();
			}
		});
		}
	}
</script>
</html>

