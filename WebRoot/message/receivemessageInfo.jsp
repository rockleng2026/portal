<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>我分配的任务</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
function ckfj(sbh,url)
	{
		var dd = new Date().getTime();
		url = url+"?dd="+dd;
		$.post(url,{sbh:sbh}
		,function(data){
			if(data != 0){
			  alert("该单据暂未有附件!");
			  window.location.href="fjlistcommonaction.do?sbh="+sbh+"&isok=1";
			}else{
				window.location.href="fjlistcommonaction.do?sbh="+sbh+"&isok=1";
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
		window.showModalDialog("<%=request.getContextPath() %>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
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
</script>
</head>
<body>
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
						
						<FORM name=form1 action="" onsubmit="">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="10%" class=category>
											接收人
										</TD>
										<TD width="10%" class=category>
											接收类型
										</TD>
										
										<TD width="10%" class=category>
											接收时间
										</TD>
										<TD width="10%" class=category>
											是否接收
										</TD>
										
										<TD width="5%" class=category>
											附件
										</TD>
										<TD width="5%" class=category>
											反馈附件
										</TD>
										<TD width="15%" class=category>
											操作
										</TD>
									</TR>
									<!--循环-->
									  
                                      <c:forEach items="${empList}" var="data">
									       
											<TR>
												<TD align=middle>
												  ${data.name }
												</TD>
												<TD align=middle>
												  ${messageType.type }
												</TD>
												
												<TD align=middle>
												  ${messR.receivetime}
												</TD>	
												
												
												
												<TD align="middle">
													<c:if test="${messR.readfalg=='0'}">未接收</c:if>
													<c:if test="${messR.readfalg=='1'}">已接收</c:if>
												</TD>
												<TD align="middle">
													
												</TD>
												<TD align="middle">
											    
												</TD>
											</TR>
										</c:forEach>
											<!--循环结束-->
											
											<!--循环-->
											
									  
                                      <c:forEach items="${cusList}" var="data">
									       
											<TR>
												<TD align=middle>
												  ${data.customerName}
												</TD>
												<TD align=middle>
												  ${messageType.type }
												</TD>
												<TD align=middle>
												   ${messR.receivetime}
												</TD>
												<TD align=middle>
												<c:if test="${messR.readfalg=='0'}">否</c:if>
													<c:if test="${messR.readfalg=='1'}">是</c:if>
												</TD>	
												
												
												
												<TD align="middle">
													<a href="javascript:void(0);" onclick="ckfj('${messR.tmp2 }','ckfjcommonaction.do');" title="点击查看或上传附件" >附件</a>
												</TD>
												<TD align="middle">
												  <a href="javascript:void(0);" onclick="ckfj('${messR.tmp3}','ckfjcommonaction.do');" title="点击查看或上传附件" >反馈附件</a>
												</TD>
												<TD align="middle">
											    <a title="点我给他发送邮件">给他发邮件</a>&nbsp;<a  title="点我给他发送短信">给他发短信</a>
												</TD>
											</TR>
										</c:forEach>
											<!--循环结束-->
											
											
											<tr>
											</tr>
								</TBODY>
							</TABLE>
				</FORM>
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD>
					
					<p:pages url="getmyhandoutmission.do"/>
					
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
