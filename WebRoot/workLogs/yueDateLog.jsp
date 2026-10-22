<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdiv.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<SCRIPT language=javascript>
		function del(id)
		{
		var t=new Date();
		var url="delIntentFollowUp.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getpageCustomer.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}

</SCRIPT>



		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<SCRIPT>

		function CheckAll(form)  {
		  for (var i=0;i<form.elements.length;i++)    {
		    var e = form.elements[i];
		    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
		   }
		  }
		  	 function check()
		 {
		 		
		 	var o= document.form1.elements["ids"] 
		 	var isOk=false; 
			for(i=0;i<o.length;i++) 
			{
				if(o[i].checked)
				{ 
					isOk=true;
					break;
				}
			} 
			if(!isOk)
			{
				alert("请选择要删除的员工记录");
			}
			
			
		 	return isOk;
		}
		
</SCRIPT>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
									    <% List leavelist=(List)request.getAttribute("leavelist"); %>
										&nbsp;共请假<font style="font-weight: bold; color: red;"><%=leavelist.size() %>次</font>，以下是员工本月请假的列表信息。
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
						<!--startprint-->
						<FORM name=form1 action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
                            <% if(leavelist.size()>0){ %>
								<TBODY>
									<TR align="center">
									
										<TD width="20%" height=30 class=category>
											请假人
										</TD>
										<TD width="20%" class=category>
											请假开始时间
										</TD>
										<TD width="20%" class=category>
											请假结束时间
										</TD>
										<TD width="20%" class=category>
											类型
										</TD>
										<TD width="20%" class=category>
											内容
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${leavelist}" var="leave">
											<TR>
												<TD align=middle height=25>
													${leave.temp}
												</TD>
												<TD align=middle>
													${leave.begintime}
												</TD>
												<TD align=middle>
													${leave.endtime}
												</TD>
												<TD align=middle>
													<c:if test="${leave.leavetype==0}">休假(假)</c:if>
											        <c:if test="${leave.leavetype==1}">病假</c:if>
											        <c:if test="${leave.leavetype==2}">事假</c:if>
											        <c:if test="${leave.leavetype==3}">其他</c:if>
												</TD>
												<TD align=middle>
													${leave.content}
												</TD>
											</TR>	
									</c:forEach>
									<!--循环结束-->
								</TBODY>
							<%}else{ %>
							<TR align="center"><td>此员工没有请假信息。</td></TR>
							<%} %>
							</TABLE>
						</FORM>
					</TD>
					<TD></TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
