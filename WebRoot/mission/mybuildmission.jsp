<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>我发布的任务</title>
		<LINK href="<%=request.getContextPath()%>/Css/style.css"
			type=text/css rel=stylesheet>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js"></script>
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
			  //window.location.href="fjlistcommonaction.do?sbh="+sbh+"&isok=1";
			}else{
				window.location.href="fjlistcommonaction.do?sbh="+sbh;
			}
		});
		
	}
	function newmission(url){
	    //alert(url);
		window.location.href=url;
		return false;
	}
	
	function showd(id)
	{
		//alert(id);
		var obj=new Object();
		var v = $("#"+id).html();
		obj.name=v;
		window.showModalDialog("<%=request.getContextPath() %>/mission/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}
	function showdinfck(id)
	{
		//alert(id);
		var obj=new Object();
		window.showModalDialog("<%=request.getContextPath() %>/mission/logdetailmission.do?id="+id,obj,"dialogWidth=710px;dialogHeight=310px");
	}
	
	//删除所选信息
function del(url,href){
	if(confirm("你确定要删除任务吗？")){
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
		}else {
			alert('删除失败！');
		}
	});
	
	}
}
function endmission(id){
	
	if(confirm("你确定要结束任务吗？")){
	var url = "endmission.do";
	$.post(url,{id:id},
	function (data)
	{
		if(data==0){
			alert('操作成功！');
			window.location.href="getmybuildmission.do";
		}else if(data == 1)
		{
			alert("删除失败");
			return false;
		}
		else {
			alert('网络错误');
			return false;
		}
	});
	}
}
</script>
	</head>
	<body>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<td>
					</td>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										当前位置：我发布的任务<< <a href="<%=request.getContextPath() %>/listnewProject.do">我的项目</a> << <a href="<%=request.getContextPath() %>/publishtaskTaskProject.do">分配任务</a> << <a href="<%=request.getContextPath() %>/selectTaskProject.do?pid=-2">任务列表</a> << <a href="<%=request.getContextPath() %>/selectQuestionProject.do">讨论区</a> << <a href="<%=request.getContextPath() %>/QuestionListQuestionProject.do">我要提问</a> 
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
					<TD></TD>
					<TD>
						<FORM name=form1 action="" onsubmit="">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">

										<TD width="10%" class=category>
											任务名称
										</TD>
										<TD width="10%" class=category>
											任务类别
										</TD>
										<TD width="20%" class=category>
											任务描述
										</TD>
										<TD width="10%" class=category>
											生成任务时间
										</TD>
										<TD width="10%" class=category>
											预计开始时间
										</TD>
										<TD width="10%" class=category>
											预计结束时间
										</TD>
										<TD width="5%" class=category>
											任务状态
										</TD>
										<TD width="5%" class=category>
											附件
										</TD>
										<TD width="20%" class=category>
											操作
										</TD>
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data">
										<TR>
											<TD align=middle>
												<a href="getmyhandoutmission.do?taskid=${data.taskId }"
													title="点击进入查看我分配给的任务">${data.name }</a>
											</TD>
											<TD align=middle>
												${data.missiontype.name }
											</TD>
											<TD align=middle>
													<a style="cursor: hand;"
														onclick="showdinfck('${data.taskId }')" title="点击查看任务详细">任务详细</a>
											</TD>
											<TD align="middle">
												${data.buildTime }
											</TD>
											<TD align="middle">
												${data.expStartTime }
											</TD>
											<TD align="middle">
												${data.expEndTime }
											</TD>
											<TD align="middle">
												<c:if test="${data.status == '0' }">进行中</c:if>
												<c:if test="${data.status == '-1' }">已结束</c:if>
											</TD>
											<TD align="middle">
												<a href="javascript:void(0);" onclick="ckfj('${data.sbh }','ckfjcommonaction.do');" title="点击查看或上传附件" >附件</a>
											</TD>
											<TD align="middle">
												<c:if test="${data.status == 0}">
													<A href="handoutmission.do?id=${data.taskId}" target=right
														title="点击下发任务"><IMG style="CURSOR: hand" hspace=2
															src="<%=request.getContextPath()%>/images/res.gif"
															border=0> </a>
													<A href="getmission.do?id=${data.taskId}" target=right
														title="点击修改任务"><IMG style="CURSOR: hand" hspace=2
															src="<%=request.getContextPath()%>/images/res.gif"
															border=0> </a>
													<A href="javascript:void(0);" target=right
														onclick="endmission('${data.taskId }')" title="点击结束任务"><IMG
															style="CURSOR: hand" hspace=2
															src="<%=request.getContextPath()%>/images/res.gif"
															border=0> </a>
												</c:if>
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="${data.taskId }" name=ids>
											</TD>
										</TR>
									</c:forEach>

									<TR>


										<!--循环结束-->

										<td>
											<INPUT name="delbut" type=button class=button
												onclick="newmission('buildmission.do')" value="新建任务">
										</td>
										<TD class=category colSpan=12 height=30 align="right">

											<INPUT id=chkall
												style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
												onclick=CheckAll(this.form) type=checkbox value=select
												name=chkall>
											全选(删除)

											<INPUT name="delbut" type=button class=button
												onclick="del('delmission.do','getmybuildmission.do')"
												value="删 除">

										</TD>
									</tr>
								</TBODY>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					
				</TR>
				<TR>
					<TD colspan="2">
						<p:pages url="getmybuildmission.do" />
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
