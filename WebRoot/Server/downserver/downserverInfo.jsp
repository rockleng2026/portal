<%@ page language="java" contentType="text/html; charset=gbk"  	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>下架单列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" charset="GBK" ></script>
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
			window.location.href="selectDownserver.do?marker=DownServer&state="+op;
		}
	function cancleDownserver(id){
		var url = "cancleDownserver.do?tt="+(new Date()).getTime();
		$.get(url,{id:id},function(data){
			if(data == 0){
				alert("处理成功");
				window.location.reload();
			}else{
				alert("处理失败");
			}
		});
	}
</script>
<base target="_self"/> 
</head>
<body onload="showbc()">
		<FORM name=form2 action="selectDownserver.do?funid=199" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=Middle>
						</TD>
						<td align="right">
						单据审核状态：
							<c:if test="${empty backlogList}"><input type="button" value=" 查看待审 (0)" onclick="orderstate('1')"/></c:if>
                            <c:if test="${not empty backlogList}">
                              <c:forEach items="${backlogList }" var="backlog" varStatus="status">
                            	<c:forEach items="${orderlist}" var="order">
                            	<c:if test="${backlog.verifyOrder.id == order.id}">
                                	<c:if test="${order.entityName == 'DownServer'}">
                             &nbsp;<input type="button" value=" 查看待审 (${backlog.tmp})" onclick="orderstate('1')"/>
                            	    </c:if>
                            	</c:if>
                            	</c:forEach>
                             </c:forEach>
                            </c:if>
                            	&nbsp;<input type="button" value=" 查看未审 " onclick="orderstate('0')" />&nbsp;
                            	<input type="button" value=" 查看已审 " onclick="orderstate('2')"/>
						</td>
						<TD align=right width="50%">
							下架单号：
							<INPUT name="sjNo" id="sjNo" >
							<INPUT class=button type=submit  value=" 查询 ">
							<c:if test="${not empty tag}"><INPUT type="hidden" name="marker" id="sjNo" value="DownServer">
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
										<c:if test="${empty tag}">&nbsp;下架单记录查询</c:if>
										<c:if test="${not empty tag}">&nbsp;
											<c:if test="${state=='1' || state == ''}">查询待审核下架单记录</c:if>
											<c:if test="${state == '0'}">查询未审核下架单记录</c:if>
											<c:if test="${state == '2'}">查询已审核下架单记录</c:if>	
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
									
										<TD width="13%" height=30 class=category>
											客户
										</TD>
										<TD width="10%" class=category>
											服务器名称
										</TD>
										<TD width="8%" class=category>
											审核状态
										</TD>
										<TD width="10%" class=category>
											下架类型
										</TD>
										<TD width="6%" class=category>
											下架状态
										</TD>
										<TD width="8%" class=category>
											下架时间
										</TD>
										<TD width="8%" class=category>
											经手人
										</TD>
										<TD width="8%" class=category>
											详细信息
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
											执行下架
											<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							                <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
										</TD>
									</TR>


									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												${data.customer.realName}/${data.customer.customerCompany}
												</TD>
													<TD align=middle>
													${data.product.property.name}
												</TD>
													<TD align=middle>
													<c:if test="${data.auditingFlag==0||data.auditingFlag==null}">
													未审核
													</c:if>
													<c:if test="${data.auditingFlag==1}">
													已审核通过
													</c:if>
													<c:if test="${data.auditingFlag==2}">
													审核未通过
													</c:if>
													<c:if test="${data.auditingFlag==8}">
													审核中
													</c:if>
												</TD>
												<TD align=middle>
													${data.allType.typeName}
												</TD>
												<TD align=middle>
													<c:if test="${data.downFlag==0}">
													未下架
													</c:if>
													<c:if test="${data.downFlag==1}">
													已下架
													</c:if>
												</TD>
												
												<TD align=middle>
														<c:set var="birthDate" scope="request" value="${data.dtime}"  />
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
													<a href="detailDownserver.do?cid=${data.id }&downNo=${data.downNo}&info=info">详细信息</a>
												</TD>
												<TD align=center>
													<a href="followAuditing.do?orderNo=${data.downNo }">流程跟踪</a>
												</TD>
												<TD align=middle>
								<!-- 	 			<c:forEach items="${option}" var="data1">
													<c:if test="${data1.key==2}">
													<a href="updateShowDownserver.do?cid=${data.id }"
													   target=right><IMG style="CURSOR: hand" onclick=""
													   hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
													</c:forEach>
													 -->
													<a href="updateShowDownserver.do?cid=${data.id }"
													   target=right><IMG style="CURSOR: hand" onclick=""
													   hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.id }" name=ids>
												</TD>
												<TD align=middle>
													<c:if test="${data.auditingFlag==1&&data.downFlag!=1}">
													<INPUT class="button" type="button" value="下架" onclick="executeServer('auditingDownserver.do','${data.id }','${data.product.id}')" />
													</c:if>
													<c:if test="${data.auditingFlag==0}">
													该单据审核未完成
													</c:if>
													<c:if test="${data.downFlag==1}">
													该单据产品已下架完成
													</c:if>
													<c:if test="${data.auditingFlag==2&&data.downFlag==0}">
													<INPUT class="button" type="button" value="撤销" onclick="cancleDownserver('${data.id}')" />
													</c:if>
													<c:if test="${data.auditingFlag==2&&data.downFlag==2}">
													已撤销
													</c:if>
												</TD>
											</TR>
											</c:forEach>
					
											<TR>

											</tr>
									<!--循环结束-->
									<TD class=category colSpan=12 height=30 align="right">
								     
								     	<INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
												onclick=CheckAll(this.form) type=checkbox value=select name=chkall>
												全选
												<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
								<!-- 				<c:forEach items="${option}" var="data1">
												 <c:if test="${data1.key==3}">
													<INPUT name="delbut" type=button class=button onclick="del('delDownserver.do','selectDownserver.do?funid=199')"
															value="删 除">
												 </c:if>
												</c:forEach>
												 -->
										<INPUT name="delbut" type=button class=button onclick="del('delDownserver.do','selectDownserver.do?funid=199')"
															value="删 除">		 
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
							<p:pages url="selectDownserver.do?funid=199"/>
						</c:if>
						<c:if test="${not empty tag}">
							<c:if test="${state == '1'}"><p:pages url="selectDownserver.do?marker=DownServer"/></c:if>
							<c:if test="${state == '0'}"><p:pages url="selectDownserver.do?marker=DownServer&state=0"/></c:if>
							<c:if test="${state == '2'}"><p:pages url="selectDownserver.do?marker=DownServer&state=2"/></c:if>
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
