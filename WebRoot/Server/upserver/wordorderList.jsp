<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ page import="com.fuao.fajxc.vo.UpServer,com.fuao.fajxc.vo.Product,java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>工单信息</title>
		<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/interface/e.js'></script>
    	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
   		<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.3.2.min.js" ></script>
		
		<style type="text/css">
			#div1{width:250px;height:30px; border:1px solid #C60; position:relative;}
			ul{ list-style:none; background-color:#D7FFEE; margin:0; padding:0; position:absolute;top:30px;left:5px; border:1px solid #C60;width:250px; display:none;}
			#div1 p{ float:right;font-size:12px; width:40px; cursor:pointer;}
		</style>
		
		<style>
	     .black_overlay{  display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.8;  opacity:.80;  filter: alpha(opacity=30);  }  
	     .white_content {  display: none;  position: absolute;  top: 15%;  left: 25%;  width: 50%;  height: 70%;  padding: 16px;  border: 1px solid orange;  background-color: #ADFEDC;  z-index:1002;  overflow: auto;  }  
	    </style>
		
		
		<style type="text/css">
		 .hidden{display:none;}
		 #smallLay{width:300px; height:200px;padding:4px 10px 10px;background-color:#FFFFFF;border:1px solid #05549d;color:#333333;line-height:24px;text-align:left;-webkit-box-shadow:5px 2px 6px #000;-moz-box-shadow:3px 3px 6px #555;}
	    </style>

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
	
	
	填写运维单
	<!-- 遮罩层  -->
<div style="position:absolute;display:none; left:0px; top:0px;" id="tranDiv">
<div style="position:absolute;left:0px; top:0px; width:100%; height:100%;background-color:#000000;filter:alpha(Opacity=30)" id="tranDivBack"> </div> 
<div align='center'style='position:absolute;left:0px; top:0px; width:100%; height:100%; background-color:#e5edf5;background-image:url(images/bestnetqywimg/tccbg.gif);'  id='infoDiv'></div> 
</div> 



<!--层遮罩部分结束  addPurchaseOrder.do-->
	<!-- onsubmit="return checkForms()" -->
		<FORM name=form1 action="" method="post">
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
4						 
						 <TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="13%" height=30 class=category>
											编号
										</TD>
										<TD width="10%" class=category>
											客户
										</TD>
										<TD width="8%" class=category>
											客户类型
										</TD>
										<TD width="10%" class=category>
											上架单号
										</TD>
										<TD width="6%" class=category>
											问题类型
										</TD>
										<td width="10%" class=category>
										          状态
										</td>
										<td>
										  操作
										</td>
									</TR>


									<!--循环-->
									<c:forEach items="${pages.pageList}" var="workorder" >
											<TR>
												<TD align=middle>
												  <input type="hidden" id="opid" value=""/>
												  ${workorder.id}
												</TD>
												<TD align=middle>
												  ${workorder.saleorder.customer.customerName }
												</TD>
												<TD align=middle>
												  ${workorder.saleorder.customer.customerType}
												</TD>
												<TD align=middle>
												  ${workorder.upserver.upNo}
												</TD>
												<TD align=middle>
												  ${workorder.problemType }
												</TD>
												<TD align=middle>
											      <c:if test="${workorder.status==0}">
											                      未处理
											        <input type="button" id="cl" value="处理"/>
											      </c:if>
											      <c:if test="${workorder.status==1}">
											                      处理中
											      </c:if>
											      <c:if test="${workorder.status==2}">
											                      处理完成
											      </c:if>
												</TD>
												<td>
												<c:if test="${workorder.status==1}">
												    <input type="button" value="发往运维部" onclick=""/>
												</c:if>   
												</td>
											</TR>
										</c:forEach>
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
					<tr>
					  <td id="page" colspan="11"><p:pages url="workorderlistUpserver.do?funid=14" /></td>
					</tr>
				</TBODY>
				<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
			</TABLE>
</FORM>

   
	</BODY>
</HTML>
