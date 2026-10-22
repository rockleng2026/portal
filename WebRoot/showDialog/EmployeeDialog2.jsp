<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta   http-equiv="Pragma"   content="no-cache"> 
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		
		<base target="_self">
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<SCRIPT>

		
		
</SCRIPT>
<script type="text/javascript">
function dialogInfo(id)
{
	var url="selectempinfoOutbound.do";
	$.post(url,{id:id,mark:"server"},function(data){
		
			$("#selectinfo").append(data);
			$("#selectList").css("display","none");
			$("#close").css("display","");
	});
}
function closeInfo()
{
	$("#selectinfo").html("");
	$("#close").css("display","none");
	$("#selectList").css("display","");
}
	
</script>

			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							员工姓名：
							<INPUT name=ename id="ename">
							<INPUT type="button" onclick="selectinfo('showDialogOutbound.do?mark=employee&ename','ename')" value=" 查询 ">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		<div id="selectList" name="selectList">
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
										&nbsp;员工信息查询
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
						<FORM name=form1 action="" onsubmit="">
						
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="12%" class=category>
											姓名
										</TD>
										<TD width="5%" height=30 class=category>
											年龄
										</TD>
										<TD width="5%" class=category>
											性别
										</TD>
										<TD width="13%" class=category>
											联系电话
										</TD>
										<TD width="12%" class=category>
											生日
										</TD>
										<TD width="4%" class=category>
											学历
										</TD>
										<TD width="7%" class=category>
											所属部门
										</TD>
										<TD width="9%" class=category>
											员工编号
										</TD>
										<TD width="15%" class=category>
											创建时间
										</TD>
										<TD width="10%" class=category>
											详细信息
										</TD>
										<TD width="15%" class=category>
											选择员工
										</TD>
										
									</TR>


									<!--循环-->

									<c:forEach items="${pages.pageList}" var="data" >
											<TR id="tr${data.id }" ondblclick="getvalue('${data.id},${data.name }')" onmouseover="this.style.background='red'"  onmouseout="this.style.background='none'">
												
												<TD align=middle height=25>
											
													${data.name}
												</TD>
												<TD align=middle>
											
													${data.age}
												</TD>
												<TD align=middle>
											    <c:if test="${data.sex==1}">男</c:if>
													<c:if test="${data.sex==2}">女</c:if>
												</TD>
												<TD align=middle>
											
													${data.tel}
												</TD>
												<TD align=middle>
												<c:set var="birthDate" scope="request" value="${data.birth}"  />
											${data.birth}
													</TD>
													<TD align=middle>
													${data.education }
												</TD>
												<TD align=middle>
													${data.department.name}
												</TD>
													<TD align=middle>
													${data.empNo}
												</TD>
													<TD align=middle>
													${data.time }
												</TD>
												<TD align=center>
													<a href="#" onclick="dialogInfo(${data.id })">	详细信息</a>
												</TD>
												<TD align=center>
													<input id="" name="" type="button" value="选择该员工" onclick="selectemp('${data.id}','${data.name}')"/>
												</TD>
											</TR>
											</c:forEach>

	<tr>
								<td class=category colSpan=14 height=30>
										
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
					<TD><pp:pages1 url="showDialogOutbound.do?mark=employee"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</div>
		<div>
		<table name="selectinfo" id="selectinfo"  class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">
					
				</table>
			</div>
	</BODY>
</HTML>
