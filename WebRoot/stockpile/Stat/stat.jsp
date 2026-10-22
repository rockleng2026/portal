<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>盘点单列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
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
<base target="_self"/> 
</head>
<body onload="showbc()">
		<FORM name=form2 action="selectStat.do?funid=77" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							盘点单号：
							<INPUT name="statNo" id="statNo" >
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="" id="form1">
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
										&nbsp;盘点单记录查询
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
										<TD width="18%" height=30 class=category>
											盘点单号
										</TD>
										<TD width="13%" height=30 class=category>
											盘点类型
										</TD>
										<TD width="10%" class=category>
											仓库
										</TD>
										<td width="9%" class=category >
										审核状态
										</td>
										<TD width="13%" class=category>
											盘点时间
										</TD>
										<TD width="10%" class=category>
											盘点人
										</TD>
										<TD width="10%" class=category>
											详细信息
										</TD>
										<TD width="8%" class=category>
											修改
										</TD>
										<TD width="8%" class=category>
											删除
										</TD>
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							            <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>


									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												${data.statNo }
												</TD>
												<TD align=middle>
													${data.statType}
												</TD>
												<TD align=middle>
													${data.depot.name}
													</TD>
													<td align="middle">
													<c:if test="${data.auditingState==0||data.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingState==1 ||data.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${data.auditingState==8}">审核进行中</c:if>
													</td>
													<TD align=middle>
													<c:set var="birthDate" scope="request" value="${data.statTime}"  />
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											if(request.getAttribute("birthDate")!=null)
											out.println(formatter.format(request.getAttribute("birthDate")));
											 %>
												</TD>
													<TD align=middle>
													${data.employee.name}
												</TD>
												<TD align=middle>
													<a href="detailStat.do?cid=${data.id}&info=info">详细信息</a>
												</TD>
												<TD align=middle>
												<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<c:if test="${data.auditingState!=8}">
													<A
														href="updateShowStat.do?cid=${data.id }"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
													</c:if>
													</c:forEach>
													<c:if test="${data.auditingState==8}">审核进行中</c:if>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</TD>
											</TR>
											</c:forEach>
					
											<TR>
											</tr>
									<!--循环结束-->




									<TD class=category colSpan=12 height=30 align="right">
								     
								     	<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
														<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('delStat.do','selectStat.do?funid=77')"
															value="删 除">
															</c:if>
															</c:forEach>
									</TD>
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
					<TD> <p:pages url="selectStat.do?funid=77"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>
