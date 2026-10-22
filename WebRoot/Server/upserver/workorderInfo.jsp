<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>工单信息</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>

<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(){
       form1.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form1.submit();
    }
    
    //保存按钮的显示和隐藏
		function showbc(){
		  var marker2 = $("#marker2").val();
		  var taskid = $("#taskid").val();
		  if(marker2.length>0 && marker2!="" && taskid!=""){
		     document.getElementById("bc").style.display='block';
		  }else{
		     document.getElementById("bc").style.display='none';
		  }
		}
</script>
<script type="text/javascript">
	function orderstate(op)
		{
			window.location.href="selectUpserver.do?marker=UpServer&state="+op;
		}
		function chselect()
{
 var vals = $("#selecttage").val();
 //var vals1 = $("#selecttage1").val();
 if(vals=='1' ){
  $("#selecttage").attr("value","0");
 }else{
     $("#selecttage").attr("value","1");
 }
}
function showInput(obj){
  var v = $("#"+obj.id).find("input,select").get(0); 
    var inputid = v.id;
    $("#"+inputid).css("display","");
}
function displayIput(obj){
  var v = $("#"+obj.id).find("input,select").get(0); 
    var inputid = v.id;
    var vals = $("#selecttage").val();
    //alert(vals);
    if(vals != '1'){
    $("#"+inputid).css("display","none");
    }
}

function selectemp(pageNo){

$("#form1 select").css("display","none");
   
var formdata = $("#form1").serialize();

formdata = encodeURI(formdata);
 $.ajax({
	  type: "POST",
	  url: "selectObscureUpserver.do",
	  data:formdata,
	  success: function(data){
		 var data1 = new Array();
	  data1 = data.split("#");
		$("#infotable").html(data1[0]);
		$("#page").html(data1[1]);
	  }
	 });
	 //$("#selecttage1").attr("value","0");
}
//跳转到下架页面
function executeDownServer(upNo){
	alert(upNo);
	window.location.href="addShow2Downserver.do?upNo="+upNo;
}
function godownpage(upNo){
     //alert(upNo);
	var tt = new Date().getTime();
	var url = "getDownNoDownserver.do?tt="+tt;
	$.get(url,{upNo:upNo},function(data){
		
		if(data == 1){
			alert("参数错误!");
			return;
		}else if(data ==2){
			alert("不存在相应下架单,请确认");
			return ;
		}else{
		//alert(data);
		window.location.href="detailDownserver.do?downNo="+data+"&info=info";
		}
	});
	
}

</script>
<base target="_self"/> 
</head>
<body onload="showbc()">
		<FORM name=form2 action="selectUpserver.do?funid=193" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<td align="right">
						<a href="<%=request.getContextPath()%>/cms/loadCityServers.do" target="_blank">服务器直观管理</a>&nbsp;&nbsp;&nbsp;单据审核状态：
							<c:if test="${empty backlogList}"><input type="button" value=" 查看待审 (0)" onclick="orderstate('1')"/></c:if>
                            	<c:if test="${not empty backlogList}">
                            		<c:forEach items="${backlogList }" var="backlog" varStatus="status">
                            			<c:forEach items="${orderlist}" var="order">
                            				<c:if test="${backlog.verifyOrder.id == order.id}">
                            					<c:if test="${order.entityName == 'UpServer'}">
                            			&nbsp;		<input type="button" value=" 查看待审 (${backlog.tmp})" onclick="orderstate('1')"/>
                            					</c:if>
                            				</c:if>
                            			</c:forEach>
                            		</c:forEach>
                            	</c:if>
                            	&nbsp;<input type="button" value=" 查看未审 " onclick="orderstate('0')" />&nbsp;
                            	<input type="button" value=" 查看已审 " onclick="orderstate('2')"/>
						</td>
						<TD align=right width="50%">
							上架单号：
							<INPUT name="sjNo" id="sjNo" >
							<INPUT class=button type=submit  value=" 查询 ">
							<c:if test="${not empty tag}"><INPUT type="hidden" name="marker" id="sjNo" value="UpServer">
								<INPUT type="hidden" name="state" value="${state }">
							</c:if>
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form id="form1">
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
										<c:if test="${empty tag}">&nbsp;上架单记录查询</c:if>
										<c:if test="${not empty tag}">&nbsp;
											<c:if test="${state=='1' || state == ''}">查询待审核上架单记录</c:if>
											<c:if test="${state == '0'}">查询未审核上架单记录</c:if>
											<c:if test="${state == '2'}">查询已审核上架单记录</c:if>	
										</c:if>
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
					<TD>&nbsp;</TD>
					<TD>
						<!--startprint-->
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="5%" height=30 class=category id="tdcusName"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											客户
											<input id="cusName" name="cusName" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="5%" class=category id="tdserverLocation"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											机房
											<input id="serverLocation" name="serverLocation" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="7%" class=category id="tdserverIp"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											ip
											<input id="serverIp" name="serverIp" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="5%" class=category id="tdbandwidthAmount"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											宽带
											<input id="bandwidthAmount" name="bandwidthAmount" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="6%" class=category id="tdupServerType"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											上架状态
											<input id="upServerType" name="upServerType" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="7%" class=category id="tdtime"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											到期时间
											<input id="time" name="time" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="7%" class=category id="tdemployeeByEmpName"  onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											业务负责人
											<input id="employeeByEmpName" name="employeeByEmpName" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="7%" class=category >
											详细情况
										</TD>
										<TD width="7%" class=category>
											流程跟踪
										</TD>
										<TD width="7%" class=category>
											交换机
										</TD>
										<TD width="5%" class=category>
											端口
										</TD>
										<TD width="5%" class=category>
											机柜号
										</TD>
										<TD width="5%" class=category>
											备注
										</TD>
										<TD width="5%" class=category>
											修改
										</TD>
										<TD width="5%" class=category>
											删除
										</TD>
										<TD width="10%" class=category>
											执行上架
											<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							                <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
										</TD>
									</TR>

									</table >
								<table  id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle width="5%">
												${data.customer.realName}
												</TD>
												<TD align=middle width="5%">
													${data.serverLocation}
												</TD>
												<TD align=middle width="7%">
													${data.serverIp}
												</TD>
												<TD align=middle width="5%">
													${data.bandwidthAmount}
												</TD>
												<TD align=middle width=6%">
													<c:if test="${data.upFlag==0||data.upFlag==''}">
													未上架
													</c:if>
													<c:if test="${data.upFlag==1||data.upFlag==2}">
													已上架
													</c:if>
													<c:if test="${data.upFlag== 3}">
													下架审核中
													</c:if>
													<c:if test="${data.upFlag== 4}">
													已下架
													</c:if>
												</TD>
												
												<TD align=middle width="7%>
">
														<c:set var="birthDate" scope="request" value="${data.downtime}"  />
											<%
											
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
												</TD>
												<TD align=middle width="7%">
													${data.saleOrder.customer.employee.name}
												</TD>	
												<TD align=middle width="7%">
													<a href="detailedUpserver.do?cid=${data.id }&upNo=${data.upNo }&info=info">详细情况</a>
												</TD>
												<TD align=center width="7%">
													<a href="followAuditing.do?orderNo=${data.upNo}">流程跟踪</a>
												</TD>
												<td align=middle width="7%">
												    ${data.jhjname}
												</td>
												<td align=middle width="5%">
												    ${data.port}
												</td>
												<td align=middle width="5%">
												    ${data.jgh}
												</td>
												<TD align=center width="5%">
													${data.temp}
												</TD>
												<TD align=middle width="5%">
								<!--  			<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<a href="updateShowUpserver.do?cid=${data.id }">
													<IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
													</c:forEach>
													-->	
													<a href="updateShowUpserver.do?cid=${data.id }">
													<IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													
												</TD>
												<TD align=middle width="5%">
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</TD>
												<TD width="10%" align=middle>
													<c:if test="${data.audtitingFlag==1&&data.upFlag==0}">
													<INPUT class=button type="button" value="上架" onclick="executeServer('auditingUpserver.do','${data.id }',${data.product.id})" >
													</c:if>
													<c:if test="${data.audtitingFlag==0}">
													该单据审核未完成
													</c:if>
													<c:if test="${data.audtitingFlag==2}">
													审核失败
													</c:if>
													<c:if test="${data.upFlag ==1 || data.upFlag == 2}">
													该单据产品已上架完成&nbsp;
													<INPUT class=button type="button" value="申请下架" onclick="executeDownServer('${data.upNo}')" >
													</c:if>
													<c:if test="${data.upFlag ==3}">
													<a href="javascript:void(0);" onclick="godownpage('${data.upNo }')">下架审核中</a>
													</c:if>
													<c:if test="${data.upFlag ==4}">
													<a href="javascript:void(0);" onclick="godownpage('${data.upNo }')">已下架</a>
													</c:if>
												</TD>
											</TR>
											</c:forEach>
											<TR>

											</tr>
									<tr>
									<!--循环结束-->
									<TD class=category colSpan=16 height=30 align="right">
								     
								     	<INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											onclick=CheckAll(this.form) type=checkbox value=select 	name=chkall>
														全选
														<input type="button" id="bc" value="保存" onclick="allChecked()" />
										<!--  				<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('delUpserver.do','selectUpserver.do?funid=193')"
															value="删 除">
															</c:if>
															</c:forEach>
										-->					
										<INPUT name="delbut" type=button class=button onclick="del('delUpserver.do','selectUpserver.do?funid=193')" value="删 除">
															
									</TD>
								</tr>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<td id="page" align="center" colspan="7">
					<c:if test="${mark==0}">
						<c:if test="${empty tag}">
							<p:pages url="selectUpserver.do?funid=193"/>
						</c:if>
						<c:if test="${not empty tag}">
							<c:if test="${state == '1'}"><p:pages url="selectUpserver.do?marker=UpServer"/></c:if>
							<c:if test="${state == '0'}"><p:pages url="selectUpserver.do?marker=UpServer&state=0"/></c:if>
							<c:if test="${state == '2'}"><p:pages url="selectUpserver.do?marker=UpServer&state=2"/></c:if>
						</c:if>
					</c:if>
					<c:if test="${mark==1}">
							<p:pages url="selectObscure1Upserver.do?funid=193"/>
					</c:if>
					
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
