<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
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
		<FORM name=form2 action="employees.do?">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath()%>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							<input type="button" name="seach" value="筛选查询"  onclick="showDIV('functionDiv','')">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;记录查询
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

								<TBODY>
									<TR align="center">
									
										<TD width="18%" height=30 class=category>
											编号
										</TD>
										<TD width="13%" class=category>
											客户姓名
										</TD>
										<TD width="13%" class=category>
											原来负责人
										</TD>
										<TD width="13%" class=category>
											新的负责人
										</TD>
										<TD width="15%" class=category>
											移交时间
										</TD>
										<TD width="28%" class=category>
											原因查看
										</TD>
									</TR>
									<!--循环-->
									<c:forEach items="${pages.pageList}" var="data">
											<TR>
												<TD align=middle height=25>
													${data.id}
												</TD>
												<TD align=middle>
													${data.customer.realName}
												</TD>
												<TD align=middle>
													${data.employeeByOldPrincipal.name}
												</TD>
												<TD align=middle>
													${data.employeeByNewPrincipal.name}
												</TD>
												<TD align=middle>
													${data.movetime}
												</TD>
												<TD align=middle>
													<a href="getCustomerMove.do?id=${data.id}">查看</a>
												</TD>
											</TR>
											</c:forEach>				
											<TR>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
						</FORM>
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD id="page"><p:pages url="getpageCustomerMove.do?funid=14" /></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
