<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>收款单列表</title>
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

		<SCRIPT language=javascript>
		
		function del(id)
		{
		var t=new Date();
		var url="delcharge.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="selectcharge.do?t="+t;
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
</head>
<body onload="showbc()">
<script type="text/javascript">
function aa()
{
 window.returnValue = document.getElementById("jjj").value;
    window.close();

}
</script>
		<FORM name=form2 action="selectsupplier.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
						<TD align=right width="95%">
							收款单号：
							<INPUT name=name id= "jjj">
							<INPUT class=button type=submit  value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
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
										&nbsp;收款单记录查询
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
						<FORM name=form1 id="form1" action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">
									     <TD width="5%" height=30 class=category>
											选择
										</TD>   
										<TD width="10%" height=30 class=category>
											收款单号
											<input type="hidden" id="bl" value="${tag }">
										</TD>
										<TD width="10%" class=category>
											<a id="accountPayable" href="selectcharge.do?order=accountPayable" onclick="orderby(this)">应付金额</a>单位：元/RMB)
										</TD>
										<TD width="9%" class=category>
											<a id="paymentAmount" href="selectcharge.do?order=paymentAmount" onclick="orderby(this)">实付金额</a>((单位：元/RMB))
										</TD>
										<TD width="10%" class=category>
											付款帐号
										</TD>
										<TD width="8%" class=category>
											<a id="employeeByEmpId" href="selectcharge.do?order=employeeByEmpId" onclick="orderby(this)">收款员工</a>
										</TD>
										<TD width="10%" class=category>
											<a id="collectionTime" href="selectcharge.do?order=collectionTime" onclick="orderby(this)">收款时间</a>
										</TD>
											<TD width="8%" class=category>
											审核状态
										</TD>
										<TD width="8%" class=category>
											详细
										</TD>
										<TD width="9%" class=category>
											流程跟踪
										</TD>
										<TD width="5%" class=category>
											修改
										</TD>
										<TD width="5%" class=category>
											删除
										 <input type="hidden" id="marker2" name="marker2" value="${marker }" />
							             <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data" >
									<TR>
									     <TD align=center>
											<input type="checkbox" id="ids" name="ids" value="${data.id}"/>
										</TD>
										<TD align=center>
											${data.chargeNo}
										</TD>
										<TD align=center>
											${data.accountPayable}
										</TD>
										<TD align=center>
											${data.paymentAmount}
										</TD>
										<TD align=center>
											${data.payCode}
											</TD>
											<TD align=center>
											${data.employeeByEmpId.name}
										</TD>
										<TD align=center>
											${data.collectionTime}
										</TD>
											<TD align=center>
											<c:if test="${data.isAuditing == 0||data.isAuditing == null}">未审核</c:if>
											<c:if test="${data.isAuditing == 1||data.isAuditing == 2}">已审核</c:if>
											<c:if test="${data.isAuditing==8}">审核进行中</c:if>
										</TD>
										<TD align=center>
											<a href="updatePagecharge.do?trim=info&id=${data.id }&info=info&purNo=${data.chargeNo}"	target=right>详细信息</a>
										</TD>
										<TD align=center>
											<a href="followAuditing.do?orderNo=${data.chargeNo}">流程跟踪</a>
										</TD>
										<TD align=center>
										<c:if test="${data.isAuditing!=8}">
											<A href="updatePagecharge.do?id=${data.id }&isa=${data.isAuditing}"	target=right>
												<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif" align=absMiddle border=0>
											</a>
											</c:if>
											<c:if test="${data.isAuditing==8}">审核进行中</c:if>
										</TD>
										<TD align=center>
											<c:if test="${data.isAuditing!=8}">
												<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath() %>/img/del.gif" width="20px" height="20px" border=0 ></a>
											</c:if>
											<c:if test="${data.isAuditing==8}">审核进行中</c:if>
										</TD>
									</TR>
									</c:forEach>
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
						</TD>
					</TR>
					<tr>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<td>
							 <p:pages url="selectcharge.do"/>
						</td>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</tr>
				</TBODY>
			</TABLE>
	</BODY>
</HTML>
