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
		function reload1(){
//		alert("close");
//		 window.opener=null;
//         window.open('','_self');
//         window.close();
//		 alert("c");
		 parent.location.reload();
		// $("#searchDiv").hide();
		window.parent.location.reload();
	//	 location.reload();
		 
		}
	 //展开上传附件的层	
	 function showfj(){
      $("#annex").show();
      $("#zkfj").hide();
      $("#sqfj").show();
    }
     //隐藏上传附件的层
     function hidefj(){
      $("#annex").hide();
      $("#sqfj").hide();
      $("#zkfj").show();
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
    }
    
    //得到复选框中的员工
    var emp=""; //全局变量,封装员工姓名+,
    var empid="";
    function checkEmp(check){
      var empname = check.value;
      var eid=check.id;
      if(check.checked==true){
         emp+=empname+",";
         empid+=eid+",";
      }else if(check.checked==false){
        emp=emp.replace(empname+",","");
        empid=empid.replace(eid+",","");
      }else{}
      $("#look").attr("value",emp);
      $("#watcher").attr("value",empid);
    }
    
    
     //点击项目查看者按钮,显示层
    function showEmps(){
      $("#emp").show();
      $("#searchDiv").hide();
    }
    
    
    
    function refreshParent() {
  window.opener.location.href = window.opener.location.href;
  window.close();  
 }   
 
     //提交修改
     function commitupd(){
       var iscommit = "";
       var isapp = document.getElementsByName("isapprove");
       for(var i=0;i<isapp.length;i++){
         if(isapp[i].checked==true){
            iscommit=isapp[i].value;
         }
       }
       var projectname = $("#projectname").val();
       projectname = encodeURI(projectname,"utf-8");
       var cybm = $("#bm").val();
       var ckz = $("#watcher").val();
       var type = $("#type").val();
       var begintime = $("#begintime").val();
       var endtime = $("#endtime").val();
       var isapprove = $("#isapprove").val();
       var unapprove = $("#unapprove").val();
       var app = $("#app").val();
       var money=$("#money").val();
       $.post('upd2newProject.do',{'projectname':projectname,'cybm2':cybm,'ckz2':ckz,'projecttype':type,'begintime':begintime,'endtime':endtime,'isapprove2':isapprove,'unapprove':unapprove,'approver':app,'iscommit':iscommit,'money':money},function(data){
          alert("修改成功!");
          parent.location.reload();
          window.location.href="<%=request.getContextPath()%>/listnewProject.do";
       });
     }
     
    function checknum(){
		    var jd= $("#money").val();
            var reg = new RegExp("^[0-9]*$");
         if(!reg.test(jd)){
            $("#money").val(0);
            }
            if(!/^[0-9]*$/.test(jd)){
            $("#money").val(0);
            }
		}
     
   </script>
  </head>
  
  
<body onload="setdivwidth();">
	<table  width="99%" align="center"    border="0" cellspacing="0" cellpadding="0" id="tablesearch" >		
	    <tr>
	    <jsp:include page="/common/loading.jsp"></jsp:include>
	    <td class="result-border" align="center" >
	    <div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr >
				<th align="left" colspan="7">
					项目详情
				</th>
			</tr>
			<tr align="center">
			   <td>项目名称</td>
			   <td>项目发起人</td>
			   <td>项目审批人</td>
			   <td>项目资金</td>
			   <td>开始时间</td>
			   <td>结束时间</td>
			   <td>状态</td>
			</tr>
			<tr align="center">
				<td>${project.projectname}</td>
				<td>${project.launcher}</td>
				<input type="hidden" name="approver" value="${project.employee.id}"/>
				<td>${project.employee.name}</td>
				<td>${project.money}</td>
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
	    <form method="post" id="form1" onsubmit="reload1()">
		<table style="width: 98.5%;" border="0" align="center" cellpadding="0" cellspacing="5" class="tableStyle" id="youshuju" >
			<tr >
				<th align="left" colspan="2">
					编辑项目信息
				</th>
			</tr>
			<tr>
			   <th align="right">项目名称:</th>
			   <td align="left">
			    <input type="text" id="projectname" name="project.projectname" value="${project.projectname}"/>  
			   </td>
			</tr>
			<tr>
			   <th align="right">项目发起人:</th>
			   <td align="left"><input type="text" name="project.launcher" value="${project.launcher}" readonly="true"/></td>
			</tr>
			<tr>
			  <th align="right">项目类别:</th>
			  <td align="left">
			    <select name="type" id="type">
			    <option value="${project.missiontype.id}">${project.missiontype.name}</option>
			    <c:forEach items="${typelist}" var="type">
			      <option value="${type.id}">${type.name}</option>
			    </c:forEach>
			    </select>
			  </td>
			</tr>
			<tr>
			   <th align="right">开始时间:</th>
			   <td align="left"><input type="text" id="begintime" name="project.begintime" style="" value="${project.begintime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/></td>
			</tr>
			<tr>
			   <th align="right">结束时间:</th>
			   <td align="left">
			    <input type="text" name="project.endtime" id="endtime" style="" value="${project.endtime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
			   </td>
			</tr>
			<tr>
			  <th align="right">参与部门:</th>
			    <td align="left">
			    <input type="hidden" name="cm2" id="bm" value="" />
			      <textarea rows="5" cols="5" id="joindept"><c:forEach items="${prjdeptlist}" var="dept">${dept.dept.name},</c:forEach></textarea>
			      <button type="button" class="button" onclick="showdepts()"><span class="icon_add">部门</span></button>
			    </td>
			</tr>
			<tr>
			  <th align="right">查看者:</th>
			  <td align="left">
			    <input type="hidden" name="ck2" id="watcher" value=""/>
			    <textarea rows="5" cols="5" id="look"><c:forEach items="${prjemplist}" var="e">${e.emp.name},</c:forEach></textarea>
			    <button type="button" class="button" onclick="showEmps()"><span class="icon_add">员工</span></button>
			  </td>
			</tr>
			
			<tr>
			  <th align="right">是否提交审批:</th>
			  <td align="left">
			    <input type="radio" id="isapprove" name="isapprove" value="1" checked="true"/>是
			    <input type="radio" id="unapprove" name="isapprove" value="2"/>否
			  </td>
			</tr>
			<tr>
			  <th align="right">项目资金:</th>
			  <td align="left"><input type="text" name="project.money" id="money" onblur="checknum()" value="${project.money }"/>
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
			    </select>
			  </td>
			</tr>
			<tr>
			   <th align="center" colspan="2">
			      <button type="button" onclick="commitupd()" name='cha'  class="button"  ><span class="icon_save">保存</span></button>
			      <button type="button"  onclick="closeWindeows(0)"><span class="icon_close">关闭</span></button>
			   </th>
			</tr>
		</table>
		</form>
		</div>
		<div>
      <div>    	
		  <b style="float:left;"><img src="<%=path %>/icons/png/52.png" width="25" height="25"></img>附件选择</b>
		      <span style="float:right;">
			   <button type="button" id="zkfj" onclick="showfj()" style="display: none;"><span class="icon_btn_down">展开</span></button>
			   <button  type="button" id="sqfj" onclick="hidefj()" ><span  class="icon_btn_up">收起</span></button>
			  </span>
	  </div>
	    <div id="annex">
	      <jsp:include page="uploadfiles.jsp" flush="true"></jsp:include>
		</div>
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
      <c:forEach items="${elist}" var="e">
        <tr>
        <td>
          <input type="checkbox" id="${e.id}" name="${e.name}" value="${e.name}" onclick="checkEmp(this)"/>
          ${e.name}
        </td>
        </tr>
      </c:forEach>
     </table>
   </div>
   </div>
	</body>
</html>
