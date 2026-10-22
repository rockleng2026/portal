<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="images/date2.js" charset="utf-8"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
<title>客户信息</title>
<script type="text/javascript">

                function data(){
                //var date = new Date().toLocaleDateString();   
               // alert(date);             
               //date= date.replace("年","-");
               // date= date.replace("月","-");
                // date= date.replace("日","");        
                //$("#date").attr("value",date); 
                var now = new Date(); 
				var nowStr = now.format("yyyy-MM-dd hh:mm:ss"); 
				$("#date").attr("value",nowStr); 
                }
                //setInterval("date.innerText=new Date().toLocaleString()+'日一二三四五六'.charAt(new Date());");
Date.prototype.format = function(format){ 
var o = { 
"M+" : this.getMonth()+1, //month 
"d+" : this.getDate(), //day 
"h+" : this.getHours(), //hour 
"m+" : this.getMinutes(), //minute 
"s+" : this.getSeconds(), //second 
"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
"S" : this.getMilliseconds() //millisecond 
} 

if(/(y+)/.test(format)) { 
format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
} 

for(var k in o) { 
if(new RegExp("("+ k +")").test(format)) { 
format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
} 
} 
return format; 
}

                
                </script>
</head>
<body onload="data()">
			<FORM name="customerform" action="
			<c:if test="${data.id!=null}">
			updateIntentFollowUp.do
			</c:if>
			<c:if test="${data.id==null}">
			addIntentFollowUp.do
			</c:if>
			" method="post">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
				border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background=images/r_0.gif>
							<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
								<TBODY>
									<TR>
										<TD>
											&nbsp;添加客户资料(带*号的为必填项)
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
							<input type="hidden" name="customer.customerId" id="customer.customerId"  value="${param.customerId}">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="25%" height=30 align=right>
											跟进客户日期：
										</TD>
										<TD width="75%" class=category>
											<input type="hidden" name="customerId" id="customerId" value="${param.customerId}"/>
											<c:if test="${data.id!=null}">
											<input type="hidden" name="cid" id="cid" value="<%=request.getParameter("id")%>"/>
											</c:if>
											<INPUT style="WIDTH: 200px" name="date" id="date" onfocus=" WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${data.date}">
										</TD>
									</TR>																	
									<TR>
									<TD width="25%" height=30 align=right>
											跟进内容：
										</TD>
										<TD width="75%" class=category>
											
											<FCK:editor width="700px;"   inputName="detail" instanceName="detail" height="300px;">
														<jsp:attribute name="value">${data.detail}</jsp:attribute>
											</FCK:editor> 
											&nbsp;
											<FONT color=#ff0000 id="detail1">*</FONT>
										</TD>
									</TR>	
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT class=button type=submit value="确认添加 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 "><div id="tm"></div>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT type=hidden value=ok name=hid1>
											<INPUT type=hidden value=58 name=id>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
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
		</FORM>
</body>
</html>