<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
		
<html>
	<head>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>添加请购单</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/purchasing.js"></script>
				<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
</head>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}   
</STYLE>
		
<script language="javascript">


function href()
{
window.location.href="getRejectioning.do";	
}
</script>
<script type="text/javascript">

</script>
<body>

<FORM  id ="form1" name=form1 action="addsupplier.do" method="post" onsubmit="return addValidators()">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor=#D6E3F7
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
										<c:if test="${applybuy!=null}">
											&nbsp;修改请购单资料(带*号的为必填项)
										</c:if>
										<c:if test="${applybuy==null}">
											&nbsp;添加请购单资料(带*号的为必填项)
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
										<TD align=right height=30>
											请购员工：
										</TD>
										<TD class=category>
											<input id="emp" value="${applybuy.employeeByEmployeeId.name }" onblur="checkValueByRules('emp','','empMsg')" onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="empid" type="hidden" value="${applybuy.employeeByEmployeeId.id}" />
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											备注信息：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 300px" id="remark" name="remark" value="${applybuy.remark}"/>
											&nbsp;
										
										</TD>
									</TR>
									
										<TR>
										<TD align=right height=30>
											请购日期： <input type="hidden" id = "applyBuyid" name="applyBuyid" value="${applybuy.id }"/>
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('date',['birth'],'facsimileMmsg')" style="WIDTH: 150px" id="time" name="time"
												onclick="WdatePicker()" value="${applybuy.time }"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD></TD>
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
		

				<input name="Submit3" type="button" class="btn_02"  onclick="addProElement()" value="添加商品" style=" margin-top:20px;"/>
				<input id="num" name="num" type="hidden"/>
                        <table id="bill" width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CEDBEF" style=" margin-top:5px">

                          <tr id="item1">
                            <td align="center" bgcolor="#DEE7F7" class="font02">商品类型</td>
                            <td align="center" bgcolor="#DEE7F7" class="font02" >商品型号</td>
                            <td align="center" bgcolor="#DEE7F7" class="font02" >数量(单位 /PS)</td>
                          <td colspan="5" align="center" bgcolor="#FFFFFF" class="font02" style="height: 24px"><a href="javascript:CancelTr('pro1')">操作</a></td>
                        </tr>
                        		<%int i=1; %>
									<c:forEach items="${list}" var="data" >
                                         
										<TR id = "pro<%=i %>">
											<TD align=center bgcolor="white">
												<input type="hidden" name="applyBuyInfoID" value="${data.id }"/>
												<input name="types" id="types<%=i %>" type="hidden" value="${data.commodityTpye.id}" />
												<input name="type" id="type<%=i %>" readonly="readonly" type="text" onclick="return showWind('<%=i %>');" value="${data.commodityTpye.typeName}" />
											</TD>
										
											<TD align=center bgcolor="white">
												<input name="models" id="models<%=i %>" type="hidden" value="${data.model.model}"  />
												<input name="model" id="model<%=i %>" readonly="readonly" type="text" value="${data.model.name}" />
											</TD>
											<TD align=center bgcolor="white">
												<input type="text" name="num" value="${data.count }"/>
											</TD>
											<td align=center bgcolor="white"><a href="javascript:del('${data.id }','pro<%=i %>')">删除</a>
											</td>
											<%i++; %>
										</TR>
											
									</c:forEach>
								<TR>
                        </table>
                        <input type="hidden" value="2" name="ItemCount" id="ItemCount">
						<input type="hidden" value="<%=i %>" name="ProCount" id="ProCount">
                      <div style="margin:0px; padding:0px; margin-top:10px;">
                      <c:if test="${applybuy == null}"> 
                      	<input type="button" value="确定" onclick="sub();">
                      </c:if>
                      <c:if test="${applybuy != null}">
                      	<input type="button" value="修改" onclick="update();">
                      </c:if>
                  	</div>  
	</FORM>
	</BODY>
	<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
</HTML>