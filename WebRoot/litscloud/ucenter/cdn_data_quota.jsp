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
		<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
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
             // PIE CHART
             document.getElementById("a3").className = "aBackgroundImage";
       	  document.getElementById("a3").style.color= "#000000";
             var chartData =[];
             selectFlowType();
             selectISPType();
             selectFlow();
         });
     function selectFlowType(){
    
    	 var chart;
         var legend;
         chartData =[]
      	var realmName=document.getElementById("realmName").value;
      	var tt = (new Date()).getTime();
      	var url1="selectFlowTypeCDNsaleOrderAction.do?tt="+tt+"&realmName="+realmName+"";
      	
            $.ajax({
                type: "POST",
                url:url1,
                cache: false,
                async: false,
                success: function(data){
				var dt=data.split(",");
		         chartData.push({ country:"回源流量", value: dt[0]});
		         chartData.push({ country:"CACHE流量", value: dt[1]});
		    	 chart = new AmCharts.AmPieChart();
		         chart.dataProvider = chartData;
		         chart.titleField = "country";
		         chart.valueField = "value";
		         chart.outlineColor = "#FFFFFF";
		         chart.outlineAlpha = 0.8;
		         chart.outlineThickness = 2;
		         // this makes the chart 3D
		         chart.depth3D = 15;
		         chart.angle = 30;
		
		         // WRITE
		         chart.write("chartdiv2");
   		         
                }
             });


         }
     function selectISPType(){
         
    	 var chart;
         var legend;
		
         chartData =[]
      	var realmName=document.getElementById("realmName").value;
      	var tt = (new Date()).getTime();
    	var url1="selectISPTypeCDNsaleOrderAction.do?tt="+tt+"&realmName="+realmName+"";
      	
        $.ajax({
            type: "POST",
            url:url1,
            cache: false,
            async: false,
            success: function(data){
				var dt=data.split(",");
         chartData.push({ country:"电信连接次数", value: dt[0]});
         chartData.push({ country:"联通连接次数", value: dt[1]});
         chartData.push({ country:"移动连接次数", value: dt[2]});
         chartData.push({ country:"铁通连接次数", value: dt[3]});
         chartData.push({ country:"教育网连接次数", value: dt[4]});
         chartData.push({ country:"其他连接次数", value: dt[5]});
    	 chart = new AmCharts.AmPieChart();
         chart.dataProvider = chartData;
         chart.titleField = "country";
         chart.valueField = "value";
         chart.outlineColor = "#FFFFFF";
         chart.outlineAlpha = 0.8;
         chart.outlineThickness = 2;
         // this makes the chart 3D
         chart.depth3D = 15;
         chart.angle = 30;

         // WRITE
         chart.write("chartdiv1");
        }
            });


         }
     function selectFlow()
     {
    	 var chart;
		 chartData = []
    	 var realmName=document.getElementById("realmName").value;
    	 var startTime=document.getElementById("startTime1").value;
       	var tt = (new Date()).getTime();
     	var url1="selectFlowCDNsaleOrderAction.do?tt="+tt+"&realmName="+realmName+"&startTime="+startTime+"";
       	
         $.ajax({
             type: "POST",
             url:url1,
             cache: false,
             async: false,
             success: function(data){
        	 showgraph(data);
             
         }
         });
			
         }
     function selectTemp()
     {
                select1();
                select2();
                select3();
	    	             
      }
     function select1()
     {
    	  
    	 var chart;
         var legend;
		
         chartData =[]
    	 var yuming=document.getElementById("yuming").value;
		 var startTime=document.getElementById("startTime1").value;
		 var endTime=document.getElementById("endTime").value; 
		
		 var tt = (new Date()).getTime();
	      	var url1="selectFlowTypeTimeCDNsaleOrderAction.do?tt="+tt+"&realmName="+yuming+"&startTime="+startTime+"&endTime="+endTime+"";
	      	
	            $.ajax({
	                type: "POST",
	                url:url1,
	                cache: false,
	                async: false,
	                success: function(data){
					var dt=data.split(",");
			         chartData.push({ country:"回源流量", value: dt[0]});
			         chartData.push({ country:"CACHE流量", value: dt[1]});
			    	 chart = new AmCharts.AmPieChart();
			         chart.dataProvider = chartData;
			         chart.titleField = "country";
			         chart.valueField = "value";
			         chart.outlineColor = "#FFFFFF";
			         chart.outlineAlpha = 0.8;
			         chart.outlineThickness = 2;
			         // this makes the chart 3D
			         chart.depth3D = 15;
			         chart.angle = 30;
			
			         // WRITE
			         chart.write("chartdiv2");
	   		         
	                }
	             });
			
         }
     
     function select2()
     {
    	  
    	 var chart;
         var legend;
		
         chartData =[]
    	 var yuming=document.getElementById("yuming").value;
		 var startTime=document.getElementById("startTime1").value;
		 var endTime=document.getElementById("endTime").value; 
			
		 var tt = (new Date()).getTime();
	      	
	 var url2="selectISPTypeTimeCDNsaleOrderAction.do?tt="+tt+"&realmName="+yuming+"&startTime="+startTime+"&endTime="+endTime+"";
	          	
	            $.ajax({
	                type: "POST",
	                url:url2,
	                cache: false,
	                async: false,
	                success: function(data){
	    				var dt=data.split(",");
	             chartData.push({ country:"电信连接次数", value: dt[0]});
	             chartData.push({ country:"联通连接次数", value: dt[1]});
	             chartData.push({ country:"移动连接次数", value: dt[2]});
	             chartData.push({ country:"铁通连接次数", value: dt[3]});
	             chartData.push({ country:"教育网连接次数", value: dt[4]});
	             chartData.push({ country:"其他连接次数", value: dt[5]});
	        	 chart = new AmCharts.AmPieChart();
	             chart.dataProvider = chartData;
	             chart.titleField = "country";
	             chart.valueField = "value";
	             chart.outlineColor = "#FFFFFF";
	             chart.outlineAlpha = 0.8;
	             chart.outlineThickness = 2;
	             // this makes the chart 3D
	             chart.depth3D = 15;
	             chart.angle = 30;

	             // WRITE
	             chart.write("chartdiv1");
	            }
	                });
         }
     function select3()
     {
    	 var chart;
         var legend;
		
         chartData =[]
    	 var yuming=document.getElementById("yuming").value;
		 var startTime=document.getElementById("startTime1").value;
		 var endTime=document.getElementById("endTime").value; 
		
		 var tt = (new Date()).getTime();
     	var url1="selectFlowTimeCDNsaleOrderAction.do?tt="+tt+"&realmName="+yuming+"&startTime="+startTime+"&endTime="+endTime+"";
       
         $.ajax({
             type: "POST",
             url:url1,
             cache: false,
             async: false,
             success: function(data){
        	 showgraph(data);
             
         }
         });
			
         }
     
    	</script>
	<link type="text/css" rel="stylesheet"	href="<%=basePath%>Css/missionuse.css" />
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
             
               <div class="ly_xxtl">流量统计</div>        
             </div>
              <!-- 列表开始 -->
              <div class="cdn_web">
                 <div class="quo_wid quo_widt">
                    <span><a href="#">返回CDN订单信息列表</a></span><img src="images/idea_group.png" width="20" height="20" > 流量统计
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
                          <INPUT style="WIDTH: 150px" id="startTime1" name="startTime1" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})">
                          至  <INPUT style="WIDTH: 150px" id="endTime" name="endTime" value="<%=datestr %>"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"><input type="button" class="select_button" onclick="selectTemp()" value="搜索" />(注意日志格式:YYYY-MM-DD)
                   </div>
                 </div>          
                 <div class="llt_c">  <!-- 流量统计图 -->
                  <div class="cdn_li_t" style="text-indent:0px;">流量类型比例</div>
                <div class="cdn_li_c"><img src="images/log_15.gif"  alt="xx"/></div>
                
                <div class="llt_cd" style="width: 100%;height: 200px"  id="chartdiv2"></div>          
                 </div>
                 <div class="llt_c">  <!-- 流量统计图 -->
                   <div class="cdn_li_t" style="text-indent:0px;">各ISP比例</div>
                <div class="cdn_li_c"><img src="images/log_15.gif"  alt="xx"/></div>
                
                <div class="llt_cd" style="width: 100%;height: 200px"  id="chartdiv1"></div>          
                 </div>
                 <div class="llt_c">  <!-- 流量统计图 -->
                   <div class="cdn_li_t" style="text-indent:0px;">流量按天统计</div>
                <div class="cdn_li_c"><img src="images/log_15.gif"  alt="xx"/></div>
               
                <div class="llt_cd"  style="width: 100%;height: 200px" id="chartdiv"></div>
               
               
                <div class="llt_dt">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="llt_table">
                  <tr><th class="bd_left" width="20%">域名</th><th width="20%">流量（单位GB）</th><th width="30%">带宽峰值(Mbps)</th><th width="30%">峰值时间</th></tr>
                  <tr><td class="bd_left">${cls.domain }</td><td>${cls.flow }</td><td>${cls.bandwidth }</td><td>${cls.rqtime }</td></tr>
                  
                  </table>
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
                         <tr><th width="30%">序号</th><th width="30%">身份名称</th><th width="40%">流量比例</th></tr>
                       </thead>
                       <tbody>
                       <c:forEach items="${cdnAreaDis}" var="data" varStatus="num">
                         <tr><td>TOP${num.index+1 }</td><td><a href="javacsript:void(0)">${data.arear }</a></td><td>${flowBilI[num.index]}%</td></tr>
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