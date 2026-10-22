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
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/showDialog.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript">
</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
//弹出采购订单页
var returnvalue="";
//选择采购订单
function purshowWind() {  
              returnvalue= showModalDialog("<%=request.getContextPath() %>/getPurchaseOrder.do?is='is'","","dialogWidth=900px;dialogHeight=600px");
              var array = returnvalue.split(",");	
				$("#purOrderid").attr("value",array[0]);
				$("#purOrderNO").attr("value",array[1]);
				$("#totime").attr("value",array[2]);
				$("#grossmoney").attr("value",array[3]);
				
				var trArray = document.getElementsByName("model");
				var modelArray = new Array();
				for(var i=0;i<trArray.length;i++)
				{
					modelArray[i] = trArray[i].value;
				}
				for(var j=0;j<modelArray.length;j++)
				{
					delTr(j+1);
				}
				
				var purid = $("#purOrderid").val();
				var url = "selectModelPurchaseOrder.do";
				$.post(url,{purid:purid},function(data){

					$("#editTabs").append(data);
				});				
}

		
		function begin(str)
		{
			var paytype = $("#paytype").val()
			$("#missid").val(paytype);
			alert(paytype);
			var tag;
			if(typeof(str)=="string")
		    {
		   	 tag = str;
		    }else
		    {
		 		tag = $("#"+str.id).find("option:selected").text();
		 	}
		 	if(tag == '其他退款' || tag == '客户退款')
		 	{
			 	$("#purs1").hide();
			 	$("#purOrderNO").val("");
			}
			if(tag == '采购退款')
			{
			 	$("#purs1").show();
			}
		}

</script>
<%
   Cookies ck = new Cookies();
   String empName =ck.getCookie(request, "employeeName");
		String empId=ck.getCookie(request,"employeeId");
		
 %>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
	
      
		<FORM name=form1 action="addpay.do" method="post" onsubmit="return addValidators()" enctype="multipart/form-data" >
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
										<c:if test="${pmlShow!=null}">
											&nbsp;修改付款单资料(带*号的为必填项)
										</c:if>
										<c:if test="${pmlShow==null}">
											&nbsp;添加付款单资料(带*号的为必填项)
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
								<input type="hidden" value="${pmlShow.id}" id="id"/>
								<input type="hidden" value="0" name="del"/>
								<input type="hidden" value="" id="missid" name="missid"/>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											付款单号：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${pmlShow!=null}">
									    <INPUT readonly="readonly" style="WIDTH: 200px" id="payNo" name="payNo" value="${pmlShow.payNo }">
									    </c:if>
									    <c:if test="${pmlShow==null}">
											<INPUT readonly="readonly" style="WIDTH: 200px" id="payNo" name="payNo" value="${FKNo }">
											</c:if>										
											</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											审核状态：
										</TD>
										<TD width="75%" class=category>
									    <c:if test="${pmlShow.auditingState=='1' }">
									    <label id="sh">已审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value=${pmlShow.auditingState } > 
									    </c:if>
									    <c:if test="${pmlShow.auditingState=='0'||pmlShow.auditingState==null }">
									    <label id="sh">未审核</label>
									    <input id="auditingState" name="auditingState" type="hidden" value="0" > 
									    
									    </c:if>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款类型：
										</TD>
										<TD width="75%" class=category>
											<SELECT id="paytype" onchange="begin(this);">
												<c:if test="${pmlShow != null}">
													<option value="${pmlShow.missiontype.id}">${pmlShow.missiontype.name}</option>
												</c:if>
												<option value="-1">--请选择付款类型--</option>
												<c:forEach items="${listpayType}" var="paytype">
													<option value="${paytype.id}">${paytype.name}</option>
												</c:forEach>
											</SELECT>
											
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="moneyMsg"></FONT>
										</TD>
									</TR>
									<TR id="purs1">
										<TD width="25%" height=30 align=right>
											采购单号：
										</TD>
										<TD width="75%" class=category>
						
										<INPUT style="WIDTH: 200px" name="purOrderNO" onclick="completemission('getPurchaseOrder.do?is=is','')" id="purOrderNO" value="${pmlShow.purOrder.purOrderNo}"  />
											<INPUT type="hidden" style="WIDTH: 200px" name="purOrderid" id="purOrderid" value="${pmlShow.purOrder.id}"/>
										<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="purMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款金额：
										</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('paymentAmount',['money'],'moneyMsg')" style="WIDTH: 200px" id="paymentAmount" name="paymentAmount" value="${pmlShow.paymentAmount }">
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="moneyMsg"></FONT>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											付款人：
										</TD>
										<TD class=category>
											  <c:if test="${not empty pmlShow}">
											<input id="emp" value="${pmlShow.employee.name}"  readonly="readonly" 	onblur="checkValueByRules('emp','','empMsg')"
										onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="employee.id" type="hidden" value="${pmlShow.employee.id }" />
											   	</c:if>
											   	<c:if test="${empty pmlShow}">
										<input id="emp" value="${pmlShow.employee.name}"  readonly="readonly" 	onblur="checkValueByRules('emp','','empMsg')"
										onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="employee.id" type="hidden" value="<%=empId %>" />
											   	</c:if>
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											付款方式：
										</TD>
										<TD width="75%" class=category>
										<script type="text/javascript">
										$(document).ready(function(){
									         var paymode=$("#payMode").val();
										     $("#defrayMode option[value='"+paymode+"']").attr("selected",true); 
										});
										</script>
										<input type="hidden" value="${pmlShow.defrayMode}" id="payMode">
										<select id="defrayMode" name="defrayMode"  onblur="checkValueByRules('defrayMode','','defrayModeMsg')">
										
											<option value="">请选择支付方式</option>
											<option value="现金支付">现金支付</option>
											<option value="支付宝">支付宝</option>
											<option value="银行转账">银行转账</option>
											<option value="邮政">邮政</option>
											<option value="电汇">电汇</option>
											<option value="支票">支票</option>
											<option value="其他"> 其他</option>
											</select>
											<FONT color=#ff0000>*</FONT><FONT id="defrayModeMsg" color=#ff0000></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款人账号：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('account','','accMsg')" style="WIDTH: 150px" id="account" name="account" value="${pmlShow.account }">
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="accMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款人开户行：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('bankName',['bankName'],'accMsg1')" style="WIDTH: 150px" id="bankName" name="bankName" value="${pmlShow.bankName }">
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="accMsg1"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											收款名称：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('gatheringName',['gatheringName'],'accMsg2')" style="WIDTH: 150px" id="gatheringName" name="gatheringName" value="${pmlShow.gatheringName }">
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="accMsg2"></FONT>
										</TD>
									</TR>
										<TR>
										<TD align=right height=30>
											收款日期：
										</TD>
										<TD class=category>
											<INPUT onblur="checkValueByRules('time',['birth'],'birthMsg')" style="WIDTH: 150px" id="time" name="time" value="${pmlShow.time}"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="birthMsg"></FONT>
										</TD>
										
									</TR>
									<tr>
									<TD align=right height=30>
											录入信息日期：
										</TD>
										<TD class=category>
										<c:if test="${pmlShow.inputTime==null}">
										<%String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());  %>
										<INPUT readonly="readonly" style="WIDTH: 150px" id="inputTime" name="inputTime" value="<%=date %>">
											&nbsp;
										</c:if>
										<c:if test="${pmlShow.inputTime!=null}">
											<INPUT readonly="readonly" style="WIDTH: 150px" id="inputTime" name="inputTime" value="${pmlShow.inputTime }">
											&nbsp;
											</c:if>
										</TD>
										</tr>
										<TR>
										<TD align=right height=30>
											备注：
										</TD>
										<TD class=category>
											<textarea name="remark" cols="50" rows="7" id="remark"></textarea>
											<FONT color=#ff0000>*</FONT> <FONT color=#ff0000 id="accMsg3"></FONT>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<c:if test="${pmlShow==null}">
											<INPUT class=button type=submit value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${pmlShow!=null}">
											<input class="button" type="button" value="确认修改" onclick="editpays('editpay.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
	

								</TBODY>
							</TABLE>
							<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
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
