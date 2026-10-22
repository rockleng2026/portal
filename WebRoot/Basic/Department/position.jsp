<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="x-ua-compatible" content="ie=7" />

		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>Css/missionuse.css" />
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<h3>
					${deptname }--岗位管理
				</h3>
			</div>
			<table class="tb tb2 " id="tips">
				<tr>
					<th class="partition">
						技巧提示
					</th>
					<th class="partition">
						<a href="getallmissiontype.do">返回部门信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
							<li>
								“岗位设置”得到此部门下的岗位，并可以对岗位进行编辑，删除
							</li>
							<li>
								如果想增加新的岗位，下面部门添加
							</li>
						</ul>
					</td>
				</tr>
			</table>
			<form action="addoreditWorkPosition.do" method="post" id="form0"
				name="form0">
				<s:token name="register0"></s:token>
				<input type="hidden" id="mark" name="mark" value="new" />
				<table align="center" border="0" width="440px;" class="tb tb2">
					<tr align="left">
						<th>
							<b>岗位名称</b>
						</th>
						<th>
							<b>岗位简写</b>
						</th>
						<th>
							<b>当前部门</b>
						</th>
						<th>
							<b>是否主管岗位</b>
						</th>
						<th align="center">
							<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操&nbsp;&nbsp;作</b>
						</th>
					</tr>
                   
					
						<input type="hidden" id="deptname" value="${deptid }">
					
					<c:forEach items="${data}" var="p">
						<tr>
							<td style="font: 10pt;">
								${p.name }
							</td>
							<td style="font: 10pt;">
								${p.shortname }

							</td>
							<td style="font: 10pt;">
								${p.department.name }

							</td>
							<th align="center">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<b><c:if test="${p.ispersonman==1 }">是</c:if>
									<c:if test="${p.ispersonman!=1 }">否</c:if>
								</b>

							</th>
							<td style="font: 10pt;">
							<c:if test="${p.department.isbj==1 }">
								<a class="faq" title="点击编辑该职位"
									onclick="xianshi('${p.department.id }','${p.id }')">分管管理</a></c:if>
								<a class="faq" title="点击编辑该职位"
									href="<%=path %>/positionPermsionSetPosition.do?positionid=${p.id }">权限管理</a>&nbsp;&nbsp;
								<a title="点击编辑该职位"
									onclick="javascript:gomodify('${p.id }','${p.name }','${p.shortname }','${p.workgrade.grade}','${p.workgrade.name }','${p.workcontent }','${p.ispersonman }','${p.department.id }')">修改</a>
								<a class="faq" title="点击编辑该职位"
									onclick="javascript:del('${p.id }')">删除</a>

							</td>
						</tr>
					</c:forEach>

					<th class="partition">
						编辑修改
					</th>
					<tr>
						<Td colspan="5">
							<input type="hidden" id="depttid" value="0" />
							<input type="hidden" id="workpid" value="0" />
							<input type="hidden" value="$" id="id" name="id">
							<input type="hidden" value="${deptid }" id="deptid" name="deptid">
							岗位名称*
							<input style="width: 100px" type="text" value="" id="name"
								name="name" onblur="checkValueByRules2('name','','nameMsg')" />
							<FONT color=#ff0000 size="2" id="nameMsg"></FONT>
						</td>
					</tr>
					<tr>
						<Td colspan="5">
							岗位缩写*
							<input style="width: 100px" type="text" value="" id="shortname"
								name="shortname"
								onblur="checkValueByRules2('shortname','','shortnameMsg')" />
							<FONT size="2" color=#ff0000 id="shortnameMsg"></FONT>

						</td>
					</tr>
					<tr>
						<Td colspan="5">

							是否主管岗位* 是
							<input type="radio" id="r1" name="r1" value="1" />
							否
							<input type="radio" id="r1" name="r1" value="0" checked="checked" />
						</td>
					</tr>

					<tr>
						<Td colspan="5">
							岗位权重*
							<select>
								<option value="0">
									暂不启用
								</option>
							</select>
						</td>
					</tr>



					<Tr>
						<Td colspan="5">
							职位描述：300字符以内
							<FONT color=#ff0000 id="content0Msg"></FONT>
							<br />
							<textarea name="content" id="content0" cols="50" rows="5"
								onblur="checkValueByRules2('content0','','content0Msg')"></textarea>
							<FONT color=#ff0000>*</FONT>
						</td>
					</Tr>
					<Tr>
						<Td colspan="5">
							<span style="text-align: center"><input id="button1"
									name="button1" value="提交" onclick="checkbutton()" type="button" />&nbsp;
							</span>
						</td>
					</Tr>
				</table>
			</form>
			<div id="popLayer" class="div"
				style="display: none; ； width: 500px; height: 200px; border-color: #B4FF63;">
				<form id="formdl" name="formdl" method="post" action="">
					<font align="center" color="#092907" size="3">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>子部门拥有岗位</b> </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<img type="button" name="Submit1" class="bntccanniu"
						src="<%=basePath%>img/jibie/colse.png" onclick="closeWindow();" />
					<p id="textp"></p>

				</form>
			</div>
			<style type="text/css">
.addp {
	position: absolute;
	z-index: 1000;
}

.div {
	position: absolute;
	z-index: 1000;
	background-color: white;
	left: 100px;
	top: 150px;
	width: 500px;
	border-style: groove;
	border-width: 3px;
	border-color:navy;
	height: auto;
}
</style>
			<script type="text/javascript">
			
			function sel(a){
			var a1=a.value;
			var workid=$("#workpid").val();
			var deptid=$("#depttid").val();
			if(a.checked==true){
			if(confirm("是否选择这个部门的主管岗位？")==true){
			
			var tt = new Date().getTime();
var url = "ispersonmanallsposition.do?tt="+tt;
		$.get(url,{
		   ispersonman:a1,
		   wpid:workid,
		   deptid:deptid
		},function(data){
	
			if(data =="false1"){ 
			alert("此部门的子部门已是本职位的分管部门,请删除后添加");
				  a.checked=false;
			}else if(data =="false2"){
				alert("此部门的上级部门已是本职位的分管部门，请删除后在添加修改!");
				 a.checked=false;
			}else if(data =="null"){
				alert("此部门还没有主管职位请添加主管职位后再进行关联!");
			 	a.checked=false;
			}else{
			alert("分管成功!");
			location.reload();
			}
		});
			
			}else{
			
			a.checked=false;
			}
			}else{
			if(confirm("你确定要删除这个分管岗位位")==true){
					var tt = new Date().getTime();
var url = "delispersonmanallsposition.do?tt="+tt;
		$.get(url,{
		   ispersonman:a1,
		   wpid:workid,
		   deptid:deptid
		},function(data){
			if(data ==1){
				alret("删除关联成功");
					location.reload();
			
			 }
				
		});
			
			}
   }
   }
  function xianshi(a,x1){
 
			 var mouseX = event.clientX;  
			 var mouseY = event.clientY;
			
		 $.ajax({
          type:'post',
           url:'selpositinmissiontype.do',
           data:{pid:a,workid:x1},
           success:function(sc){
             $("#depttid").val(a);
                
          		$("#workpid").val(x1);
         	var str=sc.split("/");
  			  $("p").remove("#textp");
            $("#popLayer").append('<p id="textp"></p>');
          	 $("#textp").append(str[0]);
               
             showWindow(mouseX,mouseY);
         	
         	if(str[1]!=""){
         	
         	var str2=str[1].split(",");
         	var x=str2.length;
         	
         	for(var j=0;j<x;j++){
         	
         $('input[type="checkbox"][name="sel"]').each(
                function() {
                     if($(this).val()==str2[j]){
                    
                     $(this).attr('checked',true);
                     }
                }
            );
         
         	}
         	}
          	
          	
           }
         });
			  
			  }
			  function showWindow(width1,height1){
	document.getElementById("popLayer").style.position="absolute";
	document.getElementById("popLayer").style.left=width1+"px";
	document.getElementById("popLayer").style.top=(document.body.scrollTop+height1)+"px";
	document.getElementById("popLayer").style.display="block"; 
 		} 
	function closeWindow(){ 
	$("p").remove("#textp");
	document.getElementById("popLayer").style.display="none"; 
	} 
function addPositon(deptid){
	
}
function checkbutton(){ 
  
	var flag = addValidators2();
	
	if(flag == true){
	
		var mark = $("#mark").val();
		var deptid = $("#deptid").val();
		var id = $("#id").val();
		var name = encodeURI($("#name").val());
		var shortname = encodeURI($("#shortname").val());
		var deptname=$("#deptname").val();
		var grade = 1;
		var rr = $('input[@name="r1"][checked]').val();
		var content = encodeURI($("#content0").val());
		var tt = new Date().getTime();
	    
		var url = "addoreditWorkallsposition.do?tt="+tt;
		$.get(url,{
		   mark:mark,
		   wpid:id,
		   deptid:deptid,
		   name:name,
		   shortname:shortname,
		   grade:grade,
		   content:content,
		   ispersonman:rr,
		   deptname:deptname
		},function(data){
			if(data == 0){
				
				  location.href="getDeptallsposition.do?deptid="+deptid+"&tt="+tt;
			}else if(data ==3){
				alert("主管岗位已存在，请删除后在添加修改!");
			}
		});
	}else if(flag == false){
		alert(flag);
	}else{
		alert("ss");
	}
}
function del(id){
		if(confirm("你确定要删除该职位吗？")){
		var deptid = $("#deptid").val();
		var tt = new Date().getTime();
		var url = "delWorkallsposition.do?tt="+tt;
		$.get(url,{
		   wpid:id
		},function(data){
		    //alert(data);
			if(data == '0'){
				 location.href="getDeptallsposition.do?deptid="+deptid+"&tt="+tt;
				alert("操作成功!");
			}else if(data == '2'){
				alert("已有员工关联到此职位,请先删除关联!");
			}else{
				alert("操作错误!");
			}
		});
		}
}
function gomodify(id,name,shortname,grade,gradename,content,ispersonman,deptname){
	$("#mark").val("edit");
	$("#id").val(id);
	$("#deptname").val(deptname);
	$("#name").val(name);
	alert(ispersonman);
	if(ispersonman==1){
	$("input[@type=radio][name='r1'][value=1]").attr("checked",'checked'); 
	}else{
	$("input[@type=radio][name='r1'][value=0]").attr("checked",'checked'); 
	}  
	$("#shortname").val(shortname);
	$("#grade").append("<option value='"+grade+"' selected>"+gradename+"</option>");	
	$("#content0").val(content);	
}
</script>
	</body>

</html>
