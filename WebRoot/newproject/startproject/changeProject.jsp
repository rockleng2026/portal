<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>修改项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		function nsrmx(){
            var url = "<%=path%>/test.jsp";
			showWindwoButton('id','社保费分户台账','800','550',url);
		}
		
		function upd(){
		  $.post('updnewProject.do',{},function(result){
		     if(result=="SUCCESS"){
		       alert("修改成功!");
		       
		     }
		  });
		}
		
		//关闭子窗体,刷新父窗体
		function reload(){
		  parent.location.reload();
		}
		
		//显示部门的层
		function showdepts(){
		  $("#searchDiv").show();
		  $("#emp").hide();
		}
		//部门:点击层上面的关闭,隐藏
    function hidedepts(){
      $("#searchDiv").hide();
    }
    
    function hideemps(){
      $("#emp").hide();
    }
    
      //点击参与人添加按钮,加载所有员工
   function loadcyry(){
     $("#cyemp").show();
     var did=$("#deptbm").val();
     var empids=$("#empids").val();
     var cyrid = $("#cyrid").val();
     alert(cyrid);
     $.post('emplist2newProject.do',{'empids':empids,'did':did,'cyrid':cyrid},function(data){
          if(data!="" || data!=null){
            $("#tab3").html(data);
          }else{
            $("#tab3").html("");
          }
       });
   }
    
    //点击参与人员的关闭连接，隐藏层
    function closecyemp(){
      $("#cyemp").hide();
    }
    
    
    //得到复选框中选中的部门
    var dept=""; //全局变量,封装部门名称+,
    var deptid="";
    function checkDept(check){
      var deptname=check.value;
      var did=check.id;
       if(check.checked==true){
          dept+=deptname+",";
          deptid+=did+",";
       }else if(check.checked==false){
         dept=dept.replace(deptname+",","")
         deptid=deptid.replace(did+",","");
       }else{}
       $("#joindept").attr("value",dept);
       $("#bm").attr("value",deptid);
       $("#deptbm").attr("value",deptid);
    }
    
    //得到复选框中的员工
    var emp=""; //全局变量,封装员工姓名+,
    var empid="";
    function checkEmp(check){
      var empname = check.value;
      var eid=check.id;
      if(check.checked==true){
         emp=empname+","+document.getElementById("look").value;
         empid=eid+","+document.getElementById("ckemp").value;
      }else if(check.checked==false){
    	  emp=document.getElementById("look").value;
          empid=document.getElementById("ckemp").value;
        emp=emp.replace(empname+",","");
        empid=empid.replace(eid+",","");
      }else{}
      $("#look").attr("value",emp);
      $("#watcher").attr("value",empid);
      $("#ckemp").attr("value",empid);
    }
    
    
     //添加参与人员、
    var cyr=""; //全局变量,封装员工姓名+,
    var cyrid="";
    function checkCyr(check){
        
      var empname = check.value;
      var eid=check.id;
      if(check.checked==true){
         cyr+=empname+",";
         cyrid+=eid+",";
      }else if(check.checked==false){
        cyr=cyr.replace(empname+",","");
        cyrid=cyrid.replace(eid+",","");
      }else{}
      $("#cyr").attr("value",cyr);
      $("#cyrid").attr("value",cyrid);
    }
    
     //点击项目查看者按钮,显示层
    function showEmps(){
      $("#emp").show();
      $("#searchDiv").hide();
    }
    function hidetext()
    {
		
    }
   </script>
   
  </head>
  
  
<body onload="setdivwidth(),hidetext();">
<input type="hidden" value="" id="hidetext1" name="hidetext1"/>
	<table  width="99%" align="center"    border="0" cellspacing="0" cellpadding="0" id="tablesearch" >		
	    <tr>
	    <jsp:include page="/common/loading.jsp"></jsp:include>
	    <td class="result-border" align="center" >
	    <div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr >
				<th align="left" colspan="6">
					项目详情
				</th>
			</tr>
			<tr align="center">
			   <td>项目名称</td>
			   <td>项目发起人</td>
			   <td>开始时间</td>
			   <td>结束时间</td>
			   <td>状态</td>
			</tr>
			<tr align="center">
				<td>${project.projectname}</td>
				<td>${project.launcher}</td>
				<td>${project.begintime}</td>
				<td>${project.endtime}</td>
				<td>
				<c:if test="${project.projectstatus==0}">
				   立项中
				</c:if>
				<c:if test="${project.projectstatus==1}">
				  审批中
				</c:if>
				<c:if test="${project.projectstatus==2}">
				  进行中
				</c:if>
				<c:if test="${project.projectstatus==3}">
				  已超时
				</c:if>
				<c:if test="${project.projectstatus==4}">
				  已结束
				</c:if>
				</td>
			</tr>
		</table>
		</div>
		</td>
		
		<td class="result-border" align="center" >
	    <div id="resulthight">
	    <form action="<%=request.getContextPath()%>/changenewProject.do" method="post" id="form1" onsubmit="reload()">
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr >
				<th align="left" colspan="2">
					变更项目<font color="red">(只能变更参与部门和查看人员以及参与人员)</font>
				</th>
			</tr>
			<tr>
			   <th align="right">项目名称:</th>
			   <td align="left">
			    <input type="text" name="project.projectname" readonly="true" value="${project.projectname}"/>  
			   </td>
			</tr>
			<tr>
			   <th align="right">项目发起人:</th>
			   <td align="left"><input type="text" name="project.launcher" readonly="true" value="${project.launcher}" readonly="true"/></td>
			</tr>
			<tr>
			  <th align="right">项目类别:</th>
			  <td align="left">
			    <select name="type" readonly="true">
			    <option value="${project.missiontype.id}">${project.missiontype.name}</option>
			    </select>
			  </td>
			</tr>
			<tr>
			   <th align="right">开始时间:</th>
			   <td align="left"><input type="text" readonly="true" name="project.begintime" style="" value="${project.begintime}"/></td>
			</tr>
			<tr>
			   <th align="right">结束时间:</th>
			   <td align="left">
			    <input type="text" name="project.endtime" readonly="true" style="" value="${project.endtime}"/>
			   </td>
			</tr>
			<tr>
			  <th align="right">参与部门:</th>
			    <td align="left">
			    <textarea rows="5" cols="5" id="deptbm" style="display: none;"><c:forEach items="${prjdeptlist}" var="d">${d.dept.id},</c:forEach></textarea>
			    <input type="hidden" name="cm2" id="bm" value="" />
			      <textarea rows="5" cols="5" id="joindept"><c:forEach items="${prjdeptlist}" var="dept">${dept.dept.name},</c:forEach></textarea>
			      <button type="button" class="button" onclick="showdepts()"><span class="icon_add">部门</span></button>
			    </td>
			</tr>
			<tr>
			  <th align="right">查看者:</th>
			  <td align="left">
			    <input type="hidden" name="ck2" id="watcher" value=<c:forEach items="${prjemplist}" var="e">${e.emp.id},</c:forEach>   />
			    <textarea rows="5" cols="5" id="ckemp" style="display: none"><c:forEach items="${prjemplist}" var="e">${e.emp.id},</c:forEach></textarea>
			    <textarea rows="5" cols="5" id="look"><c:forEach items="${prjemplist}" var="e">${e.emp.name},</c:forEach></textarea>
			    <button type="button" class="button" onclick="showEmps()"><span class="icon_add">员工</span></button>
			  </td>
			</tr>
			
			<tr>
			  <th align="right">参与人:</th>
			  <td align="left">
			  <textarea rows="5" cols="5" id="empids" style="display: none;"><c:forEach items="${cyrlist}" var="c">${c.employee.id},</c:forEach></textarea>
			  
			   
			    <input type="hidden" name="cy2" id="cyrid" value=""/>
			    <textarea rows="5" cols="5" id="cyr"><c:forEach items="${cyrlist}" var="cyr">${cyr.employee.name},</c:forEach></textarea>
			    
			    <button type="button" class="button" onclick="loadcyry()"><span class="icon_add">参与人</span></button>
			  </td>
			</tr>
			
			
			<tr>
			  <th align="right">状态:</th>
			  <td align="left">
			    <select name="project.projectstatus">
			      <c:if test="${project.projectstatus==0}">
			        <option value="${project.projectstatus}">立项中</option>
			      </c:if>
			      <c:if test="${project.projectstatus==1}">
			        <option value="${project.projectstatus}">审批中</option>
			      </c:if>
			      <c:if test="${project.projectstatus==2}">
			        <option value="${project.projectstatus}">进行中</option>
			      </c:if>
			      <c:if test="${project.projectstatus==3}">
			        <option value="${project.projectstatus}">已超时</option>
			      </c:if>
			      <c:if test="${project.projectstatus==4}">
			        <option value="${project.projectstatus}">已结束</option>
			      </c:if>
			      <option value="3">已超时</option>
			      <option value="4">已结束</option>
			    </select>
			  </td>
			</tr>
			<tr>
			   <th align="center" colspan="2">
			      <button type="submit" name='cha'  class="button"  ><span class="icon_save">保存</span></button>
			      <button type="button"  onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
			   </th>
			</tr>
		</table>
		</form>
		</div>
		</td>
		
		
		</tr>
	</table>
	
	<!-- 显示所有部门的层 -->
   <div id="searchDiv" class="searchDiv"  style="position: absolute;left: 470px;top: 110px;border-color: red; display: none;border:#89aad7 1px solid;margin-bottom: 10px;">
   <div style="width: 100px;height: 10px;background-color: #E8FFF5; z-index: 10;" align="right">
   <div style="float:right;font-weight:bold;">选择部门列表</div>
   <div style="float:right;position: absolute;left:160px;">
     <a href="javascript:hidedepts();" style="text-decoration: none;">关闭</a>
     </div>
   </div>
   <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
       <c:forEach items="${dlist}" var="d">
       <tr>
         <td>
         <input type="checkbox" id="${d.id}" name="${d.name}" value="${d.name}" onclick="checkDept(this)"/>
         ${d.name}</td>
       </tr>
       </c:forEach>
     </table>
   </div>
   </div>
   
   <!-- 显示所有员工的层 -->
   <div id="emp" style="position: absolute;left: 470px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideemps();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
      ${mark }
     </table>
   </div>
   </div>
   
   
    <!-- 显示所有参与人员的层 -->
   <div id="cyemp" style="position: absolute;left: 470px;top: 310px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:closecyemp();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab3" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   </div>
   
	</body>
</html>
