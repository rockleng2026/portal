<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>CDN套餐详细信息</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
</HEAD>

	<script type="text/javascript">
		function goUpdate(goUrl){
			window.location.href = goUrl;
		}
	</script>
<BODY >
		<FORM  id ="form1" name=form1 action="addContracta.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;CDN套餐详情
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="15%" height=30 align=right>套餐编号：	</TD>
										<TD width="35%" class=category>${data.id }</TD>
										<TD width="15%" height=30 align=right>套餐名称： </TD>
										<TD width="35%" class=category>${data.name }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>活动开始时间：</TD>
										<TD width="35%" class=category>${data.starttime }</TD>
										<TD align=right width="15%" height=30>活动结束时间：</TD>
										<TD width="35%" class=category>${data.endtime }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>套餐使用时长：</TD>
										<TD width="35%" class=category>${data.usetime }</TD>
										<TD width="25%" align=right height=30>收费类型：</TD>
										<TD width="25%" class=category>
											<c:if test="${data.chargeType == '0'}">免费</c:if>
											<c:if test="${data.chargeType == '1'}">赠送</c:if>
											<c:if test="${data.chargeType == '2'}">收费中预付</c:if>
											<c:if test="${data.chargeType == '3'}">后付</c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>原价：</TD>
										<TD width="35%" class=category>${data.price }</TD>
										<td width="25%" align=right height=30>实际价格：</td>
								 		<TD width="25%" class=category>${data.payprice }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>域名类型：</TD>
										<TD width="35%" class=category>${data.realmtype.name }</TD>
										<td width="25%" align=right height=30></td>
								 		<TD width="25%" class=category></TD>
									</TR>
									<TR>
										<TD align=right height=30 >套餐描述：</TD>
										<TD class=category colspan="3">
											${data.describe }
										</TD>
									</TR>
									<tr>
										<td width="25%" align=right height=30>包含属性：</td>
								 		<TD width="25%" class=category colspan="3">
								 			<c:forEach items="${centerList }" var="cen">
								 				${cen.setMealProperty.name }&nbsp;&nbsp;&nbsp;&nbsp;
								 			</c:forEach>
								 		</TD>
									</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category colspan="3">
											
											<INPUT class=button type="button" onClick="history.go(-1);" value=" 返回  ">
										</TD>									
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
