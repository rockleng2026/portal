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
		<title>写信箱</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script language=javascript
			src="<%=request.getContextPath()%>/js/message/0219.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/dtree.js"></script>

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
 	//alert("消息类型"+mes);
 	if(mes=='-1'){
 		alert("请选择类型！");
		return false;
		}
 	}
 	
 	
 	

 
 </script>
	<body>
		<div style="margin-left: 60px">
			<FORM name="customerform"
				action="<%=request.getContextPath()%>/addmessage.do" method="post"
				onsubmit="return val()">
				<div style="float: left; width: 500px;">
					<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor=#c4d8ed
						border=0>
						<TBODY>
							<TR>
								<TD>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
								</TD>
								<TD width="100%"
									background="<%=request.getContextPath()%>/images/r_0.gif">
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TBODY>
											<TR>
												<TD style="font-size: 12px; color: red;">
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
								<TD></TD>
								<TD>
									<TABLE class="toptable grid" align="center"
										style="font-size: 14px; border-collapse: collapse; border: #708090 1px solid">
										<TBODY>
											<TR>
												<TD width="10%;" height=30 align="right">
													消息类型：
												</TD>



												<!--<s:select onchange="selbysuperid(this)" id="mestype"
														cssStyle="width:100px;height:22px;" name="mestype"
														list="#request.messagetypes" listKey="messagetypeid"
														listValue="type" value="%{-1,#request.onedep.parentId}"
														headerKey="-1" headerValue="请选择">
													</s:select>
													-->
												<td>
												   <input type="hidden" value="${messagetypes.messagetypeid }" name="messagetypeBySendertype.messagetypeid"/>
													<input type="hidden" disabled="disabled"
														value="${messagetypes.type }" size="10" id="mestype"
														name="mestype">
													
                                                     <select id="mesty" name="messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
													   <option value="-1">请选择！！</option>  
														<c:forEach items="${messagetypes1}" var="data"> 
														    
															<option value="${data.messagetypeid}"> 
																 
																${data.type} 
															</option> 
														</c:forEach> 
													</select>
													
												</td>
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

											</TR>
											<TR>
												<TD width="10%" height=30 align=right>
													接收人：
												</TD>
												<TD width="10%" class=category>

													<INPUT style="WIDTH: 95%" name="receiver" id="receiver">
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
											<!-- 
									<TR>
										<TD width="10%" height=30 align=right>
											 <input type="button" name="addaccessory" id="addaccessory" value="添加附件">
										</TD>
										<td></td>
									</TR>-->
											<TR>
												<TD width="20%" height=30 align=right>
													消息内容：

												</TD>
												<TD width="80%" class=category>
													<textarea rows="15" cols="50" name="messagecontent"
														id="messagecontent"></textarea>
													&nbsp;
													<FONT color=#ff0000>*</FONT>
												</TD>
											</TR>
											<TR>
												<TD height=30>
													&nbsp;
												</TD>
												<TD class=category>
													<input type="hidden" id="customers" name="customers">
													<INPUT class=button type="submit" value="确认提交 "
														onclick="setusers()">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<INPUT class=button type=reset value=" 重置 ">

												</TD>
											</TR>
										</TBODY>
									</TABLE>
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
									<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
								</TD>
					</TABLE>
				</div>
			</FORM>
			<div id="sub-dept"
				style="float: left; width: 230px; margin: 0px; padding: 0px; border: 0px;">
			</div>
		</div>
		<script type="text/javascript">
	$("#sub-dept").load("showCustomer.do");
	function setusers(){
	var mesty=document.getElementById("mesty").value;
   // alert("adffdf"+emps);
	$("#customers").attr("value",emps);
}
function add()
{
     var typeId=document.getElementById("typeId").value;
   if(type ==-1)
   {
        alert("请选择消息类型!!");
	     return false;
   }
     var titleweb=document.getElementById("titleweb").value;
   if(titleweb =="" || titleweb==null)
   {
        alert("请选择标题!!");
	     return false;
   }
     var messagecontent=document.getElementById("messagecontent").value;
   if(messagecontent =="" || messagecontent==null)
   {
        alert("请选择消息内容!!");
	     return false;
   }
  
   
}
</script>
	</body>
</html>