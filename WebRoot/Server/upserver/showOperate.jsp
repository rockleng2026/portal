<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
				<base target="_self">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		    <script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/interface/e.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
			
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js" charset="GBK"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery-1.3.2.min.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/auditing.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>



		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
  function tolist(){
    window.location.href="<%=request.getContextPath()%>/selectUpserver.do?funid=193";
  }
</script>

</head>	
<% request.setCharacterEncoding("gbk");
	response.setCharacterEncoding("gbk");
%>
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
											&nbsp;运维单详细信息
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
	<!-- form开始 -->		<form action="<%=request.getContextPath() %>/updateYwUpserver.do" method="post" id="form1">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border="1" >
								<TBODY>
									<tr>
										<td width="20%" height="30" align="right">
											编号：
										</td>
										<td width="20%" height="30" align="left"  class=category>
											${operate.id}
										</td>
										<td width="20%" height="30" align="right">
											上架单编号：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											${operate.upserver.upNo}
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											运维单号：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${operate.operateNo}
										</td>
										<td width="20%" height="30" align="right">
											销售订单号：
										</td>
										<td width="30" height="30" align="left"  class=category>
											${operate.saleOrders.soNums}
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											上架员工：
										</td>
										<td width="30" height="30" align="left"  class=category >
											${operate.employee.name}
										</td>
										<td width="20%" height="30" align="right">
											上架时间：
										</td>
										<td width="30" height="30" align="left"  class=category>
											<c:out value="${operate.uptime}"></c:out>
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											下架时间：
										</td>
										<td  width="30%" class=category  >
											<c:out value="${operate.downtime}"></c:out>
										</td>
										<TD width="20%" height=30 align=right>
											所属仓库：
										</TD>
										<TD width="30%" class=category>
											${operate.depot.name}
										</TD>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											商品名称：
										</td>
										<td  width="30%" class=category   class=category >
											${operate.product.property.name}
										</td>

										<td  width="20%"  height=30 align=right >
											IP地址：
										</td>
										<td  width="30%" class=category >
											${operate.ipAddress}
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											机房/房间：
										</td>
										<td  colspan="1" class=category >
											${operate.housesAndRooms}
										</td>
										<td width="20%"  height=30 align=right>
											机柜：
										</td>
										<td  width="30%" class=category >
										   ${operate.jgh}
										</td>
									</tr>

									<TR>
										<TD align=right height=30>
											交换机名称：
										</TD>
										<TD class=category> 
											${operate.jhj}
										</TD>
										
										<TD align=right height=30>
											端口号：
										</TD>
										<TD class=category> 
											${operate.port}
										</TD>
									</TR>     
									    
									<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category> 
											${operate.temp}
										</TD>
										<tr>
										  <td colspan="4" align="center">
										    <input type="button" onclick="tolist()" value="返回上架单列表"/>
										  </td>
										</tr>
									</TR>             
								</TBODY>
							</TABLE>
		<!-- form结束 -->	</form>
						</TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<jsp:include page="/contract/reviewSubmissions.jsp"></jsp:include>
			
  <div id="electhouse" style="position: absolute;left: 500px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;">选择机房/房间</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideelecthouse();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;left:80px;"><input type="button" id="sure" value="确定" onclick="hideelecthouse()"/></div>
   </div>
   </div>
   
   <!-- 显示机柜的层 -->
   <div id="cabinet" style="position: absolute;left: 1000px;top: 110px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;">选择机柜</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hidecabinet();" style="text-decoration: none;">关闭</a></div>
   </div>
   <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     <table id="tab3" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   <div style="width: 200px;height: 13px;background-color: #E8FFF5; z-index: 10; position: absolute;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;left:80px;"><input type="button" id="sure" value="确定" onclick="hidecabinet()"/></div>
   </div>
   </div>
			
	</BODY>
</HTML>
