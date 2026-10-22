<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>CDN套餐属性详细信息</title>
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
		<FORM  id ="form1" name=form1 action="" method="post" onsubmit="return addValidators()">
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
											&nbsp;CDN商品属性详情
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
										<TD width="15%" height=30 align=right>商品编号：	</TD>
										<TD width="35%" class=category>${data.id }</TD>
										<TD width="15%" height=30 align=right>商品名称： </TD>
										<TD width="35%" class=category>${data.name }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>带宽大小：</TD>
										<TD width="35%" class=category>${data.flow }<font color="red"> G</font></TD>
										<TD align=right width="15%" height=30>单价：</TD>
										<TD width="35%" class=category>${data.bandwidth }<font color="red"> G/元</font></TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>原价：</TD>
										<TD width="35%" class=category>${data.hitnum }<font color="red"> 元</font></TD>
										<TD width="25%" align=right height=30>优惠价：</TD>
										<TD width="35%" class=category>${data.flow1 }<font color="red"> 元</font></TD>
									</TR>
									
									<TR>
										<TD align=right width="15%" height=30>线路：</TD>
										<TD width="35%" class=category>${data.flow2 }</TD>
										<td width="25%" align=right height=30></td>
								 		<TD width="25%" class=category></TD>
									</TR>
									<!-- 
									<TR>
										<TD align=right width="15%" height=30>流量-类别4：</TD>
										<TD width="35%" class=category>${data.flow4 }</TD>
										<TD width="25%" align=right height=30>带宽-类别1</TD>
										<TD width="25%" class=category>${data.bandwidth1 }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>带宽-类别2：</TD>
										<TD width="35%" class=category>${data.bandwidth2 }</TD>
										<TD width="25%" align=right height=30>带宽-类别3</TD>
										<TD width="25%" class=category>${data.bandwidth3 }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>带宽-类别4：</TD>
										<TD width="35%" class=category>${data.bandwidth4 }</TD>
										<TD width="25%" align=right height=30>hit连接数-类别1</TD>
										<TD width="25%" class=category>${data.hitnum1 }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>hit连接数-类别2：</TD>
										<TD width="35%" class=category>${data.hitnum2 }</TD>
										<TD width="25%" align=right height=30>hit连接数-类别3</TD>
										<TD width="25%" class=category>${data.hitnum3 }</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>hit连接数-类别4：</TD>
										<TD width="35%" class=category>${data.hitnum4 }</TD>
										<TD width="25%" class=category></TD>
										<TD width="25%" class=category></TD>
									</TR>
									 -->
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category colspan="3">
											<INPUT class=button type="button" onClick="goUpdate('dealCDNSetMealPropertyAction.do?id=${data.id }&type=update');" value=" 修改 ">
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
