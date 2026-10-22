<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
  <style type="text/css">
  table th{text-align: right;}
  </style>
    <title>待审批项目</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
	   // 修改任务进度
		function updateTask(){
            var url = "<%=path%>/newproject/task/updateTaskPlan.jsp";
			showWindwoButton('id','修改任务进度','800','550',url);
		}
		function hideEdit(){
			$("#fd").hide();
			$("#content").html("");
		}
		// 输入审批意见
		function writeYJ(approveid,status){
		    var loginemp = $("#emp").val(); //登录人id
		    var appemp = $("#appemp").val(); //项目审批人id
		    if(status==1 && loginemp==appemp){ //to
		        $("#mydiv").show();
				$("#fd").show();
				var appmoney = $("#approvemoney").val();
				$("#m").val(appmoney);
				$("#approveid").val(approveid);
				$("#status").val(status);
		    }
		    
		    if(status==0 || status==2){
		       $("#mydiv").hide();
			   $("#fd").show();
			   $("#m").val(appmoney);
			   $("#approveid").val(approveid);
			   $("#status").val(status);
			   
		    }
		    //如果登录人是当前项目的审批人
		   if(loginemp==appemp){
			   if(status==2){
			    $("#mydiv").show();
				$("#fd").show();
				var appmoney = $("#approvemoney").val();
				$("#m").val(appmoney);
				$("#approveid").val(approveid);
				$("#status").val(status);
				}
			}
			//如果登录人不是当前项目的审批人
			if(loginemp!=appemp){
			  $("#mydiv").hide();
			   $("#fd").show();
			   $("#m").val(appmoney);
			   $("#approveid").val(approveid);
			   $("#status").val(status);
			}
			
		}
		// 查询
		function showPage(dc){
			var prjname= encodeURI(encodeURI($("#prjname").val(),"utf-8"));
			var begintime=$("#begintime").val();
			var endtime=$("#endtime").val();
			form1.action="<%=path %>/waitProjectApprovalProject.do?projectname="+prjname+"&begintime="+begintime+"&endtime="+endtime+"&dc="+dc;
			form1.submit();
		}
		//查看项目的详细信息
		function projectInfo(id){
		  window.location.href="<%=request.getContextPath()%>/projectInfonewProject.do?proid="+id;
		}

		// 审批
		function app(){
		alert("审批");
		var status=$("#status").val();
			var approveid=$("#approveid").val();
//			var status=$("#status").val();
			//申请人id
			var sqrid = $("#sqr").val();
			var ckzid = $("#watcher").val();
			var money = $("#money").val();
			//项目id
			var pid = $("#pid").val();
			var content1=$("#content").val();
			var content=encodeURI(encodeURI(content1,"utf-8"));
			form2.action="<%=path%>/appRecordApprovalProject.do?approveid="+approveid+"&status="+status+"&content="+content+"&sqrid="+sqrid+"&ckzid="+ckzid+"&money="+money+"&pid="+pid;
			alert(form2.action);
			form2.submit(); 
		}
		
		
		
		function showemp2(){
           $.post('emplistnewProject.do',{},function(data){
	          $("#tab2").append(data);
          });
           $("#empdiv").show();
      }
   
 
    
      var emp=""; 
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
    
    function hideemps(){
      $("#empdiv").hide();
    }

    function shuzi(inputname){
		var zhi=document.all(inputname).value;
			if(zhi.length>0 && isNaN(zhi)==true){
			document.all(inputname).value=zhi.substring(0,zhi.length-1);
			shuzi(inputname);
			}
	}
	
   </script>
  </head>
  
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<input name="daonum" value="1" type="hidden" />
			<input name="curpage" id="curpage" type="hidden" value="" />
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						项目名称：
					</th>
					<td>
						<input type="text" id="prjname" name="projectname" value="${projectname }" />
					</td>
					<th>
					        项目周期：
					</th>
					<td><input type="text" id="begintime" name="begintime" class="Wdate" style="width: 90px;" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" value="${begintime}" />
				                    至<input type="text" id="endtime" name="endtime" class="Wdate" style="width: 90px;" onclick="WdatePicker()" value="${endtime}" />
				  　　</td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showPage(0)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showPage(1)"  ><span    class=icon_xls>导出</span></button>
					</td>
				</tr>
				<tr>
				   <td align="left" ><img src="<%=request.getContextPath() %>/icons/png/26.png" width="20px" height="20px" style="float: left;"></img><h3><a href="appRecordListApprovalProject.do" title="点击查看项目审批记录">审批记录</a></h3></td>
				 <td><h3>
				 	<a href="listnewProject.do" title="回到我的项目">我的项目</a></h3>
				 </td>
				 <td><h3>
				 <a href="waitProjectApprovalProject.do" title="回到待批项目">待批项目</a></h3>
				 </td>
				</tr>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight">
		 <span>您现在的位置：<a href="<%=path %>/listnewProject.do">我的项目</a>》待批项目</span>
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>项目名称</th>
			 <th>申请人</th>
			 <th>开始日期</th>
			 <th>结束日期</th>
			 <th>审批人</th>
			 <th>审批最大金额</th>
			 <th>项目资金</th>
			 <th>操作</th>
			</tr>
			<c:forEach items="${waitprj}" var="approve">
				<tr>
				   <td align=middle>
			           <a style="text-decoration: none;" title="点击查看该项目详细信息" href="javascript:projectInfo('${approve.newproject.id}')">
			           ${approve.newproject.projectname}</a>
			           
				       <input type="hidden" id="emp" value="${employee.id }"/>
				       <input type="hidden" id="appemp" value="${approve.approveemp.id }"/>
				       <input type="hidden" id="pid" value="${approve.newproject.id }"/>
				       <input type="hidden" id="sqr" value="${approve.applypeople.id }"/>
				       <input type="hidden" id="approvemoney" value="${oneMoney}"/>
			       </td>
				   <td>${approve.applypeople.name }</td>
				   <td>${approve.newproject.begintime }</td>
				   <td>${approve.newproject.endtime }</td>
				   <td>${approve.approveemp.name }</td>
				   <td>${oneMoney}</td>
				   <td>${approve.newproject.money }.${approve.appstatus }</td>
				   <c:if test="${approve.applypeople.id!=employee.id or approve.approveemp.id==employee.id and approve.appstatus==0}">
				   <td>
				      <c:if test="${oneMoney>=approve.newproject.money and approve.appstatus!=1 and approve.appstatus!=2}">
				         <a href="javascript:void(0);" onclick="writeYJ(${approve.id},1);" title="点击审批项目" >通过</a>&nbsp;&nbsp;&nbsp;
				      </c:if>
				      <c:if test="${oneMoney<approve.newproject.money and approve.appstatus!=1 and approve.appstatus!=2 and employee.empNo!='12003'}">
				         <a href="javascript:void(0);" onclick="writeYJ(${approve.id},2);" title="点击审批项目" >通过并上报</a>&nbsp;&nbsp;&nbsp;
				      </c:if>
				       <c:if test="${oneMoney<approve.newproject.money and approve.appstatus!=1 and approve.appstatus!=2 and employee.empNo=='12003'}">
				         <a href="javascript:void(0);" onclick="writeYJ(${approve.id},1);" title="点击审批项目" >通过</a>&nbsp;&nbsp;&nbsp;
				      </c:if>
				      <c:if test="${approve.appstatus==0}">
				         <a href="javascript:void(0);" onclick="writeYJ(${approve.id},0);"  title="请填写拒绝原因">拒绝</a>
				      </c:if>
				      <c:if test="${approve.appstatus==1}">
				      	<c:if test="${approve.temp==''||approve.temp==null}">通过审批</c:if>
				      	<c:if test="${approve.temp!=''&&approve.temp!=null}"><a href="javascript:void(0)" title="${approve.temp }"><font color="red">通过审批</font></a></c:if>
				      	</c:if>
				      <c:if test="${approve.appstatus==2}">以上报、审批</c:if>
				   </td>
				   </c:if>
				   <c:if test="${approve.applypeople.id==employee.id and approve.approveemp.id!=employee.id }">
				   <td>
				      <c:if test="${approve.appstatus==0}">未审批</c:if>
				      <c:if test="${approve.appstatus==1}">
							<c:if test="${approve.temp==''||approve.temp==null}">通过审批</c:if>
				      	<c:if test="${approve.temp!=''&&approve.temp!=null}"><a href="javascript:void(0)" title="${approve.temp }"><font color="red">通过审批</font></a></c:if>
						</c:if>
				      <c:if test="${approve.appstatus==2}">以上报、审批</c:if>
				   </td>
				   </c:if>
				   <c:if test="${approve.applypeople.id==approve.approveemp.id and approve.appstatus==1}">
					   <td>
					             <c:if test="${approve.temp==''||approve.temp==null}">通过审批</c:if>
				      	<c:if test="${approve.temp!=''&&approve.temp!=null}"><a href="javascript:void(0)" title="${approve.temp }"><font color="red">通过审批</font></a></c:if>
					   </td>
				   </c:if>
				   <c:if test="${approve.applypeople.id==approve.approveemp.id and approve.appstatus==2}">
					   <td>
					                以上报、审批
					   </td>
				   </c:if>
				</tr>
			</c:forEach>
			<tr>
				<td id="page" colspan="8" align="center"><p:pages url="waitProjectApprovalProject.do?&funid=14" /></td>
			</tr>
		</table></div>
		
		<!-- 弹出内容 -->
		<form action="" name="form2" id="form2" method="post">
			<div id="fd" style="display:none; filter:alpha(opacity=100);opacity:1;float: right;" >
				<table style="width:100%; text-align: center; height: 150px;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
				     <tr>
				        <th align="left" colspan="2">
				        	审批意见：
						   	<input type="hidden" name="approveid" id="approveid" value="" />
						   	<input type="hidden" name="status" id="status" value="" />
				        </th>
				     </tr>
				     <tbody id="mydiv" style="display: none">
				     <tr>
				       <td align="right" width="25%">负责人审批最大金额:</td>
				       <td align="left" width="75%"><input type="text" id="m" readonly="true"/></td>
				     </tr>
				     <tr>
				       <td align="right">修改项目负责人审批最大金额:</td>
				       <td align="left"><input type="text" id="money" name="maxmoney" value="" onkeyup="shuzi('maxmoney')"/>
					      
					   </td>
					</tr>
				     <tr>
					 <td align="right">项目查看者:</td>
				      <td align="left">
				      <input type="hidden" name="ckz" id="watcher"/>
				      <textarea id="look" name="" cols="10" rows="5" readonly="true"></textarea>
				      <button type="button" onclick="showemp2()"><span class="icon_add">添加</span></button>
					 
				      </td>
				    </tr>
				     </tbody>
		             <tr>
		                <td align="right">审批意见:</td>
		                <td align="left"><textarea name="content" id="content"  style='width:450px;height:150px;'></textarea></td>
		             </tr>
		             <tr>
		                <td align="center" colspan="2">
		                   <button type="button" onclick="app()"><span class="icon_save">保存</span></button>
		                   <button type="button" onclick="hideEdit()"><span class="icon_close">关闭</span></button>
		                </td>
		             </tr>
				</table>
				<script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
			</div>
		</form>
		
		
    <div id="empdiv" style="position: absolute;left: 760px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
		   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
		     <div style="float:left;font-weight:bold;">选择员工列表</div>
		     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideemps();" style="text-decoration: none;">关闭</a></div>
		   </div>
		    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
		     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
		     </table>
		   </div>
   </div>
		
		
		
	</body>
</html>
