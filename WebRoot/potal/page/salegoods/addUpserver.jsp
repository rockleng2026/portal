<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>代客上架</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<style type="text/css">
body {
	width: 760px;
	margin: 0 auto;
	font-size: 12px;
	color: #333132
}

.1c {
	border-color: #cdcdcd;
}

dl,dd,dt,p,input {
	padding: 0px;
	margin: 0px;
}

.dow {
	width: 760px;
	height: 230px;
	float: left
}

.dow_top {
	width: 750px;
	height: 26px;
	background: #3c8301;
	padding-left: 10px;
	float: left;
	line-height: 26px;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	overflow: hidden
}

.dow_top span {
	float: right;
	padding-right: 10px;
	padding-top: 1px;
}

.dow_top a {
	color: #FFFFFF;
	font-size: 14px;
	font-weight: bold;
	text-decoration: none
}

.dow_nr {
	width: 758px;
	border: 1px solid #455c32;
	float: left
}

.tc_form {
	width: 750px;
	float: left;
	line-height: 23px;
}

.tc_form dd {
	width: 530px;
	float: left;
	text-align: right;
}

.tc_form dt {
	width: 210px;
	float: left;
	text-align: left;
	padding-left: 10px;
}

.tc_form dt span {
	width: 50px;
	float: right
}

.tc_form dt span a {
	width: 45px;
	float: left;
	text-align: center;
	color: #FFFFFF;
	text-decoration: none;
	height: 21px;
	background: #519300;
	line-height: 21px;
}

.text {
	height: 19px;
	border: 1px solid #b2b2b2
}

.foot {
	padding-right: 15px
}

.foot a {
	height: 24px;
	padding: 5px;
	text-decoration: none;
	color: #000000
}

}
.foot a:hover {
	background: #5da500;
	color: #FFFFFF
}

.tc_top {
	background: #7b7b7b;
	color: #FFFFFF
}

.tc_footb {
	border-bottom: 1px solid #c3c3c3
}

.tc_footb a {
	text-decoration: none;
	color: #ff9002;
}

.tc_footb a:hover {
	background: #5da601;
	float: left;
	width: 100%;
	color: #FFFFFF;
	line-height: 26px;
	clear: both;
}

.tc_rightb {
	border-right: 1px solid #c3c3c3
}

.ccc {
	text-align: center;
	width: 50px;
	line-height: 20px;
	float: right;
	background-color: #7b7b7b;
	color: #fff;
}

/*hongbinma */
ul,ul li {
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.foot1 {
	padding-right: 15px
}

.text1 {
	width: 145px;
	height: 19px;
	border: 1px solid #b2b2b2
}

.d1 {
	line-height: 20px;
}

.da {
	width: 794;
	margin-left: 30px;
	margin-right: 30px;
	margin-top: 10px;
	height: 600px;
}

.sp1 {
	float: left;
}

.sp2 {
	float: right;
	margin-right: 5px;
}

.sp3 {
	float: right;
	background-color: #7b7b7b;
	width: 50px;
	text-align: center;
	margin-left: 10px;
	line-height: 20px;
	color: #fff;
}

.sp4 {
	float: left;
	background-color: #7b7b7b;
	width: 50px;
	text-align: center;
	margin-left: 10px;
	line-height: 20px;
	color: #fff;
}

.sp5 {
	padding-left: 130px;
	float: left;
}

.sp6 {
	float: left;
}

.lb {
	height: 25px;
	border-bottom: 1px solid #295A00;
}

.lb li {
	text-align: center;
	font-size: 15px;
	margin-top: 1px;
	border: 1px solid #295A00;
	width: 115px;
	margin-left: 20px;
	padding: 5px 5px 3px 5px;
	border-bottom-width: 0px;
	position: relative;
	background-color: #fff;
	z-index: 1;
}

.msg {
	border: #FFDAAD 1px solid;
	line-height: 20px;
	background-color: #FFFBF2
}

.msgshow .c {
	background: url(images/c1.png) no-repeat 100px 0px;
	height: 7px;
	position: relative;
	margin-bottom: -1px;
	z-index: 1;
}

.tdyh {
	padding-right: 75px;
}

.tcolor {
	border: 1px solid #295a01;
	background-color: #eafed9;
}

.tdcolor {
	color: #3d3d3d;
	background-color: #bcbcbc;
	border: 1px;
	border-color: #999999;
	height: 28px;
	size: 14px;
}

.ta111 {
	margin-top: 10px;
	margin-left: 5px;
	margin-bottom: 10px;
	margin-right: 5px;
	border: 1px solid #bababa;
}

.btn {
	background-color: #50a806;
	color: #fff;
}

.zt {
	color: #295b02;
}

.zt2 {
	color: #F00;
}

.tbcenter {
	border: 1px solid #bababa;
	margin-top: 10px;
	margin-bottom: 10px;
	border-color: #295a01
}

.tdleft {
	padding-left: 40px;
}

.qc {
	padding-left: 25px
}

.yfd {
	width: 600px;
	float: right;
	line-height: 20px;
}

.yfd span {
	color: #fec2a8;
}

.gb_bt {
	background-color: #7a7a7a;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: auto;
	margin-right: 29px;
	float: right;
}

.gb_bt4 {
	background-color: #7a7a7a;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: 15px;
	margin-right: 29px;
	float: left;
}

.div_left {
	float: right;
	width: 100px;
}

.div_right {
	float: right;
	width: 100px;
}

.gb_bt2 {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 25px;
	text-align: center;
	float: right;
	margin-right: 30px;
}

.gb_bt3 {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 25px;
	text-align: center;
	float: left;
	margin-right: 30px;
}

.tc_bottom_top {
	margin-top: 25px;
	margin-bottom: 10px;
}

.ttx {
	size: 20px;
}

.tbbottom {
	margin-top: 13px;
}

.top1 {
	color: #3b8902;
}

.top2 {
	color: #fe6700;
}

.khmg {
	padding-top: 15px;
}

.top3 {
	margin-top: 7px;
	margin-bottom: 12px;
}

.qd {
	margin-top: 7px;
	margin-left: 5px;
	margin-bottom: 9px;
}

.qcc {
	width: 128px;
}

.main {
	width: 810px;
	margin: 0 auto;
}

.wzdh {
	line-height: 25px;
}

.wzls {
	color: #3b8801;
}

.wzcs {
	color: #ff6600;
}

.ltj {
	color: #3b8801;
	line-height: 25px;
	margin: 0 0 0 auto;
	width: 130px;
}

.rz_box .title {
	width: 85px;
	line-height: 25px;
	background-color: #4FA805;
	position: absolute;
	color: #fff;
	font-size: 13px;
	font-weight: bold;
	text-align: center;
}

.rz_box .list th {
	height: 35px;
	background-color: #EDEDED;
}

.gz_rz {
	line-height: 25px;
	padding-left: 5px;
}

.gz_rz p {
	line-height: 25px;
}

.gz_rz p span {
	color: #e0731e;
}

.gz_rz p span a {
	color: #e0731e;
}

.wbbd {
	width: 810px;
	border-bottom: 1px solid #c6c6c6;
	border-left: 1px solid #c6c6c6;
	border-right: 1px solid #c6c6c6;
	margin: auto auto 5px auto;
}

.ts_nr {
	border-top: 1px solid #c6c6c6;
	margin: 0 0 5px 0;
	line-height: 25px;
	padding-left: 5px;
}

.sc_fj {
	width: 770px;
	line-height: 30px;
	background-color: #ededed;
	padding-left: 10px;
	margin: 5px auto 5px 10px;
}

#an_bj {
	margin: 15px auto 90px auto;
}

.gb_bt {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: auto;
	margin-right: 20px;
}

.gb_btt {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: auto;
	margin-right: 20px;
}

#hssj {
	color: #abaaaa;
}

.hszt {
	color: #ff0000;
}

.hs_bt {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 25px;
	text-align: center;
}

.msg {
	border: #FFDAAD 1px solid;
	line-height: 40px;
	background-color: #FFFBF2
}

.msgshow .c {
	background: url(images/c1.png) no-repeat 100px 0px;
	height: 7px;
	position: relative;
	margin-bottom: -1px;
	z-index: 1;
}

.rz_box {
	border-top: 2px solid #4FA805;
}

.msg_green {
	border: #4FA805 1px solid;
	line-height: 20px;
	background-color: #FFF;
	width: 370px;
}

.msgshow_green .c2 {
	background: url(images/c2.png) no-repeat 100px 0px;
	height: 11px;
	position: relative;
	margin-bottom: -1px;
	z-index: 1;
}

#bg_ntc {
	padding-left: 5px;
}

.lm_ss {
	width: 790px;
	line-height: 40px;
	background-color: #eafed9;
	border: 1px solid #2a5800;
	text-align: center;
	color: #636b5c;
	font-size: 14px;
	font-weight: bold;
	margin: 0 auto 0 auto;
}

.cz_an {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 100px;
	line-height: 25px;
	text-align: center;
	margin: auto auto auto 15px;
}

.zj_lm {
	line-height: 40px;
	padding-left: 40px;
}

.tj_sp {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 90px;
	line-height: 25px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

.bd_bj {
	width: 745px;
	border: 1px solid #e2e2e2;
	margin-left: 5px;
	margin-bottom: 15px;
}

#tb_hg {
	line-height: 25px;
	margin-left: 20px;
	margin-right: 20px;
}

.xz_k {
	width: 240px;
	height: 280px;
	line-height: 25px;
	overflow-y: auto;
}

.xz_k ul {
	width: 200px;
	height: 20px;
	line-height: 20px;
}

.xz_k li a {
	width: 215px;
	height: 20px;
	line-height: 20px;
	color: #000000;
	text-decoration: none;
	display: block;
	padding-left: 5px;
}

.xz_k li a:hover {
	width: 215px;
	height: 20px;
	line-height: 20px;
	background-color: #eafed9;
	border: 1px solid #70ba0f;
}

.xz_k li span {
	float: right;
	margin-right: 5px;
}

.xz_wz {
	font-weight: bold;
}

.td_mag {
	margin-left: 5px;
}
.d2{z-index: 100004;position:absolute;left:13%;top:22%;}
.rcs{text-decoration: none;}
.xb_main { width:770px; padding-bottom:5px; padding-top:5px; background-color:#fff; margin:0 auto;}
.xb_sst { width:740px; line-height:25px; padding-left:15px; color:#df0909; background-color:#bebebe; margin:0 auto; font-size:12px; font-weight:bold}
.xb_ssbd { width:740px; padding-bottom:30px; margin:0 auto; border:1px solid #bebebe; padding-left:13px; border-top-width:0px;}
.xb_tdwz { line-height:30px; font-size:12px;}
.xb_ckgd { width:107px; line-height:22px; height:22px; background-color:#eafed9; border:1px solid #3c8301; color:#3b8401; text-align:center}
.xb_ckgd a { color:#3b8401; text-decoration:none}
</style>
	</head>
<script type="text/javascript"
			src="<%=basePath%>potal/js/jquery.min.js"></script>
<script type="text/javascript">
	function showDetailso()
	{
		if(document.getElementById("detailtop").style.display == 'none' && document.getElementById("detailnr").style.display == 'none' )
		{
			$("#detailtop").show();
			$("#detailnr").show();
			document.getElementById("detailtop").style.display == 'black';
			document.getElementById("detailnr").style.display == 'black';
		}
		else
		{
			$("#detailtop").hide();
			$("#detailnr").hide();
		}
		
	}

	<%--  一级显示	--%>
	function oneshow(obj,indexs)
	{
		var comm1 = encodeURI($("#comm1").val(),"utf-8");
		var comm2 = encodeURI($("#comm2").val(),"utf-8");
		var comm3 = encodeURI($("#comm3").val(),"utf-8");
		
		var soNum = $("#soNum").val();
		var upNo = $("#upNo").val();
		$("#showcommid").val(obj);
		$.ajax({
			type:"POST",
			url:"findCommsalegoods.do",
			data:{
				"commid":obj,
				"indexs":indexs,
				"comm1":comm1,
				"comm2":comm2,
				"comm3":comm3,
				"soNum":soNum,
				"upNo":upNo
			},
			success:function(data)
			{
				var num = data.indexOf("*");
				var num1= data.indexOf("?");
				var num2 = data.indexOf("$");
				
				var str1 = data.substring(0,num);
				var str2 = data.substring(num+1,num1);
				var str3 = data.substring(num1+1,num2);
				var str = data.substring(num2+1,data.length);
 
				
				$("#ls").empty();
				$("#twoComm").empty();
				$("#threeComm").empty();
				$("#oneComm").empty();
				
				$("#oneComm").html(str);
				$("#twoComm").html(str1);
				$("#threeComm").html(str2);
				if(str3 == "")
				{
					$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");
				}else
				{
					$("#ls").append(str3);
				}	
			}
		});
	} 	
	function twoshow(obj,indexs)
	{
		var comm2 = encodeURI($("#comm2").val(),"utf-8");
		
		$("#showcommid").val(obj);
		$.ajax({
			type:"POST",
			url:"findCommsalegoods.do",
			data:{
				"commid":obj,
				"indexs":indexs,
				"comm2":comm2
			},
			success:function(data)
			{
				var num = data.indexOf("?");
				var num1 =data.indexOf("$");
				var str1 =data.substring(0,num);
				var str2 =data.substring(num+1,num1);
				var str = data.substring(num1+1,data.length);

				$("#ls").empty();
				$("#twoComm").empty();
				$("#twoComm").html(str);
				$("#threeComm").empty();
				if(str1 != "")
				{
					$("#threeComm").html(str1);
				}
				else
				{
					$("#threeComm").html("<li><a href='javascript:void(0);' style='CURSOR:pointer;'><span>&gt;</span>无</a></li>");
				}
				
				if(str2 == "")
				{
					$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");
				}else
				{
					$("#ls").append(str2);
				}	
			}
		});
	}
	function threeshow(obj,indexs)
	{
	    
		var comm3 = encodeURI($("#comm3").val(),"utf-8");
		
		$("#showcommid").val(obj);
		$.ajax({
			type:"POST",
			url:"findCommsalegoods.do",
			data:{
				"commid":obj,
				"indexs":indexs,
				"comm3":comm3
			},
			success:function(data)
			{
				if(data != "")
				{
					var num = data.indexOf("`");
					var str = data.substring(0,num);
					var str1 = data.substring(num+1,data.length-1);
					$("#ls").empty();
					if(str1 != "")
					{
						$("#ls").append(str1);
					}
					else
					{
						$("#ls").empty();
						$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");
					}
					$("#threeComm").empty();
					$("#threeComm").html(str);
				}else
				{
					$("#ls").empty();
					$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");
				}
			}
		});
	}

	function onclickCur(obj)
	{
		var txtid = obj.id+"s";
		var txtvalue = $("#"+txtid).val();
		if(txtvalue <=1)
		{
			alert("亲，没货了不能在－了!");
			return false;
		}	
		else
		{
			var values = txtvalue-1;
			$("#"+txtid).empty();
			$("#"+txtid).val(values);
		}
	}

	function onclickadd(obj)
	{
		var str = obj.id;
		var txtid = str.substring(0,str.length-1);
		var txtids = str.substring(0,str.length-2);
		var txtvalue = $("#"+txtid).val();
		var hiddzongid = txtids+"zong";
		
		var hiddzongvalue = $("#"+hiddzongid).val();
	
		var txtid = str.substring(0,str.length-1);
		if(Number(txtvalue) >= Number(hiddzongvalue))
		{
			alert("亲，只有这么些了不能在＋了!");
			return false;
		}
		else
		{
			var newvalue = Number(txtvalue)+1;
			$("#"+txtid).empty();
			$("#"+txtid).val(newvalue);
			alert(newvalue);
		}
	}


	function addupsalegood()
	{
		var obj = document.getElementsByName("checkbox");
		var strTemp="";
		var strid  ="";
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)
			{
				var checkid = obj[i].id;
				var txtid = checkid.substring(0,checkid.length-2);
				var str = checkid.substring(0,checkid.length-3);
				var str5 = str.substring(3,str.length);
				var txtnameid = str+"name";
				var depotname = str+"dept";
			
				var depottxt = $("#"+depotname).val();
				var txtvalue = $("#"+txtid).val();
				var txtname = $("#"+txtnameid).val();
				strTemp+="<tr id='"+str+"trs'><td><input type='checkbox' value='"+str5+"'  name='checkbox2' id='"+str+"newid'/><label for='checkbox2'></label></td><td>"+txtname+"</td><td>"+depottxt+"</td><td align='center'><img src='<%=request.getContextPath()%>/potal/images/ss_-.png' id='"+str+"imgs' onclick='javascript:curTxt(this);' style='CURSOR:pointer;' width='11' height='11' /><input name='"+str+"' type='text' id='"+str+"txt' value='"+txtvalue+"' size='2' width='25px' />&nbsp;<img src='<%=request.getContextPath()%>/potal/images/ss_x.png' style='CURSOR:pointer;' id='"+str+"img' onclick='hidesg(this);' width='13' height='13'/></td></tr>";
				var values = obj[i].value;
				strid +=values+",";
			
			}
		}
		
		$("#tabupsalegood").empty();
		$("#tabupsalegood").html(strTemp);
	
	}

	function curTxt(obj)
	{
		var s = obj.id;
		var t = s.substring(0,s.length-4);
		var txt = t+"txt";
		var txtvalue = $("#"+txt).val();
		if(txtvalue<=1)
		{
			alert("亲，不能在－了!");
			return false;
		}
		var values = txtvalue-1;
		$("#"+txt).empty();
		$("#"+txt).val(values);
	}
	
	function hidesg(obj)
	{
		var imgid = obj.id;
		var trid = imgid.substring(0,imgid.length-3)+'trs';
		var hid = "#"+trid;
		$(hid).remove();
		var tableid = document.getElementById("tabupsalegood");
		var num = tableid.getElementsByTagName("tr").length;
		if(num <= 0)
		{
			$("#tabupsalegood").html("<tr><td>无要上架的物品</td></tr>");
		}
	}

	
	
	function onsumbitupser()
	{
		var obj = document.getElementsByName("checkbox2");
		var allid = new Array();
		var falg = false;
		var strTemp="";
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked)
			{
				var checkvalue = obj[i].value;
				strTemp += checkvalue+",";
			}			
		}
		if(strTemp.length>0)
		{
			falg = true;
		}
		if(!falg)
		{
			alert("请选择要上架的物品!");
			return false;
		}
		$("#proids").val(strTemp);
		form1.action = "<%=request.getContextPath()%>/addUpserverSalegoodssalegoods.do";
		form1.submit();
	}

	function addrow()
	{
<%--		 $("#addrow").load("<%=request.getContextPath()%>/pdm/addRCUIsalegoods.do");--%>
<%--		 $("#addrow").css("display","block");--%>
<%--			showWindwoButton('id','历史记录列表','500','550',"pdm/addRCUIsalegoods.do");--%>
			  $("#myFrames").attr("src","<%=request.getContextPath()%>/addRCUIsalegoods.do?demo=rc");
			  var load=$("#addrow");
			  var width=load.width();
			  var height=load.height();
			  var left=(screen.width-width)/2+document.documentElement.scrollLeft;
			  var top=(screen.height-height)/2+document.documentElement.scrollTop-150;
			 $("#addrow").css({"display":"block","top":top});
						
<%--			$("#addrow").css("display","block");--%>
	}
	
	function yingcang()
	{
		 $("#addrow").css("display","none");
	}

	function showpro()
	{
		var comm1 = encodeURI($("#comm1").val(),"utf-8");
		var comm2 = encodeURI($("#comm2").val(),"utf-8");
		var comm3 = encodeURI($("#comm3").val(),"utf-8");

		var commid = $("#showcommid").val();
		$.ajax({
				type:"POST",
				url:"selectAllsalegoods.do",
				data:{
					"commid":commid,
					"comm1":comm1,
					"comm2":comm2,
					"comm3":comm3
				},
				success:function(data)
				{
					$("#ls").empty();
					if(data != "")
					{
						$("#ls").append(data);
					}
					else
					{
						$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");	
					}
					
				}
			});
		
<%--		$("#addrow1").load("<%=request.getContextPath()%>/pdm/addRCUIsalegoods.do?");--%>
<%--		 $("#addrow1").css("display","block");--%>
	}
	function checkpro()
	{
		var txtpro = $("#txtpro").val();
		var txtpro1 = encodeURI(txtpro,"utf-8");
		$.ajax({
			type:"POST",
			url:"findCommRCsalegoods.do",
			data:{"rcname":txtpro1},
			success:function(data)
			{
				$("#bd_bj").hide();
				$("#tablb").empty();
				$("#tablb").html(data);
				$("#tablb").show();
			}
		});
	}
	function hideproshowtype()
	{
		$("#tablb").hide();
		$("#bd_bj").show();
	}
	function checkfindpro(obj)
	{
		$.ajax({
			type:"POST",
			url:"findprosalegoods.do",
			data:{"commid":obj},
			success:function(data)
			{
				var num = data.indexOf("`");
				var str = data.substring(0,num);
				var str1 = data.substring(num+1,data.length);
				$("#showcommid").val(str1);
				$("#ls").empty();
				if(str != "")
				{
					$("#ls").append(str);
				}
				else
				{
					$("#ls").append("<li><table width='100%' border='0' cellspacing='8' cellpadding='0'><tr><td>查无物品</td></tr></table></li>");	
				}
			}
		});
	}
	function selectallcomm()
	{
		var txtpro = $("#txtpro").val();
		var txtpro1 = encodeURI(txtpro,"utf-8");
		$.ajax({
			type:"POST",
			url:"findCommRCsalegoods.do",
			data:{"rcname":txtpro1,"demo":"1"},
			success:function(data)
			{
				$("#bd_bj").hide();
				$("#tablb").empty();
				$("#tablb").html(data);
				$("#tablb").show();
			}
		});
	}
</script>
	<body>
	<form action="" method="post" id="form1">
		<div class="d1">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<span class="top1">您的位置</span>：<a>首页&gt;
						<span class="top2">代客写上架单</span>
					</td>
				</tr>
			</table>
			
			<input type="hidden" id="proids" name="proids" value=""/>
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="top3">
				<tr>
					<td width="40%">
						<span class="top3"><span class="sp1">上架单号： <input name="upNos" id="upNo" type="text" readonly="readonly" value="${usNum}" /></span>
						</span>
					</td>
					<td width="60%">
						<a><span class="gb_bt" onclick="javascript:showDetailso();" style="CURSOR:pointer;">详情 <img src="<%=request.getContextPath()%>/potal/images/ss_c1.png" width="10" height="13" border="0" /> </span> </a>
						<span class="sp2">订单编号： <input name="soNum" id="soNum" type="text" value="${soNum}" />
						</span>
					</td>
				</tr>
			</table>

			<div class="top3"></div>
		</div>
		<div class="dow">
			<div class="dow_top" id="detailtop" style="display: none;">
				订单详情
			</div>
			<div class="dow_nr" id="detailnr" style="display: none;">
				<div class="lb">
					<ul>
						<li>
							订单信息
						</li>
					</ul>
				</div>
				<div class="c">
					<p>
						&nbsp;
					</p>
				</div>
				<table width="100%" border="0">
					<tr>
						<td width="14%" rowspan="2" class="tdleft">
							<img src="<%=request.getContextPath()%>/potal/images/ss_c2.png" alt="" width="52" height="52"
								border="1">
						</td>
						<td colspan="2" class="zt">
							${smg.sale_goods.sgname}
						</td>
						<td colspan="2">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="34%">
							<span class="sp1">保障<img src="<%=request.getContextPath()%>/potal/images/ss_bz.png" width="15"
									height="13" />
							</span>
						</td>
						<td width="17%" align="center">
							${smg.soOrderNumber}
						</td>
						<td width="26%" align="right" class="tdyh">
							无优惠：
						</td>
						<td width="9%" align="left" class="zt2">
							￥${smg.sale_orders.sgPrice}
						</td>
					</tr>
					<tr>
						<td colspan="3" class="tdleft khmg">
							<span class="sp6">客户姓名：${smg.sale_orders.customer.customerName}</span>
							<span class="sp5">客户公司：${smg.sale_orders.customer.customerCompany}</span>
						</td>
						<td colspan="2" align="center" class="khmg">
							客户电话：${smg.sale_orders.customer.mobilePhone}
						</td>
					</tr>
				</table>

				<div class="lb">
					<ul>
						<li>
							商品属性
						</li>
					</ul>
				</div>
				<table width="100%" border="0" cellspacing="8" cellpadding="0">
					<tr>
						<td class="qc">
							名称：${smg.sale_goods.sgname}
						</td>
						<td>
							价格：￥${smg.sale_goods.sgPrice}
						</td>
						<td>
							库存:${smg.sale_goods.sgInventory}
						</td>
					</tr>
					
				</table>
			</div>
			<p>
				&nbsp;
			</p>
			<div class="dow">
				<div class="dow_top">
					库存信息
				</div>
				<div class="dow_nr">
					<table width="99%" border="0" align="center" class="tcolor"
						cellspacing="0" cellpadding="0">
						<tr>
							<td width="60%" height="50" align="right">
								<span class="ttx">资 源 查 询&nbsp;&nbsp;&nbsp;</span>
								<input name="input2" type="text" id="txtpro" />
							</td>
							<td width="40%" align="left">
								<span class="gb_bt4"><a href="javascript:void(0)" onclick="checkpro();" style="text-decoration: none;color: white;">搜索</a></span>
							</td>
						</tr>
					</table>
					
<div class="xb_main" style="display: none;" id="tablb">
<div class="xb_sst">
您搜索的结果如下：（找到10条相关匹配项）
</div>
<div class="xb_ssbd">
  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="xb_tdwz">1、商品/服务器</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="xb_tdwz">2、商品/VPS服务器</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="xb_tdwz">3、商品/服务器/客户服务器</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="xb_tdwz">4、商品/服务器/公司服务器</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="xb_tdwz"><div class="xb_ckgd"><a href="#">点击查看更多</a></div></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="xb_tdwz">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
</div>
<!-- <div class="lb" id="lb1" style="display: none;">-->
<!--      <ul>-->
<!--        <div class="yfd">（<span><a href="javascript:void(0);" onclick="hideproshowtype();" style="text-decoration: none;color: black;">重新搜索</a></span>）</div>-->
<!--      </ul>-->
<!--    </div>-->
<!--	<table width="100%" border="0" style="display: none;" id="tablb">-->
<!--          <tr>-->
<!--            <td colspan="2"><table width="100%" border="0" cellspacing="8" cellpadding="0" id="tabcomm">-->
<!--              <tr>-->
<!--                <td><input type="checkbox" name="checkbox" id="checkbox" />-->
<!--                  <label for="checkbox"></label></td>-->
<!--                <td>联想服务器</td>-->
<!--                <td>可用3台</td>-->
<!--                <td>冻结2台</td>-->
<!--                <td align="center"><label for="textfield"></label>-->
<!--                  <img src="images/ss_-.png" width="11" height="11" />-->
<!--                <input name="textfield" type="text" id="textfield10" size="2" width="25px"/>                  <img src="images/ss_+.png" width="11" height="11" /></td>-->
<!--              </tr>-->
<!--            </table></td></tr></table>-->
					<div class="bd_bj" id="bd_bj">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" >
						<input type="hidden" id="showcommid" name="showcommid" value="${commids}"/>
							<tr>
								<td width="33%">
									<div class="xz_k">
										<label>
											<input type="text" name="textfield2" value="${comm1}" onchange="oneshow('','1');" size="30" id="comm1"/>
										</label>
										<ul id="oneComm">
											<c:if test="${oneCommtype != null}">
												<c:forEach items="${oneCommtype}" var="oneCommtype">
													<li>
														<a href="javascript:void(0);" style="CURSOR:pointer;" onclick="javascript:oneshow('${oneCommtype.id}','1');"><span>&gt;</span> ${oneCommtype.typeName}</a>
													</li>
												</c:forEach>
											</c:if>
											<c:if test="${oneCommtype == null}">
												<a href="javascript:void(0);" style="CURSOR:pointer;"><span>&gt;</span>无</a>
											</c:if>
										</ul>
									</div>

								</td>
								<td width="33%" class="td_mag">
									<div class="xz_k">
										<label>
											<input type="text" name="textfield2" onchange="twoshow('','2');" size="30" id="comm2" />
										</label>
										<ul id="twoComm">
											<c:if test="${twoCommList != null}">
												<c:forEach items="${twoCommList}" var="twoCommtype">
													<li>
														<a href="javascript:void(0);" style="CURSOR:pointer;" onclick="javascript:twoshow('${twoCommtype.id}','2');"><span>&gt;</span>${twoCommtype.typeName}</a>
													</li>
												</c:forEach>
											</c:if>
											<c:if test="${twoCommList == null}">
												<li>
													<a href="javascript:void(0);" style="CURSOR:pointer;"><span>&gt;</span>无</a>
												</li>
											</c:if>
										</ul>
									</div>
								</td>
								<td width="33%" class="td_mag">
									<div class="xz_k">
										<label>
											<input type="text" name="textfield2" onchange="threeshow('','3');" size="30" id="comm3"/>
										</label>
										<ul id="threeComm">
											<c:if test="${threeCommtype != null}">
												<c:forEach items="${threeCommtype}" var="threeCommtype">
													<li>
														<a href="javascript:void(0);" style="CURSOR:pointer;" onclick="javascript:threeshow('${threeCommtype.id}','3');"><span>&gt;</span>${threeCommtype.typeName}</a>
													</li>
												</c:forEach>
											</c:if>
											
											<c:if test="${threeCommtype == null}">
												<li>
													<a href="javascript:void(0);" style="CURSOR:pointer;"><span>&gt;</span>无</a>
												</li>
											</c:if>
										
										</ul>
									</div>
								</td>
							</tr>
						</table>
					</div>




					<div class="lb">
						<ul>
							<div class="yfd">
								<span>注：</span>（如没有您的商品，请填写
								<span><a href="javascript:addrow();" class="rcs" style="color: red;">资源审查</a></span>）
								<div class="gb_bt" style="CURSOR:pointer;" style="margin-top: -20px;">
									<span onclick="javascript:addupsalegood();" >添加</span>
								</div>
							</div>
							<li>
								库存货物
							</li>
						</ul>
					</div>
					
					<table width="100%" border="0">
          <tr>
            <td >
			<style type="text/css">
			 #ls li{ float:left;width:50%;}
			</style>
			<ul id="ls">
			<c:if test="${map != null}">
			<c:forEach items="${map}" var="pro">
			<c:forEach items="${pro.value}" var="mappro">
			<input type='hidden' id='pro${mappro.id}zong' value='${pro.key}'/>
									<input type='hidden' id='pro${mappro.id}name' value='${mappro.property.name}'/>
									<input type='hidden' id='pro${mappro.id}dept' value='${mappro.depot.name}'/>
									<input type='hidden' id='pro${mappro.id}id' value='${mappro.id}'/>
			<li>
				<table width="100%" border="0" cellspacing="8" cellpadding="0">
	              <tr>
	                <td><input type="checkbox" name="checkbox" value="${mappro.id}" id="pro${mappro.id}sss" />
	                  <label for="checkbox"></label></td>
	                <td>
							${mappro.property.name}
										</td>
										<td>
											可用${pro.key}台
										</td>
										<td>
											￥${mappro.depot.name}
										</td>
	               <td align="center">
											<label for="textfield"></label>
											<img src="<%=basePath%>potal/images/ss_-.png" id="pro${mappro.id}"  style="CURSOR:pointer;" width="11" height="11" onclick="onclickCur(this);" />
								<input name="textfield" value="1" type="text" id="pro${mappro.id}s" size="2" width=25px />
								<img src="<%=basePath%>potal/images/ss_+.png" id="pro${mappro.id}ss" style="CURSOR:pointer;" onclick="onclickadd(this);" width="11" height="11" />
										</td>
	              </tr>
				  </table>
			  </li>
			  </c:forEach>
			  </c:forEach>
			  </c:if>
			  <c:if test="${map == null}">
			  	<li>
			  		<table width="100%" border="0" cellspacing="8" cellpadding="0">
			  			<tr><td>查无物品</td></tr>
			  		</table>
			  	</li>
			  </c:if>
			  </ul>
			 </td> 
          </tr>
</table>
<table width="100%" border="0" cellspacing="8" cellpadding="0" id="showall">
	<tr>
		<td><span class="sp2"><a href="javascript:showpro();" style="text-decoration: none;color: red;">更多 </a><strong>>>></strong></span> &nbsp;</td>
	</tr>
</table>
					
<%--					<table width="100%" border="0">--%>
<%--						<tr>--%>
<%--							<td colspan="2">--%>
<%--								<table width="100%" border="0" cellspacing="8" cellpadding="0" id="tabid">--%>
<%--									<c:if test="${pages != null}">--%>
<%--									<c:forEach  items="${pages.pageList}" var="promap">--%>
<%--									<input type='hidden' id='pro${promap.id}zong' value=''/>--%>
<%--									<input type='hidden' id='pro${promap.id}name' value='${promap.property.name}'/>--%>
<%--									<tr>--%>
<%--										<td>--%>
<%--											<input type="checkbox" name="checkbox" value="${promap.id}" id="pro${promap.id}sss" />--%>
<%--											<label for="checkbox"></label>--%>
<%--										</td>--%>
<%--										<td>--%>
<%--											${promap.property.name}--%>
<%--										</td>--%>
<%--										<td>--%>
<%--											可用111台--%>
<%--										</td>--%>
<%--										<td>--%>
<%--											￥${promap.depot.name}--%>
<%--										</td>--%>
<%--										<td align="center">--%>
<%--											<label for="textfield"></label>--%>
<%--											<img src="<%=basePath%>potal/images/ss_-.png" id="pro${promap.id}"  style="CURSOR:pointer;" width="11" height="11" onclick="onclickCur(this);" />--%>
<%--								<input name="textfield" value="1" type="text" id="pro${promap.id}s" size="2" width=25px />--%>
<%--								<img src="<%=basePath%>potal/images/ss_+.png" id="pro${promap.id}ss" style="CURSOR:pointer;" onclick="onclickadd(this);" width="11" height="11" />--%>
<%--										</td>--%>
<%--									</tr>--%>
<%--									</c:forEach>--%>
<%--									<tr>--%>
<%--										<td><pp:pages1 url="addUpserversalegoods.do" param="soNum=${soNum}&usNums=${usNum}&openmethod=1"/></td>--%>
<%--									</tr>--%>
<%--									</c:if>--%>
<%--								</table>--%>
<%--							</td>--%>
<%--						</tr>--%>
<%--					</table>--%>
					<div class="lb">
						<ul>
							<li>
								上架物品
							</li>
						</ul>
					</div>
					<table width="45%" border="0" class="tbbottom">
						<tr>
							<td colspan="2">
								<table width="100%" border="0" cellspacing="8" cellpadding="0" id="tabupsalegood">
									<tr>
										<td>无要上架的物品</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tc_bottom_top">
						<tr>
							<td align="right">

								<div class="gb_bt2">
									<span style="CURSOR:pointer;" onclick="javascript:onsumbitupser();">确认</span>
								</div>
							</td>
							<td>
								<div class="gb_bt3">
									<span style="CURSOR:pointer;" onclick="javascript:quxiao();">取消</span>
								</div>
							</td>
						</tr>
					</table></div></div></div>
					<div id="addrow" class="d2" style="display: none;">
						<iframe frameborder="0"  marginheight="0" marginwidth="0" id="myFrames" src="" style="width:582px;height:430px;"></iframe>
					</div> 
					
					</form>
					<script type="text/javascript">
						function quxiao()
						{
							window.location.href = "<%=basePath%>selectsordersalegoods.do";
						}
					</script>
	</body>
</html>

