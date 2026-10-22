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
		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	</head>
	<body>
		<c:forEach items="${list1 }" var="list1">
			<div id="append_parent"></div>
			<div id="ajaxwaitid"></div>
			<div class="container" id="cpcontainer">
				<div class="itemtitle">
					<h3>
						编辑岗位 - 员工(${list1.name})岗位管理
					</h3>
				</div>
				<table class="tb tb2 " id="tips">
					<tr>
						<th class="partition">
							技巧提示
						</th>
					</tr>
					<tr>
						<td class="tipsblock" s="1">
							<ul id="tipslis">
								<li>
									“岗位设置”得到先选择岗位类型，然后得到部门， 得到此部门拥有的职位，然后对这个人员进行职位管理
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

							<th width="25%" align="right">
								员工名称
							</th>
							<th>
								所属部门
							</th>
							<th>
								所属职位
							</th>
							<th>
								岗位类型
							</th>
							<td width="100">
								操作
							</td>
						</tr>
						<c:forEach items="${list3 }" var="list3">
							<c:if test="${list3.employee.id==list1.id}">
								<tr class="hover">
									<td class="td25" align="right">
										${list3.employee.name }
									</td>
									<td class="td28">
										${list3.workposition.department.name}
									</td>

									<td>
										${list3.workposition.name}
									</td>
									<td>
									<c:if test="${list3.positiontype==1}">
										主岗
									</c:if>
									<c:if test="${list3.positiontype==2}">
										分岗
									</c:if>
									<c:if test="${list3.positiontype==3}">
										分管
									</c:if>

									</td>
									<td width="100">
										    <a class="faq" href="javascript:showdiv(${list3.workposition.id},'${list3.workposition.name}','${list3.workposition.department.name}',${list3.workposition.department.id
										},${list3.id})">修改 </a>   <a class="faq" href="javascript:submit3(${list3.id})">删除 </a> 
									</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:set value="1" var="namenum"></c:set>


<tr><td ></td><td ></td><td ></td><td ></td>
</tr>



					</table>
	
		
				<div >
				<font size="+1"><b>添加编辑</b></font>
		<br/><br/>
		<table class="tb tb2 ">
		   		<tr>
				<td colspan="2" class="td27" s="1">
					岗位类型：
					<a id="faq9fb4" class="faq" href="#" target="_blank"
						style="display: none">&nbsp;&nbsp;&nbsp;</a>
				</td>
			</tr>
			<tr class="noborder">
				<td class="vtop rowform">
						<select id="allsel" style="width: 160px" onchange="selchange(this.value)">
									<option value="0">
										选择岗位类型
									</option>
									<option value="1">
										主岗
									</option>
									<option value="2">
										分岗
									</option>
									
								<c:if test="${list1.department.isbj==1}"><option value="3">
										分管
									</option>
									</c:if>
									</select>
				</td>
				<td class="vtop tips2" s="1">
					<font color="red">(先选)</font>选择职位类型，分为主岗(隶属本部门)，分岗(兼职其他部门),分岗(员工级别达到制定级别可分管其他部门)
				</td>
			</tr>
			<tr>
				<tr>
					<td colspan="2" class="td27" s="1">
						选择部门:
					</td>
				</tr>
				<tr class="noborder">
					<td class="vtop rowform">
						<select name="s1" id="xsel5" style="width: 160px"
									onchange="selchange1(this.name,this.value,${list1.id});">
									<option value="0">
										-------
									</option>
								    </select>

								<!-- 主岗 -->
								<select name="s1" id="xsel1" style="display: none; width: 160px"
									onchange="selchange1(this.name,this.value,${list1.id});">
									<option value="0">
										-------
									</option>
									<c:forEach items="${list4 }" var="department">
										<c:if test="${department.id==list1.department.id }">
											<option value="${department.id }">
												${department.name }
											</option>
										</c:if>
									</c:forEach>
								</select>


								<!-- 分岗 -->
								<select name="s2" id="xsel2" style="display: none; width: 160px"
									onchange="selchange1(this.name,this.value,${list1.id});">
									<option value="0">
										-------
									</option>
									<c:forEach items="${list4 }" var="department">
										<option value="${department.id }">
											${department.name }
										</option>
									</c:forEach>
								</select>
								<!-- 分管-->
								<select name="s3" id="xsel3" style="display: none; width: 160px"
									onchange="selchange1(this.name,this.value,${list1.id});">
									<option value="0">
										-------
									</option>

									<c:forEach items="${list4 }" var="department">
										<c:if test="${department.isbj==1 }">
											<option value="${department.id }">
												${department.name }
											</option>
										</c:if>
									</c:forEach>
								</select>
							</td>
					<td class="vtop tips2" >
					<font color="red">(次选)</font>选择部门，分为主岗(隶属本部门)，分岗(兼职其他部门),分岗(员工级别达到制定级别可分管其他部门)
				</td>
					</tr>
					<tr>
					
					<td colspan="2" class="td27" s="1">
						选择部门职位:
					</td>
				</tr>
				
							<td width="200"><div id="selshow" style="display: none"> ss</div>
								<select name=""  style="width: 160px;display:block" id="show" onchange="change2()">
									<option value="0">
										-------
									</option>
									<c:forEach items="${list2 }" var="list2">
									
										<option value="${list2.id }">
											${list2.name }
										</option>

									</c:forEach>
								</select>
						<input type="hidden" id="wpid" value=""/>
							</td>
							<td class="vtop tips2" >
					<font color="red">(后选)</font>选择部门职位，给这个员工选择以选择的部门职位
				</td>
						</tr>
						<tr>
						
					<tr>
					<td>员工姓名：<p style="display: inline;">${list1.name}</p></td>
					<td></td>
					
					</tr>
					<tr>
					<td>职位名称：<span id="inpt"></span></td>
					<td><input type="hidden" value="" id="inpt1"/><input type="hidden" value="" id="inpt3"/></td>
					
					</tr>
</tr>

</table>


					<input type="button" class="btn" id="b1" style="display: block" onclick="submit1(${list1.id});" value="提交" />
						<input type="button" class="btn" id="b2" style="display: none" onclick="submit2(${list1.id});" value="修改"  />
					</form>
		</div>
			</c:forEach>
	</body>


	<script type="text/javascript"><!--
	function showdiv(wpid,workpositionname,deptname,deptid,workid){
	document.getElementById("b1").style.display="none";
	document.getElementById("b2").style.display="block";
	$("#inpt2").remove();
	$("#xsel5").append("<option value='"+deptid+"' selected>"+deptname+"</option>");
	$("#inpt").append('<p  id="inpt2" style="display: inline;">'+workpositionname+"</p>");
	
	document.getElementById("inpt1").value=wpid;
	document.getElementById("inpt3").value=workid;
	
	}
	function	 change2(){
 	var val=$("#xsel4").val();
 	$("#inpt2").remove();

	   document.getElementById("inpt1").value=val;
	   
	   var val1=$("#xsel4").find("option:selected").text();
		$("#inpt").append('<p  id="inpt2" style="display: inline;">'+val1+"</p>");
	}
	function selchange(v){
	alert(v);
		if(v==1){
		$("#xsel1").show();
			$("#xsel2").hide();
			$("#xsel3").hide();
			$("#xsel5").hide();
		}else if(v==2){
		$("#xsel2").show();
		$("#xsel1").hide();
		$("#xsel3").hide();
			$("#xsel5").hide();
		}else if(v==3){
		$("#xsel3").show();
		$("#xsel2").hide();
		$("#xsel1").hide();
			$("#xsel5").hide();
		}else{
		
			$("#xsel5").show();
		$("#xsel2").hide();
		$("#xsel1").hide();
			$("#xsel3").hide();
		
		}
	}
	function selchange1(val1,v,id){
	
	 var url="selworkpositionbydeptemp.do?depid="+v+"&empid="+id+"&sname="+val1;
	$("#selshow").load(url);
	document.getElementById("show").style.display="none";
	document.getElementById("selshow").style.display="block";
	
	}
	
	function submit1(a){
	alert(a);
	
	var val11=$("#allsel").val();
	var val1=$("#inpt1").val();
	
	if(val1!=""){
	
	  $.ajax({
           type:'post',
           url:'changeworkpositionmissiontype.do',
           data:{employeeid:a,workpositionid:val1,value1:val11},
           success:function(res){
    
              location.reload();
           }
     });
     }else{
     
     alert("请选择部门")};
	}
	function submit2(a){
	alert(a);
	var val11=$("#inpt3").val();
	var val1=$("#inpt1").val();
	alert(val11);
	if(val1!=""){
	
	  $.ajax({
           type:'post',
           url:'editworkpositionmissiontype.do',
           data:{employeeid:a,workpositionid:val1,workpositionempid:val11},
           success:function(res){
           alert("ok");
              location.reload();
           }
     });
     }else{
     
     alert("请选择部门")};
	}
		function submit3(a) {
	    if(confirm("确定要卸除这个人的岗位吗？")==true){
		var val2 = $("#workpositionid").val();
		//alert(val2);
		$.ajax( {
			type : 'post',
			url : 'delworkpositionmissiontype.do',
			data : {
				workpositionempid:a
			},
			success : function(res) {
			 
				location.reload();
			}
		});
		}
	}
	
	
	</script>
</html>
</body>
</html>
