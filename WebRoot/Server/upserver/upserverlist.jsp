<%@ page language="java" contentType="text/html; charset=gbk"	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>上架单列表</title>
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
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="10%" height=30 class=category>
											客户
										</TD>
										<TD width="10%" class=category>
											机房
										</TD>
										<TD width="12%" class=category>
											IP
										</TD>
										<TD width="10%" class=category>
											带宽
										</TD>
										<TD width="10%" class=category>
											上架状态
										</TD>
										<TD width="10%" class=category>
											负责人
										</TD>
										<TD width="10%" class=category>
											商品名称
										</TD>
										<td width="5%" align="center" class=category>
										       上架状态
										</td>
										<td align="center" width="8%" class=category>
										    操作
										</td>
										
									</TR>


								
                             
										
								</TBODY>
							</TABLE>
								<table  id="infotable" class="toptable grid" border="1">
									<!--循环-->
                             
									<c:forEach items="${list}" var="data" >
											<TR>
												<TD align=middle width="10%">
												${data.customer.realName}
												</TD>
												<TD align=middle width="10%">
													${data.upNo}
												</TD>
												<TD align=middle width="12%">
													${data.serverIp}
												</TD>
												<TD align=middle width="10%">
													${data.bandwidthAmount}
												</TD>
												<TD align=middle width="10%">
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
												<TD align=middle width="10%">
													${data.saleOrder.customer.employee.name}
												</TD>	
												<TD align=middle width="10%">
												   ${data.product.property.name}
												</TD>
												<td width="5%" align="center">
												  <c:if test="${data.upFlag==4}">
												       待上架
												  </c:if>
												  <c:if test="${data.upFlag==1}">
												       上架
												  </c:if>
												  <c:if test="${data.upFlag==2}">
												      下架
												  </c:if>
												</td>
												
												<td align="center" width="8%">
												  <a href="javascript:void(0)">修改</a> | <a href="javascript:void(0)">删除</a>
												</td>
												
											</TR>
											</c:forEach>
											<TR>
											</tr>
							</TABLE>
					
				
			
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
