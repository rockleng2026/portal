<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>CDN节点域名流量监控</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />  
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
		<link rel="stylesheet" href="litscloud/flowchart/style.css" type="text/css"/>
		<link rel="stylesheet" href="litscloud/flowchart/missionuse.css" type="text/css"/>
		
		<script src="litscloud/flowchart/amcharts.js" type="text/javascript"></script>
		<script src="litscloud/flowchart/cdncharts.js" type="text/javascript"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js">
</script>
		<script type="text/javascript">
    	$(document).ready(function(){
		 	var chart;
			var chartData = [];
		 	goquery();
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
		 	
		 	$("#btimespan").html(btime+" 00:00:00 - "+btime+" 23:59:59");
		 	$("#sitespan").html(realmName);
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
	<link type="text/css" rel="stylesheet"	href="<%=basePath%>Css/missionuse.css" />
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
            <hr style="width:300px; float:left; height:1px; position:absolute; margin-top:32px;" size="3" color="#20a3f6" />
             <span><img src="images/home.png" width="30" height="30"></span>
				<h3 style="line-height:35px;">
					带宽图监控                    
				</h3>
               
			</div>
			<table class="tb tb2 " id="tips">
				<tr style="border-bottom:dashed 1px #deeffb;">   <!--  class="dji"  -->
 					<th class="partition">
						<span><img src="images/idea_group.png" width="20" height="20" ></span>带宽图监控
					</th>
					<th class="partition"style="text-align:right;">
						<a href="javascript:void(0);">XXXXXXXXX</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1" colspan="2">
						<div class="flow_select">请选择频道：
						<select name="xz" id="realmName" value="this.value" onchange="selectRealmName()">
		                  <c:forEach items="${cdnso}" var="data" >
		                  <option value="${data.cuRealmName }">${data.cuRealmName }</option>
		                  </c:forEach>
				         </select>  &nbsp;&nbsp;  <font color="red">可选这多个</font>
                        
                        <p class="search" style="width:330px;"><span style="float:left;"></span></p>
                        </div>
                        <div class="flow_search">
                         <span>选择的结果：</span><div id="zengjia" name="zengjia" ></div><input type="hidden" id="yuming" name="yuming"/>
						</div>
						<% Date date= new Date();
			             SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			               String datestr=sdf.format(date);
			            %>
                         <div class="flow_time">
                         选择日期：<input type="hidden" value="<%=datestr %>" id="btime"  name="btime" />
                         
                          
                          选择时间：
                          <INPUT style="WIDTH: 150px" id="startTime" name="startTime" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
                          至  <INPUT style="WIDTH: 150px" id="endTime" name="endTime" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"><input type="button" class="select_button" onclick="goquery1()" value="搜索" />(注意日志格式:YYYY-MM-DD)  
                         </div>  
                         <!-- 
                         <div class="flow_time">选择日期：<input type="text" value="2013-05-05" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"  name="time_select" />  至 <input type="text" value="2012-12-12 18:00:00" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}"  name="time_select" />  <input type="button" class="select_button" value="搜索" /> </div>                   
						 -->
					</td>
				</tr>
			</table>
			<div class="itemtitle">
                
				<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
				<span><img src="images/notes.png" width="20" height="20" /></span> <p style="float:left; margin-right:50px; line-height:22px;">	生成图表</p>
				<input type="submit" value="显示类型" class="xslx" >
                <input type="button" value="按带宽显示" class="xllx" >
                <input type="button" value="按流量显示" class="jdlx" >
				</h3>
				
			</div>
			<div class="itemtitle">
                <div class="flow_t">站点名称： <span id="sitespan">www.baidu.com</span> &nbsp;&nbsp;时间范围：<span id="btimespan"></span></div>
                <div class="flow_m">网站带宽（单位：MB）</div>
                <div class="flow_c">
                <div class="flow_cl">
                   <div class="flow_clt">说明标题</div>
                   <div class="flow_cld">说明内容说明</div>
                </div>
                <div class="flow_cr">
                <div style="width:100%; height:400px;" id="chartdiv">
            	</div>
                <br />
                <div class="flow_d">
                  <dl><dt class="bg_blue"></dt><dd>红光线</dd><dt class="bg_red"></dt><dd>黄光线</dd><dt class="bg_yellow"></dt><dd>蓝光先</dd></dl>
                </div>
                </div>
                </div>
            </div>
            
              <div class="flow_top flow_margin flow_searchtime"></div>
                <div class="flow_top flow_tablet">TOP10频道按峰值排行</div>
                <div class="flow_top" style="margin:0 auto;">
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
            
		<!-- 11111111111111111111111111111111111111111111111111111 -->
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