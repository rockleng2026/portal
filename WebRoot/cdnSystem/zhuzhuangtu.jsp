<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'zhuzhuangtu.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/FusionCharts.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/EJSChart.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <div id="chartdiv1"></div>
<script type="text/javascript">

	var dataXml = "<chart caption='每月销售额柱形图' xAxisName='月份' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0'><set name='一月' value='462' color='AFD8F8' /><set name='二月' value='857' color='F6BD0F' /><set name='三月' value='671' color='8BBA00' /><set name='四月' value='494' color='FF8E46' /><set name='五月' value='761' color='008E8E' /><set name='六月' value='960' color='D64646' /><set name='七月' value='629' color='8E468E' /><set name='八月' value='622' color='588526' /><set name='九月' value='376' color='B3AA00' /><set name='十月' value='494' color='008ED6' /><set name='十一月' value='761' color='9D080D' /><set name='十二月' value='960' color='A186BE' /></chart>";
	var aa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
    aa+="<category label='0时' /><category label='2时' /><category label='4时' /><category label='6时' /><category label='8时' /><category label='10时' /><category label='12时' /><category label='14时' /><category label='16时' /><category label='18时' /><category label='20时' /><category label='22时' /><category label='24时' />";
    aa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量(2小时统计一次)'><set value='3242' /><set value='3171' /><set value='700' /><set value='1287' /><set value='1856' /><set value='987' /><set value='1610' /><set value='4000' /><set value='2000' /><set value='3012' /><set value='200' /><set value='0' /><set value='8000' /></dataset>";
  	aa+="</chart>";
  
	var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/MSLine.swf","myid","800","500");//单Y 单曲线
	//双Y多曲线  var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/MSCombiDY2D.swf","myid","800","500");
	//柱状 var mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/Column2D.swf","myid","800","500","0","0");
	
	
	
	mychart.setDataXML(aa);
	mychart.render("chartdiv1");
	

	
	</script>
  </body>
</html>
