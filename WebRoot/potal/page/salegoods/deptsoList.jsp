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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>出售中的商品</title>
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
	font-size: 12px
}

img {
	border: 0
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
	font-size: 14px;
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
	font-size: 14px;
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

.gb_bt {
	background-color: #7b7b7b;
	font-weight: bold;
	color: #fff;
	width: 50px;
	line-height: 20px;
	text-align: center;
	margin-left: auto;
	margin-right: 40px;
}

.td_color {
	background-color: #eafed9;
	margin-top: 5px;
}

.td_top_color {
	background-color: #626262;
	font-size: 14px;
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
	color: #6d696a;
}
.hui a {
	color: #6d696a;
	text-decoration: none;
}
.hong {
	color: #fe0000
}
</style>
		<script type="text/javascript"
			src="<%=basePath%>potal/js/jquery.min.js"></script>
<script type="text/javascript">
	function onsumbitso()
	{
		var demo = $("#demo").val();
		if(demo == "sg")
		{
			form1.action = "<%=basePath%>selectsordersalegoods.do";
			form1.submit();
		}
		if(demo == "mysg")
		{
			form1.action = "<%=basePath%>selectmysgsalegoods.do";
			form1.submit();
		}
		if(demo == "deptsg")
		{
			form1.action = "<%=basePath%>selectdeptsgsalegoods.do";
			form1.submit();
		}
		
		
	}
	function onchangso()
	{
		var obj = document.getElementById("select3");
		var selectIndex = obj.selectedIndex;
		var values = obj.options[selectIndex].value;
		$("#soStat").attr("value",values);
	}

	function onclickUS(soNum)
	{
		window.location.href = "<%=basePath%>addUpserversalegoods.do?soNum="+soNum;
	}



	function mouseevent(obj)
	{
		var addtxt = obj+"s";
		$("#"+addtxt).hide();
		$("#"+obj+"ss").show();
	}

	function monseoutevent(obj)
	{
		
		$("#"+obj+"aa").empty();
		$("#"+obj+"aa").html("500.0");
	}

	function mouseoutevent(obj,sgId)
	{
<%--		$("#"+obj+"s").show();--%>
<%--		$("#"+obj+"ss").hide();--%>
		var prices = $("#"+sgId+"sd").val();
		var invilprice = $("#"+sgId+"hideprice").val();
		var count = $("#"+sgId+"count").val();
		var devprice = $("#"+sgId+"devprice").val();
		if(isNaN(prices))
		{
			alert("请输入数字!");
			$("#"+sgId+"sd").val(invilprice);
			return ;
		}
		if(Number(prices)<0)
		{
			alert("请输入的数字大于0!");
			$("#"+sgId+"sd").val(invilprice);
			return false;
		}
		if(prices == "")
		{
			alert("不能为空!");
			$("#"+sgId+"sd").val(invilprice);
			return false;
		}
		$.ajax({
			  tpye:"POST",
			  url:"updateSgAndSosalegoods.do",
			  data:{
					"sgId":obj,
					"soId":sgId,
					"prices":prices,
					"count":count,
					"devprice":devprice
				  },
			  success:function(data)
			  {
				 window.location.href = "selectsordersalegoods.do?demo=sg";
			  }
			});
		
	}


	function monseoverevent(obj)
	{
		var addtxt = obj+"adel";
		$("#"+addtxt).hide();
		$("#"+obj+"del").show();
	}
	function monseoverevents(obj)
	{
		var addtxt = obj+"adels";
		$("#"+addtxt).hide();
		$("#"+obj+"dels").show();
	}


	function mouseouteventdel(obj,soId)
	{
		var delprice = $("#"+soId+"delsd").val();
		var devprice = $("#"+soId+"devprice").val();
		var invilprice = $("#"+soId+"hideprice").val();
		var count = $("#"+soId+"count").val();
		if(isNaN(delprice))
		{
			alert("请输入数字!");
			$("#"+soId+"delsd").val(devprice);
			return ;
		}
		if(Number(delprice)<0)
		{
			alert("请输入的数字大于0!");
			$("#"+soId+"delsd").val(devprice);
			return false;
		}
		if(delprice == "")
		{
			alert("不能为空!");
			$("#"+soId+"delsd").val(devprice);
			return false;
		}

		$.ajax({
			 type:"POST",
			 url:"updatedevlipricesalegoods.do",
			 data:{
				"sgId":obj,
				"soId":soId,
				"delprice":delprice,
				"count":count,
				"prices":invilprice
			 },
			 success:function(data)
			 {
				 window.location.href = "selectsordersalegoods.do?demo=sg";
			 }
			});
	}

	function mouseouteventdels(obj,soId)
	{
		var delprice = $("#"+soId+"delsds").val();
		var devprice = $("#"+soId+"devprice").val();
		var invilprice = $("#"+soId+"hideprice").val();
		var count = $("#"+soId+"count").val();
		var price = $("#"+soId+"price").val();
		if(isNaN(delprice))
		{
			alert("请输入数字!");
			$("#"+soId+"delsds").val(devprice);
			return ;
		}
		if(Number(delprice)<0)
		{
			alert("请输入的数字大于0!");
			$("#"+soId+"delsds").val(devprice);
			return false;
		}
		if(delprice == "")
		{
			alert("不能为空!");
			$("#"+soId+"delsds").val(devprice);
			return false;
		}

		$.ajax({
			 type:"POST",
			 url:"updatepricessalegoods.do",
			 data:{
				"sgId":obj,
				"soId":soId,
				"delprice":delprice,
				"count":count,
				"prices":invilprice,
				"devprice":devprice
			 },
			 success:function(data)
			 {
				 window.location.href = "selectsordersalegoods.do?demo=sg";
			 }
			});
	}

</script>
	</head>
	<body>
		<div class="dow">
			<div class="div_top">
				<p>
					&nbsp;
				</p>
				<p>
					<span class="lv">您的位置</span><span class="hui">：<a href="<%=basePath %>potal/page/desk.jsp">首页</a>>办公桌面></span><span
						class="ju">销售订单</span>
				</p>

				<p>
					&nbsp;
				</p>
			</div>
			<div class="dow_top">
				<span><a href="#">×</a>
				</span> 已卖出的商品
			</div>
			<div class="dow_nr">
			<form action="" method="post" id="form1">
				<input type="hidden" name="demo" id="demo" value="${demo}"/>
				<input type="hidden" id="soStat" name="soStat" value="" />
				<c:if test="${workgrad == 'mark'}">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabtop">
					<tr>
						<td width="35%">
							&nbsp;&nbsp;商品名称：
							<label for="textfield"></label>
							<input type="text" name="saleName" value="${saleName}" id=saleName />
						</td>
						<td width="65%">
							&nbsp;成交时间：从
							<label for="textfield2"></label>
							<input name="textfield2" type="text" id="textfield2" size="4" />
							日
							<label for="select"></label>
							<select name="select" id="select">
							</select>
							时
							<input name="textfield5" type="text" id="textfield5" size="2" />
							分 到
							<input name="textfield3" type="text" id="textfield3" size="4" />
							日
							<select name="select2" id="select2">
							</select>
							时
							<input name="textfield7" type="text" id="textfield7" size="2" />
							分
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="9" cellpadding="0"
					class="hui">
					<tr>
						<td width="35%">
							买家昵称：
							<input type="text" name="curName" value="${curName}" id="curName" />
						</td>
						<td width="34%">
							订单状态：
							<label for="select3"></label>
							<select name="select3" class="lbdx" id="select3" onchange="javascript:onchangso();">
								<option value="-1">
									--请选择--
								</option>
								<option value="0" <c:if test="${soStat == '0' }">selected</c:if> >
										待审核
								</option>
								<option value="1" <c:if test="${soStat == '1' }">selected</c:if> >
										待付款
								</option>
								<option value="2" <c:if test="${soStat == '2' }">selected</c:if> >
										待付款审核
								</option>
								<option value="3" <c:if test="${soStat == '3' }">selected</c:if> >
										待生成上架单
								</option>
								<option value="4" <c:if test="${soStat == '4' }">selected</c:if> >
										待调拨往客服
								</option>
								<option value="5" <c:if test="${soStat == '5' }">selected</c:if> >
										待客服接受
								</option>
								<option value="6" <c:if test="${soStat == '6' }">selected</c:if> >
										待客服转运维
								</option>
								<option value="7" <c:if test="${soStat == '7' }">selected</c:if> >
										待运维接收
								</option>
								<option value="8" <c:if test="${soStat == '8' }">selected</c:if> >
										带运维上架
								</option>
								<option value="9" <c:if test="${soStat == '9' }">selected</c:if> >
										待客服确认
								</option>
								<option value="10" <c:if test="${soStat == '10' }">selected</c:if> >
										订单成功
								</option>
								<option value="11" <c:if test="${soStat == '11' }">selected</c:if> >
										待生成上架单
								</option>
							</select>
						</td>
						<td width="31%">
							评价状态：
							<select name="select5" class="lbdx" id="select5">
								<option>
									全部
								</option>
								<option>
									全部
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							订单编号：
							<input type="text" name="soNum" value="${soNum}" id="soNum" />
						</td>
						<td>
							物流服务：
							<select name="select4" class="lbdx" id="select4">
								<option>
									全部
								</option>
								<option>
									全部
								</option>
							</select>
						</td>
						<td>
							售后服务：
							<select name="select6" class="lbdx" id="select6">
								<option>
									全部
								</option>
								<option>
									全部
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
						<td>
							<div class="gb_bt" style="CURSOR:pointer;">
								<span id="sosubmit" onclick="javascript:onsumbitso();">搜索</span>
							</div>
						</td>
					</tr>
				</table>
				</form>
				<div align="center">
					<hr />
				</div>
				<div>
					<ul class="sp_nav_tab">
						<li class="nomarl">
							订单列表
						</li>
						<li class="sq"></li>
						<li class="nomarl">
							等待卖家
						</li>
						<li class="sq"></li>
						<li class="nomarl">
							等待发货
						</li>
						<li class="sq"></li>
						<li class="nomarl">
							已发货
						</li>
						<li class="sq"></li>
						<li class="nomarl">
							退款中
						</li>
						<li class="sq"></li>
						<li class="active">
							等待上架
						</li>
					</ul>
					<table width="95%" border="0" cellspacing="0" cellpadding="0"
						align="center" class="tdborder">
						<tr class="td_top_color">
							<td colspan="2" class="tdborderright">
								商品
							</td>
							<td width="8%" class="tdborderright">
								单价(元)
							</td>
							<td width="8%" class="tdborderright">
								数量
							</td>
							<td width="11%" class="tdborderright">
								买家
							</td>
							<td width="13%" class="tdborderright">
								售后
							</td>
							<td width="15%" class="tdborderright">
								交易状态
							</td>
							<td width="13%" class="tdborderright">
								实收款(元)
							</td>
							<td width="10%">
								评价
							</td>
						</tr>
						<c:if test="${pages != null}">
						<c:forEach items="${pages.pageList}" var="so">
							<tr>
								<td colspan="9">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr class="td_color">
											<td align="center">
												<input type="checkbox" name="checkbox2" id="checkbox2" />
											</td>
											<td>
												订单编号
												<span class="hui">：${so.sale_orders.soNums}</span>
											</td>
											<td>
												成交时间：
												<span class="hui">${so.sale_orders.soOrderTime}</span>
											</td>
											<td>
												总额：
												<span class="hong">
												${so.sale_orders.sgPrice}
												(邮费:
													<c:if test="${so.sale_orders.statchang==0}">
														${so.sale_orders.devilvprice}
													</c:if>
													<c:if test="${so.sale_orders.statchang==1}">
													<span id="${so.sale_orders.soId}adel" onmouseover="monseoverevent('${so.sale_orders.soId}');">${so.sale_orders.devilvprice}</span>
												<span onmouseout="mouseouteventdel('${so.sale_goods.sgId}','${so.sale_orders.soId}')" id="${so.sale_orders.soId}del" style="CURSOR: pointer;display: none;height: 20px;">
													<input onblur="mouseouteventdel('${so.sale_goods.sgId}','${so.sale_orders.soId}')" id="${so.sale_orders.soId}delsd" size="6" type="text" value="${so.sale_orders.devilvprice}"/>
												</span>
												</c:if>
													)
												</span>元
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="center" class="tdborbernn">
									<img src="<%=request.getContextPath()%>/potal/images/mj_ej.png" alt="" width="70" height="39" />
								</td>
								<td height="50px">
									${so.sale_goods.sgname}
								</td>
								<td align="center" class="hong" id="${so.sale_orders.soId}aa">
										<c:if test="${so.sale_orders.statchang==0}">￥${so.sale_orders.prices}</c:if>
										<c:if test="${so.sale_orders.statchang==1}">
											<span id="${so.sale_orders.soId}adels" onmouseover="monseoverevents('${so.sale_orders.soId}');">￥${so.sale_orders.prices}</span>
											<span onmouseout="mouseouteventdels('${so.sale_goods.sgId}','${so.sale_orders.soId}')" id="${so.sale_orders.soId}dels" style="CURSOR: pointer;display: none;height: 20px;">
													<input onblur="mouseouteventdels('${so.sale_goods.sgId}','${so.sale_orders.soId}')" id="${so.sale_orders.soId}delsds" size="6" type="text" value="${so.sale_orders.prices}"/>
												</span>
										</c:if>
								</td>
								<td align="center">
									${so.soOrderNumber}
								</td>
								<td align="center">
									${so.sale_orders.customer.realName}
								</td>
								<td align="center">
<%--									要求退款--%>
								</td>
								<td align="center">
									<c:if test="${so.sale_orders.soStat ==0 }">
										待审核
									</c:if>
									<c:if test="${so.sale_orders.soStat ==1 }">
										待付款
									</c:if>
									<c:if test="${so.sale_orders.soStat ==2 }">
										待付款审核
									</c:if>
									<c:if test="${so.sale_orders.soStat ==3 }">
										待生成上架单
									</c:if>
									<c:if test="${so.sale_orders.soStat ==4 }">
										待调拨往客服
									</c:if>
									<c:if test="${so.sale_orders.soStat ==5 }">
										待客服接受
									</c:if>
									<c:if test="${so.sale_orders.soStat ==6 }">
										待客服转运维
									</c:if>
									<c:if test="${so.sale_orders.soStat ==7 }">
										待运维接收
									</c:if>
									<c:if test="${so.sale_orders.soStat ==8 }">
										带运维上架
									</c:if>
									<c:if test="${so.sale_orders.soStat ==9 }">
										待客服确认
									</c:if>
									<c:if test="${so.sale_orders.soStat ==10 }">
										订单成功
									</c:if>
									<c:if test="${so.sale_orders.soStat ==11 }">
										待生成上架单
									</c:if>
									
								</td>
								<td align="center">
									${so.sale_orders.meetPrice}
								</td>
								<td align="center">
									<c:if test="${so.sale_orders.soStat == 3}">
										<span class="lv" onclick="javascript:onclickUS('${so.sale_orders.soNums}');" style="CURSOR:pointer;">待客上架</span>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						
						<c:if test="${pages == null}">
							<tr>
								<td colspan="9">查无数据</td>
							</tr>
						</c:if>
					</table>
					<table width="95%" border="0" cellspacing="0" cellpadding="0"
						align="center" class="hui">
						<tr>
							<td align="right">
								<c:if test="${demo == 'sg'}">
									<pp:pages1 url="selectsordersalegoods.do" param="demo=sg&openmethod=1"/>
								</c:if>
								<c:if test="${demo == 'mysg'}">
									<pp:pages1 url="selectmysgsalegoods.do" param="demo=mysg&openmethod=1"/>
								</c:if>
								<c:if test="${demo == 'deptsg'}">
									<pp:pages1 url="selectsordersalegoods.do" param="demo=deptsg&openmethod=1"/>
								</c:if>
							</td>
						</tr>
					</table>
					</c:if>
						<c:if test="${workgrad != 'mark'}">
						<table width="95%" border="0" cellspacing="0" cellpadding="0"
						align="center" class="hui">
							<tr align="center">
								<td>无权限，请与管理员联系!</td>
							</tr>
							</table>
						</c:if>
				</div>
			</div>
		</div>
	</body>
</html>
