<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>日志统计</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cms/css/easyui.css"></link>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet></LINK>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/cms/css/icon.css"></link>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cms/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cms/js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/cms/js/emplog.js"></script>

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
.tj{
   width:109px; 
   height:33px; 
   margin-left:15px; 
   text-indent:30px; 
   line-height:38px; 
   font-size:12px;
   cursor: pointer;
}
#xuanl {
	width:100px;
	height:25px;
	margin-top:4px;
	margin-left:15px;
	background:url(images/xuanxkimg.jpg);
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
#cdje{ display:none;}
</STYLE>
<script>
 function shuliang()
 { document.getElementById("cdl").style.display="Block"
   document.getElementById("cdje").style.display="none"
   document.getElementById("xuanl").style.background="url(images/xuanxkimg.jpg)"
   document.getElementById("xuanr").style.background="none"
   }
 function jine()
 { document.getElementById("cdje").style.display="Block"
   document.getElementById("cdl").style.display="none"
   document.getElementById("xuanl").style.background="none"
   document.getElementById("xuanr").style.background="url(images/xuanxkimg.jpg)"
   }
 function showyuetj(){
	 $("#rj").hide();
	 $("#yj").show();
	 $("#ritj").attr("style","background:url(<%=request.getContextPath() %>/images/header3bg.jpg); background-repeat:repeat-x;");
	 $("#yuetj").attr("style","background:url(<%=request.getContextPath() %>/images/head3-img.jpg); background-repeat:no-repeat");
	 window.location.href="<%=request.getContextPath()%>/yjPageWorkLog.do";
 }
 function showritj(){
	 $("#rj").show();
	 $("#yj").hide();
	 $("#yuetj").attr("style","background:url(<%=request.getContextPath() %>/images/header3bg.jpg); background-repeat:repeat-x;");
	 $("#ritj").attr("style","background:url(<%=request.getContextPath() %>/images/head3-img.jpg); background-repeat:no-repeat");
	 window.location.href="<%=request.getContextPath()%>/emplogByRjWorkLog.do";
 }

 // 根据时间查询统计日志
 function searchByTime(){
	 var logtime= $("#logtime").val();
	 var deptid=$("#dept").val();
	 var empid=$("#emp").val();
	 $.ajax({
		 type:"post",
		 url:"tjrzWorkLog.do",
		 data:{
			 "logtime":logtime,
			 "deptid":deptid,
			 "empid":empid
			 },
		 success:function(date){
			 $("#loglist").html("");
			 $("#loglist").html(date);
		 }
	 });
 }
 
//根据月份查询统计日志
 function searchByYue(){
	 var mon=$("#yue").val();
	 var deptid=$("#yuedept").val();
	 var empid=$("#yueemp").val();
	 $.ajax({
		 type:"post",
		 url:"emplogByYjWorkLog.do",
		 data:{
			 "mon":mon,
			 "deptid":deptid,
			 "empid":empid
			 },
		 success:function(date){
			 $("#yulog").html("");
			 $("#yulog").html(date);
		 }
	 });
 }
 //查看员工请假时间。
 function qjinfo(obj){
	 var empid=obj.id;
	 var qjtime=$("#logtime").val();
	 window.location.href="<%=request.getContextPath()%>/empByQjInfoWorkLog.do?empid="+empid+"&qjtime="+qjtime;
 }
 //查看员工这个月未写日志请假的天数。
 function yueQjDate(obj){
	 var empid=obj.id;
	 var yue=$("#yue").val();
	 window.location.href="<%=request.getContextPath()%>/yueQjDateWorkLog.do?empid="+empid+"&yue="+yue;
 }
</script>
</head>
<body leftmargin="0" topmargin="0" rightmargin="0">
<c:if test="${loglist!=''}">
	<div style="width:100%;  background:url(<%=request.getContextPath() %>/images/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
	<div style="height:33px; float:left;">
	  <div id="ritj" onclick="showritj()" class="tj" style="background:url(<%=request.getContextPath() %>/images/head3-img.jpg); background-repeat:no-repeat;">按日统计:</div>
	</div>
	<div style="float:left; height:33px;">
	  <div id="yuetj" style="" class="tj" onclick="showyuetj()">按月统计:</div>
	</div>
	</div>
</c:if>
<c:if test="${loglist==''}">
	<div style="width:100%;  background:url(<%=request.getContextPath() %>/images/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
	<div style="height:33px; float:left;">
	  <div id="ritj" onclick="showritj()" class="tj" style="">按日统计:</div>
	</div>
	<div style="float:left; height:33px;">
	  <div id="yuetj" style="background:url(<%=request.getContextPath() %>/images/head3-img.jpg); background-repeat:no-repeat;" class="tj" onclick="showyuetj()">按月统计:</div>
	</div>
	</div>
</c:if>


<div id="rj" style="width: 100%;">
<c:if test="${loglist!=''}">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">  
    <tr>
      <td align="left" colspan="5" class="tdfirst">
	      请选择日期：<input type="text" name="recordTime" id="logtime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" style="width: 100px; border: 1px solid #ccc;" value="" /> 
                 请选择部门：<select id="dept">
                    <option value="-1">--所有--</option>
                     <c:forEach items="${deptlist}" var="dept">
                     	<option value="${dept.id}">${dept.name}</option>
                     </c:forEach>
                 </select>
                 请选择员工：<select id="emp">
                     <option value="-1">--所有--</option>
                     <c:forEach items="${emplist}" var="emp">
                     	<option value="${emp.id}">${emp.name}</option>
                     </c:forEach>
                 </select>
       <input type="button" value="搜索" onclick="searchByTime()" style="width:50px; height:20px; border: 1px solid #000; background-color: #CCC" />
      </td>
    </tr>
    <tr>
      <td width="15%" class="tdfirst">员工</td>
      <td width="15%" class="tdfirst">部门</td>
      <td width="15%" class="tdfirst">职位</td>
      <td width="15%" class="tdfirst">日志</td>
      <td width="15%" class="tdfirst">操作</td>
    </tr>
    <tbody id="loglist">
	    <c:forEach items="${loglist}" var="obj">
		    <tr>
		      <td class="tdlast">${obj[1]}</td>
		      <td class="tdlast">${obj[3]}</td>
		      <td class="tdlast">${obj[2]}</td>
	         <c:if test="${obj[4]==0}">
	              <!-- 0未写，1警告，2已写 -->
	            <td class="tdlast">
	              <img src="<%=request.getContextPath() %>/img/x.jpg" width="25" height="25"></img>
	            </td>
	         </c:if>
	          <c:if test="${obj[4]==1}">
	            <td class="tdlast">
	              <img src="<%=request.getContextPath() %>/img/quan.jpg"  width="25" height="25"></img>
	            </td>
	         </c:if>
	          <c:if test="${obj[4]==2}">
	            <td class="tdlast">
	              <img src="<%=request.getContextPath() %>/img/gou.jpg"  width="25" height="25"></img>
	            </td>
	         </c:if>
		      <td class="tdlast">
		        <c:if test="${obj[4]!=2}">
			         <c:if test="${obj[5]==1}">
			            <a href="javascript:void(0);" onclick="qjinfo(this)" id="${obj[0]}" class="tda">查看请假原因</a>
			         </c:if>
			         <c:if test="${obj[5]!=1}">
			            <font style="font-weight: bold;" color="red">没写日志！</font>
			         </c:if>
		        </c:if>
		      </td>
		    </tr>
	    </c:forEach>
    <tr>
       <td>
           <img src="<%=request.getContextPath() %>/images/r_4.gif" alt="" />
       </td>
       <td colspan="3">
           <p:pages url="emplogByRjWorkLog.do?funid=14" />
       </td>
       <td>
           <img src="<%=request.getContextPath() %>/images/r_3.gif" alt="" />
       </td>
    </tr>
    </tbody>
  </table>
</c:if>
</div>


<div id="yj" style="width: 100%;">
<c:if test="${loglist==''}">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">  
    <tr>
      <td align="left" colspan="6" class="tdfirst">
	       请选择月份：<select name="yue" id="yue">
	               <option value="-1">--所有--</option><option value="1">1月</option><option value="2">2月</option><option value="3">3月</option><option value="4">4月</option><option value="5">5月</option>
	                <option value="6">6月</option><option value="7">7月</option><option value="8">8月</option><option value="9">9月</option><option value="10">10月</option>
	                <option value="11">11月</option><option value="12">12月</option>
	             </select>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                 请选择部门：<select id="yuedept">
                     <option value="-1">--所有--</option>
                     <c:forEach items="${deptlist}" var="dept">
                     	<option value="${dept.id}">${dept.name}</option>
                     </c:forEach>
                 </select>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                 请选择员工：<select id="yueemp">
                     <option value="-1">--所有--</option>
                     <c:forEach items="${emplist}" var="emp">
                     	<option value="${emp.id}">${emp.name}</option>
                     </c:forEach>
                 </select>
      <input type="button" value="搜索" onclick="searchByYue()" style="width:50px; height:20px; border: 1px solid #000; background-color: #CCC" />
      </td>
    </tr>
    <tr>
      <td width="15%" class="tdfirst">部门</td>
      <td width="15%" class="tdfirst">员工</td>
	  <td width="15%" class="tdfirst">日志状态</td>
      <td width="15%" class="tdfirst">日志</td>
      <td width="15%" class="tdfirst">周志</td>
      <td width="15%" class="tdfirst">月志</td>
    </tr>
    <tbody id="yulog">
    <%
       List<Object[]> objlist=(List<Object[]>)request.getAttribute("yuelog");
       // 已写日志数，周志数。
       int datecount=Integer.parseInt(request.getAttribute("datecount").toString());
       int weekcount=Integer.parseInt(request.getAttribute("weekcount").toString());
       for(int i=0;i<objlist.size();i++){
    	   Object[] obj=objlist.get(i);
    %>
    <tr>
      <td class="tdlast" rowspan="3"><%=obj[0] %></td>
	  <td class="tdlast" rowspan="3"><%=obj[1] %></td>
      <td class="tdlast">实写</td>
      <td class="tdlast"><font style="font-weight: bold;" color="blue"><%=datecount %></font></td>
      <td class="tdlast"><font style="font-weight: bold;" color="blue"><%=weekcount %></font></td>
      <td class="tdlast"><font style="font-weight: bold;" color="blue">1</font></td>
    </tr>
	<tr>
      <td class="tdlast">已写</td>
      <% 
         String dlog="0";String wlog="0";String mlog="0";
         if(obj[3]!=null){
         	dlog=obj[3].toString();
         }
         if(obj[4]!=null){
         	wlog=obj[4].toString();
         }
         if(obj[5]!=null){
          	mlog=obj[5].toString();
         }
         
         if(dlog==null||dlog.trim().length()<=0){
        	 dlog="0";
         }
         if(wlog==null||wlog.trim().length()<=0){
        	 wlog="0";
         }
         if(mlog==null||mlog.trim().length()<=0){
        	 mlog="0";
         }
         // 未写日志数量
         int ndlog=datecount-Integer.parseInt(dlog);
         int wdlog=weekcount-Integer.parseInt(wlog);
         int mdlog=1-Integer.parseInt(mlog);
      %>
      <td class="tdlast"><%=dlog %></td>
      <td class="tdlast"><%=wlog %></td>
      <td class="tdlast"><%=mlog %></td>
    </tr>
    <tr>
       <td class="tdlast">未写</td>
      <td class="tdlast">
         <%if(ndlog==0){ %>
            <font style="font-weight: bold;" color="red"><%=ndlog %></font>
         <%}else{ %>
            <a href="javascript:void(0);" onclick="yueQjDate(this)" id="<%=obj[2] %>"><font style="font-weight: bold;" color="red"><%=ndlog %></font></a></td>
         <%} %>
      <td class="tdlast"><font style="font-weight: bold;" color="red"><%=wdlog %></font></td>
      <td class="tdlast"><font style="font-weight: bold;" color="red"><%=mdlog %></font></td>
    </tr>
   <%} %>
   <tr>
       <td>
           <img src="<%=request.getContextPath() %>/images/r_4.gif" alt="" />
       </td>
       <td colspan="3">
           <p:pages url="yjPageWorkLog.do?funid=14" />
       </td>
       <td>
           <img src="<%=request.getContextPath() %>/images/r_3.gif" alt="" />
       </td>
    </tr>
   </tbody>
  </table>
</c:if>
</div>
</body>
</html>

