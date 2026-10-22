<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>入库单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
<script type="text/javascript">
function xuanze()
{
	var time=document.getElementById("time").value;
	if(time==1)
	{
		$($("#number option")[0]).text('请选择月份！！！！');
		for(var i=1;i<13;i++)
		{
			$($("#number option")[i]).text(i+'月份');
		}
			
	}
	if(time==2)
	{
		$($("#number option")[0]).text('请选择季度！！！！');
		for(var i=1;i<13;i++)
		{
			if(i<5)
			$($("#number option")[i]).text('第'+i+'季度');
			else
			$($("#number option")[i]).text(' ');
		}
	}
	if(time==3)
	{
		$($("#number option")[0]).text('请选择年！！！！');
		for(var i=1;i<13;i++)
		{
			if(i<10)
			$($("#number option")[i]).text('201'+i+'年');
			else
			$($("#number option")[i]).text(2010+i+'年');
		}
	}
}
function isok()
{
	var time=document.getElementById("time").value;
	var number=document.getElementById("number").value;
	var modelid=document.getElementById("modelid").value;
	if(time==0)
	{
		alert("请选择查询条件！！");
		return false;
	}
	if(number==0)
	{
		alert("请选择时间！！");
		return false;
	}
	if(time==2)
	{
		if(number!=1&&number!=2&&number!=3&&number!=4)
		{
			alert("请选择季度！！");
			return false;
		}
	}
	window.location.href='selectTimeWarehousing.do?time='+time+'&number='+number+'&modelid='+modelid+'';
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
	  url: "selectWarehousing.do?tage=s&pageNo="+pageNo,
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


</script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>


<base target="_self"/> 
</head>
<body>
	
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
					
						
						<TD align=right width="95%">
						请选择查询条件：
							<SELECT id="time" name="time" value="this.value" onblur="xuanze()">
								<option value="0">请选择查询条件！！！！</option>
								<option value="1">月</option>
								<option  value="2">季度</option>
								<option  value="3">年</option>
							</SELECT>&nbsp;&nbsp;
							<SELECT id="number" name="number" value="this.value">
								<option value="0">请选择时间！！！！</option>
								<option value="1"></option>
								<option value="2"></option>
								<option value="3"></option>
								<option value="4"></option>
								<option value="5"></option>
								<option value="6"></option>
								<option value="7"></option>
								<option value="8"></option>
								<option value="9"></option>
								<option value="10"></option>
								<option value="11"></option>
								<option value="12"></option>
							</SELECT>
							<s:select  id="modelid" name="modelid"  list="#request.model" listKey="model" listValue="name" headerKey="0" headerValue="所有商品！！"  
					  	 value="%{'',#request.model.name}">
						</s:select>
							<INPUT type="button" onclick="isok()"  value=" 查询 ">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		<FORM id="form1" name=form1 action="" method="post">
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
										&nbsp;入库商品列表
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
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
										<TD width="12%" height=30 id="tdbarcode" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											条形码
											<input id="barcode" name="barcode" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="12%" height=30 id="tdmodelname" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											商品类型名称
											<input id="modelname" name="modelname" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="8%" id="tdstorageDate" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											入库时间
											<input id="storageDate" name="storageDate" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="8%" id="tdtypeName" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											入库类型
											<input id="typeName" name="typeName" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="8%" class=category>
											使用状态
											
										</TD>
										<TD width="8%" id="tddepotname" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											仓库
											<input id="depotname" name="depotname" style="display: none" onblur="selectemp(1)">
										</TD>
										<TD width="8%" id="tdempname" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											经手人
											<input id="empname" name="empname" type="text"  style="display: none" onblur="selectemp(1)" />
										</TD>
									
									</TR>
									</table>
									<!--循环-->
									 <table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
                             			<c:forEach items="${pages.pageList}" var="data" > 
											<TR>
										<td align="center" width="12%">
										
										${data.barcode}
										</td>
												
										<TD align="center" width="12%">
											<a href="selectModelTypeWarehousing.do?modelTypeId=${data.property.model.model}">${data.property.model.name}</a>
										</TD>
										<TD  align="center" width="8%">
											${data.storageInfo.storage.storageDate}
										</TD>
										<TD align="center" width="8%">
											${data.storageInfo.storage.allType.typeName}
										</TD>
										<TD align="center" width="8%">
										<c:if test="${data.usestate==1}">使用中</c:if>
										<c:if test="${data.usestate==2}">未使用</c:if>
										<c:if test="${data.usestate==3}">入库未审核</c:if>
										<c:if test="${data.usestate==4}">出库未审核</c:if>
										</TD>
										<TD align="center" width="8%">
											<a href="selectDepotWarehousing.do?depotid=${data.storageInfo.storage.depot.id}">${data.storageInfo.storage.depot.name}</a>
										</TD>
										<TD  align="center" width="8%">
												${data.storageInfo.storage.employee.name}
										</TD>
										
											</tr>
									</c:forEach>
								</TBODY>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<c:if test="${mark=='1'}"><TD><p:pages url="selectStocksWarehousing.do"/></TD></c:if>
					<c:if test="${mark=='2'}"><TD><p:pages url="selectModelTypeWarehousing.do"/></TD></c:if>
					<c:if test="${mark=='3'}"><TD><p:pages url="selectDepotWarehousing.do"/></TD></c:if>
					<c:if test="${mark=='4'}"><TD><p:pages url="selectTimeWarehousing.do"/></TD></c:if>
					
					
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
