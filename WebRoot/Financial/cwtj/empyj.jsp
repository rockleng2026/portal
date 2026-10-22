<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Iterator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工业绩</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<STYLE>
BODY {
	BACKGROUND-COLOR: #fefefe;
}
.tdfirst {
	background:#f6f6f6;
	border-bottom:#CCC double 1px;
	border-left:#bfbfbf double 1px;
	border-top:#bfbfbf double 1px;
	font-size:12px;
	text-align:center;
	line-height:30px;
}
.tdlast {
	border-bottom:#CCC double 1px;
	border-left:#bfbfbf double 1px;
	font-size:12px;
	line-height:30px;
	text-align:center;
}
.tda {
	text-decoration:none;
	color:#000;
	cursor:pointer;
}
#xuanl {
	width:100px;
	height:25px;
	margin-top:4px;
	margin-left:15px;
	background:url(img/xuanxkimg.jpg);
	background-repeat:no-repeat;
	font-size:12px;
	line-height:24px;
	text-align:center;
	float:left;
	cursor:pointer;
}
#xuanr {
	width:100px;
	height:25px;
	margin-top:4px;
	margin-left:15px;
	font-size:12px;
	line-height:24px;
	text-align:center;
	float:left;
	cursor:pointer;
}
#cdl{}
#cdje{ display:none;}

</STYLE>
<script>
 function shuliang(){ 
   document.getElementById("cdl").style.display="Block"
   document.getElementById("cdje").style.display="none"
   document.getElementById("xuanl").style.background="url(<%=request.getContextPath()%>/img/xuanxkimg.jpg)"
   document.getElementById("xuanr").style.background="none"
   }
 function jine(){ 
   document.getElementById("cdje").style.display="Block"
   document.getElementById("cdl").style.display="none"
   document.getElementById("xuanl").style.background="none"
   document.getElementById("xuanr").style.background="url(<%=request.getContextPath()%>/img/xuanxkimg.jpg)"
   }
   
   function getNowTime(){
     var now = new Date();
     document.getElementById("showTime").value=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
     document.getElementById("showTime").value+=" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
   }
   window.setInterval("getNowTime()",1000);
   
   
    function getNowTime2(){
     var now = new Date();
     document.getElementById("showTime2").value=now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
     document.getElementById("showTime2").value+=" "+now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
   }
   window.setInterval("getNowTime2()",1000);
</SCRIPT>
</script>


  </head>
  <body leftmargin="0" topmargin="0" rightmargin="0">
<div style=" width:100%; height:33px; background:url(<%=request.getContextPath()%>/img/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(<%=request.getContextPath()%>/img/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">员工业绩：</div>
</div>
<div style=" width:100%; height:30px; border:#CCC double 1px; margin-top:8px;background:url(<%=request.getContextPath()%>/img/xuanxkbg.jpg); background-repeat:repeat-x;">
  <div id="xuanl" onclick="shuliang()">成单量</div>
  <div id="xuanr" onclick="jine()">成单金额量</div>
</div>
<div id="cdl">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="15%" class="tdfirst">员工</td>
      <td width="15%" class="tdfirst">本月</td>
      <td width="15%" class="tdfirst">上月</td>
      <td width="15%" class="tdfirst">最近6个月</td>
      <td width="25%" class="tdfirst">总计</td>
      <td width="15%" class="tdfirst">操作</td>
    </tr>
    
    <%
			Map map = (Map)request.getAttribute("listmap");
			
	%>
	<%
	  for(Iterator it = map.keySet().iterator(); it.hasNext();){
	     String empname = (String)it.next();
		 String[] tt2 = (String[])map.get(empname); 
	%>
	<tr>
	<td width="15%" class="tdfirst"><c:out value="<%=tt2[1]==null?'-':tt2[1] %>" /></td>
	<td width="15%" class="tdfirst"><c:out value="<%=tt2[2]==null?'-':tt2[2] %>" /></td>
	<td width="15%" class="tdfirst"><c:out value="<%=tt2[3]==null?'-':tt2[3] %>" /></td>
	<td width="15%" class="tdfirst"><c:out value="<%=tt2[4]==null?'-':tt2[4] %>" /></td>
	<td width="15%" class="tdfirst"><c:out value="<%=tt2[5]==null?'-':tt2[5] %>" /></td>
	<td width="15%" class="tdfirst">
	 <a href="<%=request.getContextPath() %>/showCdlfxsaleOrder.do?empid=<%=tt2[0] %>" class="tda">查看详情</a>
	</td>
    </tr>
	<%} %>
    <td colspan="6" class="tdfirst">当前时间:<input type="text" id="showTime" readonly="true" style="border:thin;"/></td>
  </table>
</div>



<div id="cdje">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="15%" class="tdfirst">员工</td>
      <td width="15%" class="tdfirst">本月</td>
      <td width="15%" class="tdfirst">上月</td>
      <td width="15%" class="tdfirst">最近6个月</td>
      <td width="25%" class="tdfirst">总计</td>
      <td width="15%" class="tdfirst">操作</td>
    </tr>
    <%
      Map moneymap = (Map)request.getAttribute("moneymap");
      for(Iterator it = moneymap.keySet().iterator(); it.hasNext();){
         String name = (String)it.next();
         String[] data = (String[])moneymap.get(name);
     %>
    <tr>
      <td class="tdlast"><c:out value="<%=data[1]==null?'-':data[1]%>"/></td>
      <td class="tdlast"><c:out value="<%=data[2]==null?'-':data[2]+0%>"/></td>
      <td class="tdlast"><c:out value="<%=data[3]==null?'-':data[3]+0%>"/></td>
      <td class="tdlast"><c:out value="<%=data[4]==null?'-':data[4]+0%>"/></td>
      <td class="tdlast"><c:out value="<%=data[5]==null?'-':data[5]+0%>"/></td>
      <td class="tdlast"><a href="<%=request.getContextPath() %>/showCdlfxsaleOrder.do?empid=<%=data[0] %>" class="tda">查看详情</a></td>
    </tr>
    <%} %>
      <td colspan="6" class="tdfirst">当前时间:<input type="text" id="showTime2" readonly="true" style="border:thin;"/></td>
  </table>
</div>
</body>
</html>
