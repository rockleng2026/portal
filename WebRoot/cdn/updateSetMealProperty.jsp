<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>修改CDN套餐属性详细信息</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		
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
		function addValidators()
		{
			
			flag = window.confirm("是否确认提交？");
			var mark = $("#is").val();
			if(mark=='1'){
				return false;
			}	
			if(!flag){
				return false;
				
			}
			var name=$("#name").val();
			if(name==null||name=="")
			{
				alert("商品名称不能为空");
				return false;
				}
			var flow=$("#flow").val();
			var bandwidth=$("#bandwidth").val();
			var reg = new RegExp("^[0-9]*$");
			if(!reg.test(flow))
			{
				alert("带宽请输入数字");
				return false;
			}
			if(!reg.test(bandwidth))
			{
				alert("单价请输入数字");
				return false;
			}
			var hitnum=$("#hitnum").val();
			var flow1=$("#flow1").val();
			if(!reg.test(flow1))
			{
				alert("优惠价请输入数字");
				return false;
				}
			if(hitnum-flow1<0)
			{
				alert("优惠价不能比原价打");
				return false;
				}
			
		}
		function zongjia()
		{
			
			var flow=$("#flow").val();
			var bandwidth=$("#bandwidth").val();
			var reg = new RegExp("^[0-9]*$");
			if(!reg.test(flow))
			{
				alert("带宽请输入数字");
				return false;
			}
			if(!reg.test(bandwidth))
			{
				alert("单价请输入数字");
				return false;
			}
			document.getElementById("hitnum").value=flow*bandwidth;

		}
	</script>
<BODY >
		<FORM  id ="form1" name=form1 action="updateCDNSetMealPropertyAction.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;修改CDN商品属性
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
										<TD width="15%" height=30 align=right>
											商品编号：
										</TD>
										<TD width="35%" class=category>
											${data.id }
											<INPUT type="hidden" id="id" name="id" value="${data.id }">
										</TD>
										<TD width="15%" height=30 align=right>
											商品名称：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('name','','nameMsg')" id="name" name="name" value="${data.name }">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="15%" height=30 align=right>
											带宽：
										</TD>
										<TD width="35%" class=category>
											<INPUT id="flow" name="flow" value="${data.flow }"><font color="red"> G</font>
										</TD>
										<TD align=right width="15%" height=30>
											单价：
										</TD>
										<TD width="35%" class=category>
											<INPUT id="bandwidth" name="bandwidth" onchange="zongjia()" value="${data.bandwidth }"><font color="red"> G/元</font>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											原价：
										</TD>
										<TD width="35%" class=category>
											<input type="text" id="hitnum" name="hitnum" disabled="disabled" value="${data.hitnum }"><font color="red"> 元</font>
										</TD>
										<TD align=right width="15%" height=30>
											优惠价：
										</TD>
										<TD width="35%" class=category>
											<input id="flow1" name="flow1" value="${data.flow1 }"/><font color="red"> 元</font>
										</TD>
									</TR>
									
									<TR>
										<TD align=right width="15%" height=30>
											线路:
											
										</TD>
										<TD width="35%" class=category>
										<SELECT id="flow2" name="flow2" value="this.value">
											<option <c:if test="${data.flow2 =='电信'}">selected="selected"</c:if> value="电信" >电信</option>
											<option  <c:if test="${data.flow2 =='联通'}">selected="selected"</c:if> value="联通">联通</option>
											<option <c:if test="${data.flow2 =='移动'}">selected="selected"</c:if> value="移动">移动</option>
											<option <c:if test="${data.flow2 =='网通'}">selected="selected"</c:if> value="铁通">铁通</option>
											<option <c:if test="${data.flow2 =='教育网'}">selected="selected"</c:if> value="教育网">教育网</option>
										</SELECT>
										</TD>
										<TD width="15%" align=right height=30>
										</TD>
										<TD width="35%" class=category>
										</TD>
									</TR>
									<!-- 
									<TR>
										<TD align=right width="15%" height=30>
											流量-类别4：
										</TD>
										<TD width="35%" class=category>
											<input id="flow4" name="flow4" value="${data.flow4 }"/>
										</TD>
										<TD width="15%" align=right height=30>
											带宽-类别1：
										</TD>
										<TD width="35%" class=category>
											<input id="bandwidth1" name="bandwidth1" value="${data.bandwidth1 }"/>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											带宽-类别2：
										</TD>
										<TD width="35%" class=category>
											<input id="bandwidth2" name="bandwidth2" value="${data.bandwidth2 }"/>
										</TD>
										<TD width="15%" align=right height=30>
											带宽-类别3：
										</TD>
										<TD width="35%" class=category>
											<input id="bandwidth3" name="bandwidth3" value="${data.bandwidth3 }"/>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											带宽-类别4：
										</TD>
										<TD width="35%" class=category>
											<input id="bandwidth4" name="bandwidth4" value="${data.bandwidth4 }"/>
										</TD>
										<TD width="15%" align=right height=30>
											hit连接数-类别1：
										</TD>
										<TD width="35%" class=category>
											<input id="hitnum1" name="hitnum1" value="${data.hitnum1 }"/>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											hit连接数-类别2：
										</TD>
										<TD width="35%" class=category>
											<input id="hitnum2" name="hitnum2" value="${data.hitnum2 }"/>
										</TD>
										<TD width="15%" align=right height=30>
											hit连接数-类别3：
										</TD>
										<TD width="35%" class=category>
											<input id="hitnum3" name="hitnum3" value="${data.hitnum3 }"/>
										</TD>
									</TR>
									<tr>
										<TD align=right width="15%" height=30>
											hit连接数-类别4：
										</TD>
										<TD width="35%" class=category>
											<input id="hitnum4" name="hitnum4" value="${data.hitnum4 }"/>
										</TD>
										<TD width="25%" class=category>
										</TD>
										<TD width="25%" class=category>
										</TD>
									</tr>
									 -->
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category colspan="3">
											<INPUT class=button type=submit value="确认修改">
											<INPUT class=button type=reset value=" 重置 ">
											<input type="hidden" id="delflag" name="delflag" value="0" />
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
