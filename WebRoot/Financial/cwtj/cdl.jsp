<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>全体成单量</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
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
#qtshul {
	width:100px;
	height:25px;
	margin-top:4px;
	margin-left:15px;
	background:url(<%=request.getContextPath()%>/img/xuanxkimg.jpg);
	font-size:12px;
	line-height:24px;
	text-align:center;
	float:left;
	cursor:pointer;
}
#qtjine {
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
#qtsl{}
#qtje{ display:none;}

</STYLE>
<script>
 function qtshuliang()
 { document.getElementById("qtsl").style.display="Block"
   document.getElementById("qtje").style.display="none"
   document.getElementById("qtshul").style.background="url(<%=request.getContextPath()%>/img/xuanxkimg.jpg)"
   document.getElementById("qtjine").style.background="none"
   }
 function qtjine()
 { document.getElementById("qtje").style.display="Block"
   document.getElementById("qtsl").style.display="none"
   document.getElementById("qtshul").style.background="none"
   document.getElementById("qtjine").style.background="url(<%=request.getContextPath()%>/img/xuanxkimg.jpg)"
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
   window.setInterval("getNowTime2()",1000);  //一秒钟执行一次getNowTime()方法
</script>
<body leftmargin="0" topmargin="0" rightmargin="0">
<div style=" width:100%; height:33px; background:url(<%=request.getContextPath()%>/img/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(<%=request.getContextPath()%>/img/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">全体成单量：</div>
</div>
<div style=" width:100%; height:30px; border:#CCC double 1px; margin-top:8px;background:url(<%=request.getContextPath()%>/img/xuanxkbg.jpg); background-repeat:repeat-x;">
  <div id="qtshul" onclick="qtshuliang()">数量</div>
  <div id="qtjine" onclick="qtjine()">金额</div>
</div>
<div id="qtsl">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10%" class="tdfirst">月份</td>
      <td width="10%" class="tdfirst">月付</td>
      <td width="10%" class="tdfirst">季付</td>
      <td width="10%" class="tdfirst">半年付</td>
      <td width="10%" class="tdfirst">年付</td>
      <td width="10%" class="tdfirst">总计</td>
    </tr>
    <%
      List list = (List)request.getAttribute("li");
      for(int i=0;i<list.size();i++){
        Object[] obj = (Object[])list.get(i);
     %>
    <tr>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0]%>"/>月</td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj[5]==null?0:obj[5]%>"/></td>
    </tr>
    <%} %>
    
    
    <%
         List beforelist = (List)request.getAttribute("before");
         for(int a=0;a<beforelist.size();a++){
           Object[] obj2 = (Object[])beforelist.get(a);
       %>
     <tr>
      <td class="tdlast">以前</td>
      <td class="tdlast"><c:out value="<%=obj2[0]==null?0:obj2[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[1]==null?0:obj2[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[2]==null?0:obj2[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[3]==null?0:obj2[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[4]==null?0:obj2[4] %>"/></td>
      
    </tr>
    <%break;} %>
    
    
     <%
       List tlist = (List)request.getAttribute("totallist");
        for(int i=0;i<tlist.size();i++){
           Object[] t = (Object[])tlist.get(i);
      %>
     <tr>
      <td class="tdlast">总计</td>
      <td class="tdlast"><c:out value="<%=t[0]==null?0:t[0]%>"/></td>
      <td class="tdlast"><c:out value="<%=t[1]==null?0:t[1]%>"/></td>
      <td class="tdlast"><c:out value="<%=t[2]==null?0:t[2]%>"/></td>
      <td class="tdlast"><c:out value="<%=t[3]==null?0:t[3]%>"/></td>
      <td class="tdlast"><c:out value="<%=t[4]==null?0:t[4]%>"/></td>  
    </tr>
    <%break;}%>
    
    
    <tr>
      <td colspan="6" class="tdfirst">当前日期:<input type="text" id="showTime" style="border: thin;" readonly="true"/></td>
    </tr>
  </table>
</div>



<div id="qtje">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10%" class="tdfirst">月份</td>
      <td width="10%" class="tdfirst">月付</td>
      <td width="10%" class="tdfirst">季付</td>
      <td width="10%" class="tdfirst">半年付</td>
      <td width="10%" class="tdfirst">年付</td>
      <td width="10%" class="tdfirst">总计</td>
    </tr>
    
    <%
      List mlist = (List)request.getAttribute("li2");
      for(int i=0;i<mlist.size();i++){
         Object[] obj2 = (Object[])mlist.get(i);
     %>
    <tr>
      <td width="10%" class="tdfirst"><c:out value="<%=obj2[0] %>"/>月</td>
      <td class="tdlast"><c:out value="<%=obj2[1]==null?0:obj2[1]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[2]==null?0:obj2[2]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[3]==null?0:obj2[3]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[4]==null?0:obj2[4]%>"/></td>
      <td class="tdlast"><c:out value="<%=obj2[5]==null?0:obj2[5]%>"/></td>
    </tr>
    <%} %>
    
    
       <%
        List mlist2 = (List)request.getAttribute("beforem");
        for(int a=0;a<mlist2.size();a++){
          Object[] o = (Object[])mlist2.get(a);
       %>
     <tr>
      <td class="tdlast">以前</td>
      
      <td class="tdlast"><c:out value="<%=o[0]==null?0:o[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=o[1]==null?0:o[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=o[2]==null?0:o[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=o[3]==null?0:o[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=o[4]==null?0:o[4] %>"/></td>
     
    </tr>
    
      <% 
      break;
      } %>
    
    
    
     <%
        List totalmoney = (List)request.getAttribute("totalmoney");
        for(int i=0;i<totalmoney.size();i++){
          Object[] obj = (Object[])totalmoney.get(i);
       %>
     <tr>
      <td class="tdlast">总计</td>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
      
    </tr>
    <%break;}%>
    
    
    <tr>
      <td colspan="6" class="tdfirst">当前日期:<input type="text" id="showTime2" readonly="true" style="border:thin;"/></td>
    </tr>
  </table>
</div>
</body>
</html>
