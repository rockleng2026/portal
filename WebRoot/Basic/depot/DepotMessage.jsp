<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	   <base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<!-- saved from url=(0014)about:internet -->   
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<LINK href="Css/style.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="js/jquery.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<SCRIPT language=javascript>
function del(id)
{
	var t=new Date();
	var url="deldepot.do?t="+t;
     if(confirm("你确定要删除该数据吗？")==true)
     {
         $.post(url,{id:id},function(data)
         {
            if(data==1)
            {
                 alert("删除成功");
                 window.location.href="selectdepot.do?t="+t;
             }else   alert("删除失败");
        });
     }
}
//表头排序
function orderby(obj)
{
	var tag = $("#bl").val();
	if(null != tag && tag!= '' && tag == obj.id)
	{
	 $("#"+obj.id).attr("href",obj.href.substring(0,obj.href.indexOf("?")));
	}
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
    if(vals != '1')
      $("#"+inputid).css("display","none");
}

function selectemp(pageNo){
$("#form1 select").css("display","none");
var formdata = $("#form1").serialize();
formdata = encodeURI(formdata);
 $.ajax({
	  type: "POST",
	  url: "selectdepot.do?tage=s&pageNo="+pageNo,
	  data:formdata,
	  success: function(data){
	  var data1 = new Array();
	  data1 = data.split("#");
		$("#infotable").html(data1[0]);
		$("#page").html(data1[1]);
	  }
	 });
}
</SCRIPT>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM name=form2 action="selectdepot.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							仓库名称：
							<INPUT name=cname>
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;仓库查询
									</TD>
									<TD align=right>
										&nbsp;<a href="addPagedepot.do">添加仓库</a>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						<FORM  id="form1" name="form1" action="employees.do?" onsubmit="return check()">
						    <input type="hidden" name="method" value="delEmployees">
							<table class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1 >
									<tbody>
									<TR align="center" height="80px">
										<TD width="12%" id="tdname" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)" >
											仓库名称 <br/>
											<input id="name" name="name" style="display: none" onkeyup="selectemp(1)">
											<input id="bl" type="hidden" value="${tag }">
										</TD>
										<TD width="9%" id="tdaddress" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											仓库地址<br/>
											<input id="address" name="address" style="display: none" onkeyup="selectemp(1)">
										</TD>
										<TD width="21%" id="tdcapacity" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											仓库容量<br/>
											<input id="capacity" name="capacity" style="display: none" onkeyup="selectemp(1)">
										</TD>
										<TD width="18%" id="tdtime" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											建立仓库日期<br/>
											<%--<a id="time" href="selectdepot.do?order=time" onclick="orderby(this);">建立仓库日期</a>--%>
											<input id="time" name="time" style="display: none" onkeyup="selectemp(1)">
										</TD>
										<TD width="13%" id="tdempname" height=30 class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											<a id="employee" href="selectdepot.do?order=employee" onclick="orderby(this);">仓库管理员</a>
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="8%" class=category>
													删除
												</TD>
											</c:if>
										</c:forEach>
									</TR>
									</tbody>
								</table>
								<table  id="infotable" name="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
									<!--循环-->
									<tbody>
									<c:forEach items="${pages.pageList}" var="data" >
										<TR>
											<TD width="12%" align="center">${data.name}				</TD>
											<TD width="9%" align="center">${data.address}			</TD>
											<TD width="21%" align="center">${data.capacity}			</TD>
											<TD width="18%" align="center">${data.time}				</TD>
											<TD width="13%" align="center">${data.employee.name }		</TD>
										    <c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="8%" align="center">
													<A href="updatePagedepot.do?id=${data.id }" target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="images/res.gif" align=absMiddle border=0> </a>
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD  width="8%" align="center">
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="img/del.gif" width="20px" height="20px" border=0 ></a>
												</TD>
											</c:if>
										</c:forEach>
										</TR>
									</c:forEach>
									</tbody>
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
					<TD id="page"><p:pages url="selectdepot.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
