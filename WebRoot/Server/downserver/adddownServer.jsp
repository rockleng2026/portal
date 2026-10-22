<%@ page language="java" contentType="text/html; charset=GBK"  	pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@ page import="com.fuao.fajxc.vo.DownServer" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<title>增加/修改下架单</title>
		
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" charset="GBK" ></script>
		
		<script type="text/javascript">
		 window.onload = getInfo;
		 function getInfo(){
		 	//alert(111);
		 	var upNo = '${upNo}';
		 	//alert(upNo);
		 	var url = "getServerInfoUpserver.do?tt="+(new Date()).getTime();
		 	$.get(url,{upNo:upNo},function(data){
		 		//alert(data);
		 		//cusname|cuscomp|serverName|serverId|upNo|cus|phone|cardid|cusempname|liip
		 		var str= data.split("#");
		 		$("#cusname").val(str[0]);
		 		$("#cuscomp").val(str[1]);
		 		$("#serverName").val(str[2]);
		 		$("#serverId").val(str[3]);
		 		$("#upNo").val(str[4]);
		 		$("#cus").val(str[5]);
		 		$("#phone").val(str[6]);
		 		$("#cardid").val(str[7]);
		 		$("#cusempname").val(str[8]);
		 		$("#liip").html(str[9]);
		 		$("#serverLocation").val(str[10]);	
		 	});
		 }
		
			function checknull()
			{
				var cuscom=document.getElementById("cuscomp").value;
				if(cuscom==null||cuscom=="")
				{
					alert("单位名称不能为空！");
					return false;
				}
				var serverName=document.getElementById("serverName").value;
				if(serverName==null||serverName=="")
				{
					alert("服务器名称不能为空！");
					return false;
				}
				var serverIp=document.getElementsByName("serverIp");
				var flag = false;
				for(var i=0;i<serverIp.length;i++)
				{
					if(serverIp[i].checked)
					{
						 flag= true;
					}
				}
				if(!flag){
				alert("请选择要下架的IP！");
				return false;
				}
				var aid  = document.getElementById("aid").value;
				if(aid == null || aid == ''){
					alert("下架类型不能为空");
					document.getElementById("aid").focus();
					return false;
				}
				var downTime=document.getElementById("downTime").value;
				if(downTime==null||downTime=="")
				{
					alert("下架日期不能为空！");
					return false;
				}
				return true;
				
			}
			function checkshowsystem(data)
			{
				var aa=data;
				var sysfo=document.getElementById("systemfont");
				if(aa=="其它")
				{
					sysfo.innerHTML="<input id='systemother' name='systemother'/>";
				}else{
					while(sysfo.hasChildNodes())
					{
						sysfo.removeChild(sysfo.firstChild);
					}
				}
			}
		
			function checkbandwidth(data)
			{
				var aa=data;
				var sysfo=document.getElementById("bandfont");
				if(aa=="其它")
				{
					sysfo.innerHTML="<input id='bandother' name='bandother'/>";
					return;
				}
				if(aa=="CDN")
				{
					sysfo.innerHTML="<input id='bandcdn' name='bandcdn' />M";
				}
				else
				{
					while(sysfo.hasChildNodes())
					{
						sysfo.removeChild(sysfo.firstChild);
					}
				}
			}
		function getServer(){
		    var cid = $("#cusname").val();
		    //alert(cid);
		    if(cid == null || cid == ''){
		    	alert("请先选择客户单位");
		    	return false;
		    }
			completemission("showDialogOutbound.do?mark=upserver&cid="+cid+"&funid=200","");
		}
			
		
		</SCRIPT>

		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<%
   Cookies ck = new Cookies();
   String empName =ck.getCookie(request, "employeeName");
   String empId=ck.getCookie(request,"employeeId");
 %>
	<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM name=form1 id=form1 method="post" action=
		<c:if test="${oneDownS==null}">
		  "addDownserver.do"
		</c:if>
		<c:if test="${oneDownS!=null}">
		  "editDownserver.do"
		</c:if>
		onsubmit="return checknull()"
		>
		<c:if test="${oneDownS!=null}">
			<input id="empid" name="employee.id"  type="hidden" value="${oneDownS.employee.id }" />
			<input id="downFlag" name="downFlag" type="hidden" value="${oneDownS.downFlag }"/>
			<input id="delflag" name="delflag" type="hidden" value="${oneDownS.delflag }"/>
			<input id="auditingFlag" name="auditingFlag" type="hidden" value="${oneDownS.auditingFlag }"/>
			<input type="hidden" value="${oneDownS.id }" id="id" name="id">
		</c:if>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed border=0>
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
										  <c:if test="${oneDownS!=null}">
											&nbsp;修改下架单资料(带*号的为必填项)
											</c:if>
											  <c:if test="${oneDownS==null}">
											  &nbsp;新增下架单资料(带*号的为必填项)
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border="1" >
							<input type="hidden" value="0" name="delflag"/>
								<TBODY>
									<tr>
										<td width="20%" height="30" align="right">
											单位名称：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											
											<input id="cuscomp" name="cuscomp" onblur="checkValueByRules('cus','','cusMsg')" value="${oneDownS.customer.customerCompany}" 
											name="customer.customerCompany"
											onclick="completemission('showDialogOutbound.do?mark=custom','')" readonly="readonly">
											   	<input name="customer.customerId" id="cusname" type="hidden" value="${ oneDownS.customer.customerId}"/>
											<label><FONT color=#ff0000 id="cusMsg">*</FONT></label>
										</td>
										<TD width="20%" height=30 align=right>
											服务器名称：
										</TD>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules('serverName','','serverMsg')" style="WIDTH: 200px" id="serverName" name="product.property.name"
											
											onclick="getServer()"
											value="${oneDownS.product.property.name }">
											<input id="serverId" name="product.id" type="hidden" value="${oneDownS.product.id }">
											<input id="upNo" name="upNo" type="hidden" value="${oneDownS.upNo }">
											<FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="serverMsg"></FONT>
										</TD>
									</tr>
									
									<tr>
										<td width="20%" height="30" align="right">
											联系人：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											<input id="cus" name="customer.realName" value="${oneDownS.customer.realName }" readonly="readonly"/>
										</td>
										<td width="20%" height="30" align="right">
											电话：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											<input  id="phone" name="customer.phone" value="${oneDownS.customer.phone }" readonly="readonly"/>
										</td>
									</tr>
									<tr>
										<td width="20%" height="30" align="right">
											证件号码：
										</td>
										<td width="30%" height="30" align="left"  class=category >
											<input id="cardid" name="customer.cardid" value="${oneDownS.customer.cardid }"  readonly="readonly"/>
										</td>
										<td width="20%" height="30" align="right">
											公司负责人：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											<input id="cusempname" name="customer.employee.name" value="${oneDownS.employee.name }"/>
										</td>
									</tr>
									
									<TR>
										<TD width="20%" height=30 align=right>
											下架单号：
										</TD>
										<TD width="30%" class=category>
									       <c:if test="${oneDownS!=null}">
									          <INPUT readonly="readonly" style="WIDTH: 200px" id="downNo" name="downNo" value="${oneDownS.downNo }">
									       </c:if>
									       <c:if test="${oneDownS==null}">
										    	<INPUT readonly="readonly" style="WIDTH: 200px" id="downNo" name="downNo" value="${XJNo }">
											</c:if>
										</TD>
										<td width="20%" height="30" align="right">
											业务类型：
										</td>
										<td width="30%" height="30" align="left"  class=category>
											<select id="businesstype" name="businesstype" >
												<option value="IDC"  <c:if test="${oneDownS.businesstype=='IDC' }">selected="selected"</c:if> >IDC</option>
												<option value="VPS"  <c:if test="${oneDownS.businesstype=='VPS' }">selected="selected"</c:if>>VPS</option>
												<option value="虚拟主机" <c:if test="${oneDownS.businesstype=='虚拟主机' }">selected="selected"</c:if>>虚拟主机</option>
											</select>
										</td>
									</TR>
								
									<tr >
										<td width="20%" height="30" align="right">
											要下架的IP：
										</td>
										<td colspan="3" height="30" align="left"  class=category>
								<font id="liip">  	
								 	<c:if test="${oneDownS!=null}">
								 	 <%
								 	    DownServer ds=(DownServer)request.getAttribute("oneDownS");
								 	 	if(ds.getServerIp()!=null&&!"".equals(ds.getServerIp()))
								 	 	{
								 	    String[] ip=ds.getServerIp().split(",");
										for(int i=0;i<ip.length;i++)
										{
											%>
								<input type="checkbox"   id="serverIp" name="serverIp" value="<%=ip[i] %>" checked="checked"/><%= ip[i]%>&nbsp;&nbsp;
											<%
										}
										}
								 	 %>
											</c:if> 
									</font>
											<font id="iplist"></font>
										</td>
									</tr>
								
									<TR>
										<td width="20%"  height=30 align=right >
											下架原因：
										</td>
										<td width="30%"  class=category  align="left" height="30">
											<textarea   onblur="checkValueByRules('downcause','','downcauseMsg')" id="downcause" name="downcause"  cols="35" rows="3">
												${oneDownS.downcause }
											</textarea>
											<FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="downcauseMsg"></FONT>
										</td>
										<td width="20%"  height=30 align=right >
											配置详情：
										</td>
										<td  width="30%" height="30" align="left"  class=category>
											<textarea cols="40" rows="3" id="configurationinfo" name="configurationinfo" >
												${oneDownS.configurationinfo }
											</textarea>
										</td>
									</TR>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											机房位置：
										</td>
										<td  width="30%" class=category  >
										  		<input id="serverLocation" name="serverLocation" readonly="readonly" value="${oneDownS.serverLocation }"/>
											<font id="foselo"></font>
										</td>
										<TD width="20%" height=30 align=right>
											下架类型：
										</TD>
										<TD width="30%" class=category>
											<s:select onblur="checkValueByRules('aid','','downMsg')" 
											id="aid" name="allType.id" cssClass="category" 
											list="#request.downType" listKey="id" listValue="typeName" 
											value="%{'',#request.oneDownS.allType.id}" headerKey="" headerValue="请选择" >
											</s:select><FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="downMsg"></FONT>
										</TD>
									</tr>
									
									
									<tr>
										<td  width="20%"  height=30 align=right >
											系统显示：
										</td>
										<td  width="30%" class=category   class=category >
											<select id="system" name="system"   onchange="checkshowsystem(this.value)">
												<c:if test="${oneDownS!=null&&oneDownS.system!='windows2003'&&oneDownS.system!='windows2008'
												&&oneDownS.system!='Linux(redhat)'&&oneDownS.system!='Linux(centos)'}">
													<option value="${oneDownS.system}" >${oneDownS.system}</option>
												</c:if>
												<option value="windows2003" <c:if test="${oneDownS.system=='windows2003' }">selected="selected"</c:if>>windows2003</option>
												<option value="windows2008"  <c:if test="${oneDownS.system=='windows2008' }">selected="selected"</c:if>>windows2008</option>
												<option value="Linux(redhat)"  <c:if test="${oneDownS.system=='Linux(redhat)' }">selected="selected"</c:if>>Linux(redhat)</option>
												<option value="Linux(centos)"  <c:if test="${oneDownS.system=='Linux(centos)' }">selected="selected"</c:if>>Linux(centos)</option>
												<option value="Unix"  <c:if test="${oneDownS.system=='Unix' }">selected="selected"</c:if>>Unix</option>
												<option value="其它">其它</option>
											</select>
											<font id="systemfont"></font>
										</td>

										<td  width="20%"  height=30 align=right >
											带宽/流量：
										</td>
										<td  width="30%" class=category >
											<select id="bandwidthflow" name="bandwidthflow" onchange="checkbandwidth(this.value)">
												<c:if test="${oneDownS!=null&&oneDownS.bandwidthflow!='10M独享'&&oneDownS.bandwidthflow!='100M共享'
												&&oneDownS.bandwidthflow!='100M独享'&&oneDownS.bandwidthflow!='1000M独享'}">
													<option value="${oneDownS.bandwidthflow}" >${oneDownS.bandwidthflow}</option>
												</c:if>
												<option value="10M独享" <c:if test="${oneDownS.system=='10M独享' }">selected="selected"</c:if>>10M独享</option>
												<option value="100M共享" <c:if test="${oneDownS.system=='100M共享' }">selected="selected"</c:if>>100M共享</option>
												<option value="100M独享" <c:if test="${oneDownS.system=='100M独享' }">selected="selected"</c:if>>100M独享</option>
												<option value="1000M独享" <c:if test="${oneDownS.system=='1000M独享' }">selected="selected"</c:if>>1000M独享</option>
												<option value="CDN">CDN:</option>
												<option value="其它">其它</option>
											</select>
											<font id="bandfont">
											</font>
										</td>
									</tr>
									
									<tr>
										<td  width="20%"  height=30 align=right >
											财务结算：
										</td>
										<td  colspan="1" class=category ><!-- onblur="checkValueByRules('money','','moneyMsg')" -->
											反退金额：<input    name="returnAmout" id="returnAmout" value="${oneDownS.returnAmout }"/>
											<FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="moneyMsg"></FONT>
										</td>
										<td  colspan="2" class=category ><!--onblur="checkValueByRules('bandcard','','bandcardMsg')"  -->
											结算帐号：<input    name="settlementAccount" id="settlementAccount" value="${oneDownS.settlementAccount }"/>
											<FONT color=#ff0000>*</FONT>
											<FONT color=#ff0000 id="bandcardMsg"></FONT>
										</td>
									</tr>
									
									
									<tr>
										<td width="20%"  height=30 align=right >
											下架日期：
										</td>
										<% String bb=""; %>
										<c:if test="${oneDownS!=null}">
										<c:set var="ttime" value="${oneDownS.dtime}" scope="request"></c:set>
											<%
											java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
											bb=formatter.format(request.getAttribute("ttime"));
											 %>
										</c:if>
										<TD width="30%" class=category>
											<INPUT onblur="checkValueByRules('downTime',['birth'],'downTimeMsg')" style="WIDTH: 120px" id="downTime" name="dtime" value="<%=bb %>"
												onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT> 点击输入框获取时间<FONT color=#ff0000 id="downTimeMsg"></FONT>
										</TD>
										<td width="20%"  height=30 align=right >
											费用结清：
										</td>
										<td  width="30%" height="30" align="left"  class=category>
										<c:if test="${oneDownS!=null}">
											<input type="radio" name="costFlag" value="0" <c:if test="${oneDownS.costFlag==0 }">checked="checked"</c:if>/>已&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="costFlag" value="1" <c:if test="${oneDownS.costFlag==1 }">checked="checked"</c:if>/>否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:if>
										<c:if test="${oneDownS==null}">
											<input type="radio" name="costFlag" value="0" checked="checked">已&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" name="costFlag" value="1">否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:if>
										</td>
									</tr>
									<TR>
										<TD align=right height=30>
											经手人：
										</TD>
										<TD class=category> 
										<c:if test="${empty oneDownS}">
										<input id="emp"  value="<%=empName %>"  >
											<input id="empid" name="employee.id"  type="hidden" value="<%=empId %>" />
										</c:if>
											<c:if test="${not empty oneDownS}">
											<input id="emp" value="${oneDownS.employee.name }"  >
											</c:if>
										</TD>
										
										<TD align=right height=30>
										        备注：
										</TD>
										<TD class=category>
											<textarea rows="3" cols="40" id="description" name="remark">${oneDownS.remark}</textarea>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<c:if test="${oneDownS==null}">
											<INPUT class=button type=submit  value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
											<c:if test="${oneDownS!=null}">
											<input class="button" type="submit" value="确认修改"/>&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											<INPUT class=button type=reset value="重置 ">
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
			<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
		</FORM>
	</BODY>
</HTML>
