<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
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
		<script type="text/javascript">
</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
      
		
		<c:if test="${docshow!=null}">
		<FORM name=form1 action="updatedocmark.do" method="post" onsubmit="return addValidators()" >
		<input type="hidden" value="${docshow.id }" name="id" id="id"/>		${docshow.id }	
		</c:if>
				<c:if test="${docshow==null}">
					<FORM name=form1 action="adddocmark.do" method="post" onsubmit="return addValidators()" >
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
										<c:if test="${docshow!=null}">
											&nbsp;修改单据类型(带*号的为必填项)
										</c:if>
										<c:if test="${docshow==null}">
											&nbsp;添加单据类型(带*号的为必填项)
										</c:if>
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
										<TD width="25%" height=30 align=right>
											单据名称：
										</TD>
										<TD width="75%" class=category>
									    <INPUT style="WIDTH: 200px" onblur="checkValueByRules('aname','','anameMsg')" id="aname" name="aname" value="${docshow.aname }">
									  			<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="anameMsg"></FONT>		
											</TD>
									</TR>
								
									<TR>
										<TD width="25%" height=30 align=right>
											单据标识：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" onblur="checkValueByRules('mark','','markMsg')" name="mark" id="mark" value="${docshow.mark}"/>
										<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="markMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											单据类型：
										</TD>
										<TD width="75%" class=category>
											<select style="WIDTH: 200px" onblur="checkValueByRules('otype','','otypeMsg')" name="otype" id="otype">
											<option value="" >--请选择单据类型--</option>
											<option value="1" <c:if test="${docshow.otype ==1}">checked=checked</c:if>>业务类</option>
											<option value="2" <c:if test="${docshow.otype ==2}">checked=checked</c:if>>技术类</option>
											<option value="3" <c:if test="${docshow.otype ==3}">checked=checked</c:if>>法务类 </option>
											<option value="4" <c:if test="${docshow.otype ==4}">checked=checked</c:if>>财务类 </option>
											<option value="5" <c:if test="${docshow.otype ==5}">checked=checked</c:if>>行政类 </option>
											
											</select>
										<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="otypeMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${docshow==null}">
											<INPUT class=button type=submit value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${docshow!=null}">
											<input class="button" type="submit" value="确认修改" />&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
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
<div id="dialog" title="错误信息提示">
       <p></p>
</div>
	</BODY>
</HTML>
