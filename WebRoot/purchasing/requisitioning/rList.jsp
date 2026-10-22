<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>

		<SCRIPT language=javascript>
		
		function delapplyBuy(id)
		{
		var t=new Date();
		var url="delapplyBuyRejectioning.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(date)
		        {
		            if(date==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getRejectioning.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
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
</SCRIPT>
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


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY onload="showbc()">

		<FORM name=form2 action="getRejectioning.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							请购单号：
							<INPUT name="applyBuyNo">
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;请购单列表
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
						<FORM name=form1 id="form1" action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										
										<TD width="5%" height=30 class=category>
											选择
										</TD>
										<TD width="12%" class=category>
											请购单号
											<input type="hidden" id="bl" value="${tag }">
										</TD>
										<TD width="18%" class=category>
											<a id="time" href="getRejectioning.do?order=time" onclick="orderby(this)">申请请购日期</a>
										</TD>
										<TD width="13%" height=30 class=category>
											<a id="employeeByEmployeeId" href="getRejectioning.do?order=employeeByEmployeeId" onclick="orderby(this)">申请人</a>
										</TD>
										<td width="13%" height=30 class=category>
											审核状况
										</td>
										<td width="13%" height=30 class=category>
											流程跟踪
										</td>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==4}">
												<TD width="8%" class=category>
													详细信息
												</TD>
											</c:if>
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
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
						                <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>
									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
											<TD align=center>
											<input type="checkbox" id="ids" name="ids" value="${data.id}"/>
										</TD>
												<TD align=middle>
													${data.applyBuy}
												</TD>
											
												<TD align=middle>
													${data.time}
													</TD>
													<TD align=middle>
													${data.employeeByEmployeeId.name }
												</TD>
												<td align=middle>
													<c:if test="${data.approve==0||data.approve==null}">
													未审核
													</c:if>
													<c:if test="${data.approve==1 ||data.approve==2}">
													已审核
													</c:if>
													<c:if test="${data.approve==8}">审核进行中</c:if>
												</td>
												<td align=middle>
												<a href="followAuditing.do?orderNo=${data.applyBuy}">流程跟踪</a>
												</td>
									    <c:forEach items="${option}" var="map">
											<c:if test="${map.key==4}">
												<TD align=middle>
													<a href="selectInfoRejectioning.do?trm=info&applyBuyinId=${data.id }&info=info">详细信息</a>
												</TD>
											</c:if>
											<c:if test="${map.key==2}">
												<TD align=middle>
												<c:if test="${data.approve!=8}">
													<A href="selectInfoRejectioning.do?trm=update&applyBuyinId=${data.id }"+"trm='update'";
														target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
													</a>
													</c:if>
												<c:if test="${data.approve==8}">审核进行中</c:if>
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD align=middle>
												<c:if test="${data.approve!=8}">
													<a href="javascript:void();" onclick="return delapplyBuy(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</c:if>
												<c:if test="${data.approve==8}">审核进行中</c:if>
												</TD>
											</c:if>
										</c:forEach>
											</TR>
											</c:forEach>
											<TR>
									<TD class=category colSpan=14 height=30>
									<p:pages url="getRejectioning.do"/>
									</TD>
											</tr>
									<!--循环结束-->
									<tr>
									  <td colspan="12" align="right">
									 <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
										<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" /> 
									</td>
									</tr>
								</TBODY>
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
					<TD></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
