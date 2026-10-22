<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
</head>		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>


		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	<BODY>
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
											&nbsp;工单反馈
										</TD>
										<TD align=right>
											&nbsp;<a href="javascript:history.go(-1);">返回</a>
											
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
						</TD>
						<TD>
						<form action="" method="post" id="form1">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="20%" height=30 align=right>
											工单号：
										</TD>
										<TD width="30%" class=category>
										    <input type="hidden" id="pk" value="${wo.id}"/>
										    <input type="hidden" id="upid" value="${wo.upserver.id}"/>
											${wo.workorderNo}
										</TD>
				
										<TD width="20%" height=30 align=right>
											销售单号：
										</TD>
										<TD width="30%" class=category>
											${wo.saleOrders.soNums}
										</TD>
									</TR>
									<tr>
										<td width="20%" height="30" align="right">
											上架单号：
										</td>
										<td  width="30%" class=category>
											${wo.upserver.upNo}
										</td>
										<TD width="20%" height=30 align=right>
										     问题类型：
										</TD>
										<TD width="30%" class=category>
											${wo.problemType}
										</TD>
										
									</tr>
									
									<TR>
										
										<TD width="20%" height=30 align=right>
											故障描述：
										</TD>
										<TD width="30%" class=category>
										   ${wo.problemInfo }
										</TD>
										
										<TD  width="20%" align=right height=30>
											备注：
										</TD>
										<TD>
											${wo.temp}
										</TD>
									</TR>
									<tr>
									  <TD width="20%" height=30 align=right>
											处理状态：
										</TD>
										<TD width="30%" class=category>
										   <c:if test="${wo.status==1}">
										              客服中心处理
										   </c:if>
										   <c:if test="${wo.status==2}">
										              运维组处理
										   </c:if>
										   <c:if test="${wo.status==3}">
										          运维组已接收
										   </c:if>
										   <c:if test="${wo.status==4}">
										          运维组已处理完毕
										   </c:if>
										</TD>
									</tr>
									
									<tr>
									  <td colspan="4" align="center">
									   <c:if test="${wo.status==1 && status==365}">
									        <input type="button" id="kf" onclick="setoperate()" value="转发至运维组"/>
									    </c:if>
									    <c:if test="${wo.status==2 && status==244}">
									               <input type="button" value="接收" onclick="jieshou()"/>
									    </c:if>
									    <c:if test="${wo.status==3 && status==244}">
									       <input type="button" value="通过" onclick="sub()"/>
									    </c:if>
									    <c:if test="${wo.status==4}">
									                       运维组已经处理完毕
									    </c:if>
									    <c:if test="${status==0}">
									                  暂无权限处理
									    </c:if>
									  </td>
									</tr>
									
								</TBODY>
							  </TABLE>
							</form>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
	</BODY>
	<script type="text/javascript">
	  //转发给运维组
   function setoperate(){
     var pk = $("#pk").val();
     var upid = $("#upid").val();
     var problemtype = $("#problemtype").val();
     problemtype = encodeURI(problemtype,"utf-8");
     var probleminfo = $("#probleminfo").val();
     probleminfo = encodeURI(probleminfo,"utf-8");
     
     $.post('<%=request.getContextPath()%>/toOperateUpserver.do',{'pk':pk,'problemtype':problemtype,'probleminfo':probleminfo},function(result){
           alert("工单已转发至运维组!");
           window.location.href="<%=request.getContextPath()%>/getOperateOfUpsUpserver.do?upid="+obj;
     });
     window.location.href="<%=request.getContextPath()%>/selectUpserver.do?funid=193";
   }
   
   function jieshou(){
      var pk = $("#pk").val();
      window.location.href="<%=request.getContextPath()%>/jieshouUpserver.do?cid="+pk;
      alert("接收成功!");
      window.location.href="<%=request.getContextPath()%>/selectUpserver.do?funid=193";
   }
   
   function sub(){
     var pk = $("#pk").val();
     var upid = $("#upid").val();
     window.location.href="<%=request.getContextPath()%>/subUpserver.do?cid="+pk+"&upid="+upid;
     alert("上架成功!");
   }
	</script>
</HTML>
