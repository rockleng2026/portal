<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>缓存-更新</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
	</head>
	<script type="text/javascript">
    window.onload = function()
		{
			//missiontypelist('typeid','','');
		}
 	function cdnsubmit(){

 		//var typeid = $("#typeid").val();
 		var name = $("#name").val();
 		var description = $("#urllist").val();
 		
 		if(name == ''){
 			alert("请填写任务名称!");
 			$("#name").focus();
 			return false;
 		}
 		if(description == ''){
 			alert("请填写任务描述!");
 			$("#urllist").focus();
 			return false;
 		}
 		
 		//var mes=$("#mesty");
 		//mes.empty();
 		//$.post('selbysuperidmessage.do',{surperid:surperid},
 		//function (data){
 		//	if(data!=1)
 		//		mes.append(data);
 		//});
 		$("#cdnform").submit();
 	}
 </script>
	<body>
		<div style="margin-left: 60px">
			<div style="float: left; width: 840px;">
				<FORM id="cdnform" name="cdnform"
					action="<%=request.getContextPath()%>/clearCachemission.do" method="post">
					<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
						border=0>
						<TBODY>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
								</TD>
								<TD width="100%" background=<%=request.getContextPath()%>
									/images/r_0.gif>
									<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
										<TBODY>
											<TR>
												<TD style="font-size: 12px; color: red;">
													&nbsp;缓存更新(带*号的为必填项)
												</TD>
												<TD align=right>
													&nbsp;
												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
								</TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
										align="center" border=1 style="font-size: 14px;">
										<TBODY>
											<TR>
												<TD width="80px;" height=30 align=right align="left">

												</TD>
												<TD>
													&nbsp; CDN服务器：
													<select id="server" name="server"
														style="width: 200px;">
														<option value="">
															--请选择--
														</option>
													</select>
												</TD>
											</TR>
											<!-- 
									<TR>
										<TD width="10%" height=30 align=right>
											接收人：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="receiver" id="receiver" readonly="readonly">
										</TD>
									</TR>
									 -->
											<TR>
												<TD width="10%" height=30 align=right>
													网站域名：
												</TD>
												<TD width="10%" class=category>
													<INPUT style="WIDTH: 95%" name="name" id="name" />
											</TD>
											</TR>
											<TR>
												<TD width="25%" height=30 align=right>
													清除缓存地址：<br/><font color="red">(多个地址请用|分割)</font>
												</TD>
												<TD width="75%" class=category>
													<textarea rows="20" cols="70" name="urllist"
														id="urllist"></textarea><FONT color=#ff0000>*</FONT>
												</TD>
											</TR>
											
												<TR>
												<TD height=30>
													&nbsp;
												</TD>
												<TD class=category>
													<INPUT class=button type="button" value="确认提交 "
														onclick="cdnsubmit()">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<INPUT class=button type=reset value=" 重置 ">

												</TD>
											</TR>
										</TBODY>
									</TABLE>
								</TD>
								<TD></TD>
							</TR>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
								</TD>
								<TD></TD>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
								</TD>
							</TR>
						</TBODY>
					</TABLE>
				</FORM>
			</div>
		</div>
	</body>
</html>