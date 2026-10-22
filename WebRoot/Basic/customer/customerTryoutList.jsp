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
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
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
		var url="delCustomerTryout.do?t="+t;
		     if(confirm("你确定要删除该数据吗？")==true)
		     {
		         $.post(url,{
		           id:id
		        },function(data)
		        {
		            if(data==1)
		             {
		                 alert("删除成功");
		                 window.location.href="getpageCustomerTryout.do?t="+t;
		             }else
		             {
		             alert("删除失败")
		             }
		        }
		                 );
		     }
		}
		
		//更多功能菜单选项
		function morefunction(id)
		{	
			//添加跟进记录	
			 $("#addfollowup").attr('href', "followup.jsp?customerId="+id);	 
			 //查看跟进记录
			 $("#seefollowup").attr('href', "getpageIntentFollowUp.do?customerId="+id);
			 //增加交接记录
			 $("#addcustomerMove").attr('href', "customerMove.jsp?customerId="+id);
			  //查看交接记录
			 $("#seecustomerMove").attr('href', "getpageCustomerMove.do?customerId="+id);
			 showDiv('functionDiv','');
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
										&nbsp;供应商记录查询
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
									
										<TD width="13%" height=30 class=category>
											编号
										</TD>
										
										<TD width="12%" class=category>
											客户姓名
										</TD>
										<TD width="15%" class=category>
											试用服务器IP：
										</TD>
										<TD width="10%" class=category>
											带宽
										</TD>
										<TD width="12%" class=category>
											业务负责人
										</TD>
										<TD width="18%" class=category>
											是否购买
										</TD>
										<TD width="8%" class=category>
											修改
										</TD>										
										<TD width="5%" class=category>
											删除
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
													${data.ip}
												</TD>
												<TD align=middle>
													${data.bandwidth}
												</TD>
												<TD align=middle>
													${data.customer.employee.name}
													</TD>
													<TD align=middle>
													${data.isPurchase}
												</TD>
												<TD align=middle>
													<a
														href="getCustomerTryout.do?id=${data.id}"
														target=right><IMG style="CURSOR: hand" onclick=""
															hspace=2 src="<%=request.getContextPath()%>/images/res.gif" align=absMiddle border=0>
													</a>
												</TD>					
												<TD align=middle>
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath()%>/img/del.gif" width="20px" height="20px" border=0></a>
												</TD>												
											</TR>
											</c:forEach>				
											<TR>
											<td colspan="9"></td>
											</tr>
									<!--循环结束-->
								</TBODY>
							</TABLE>
							<p:pages url="getpageCustomer.do"/>
						</FORM>
						<!--endprint-->
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
<!--更多功能层 -->		
	</BODY>
</HTML>
