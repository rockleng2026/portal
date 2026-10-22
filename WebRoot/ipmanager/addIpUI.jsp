<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%@ page import="java.text.*,java.util.Calendar,com.fuao.fajxc.util.Cookies" %>
<%@page import="com.fuao.fajxc.vo.IPConfiguration"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
	<%@ taglib uri="/struts-tags" prefix="s" %>
	
	<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/editTable.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript">
		   function changedept(){
		       var dept=$("#de").val();
		       $("#deptid").val(dept);
		   }
		   
		   function changedept2(){
		       var proper=$("#pid").val();
		       $("#properid").val(proper);
		   }
		 
		   function onchangeSelectname()
		   {
		   	   var ipcaddress = $("#ipcaddress").val();
		   	   if(ipcaddress =="")
		   	   {
		   	   	var a = "<font style='color:red;font-size:12px;'>IP地址不能为空</font>";
		   	   	$("#ipconfig4").html(a);
		   	   	$("#ccc").val();
		   	   	return false;
		   	   }
		   	   var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
		   	   if(!exp.test(ipcaddress))
		   	   {
		   	   	   $("#ipconfig4").html("<font style='color:red;font-size:12px;'>请输入正确的IP地址</font>");
		   	   	   $("#ipcaddress").focus();
		   	   	  return false;
		   	   }	
		   	   $.ajax({
		   	   	  type:"POST",
		   	   	  url:"selectNamemanager.do",
		   	   	  data:{
				  		"address":ipcaddress
				  },
		   	   	  success:function(data){
		   	   	  	if(data == "1")
		   	   	  	{
		   	   	  		var str = "<font style='font-size: 12px;color: red;'><img src='<%=request.getContextPath()%>/images/b.png'>(Ip不可用,重复Ip)</font>";
		   	   	  		$("#ipconfig4").html(str);
		   	   	  		$("#ipcaddress").val("");
		   	   	  	}
		   	   	  	if(data == "2")
		   	   	  	{
		   	   	  		var str = "<font style='font-size: 12px;color: blue;'><img src='<%=request.getContextPath()%>/images/a.png'>(IP可用)</font>";
		   	   	  		$("#ipconfig4").html(str);
		   	   	  	}
		   	   	  }
		   	   });
		   }
		   function onClicksubmit(url)
		   {	
		   	  var ipcaddress = $("#ipcaddress").val();
		   	  var ipcname = $("#ipcname").val();
		   	  var ipcarrier = $("#ipcarrier").val();
		   	
		   	  var propertyid = $("#pid").val();
		   	  var depotid = $("#de").val();
	          
	          if(ipcaddress != "")
	          {
	          	$("#ipconfig4").hide();
	          }
		   	  if(ipcname != "")
		   	  {
		   	  	$("#ipcname1").hide();
		   	  }
		   	  if(ipcarrier != "")
		   	  {
		   	  	$("#ipconfig1").hide();
		   	  }
		   	  if(propertyid != "-1")
		   	  {
		   	  	$("#ipconfig2").hide();
		   	  }
		   	  if(depotid !="-1")
		   	  {
		   	  	$("#ipconfig3").hide();
		   	  }
		   	  
			  if(ipcaddress =="")
		   	  {
		   	  	var a = "<font style='color:red;font-size:12px;'>IP地址不能为空</font>";
		   	   	$("#ipconfig4").html(a);
		   	  	$("#ipcaddress").focus();
		   	  	return false;
		   	  }
		   	  if(ipcname == "")
		   	  {
		   	  	$("#ipcname1").html("IP名称不能为空");
		   	  	return false;
		   	  }
		   	  if(ipcarrier =="")
		   	  {
		   	  	$("#ipconfig1").html("运营商不能为空");
		   	  	$("#ipcarrier").focus();
		   	  	return false;
		   	  }
		   	  if(propertyid == "-1")
		   	  {
		   	  	$("#ipconfig2").html("商品不能为空");
		   	  	return false;
		   	  }
		      if(depotid == "-1")
		      {
		      	$("#ipconfig3").html("仓库不能为空");
		      	return false;
		      }
		     
		   	  
		   		var str = $("#str3").val();
		   		if(str == "aaaa"){
		   			$("#form1").attr("action","addIpconfigsmanager.do");
		   			$("#form1").submit();
		   	  		return true;
		   		}else{
		   			$("#form1").attr("action",url);
		   			$("#form1").submit();
		   	  		return true;
		   		}
		   		return true;
		   }
		   
		   function onfocusaddress1()
		   {
		   	
		   }
		   
		   function onfocusaddress()
		   {
		   	 var address1 = $("#ipcaddress").val();
		   	  var minnum = $("#minnum").val();
		   	  var maxnum = $("#maxnum").val();
		   	  
		   	  if(address1 =="")
		   	  {
		   	  	$("#ipconfig5").html("前三位不能为空");
		   	  	$("#ipcaddress").focus();
		   	  	return false;
		   	  }
		   	  if(minnum =="")
		   	  {
		   	  	$("#ipconfig5").html("前一位不能为空");
		   	  	$("#minnum").focus();
		   	  	return false;
		   	  }
		   	  if(maxnum =="")
		   	  {
		   	  	$("#ipconfig5").html("后一位不能为空");
		   	  	$("#maxnum").focus();
		   	  	return false;
		   	  }
		   	  if(parseInt(minnum) > parseInt(maxnum))
		   	  {
		   	  	$("#ipconfig5").html("前一位不能大于后一位");
		   	  	$("#minnum").focus();
		   	  	return false;
		   	  }
		   }
		   
		   
		   function bluraddress()
		   {
		   	  var address1 = $("#ipcaddress").val();
		   	  var minnum = $("#minnum").val();
		   	  var maxnum = $("#maxnum").val();
		   	  
		   	  
		   	  if(address1 =="")
		   	  {
		   	  	$("#ipconfig5").html("前三位不能为空");
		   	  	$("#ipcaddress").focus();
		   	  	return false;
		   	  }
		   	  if(minnum =="")
		   	  {
		   	  	$("#ipconfig5").html("前一位不能为空");
		   	  	$("#minnum").focus();
		   	  	return false;
		   	  }
		   	  if(maxnum =="")
		   	  {
		   	  	$("#ipconfig5").html("后一位不能为空");
		   	  	$("#maxnum").focus();
		   	  	return false;
		   	  }
		   	  if(parseInt(minnum) > parseInt(maxnum))
		   	  {
		   	  	$("#ipconfig5").html("前一位不能大于后一位");
		   	  	$("#minnum").focus();
		   	  	return false;
		   	  }
              
              
              var str = address1+"."+minnum;
              var str1 = address1 +"."+maxnum;
              var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
		   	   if(!exp.test(str))
		   	   {
		   	   	  $("#ipconfig4").html("请输入正确的IP号");
		   	   	  $("#ipcaddress").focus();
		   	   	  return false;
		   	   }
		   	   if(!exp.test(str1))
		   	   {
		   	   	  $("#ipconfig4").html("请输入正确的IP号");
		   	   	  $("#maxnum").val("");
		   	   	  return false;
		   	   }
		   	 
		   	  $.ajax({
		   	  	type:"POST",
		   	  	url:"selectByaddressmanager.do",
		   	  	data:{
		   	  		"address1":address1,
		   	  		"minnum":minnum,
		   	  		"maxnum":maxnum
		   	  	},
		   	  	success:function(data){
		   	  	  $("#ipconfig4").empty();
		   	  		if(data != null)
		   	  		{
		   	  			$("#ipconfig4").html(data);
		   	  			$("#minnum").focus();
		   	  		}
		   	  		if(data =="1")
		   	  		{
		   	  			var a = "<font style='font-size: 12px;color: blue;'>(Ip可用)</font>";
		   	  			$("#ipconfig4").html(a);
		   	  		}
		   	  	}
		   	  });
		   }
		   function coblurupdate()
		   {
			   var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
				var ipcaddress = $("#ipcaddress").val();
				if(ipcaddress == null)
				{
					$("#ipconfig4").html("IP不能为空");
					$("#ipcaddress").val('');
					return false;
				}
				if(!exp.test(ipcaddress))
				{
					$("#ipconfig4").html("请输入正确的IP");
					$("#ipcaddress").val('');
					return false;
				}
		   }
		   
		   
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
		<FORM name=form1 action="" method="post" id="form1" onsubmit="">
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
											<c:if test="${ipconfig==null}">
												&nbsp;添加价格调整记录(带*号的为必填项)&nbsp;&nbsp;&nbsp;&nbsp;<a href="addUI1manager.do?str=aaaa">批量添加</a>
											</c:if>
											<c:if test="${ipconfig!=null}">
												&nbsp;修改价格调整记录(带*号的为必填项)
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
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD></TD>
						<TD>
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border="1" >
								<TBODY>
								<TR>
										<TD width="25%" height=30 align=right>
											IP地址<font color="red">*</font>:
										</TD>
										 <TD width="75%" class=category>
											<c:if test="${str1 == '1'}">
												<input type="text" id="ipcaddress" onblur="onchangeSelectname()" name="configuration.ipcaddress" value="${ipconfig.ipcaddress}"/>
												
											</c:if>
											<c:if test="${str2 == '2'}">
												<input type="text" id="ipcaddress" onblur="coblurupdate();" name="configuration.ipcaddress" value="${ipconfig.ipcaddress}"/>
											</c:if>
											<c:if test="${str=='aaaa'}">
												<input type="text" id="ipcaddress"  name="configuration.ipcaddress" value="${ipconfig.ipcaddress}"/>
												←前三位(例：192.168.0),后一位(0-255)→<INPUT type="text" size="3" id="minnum" name="minnum"/>~~<input type="text" id="maxnum" name="maxnum" size="3" onblur="bluraddress()" />
											</c:if>
											<font id="ipconfig4" ></font>
											<font id="ipconfig5"></font>
											&nbsp;&nbsp;<font>正确的IP地址规范(192.168.0.1)</font>
											<div id="address"></div>
											<div id="ipaddress"></div>
											
											
										 </TD>
									</TR>
									<TR>
										<TD width="25%" height=30 align=right>
											IP名称：
										</TD>
										<TD width="75%" class=category>
										<c:if test="${str != 'aaaa'}">
									  		<input type="text" name="configuration.ipcname" id="ipcname"  onfocus="onfocusaddress1();" value="${ipconfig.ipcname}" >
									  		</c:if>
									  	<c:if test="${str == 'aaaa'}">
									  		<input type="text" name="configuration.ipcname" id="ipcname" onfocus=""  value="${ipconfig.ipcname}" />
									  	</c:if>
									  	
									  	<font id="ipcname1" style="color: red;font-size: 12px;"></font>
											</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											运营商<font color="red">*</font>:
										</TD>
										<TD width="75%" class=category>
											<input type="text" name="configuration.ipcarrier" id="ipcarrier" value="${ipconfig.ipcarrier}">
<!--											<input readonly="readonly" id="modelId" type="hidden" value="${oneReg.model.model }"/>-->
										<font id="ipconfig1" style="color: red;font-size: 12px;"></font>
										&nbsp;&nbsp;<font>请手动填写</font>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
										      商品名称<font color="red">*</font>：
										</TD>
										<TD class=category>
											<SELECT id="pid"  onchange="changedept2()" name="configuration.Tproperty.id" >
									    		  
									    		    <% IPConfiguration ipconfig1=(IPConfiguration)request.getAttribute("ipconfig"); %>
									    		    <% if(ipconfig1!=null){ %>
									    		       <option value="<%=ipconfig1.getTproperty().getId() %>"><%=ipconfig1.getTproperty().getName() %></option>
									    		    <%} if(ipconfig1==null){%>
									    		       <option value="-1">请选择IP商品</option>
									    		    <%}%>
									    		    <c:forEach items="${listproperty}" var="property">
											  			<option value="${property.id}">${property.name}</option>
											  		</c:forEach>
											 </SELECT>
											 <font id="ipconfig2" style="color: red;font-size: 12px;"></font>
											 &nbsp;&nbsp;<font>请手动选择下拉IP这一项</font>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
										      仓库<font color="red">*</font>：
										</TD>
										<TD class=category>
											  	<SELECT id="de"  onchange="changedept()">
	  												<% IPConfiguration ipconfig2=(IPConfiguration)request.getAttribute("ipconfig"); %>
									    		    <% if(ipconfig2!=null){ %>
									    		       <option value="<%=ipconfig2.getTdepot().getId()%>"><%=ipconfig2.getTdepot().getName()%></option>
									    		    <%} if(ipconfig2==null){%>
									    		       <option value="-1">请选择</option>
									    		    <%}%>
											  		<c:forEach items="${listdepo}" var="depo">
											  		<option value="${depo.id}">${depo.name}</option>
											  		</c:forEach>
											  	</SELECT>
											  	<font id="ipconfig3" style="color: red;font-size: 12px;"></font>
										</TD>
									</TR>
									
									
									<input type="hidden" id="str3" name="str3" value="${str}"/>
									<input type="hidden" id="properid" name="properid" value=""/>
									<input type="hidden" id="deptid" name="deptid" value=""/>
								
									<input type="hidden" id="ipcid" name="ipcid" value="${ipconfig.ipcId}"/>
									
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
										<% IPConfiguration ipconfig3=(IPConfiguration)request.getAttribute("ipconfig"); %>
									    		    <% if(ipconfig3==null){ %>
											<INPUT class="button" type="button" value="确认添加 " onclick="onClicksubmit('addIpmanager.do')">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<%}if(ipconfig3 != null){%>
											<input class="button" type="button" value="确认修改" onclick="onClicksubmit('updateipUImanager.do')"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<%} %>
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
			
		</FORM>
	</BODY>
</HTML>
