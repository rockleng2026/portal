<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<meta http-equiv="x-ua-compatible" content="ie=7" />

		<link type="text/css" rel="stylesheet"
			href="<%=request.getContextPath()%>/potal/css/index2.css" />
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>potal/css/goods.css" />
		<style type="text/css">
body {
	width: 760px;
	margin: 0 auto;
	font-size: 12px;
	background-color: #FFFFFF
}

img {
	border: 0
}

.tp1 {
	border: 1px solid #CCC;
	margin-top: 3px;
	margin-bottom: 4px;
}

.centerl {
	padding-bottom: 5px;
	margin-top: 5px;
}

ul {
	list-style-type: none;
}

dl,dd,dt,p,input {
	padding: 0px;
	margin: 0px;
}

.dow {
	width: 760px;
	height: 230px;
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
	overflow: hidden;
	margin: auto;
}

.dow_top span {
	float: right;
	padding-right: 10px;
	padding-top: 1px;
}

.dow_top a {
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	text-decoration: none
}

.tc_footb {
	border-bottom: 1px solid #c3c3c3
}

.tc_footb a {
	text-decoration: none;
	color: #295a00;
}

.tc_footright
.tc_top {
	background: #7b7b7b;
	color: #FFFFFF
}

.sp_nav_tab {
	border-bottom: 1px solid #295A00;
	height: 26px;
}

.sp_nav_tab .nomarl {
	width: 95px;
	line-height: 25px;
	border: 1px solid #295A00;
	border-bottom-width: 0;
	background-color: #EAFED9;
}

.sp_nav_tab  li {
	float: left;
	text-align: center;
	margin-left: 3px;
}

.sp_nav_tab    .sq {
	width: 8px;
	height: 8px;
	background-color: #295A00;
	margin-top: 9px;
}

.sp_nav_tab .active {
	background-color: #fff;
	width: 95px;
	line-height: 25px;
	border: 1px solid #295A00;
	border-bottom-width: 0;
	position: relative;
	margin-top: 1px;
}

.top {
	line-height: 30px
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
	font-size: 12px;
	font-weight: bold;
	text-decoration: none
}

.dow_nr {
	width: 758px;
	border: 1px solid #455c32;
	float: left
}

.lbdx {
	width: 130px;
}

.tabtop {
	margin-top: 5px;
	color: #6d696a
}

.gb_btss {
	background-color: #50a806;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-right: 40px;
}
.gb_bts {
	background-color: #50a806;
	font-weight: bold;
	color: #fff;
	width: 70px;
	line-height: 20px;
	text-align: center;
	margin-right: 40px;
}

.gb_bt2 {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 75px;
	line-height: 20px;
	text-align: center;
	margin-right: 20px;
	float: right;
}

.gb_btle {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 60px;
	line-height: 20px;
	text-align: center;
	margin-left: 10px;
	float: left;
}

.gb_btri {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: 10px;
	float: left;
}

.td_color {
	background-color: #eafed9;
	margin-top: 5px;
}

.td_top_color {
	background-color: #626262;
	font-size: 12px;
	color: #fff;
	text-align: center;
	height: 21px;
}

.tdborder {
	border: 1px solid #b2b2b2
}

.tdborbern {
	border-bottom: 1px solid #ededed;
	border-right: 1px solid #ededed
}

.tdborbernn {
	border-bottom: 1px solid #ededed;
}

.tdbordernnn {
	border-right: 1px solid #ededed;
}

.tdborderright {
	border-right: 1px solid #fff;
}

.div_top {
	line-height: 10px;
}

.lv {
	color: #388900;
}

.ju {
	color: #fe6700
}

.hui {
	color: #6d696a
}

.hong {
	color: #fe0000
}

.qlv {
	color: #62ac00
}

.hei {
	color: #000
}

.td_center {
	background-color: #fff3c3;
	padding-left: 10px;
}

.tdtd {
	margin-left: 30px;
}

.tdbottom {
	margin-top: 30px;
	margin-bottom: 15px;
}

.tdmaleft {
	margin-left: 6px;
}

.hongbottom {
	color: #F00;
	font-size: 12px;
}

.tdcen {
	margin-bottom: 5px;
}

.d2 {
	z-index: 100004;
	position: absolute;
	left: 15%;
	top: 22%;
}

.gray {
	text-decoration: none;
	list-style-type: none;
}
</style>
		<script type="text/javascript"
			src="<%=basePath%>potal/js/jquery.min.js"></script>
		<script type="text/javascript">
		function clickcut()
		{
			var count = $("#count").val();
			var sprice = $("#sprice").val();
			var money =  $("#moneys").text();
			var delivprice = $("#delivprice").val();
			if(count == "1")
			{
				alert("亲，不能在－了!");
				return false;
			}else
			{
				var num = count-1;
				$("#count").val(num);

				var sprice = $("#sprice").val();
				var sprices1 = Number(money)-Number(sprice);
				var sprices = Number(money)-Number(sprice)+Number(delivprice);
				$("#moneys").empty();
				$("#summoney").empty();
				$("#paymoney").empty();
				$("#moneys").text(sprices1);
				$("#summoney").text(sprices);
				$("#paymoney").text(sprices);
				
			}
		}
		function clickadd()
		{
			var count = $("#count").val();
			var sgInventory = $("#sgInventory").val();
			var money =  $("#moneys").text();
			var delivprice = $("#delivprice").val();
			if(Number(count) >= Number(sgInventory))
			{
				alert("亲，不能在＋了!");
				return false;	
			}
			else
			{
				var num = Number(count) +1;
				$("#count").val(num);
				var sprice = $("#sprice").val();
				var sprices1 = Number(money)+Number(sprice);
				var sprices = Number(money)+Number(sprice)+Number(delivprice);
				$("#moneys").empty();
				$("#summoney").empty();
				$("#paymoney").empty();
				$("#moneys").text(sprices1);
				$("#summoney").text(sprices);
				$("#paymoney").text(sprices);
			}
		}

		function onclickshow()
		{
			var allradio = document.getElementsByName("radio");
			
			for(var i =0;i<allradio.length;i++)
			{
				if(allradio[i].checked)
				{
					var radio = allradio[i].value;
					if(radio== "wu")
					{
						$("#ress").empty();
						$("#ress").text("无");
						$("#finaladdress").val("无");
					}
					else if(radio == "noaddress")
					{
						$("#ress").empty();
						$("#ress").text("无收获地址!");
						$("#finaladdress").val("无收获地址");
					}
					else if(radio == "radio")
					{
						$("#ress").empty();
						var txt = $("#address2").val();
						$("#ress").text(txt);
						$("#finaladdress").val(txt);
					}
					else
					{
						$("#ress").empty();
						$("#ress").text(radio);
						$("#finaladdress").val(radio);
					} 
				}	
			}
		}

		function onchangsotype()
		{
			var obj = document.getElementById("changsotype");
			var index = obj.selectedIndex;

			var summoney = $("#moneys").text();
			if(index != "0")
			{
				var value = obj.options[index].text;
				$("#sotype").val(value);
				if(index== "1")
				{
					$("#delivprice").val("20");
					$("#delprice").text("20.0");

					$("#summoney").empty();
					$("#paymoney").empty();
					var sprices = Number(summoney)+Number(20);
					$("#summoney").text(sprices);
					$("#paymoney").text(sprices);
				}
				if(index== "2")
				{
					$("#delivprice").val("30");
					$("#delprice").text("30.0");

					$("#summoney").empty();
					$("#paymoney").empty();
					var sprices = Number(summoney)+Number(30);
					$("#summoney").text(sprices);
					$("#paymoney").text(sprices);
				}
				if(index== "3")
				{
					$("#delivprice").val("40");
					$("#delprice").text("40.0");

					$("#summoney").empty();
					$("#paymoney").empty();
					var sprices = Number(summoney)+Number(40);
					$("#summoney").text(sprices);
					$("#paymoney").text(sprices);
				}
			}else
			{
				$("#delivprice").val("0");
				$("#delprice").text("0.0");

				$("#summoney").empty();
				$("#paymoney").empty();
				var sprices = Number(summoney)+Number(0);
				$("#summoney").text(sprices);
				$("#paymoney").text(sprices);
			}
		}

<%--		function onsubmitso()--%>
<%--		{--%>
<%--			alert("aaa");--%>
<%--			form1.action ="<%=request.getContextPath()%>/pdm/addsaleordersalegoods.do";--%>
<%--			$("#form1").attr("action","pdm/addsaleordersalegoods.do");--%>
<%--			form1.submit();--%>
<%--		}--%>

	function newaddress()
	{
		var cusid = $("#cusid").val();
		if(cusid == "")
		{
			alert("请选择客户");
			return ;
		}
<%--		 $("#addrow").load("<%=request.getContextPath()%>/potal/page/salegoods/newaddress.jsp?cusid="+cusid);--%>
		$("#myFramenewaddress").attr("src","<%=request.getContextPath()%>/potal/page/salegoods/newaddress.jsp?cusid="+cusid);
		 var load=$("#addrow");
		  var width=load.width();
		  var height=load.height();
		  var left=(screen.width-width)/2+document.documentElement.scrollLeft;
		  var top=(screen.height-height)/2+document.documentElement.scrollTop-180;
		 $("#addrow").css({"display":"block","top":top});
	}
	function yingcangs()
	{
		 $("#addrow").css("display","none");
	}	

	function showCur()
	{
		$("#myFrames").attr("src","<%=request.getContextPath()%>/selectCussalegoods.do");
		$("#addrow1").css("display","block");
	}
	function yingcangs1()
	{
		 $("#addrow1").css("display","none");
	}

	function showEmp()
	{
<%--		 $("#addrow2").load("<%=request.getContextPath()%>/pdm/selectEmpsalegoods.do");--%>
		 $("#addrow2").css("display","block");
	}
	function yingcangs2()
	{
		 $("#addrow2").css("display","none");
	}
	function yingcangs3()
	{
		 $("#addrow3").css("display","none");
	}		
	function yingcangall()
	{
		 $("#addrow1").css("display","none");
		 $("#addrow2").css("display","none");
		 $("#addrow3").css("display","none");
		 $("#addrow").css("display","none");
	}

	function btnclick(obj)
	{
		var cusname = $("#cusname").val();
		if(cusname == "")
		{
			alert("客户不能为空!");
			return ;
		}
		var ress = $("#ress").html();
		if(ress == "")
		{
			alert("收获地址不能为空!");
			return ;
		}
		$("#statchang").val(obj);
		var divsg = $("#divsg").html();
		$("#divsgs").val(divsg);
		form1.submit();
	}
	function defaultaddress(obj,cusid)
	{
		var address = obj;
		var cusids = cusid;
		$.ajax({
			  type:"POST",
			  url:"defaultAddresssalegoods.do",
			  data:{"addressid":address,"cusid":cusids},
			  success:function(data)
			  {
				  if(data == "1")
				  {
					alert("设置成功!");
				   }
				  else
				  {
					  alert("设置失败!");
				  }
	          }
			});	
	}
	function changaddress(addressid,cusid)
	{
		$("#myFrameaddress").attr("src","<%=request.getContextPath()%>/updateaddressUIsalegoods.do?addressid="+addressid+"&cusid="+cusid);
		 var load=$("#addrow3");
		  var width=load.width();
		  var height=load.height();
		  var left=(screen.width-width)/2+document.documentElement.scrollLeft;
		  var top=(screen.height-height)/2+document.documentElement.scrollTop-180;
		 $("#addrow3").css({"display":"block","top":top});
	}

	function changtxt()
	{
		var count = $("#count").val();
		var delivprice = $("#delivprice").val();
		if(isNaN(count))
		{
			alert("请输入数字!");
			$("#count").val('1');
			var sprice = $("#sprice").val();
			var sprices = Number(sprice) * Number(1);
			var sprices1 = Number(sprices)+Number(delivprice);
			$("#moneys").empty();
			$("#summoney").empty();
			$("#paymoney").empty();
			$("#moneys").text(sprices);
			$("#summoney").text(sprices1);
			$("#paymoney").text(sprices1);
			return ;
		}
		var sgInventory = $("#sgInventory").val();
		var money =  $("#moneys").text();
		if(Number(count) > Number(sgInventory))
		{
			alert("亲，没有那么多货了!");
			$("#count").val(sgInventory);
			var sprice = $("#sprice").val();
			var sprices = Number(sprice) * Number(sgInventory);
			var sprices1 = Number(sprices)+Number(delivprice);
			$("#moneys").empty();
			$("#summoney").empty();
			$("#paymoney").empty();
			$("#moneys").text(sprices);
			$("#summoney").text(sprices1);
			$("#paymoney").text(sprices1);
			return ;	
		}
		else if(Number(count) < 1)
		{
			alert("亲，最起码要一件商品!");
			$("#count").val('1');
			var sprice = $("#sprice").val();
			var sprices = Number(sprice) * Number(1);
			var sprices1 = Number(sprices)+Number(delivprice);
			$("#moneys").empty();
			$("#summoney").empty();
			$("#paymoney").empty();
			$("#moneys").text(sprices);
			$("#summoney").text(sprices1);
			$("#paymoney").text(sprices1);
			return ;	
		}
		else{
			var num = Number(count);
			$("#count").val(num);
			var sprice = $("#sprice").val();
			var sprices = Number(sprice) * Number(num);
			var sprices1 = Number(sprices)+Number(delivprice);
			$("#moneys").empty();
			$("#summoney").empty();
			$("#paymoney").empty();
			$("#moneys").text(sprices);
			$("#summoney").text(sprices1);
			$("#paymoney").text(sprices1);
		}	
	}
	</script>
	</head>

	<body style="background-color: #ffffff;">

		<%--		<div class="middlebox">--%>
		<%--			<div class="middtop">--%>
		<%--				<span>您的位置<a class="gray" href="<%=basePath %>potal/page/desk.jsp">：首页</a>><a href="#"--%>
		<%--					class="javascript:void(0);">填写销售订单</a>--%>
		<%--				</span>--%>
		<%--			</div>--%>
		<div class="dow">
			<div class="div_top">
				<p>
					&nbsp;
				</p>
				<p>
					<span class="lv">您的位置</span><span class="hui">：<a
						class="gray" href="<%=basePath%>potal/page/desk.jsp">：首页</a>></span><span
						class="ju">填写销售订单</span>
				</p>

				<p>
					&nbsp;
				</p>
			</div>
			<div class="dow_top">
				<span><a href="#"></a>
				</span> 填写销售订单
			</div>
			<form action="<%=basePath%>addsaleordersalegoods.do"
				method="post" id="form1">
				<input type="hidden" name="orders.soNums" value="${sgnum}" />
				<input type="hidden" name="sotype" id="sotype" value="" />
				<input type="hidden" name="finaladdress" id="finaladdress" value="" />
				<input type="hidden" name="delivprice" id="delivprice" value="">
				<input type="hidden" name="statchang" id="statchang" value=""/>
				<input type="hidden" name="divsgs" id="divsgs" value=""/>
				<div class="dow_nr">
					<table width="100%" border="0" cellspacing="8" cellpadding="0"
						class="hui">
						<tr style="font-size: 12px;">
							<td width="10%">
								订单名称：
							</td>
							<td colspan="2" class="hei">
								${sgnum}
							</td>
							<td width="11%">
								&nbsp;
							</td>
							<td colspan="2">
								&nbsp;
							</td>
						</tr>
						<tr style="font-size: 12px;">
							<td>
								客户名称：
							</td>
							<td width="18%">
								<label for="textfield4"></label>
								<input name="cusname" id="cusname" readonly="readonly" type="text" class="cs_khtetx"
									onclick="showCur();" />
								<input type="hidden" id="cusid" value="" name="cusid" />
								<input type="hidden" id="address2" name="address2" value="" />
							</td>
							<td width="22%">
								<div class="gb_btle">
									<span><a style="CURSOR: pointer;" onclick="showCur();">快捷选择</a>
							</span>
								</div>
							</td>
							<td>
								<span class="hong">*</span> 销售员工：
							</td>
							<td width="18%">
								<label for="textfield6"></label>
								<input name="empname" id="empname" onclick="showEmp();" readonly="readonly" value="${emps.name}" type="text" class="cs_khtetx" />
								<input type="hidden" id="empid" name="empid" value="${emps.id}" />
							<td width="21%">
								<div class="gb_btri">
									<a style="CURSOR: pointer;" onclick="showCur();">更改</a>
								</div>
							</td>
						</tr>
					</table>

					<div align="center">
						<hr />
					</div>

					<div>
						<ul class="sp_nav_tab">
							<li class="active">
								确认订单信息
							</li>
						</ul>
						<table width="95%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="tdborder">
							<tr class="td_top_color" style="font-size: 12px;">
								<td colspan="9">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="td_top_color">
										<tr>
											<td width="35%" class="tdborderright">
												店铺商品
											</td>
											<td width="20%" class="tdborderright">
												特殊规格
											</td>
											<td width="17%" class="tdborderright">
												数量
											</td>
											<td width="15%" class="tdborderright">
												价格（元）
											</td>
											<td width="13%">
												小计（元）
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<input type="hidden" id="sprice" name="sprice"
								value="${sggood.sgPrice}" />
							<input type="hidden" id="sgInventory" name="sgInventory"
								value="${sggood.sgInventory}" />
							<input type="hidden" id="sgid" name="sgid" value="${sggood.sgId}" />
							<tr style="font-size: 12px;">
								<td colspan="9">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="td_color">
										<tr style="font-size: 12px;">
											<td width="1%" align="center">
												&nbsp;
											</td>
											<td width="18%">
												<!-- 店铺： -->
												<span class="qlv"><!-- 甜心VPS --></span>
											</td>
											<td width="81%">
												<!-- 卖家：-->
												<span class="qlv"><!-- duhfuhi --></span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr style="font-size: 12px;">
								<td colspan="9" align="center" class="tdborbernn">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr style="font-size: 12px;">
											<td width="9%" rowspan="2" align="center" height="47">
												<img src="<%=basePath%>potal/images/ss_c2.png" width="52" height="52"
													class="tp1" />
											</td>
											<td width="26%" height="25" class="lv">
												${sggood.sgname}
											</td>
											<td width="20%" rowspan="2" align="center">
												
											</td>
											<td width="17%" rowspan="2" align="center">
												<a onclick="javascript:clickcut();" href="javascript:void(0);" style="CURSOR: pointer"><img src="<%=basePath%>potal/images/ss_-.png" width="11" height="11" /></a>
												&nbsp;
												<label for="textfield3"></label>
												<input type="text" id="count" style="text-align: center;"
													align="middle" name="count" value="1" onblur="changtxt();"
													class="jjtext" />
												&nbsp;
												<a onclick="javascript:clickadd();" style="CURSOR: pointer" href="javascript:void(0);"><img src="<%=basePath%>potal/images/ss_+.png" width="11" height="11" /></a>
											</td>
											<td width="15%" rowspan="2" align="center">
												${sggood.sgPrice}<br /> ${sggood.sgPrice}<!-- 无优惠  -->
											</td>
											<td width="13%" rowspan="2" align="center" id="moneys"
												class="hong">
												${sggood.sgPrice}
											</td>
										</tr>
										<tr style="font-size: 12px;">
											<td align="left">
												保障
												<img src="<%=basePath%>potal/images/ss_bz.png" width="15" height="13" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr class="tdcen" style="font-size: 12px;">
								<td colspan="9" class="tdcen">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="centerl">
										<tr style="font-size: 12px;">
											<td width="14%" align="center">
												给卖家留言：
											</td>
											<td width="36%" rowspan="2" class="tdborbernn">
												<label for="textarea"></label>
												<textarea name="orders.sgLeave"  id="textarea" cols="35" rows="3"></textarea>
											</td>
											<td width="37%" rowspan="2" align="center" class="tdborbernn">
												运送方式：
												<label for="select2"></label>
												<select id="changsotype" onchange="javascript:onchangsotype();" class="cs_xq_xlk">
													<option value="0">
														--请选择运送方式--
													</option>
													<option value="1">
														顺风
													</option>
													<option value="2">
														快递
													</option>
													<option value="3">
														送过来
													</option>
												</select>
											</td>
											<td width="13%" rowspan="2" align="center" class="tdborbernn">
												<span class="hong" id="delprice"> 0.0</span>
											</td>
										</tr>
										<tr>
											<td class="tdborbernn">
												&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr style="font-size: 12px;">
								<td colspan="4" align="left">	
								规格选项：
								<select>
									<option>百独.电信</option>
									<option>百独.电信</option>
									<option>百独.电信</option>
									<option>百独.电信</option>
									
								</select>
									
								</td>
								<td colspan="5" align="right">
									店铺合计(含运费)：
									<span class="hong"><span class="hei">￥<span
											id="summoney">${sggood.sgPrice}</span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
									</span>
								</td>
							</tr>
						</table>
						<table width="95%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="hui">
							<tr style="font-size: 12px;">
								<td align="right">
									&nbsp;
								</td>
							</tr>
						</table>
						<ul class="sp_nav_tab">
							<li class="active">
								收货地址
							</li>
						</ul>
						<table width="95%" border="0" cellspacing="12" cellpadding="0"
							align="center">
							<tr style="font-size: 12px;">
								<td colspan="2" align="center" id="addressifo">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" id="newaddressid">
										<tr style="font-size: 12px;">
											<td width="9%" align="center" class="td_center">
												<span class="ju">寄送至</span>
											</td>
											<td width="91%" align="left" class="td_center">
												<input name="radio" onclick="onclickshow();" type="radio" value="wu" />
												<label for="radio"></label>
												<label for="checkbox"></label>
												<label for="checkbox">
													<strong>无收获地址</strong>
													<span class="hui">&nbsp;&nbsp;默认地址</span>
												</label>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr style="font-size: 12px;">
								<td>
									&nbsp;
								</td>
								<td align="right">
									<div class="gb_bt2">
										<a href="javascript:newaddress();" class="cs_xdz">使用新地址</a>
									</div>
								</td>
							</tr>
						</table>
						<ul class="sp_nav_tab">
							<li class="active">
								确认收货地址
							</li>
						</ul>
						<table width="95%" border="0" cellspacing="12" cellpadding="0"
							class="tdtd">
							<tr style="font-size: 12px;">
								<td>
									寄送至：<span id="ress"></span>
								</td>
							</tr>
							<tr style="font-size: 12px;">
								<td>
									收货人：<span id="uname"></span>
								</td>
							</tr>
							<tr style="font-size: 12px;">
								<td>
									实付款：
									<strong><span id="paymoney">￥${sggood.sgPrice}</span>
									</strong>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tdbottom">
							<tr style="font-size: 12px;">
								<td width="33%"  align="center">
									<div class="gb_bts">
										<span onclick="javascript:btnclick(0);"
											style="CURSOR: pointer;">提交并审核</span>
									</div>
								</td>
								<td width="33%"  align="center">
									<div class="gb_btss">
										<span onclick="javascript:btnclick(1);" style="CURSOR:pointer;">提交</span>
									</div>
								</td>
								<td width="33%"  align="center">
									<div class="gb_btss" onclick="javascript:onback();" style="CURSOR:pointer;">
										取消
									</div>
								</td>
							</tr>
						</table>
					
					</div>
				<script type="text/javascript">
					function onback()
					{
						window.location.href = "<%=request.getContextPath()%>/selectsalegoods.do";
					}
				</script>
				</div>
			</form>
		</div>

		<div id="addrow" style="display: none;" class="d2">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFramenewaddress" src="" style="width: 620px; height: 398px;"></iframe>
		</div>
		<div id="addrow1" class="d2" style="display: none;">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrames" src=""
				style="width: 623px; height: 410px;"></iframe>
		</div>
		<div id="addrow2" style="display: none;" class="d2">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrame"
				src="<%=request.getContextPath()%>/selectEmpsalegoods.do"
				style="width: 623px; height: 490px;"></iframe>
		</div>
		<div id="addrow3" style="display: none;" class="d2">
			<iframe frameborder="0" scrolling="no" marginheight="0"
				marginwidth="0" id="myFrameaddress" src="" style="width: 623px; height: 490px;"></iframe>
		</div>
		
		
		
		
		
		
		
		<div style="display: none;width: 1px;top: 80%" id="divsg">
			
<style type="text/css">
body{width:760px; margin:0 auto; font-size:12px; color:#333132}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left; height:1000px;}
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
.ccc{ text-align:center;width:50px; line-height:20px;float:right; background-color:#7b7b7b;color:#fff;}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.d1{ line-height:20px;}
.da{ width:794; margin-left:30px; margin-right:30px; margin-top:10px; height:600px;}
.sp1{float:left;}
.sp2{float:right;}
.sp3{float:right; background-color:#7b7b7b; width:50px; text-align:center; margin-left:10px;line-height:20px; color:#fff;}
.sp4{ float:left;background-color:#7b7b7b; width:50px; text-align:center; margin-left:10px;line-height:20px; color:#fff;}
.sp5{ padding-left:130px; float:left;}
.sp6{ float:left;}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:0px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
.msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
.msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.tdyh{ padding-right:75px;}
.tcolor{ border:1px solid #295a01; background-color:#eafed9; }
.tdcolor{ color:#3d3d3d; background-color:#bcbcbc; border:1px; border-color:#999999; height:28px; size:14px;}
.ta111{ margin-top:10px; margin-left:5px; margin-bottom:10px; margin-right:5px; border:1px solid #bababa;}
.btn{ background-color:#50a806; color:#fff;}
.zt{ color:#295b02;}
.zt2{ color:#F00;}
.tbcenter{ margin-top:10px; margin-bottom:10px; border-color:#295a01}
.tdleft{ padding-left:40px;}
.qc{ padding-left:25px}
.yfd { width:600px; float:right; line-height:25px;}
.yfd span { color:#fec2a8;}
.gb_bt{ background-color:#7a7a7a; font-weight:bold; color:#fff; width:50px; line-height:20px; text-align:center; margin-left:auto; margin-right:29px; float:right;}
.div_left{ float:right; width:100px;}
.div_right{ float:right;width:100px;}
.gb_bt2{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; float:right; margin-right:30px;}
.gb_bt3{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; float:left; margin-right:30px;}
.tc_bottom_top{ margin-top:25px; margin-bottom:10px;}
.ttx{ size:20px;}
.tbbottom{ margin-top:13px;}
.top1{color:#3b8902;}
.top2{color:#fe6700;}
.khmg{ padding-top:15px;}
.top3{ margin-top:7px; margin-bottom:12px;}
.bg_wz { line-height:30px; padding-left:30px;}
.bg_t { line-height:30px; border:1px solid #ececec; background-color:#f8f8f8;}
.sp_tp { width:100px; height:100px; border:1px solid #ff6600;}
.sp_tp_t { width:100px; height:100px; border:1px solid #d9d9d9;}
.sp_ms { width:650px; line-height:25px; padding-top:20px; padding-left:10px; padding-right:10px; border:1px solid #ececec; background-color:#f8f8f8;}
.lh_ss { line-height:40px;}
.fh_an { width:50px; line-height:25px; color:#fff; background-color:#50a806; text-align:center; border:0;}



a { color:#213f71; font-size:9pt; text-decoration:none; }
a:hover { color:#0066cc; }
.blk_18 { overflow:hidden; zoom:1; font-size:9pt; border:1px solid #e3e3e3; background:#ffffff; width:692px; margin-top:8px; }
.blk_18 .pcont { width:638px; float:left; overflow:hidden; padding-left:5px; }
.blk_18 .ScrCont { width:32766px; zoom:1; margin-left:-5px; }
.blk_18 #List1_1, .blk_18 #List2_1 { float:left; }
.blk_18 .LeftBotton, .blk_18 .RightBotton { width:15px; height:74px; float:left; background:url(ax.gif) no-repeat; }
.blk_18 .LeftBotton { background-position: 0 0; margin:8px 5px 0; }
.blk_18 .RightBotton { background-position: 0 -100px; margin:8px 1px 10px 5px; }
.blk_18 .LeftBotton:hover { background-position: -20px 0; }
.blk_18 .RightBotton:hover { background-position: -20px -100px; }
.blk_18 .pl img { display:block; cursor:pointer; border:none; margin:6px auto 1px auto; }
.blk_18 .pl { width:105px; border:1px solid #f3f3f3; float:left; float:left; text-align:center; line-height:24px; }
.blk_18 a.pl:hover { border:1px solid #5dacec; color:#5dacec; background:#fff; }
</style>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>

<script type="text/javascript">

var Speed_1 = 10; //速度(毫秒)
var Space_1 = 20; //每次移动(px)
var PageWidth_1 = 107 * 6; //翻页宽度
var interval_1 = 5000; //翻页间隔时间
var fill_1 = 0; //整体移位
var MoveLock_1 = false;
var MoveTimeObj_1;
var MoveWay_1="right";
var Comp_1 = 0;
var AutoPlayObj_1=null;

function GetObj(objName){if(document.getElementById){return eval('document.getElementById("'+objName+'")')}else{return eval('document.all.'+objName)}}
function AutoPlay_1(){clearInterval(AutoPlayObj_1);AutoPlayObj_1=setInterval('ISL_GoDown_1();ISL_StopDown_1();',interval_1)}
function ISL_GoUp_1(){if(MoveLock_1)return;clearInterval(AutoPlayObj_1);MoveLock_1=true;MoveWay_1="left";MoveTimeObj_1=setInterval('ISL_ScrUp_1();',Speed_1);}
function ISL_StopUp_1(){if(MoveWay_1 == "right"){return};clearInterval(MoveTimeObj_1);if((GetObj('ISL_Cont_1').scrollLeft-fill_1)%PageWidth_1!=0){Comp_1=fill_1-(GetObj('ISL_Cont_1').scrollLeft%PageWidth_1);CompScr_1()}else{MoveLock_1=false}
AutoPlay_1()}
function ISL_ScrUp_1(){if(GetObj('ISL_Cont_1').scrollLeft<=0){GetObj('ISL_Cont_1').scrollLeft=GetObj('ISL_Cont_1').scrollLeft+GetObj('List1_1').offsetWidth}
GetObj('ISL_Cont_1').scrollLeft-=Space_1}
function ISL_GoDown_1(){clearInterval(MoveTimeObj_1);if(MoveLock_1)return;clearInterval(AutoPlayObj_1);MoveLock_1=true;MoveWay_1="right";ISL_ScrDown_1();MoveTimeObj_1=setInterval('ISL_ScrDown_1()',Speed_1)}
function ISL_StopDown_1(){if(MoveWay_1 == "left"){return};clearInterval(MoveTimeObj_1);if(GetObj('ISL_Cont_1').scrollLeft%PageWidth_1-(fill_1>=0?fill_1:fill_1+1)!=0){Comp_1=PageWidth_1-GetObj('ISL_Cont_1').scrollLeft%PageWidth_1+fill_1;CompScr_1()}else{MoveLock_1=false}
AutoPlay_1()}
function ISL_ScrDown_1(){if(GetObj('ISL_Cont_1').scrollLeft>=GetObj('List1_1').scrollWidth){GetObj('ISL_Cont_1').scrollLeft=GetObj('ISL_Cont_1').scrollLeft-GetObj('List1_1').scrollWidth}
GetObj('ISL_Cont_1').scrollLeft+=Space_1}
function CompScr_1(){if(Comp_1==0){MoveLock_1=false;return}
var num,TempSpeed=Speed_1,TempSpace=Space_1;
if(Math.abs(Comp_1)<PageWidth_1/2){
	TempSpace=Math.round(Math.abs(Comp_1/Space_1));
	if(TempSpace<1){
		TempSpace=1
		}
	}
if(Comp_1<0){if(Comp_1<-TempSpace){Comp_1+=TempSpace;num=TempSpace}else{num=-Comp_1;Comp_1=0}
GetObj('ISL_Cont_1').scrollLeft-=num;setTimeout('CompScr_1()',TempSpeed)}else{if(Comp_1>TempSpace){Comp_1-=TempSpace;num=TempSpace}else{num=Comp_1;Comp_1=0}
GetObj('ISL_Cont_1').scrollLeft+=num;setTimeout('CompScr_1()',TempSpeed)}}
function picrun_ini(){
GetObj("List2_1").innerHTML=GetObj("List1_1").innerHTML;
GetObj('ISL_Cont_1').scrollLeft=fill_1>=0?fill_1:GetObj('List1_1').scrollWidth-Math.abs(fill_1);
GetObj("ISL_Cont_1").onmouseover=function(){clearInterval(AutoPlayObj_1)}
GetObj("ISL_Cont_1").onmouseout=function(){AutoPlay_1()}
AutoPlay_1();
}

$(function(){
	var imgs=$('#imgs').val();
		alert(imgs);
	  var imgvalue=  imgs.split('|');
	    if(imgvalue!=""){
	  for(var i=1; i<imgvalue.length; i++){
	  	if(imgvalue[i]!=""){
	    	$('#List1_1').append("<a class='pl' href='javascript:void(0);'><img src='"+imgvalue[i]+"'  width='96' height='72'/></a>");
	  	}
	    }
	  }
	});
</script>

<div class="d1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><span class="top1">您的位置</span>：<a href="<%=basePath %>potal/page/desk.jsp">首页</a>&gt;<a href="<%=basePath%>selectsalegoods.do">出售中的商品</a>&gt;<span class="top2">商品详情</span></td>
  </tr>
</table>
<div class="top3"></div>
</div>
<div class="dow">
<div class="dow_top">
商品详情
</div>
<div class="dow_nr">
	 <div class="lb">
     <ul>
     <li>商品的基本信息</li>
     </ul>
     </div>	 
    <div class="c">
	   <p>&nbsp;</p>
    </div>
    <input type="hidden" id="imgs" name="imgs" value="${sggood.sgImg}"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="bg_wz">
  <tr>
    <td width="15%" align="right">商品全称：</td>
    <td width="35%">${sggood.sgname}</td>
    <td width="25%" align="right">一口价：</td>
    <td width="25%">${sggood.sgPrice }元</td>
  </tr>
  <tr>
    <td align="right">商品类型：</td>
    <td>${sggood.goods_dict.gdnames}</td>
    <td align="right">上架类型：</td>
    <td>
    	<c:if test="${  sggood.sgchecks== null || sggood.sgchecks == '0'}">无</c:if>
    	<c:if test="${sggood.sgchecks != '0'}">上架</c:if>
    </td>
  </tr>
  <tr>
    <td align="right">开始时间：</td>
    <td>${sggood.sgtime}</td>
    <td align="right">运费：</td>
    <td>暂无</td>
  </tr>
  <tr>
    <td align="right" valign="top">商品属性：</td>
    <td colspan="3"><table width="100%" align="left" border="0" cellspacing="0" cellpadding="0" class="bg_t">
    <c:forEach items="${getpropertys}" var="sgo">
      <tr>
        <td width="6%" align="left">${sgo.value[0]}：</td>
        <td width="24%">${sgo.value[1]}</td>
      </tr>
      </c:forEach>
    </table></td>
    </tr>
</table>
<center>
<!-- picrotate_left start  -->


<div class="blk_18"> <a class="LeftBotton" onmousedown="ISL_GoUp_1()" onmouseup="ISL_StopUp_1()" onmouseout="ISL_StopUp_1()" href="javascript:void(0);" target="_self"></a>
  <div class="pcont" id="ISL_Cont_1">
    <div class="ScrCont">
      <div id="List1_1" >

      </div>
      <div id="List2_1"></div>
    </div>
  </div>
  <a class="RightBotton" onmousedown="ISL_GoDown_1()" onmouseup="ISL_StopDown_1()" onmouseout="ISL_StopDown_1()" href="javascript:void(0);" target="_self"></a> </div>
<div class="c"></div>
<script type="text/javascript">
        <!--
        picrun_ini()
        //-->
        </script>
<!-- picrotate_left end -->
</center>

	  <p>&nbsp;</p>
	  <div class="lb">
      <ul>
        <li>商品描述</li>
        
      </ul>
  </div>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="90%"><div class="sp_ms">${sggood.sgDetails}</div></td>
          </tr>
  </table>
		<p>&nbsp;</p>
  <div class="lb">
    <ul>
      <li>售后保障信息</li>
    </ul>
  </div>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="10%" align="right" class="lh_ss">发票：有</td>
            <td width="90%" align="center" class="lh_ss">保修：有</td>
          </tr>
          <tr>
            <td align="right" valign="top">售后说明：</td>
            <td><div class="sp_ms">暂无</div></td>
          </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center">
      <input type="button" style="CURSOR:pointer;" name="fanHui" onclick="javascript:window.history.go(-1);"  value="返回" class="fh_an" /></td>
  </tr>
</table>

  
  </div>
</div>
		</div>
	</body>
</html>
