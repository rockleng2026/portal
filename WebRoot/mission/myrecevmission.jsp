<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>我接收的任务</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function ckfj(sbh,url)
	{
		//alert(sbh+url);
		var dd = new Date().getTime();
		url = url+"?dd="+dd;
		$.post(url,{sbh:sbh}
		,function(data){
			if(data != 0){
			  alert("该单据暂未有附件!");
			  //window.location.href="fjlistcommonaction.do?sbh="+sbh+"&isok=0";
			  return false;
			}else{
				window.location.href="fjlistcommonaction.do?sbh="+sbh+"&isok=0";
			}
		});
		
	}
	function showd(id)
	{
		//alert(id+"ddd");
		var obj=new Object();
		var v = $("#"+id).html();
		//alert(v);
		obj.name=v;
		window.showModalDialog("<%=request.getContextPath() %>/mission/missionTickling.jsp", obj, "dialogWidth=500px;dialogHeight=200px");
	}
	function showdinfck(id)
	{
		//alert(id);
		var obj = new Object();
		window.showModalDialog("<%=request.getContextPath() %>/mission/logdetailmission.do?id="+id, obj, "dialogWidth=500px;dialogHeight=200px");
	}
	
	
	//删除所选信息
function del(url,href){
	var delflag=false;
	
	var all=document.getElementsByName('ids');
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++)
	{
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0)
		delflag=true;
	if(!delflag)
	{
		alert("请选择要删除的记录！");
		return false;
	}
	delflag=confirm("是否确定要删除？");
	if(!delflag)
		return false;
	$.post(url,{ids:allId},
	function (data)
	{
		if(data==0){
			alert('删除成功！');
			window.location.href=href;
		}else if(data == 2)
		{
			alert("请将入库单的入库详细先删除");
		}
		else {
			alert('删除失败！');
		}
	});
}
function missionquery(stateId)
	{
		//alert(stateId);
		window.location.href="getmyreceivemission.do?status="+stateId;
	}
function receivemissionstus(id,status)
	{
		var url = "receivemission.do";
		$.post(url,{id:id,status:status},
		function (data)
		{
			if(data==0){
				alert('更改成功！');
				window.location.href="getmyreceivemission.do";
			}else if(data == 1)
			{
				alert('修改失败！');
				return false;
			}else {
			  alert('网络问题');
			  return false;
			  }
		});
	}
	
	//字段查找
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
		
		function selectsupplierr(){
			$("#form1 select").css("display","none");
			/*
			var formdata = $("#form1").serialize();
			formdata = encodeURI(formdata);
			 $.ajax({
				  type: "POST",
				  url: "getmyreceivemission.do?tage=y",
				  data:formdata,
				  success: function(data){
					  var data1 = new Array();
					  data1 = data.split("#");
						$("#infotable").html(data1[0]);
						$("#page").html(data1[1]);
					  }
				 });
			*/
			//$("#selecttage1").attr("value","0");
		}
</script>
</head>
<body>
		<table cellspacing="2" cellpadding="0" width="100%" align="center" border="0">
				<tbody>
					<tr>
						<td width="5%" height=21>
							&nbsp;
							<img style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</td>
						
						<td align="center" width="70%">
							 处理状态&nbsp;&nbsp;
							<input type="button" value="新任务" onclick="missionquery('0');"  />&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="处理中" onclick="missionquery('1');"  />&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="已完成" onclick="missionquery('2');" />
						</td>
					</tr>
				</tbody>
		</table>
		<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#c4d8ed" border="0">
			<TBODY>
				<TR>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										我接收的任务
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
					<form id="form1" name="form1" action="getmyreceivemission.do" onsubmit="return check()">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">
									
										<TD id="tmissionName" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											任务名称<br/>
											<input id="missionName" name="mission.name" style="display: none" onkeyup="selectsupplierr()"/>
										</TD>
										<TD id="tmissionDescription" width="15%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											任务描述<br/>
											<input id="missionDescription" name="mission.description" style="display: none" onkeyup="selectsupplierr()"/>
										</TD>
										<TD id="tbuildTime" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											任务下达时间<br/>
											<input id="buildTime" name="buildTime" style="display: none" onkeyup="selectsupplierr()"/>
										</TD>
										<TD id="tmissionDescription" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											任务预计开始时间<br/>
										</TD>
										<TD id="tmissionDescription" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											任务预计结束时间<br/>
										</TD>
										<TD id="treceiveTime" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											接受时间<br/>
											<input id="receiveTime" name="receiveTime" style="display: none" onkeyup="selectsupplierr()"/>
										</TD>
										<TD id="tcompleteTime" width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											完成时间<br/>
											<input id="completeTime" name="completeTime" style="display: none" onkeyup="selectsupplierr()"/>
										</TD>
										<TD width="5%" class=category >
											附件
										</TD>
										<TD width="10%" class=category onmouseover="showInput(this)" onMouseOut="displayIput(this)">
											状态<br/>
										</TD>
										<TD width="10%" class=category>
											操作
										</TD>
									</TR>
									</tbody>
									</TABLE>									
                            </form>
									<!--循环-->
									<table id="infotable" class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
									<tbody>
									<c:forEach items="${pages.pageList}" var="data">
											<TR>
												<TD width="10%" align=middle>
												${data.mission.name }
												</TD>
												<TD width="15%" align=middle>
													<a style="cursor: hand;" href="javascript:void(0);" onclick="showdinfck('${data.mission.taskId }')" title="点击查看任务详细" >任务详细</a>
												</TD>
												<TD width="10%" align=middle>
												${data.buildTime }
												</TD>
												<TD width="10%" align=middle>
												${data.mission.expStartTime }
												</TD>
												<TD width="10%" align=middle>
												${data.mission.expEndTime }
												</TD>
												<TD width="10%" align=middle>
												${data.receiveTime }
												</TD>
												<TD width="10%" align=middle>
													${data.completeTime }
												</TD>	
												<td width="5%" align=middle>
												<a href="javascript:void(0);" onclick="ckfj('${data.mission.sbh },${data.sbh }','ckfjcommonaction.do');" title="点击查看任务附件" >附件</a>
												</td>
												<TD width="10%" align="middle">
												<c:if test="${data.status == '0' }">未接受</c:if>
												<c:if test="${data.status == '1' }">处理中</c:if>
												<c:if test="${data.status == '2' }">
												<div id="fk${data.id }" style="display: none;">${data.completeDescribe }</div>
												<a href="javascript:void(0);" onclick="showd('fk${data.id }')" title="点击查看反馈信息">已完成</a>
												</c:if>
												</TD>
												<TD width="10%" align="middle">
												<c:if test="${data.status == '0' }">
												<a href="javascript:void(0);" onclick="receivemissionstus('${data.id }',1)" title="点击接收任务">接收</a>
												</c:if>
												<c:if test="${data.status == '1' }">
												<a href="javascript:void(0);" onclick="completemission('${data.id }',2)" title="点击完成任务">完成</a>
												</c:if>
												<c:if test="${data.status == '2' }">
												<a href="javascript:void(0);" onclick="ckfj('${data.completeFjbs }','ckfjcommonaction.do');" title="点击查看我提交的反馈附件" >反馈附件</a>
												</c:if>
												
												<input	style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"	type=checkbox  value="${data.id }" name="ids" />
												</TD>
											</TR>
											</c:forEach>
					
											<TR>
									<!--循环结束-->
													
													
													<TD class=category colSpan=12 height=30 align="right">
													
								     					<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall />
														全选
									</TD>
									</tr>
								</TBODY>
							</TABLE>
						</TD>
				</TR>
				<TR>
					<TD>
					<p:pages url="getmyreceivemission.do"/>
					</TD>
				</TR>
			</TBODY>
		</table>
		<jsp:include page="writedescribe.jsp"></jsp:include>
	</body>
</html>
