<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<meta http-equiv="x-ua-compatible" content="ie=7" />
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
 .msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
  .msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.rz_box{ border-top:2px solid #4FA805;}
.main { width:760px; margin:0 auto;}
.wzdh { line-height:25px;}
.wzls { color:#3b8801;}
.wzcs { color:#ff6600;}
.wcm_u { color:#295a01; line-height:70px; font-size:14px; padding-left:15px; font-weight:bold;}
.wcm_t { color:#b1afb0; font-size:12px; line-height:70px; font-weight:normal;}
.cont_bg { width:650px; margin-bottom:30px; padding-left:15px;}
.cont_bg td{font-size:12px;}
.cont_bg img{border: 0;margin-top: 17px;margin-bottom: 17px;}
.yjbk_h { width:179px; line-height:66px; background:url(<%=path %>/potal/images/yjbk_h.jpg) no-repeat; text-align:center;}
.yjbk_h a { text-decoration:none; color:#000000;}
.yjbk_h a:hover { color:#3b8801; background:url(<%=path %>/potal/images/yjbk_l.jpg) no-repeat; width:179px; display:block; line-height:66px; text-align:center;}
.zx_xx{width:273px; height:26px; background:#eeeeee; padding-left:10px; float:left; line-height:26px; color:#000000; font-size:12px; border:1px solid #a8a8a8; overflow:hidden}
.zx_xx span{float:right; padding-right:10px; padding-top:1px;}
.zx_xx a{color:#000000; font-size:14px; font-weight:bold; text-decoration:none}
.zxxx_nr{width:278px; border:1px solid #a8a8a8; border-top-width:0;  float:left; padding-left:5px; line-height:25px; height:200px; overflow-y:auto;}
.cont_bgl{margin-right:30px;width:280px; float:left; height:auto; }
.cont_bgr{width:300px; float:left; height:auto;}
.yxyg{
	width:353px;
	height:auto;
	overflow:hidden;
	margin:0 auto;
	}
.yxyg_t{
	width:353px;
	height:5px;
	overflow:hidden;
	background-image:url(<%=path %>/potal/images/gd_01.gif);
	background-repeat:no-repeat;
	}
.yxyg_d{
	width:353px;
	height:6px;
	overflow:hidden;
	background-image:url(<%=path %>/potal/images/gd_04.gif);
	background-repeat:no-repeat;
	}
.yxyg_c{
	width:353px;
	height:26px;
	overflow:hidden;
	background-image:url(<%=path %>/potal/images/gd_02.gif);
	background-repeat:repeat-y;
	border-bottom:solid 1px #c4c4c4;
	font-size:12px;
	color:#000;
	line-height:26px;
	text-indent:10px;
	}
.yxyg_c span{
	float:right;
	height:9px;
	width:11px;
	line-height:0px;
	margin-top:-8px;
	margin-right:20px;
	}	
.yxyg_m{
	width:353px;
	height:auto;
	overflow:hidden;
	background-image:url(<%=path %>/potal/images/gd_03.gif);
	background-repeat:repeat-y;
	}
.yxyg_mc{
	height:177px;
	width:333px;
	margin:10px 10px 5px 10px; 
	}	
.cont_bgr ul{
	margin:0px;
	padding:0px;
	}
.cont_bgr ul li{
	width:134px;
	height:177px;
	list-style:none;
	float:left;
	margin-right:10px;
	}
.wrap {width:134px; height:177px; position:relative; overflow:hidden; font-family:arial, sans-serif;}
.wrap img {display:block;}
.wrap div {width:134px; height:177px; margin:155px 0px 0px 0px; position:absolute; left:0; top:0; background:url(<%=path %>/potal/images/gd_08.png);}
.wrap div p{ width:114px; margin:0 auto; height:260px; overflow:hidden; line-height:22px; font-size:12px; color:#fff; text-indent:25px;}
.wrap div h1{ width:134px; height:25px; line-height:25px; font-size:12px; color:#fff; font-weight:normal; font-family:"宋体"; margin:0px; padding:0px;}
.wrap div a {color:#fc0; font-size:12px; left:0;text-decoration:none; display:block; margin:0;}
.wrap div a:hover {color:#ff0;}	
</style>
<script src="<%=path %>/potal/js/jquery-1.6.min.js" type="text/javascript"></script>
<script src="<%=path %>/potal/js/photo-info.js" type="text/javascript"></script>
<div class="main">
<div class="wzdh">
<span class="wzls">您的位置</span>：首页</div>
</div>
<div class="main">
<div class="wcm_u">
下午好，${emp.name}。
<span class="wcm_t">
晚饭时间到啦！
</span>
</div>
</div>
<div class="main">
<div class="cont_bg">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="33%"><div class="yjbk_h"><a href="#">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_jis.jpg" /></td>
          <td width="60%" align="left">工作记事</td>
        </tr>
      </table></a>
    </div></td>
    <td width="33%"><div class="yjbk_h"><a href="<%=path %>/selectDayWorkLogNewportal.do">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_rz.jpg" alt="我的日志" /></td>
          <td width="60%" align="left">我的日志<span class="wzls">(</span><span class="wzcs">1</span><span class="wzls">)</span></td>
        </tr>
      </table></a>
    </div></td>
    <td width="34%"><div class="yjbk_h"><a href="#">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_rw.jpg" alt="任务分配" /></td>
          <td width="60%" align="left">任务分配</td>
        </tr>
      </table></a>
    </div></td>
  </tr>
  <tr>
    <td width="33%" height="25">&nbsp;</td>
    <td width="33%" height="25">&nbsp;</td>
    <td width="34%" height="25">&nbsp;</td>
  </tr>
  <tr>
    <td><div class="yjbk_h"><a href="#">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_xs.jpg" alt="销售订单" /></td>
          <td width="60%" align="left">销售订单</td>
        </tr>
      </table></a>
    </div></td>
    <td><div class="yjbk_h"><a href="<%=path %>/selectOtherWorkLogNewportal.do">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_dp.jpg" alt="待批日志" /></td>
          <td width="60%" align="left">待批日志</td>
        </tr>
      </table></a>
    </div></td>
    <td><div class="yjbk_h"><a href="#">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="40%" align="right"><img src="<%=path %>/potal/images/xtb_sk.jpg" alt="收款明细" /></td>
          <td width="60%" align="left">收款明细</td>
        </tr>
      </table></a>
    </div></td>
  </tr>
</table>
</div>
</div>
<div class="main">
<div class="cont_bg">
<div class="cont_bgl">
<div class="zx_xx" >
<span><a href="#">×</a></span>
访问动态
</div>
<div class="zxxx_nr">
<ul>
<c:forEach items="${erList}" var="log">
<li>${log.executeTime } ${log.employee.name}访问了你的日志</li>
</c:forEach>

</ul>
</div>
</div>
<div class="cont_bgr">
<div class="zx_xx" style="width:287px;" >
<span><a href="#">×</a></span>
优秀员工
</div>
<div class="zxxx_nr" style="width:292px; height:202px;">
<ul style="width:278px; margin:0 auto;">
       <li class="wrap"><img src="<%=path %>/potal/images/xy4.jpg" />
         <div>
		<h1><img src="<%=path %>/potal/images/gd_07.gif" style="float:left; margin-left:5px; margin-right:5px; margin-top:8px; width:14px;" /><a href="#"> 胥渊(优秀员工)</a></h1>
		<p>部门：技术部，职位：JAVA开发，因为工作兢兢业业，所以被评为４月份的优秀员工！</p>
	
	</div>
       </li>
       <li class="wrap" style="margin-right:0px;"><img src="<%=path %>/potal/images/whf4.jpg" style="height:176px;" />
         <div>
		<h1><img src="<%=path %>/potal/images/gd_07.gif" style="float:left; margin-left:5px; margin-right:5px; margin-top:8px; width:14px;" /><a href="#"> 王海飞(优秀员工)</a></h1>
		<p>部门：技术部，职位：WEB前端，因为工作表现突出，刻苦肯干，所以被评为４月份的优秀员工！</p>
	
	</div>
       </li>
     </ul>
</div>
</div>
</div>
</div>
