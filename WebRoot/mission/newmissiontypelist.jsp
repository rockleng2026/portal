<%@ page language="java"
	import="java.util.*,com.fuao.fajxc.vo.Department" pageEncoding="GBK"%>
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
		<title>My JSP 'newmissiontypelist.jsp' starting page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">

		<script type="text/javascript" src="<%=basePath%>/js/jquery-1.4.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>Css/missionuse.css" />
		<script type="text/javascript">
   $(document).ready(function(){
   
    
   $("img.mouseover").mouseover(function(){
   
   $(this).after('<div  class="addp" style="display: inline;z-index:2;"  ><br><font size="-1" color="#FF6600">添加子模块</font></div>');
   });
     
   $("img.mouseover").mouseout(function(){
   
   $("div").remove(".addp");
   });
   
   $("input.paixu").mouseover(function(){
   $(this).css("border-color","#2366A8");
    $(this).css("color","#2366A8");
  });
   $("input.paixu").mouseout(function(){
    $(this).css("color","#333");
    $(this).css("border-color","#ccc");
    });
});

</script>
		<style type="text/css">
.addp {
	position: absolute;
	z-index: 1000;
}

.div {
	position: absolute;
	z-index: 1000;
	background-color: #E6F0F9;
	left: 100px;
	top: 150px;
	height: auto;
}

A IMG {
	BORDER-BOTTOM: medium none;
	BORDER-LEFT: medium none;
	BORDER-TOP: medium none;
	BORDER-RIGHT: medium none
}

INPUT {
	BORDER-BOTTOM: #ccc 1px solid;
	BORDER-LEFT: #666 1px solid;
	PADDING-BOTTOM: 2px;
	PADDING-LEFT: 2px;
	PADDING-RIGHT: 2px;
	BACKGROUND: #f9f9f9;
	COLOR: #333;
	BORDER-TOP: #666 1px solid;
	BORDER-RIGHT: #ccc 1px solid;
	PADDING-TOP: 2px;
	resize: none
}
</style>
	</head>
	<body>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<h3>
					**** - 部门信息管理
				</h3>
			</div>
			<table class="tb tb2 ">
				<tr>
					<th class="partition">
						功能提示
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
							<li>
								“顺序变更”是由同等级部门按照1开始的顺序排序，如果想更换位置，目标部门的顺序是当前级别的数序。不同级别，不同部门下不能更换顺序
							</li>
							<li>
								“删除功能”“设置岗位人员”功能当前用户下，若删除部门有子部门存在不能一次删除。删除和设置岗位需要对应权限才能操作。
							</li>
							<li>
								“添加部门”添加部门的时候请一次添加一条部门信息，输入信息后鼠标离开输入框即可完成输入。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</li>
							<li>
								<a href="<%=basePath%>mission/reeidtdepartment.jsp">添加部门(针对部门初始化)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="getislevefatermissiontype.do">给临时部门设岗</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="resetDeptqummissiontype.do">初始化部门顺序</a>
							</li>
						</ul>
					</td>
				</tr>
			</table>
			<br />
			<div align="left" style="width: 950">
				<p class="flip" style="background: #92c0e2">
					&nbsp;
				</p>
				<br />
				<!-- 2级别循环 -->
				<c:forEach items="${deptlist}" var="dept">
					<c:set value="1" var="pcms"></c:set>
					<c:set value="1" var="pcms3"></c:set>
					<c:set value="1" var="pcms2"></c:set>
					<c:set value="1" var="pcms1"></c:set>
					<c:set value="1" var="pcms5"></c:set>
					<c:set value="1" var="pcms4"></c:set>

					<c:if test="${dept.parentId==1}">
						<div class="fuao" style="border-color: green; display: block">
							<input class="paixu" type="text" style="width:25; height: 20;"
								value="0" />
							<input class="paixu" name="${dept.parentId}"
								style="width: 110; height: 18; font: bolder;" type="text"
								value="${dept.name}" />
							<img id="fuao" name="${dept.parentId}"
								src="<%=basePath%>img/jibie/+.jpg" onclick="changex(28,1,2);" />
							<br />
							<p id="fuao28"></p>
							<hr size="0.5" style="border: 3px dotted #DEEFFB" color="#000000" />

							<!-- 3级别循环 -->
							<c:forEach items="${deptlist}" var="dept1">
								<c:if test="${dept1.parentId==dept.id}">
									<c:set value="${pcms4+1 }" var="pcms4"></c:set>
									<c:set value="${pcms3+1 }" var="pcms3"></c:set>


									<div style="display: inline;" class="${dept.id}">
										<input class="paixu" name="${dept1.id }" type="text"
											style="width: 25; height: 20;" value="${dept1.squnum }"
											onblur="orderby(this.name,${dept1.islevel },this.value,${dept1.squnum },${dept1.parentId });" />
										<img name="${dept.id}" class="c1"
											onclick="change1(this,${pcms4});"
											src="<%=basePath%>img/jibie/---.jpg" />
										<img src="<%=basePath%>img/jibie/2.gif" />
										<input class="paixu" name="${dept1.parentId}"
											style="width: 110; height: 20; font: bolder;" type="text"
											value="${dept1.name}" />
										&nbsp;&nbsp;
										<img class="mouseover" name="${dept.id}"
											src="<%=basePath%>img/jibie/+.jpg"
											onclick="changex(${dept1.id},${dept1.parentId},${dept1.islevel });" />
										<span style="width: 207"></span>
										<a href="selpositionmissiontype.do?deptid=${dept1.id}" /><font
											size="-1.5" color="#2366A8">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a name="${dept1.id}" href="javascript:add(${dept1.id});"><font
											size="-1.5" color="#2366A8">岗位管理</font> </a><a
											style="margin-left: 20"
											href="javascript:addOperationDepart(${dept1.id})"><font
											size="-1.5" color="#2366A8">额度审核管理</font> </a><a
											style="margin-left: 20"
											href="javascript:getAuthorization(${dept1.id})"><font
											size="-1.5" color="#2366A8">授权管理</font> </a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<a href="editdeptmissiontype.do?deptid=${dept1.id}"><font
											size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
										<a onclick="del(${dept1.id},${dept1.islevel});"><font
											size="-1.5" color="#2366A8">删除</font> </a>
										<p id="fuao${dept1.id}"></p>
										<hr size="0.2" style="border: 3px dotted #DEEFFB;"
											color="#DEEFFB" />
										<div class="${pcms3 }first" id="${dept1.parentId}"
											style="display: block; display: inline">


											<!-- 4级别循环 -->
											<c:forEach items="${deptlist}" var="dept2">
												<c:if test="${dept2.parentId==dept1.id}">

													<c:if test="${dept2.isbj==1}">

														<!-- 判断是否是半级机构 -->
														<div style="display: inline;">
															<input class="paixu" name="${dept2.id }" type="text"
																style="width: 25; height: 20;" value="${dept2.squnum }"
																onblur="orderby(this.name,${dept2.islevel },this.value,${dept2.squnum },${dept2.parentId });" />
															<img style="margin-left: 37" name="${dept.id}" class="c2"
																onclick="change2(this,${dept2.id});"
																src="<%=basePath%>img/jibie/---.jpg" />
															<img src="<%=basePath%>img/jibie/1--2.gif" />
															&nbsp;
															<input name="${dept2.parentId}"
																style="width: 110; height: 20; color: red;" type="text"
																value="${dept2.name}" onclick="xianshi(${dept2.id})" />
															&nbsp;&nbsp;
															<img class="mouseover" name="${dept1.id}"
																src="<%=basePath%>img/jibie/+.jpg" />
															<span style="width: 108"></span>
															<a href="selpositionmissiontype.do?deptid=${dept2.id}" /><font
																color="#2366A8" size="-1.5">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a name="${dept2.id}" href="javascript:add(${dept2.id});"><font
																size="-1.5" color="#2366A8">岗位管理</font> </a><a
																style="margin-left: 20"
																href="javascript:addOperationDepart(${dept2.id})"><font
																size="-1.5" color="#2366A8">额度审核管理</font> </a><a
																style="margin-left: 20"
																href="javascript:getAuthorization(${dept2.id})"><font
																size="-1.5" color="#2366A8">授权管理</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a href="editdeptmissiontype.do?deptid=${dept2.id}"><font
																size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a onclick="del(${dept2.id},${dept2.islevel});"><font
																size="-1.5" color="#2366A8">删除</font> </a>
															<p id="fuao${dept2.id}"></p>
															<hr size="0.2" style="border: 3px dotted #DEEFFB;"
																color="#DEEFFB" />
														</div>


													</c:if>
													<c:if test="${dept2.isbj!=1}">
														<c:set value="${pcms2+1 }" var="pcms2"></c:set>
														<c:set value="${pcms+1 }" var="pcms"></c:set>

														<div style="display: inline;" class="${dept1.id}">
															<input class="paixu" name="${dept2.id }" type="text"
																style="width: 25; height: 20;" value="${dept2.squnum }"
																onblur="orderby(this.name,${dept2.islevel },this.value,${dept2.squnum },${dept2.parentId });" />
															<img style="margin-left: 37" name="${dept.id}" class="c2"
																onclick="change2(this,${dept2.id});"
																src="<%=basePath%>img/jibie/---.jpg" />
															<img src="<%=basePath%>img/jibie/1--2.gif" />
															&nbsp;
															<input class="paixu" name="${dept2.parentId}"
																style="width: 110; height: 20;" type="text"
																value="${dept2.name}" />
															&nbsp;&nbsp;
															<img class="mouseover" name="${dept1.id}"
																src="<%=basePath%>img/jibie/+.jpg"
																onclick="changex(${dept2.id},${dept2.parentId},${dept2.islevel });" />
															<span style="width: 108"></span>
															<a href="selpositionmissiontype.do?deptid=${dept2.id}" /><font
																color="#2366A8" size="-1.5">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a name="${dept2.id}" href="javascript:add(${dept2.id});"><font
																size="-1.5" color="#2366A8">岗位管理</font> </a><a
																style="margin-left: 20"
																href="javascript:addOperationDepart(${dept2.id})"><font
																size="-1.5" color="#2366A8">额度审核管理</font> </a><a
																style="margin-left: 20"
																href="javascript:getAuthorization(${dept2.id})"><font
																size="-1.5" color="#2366A8">授权管理</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a href="editdeptmissiontype.do?deptid=${dept2.id}"><font
																size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
															<a onclick="del(${dept2.id},${dept2.islevel});"><font
																size="-1.5" color="#2366A8">删除</font> </a>
															<p id="fuao${dept2.id}"></p>
															<hr size="0.2" style="border: 3px dotted #DEEFFB;"
																color="#DEEFFB" />
															<div class="${pcms2 }" id="${dept2.parentId}"
																style="display: block; display: inline">

																<!-- 5级别循环 -->
																<c:forEach items="${deptlist}" var="dept3">


																	<c:if test="${dept3.parentId==dept2.id}">
																		<c:if test="${dept3.isbj==1}">

																			<!-- 判断是否是半级机构 -->
																			<div style="display: inline" class="${dept2.id}">
																				<input class="paixu" name="${dept3.id }" type="text"
																					style="width: 25; height: 20;"
																					value="${dept3.squnum }"
																					onblur="orderby(this.name,${dept3.islevel },this.value,${dept3.squnum },${dept3.parentId });" />
																				&nbsp;
																				<img style="margin-left: 107"
																					src="<%=basePath%>img/jibie/1--2.gif" />
																				<input name="${dept3.parentId}"
																					style="width: 110; height: 20; color: red;"
																					type="text" value="${dept3.name}"
																					onclick="xianshi(${dept3.id})" />
																				&nbsp;&nbsp;
																				<img name="${dept2.id}" class="mouseover"
																					src="<%=basePath%>img/jibie/+.jpg" />
																			<span style="width: 62"></span>
																				<a
																					href="selpositionmissiontype.do?deptid=${dept3.id}" /><font
																					color="#2366A8" size="-1.5">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a name="${dept3.id}" href="javascript:add(${dept3.id});"><font
																					size="-1.5" color="#2366A8">岗位管理</font> </a><a
																					style="margin-left: 20"
																					href="javascript:addOperationDepart(${dept3.id})"><font
																					size="-1.5" color="#2366A8">额度审核管理</font> </a><a
																					style="margin-left: 20"
																					href="javascript:getAuthorization(${dept3.id})"><font
																					size="-1.5" color="#2366A8">授权管理</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a href="editdeptmissiontype.do?deptid=${dept3.id}"><font
																					size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a onclick="del(${dept3.id},${dept3.islevel});"><font
																					size="-1.5" color="#2366A8">删除</font> </a>
																				<p id="fuao${dept3.id}"></p>
																				<hr size="0.2" style="border: 3px dotted #DEEFFB"
																					color="#DEEFFB" />
																			</div>


																		</c:if>
																		<c:set value="${pcms1+1 }" var="pcms1"></c:set>

																		<c:if test="${dept3.isbj!=1}">

																			<div style="display: inline" class="${dept2.id}">
																				<input class="paixu" name="${dept3.id }" type="text"
																					style="width: 25; height: 20;"
																					value="${dept3.squnum }"
																					onblur="orderby(this.name,${dept3.islevel },this.value,${dept3.squnum },${dept3.parentId });" />
																				&nbsp;
																				<img style="margin-left: 107"
																					src="<%=basePath%>img/jibie/1--2.gif" />
																				<input class="paixu" name="${dept3.parentId}"
																					style="width: 110; height: 20;" type="text"
																					value="${dept3.name}" />
																				&nbsp;&nbsp;
																				<img name="${dept2.id}" class="mouseover"
																					src="<%=basePath%>img/jibie/+.jpg"
																					onclick="changex(${dept3.id},${dept3.parentId},${dept3.islevel });" />
																				<span style="width: 62"></span>
																				<a
																					href="selpositionmissiontype.do?deptid=${dept3.id}" /><font
																					color="#2366A8" size="-1.5">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a name="${dept3.id}" href="javascript:add(${dept3.id});"><font
																					size="-1.5" color="#2366A8">岗位管理</font> </a><a
																					style="margin-left: 20"
																					href="javascript:addOperationDepart(${dept3.id})"><font
																					size="-1.5" color="#2366A8">额度审核管理</font> </a><a
																					style="margin-left: 20"
																					href="javascript:getAuthorization(${dept3.id})"><font
																					size="-1.5" color="#2366A8">授权管理</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a href="editdeptmissiontype.do?deptid=${dept3.id}"><font
																					size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																				<a onclick="del(${dept3.id},${dept3.islevel});"><font
																					size="-1.5" color="#2366A8">删除</font> </a>
																				<p id="fuao${dept3.id}"></p>
																				<hr size="0.2" style="border: 3px dotted #DEEFFB"
																					color="#DEEFFB" />
																				<div id="${dept3.id}"
																					style="display: block; display: inline">

																					<!-- 6级别循环 -->
																					<c:forEach items="${deptlist}" var="dept4">
																						<c:if test="${dept4.parentId==dept3.id}">

																							<div style="display: inline;" class="${dept3.id}">
																								<input class="paixu" name="${dept1.id }"
																									type="text" style="width: 25; height: 20;"
																									value="${dept4.squnum }"
																									onclick="changex(${dept4.id},${dept4.parentId},${dept4.islevel });" />
																								<div style="display: block; display: inline">
																									<img style="margin-left: 170"
																										src="<%=basePath%>img/jibie/12.gif" />
																									<input class="paixu" name="${dept4.parentId}"
																										style="width: 110; height: 20;" type="text"
																										value="${dept4.name}" />
																									<span style="width: 34"></span>
																									<a
																										href="selpositionmissiontype.do?deptid=${dept4.id}" /><font
																										color="#2366A8" size="-1.5">岗位人员管理</font></a>&nbsp;&nbsp;&nbsp;&nbsp;
																									<a name="${dept4.id}" href="javascript:add(${dept4.id});"><font
																										size="-1.5" color="#2366A8">岗位管理</font> </a><a
																										style="margin-left: 20"
																										href="javascript:addOperationDepart(${dept4.id})"><font
																										size="-1.5" color="#2366A8">额度审核管理</font> </a><a
																										style="margin-left: 20"
																										href="javascript:getAuthorization(${dept4.id})"><font
																										size="-1.5" color="#2366A8">授权管理</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																									<a class="ca"
																										href="editdeptmissiontype.do?deptid=${dept4.id}&islevel=${dept4.islevel}&islevel=${dept3.islevel}"><font
																										size="-1.5" color="#2366A8">编辑</font> </a>&nbsp;&nbsp;&nbsp;&nbsp;
																									<a onclick="del(${dept4.id},${dept4.islevel});"><font
																										size="-1.5" color="#2366A8">删除</font> </a>
																									<p id="fuao${dept4.id}"></p>
																									<hr size="0.2"
																										style="border: 3px dotted #DEEFFB"
																										color="#DEEFFB" />

																								</div>
																							</div>
																						</c:if>
																					</c:forEach>
																				</div>
																			</div>
																		</c:if>
																	</c:if>
																</c:forEach>



															</div>
														</div>
													</c:if>
												</c:if>
											</c:forEach>


										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>

				</c:forEach>

			</div>


			<div id="popLayer" class="div"
				style="display: none; ； width: 250px; height: 200px; border-color: #B4FF63;">
				<form id="formdl" name="formdl" method="post" action="">
					<font align="center" color="#092907" size="3">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>部门职位人员表</b> </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<img type="button" name="Submit1" class="bntccanniu"
						src="<%=basePath%>img/jibie/colse.png" onclick="closeWindow();" />
					<br />
					<br />
					<br />
					<Br />
				</form>
			</div>
			<script type="text/javascript">
			  
			  function xianshi(a){
			 var mouseX = event.clientX;  
			 var mouseY = event.clientY;
			 
			  
      
		 $.ajax({
          type:'post',
           url:'xianshimissiontype.do',
           data:{pid:a},
           success:function(sc){
         
          $("p").remove("#textp");
            $("#popLayer").append('<p id="textp"></p>');
           $("#textp").append(sc);
           
          
             showWindow(mouseX,mouseY);
           }
         });
			  
			  }
			  function del(ids,level){
			  if(confirm("确定删除吗？删除后该部门成员将划分到临时部门！")==true){
			   $.ajax({
           type:'post',
           url:'deldeptmissiontype.do',
           data:{islevel:level,pid:ids},
           success:function(res){
              location.reload();
           }
     });
			  }		  
			  }
   function  orderby(m,n,v,s,p){
   
    
      
     if(v==0){
     alert("提示：此部门不能和半级部门更换位置，谢谢。")
    }if(s==0){
     alert("提示：半级部门不能更换位置，谢谢。")
    }else{
    $.ajax({
           type:'post',
           url:'orderbymissiontype.do',
           data:{parantIds:m,islevel:n,value1:v,squnum:s,pid:p},
           success:function(res){
              location.href="getallmissiontype.do";
           }
     });
   
   }
  }

   function change1(c,a){

       
          c.src=c.src=="<%=basePath%>img/jibie/+++.jpg"?"<%=basePath%>img/jibie/---.jpg":"<%=basePath%>img/jibie/+++.jpg";

       
       
         
       
       $("div."+a+"first").slideToggle("slow");
       
    
   }
    
   function change2(c,m){
   c.src=c.src=="<%=basePath%>img/jibie/+++.jpg"?"<%=basePath%>img/jibie/---.jpg":"<%=basePath%>img/jibie/+++.jpg";


      
       
    $("div."+m).slideToggle("slow");
   
   }
   
   
function changex(zid,pid,is){
 
  
    
        $("#fuao"+zid).after('<p id="fuao1"><br><img  id="addfoao" style="margin-left:250" src="<%=basePath%>img/jibie/2.gif" /><input  id="addfoao" type="text"   style="width: 100px;height:18px;" onblur="outboxvxs1('+zid+','+pid+','+is+',this.value,this.id)"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
     
 
   }
   function outboxvxs1(vn,r,p,v1,tid){
        var v=encodeURI(v1,"UTF-8");
        if(v!=null && v!=""){
        $.ajax({
           type:'post',
           url:'addpositionsmissiontype.do',
           data:{parantIds:vn,strinName:v,islevel:p,pid:vn},
           success:function(res){
              location.reload();
           }
        });
        }else{
         alert("输入内容为空！");
         if(confirm("确认:取消添加并删除输入框，取消:重新输入新部门信息！")==true){
         
          $("#fuao1").remove();
       		 
         }
        }
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
</script>
			<!-- 弹出层 -->
			<div id="floatDiv">

				<div id="TB_overlayBG">
					&nbsp;
				</div>
				<div style="display: none" class="box">
					<h2>
						页面信息
						<a class="close">关闭</a>
					</h2>
					<div class="mainlist" id="postionDiv">

						<div id="TB_overlayBG">
							&nbsp;
						</div>
						
					</div>
				</div>
			</div>
			<script type="text/javascript">
function showbox(id){
	   
		$("#TB_overlayBG").css({
			display:"block",height:$(document).height()
		});
		$(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		});
		var tt = (new Date()).getTime();
		    var url = "getDeptPosition.do?deptid="+id+"&tt="+tt;
			$("#postionDiv").load(url);
	} 
$(function(){
	
	
	$(".close").click(function(){
		$("#TB_overlayBG").css("display","none");
		$(".box ").css("display","none");
		var tt = (new Date()).getTime();
        window.location.href="getallmissiontype.do?tt="+tt;
		//location.reload();
	});
	$(".submitclick").click(function(){
	   if(addValidators2('form0')){
	   	var content  = $("#content0").val();
	   	if( content == null || content == ''){
	   		alert("请填写工作概述!");
	   		return false;
	   	}
	   	//alert(content);
	   	var reg=new RegExp("<br />","g"); 
	   	content = content.replace(reg,"\r\n");
	   	$("#workcontent0").val(content);
	   	//
	   	//var url = "xx.do?tt"+(new Date().getTime());
	   	//$.post(url,{},function(data){});
	   	 $("#form0").submit();
	   }
	});
});
</script>
			<style type="text/css">
* {
	margin: 0;
	padding: 0;
	list-style-type: none;
}

a,img {
	border: 0;
}

a {
	color: #5e5e5e;
	text-decoration: none;
}

a:hover {
	color: #3366cc;
	text-decoration: underline;
}

/* box */
.box {
	position: absolute;
	width: 468px;
	left: 50%;
	height: auto;
	z-index: 100;
	background-color: #fff;
	border: 1px #8FA4F5 solid;
	padding: 1px;
}

.box h2 {
	height: 25px;
	font-size: 14px;
	background-color: #3366cc;
	position: relative;
	padding-left: 10px;
	line-height: 25px;
	color: #fff;
}

.box h2 a {
	position: absolute;
	right: 5px;
	font-size: 12px;
	color: #fff;
}

.box .mainlist {
	padding: 10px;
}

.box .mainlist li {
	height: 24px;
	line-height: 24px;
}

.box .mainlist li span {
	margin: 0 5px 0 0;
	font-family: "宋体";
	font-size: 12px;
	font-weight: 400;
	color: #ddd;
}

#TB_overlayBG {
	background-color: #666;
	position: absolute;
	z-index: 99;
	left: 0;
	top: 0;
	display: none;
	width: 100%;
	height: 100%;
	opacity: 0.5;
	filter: alpha(opacity =   50);
	-moz-opacity: 0.5;
}

.box {
	position: absolute;
	width: 468px;
	left: 50%;
	height: auto;
	z-index: 100;
	background-color: #fff;
	border: 1px #8FA4F5 solid;
	padding: 1px;
}

.box h2 {
	height: 25px;
	font-size: 14px;
	background-color: #3366cc;
	position: relative;
	padding-left: 10px;
	line-height: 25px;
	color: #fff;
}

.box h2 a {
	position: absolute;
	right: 5px;
	font-size: 12px;
	color: #fff;
}

.box .mainlist {
	padding: 10px;
}

.box .mainlist li {
	height: 24px;
	line-height: 24px;
}

.box .mainlist li span {
	margin: 0 5px 0 0;
	font-family: "宋体";
	font-size: 12px;
	font-weight: 400;
	color: #ddd;
}

#TB_overlayBG {
	background-color: #666;
	position: absolute;
	z-index: 99;
	left: 0;
	top: 0;
	display: none;
	width: 100%;
	height: 100%;
	opacity: 0.5;
	filter: alpha(opacity =     50);
	-moz-opacity: 0.5;
}
</style>
			<script type="text/javascript">
		function add(id){
			var tt = (new Date()).getTime();
		    location.href= "getDeptallsposition.do?deptid="+id+"&tt="+tt;
			//$("#postionDiv").load(url);
			//$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    //$(".box").css({
			//left:($("body").width()-$(".box").width())/2-20+"px",
			//top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			//display:"block"
		   //});
		}
		
		function addOperationDepart(depid){
		    //alert(111);
			var tt = (new Date()).getTime();
			//alert(depid);
		    var url = "addOperationmissiontype.do?deptid="+depid+"&tt="+tt;
			$("#postionDiv").load(url);
			$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    $(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		   });
		}
		function getAuthorization(depid){
		//alert(depid);
		    var tt = (new Date()).getTime();
		    var url = "getAuthorizationmissiontype.do?deptid="+depid+"&tt="+tt;
			$("#postionDiv").load(url);
			$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    $(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		   });
		 
		}
	</script>
	</body>

</html>
