<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>写信箱</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
			<script language=javascript src="<%=request.getContextPath()%>/js/message/0219.js"></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
  </head>
 <script type="text/javascript">
 
 	function selbysuperid(str){
 		var surperid=$(str).val();
 		
 		var mes=$("#mesty");
 		mes.empty();
 		$.post('selbysuperidmessage.do',{surperid:surperid},
 		function (data){
 			if(data!=1)
 				mes.append(data);
 		});
 	}
 	
 	function val(){
 	var mes=$("#mesty").val();
 	if(mes=='-1'){
 		alert("请选择类型！");
		return false;
		}
 	}
 
 </script>
  <body>
  <div style="margin-left: 60px">
<FORM name="customerform" action="<%=request.getContextPath()%>/addmessage.do"  method="post"  onsubmit="return val()">
	<div style="float:left; width:840px;">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=<%=request.getContextPath()%>/images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD style="font-size: 12px;color: red;">
											&nbsp;写信箱中(带*号的为必填项)
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
						<TD ></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align="center" border=1  style="font-size: 14px;">
								<TBODY>										
									<TR>
										<TD width="80px;" height=30 align=right align="left">
											
										</TD>
										<TD>
										&nbsp;
										消息类型：
											<s:select onchange="selbysuperid(this)" id="mestype" cssStyle="width:100" name="mestype" list="#request.messagetypes" listKey="messagetypeid" listValue="type" value="%{-1,#request.onedep.parentId}" headerKey="-1" headerValue="请选择" >
										</s:select> 
										<select style="width:100px" name="messagetypeByMessagetype.messagetypeid" id="mesty">
												<option value="-1">请选择</option>	
											</select>
											&nbsp;
											<!--  
										消息优先级：
											<select style="width:60px">
												<option>普通</option>
												<option>一般</option>
												<option>紧急</option>
											</select>
											&nbsp;
											是否需求回执：
											<input type="checkbox" name="">
											-->
										</TD> 
									</TR>	
									<TR>
										<TD width="10%" height=30 align=right>
											接收人：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="receiver" id="receiver" readonly="readonly">
										</TD>
									</TR>
										
									<TR>
										<TD width="10%" height=30 align=right>
											标题：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="titleweb" id="titleweb">
										</TD>
									</TR>	
									
									<TR>
										<TD width="10%" height=30 align=right>
											<input type="button" name="addaccessory" id="addaccessory" value="添加附件">
										</TD>
										<td></td>
									</TR>
									<TR>
									<TD width="25%" height=30 align=right>
											消息内容：
										</TD>
										<TD width="75%" class=category>
											<textarea rows="20" cols="100" name="messagecontent" id="messagecontent" ></textarea>
											&nbsp;
											<FONT color=#ff0000 >*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<input type="hidden" id="users" name="users">
											<INPUT class=button type="submit" value="确认提交 " onclick="setusers()">
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
			</div>
		</FORM>
	<div id="sub-dept" style="float:left; width:230px;margin: 0px;padding: 0px;border: 0px;">
	
	</div>
</div>	
  <script type="text/javascript">
	$("#sub-dept").load("alldeptmessageDepartment.do");
	function setusers(){
	alert(""+emps);
	$('#users').attr("value",emps);
}
</script>
  </body>
</html>