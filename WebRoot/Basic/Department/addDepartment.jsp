<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js"></script>
		<script type="text/javascript">
</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">

	window.onload = function()
		{			
			categorylist('parentId','${selectedid}','');
		}

function cancleManager(){
  $("#emp").val("");
  $("#empid").val("");
}
//分公司复选框
function filialecheck(){
	var a=$("input[name='fiiale']").attr("checked");
	if(a=='checked'){
		var selid=$("#parentId").val();
		if($('#fgsbm').css('display')=="none"){
			$("#fdh").css("display","");
		}
	}
	else{
		$("#fdh").css("display","none");
	}
}

//联动查找上级部门代号
function checkfilial(str)
{
	var parentid=$(str).val();
	var a=$("input[name='fiiale']").attr("checked");
	if(parentid!=-1){
		$.post("checkfilialDepartment.do",{parentid:parentid},
		function (data){
			if(data!="1"){
				$("#fgsbm").css("display","");
				$("#parenttext").html(data+"-");
				$("#ptext").attr("value",data+"-");
				$("#fmark").attr("value","");
				//隐藏分公司文本框
				$("#fdh").css("display","none");
				$("#filialemark").attr("value"," ");
			}
			else{
			$("#fgsbm").css("display","none");
			$("#parenttext").html("");
			$("#ptext").attr("value","");
			if(a=="checked")
				$("#fdh").css("display","");
			}
		});
	}else{
		$("#fgsbm").css("display","none");
		$("#parenttext").html("");
		$("#ptext").attr("value","");
		if(a=="checked")
			$("#fdh").css("display","");
	}
}


</script>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
      
		<FORM name=form1 action="addDepartment.do" method="post" onsubmit="return checkadd()" >
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
											&nbsp;添加部门(带*号的为必填项)
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
								<input type="hidden" value="${onedep.id }" id="id"/>
								<input type="hidden" value="0" name="delflag"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											名称：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('name','','nameMsg')" style="WIDTH: 200px" id="name" name="name" value="${onedep.name }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
											为分公司请勾选(非部门)<input style="border: 0px" type="checkbox" id="filialcheck" name="fiiale" value="1"  onclick="filialecheck()"  <c:if test="${not empty onedep.fiiale }">checked="checked"</c:if>  />
										</TD>
									</TR>
									<TR  id="fdh" <c:if test="${empty onedep.filialemark || empty onedep.fiiale }">style="display: none"</c:if>>
									<TD width="25%" height=30 align=right>公司代号</TD>
									<TD width="75%" class=category><input name="filialemark" id="filialemark" value="${onedep.filialemark }" ></TD>
									</TR>
									<TR>
										<td align=right height=30>
										上级部门：
										</td>
								   <td class="category">
										<select onchange="checkfilial(this)" id="parentId" name="parentId"  >
										</select>  
									</td>
									</TR>
									<!-- 
									<TR>
										<td align=right height=30>
										所属组：
										</td>
								   <td class="category">
									</td>
									</TR>
									 -->
									<TR  id="fgsbm" <c:if test="${empty onedep.filialemark }">style="display: none"</c:if>>
									<TD width="25%" height=30 align=right>部门代号</TD>
									<TD width="75%" class=category>
									<label id="parenttext" ></label><input id="fmark" name="fmark" value="${onedep.filialemark }" ></TD>
									<input id="ptext" name="ptext" type="hidden"/>
									</TR>
									<TR>
										<TD align=right height=30>
											联系电话：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" id="tel" name="tel" value="${onedep.tel }" onblur="checkValueByRules('tel',['phone'],'telMsg')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT id="telMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<td align=right height=30>
										主管：
										</td>
								   <td class="category">
										
										<input id="emp" value="${onedep.employee.name }"  onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="employee.id" type="hidden" value="${onedep.employee.id }" /><a onclick="cancleManager()" title="点击我可以设置主管为空">取消主管</a>
											   
									</td>
									</TR>
									<TR>
										<td align=right height=30>
										部门编号：
										</td>
								     <td class="category">
										<INPUT style="WIDTH: 200px" id="depNo" name="depNo" value="${onedep.depNo }" onblur="checkValueByRules('depNo',['depNum'],'depNoMsg')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT id="depNoMsg" color=#ff0000></FONT>
									</td>
									</TR>
									<tr>
									
									<TD align=right height=30>
											创建日期：
										</TD>
										<TD class=category>
										<c:if test="${onedep.time==null}">
										<%String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());  %>
										<INPUT readonly="readonly" style="WIDTH: 150px" id="time" name="time" value="<%=date %>">
											&nbsp;
										</c:if>
										<c:if test="${onedep.time!=null}">
											<INPUT readonly="readonly" style="WIDTH: 150px" id="time" name="time" value="${onedep.time }">
											&nbsp;
											</c:if>
										</TD>
										</tr>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${onedep==null}">
											<INPUT class=button type=submit value="确认添加 " >
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${onedep!=null}">
											<input class="button" type="button" value="确认修改" onclick="editdep('editDepartment.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
									<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
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
