<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="java.util.List"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>成单量分析</title>
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
#shul {
	width:100px;
	height:25px;
	margin-top:4px;
	margin-left:15px;
	background: url(img/xuanxkimg.jpg);
	background-repeat:no-repeat;
	font-size:12px;
	line-height:24px;
	text-align:center;
	float:left;
	cursor:pointer;
}
#jine {
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
#sl{}
#je{ display:none;}

</STYLE>
<script>
 function shuliang()
 { document.getElementById("sl").style.display="Block"
   document.getElementById("je").style.display="none"
   document.getElementById("shul").style.background="url(img/xuanxkimg.jpg)"
   document.getElementById("jine").style.background="none"
   }
 function jine()
 { document.getElementById("je").style.display="Block"
   document.getElementById("sl").style.display="none"
   document.getElementById("shul").style.background="none"
   document.getElementById("jine").style.background="url(img/xuanxkimg.jpg)"
   }
</script>
  </head>
 <body leftmargin="0" topmargin="0" rightmargin="0">
<div style=" width:100%; height:33px; background:url(img/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(img/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">成单量分析：</div>
</div>
<div style=" width:100%; height:30px; border:#CCC double 1px; margin-top:8px; background: url(img/xuanxkbg.jpg); background-repeat:repeat-x;">
  <div id="shul" onclick="shuliang()">数量</div>
  <div id="jine" onclick="jine()">金额</div>
</div>
<div id="sl">
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
      List olist = (List)request.getAttribute("olist");
      for(int i=0;i<olist.size();i++){
        Object[] obj = (Object[])olist.get(i);
      
     %>
    <tr>
      <td class="tdlast"><c:out value="<%=obj[0] %>"/>月</td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[5]==null?0:obj[5] %>"/></td>
    </tr>
 <%} %>
 
 
     <%
        List list = (List)request.getAttribute("blist");
        for(int i=0;i<list.size();i++){
          Object[] obj = (Object[])list.get(i);
       %>
     <tr>
      <td class="tdlast">以前</td>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
     
    </tr>
     <%break;} %>
     
     
    
    <%
        List tlist = (List)request.getAttribute("tlist");
        for(int i=0;i<tlist.size();i++){
          Object[] obj = (Object[])tlist.get(i);
       %>
     <tr>
      <td class="tdlast">总计</td>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
    </tr>
     <% break;} %>
    
    
     <tr>
      <td colspan="6" class="tdfirst">日期2012-9-10</td>
    </tr>
  </table>
</div>
<div id="je">
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
      List mlist = (List)request.getAttribute("mlist");
      for(int i=0;i<mlist.size();i++){
        Object[] obj = (Object[])mlist.get(i);
    %>
     <tr>
      <td class="tdlast"><c:out value="<%=obj[0] %>"/>月</td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[5]==null?0:obj[5] %>"/></td>
    </tr>
    <%} %>
    
    
    
    <%
        List tm = (List)request.getAttribute("blist2");
        for(int i=0;i<tm.size();i++){
          Object[] obj = (Object[])tm.get(i);
       %>
     <tr>
      <td class="tdlast">以前</td>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
    </tr>
    <%break;} %>
    
    
    <%
        List tolist = (List)request.getAttribute("tolist");
        for(int i=0;i<tolist.size();i++){
          Object[] obj = (Object[])tolist.get(i);
       %>
     <tr>
      <td class="tdlast">总计</td>
      <td class="tdlast"><c:out value="<%=obj[0]==null?0:obj[0] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[1]==null?0:obj[1] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[2]==null?0:obj[2] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[3]==null?0:obj[3] %>"/></td>
      <td class="tdlast"><c:out value="<%=obj[4]==null?0:obj[4] %>"/></td>
    </tr>
    <%break;} %>
    
    
    
    <tr>
      <td colspan="6" class="tdfirst">日期2012-9-10</td>
    </tr>
  </table>
</div>
</body>
</html>
