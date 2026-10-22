<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'cdnIndex.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="<%=path%>/cdnSystem/css/base.css" />

	<link rel="stylesheet" type="text/css" href="<%=path%>/cdnSystem/css/cdncss.css"/>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/FusionCharts.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/JSClass/EJSChart.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>


<style>
.main1{
	width:1000px;
	background-color:#f1f1f1;
	height:730px;
	font-size:14px;
	text-align: center;
	color:#7b7b7b;
}
.main2{
	margin-top:-10px;
	width:1000px;
	background-color:#f1f1f1;
	height:50px;
	font-size:14px;
	text-align: center;
}
.xd_j_t {width:43px;}
.xd_j_top {width:1000px;  font-size:13px;color:#626262; background:#efefef;}
.xd_j_zi {font-size:14px; color:#626262; font-weight:bold}
.xd_j_zi_b {color:#427db7}
.xc_sy_div_l{ width:229px; float:left; height:700px; margin-top:20px;}
.xc_sy_div_r{ width:771px; float:left;height:700px; margin-top:20px;}
.xc_sy_cyurl {display:block; background: url(<%=path%>/images/anniu.jpg) repeat-x; width:170px; line-height:23px; margin-left:30px; margin-top:10px; color:#FFFFFF; text-decoration:none; text-align:center;}
.xc_sy_dv {width:170px; border:1px solid #cddbe8; margin-left:30px; margin-top:20px; background-color:#FFF; height:80px;}
.xc_sy_dv_b {width:170px; border:1px solid #cddbe8; margin-left:30px; margin-top:10px; background-color:#FFF;}
.xc_sy_tt {width:170px; background-color:#cddbe8; font-size:14px; font-weight:bold; line-height:35px;}
.xc_sy_lb {width:741px; height:35px; border-bottom:1px solid #cecece;}
.xc_sy_lb li { text-align:center; font-size:12px; margin-top:10px; border: 1px solid #cecece; width:90px; padding:12px 5px 8px 5px; border-bottom-width:0px; position:relative;  background-color:#fff; z-index:1; margin-left:522px;}
.xc_sy_div{width:741px;border:1px solid #cddbe8; border-top:0px; background-color:#fff; height:321px;}
.xc_sy_tab_b {background-color:#faf8f9; line-height:33px; border-bottom:1px solid #fff; border-top:1px solid #fff;font-size:12px; color:#636363;}
.xc_sy_tab_h {background-color:#f2f2f2; line-height:33px; font-size:12px; color:#636363;}
.xc_sy_tab_bt_b{ border:1px solid #c7c7c7; width:741px;}
.sc_sy_span{ width:53px; background-color:#456cad; text-align:center; color:#FFF; font-size:12px; line-height:18px; margin-bottom:30px;}
.sc_sy_span_t{ width:53px; background-color:#cddbe8; text-align:center; color:#000; font-size:12px; line-height:18px; margin-bottom:30px;}
.sc_sy_dqyw{ text-align:left;padding-left:9px; border:1px solid #d8d6d7; line-height:40px; background-color:#fff; width:732px;}
.sc_sy_div_ccc{ line-height:35px; text-align:left; padding-left:9px;}
.sc_sy_font_blue a{color:#4789c3}
.sc_sy_font_blue a:hover{color:#C30;}
.xd_z_zi{font-size:12px; color:#626262;}
.myList li{ float: left;}

</style>
<script type="text/javascript"><!--
function selectDomain()
{

	var domain=document.getElementById("selectDomain").value;
	var url="cdnSystem/selectFlowTodayCdnSystemAction.Action";
	$.post(url,{domain:domain},function (data){
		if(data!=null)
		{
			test(data);
			
		}
	
	});

}
function selectDomainDay()
{

	var domain=document.getElementById("selectDomain").value;
	
	var url="cdnSystem/selectFlowDayCdnSystemAction.Action";
	$.post(url,{domain:domain},function (data){
	
		if(data!=null)
		{
			test(data);
			
		}
	
	});
}
function selectDomainMonth()
{

	var domain=document.getElementById("selectDomain").value;
	
	var url="cdnSystem/selectFlowMonthCdnSystemAction.Action";
	$.post(url,{domain:domain},function (data){
	
		if(data!=null)
		{
		alert(data);
			test(data);
			
		}
	
	});
}
function selectDomainTopMonth()
{

	var domain=document.getElementById("selectDomain").value;
	
	var url="cdnSystem/selectFlowTopMonthCdnSystemAction.Action";
	$.post(url,{domain:domain},function (data){
	
		if(data!=null)
		{
			test(data);
			
		}
	
	});
}
</script>
  </head>
  
<body>
<jsp:include page="top.jsp" flush="true"/>
<div style=" height:3px; background-color:#1967AF" class="main"></div>
<div class="main" style="line-height:26px; background-color:#484647; color:#cecccd; text-align:right; font-size:12px;"><span style="padding-left:80px; padding-right:5px;">账号管理 | 设置</span></div>
<div align="center">

<div class="main1">
  <table class="xd_j_top" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="50" height="29" align="center"  class="xd_j_t"><img src="<%=path%>/cdnSystem/images/yjt.png" alt="" width="9" height="8" /></td>
          <td width="950" align="left"><span class="xd_j_zi">当前位置</span>:<span class="xd_j_zi_b">首页 &gt;</span></td>
        </tr>
      </table></td>
    </tr>
  </table>
<div class="xc_sy_div_l">
<div align="center">
<div style="background-color:#fff; font-size:12px; width:155px; height:132px; border:1px solid #cecece; padding:5px 5px 10px 5px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="28%" rowspan="2"><img src="<%=path%>/cdnSystem/images/sy_rt.png" width="63" height="55" border="1" /></td>
    <td width="72%" valign="middle" style="padding-left:25px; padding-bottom:7px;"><h2 class="sc_sy_font_blue"> ${user.userName }</h2></td>
  </tr>
  <tr>
    <td valign="middle"  style="padding-left:25px;" class="sc_sy_font_blue">修改资料</td>
  </tr>
</table><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" style="padding-left:5px;">计费单元数量：21</td>
  </tr>
  <tr>
    <td align="left" style="padding-left:5px;"><p>频道数量：21</p></td>
  </tr>
  <tr>
    <td align="left" style="padding-left:5px;">合同期至:2013-3-4</td>
  </tr>
</table>
</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td width="16%" align="center" style="padding-left:5px;"><img src="<%=path%>/cdnSystem/images/sy_suo.png" width="23" height="23" /></td>
    <td width="84%" align="left"> 常用功能</td>
  </tr>
  <tr>
    <td colspan="2"><a href="" class="xc_sy_cyurl">业务概况 &gt;&gt;</a></td>
  </tr>
  <tr>
    <td colspan="2"><a href="" class="xc_sy_cyurl">宽带详情 &gt;&gt;</a></td>
  </tr>
  <tr>
    <td colspan="2"><a href="" class="xc_sy_cyurl">快捷刷新 &gt;&gt;</a></td>
  </tr>
</table>
<div>
  <div class="xc_sy_dv">
    <div class="xc_sy_tt"><div style="float:left; margin-left:10px;position:absolute; margin-top:-10px; margin-left:15px;"><img src="<%=path%>/cdnSystem/images/sy_sj.png" width="21" height="38" /></div>
      手机客户端    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style=" margin-top:10px;">
      <tr>
        <td width="26%" align="right"><img src="<%=path%>/cdnSystem/images/sy_andriod.png" width="18" height="17" /></td>
        <td width="74%" align="left">Android版下载</td>
      </tr>
    </table>
    
  </div>
</div>
  <div class="xc_sy_dv_b">
    <div class="xc_sy_tt"><div style="float:left; margin-left:10px;"><img src="<%=path%>/cdnSystem/images/sy_dh.png" width="21" height="30" /></div>
    客户服务
    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="  font-size:12px;">
      <tr>
        <td width="12%" align="left" style="color:#000; border-bottom:1px solid #d0d0d0; background-color:#f2f2f2; line-height:30px;"><strong>全国统一服务热线：</strong></td>
        </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF" style="color:#000;"><strong>400-6789-930</strong></td>
      </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF">服务监督：</td>
      </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF" style="color:#000;"><strong>0755-29558715-8009</strong></td>
      </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF">深圳公司：0755-29558715</td>
      </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF">山东公司：0543-3088618</td>
      </tr>
      <tr>
        <td align="left" bgcolor="#FFFFFF">北京公司：010-82517828</td>
      </tr>
      </table>   
  </div>

</div>
<div class="xc_sy_div_r"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:20px;">
  <tr>
    <td width="3%"><img src="<%=path%>/cdnSystem/images/sy_ds.png" width="20" height="18" /></td>
    <td width="97%" align="left"><strong>当前带宽</strong></td>
  </tr>
</table>
<div class="sc_sy_dqyw">当前业务  
  <select id="selectDomain" name="dangQianYeWu" value="this.value">
  <c:forEach items="${cdnDomain}" var="cfData">
  	
  <option value="${cfData.domain }" >${cfData.domain }</option>
  </c:forEach>
</select>
  <span style="margin-left:20px; font-size:12px;" class="sc_sy_font_blue"><a href="#">进入查看详情</a></span>
</div>
<div><div class="xc_sy_lb"><ul>
  <li class="sc_sy_font_blue">中国大陆地区</li></ul>
</div>
<div class="xc_sy_div"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="92%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="left" style="padding-left:10px; padding-top:10px; padding-bottom:5px; color:#000;"><strong>峰值：37.9Kbps(2013-2-4 00:00) 流量：245MBytes</strong></td>
      </tr>
      <tr>
        <td align="left" style="font-size:12px;padding-left:100px;">汇总 时间=00:00:00； 带宽（bps）=0.00</td>
      </tr>
    </table></td>
    <td width="8%">&nbsp;</td>
  </tr>
  <tr>
    <td><div id="chartdiv1">
    
    </div>
    
    </td>
    <td align="right"><p><div class="sc_sy_span_t"><input type="button" onclick="selectDomain()" id="" name="" value="今天" /></div></p>
      <p><div class="sc_sy_span"><input type="button" id="" name="" onclick="selectDomainDay()" value="7天" /></div></p>
      <p><div class="sc_sy_span"><input type="button" id="" name="" onclick="selectDomainMonth()" value="今月" /></div></p>
      <p><div class="sc_sy_span"><input type="button" id="" name="" onclick="selectDomainTopMonth()" value="上月" /></div></p></td>
  </tr>
</table>
</div>
</div>
<div class="sc_sy_div_ccc"><img src="<%=path%>/cdnSystem/images/i.png" width="7" height="13" /> <strong>最新消息</strong></div>
<div class="xc_sy_tab_bt_b">
<table width="738px" border="0" cellpadding="0" cellspacing="0" class="xc_sy_tab">
  <tr class="xc_sy_tab_h">
    <td align="left" style="padding-left:20px;">了肯定高很多了空间大的开了房间的了快了两个看了看快了的快了估计快了</td>
    <td>[2013-1-16]</td>
    </tr>
  <tr class="xc_sy_tab_b">
    <td align="left" class="xc_sy_tab_b" style="padding-left:20px;">了肯定高很多了空间大的开了房间的了快了两个看了看快了的快了估计快了</td>
    <td class="xc_sy_tab_b">[2013-1-16]</td>
  </tr>
  <tr class="xc_sy_tab_h">
    <td align="left" style="padding-left:20px;">了肯定高很多了空间大的开了房间的了快了两个看了看快了的快了估计快了</td>
    <td>[2013-1-16]</td>
  </tr>
  <tr class="xc_sy_tab_b">
    <td align="left" class="xc_sy_tab_b" style="padding-left:20px;">了肯定高很多了空间大的开了房间的了快了两个看了看快了的快了估计快了</td>
    <td class="xc_sy_tab_b">[2013-1-16]</td>
  </tr>
  <tr class="xc_sy_tab_h">
    <td align="left" style="padding-left:20px;">了肯定高很多了空间大的开了房间的了快了两个看了看快了的快了估计快了</td>
    <td>[2013-1-16]</td>
  </tr>
</table>
</div>
</div>
<div>

</div>
</div></div>
<div align="center">
<div class="main2"><div align="center" style="color:#7b7b7b; font-size:12px; margin-top:0px;">
<hr /><span style="color:#7b7b7b; font-size:12px;">C o p y r i g h t &copy; 福 奥 科 技 有 限 公 司</span></div></div>
</div>
</div>
</body>
</html>
<script type="text/javascript">

	
	var aa="<chart palette='2' baseFontSize='14' showYAxisValues='1' caption='流量图表' rotateNames='0' showValues='0' divLineDecimalPrecision='1' limitsDecimalPrecision='1' PYAxisName='流量'  numberPrefix='MB' formatNumberScale='0'><categories>";
    aa+="<category label='0时' /><category label='2时' /><category label='4时' /><category label='6时' /><category label='8时' /><category label='10时' /><category label='12时' /><category label='14时' /><category label='16时' /><category label='18时' /><category label='20时' /><category label='22时' /><category label='24时' />";
    aa+="</categories><dataset   renderAs='Line' parentYAxis='P' seriesName='流量(今天流量2小时统计一次)'><set value='"+${ct.aHours}+"' /><set value='"+${ct.bHours}+"' /><set value='"+${ct.cHours}+"' /><set value='"+${ct.dHours}+"' /><set value='"+${ct.eHours}+"' /><set value='"+${ct.fHours}+"' /><set value='"+${ct.gHours}+"' /><set value='"+${ct.hHours}+"' /><set value='"+${ct.iHours}+"' /><set value='"+${ct.jHours}+"' /><set value='"+${ct.kHours}+"' /><set value='"+${ct.lHours}+"' /><set value='"+${ct.mHours}+"' /></dataset>";
  	aa+="</chart>";
  
	var mychart;
	test(aa);
	
 function  test(at){
 	mychart=new FusionCharts("<%=request.getContextPath()%>/fusionChart/MSLine.swf","myid","680","266");//单Y 单曲线
	
	
	mychart.setDataXML(at);
	mychart.render("chartdiv1");
 }
	

	</script>
