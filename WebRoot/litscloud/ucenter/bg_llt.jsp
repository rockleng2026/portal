<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-后台（自助管理-添加CDN订单）</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<link rel="stylesheet" href="litscloud/flowchart/style.css" type="text/css"/>
<link rel="stylesheet" href="litscloud/flowchart/missionuse.css" type="text/css"/>
		
		<script src="litscloud/flowchart/amcharts.js" type="text/javascript"></script>
		<script src="litscloud/flowchart/cdncharts.js" type="text/javascript"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
$(document).ready(function(){
 	var chart;
	var chartData = [];
 	goquery();
 	 document.getElementById("a2").className = "aBackgroundImage";
	  document.getElementById("a2").style.color= "#000000";
 });
 function goquery(){
 	chartData = []
 	var realmName=document.getElementById("realmName").value;
 	var btime=document.getElementById("btime").value; 
 	var reg = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
 	if(!reg.test($.trim(btime))){
 		alert("请输入正确的时间:YYYY-MM-DD");
 		$("#btime").focus();
 		return ;
 	}
 	//alert(realmName);
 	//alert(btime);
 	var tt = (new Date()).getTime();
 	
 	$.post("<%=path%>/liuliangtu2CDNsaleOrderAction.do?tt="+tt,{realmName:realmName,time:btime},function(data){
 		if(data != '0'){
 			//$("#xx").html(data);
 			showgraph(data);
 		}	
 	});
 }
 function goquery1(){
	 chartData = []
	 	var yuming=document.getElementById("yuming").value;
	 	var startTime=document.getElementById("startTime").value;
	 	var endTime=document.getElementById("endTime").value; 
	 	if(yuming==null||yuming=='')
	 	{
		 	alert("请选择域名");
		 	return;
		 	}
	 	if(startTime==null||startTime=='')
	 	{
		 	alert("请选择开始时间");
		 	return;
		 	}
	 	if(endTime==null||endTime=='')
	 	{
		 	alert("请选择结束时间");
		 	return;
		 	}
	 	var tt = (new Date()).getTime();
	 	
	 	$("#btimespan").html(startTime+" 00:00:00 - "+endTime+" 23:59:59");
	 	$("#sitespan").html(yuming);
	 	var url="liuliangtu3CDNsaleOrderAction.do?tt="+tt+"";
	 	
	 	$.post(url,{realmName:yuming,startTime:startTime,endTime:endTime},function(data){
	 		if(data != '0'){
	 			//alert(data);
	 			//$("#xx").html(data);
	 			showgraph(data);
	 		}	
	 	});
	 }

</script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->

</head>

<body>
<div class="ly_body">
    <!--头部公用代码-->
 <jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
    <!--内容开始-->
	<div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <jsp:include page="/litscloud/ucenter/menu_3.jsp"></jsp:include>  
          <div class="bg_wd" > <!-- 945框架 -->
             <div class="ly_xxt">
             
               <div class="ly_xxtl">带宽图监控</div>        
             </div>
              <!-- 列表开始 -->
              <div class="cdn_web">
                 <div class="quo_wid quo_widt">
                    <span><a href="#">返回CDN订单信息列表</a></span><img src="images/idea_group.png" width="20" height="20" > 宽带统计
                 </div>
                 <div class="quo_wid">  <!-- 搜索结果 -->
                   <div class="quo_wid quo_search_t" align="left">
                   <span>
                
                   </span>
                   
                   请选择频道：<select name="xz" id="realmName" value="this.value" onchange="selectRealmName()">
		                  <c:forEach items="${cdnso}" var="data" >
		                  <option value="${data.cuRealmName }">${data.cuRealmName }</option>
		                  </c:forEach>
				         </select>  &nbsp;&nbsp;  <font color="red">可选这多个</font> 
                   </div>
                   <div class="quo_wid quo_search_c" align="left">
                  <font style="margin-left: 0px;font-size: 10px;">搜索结果： </font><div id="zengjia" name="zengjia" align="left" > </div><input type="hidden" id="yuming" name="yuming"/>
                 </div>
                   <div class="quo_wid quo_search_d" align="left">
                   <% Date date= new Date();
			             SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			               String datestr=sdf.format(date);
			            %>
                 <input type="hidden" value="<%=datestr %>" id="btime"  name="btime" />
                         
                          
                          选择时间：
                          <INPUT style="WIDTH: 150px" id="startTime" name="startTime" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
                          至  <INPUT style="WIDTH: 150px" id="endTime" name="endTime" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"><input type="button" class="select_button" onclick="goquery1()" value="搜索" />(注意日志格式:YYYY-MM-DD)
                   </div>
                 </div>          
                 <div class="llt_c">  <!-- 流量统计图 -->
                   <div class="cdn_li_t" style="text-indent:0px;">带宽类型比例</div>
                <div class="cdn_li_c"><img src="images/log_15.gif"  alt="xx"/></div>
                 <div class="cdn_li_cl" style="width:680px;">
                <div class="llt_ct" style="width:680px;"></div>
                <div class="llt_cc" style="width:680px;">网站带宽（单位：GB）</div>
                <div class="llt_cd" style="width:680px;">
                <div style="width:100%; height:400px;" id="chartdiv">
            	</div>
                
                </div>        
                </div>
                <div class="cdn_li_cr" style="width:260px;">
                   <div class="cdn_li_crt">说明标题</div>
                   <div class="cdn_li_crd">
说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容说明内容
</div> 
                </div>  
                 </div>                
                 
                 <div class="llt_c">
                  <div class="llt_c flow_searchtime"><em></em></div>
                </div>
                
                 <div class="llt_d"> <!-- 网站前十位访问 -->
                <div class="cdn_li_t" style="text-indent:0px;">TOP10频道按峰值排行</div>
                <div class="cdn_li_c"><img src="images/log_15.gif"  alt="xx"/></div>
                
                <div class="llt_dt">
                 <table class="flow_tables" cellpadding="0" cellspacing="0">
                       <thead>
                         <tr><th width="10%">序号</th><th width="30%">频道</th><th width="15%">峰值（Mbps）</th><th width="30%">峰值时间点</th><th width="15%">总流量</th></tr>
                       </thead>
                       <tbody>
                       <c:forEach items="${cdnLogServer}" var="data" varStatus="num">
                       	<tr><td>TOP${num.index+1 }</td><td>${data.domain }</td><td>${data.bandwidth }</td><td>${data.rqtime }</td><td>${data.temp }MB</td></tr>
                       </c:forEach>
                       </tbody>
                  </table>
                </div>
                 </div>
                 
                 
                 
              </div>
          </div>         
               
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--底部公用代码 -->
<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部结束 -->
</div>
</body>
</html>

<script type="text/javascript">
var numId=0;
function selectRealmName()
{
	numId++;
	 var realmName=document.getElementById("realmName").value;
	 var yuming=document.getElementById("yuming").value;
	 if(yuming!=null&&yuming!='')
	 {
		 var num=yuming.split(",");
		 for(var i=0;i<num.length;i++)
		 {
				if(num[i]==realmName)
				{
					alert("该域名已选");
					return;
					}
			 }
		 }
	 var mark="<a href='javascript:void(0)' id='id"+numId+"' name='id"+numId+"' title='点击移除' onclick=delYM('id"+numId+"','"+realmName+"')><font color='red'>"+realmName+"</font> ||</a>    ";
	
	 $("#yuming").val(yuming+realmName+",");
	 $("#zengjia").append(mark);
	}
function delYM(id,ym)
{
	
	$("#"+id+"").remove();
	var yuming=document.getElementById("yuming").value;
	var mark="";
	 if(yuming!=null&&yuming!='')
	 {
		 var num=yuming.split(",");
		 for(var i=0;i<num.length;i++)
		 {
				if(num[i]!=ym)
				{
					if(num[i]!='')
					mark+=num[i]+",";
				}
			 }
		 }
	 $("#yuming").val(mark);
	
	}
</script>
