<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>上架单列表</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function orderstate(op)
		{
			window.location.href="selectUpserver.do?marker=UpServer&state="+op;
		}
</script>
<base target="_self"/> 
</head>
<body>
		<FORM name=form2 action="selectUpserver.do?funid=193" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<td align="right">
						单据审核状态：
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
		<form action="">
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
					<TD></TD>
					<TD>
						<!--startprint-->
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="15%" height=30 class=category>
											上架单编号
										</TD>
										<TD width="10%" class=category>
											服务器名称
										</TD>
										<TD width="5%" class=category>
											审核状态
										</TD>
										<TD width="8%" class=category>
											上架状态
										</TD>
										<TD width="13%" class=category>
											上架时间
										</TD>
										<TD width="8%" class=category>
											经手人
										</TD>
										<TD width="8%" class=category>
											详细情况
										</TD>
										<TD width="9%" class=category>
											流程跟踪
										</TD>
										<TD width="5%" class=category>
											修改
										</TD>
										<TD width="5%" class=category>
											删除
										</TD>
										<TD width="15%" class=category>
											执行上架
										</TD>
									</TR>


									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												${data.upNo }
												</TD>
													<TD align=middle>
													${data.product.property.name}
												</TD>
													<TD align=middle>
													<c:if test="${data.audtitingFlag==0||data.audtitingFlag==null}">
													未审核
													</c:if>
													<c:if test="${data.audtitingFlag==1 || data.audtitingFlag==2}">
													已审核
													</c:if>
												</TD>
												<TD align=middle>
													<c:if test="${data.upFlag==0||data.upFlag==''}">
													未上架
													</c:if>
													<c:if test="${data.upFlag==1}">
													已上架
													</c:if>
												</TD>
												
												<TD align=middle>
														<c:set var="birthDate" scope="request" value="${data.uptime}"  />
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
													<a href="detailedUpserver.do?cid=${data.id }&upNo=${data.upNo }&info=info">详细情况</a>
												</TD>
												<TD align=center>
													<a href="followAuditing.do?orderNo=${data.upNo}">流程跟踪</a>
												</TD>
												<TD align=middle>
												<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<a href="updateShowUpserver.do?cid=${data.id }">
													<IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
													</c:forEach>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</TD>
												<TD align=middle>
													<c:if test="${data.audtitingFlag==1&&data.upFlag!=1}">
													<INPUT class=button type="button" value="上架" onclick="executeServer('auditingUpserver.do','${data.id }',${data.product.id})" >
													</c:if>
													<c:if test="${data.audtitingFlag==0}">
													该单据审核未完成
													</c:if>
													<c:if test="${data.upFlag==1}">
													该单据产品已上架完成
													</c:if>
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
														<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==3}">
														<INPUT name="delbut" type=button class=button
															onclick="del('delUpserver.do','selectUpserver.do?funid=193')"
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
					<TD>
						<c:if test="${empty tag}">
							<p:pages url="selectUpserver.do?funid=193"/>
						</c:if>
						<c:if test="${not empty tag}">
							<c:if test="${state == '1'}"><p:pages url="selectUpserver.do?marker=UpServer"/></c:if>
							<c:if test="${state == '0'}"><p:pages url="selectUpserver.do?marker=UpServer&state=0"/></c:if>
							<c:if test="${state == '2'}"><p:pages url="selectUpserver.do?marker=UpServer&state=2"/></c:if>
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
