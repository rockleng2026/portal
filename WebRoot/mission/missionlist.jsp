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
		<title>任务列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function showd(id)
	{
		//alert(id);
		var obj=new Object();
		var v = $("#"+id).html();
		obj.name=v;
		window.showModalDialog("<%=request.getContextPath() %>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}
	function showdinfck(id)
	{
		//alert(id);
		var obj=new Object();
		window.showModalDialog("<%=request.getContextPath() %>/mission/logdetailmission.do?id="+id,obj,"dialogWidth=710px;dialogHeight=310px");
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
										任务大全
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
											任务名称
										</TD>
										<TD width="5%" class=category>
											任务类别
										</TD>
										<TD width="5%" class=category>
											发布者
										</TD>
										<TD width="25%" class=category>
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
										<TD width="10%" class=category>
											操作
										</TD>
									</TR>
									<!--循环-->
                                   
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												<a href="getmyhandoutmission.do?taskid=${data.taskId }" title="点击进入此任务的分配情况">${data.name }</a>
												</TD>
												<TD align=middle>
												${data.missiontype.name }
												</TD>
												<TD align=middle>
												<a href="detailemp.do?cid=${data.employee.id }"  title="点击进入查看员工个人信息">${data.employee.name }</a>
												</TD>
												<TD align=middle>
													<a style="cursor: hand;" onclick="showdinfck('${data.taskId }')" title="点击查看任务详细">任务详细</a>
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
												  <a title="点我给他发送邮件">给他发邮件</a>&nbsp;<a  title="点我给他发送短信">给他发短信</a>
												</TD>
											</TR>
											</c:forEach>
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
					
					<p:pages url="gettypeparammission.do"/>
					
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
