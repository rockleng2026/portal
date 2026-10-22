<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="com.fuao.fajxc.vo.ProjectEmp"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>项目流程页面</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showDialog.js" ></script>
		<script language="javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
		
		
		
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	    <LINK href="<%=request.getContextPath() %>/Css/desk/desktop.css" type=text/css media=screen
			rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/desk/mode.css" type=text/css media=screen
			rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
		BODY {
			BACKGROUND-COLOR: #ffffff
		}
		</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0"/>  

		<SCRIPT type="text/javascript">

		   window.onload=resizeDiv;    //页面加载时调用resizeDiv()函数
		   window.onresize=resizeDiv;    //页面大小变化时调用resizeDiv()函数
		   window.onscroll=resizeDiv;    //页面滚动条被拖动时调用resizeDiv()函数 
		   function resizeDiv(){   
		   var obj=document.getElementById("eMeng"); 
		   try{   
		   divHeight=parseInt(obj.offsetHeight,10); 
		   divWidth=parseInt(obj.offsetWidth,10);   
		   docWidth=document.body.clientWidth;   
		   docHeight=document.body.clientHeight;   
		   obj.style.top=docHeight-divHeight+parseInt(document.body.scrollTop,10);   
		   obj.style.left=docWidth-divWidth+parseInt(document.body.scrollLeft,10);   
		   }   
		   catch(e){}   
		   } 
		   
		   function showfd(){
			   $("#fd").hide();
		   }

		// 参与人的鼠标事件		
		function mus(obj){
			var x=130;var y=-20;			
	  		$("#"+obj.id).mouseover(function(e){
		  		var id=this.name;
	  			$.ajax({
	 		       type: "POST",
	 		  	   url: "processInfoPrj.do",
	 		  	   data:{"id":id},
	 		  	   success: function(data){
	 		  		   $("#cls").html(" ");
		 		  		$("#cls").html(" ");
		 		  		$("#cls").html(" ");
	 		  		   $("#cls").html(data);
	 		  		   var left=e.pageX+x; var top=e.pageY+y;
	 		  		   $("#cls").attr("style","position:absolute;left:"+left+"px;top:"+top+"px;width: 300px;height:15px; border:1px solid #000;z-index: 20");		 		  	   
		 		  	   $("#cls").show();
	 		  	  } 		  		   
	 			})
	  		}).mouseout(function(){
	  			$("#cls").html("");
	  			$("#cls").hide();
	  			$("#cls").hide();
	  			$("#cls").hide();
	  		}).mousemove(function(e){
	  			var left=e.pageX+x; var top=e.pageY+y;
	  			 $("#cls").attr("style","position:absolute;left:"+left+"px;top:"+top+"px;width: 300px;height:15px; border:1px solid #000;z-index: 20");
	  			
	  		});
		}

		function fdshow(){
			$("#fd").show();
		}
		function fdhide(){
			$("#fd").hide();
			$("#ldpj").hide();
		}
		function ld(){
			$("#ldpj").hide();
		}
		function clearCot(){
			$("#content").html("");
		}
		function showldprj(obj){
			$("#content").html("");
			$("#ldpj").show();
			// 人员任务编号
			var prjempid=obj.name;
			$("#prjemp").val(prjempid);
		}
		// 判断查询时间
		function changeDate(zd,flag){
			var jt= $("#jt").val();
			var prjid= $("#prjid").val();
			var zt=$("#flag").val();
			if(zt=="prjzt"){
				if(jt.length>0){
					$.ajax({
						type: "POST",
		 		  	   url: "processByTimePrj.do",
		 		  	   data:{"zd":zd,"prjid":prjid,"time":jt},
		 		  	   success: function(data){
			 		  	   if(flag==0){
				 		  	   $("#prjzt").html("");
				 		  	   $("#prjzt").html(data);
			 		  	   }
			 		  	   if(flag==1){
				 		  	   $("#vitezt").html("");
				 		  	   $("#vitezt").html(data);
			 		  	   }
		 		  	   } 		  		  
					})
				}
			}
			if(zt=="myzt"){
				if(jt.length>0){
					$.ajax({
						type: "POST",
		 		  	   url: "myprocessByTimePrj.do",
		 		  	   data:{"prjid":prjid,"time":jt},
		 		  	   success: function(data){
			 		  	   if(flag==0){
				 		  	   $("#myzt").html("");
				 		  	   $("#myzt").html(data);
			 		  	   }
			 		  	   if(flag==1){
				 		  	   $("#vitezt").html("");
				 		  	   $("#vitezt").html(data);
			 		  	   }
		 		  	   } 		  		  
					})
				}
			}
		}
		// 判断查询时间
		function changeDate2(zd,flag){
			var jt= $("#jt2").val();
			var prjid= $("#prjid").val();
			if(jt.length>0){
				$.ajax({
					type: "POST",
	 		  	   url: "processByTimePrj.do",
	 		  	   data:{"zd":zd,"prjid":prjid,"time":jt},
	 		  	   success: function(data){
		 		  	   if(flag==0){
			 		  	   $("#prjzt").html("");
			 		  	   $("#prjzt").html(data);
		 		  	   }
		 		  	   if(flag==1){
			 		  	   $("#vitezt").html("");
			 		  	   $("#vitezt").html(data);
		 		  	   }
	 		  	   } 		  		  
				})
			}
		}
		// 月查
		function yuedt(obj,flag){
			var y= $("#"+obj.id).val();
			var prjid= $("#prjid").val();
			var zd=obj.name;
			var zt=$("#flag").val();
			if(zt=="prjzt" || zt=="vitezt"){
				$.ajax({
					type: "POST",
	 		  	   url: "processByTimePrj.do",
	 		  	   data:{"zd":zd,"prjid":prjid,"yue":y},
	 		  	   success: function(data){
	 	 		  	   if(flag==0){
			 		  	   $("#prjzt").html("");
			 		  	   $("#prjzt").html(data);
	 	 		  	   }
	 	 		  	   if(flag==1){
			 		  	   $("#vitezt").html("");
			 		  	   $("#vitezt").html(data);
		 		  	   }
	 		  	   } 		  		  
				})
			}if(zt=="myzt"){
				$.ajax({
					type: "POST",
	 		  	   url: "myprocessByTimePrj.do",
	 		  	   data:{"prjid":prjid,"yue":y},
	 		  	   success: function(data){
	 	 		  	   if(flag==0){
			 		  	   $("#myzt").html("");
			 		  	   $("#myzt").html(data);
	 	 		  	   }
	 	 		  	   if(flag==1){
			 		  	   $("#vitezt").html("");
			 		  	   $("#vitezt").html(data);
		 		  	   }
	 		  	   } 		  		  
				})
			}
		}
		//年查询
		function yeardt(zd,flag){
			var prjid= $("#prjid").val();
			var zt=$("#flag").val();
			if(zt=="prjzt" || zt=="vitezt"){
				$.ajax({
					type: "POST",
	 		  	   url: "processByYearPrj.do",
	 		  	   data:{"zd":zd,"prjid":prjid},
	 		  	   success: function(data){
	 		  			if(flag==0){
			 		  	   $("#prjzt").html("");
			 		  	   $("#prjzt").html(data);
		 		  	    }
		 	 		  	if(flag==1){
				 		  	   $("#vitezt").html("");
				 		  	   $("#vitezt").html(data);
			 		  	}
	 		  	   } 		  		  
				})
			}
			if(zt=="myzt"){
				$.ajax({
					type: "POST",
	 		  	   url: "myprocessByYearPrj.do",
	 		  	   data:{"zd":zd,"prjid":prjid},
	 		  	   success: function(data){
	 		  			if(flag==0){
			 		  	   $("#myzt").html("");
			 		  	   $("#myzt").html(data);
		 		  	    }
		 	 		  	if(flag==1){
			 		  	   $("#vitezt").html("");
			 		  	   $("#vitezt").html(data);
			 		  	}
	 		  	   } 		  		  
				})
			}
		}
		// 提交领导评价
		function sublead(){
			var prjempid= $("#prjemp").val();
			var content=$("#content").val();
			content=encodeURI(content,"utf-8");
			$.ajax({
			   type: "POST",
 		  	   url: "addLeadPjPrj.do",
 		  	   data:{"prjempid":prjempid,"content":content},
 		  	   success: function(data){
 		  		   $("#ldpj").hide();
 		  	   } 		  		  
			})
		}	
       // 领导跟进
       function leadgj(){
           var prjid=$("#prjid").val();
           $.ajax({
			   type: "POST",
 		  	   url: "leadGjPrj.do",
 		  	   data:{"prjid":prjid},
 		  	   success: function(data){
 	 		  	   alert("您已成功跟进到了这个项目。");
 		  	   } 		  		  
			})
       }	

       // 显示我的动态
       function showmy(){
           $("#myzt").show();
           $("#prjzt").hide();
           $("#flag").val("myzt");
       }
       // 显示项目最新的动态
       function showprjnew(){
    	   $("#myzt").hide();
           $("#prjzt").show();
           $("#flag").val("prjzt");
       }
       // 邀请信息
       function vite(){
    	   $("#flag").val("vitezt");
       }  
       
		</SCRIPT> 
		
	</HEAD>
	<BODY style="overflow-y:scroll; ">
		<FORM  id ="form1" name=form1 action="addcommodityTpye.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed 
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE  cellSpacing=0 cellPadding=0 width="100%">
								<TBODY>
									<TR>
										<TD>
											&nbsp;项目管理流程信息(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>		
						</TD>	
						<tr align="center">
						 <TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>								
								<TBODY>							
								  <TR>
										<TD align="center"><h3>项目管理详细信息</h3></TD>
								  </TR>	
								  </TBODY></TABLE>
						</tr>
						
                       <tr align="center">
						 <div functionid="FUNC00012" urlname="待我审批" recordcount="5"
							minflg="0"  id="FUNC00012" style="float: left;">
							<DIV ID=Block style="width: 580px; float: left;">
								<DIV style="background-color:#eef7fe; ">
									<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
										WIDTH=100%>
										<TR VALIGN=center>
											<TD WIDTH=25>
												<img border="0" width="15" height="15"
													src="<%=request.getContextPath() %>/images/desk/FUNC00012.gif" />
											</TD>
											<td>
												<b style="cursor: pointer;" onmouseover="showprjnew()">项目最新动态</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<b id="my" style="cursor: pointer;" onmouseover="showmy()">我的地盘</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</td>
										</TR>
									</TABLE>
								</DIV>
								<div style="padding: 0pt;" urlname="项目更新动态" urlvalue="Oasp2803"
									recordcount="5"  class="BlockMemo" >
									<div id="BlockDetail">
										<ul style="text-align: left;">											
												<li class="DetailLine">
													根据条件查询状态
												</li>
												<li class="DetailLine">
												          日期：<input type="text" id="jt" value="" name="prjuptime"  onclick="WdatePicker(),changeDate('prjuptime','0')" style="height: 15px; width:90px;" >&nbsp;&nbsp;
												          月动态：<select id="yue" onchange="yuedt(this,0)" name="prjuptime">
												             <option value="1">1月</option><option value="2">2月</option><option value="3">3月</option><option value="4">4月</option><option value="5">5月</option>
												             <option value="6">6月</option><option value="7">7月</option><option value="8">8月</option><option value="9">9月</option><option value="10">10月</option>
												             <option value="11">11月</option><option value="12">12月</option>
												          </select>&nbsp;&nbsp;
												          <input type="button" onclick="yeardt('prjuptime',0)"  value="年动态" style="background-color:#eef7fe; " />    
												</li>
												 
												<div id="prjzt">
												<c:if test="${uplist!=null}">
												<c:forEach items="${uplist}" var="prjemp" varStatus="count" end="3">
												<li class="DetailLine">
													<!-- 动态内容 -->
													<div class="DetailLineInfo">
														<img src="<%=request.getContextPath() %>/images/desk/list.gif" border="0" height="8"
															width="8">
														<a href="#">${count.count}:${prjemp.employee.name }</a>
													</div>
													<!-- 操作时间 -->
													<div class="DetailLineName">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														${prjemp.prjuptime }更新了项目${prjemp.prj.prjname }，项目进度：<font color="red">${prjemp.prjempplan*10 }%</font>
														领导评价： <font color="blue">${prjemp.leadevaluate }</font>
													</div>
												</li>
												</c:forEach>
												</c:if>
												<c:if test="${uplist==null}">
												    <li class="DetailLine"> <div class="DetailLineInfo" align="center">
														<img src="<%=request.getContextPath() %>/images/desk/list.gif" border="0" height="8"
															width="8">
														<a href="#">暂时没有动态信息</a>
													</div></li>
												</c:if>
												</div>		
												<div id="myzt" style="display: none;">
												<c:if test="${mylist!=null}">
												<c:forEach items="${mylist}" var="prjemp" varStatus="count" end="4">
												<li class="DetailLine">
													<!-- 动态内容 -->
													<div class="DetailLineInfo">
														<img src="<%=request.getContextPath() %>/images/desk/list.gif" border="0" height="8"
															width="8">
														<a href="#">${count.count}:${prjemp.prj.prjname }</a>
													</div>
													<!-- 操作时间 -->
													<div class="DetailLineName">
														${prjemp.prjuptime }提交了项目，我的任务进度：<font color="red">${prjemp.prjempplan*10 }%</font>
														领导评价： <font color="blue">${leadpj }</font>
													</div>
												</li>
												</c:forEach>
												</c:if>
												<c:if test="${mylist==null}">
												    <li class="DetailLine"> <div class="DetailLineInfo" align="center">
														<img src="<%=request.getContextPath() %>/images/desk/list.gif" border="0" height="8"
															width="8">
														<a href="#">暂时没有动态信息</a>
													</div></li>
												</c:if>
												</div>						
										</ul>
									</div>
								</div>
								<div>
									<div style="background-color:#eef7fe; text-align: right; ">
										<img src="<%=request.getContextPath() %>/images/desk/more.gif" border="0" height="8"
											width="9">
										<a href="#">更多...</a>
									</div>
								</div>
							</DIV>
							
							<!-- 邀请参与人动态 -->
							<DIV ID=Block style="width: 580px; float: right;">
								<DIV style="background-color:#eef7fe; ">
									<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 HEIGHT=100%
										WIDTH=100%>
										<TR VALIGN=center>
											<TD WIDTH=25>
												<img border="0" width="15" height="15"
													src="<%=request.getContextPath() %>/images/desk/FUNC00012.gif" />
											</TD>
											<td>
												<b>邀请最新动态</b>
											</td>
										</TR>
									</TABLE>
								</DIV>
								<div style="padding: 0pt;" urlname="邀请最新动态" urlvalue="Oasp2803"
									recordcount="5" class="BlockMemo" id="FUNC00004MAX" onmousemove="vite()">
									<div id="BlockDetail">
										<ul style="text-align: left;">											
												<li class="DetailLine">
													邀请条件查询状态
												</li>
												<li class="DetailLine">
												          日期：<input type="text" value="" id="jt2" name="prjvitetime"  onclick="WdatePicker(),changeDate2('prjvitetime','1')"  style="height: 15px; width:90px;" >&nbsp;&nbsp;
												          月动态：<select id="yue1" onchange="yuedt(this,1)" name="prjvitetime">
												             <option value="1">1月</option><option value="2">2月</option><option value="3">3月</option><option value="4">4月</option><option value="5">5月</option>
												             <option value="6">6月</option><option value="7">7月</option><option value="8">8月</option><option value="9">9月</option><option value="10">10月</option>
												             <option value="11">11月</option><option value="12">12月</option>
												          </select>&nbsp;&nbsp;
												          <input type="button"  value="年动态" onclick="yeardt('prjvitetime',1)" style="background-color:#eef7fe; " />    
												</li>
												<div id="vitezt">
												<c:if test="${vitelist!=null}">
												<c:forEach items="${vitelist}" var="prjemp" varStatus="count" end="4">
												<li class="DetailLine">
													<!-- 动态内容 -->
													<div class="DetailLineInfo">
														<img src="<%=request.getContextPath() %>/images/desk/list.gif" border="0" height="8"
															width="8">
														<a href="#">${count.count}:${prjemp.prj.prjname}</a>
													</div>
													<!-- 操作时间 -->
													<div class="DetailLineName">
													    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														${prjemp.prjvitetime}&nbsp;&nbsp;&nbsp;${prjemp.prj.prjmanager}邀请${prjemp.employee.name}参与${prjemp.prj.prjname}项目。
														邀请原因： ${prjemp.invite }
													</div>
												</li>
												</c:forEach>
												</c:if>
												<c:if test="${vitelist==null}">
												     <li class="DetailLine"> <div class="DetailLineName"> 暂时没有动态信息</div></li>
												</c:if>
												</div>
										</ul>
									</div>
								</div>
								<div>
									<div style="background-color:#eef7fe;text-align:right; ">
										<img src="<%=request.getContextPath() %>/images/desk/more.gif" border="0" height="8"
											width="9">
										<a href="#">更多...</a>
									</div>
								</div>
							</DIV>							
						</div>
						
					  </tr>				
					<TR>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>								
								<TBODY>
							
								  <TR>
										<TD width="25%" height=30 align=right>项目名称：</TD>
										<TD width="25%" class=category>
										    	${project.prjname }
										    	<input type="hidden" id="prjid" value="${project.id }">
										    	<input type="hidden" name="prjemp" id="prjemp" value="">
										    	<input type="hidden" id="flag" value="prjzt">
										</TD>
										<TD width="25%"  align=right height=30>
											项目负责人：
										</TD>
										<TD width="25%"  class=category >
										         ${project.prjmanager }
										</TD>
								  </TR>	
									<TR>
										<TD width="25%"  align=right height=30>
											发起人：
										</TD>
										<TD width="25%" class=category  align=left height=30>
											  ${project.startperson }
										</TD>
										<TD width="25%"  align=right height=30>
											项目类型：
										</TD>
										<TD width="25%"  class=category>
										  ${project.prjtype }
										</TD>										
									</TR>
									<TR>
										<TD width="25%"  align=right height=30>
											所属部门：
										</TD>
										<TD width="25%"  class=category>
										    ${project.dept.name }
										</TD>
										<TD width="25%"  align=right height=30>
											开始时间:
										</TD>
										<TD width="25%"  class=category>
										   ${project.begintime }
										</TD>
									</TR>
									<TR>
										<TD width="25%"  align="right" height=30>
											结束时间:
										</TD>
										<TD width="25%"  class=category>
										    ${project.endtime }
										</TD>										
										<TD width="25%"  align="right" height=30>
											预计结束时间:
										</TD>
										<TD width="25%"  class=category>
										   ${project.yjendtime }
										</TD>
									</TR>
									<TR>
									   <td width="25%" align="right" height=30>
									                    项目描述：
									   </td>
									   <td width="75%" colspan="3" align="left"  class=category>
									      ${project.prjdes}
									   </td>
									</TR>
									<TR>
									   <td width="25%" align="right" height=30 >
									                    项目功能模块：
									   </td>
									   <td width="75%" colspan="3" align="left"  class=category>
									      ${project.prjfunction}
									   </td>
									</TR>
									</TBODY>
                                     </table>
                             </TD>
                       </TR>
					  <TR>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>								
								<TBODY>							
								  <TR>
								        <TD width="25%" height=30 align="center">领导名称</TD>
										<TD width="25%" height=30 align=center>领导评价</TD>
										<TD width="25%" height=30 align=center>评价时间</TD>
										<TD width="25%" height=30 align=center>处理</TD>
								  </TR>			
								  <c:forEach items="${leadlist}" var="lead">
									<TR>
										<TD width="25%"  class=category  align="center" >
										        ${lead.leadname }
										</TD>
										<TD width="25%"  class=category  align="center" >
										       ${lead.leadevaluate }
										</TD>
										<TD width="25%" class=category  align="center" >
										     ${lead.pjtime }
										</TD>
										<TD width="25%"  class=category  align="center" >
										    <c:if test="${project.prjplan==10}">
										          <font color="red"> 此项目已完成。</font>
										    </c:if>
										    <c:if test="${project.prjplan!=10}">
											     <input type="button" value="领导跟进" style="background-color:#eef7fe; width:80px; height: 20px; border: 1px solid #a2b7c6;" onclick="leadgj()" >
										     </c:if>
										</TD>
									</TR>
									</c:forEach>
									<TR>
										<TD width="25%"  class=category  align="center" >
										         ${project.prjmanager }
										</TD>
										<td width="25%"  class=category  align="center" >
										   ${project.leadevaluate}
										</td>
										<td width="25%"  class=category  align="center" >
										  ${project.begintime }
										</td>
										<TD width="25%"  class=category  align="center" >
										    <c:if test="${project.prjplan==10}">
										          <font color="red"> 此项目已完成。</font>
										    </c:if>
										    <c:if test="${project.prjplan!=10}">
											     <input type="button" value="负责人跟进" style="background-color:#eef7fe; width:80px; height: 20px; border: 1px solid #a2b7c6; " >
										     </c:if>
										</TD>
									</TR>
								</TBODY>
                            </table>
                        </TD>
                    </TR>
				</TBODY>
			</TABLE>
		</FORM>
				
		<!-- 参与人员的展示 -->
		<div id="fd" style="display:none; filter:alpha(opacity=100);opacity:1;float: right;" >
        <div class="contentup">
		<div id="cyr" style="width: 150px; ">
		<table  class="toptable grid" cellSpacing=1 cellPadding=4 width="150px;"
								align=center border=1>
		 <tr>
		      <th>项目参与人员
		        <img width="11" height="11" border="0" onclick="showfd()" title="最小化" style="cursor: pointer;"
													id="FUNC00012Min" src="<%=request.getContextPath() %>/images/desk/min.gif" />
		      </th>
		 </tr>
		 <% 
		    List<ProjectEmp> prjemplist=(List<ProjectEmp>)request.getAttribute("prjemplist");
		    if(prjemplist.size()>0){
		 %>
		  <c:forEach items="${prjemplist}" var="prjemp" varStatus="count">
		   <tr>
		      <td>
		           <span name="${prjemp.id}"; id="${prjemp.employee.id}" style="cursor: pointer;" ondblclick="showldprj(this)" onmouseover="mus(this)"><img src="<%=request.getContextPath() %>/img/qq${count.count}.jpg" width="50px" height="50px" title="双击请给我留言吧"></img>${prjemp.employee.name }<br/></span>
		                           任务进度：<div style=" width: 99px;height:15px; border:1px solid #000; ">				     
		                     <c:forEach begin="1" end="${prjemp.prjempplan}" var="num">
		                  <c:if test="${num==1}">
		                      <img src="<%=request.getContextPath() %>/img/bluejdt.jpg" width="10px;" height="15px;" style="margin-left: 0px;"></img>
		                  </c:if>
		                  <c:if test="${num!=1}">
		                      <img src="<%=request.getContextPath() %>/img/bluejdt.jpg" width="10px;" height="15px;" style="margin-left: -4px;"></img>
		                  </c:if>
		              </c:forEach>
				       </div>
		      </td>
		   </tr>
		   </c:forEach>
		   <%}else{ %>
		   <tr><td>暂时没有人员参与此项目</td></tr>
		   <%} %>
		</table>
		</div></div></div>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
		<div id="cls" style=''>		   
		</div>
		
		<!-- 点击出现参与人的头象信息 -->
		<div style="width:180px;height:116px;position:fixed; text-align: right;" id="eMeng">
		     <img src="<%=request.getContextPath() %>/img/ry3.jpg" width="60px;" height="55px;" style="background-color:#eef7fe; cursor: pointer;" title="单击显示，双击隐藏" onclick="fdshow()" ondblclick="fdhide()"></img>
		</div>
		
		<!-- 领导评价 -->
		<div id="ldpj" style="position:absolute;left:350px;top:250px; width: 350px; display: none; background-color: green;">
		   <table class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
		    <tr>
		       <td><font style="font-weight: bold; font-size: 15px;" color="#13254d">领导评价</font> </td>
		    </tr>
		    <tr>
		      <td><textarea rows="10" cols="50" id="content"></textarea></td>
		    </tr>
		    <tr>
		      <td align="right">
		         <input type="button" value="关闭" onclick="ld()" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; " >
                 <input type="button" value="提交" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; " onclick="sublead()" >
                 <input type="button" value="清空" onclick="clearCot()" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; " >
              </td>
		    </tr>
		    </table>
		</div>
	</BODY>

</HTML>
