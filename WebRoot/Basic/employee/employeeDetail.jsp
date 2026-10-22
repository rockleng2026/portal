<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.*" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
	<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		
		<script type="text/javascript">
</SCRIPT>

<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<LINK href="Css/style.css" type=text/css rel=stylesheet>
<STYLE>
BODY { BACKGROUND-COLOR: #ffffff}
</STYLE>

		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
      
		<FORM name=form1 action="addemp.do" method="post" onsubmit="return addValidators()" >
		<c:if test="${empty showemp}">
			<input type="hidden" value="0" name="isLoginAccount" id="islogin">
			</c:if>
			<c:if test="${not empty showemp}">
			<input type="hidden" value="${showemp.isLoginAccount }" name="isLoginAccount" id="islogin">
			</c:if>
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
											&nbsp;员工资料(带*号的为必填项)
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
						<TD>
								<input type="hidden" value="${showemp.id }" id="id"/>
								<input type="hidden" value="0" name="delflag"/>
						</TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="15%" height=30 align=right>
											名称：
										</TD>
										<TD width="35%" class=category>
											${empDetial.name }
										</TD>
										<TD width="15%" height=30 align=right>
											民族：
										</TD>
										<TD width="35%" class=category>
											${empDetial.nation }
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											身份证号码：
										</TD>
										<TD width="35%" class=category>
											${empDetial.cardid }
										</TD>
										<TD align=right width="15%" height=30>
											健康状况：
										</TD>
										<TD width="35%" class=category>
											${empDetial.health}
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											性别：
										</TD>
										<TD width="35%" class=category>
										<c:if test="${empDetial.sex==1||empDetial.sex==null}">
											男
											
											</c:if>
											<c:if test="${empDetial.sex==2}">
										
											女
											</c:if>
										</TD>
										<TD align=right width="15%" height=30>
											身高：
										</TD>
										<TD width="35%" class=category>
											${empDetial.stature }
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											入职时间：
										</TD>
										<TD width="35%" class=category>
											${empDetial.entryTime }
										</TD>
										<TD align=right width="15%" height=30>
											是否离职：
										</TD>
										<TD width="35%" class=category>
										<c:if test="${empDetial.isLeave==1||empDetial.isLeave==null}">
											在职
											</c:if>
											<c:if test="${empDetial.isLeave==0}">
											离职
											</c:if>
										</TD>
									</TR>
									<c:if test="${empDetial.isLeave==0}">
									<TR>
										<TD align=right width="15%" height=30>
											离职时间
										</TD>
										<TD width="35%" class=category>
											${empDetial.leaveTime }
										</TD>
										<TD align=right width="15%" height=30>
											离职原因：
										</TD>
										<TD width="35%" class=category height="50">
											${empDetial.leaveReason }
										</TD>
									</TR>
									</c:if>
									<TR>
										<TD width="25%" align=right height=30>
											联系电话：
										</TD>
										<TD width="25%" class=category>
											${empDetial.tel }
										</TD>
										<TD align=right width="15%" height=30>
											体重：
										</TD>
										<TD width="35%" class=category>
											${empDetial.heft }
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											年龄：
										</TD>
										<TD width="25%" class=category>
										${empDetial.age }
										</TD>
									<TD align=right width="15%" height=30>
											婚否：
										</TD>
										<TD width="35%" class=category>
										<c:if test="${empDetial.married==1}">
											已婚
											</c:if>
											<c:if test="${empDetial.married==2||empDetial.married==null}">
											未婚
											</c:if>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											学历：
										</TD>
										<TD width="25%" class=category>
											${empDetial.education }
										</TD>
										<TD align=right width="25%" height=30>
											户籍地：
										</TD>
										<TD width="25%" class=category>
											${empDetial.censusreg }
											
										</TD>
									</TR>
										<TR>
										<td width="25%" align=right height=30>
										部门：
										</td>
								     <td width="25%" class="category">
										${empDetial.department.name }
									</td>
									<TD align=right width="15%" height=30>
											职位：
										</TD>
										<TD width="35%" class=category>
											${empDetial.groups.groupName}
										</TD>
									</TR>
									<TR>
										<td width="25%" align=right height=30>
										编号：
										</td>
								 		 <TD width="25%" class=category>
											${empDetial.empNo }
										</TD>
										<TD align=right width="15%" height=30>
											计算机水平：
										</TD>
										<TD width="35%" class=category>
											${empDetial.computeleve }
										</TD>
									</TR>
										<TR>
										<TD width="25%" align=right height=30>
											生日：
										</TD>
										<TD width="25%" class=category>
										${empDetial.birth }
										</TD>
										<TD align=right width="15%" height=30>
											家庭地址：
										</TD>
										<TD width="35%" class=category>
											${empDetial.place }
										</TD>
									</TR>
									<tr>
									<TD width="25%" align=right height=30>
											创建日期：
										</TD>
										<TD width="25%" class=category>
										${empDetial.time }
										</TD>
										<TD align=right width="15%" height=30>
											现居地：
										</TD>
										<TD width="35%" class=category>
											${empDetial.nowplace }
										</TD>
										</tr>
										<TR>
										<td width="25%" align=right >
										E-mail:
										</td>
								 		 <TD width="25%" class=category>
										${empDetial.email }
										</TD>
										<TD align=right width="15%" >
											英语水平
										</TD>
										<TD width="35%" align=left class=category>
											${empDetial.engleve }
										</TD>
									</TR>
									
									
									
									
									
									
									<TR>
										<td width="25%" align=right >
										员工相片:
										</td>
								 		 <TD width="25%" class=category>
								 		 <c:if test="${empDetial.photo==''||empDetial.photo==null }">暂无相片</c:if>
								 		 <c:if test="${empDetial.photo!=null }">
								 		 <img src="/FAJxc${empDetial.photo }"></c:if>
										
										</TD>
										<TD align=right width="15%" >
											
										</TD>
										<TD width="35%" align=left class=category>
											
										</TD>
										
									</TR>
									
									
									
									
									
									
									
									
									
									
									
									
									
											<TR>
										<td width="25%" align=right >
										紧急联系电话：
										</td>
								 		 <TD width="25%" class=category>
										${empDetial.urgenttel }
										</TD>
										<TD align=right width="15%" >
											特长：
										</TD>
										<TD width="35%" align=left class=category>
											${empDetial.specialty }
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
			
<div>
	 <jsp:include page="../../Basic/fieldRemarkShow.jsp"></jsp:include>
</div>
		</FORM>
		<div>
			 <jsp:include page="../../System/uploadfiles.jsp"></jsp:include>
		</div>
		<div id="dialog" title="错误信息提示">
       <p></p>
</div>

	</BODY>
</HTML>
