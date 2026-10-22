<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.fuao.fajxc.vo.Project"%>
<%@page import="com.fuao.fajxc.vo.ProjectEmp"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<%@page import="com.fuao.fajxc.dao.project.ProjectDao"%>
<%@page import="org.hibernate.criterion.Projection"%>
<%@page import="com.fuao.fajxc.dao.project.ProjectImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>项目管理列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script> 
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script language="javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
		
		<base target="_self">
		<STYLE>
			BODY {
				BACKGROUND-COLOR: #ffffff
			}
		</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		
		<SCRIPT language=javascript>
		var count=parseInt(0);
		function showInput(obj){

			var v = $("#"+obj.id).find("input,select").get(0); 

		    var inputid = v.id;
		    $("#"+inputid).css("display","");		
		}
		
		function displayIput(obj){
		  var v = $("#"+obj.id).find("input,select").get(0); 
		    var inputid = v.id;
		    var vals = $("#selecttage").val();
		    if(vals != '1'){
		    $("#"+inputid).css("display","none");
		    }
		}

		function selectcustomer(pageNo){		

			$("#form1 select").css("display","none");
			var saleOrderNo = $("#saleOrderNo").val();
			var customer = $("#customer").val();
			var realname =encodeURI(customer,"utf-8");
			var orderType = $("#ordertype").val();
			var questionname=encodeURI(orderType,"utf-8");
			var beginTime = $("#begintime").val();
			var endTime = $("#uptime").val();
			var downtime = $("#downtime").val;
			var salename=$("#salename").val();
			var sale=encodeURI(salename,"utf-8");
			var paystyle=$("#paystyle").val();
			var typename=encodeURI(paystyle,"utf-8");
			var price = $("#price").val();	
			
			//var formdata = $("#form1").serialize();
			//alert(formdata);
			//formdata = encodeURI(formdata);

			 $.ajax({
				  type: "post",
				  url: "kdqsaleOrder.do?tage=s&pageNo="+pageNo,
				  data: {
					  "saleOrderNo":saleOrderNo,
					  "customer.realName":realname,
					  "allTypeByOrdertype.questionName":questionname,
					  "beginTime":beginTime,
					  "endTime":endTime,
					  "downtime":downtime,
					  "employee.name":sale,
					  "allTypeByPayStyle.typeName":typename,
					  "price":price,
					  "allTypeByPayStatus.type":1
					  },
				  success: function(data){						  
				      
					  data1 = data.split("#");
					  $("#orderList").html(data1[0]);
					  $("#page").html(data1[1]);
					  }
				 });
			 
		}
		function showprj(id,flag){
			location.href="<%=request.getContextPath()%>/getInfoPrj.do?flag="+flag+"&id="+id;
			
		}
		function clo(){
			$("#prj").hide();
			$("#fd").hide();
			$("#sub-dept").hide();
	    }

		// 参与人的鼠标事件
		function mus(obj){
			var x=10;var y=20;
	  		$("#"+obj.id).mouseover(function(e){		  		
		  		var empid=this.name;
	  			$.ajax({
	 		       type: "POST",
	 		  	   url: "empPlanPrj.do",
	 		  	   data:{"empid":empid},
	 		  	   success: function(data){
	 		  		   var left=e.pageX+x; var top=e.pageY+y;
	 		  		   $("#cls").attr("style","position:absolute;left:"+left+"px;top:"+top+"px;width: 100px;height:15px; border:1px solid #3b6492;z-index: 20");
	 		  		   $("#cls").html(data);		 		  	   
		 		  	   $("#cls").show();
	 		  	  } 		  		   
	 			})
	  		}).mouseout(function(){
	  			$("#cls").hide();
	  		}).mousemove(function(e){
	  			var left=e.pageX+x; var top=e.pageY+y;
	  			 $("#cls").attr("style","position:absolute;left:"+left+"px;top:"+top+"px;width: 100px;height:15px; border:1px solid #3b6492;z-index: 20");
	  			
	  		});
		}

		
		// 修改项目进度条的展示
		function updatePlan(){
			var num= parseInt($("#num").val());
			count=parseInt(num)+parseInt(1);
			if(count>=10){
				  $("#num").val(count);
				  $("#jiahao").hide();
				  $("#showplan").html("");
				  $("#jindu").html("<img src='<%=request.getContextPath()%>/img/finsh.png' title='任务已完成'  width='40px' height='20px' ></img>");
			}else{
				$("#num").val(count);
				document.getElementById("upjd").style.width=count*10+'%';
			}
		}

		// 显示
		function showry(){
			$("#receiver").show();
			$("#message").show();
		}
		function clearText(){
			$("#receiver").val("");
		}
		function msg(){
			$("#msgnr").html("");
		}
		
		
		
		
		function   savepic(){   
                  if(document.all.a1==null)
                        {   
                                  objIframe=document.createElement("IFRAME");   
                                  document.body.insertBefore(objIframe);   
                                  objIframe.outerHTML=   "<iframe   name=a1   style='width:0;hieght:0'   src="+pic1.href+"></iframe>";   
                                  re=setTimeout("savepic()",1)   
                          }   
                 else
                        {   
                                  clearTimeout(re)   
                                  pic   =   window.open(pic1.href,"a1")   
                                  pic.document.execCommand("SaveAs")   
                                  document.all.a1.removeNode(true)   
                          }
                }   
		
		
		
		function downfile(filename){
		   window.location.href="/FAJxc/";
		}
		
		
</SCRIPT>
	</HEAD>
<BODY>
      <!-- 引用了显示所有人员页面 -->
	         <div style="display:none;position: absolute;left: 808px;top: 50px; z-index: 30;" id="sub-dept">
	        </div>   
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
										<c:if test="${empty tag}">&nbsp;项目管理查询</c:if>
										<c:if test="${not empty tag}">&nbsp;
											<c:if test="${state=='0' || state == ''}">查询未审批项目</c:if>
											<c:if test="${state == '１'}">查询审批未成功的项目</c:if>
											<c:if test="${state == '2'}">查询审批成功的项目</c:if>	
										</c:if>
										<a href="javascript:orderOut();" style="margin-left:40px;border:0px;">数据导出</a>
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
						<!--startprint-->
						<FORM name=form1 id="form1" action="kdqsaleOrder.do" method="post">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

							<tbody>
									<TR align="center">
									
										<TD width="5%" class=category id="tsaleOrderNo" >
											序号
										</TD>
										<TD width="12%" class=category id="tcustomer" >
											项目名称
										</TD>
										<td width="10%" class=category id="">
										      项目类型
										</td>
										<TD width="11%" class=category id="tordertype">
											项目负责人
											<input id="ordertype" name="allTypeByOrdertype.questionName" style="width:80%; display: none"/>
										</TD>
										
										<TD width="13%" class=category id="tordertype" >
										    所属部门
										</TD>
										
										<TD width="13%" class=category>
											发起时间
										</TD>
										<TD width="13%" class=category id="tbegintime">
											预计完成时间
										</TD>
										<TD width="10%" class=category id="tuptime">
											项目进度
										</TD>
										<TD width="13%" class=category id="tdowntime">
											操作
										</TD>
									</TR>
								</tbody>	
	                               <tbody id="projectlist">
									<!--循环-->
									<%
									List<Project> prjlist=(List<Project>)request.getAttribute("prjlist");
									for(int i=0;i<prjlist.size();i++){
										Project prj=prjlist.get(i);
									%>
									<tr>
									   <td align=center><%=(i+1) %> </td>
									   <td align=center><a href="javascript:showprj(<%=prj.getId()%>,0);"><%=prj.getPrjname() %></a></td>
									   <td align="center"><%= prj.getPrjtype()%></td>
									   <td align=center><%=prj.getPrjmanager() %></td>
									   <td align=center><%=prj.getDept().getName() %></td>
									   <td align=center><%=prj.getBegintime() %></td>
									   <td align=center><%=prj.getYjendtime() %></td>
									   <td align="left"><div style=" width: 100%;height:15px; border:1px solid #3b6492;">
									   
									    	<div id="" style="background-image: url('<%=request.getContextPath()%>/img/jindutiao.jpg'); width:<%=prj.getPrjplan()*10%>%; height:15px;  display: block"></div>
									     </div>
									   </td>
									   <td align=center>
									   <%
									
									   ProjectEmp pe=(ProjectEmp)request.getAttribute("pe");
									   Project project1=(Project)request.getAttribute("project1");
									   Project project2=(Project)request.getAttribute("project2");
									   Project project3=(Project)request.getAttribute("project3");
									   if(pe!=null){%>
									       <a href="javascript:showprj(<%=prj.getId()%>,1);">项目跟进</a>|
									   <%}else if(project1!=null){%><a href="javascript:showprj(<%=prj.getId()%>,1);">项目跟进</a>|<%}
									   else if(project2!=null){%><a href="javascript:showprj(<%=prj.getId()%>,1);">项目跟进</a>|<%}
									   else if(project3!=null){%><a href="javascript:showprj(<%=prj.getId()%>,1);">项目跟进</a>|<%}
									   else{%>
									                项目跟进|
									   <%} %>
									    <a href="<%=request.getContextPath() %>/getAllInfoPrj.do?id=<%=prj.getId() %>">详细信息</a>
									        
									   </td>
								
									</tr>
									<%} %>
								</tbody>
								<tr>
								<td class=category colSpan=14 height=30></td>
								</tr>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD id="page">
							<p:pages url="getAllPrj.do?funid=14"/>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE> 
		
	
	<%
	   // 项目管理详细信息的弹出层
	   Project prj=(Project)request.getAttribute("prj");
	   String flag=(String)request.getAttribute("flag");
	   List<Map<String, String>> emplist=(List<Map<String, String>>)request.getAttribute("emplist");
	   if(prj!=null&&flag.equals("0")){ %>
	   <div id="fd" style="display:show;filter:alpha(opacity=100);opacity:1;">
       <div class="contentup"> 	
		<div id="prj">
		    <table class="toptable grid" style="width: 500px;" cellSpacing=1 cellPadding=4
								align=center border=1>
		        <tr>
		           <td align="center" colspan="2">项目详细信息</td>
		        </tr>
		        <tr>
		           <td align="right">项目名称：</td>
		           <td>${prj.prjname }</td>
		        </tr>
		        <tr>
		           <td align="right">项目负责人：</td>
		           <td>${prj.prjmanager }</td>
		        </tr>
		        <tr>
		           <td align="right">参与人：</td>
		           <td height="50px">
		             <%
		                for(int i=0;i<emplist.size();i++){
		                	Map<String,String> mp=emplist.get(i);
		             %>
		              <a href="#"><%=mp.get("ename") %></a>&nbsp;&nbsp;&nbsp;
		             <%}%>
		           </td>
		        </tr>
		         <tr>
		           <td align="right">项目进度：</td>
		           <td><div style="width: 100px;height:15px; border:1px solid #000; ">
		            <c:if test="${prj.prjplan==10}">
		              <img src="<%=request.getContextPath()%>/img/finsh.png" title="任务已完成"></img>
		           </c:if>
		           <c:if test="${prj.prjplan!=10}">		             
					 <div id="" style="background-image: url('<%=request.getContextPath()%>/img/jindutiao.jpg'); width:<%=prj.getPrjplan()*10%>%; height:15px;  display: block"></div>
                   </c:if></div>
		           </td>
		        </tr>
		        <tr>
		           <td align="right">领导：</td>
		           <td>${prj.leadname }</td>
		        </tr>
		        <tr>
		           <td align="right">领导评价：</td>
		           <td>${prj.leadevaluate }</td>
		        </tr>
		        <tr>
		           <td align="right">项目功能：</td>
		           <td>${prj.prjfunction}</td>
		        </tr>
		        <tr>
		           <td align="right">项目描述：</td>
		           <td>${prj.prjdes}</td>
		        </tr>
		        <tr>
		           <td align="right">预计完成时间：</td>
		           <td>${prj.yjendtime }</td>
		        </tr>
		        <tr>
		           <td colspan="2" align="center"><input type="button" value="关闭" style="background-color:#eef7fe; " onclick="clo()" /></td>
		        </tr>
		    </table>
		</div>
		</div>
        </div>
		<%}if(prj!=null&&flag.equals("1")){%>
		<div id="fd" style="display:show;filter:alpha(opacity=100);opacity:1;">
        <div class="contentup">
		<div id="prj"><form action="updatePrj.do" method="post">
		    <table class="toptable grid" style="width: 500px;" cellSpacing=1 cellPadding=4
								align=center border=1>
		        <tr>
		           <td align="center" colspan="2"><h3>项目跟进</h3></td>
		        </tr>
		        <tr>
		           <td align="right">项目名称：</td>
		           <td>${prj.prjname }</td>
		        </tr>
		        <tr>
		           <td align="right">项目负责人：</td>
		           <td>${prj.prjmanager}</td>
		        </tr>
		        <tr>
		           <td align="right">参与人：</td>
		           <td height="50px">
		             <%
		                for(int i=0;i<emplist.size();i++){
		                	Map<String,String> mp=emplist.get(i);
		             %>
		              <a href="<%=request.getContextPath()%>/empinfoPrj.do?empid=<%=mp.get("empid") %>" id="empinfo<%=mp.get("empid") %>" name="<%=mp.get("empid") %>" onmouseover="mus(this)" ><%=mp.get("ename") %></a>&nbsp;&nbsp;
		             <%}%>
		             <input type="text" name="cn" id="receiver" value="点击我选择员工..." onclick="clearText()" style="display: none;">
		             <input type="hidden" name="cyrid" id="ryid" value="">
		             <input type="button" value="邀请" style="background-color:#eef7fe;"  onclick="showry()" >
		           </td>
		        </tr>
		        <tr id="message" style="display: none;">
		            <td align="right">消息内容：</td>
		            <td align="left">
		               <textarea  rows="3" cols="30" id="msgnr" onclick="msg()">请输入邀请消息的内容...</textarea>
		            </td>
		        </tr>
		         <tr>
		           <td align="right">项目进度：<input type="hidden" id="num" name="project.prjplan" value="${prj.prjplan }"></td>
		           <td id="jindu">
		           <c:if test="${prj.prjplan==10}">
		              <img src="<%=request.getContextPath()%>/img/finsh.png" title="任务已完成" width="40px" height="20px"></img>
		           </c:if>
		           <c:if test="${prj.prjplan<10}">
			           <div id="showplan" style="width: 100px;height:15px; border:1px solid #3b6492; ">		          
			                <% 
						        int count=0;
						        for(int j=0;j<prj.getPrjplan();j++){
						    	 count= prj.getPrjplan()*10;
						    	}
							%> 
							<div id="upjd" style="background-image: url('<%=request.getContextPath()%>/img/jindutiao.jpg'); width:<%=count%>%; height:15px;  display: block"></div>
			           </div>
		              </c:if>
		              <span id="bf" style="color:red;">
		                  <%=prj.getPrjplan()*10%>%
		              </span>
		              <c:if test="${prj.prjplan<10}">
		              <span style="color:red;" id="jiahao">
		                 <img src="<%=request.getContextPath() %>/img/jiahao2.png" width="18" height="17" title="修改项目进度" style="position:relative;left:50px; cursor: pointer;" onclick="updatePlan()" ></img>
		              </span>
		              </c:if>
		           </td>
		        </tr>
		        <tr>
		           <td align="right">领导评价：</td>
		           <td><textarea name="project.leadevaluate" rows="3" cols="30"></textarea></td>
		        </tr>
		        <tr>
		           <td align="right">项目功能：</td>
		           <td><textarea name="project.prjfunction" rows="3" cols="30">${prj.prjfunction}</textarea></td>
		        </tr>
		        <tr>
		           <td align="right">项目描述：</td>
		           <td><textarea name="project.prjdes" rows="3" cols="30">${prj.prjdes}</textarea></td>
		        </tr>
		        <tr>
		           <td align="right">预计完成时间：</td>
		           <td><input name="project.yjendtime" value="${prj.yjendtime }"  onclick="WdatePicker()"> </td>
		        </tr>
		        <tr>
		           <td colspan="2" align="center">
		              <input type="button" value="关闭" style="background-color:#eef7fe; " onclick="clo()" />
		              <input type="submit" value="提交" style="background-color:#eef7fe;"/>
		              <input type="reset" value="重置" style="background-color:#eef7fe;"/>
		           </td>
		        </tr>
		    </table>
		    </form>
		</div>
		</div>
        </div>
		<%}%>
		
      <script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>  
       <script type="text/javascript">
		   $("#sub-dept").load("alldeptmessageDepartment.do");
		   $(function(){
		      $("#receiver").click(function(){
		          $("#sub-dept").show();
		      });
		       $("#specialty,#lend,#endtime").click(function(){
		          $("#sub-dept").hide();
		      });
		   })
		 </script>
      <div id="cls" style=''></div>
	</BODY>
</HTML>
