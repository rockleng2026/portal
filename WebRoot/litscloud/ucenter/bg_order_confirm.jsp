<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>" />
		<title>立云-后台（确认订单信息）</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
		<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<style>
.address_list {
	margin: 10px auto;
}

.address_list ul {
	margin: 0px;
	padding: 0px;
}

.address_list ul li {
	width: 937px;
	height: auto;
	overflow: hidden;
	padding: 5px 0px;
	margin-bottom: 5px;
	border: solid 1px #fff;
	line-height: 25px;
}

.address_list ul li:hover {
	background: #fffae7;
}

.address_list ul li a {
	color: #2d89f0;
	font-size: 12px;
	font-family: Arial, Helvetica, sans-serif, "宋体";
}

.address_list ul li a:hover {
	color: #ff7200;
	text-decoration: underline;
}

.address_list_r {
	float: right;
	margin: 0px 10px;
	text-algin: center;
}

.address_list ul li input {
	margin-left: 75px;
	margin-top: 6px;
	position: absolute;
	vertical-align: baseline;
}

.address_list_right {
	display: inline;
}

.address_labe {
	font-size: 12px;
	color: #404040;
	padding-left: 10px;
	vertical-align: baseline;
	margin-left: 90px;
}

.address_labe em {
	color: gray;
	font-style: normal;
	font-weight: normal;
}

.address_moren {
	color: gray;
	margin-left: 20px;
	font-style: normal;
}

.address_shezhi {
	margin-left: 15px;
	vertical-align: baseline;
}

.address_zhij {
	width: 75px;
	height: 25px;
	line-height: 25px;
	position: absolute;
	color: #fc5301;
	background: url(litscloud/images/zh_32.gif) no-repeat 10px center;
	text-indent: 28px;
	font-weight: bold;
}

.address_cg {
	height: 20px;
	line-height: 20px;
	color: gray;
	text-indent: 20px;
	background: url(litscloud/images/bg_14.png) no-repeat left center;
	margin-left: 75px;
}

.fais {
	border: none;
	width: 100%;
	height: auto;
	margin: 20px auto;
}

.fais th {
	text-align: center;
	height: 26px;
	line-height: 26px;
	border: none;
	background: url(litscloud/images/zh_33.jpg) repeat-x bottom;
	border-right: 2px solid #fff;
	color: #404040;
	font-weight: bold;
}

.fais_list td {
	border-bottom: dotted 1px #80b2ff;
	border-top: dotted 1px #80b2ff;
	padding: 10px 0px;
	background: #fafcff;
	vertical-align: middle;
	text-align: center;
	font-size: 12px;
	color: #404040;
}

.fais_txt {
	width: 40px;
	text-align: right;
	padding-right: 5px;
	color: #404040;
}

.fais_chen {
	font-size: 18px !important;
	color: #f60 !important;
	font-weight: bold !important;
}

.fais_pir {
	width: 328px;
	height: auto;
	overflow: hidden;
	text-align: left !important;
}

.fais_pir_l {
	width: 76px;
	height: 76px;
	float: left;
	margin: 0px 10px;
}

.fais_pir_l img {
	width: 75px;
	border: solid 1px #fcfcfc;
	height: 75px;
}

.fais_pir_r {
	width: 220px;
	float: left;
	height: auto;
}

.fais_pir_r h1 {
	width: 220px;
	height: 22px;
	line-height: 22px;
	margin-bottom: 3px;
	font-weight: normal;
}

.fais_pir_r a {
	color: #3366cc;
	font-size: 12px;
}

.fais_pir_r a:hover {
	text-decoration: underline;
}

.fais_pir_r h2 {
	line-height: 20px;
	color: #666;
	margin-bottom: 3px;
	width: 220px;
	font-size: 12px;
	font-weight: normal;
}

.fais_pir_r span {
	width: 220px;
	color: #999;
	font-size: 12px;
	margin-top: 3px;
}

.fais_jz td {
	background: #f2f7ff;
	border-right: solid 1px #fff;
	border-bottom: solid 1px #fff;
	color: #404040;
	padding: 5px 0px;
	line-height: 25px;
	font-size: 12px;
}

.ly_fir {
	width: 350px;
	color: #666;
	font-size: 12px;
}

.fais_td {
	text-indent: 30px;
}

.fai_jz_r {
	float: right;
	margin: 0px 10px;
	font-weight: bold;
	font-size: 14px;
	color: #444;
	font-style: normal;
}

.fai_chen {
	color: #f60 !important;
}

.fais_sele {
	width: 145px;
	color: #444;
	font-size: 12px;
	margin: 0px 25px;
	height: 22px;
	line-height: 22px;
}

.fai_time {
	color: #404040;
	margin: 0px 25px;
}

.fais_xz {
	width: 100%;
	text-align: right;
	color: #404040;
	font-size: 12px;
	line-height: 25px;
	height: 25px;
	margin-bottom: 8px;
	margin-top: 5px;
}

.fais_xz label {
	padding-left: 30px;
	display: block;
	float: right;
}

.fais_xz input {
	margin-top: 6px;
	float: left;
}

.fais_xc {
	float: right;
	border: solid 1px #a0cb18;
	background: #bbe049;
	padding: 3px;
}

.fais_xcc {
	padding: 1px 10px 10px 20px;
	background: #fff;
	color: #404040;
	font-size: 12px;
	height: auto;
	overflow: hidden;
}

.fais_xcc_t {
	text-align: right;
	font-size: 12px;
	font-weight: bold;
	color: #404040;
	display: block;
	margin-top: 2px;
	margin-bottom: 10px;
}

.fais_xcc_t span {
	color: #999;
	font-size: 28px;
	font-weight: bold;
}

.fais_xcc_t em {
	font-size: 28px;
	font-weight: bold;
	font-style: normal;
}

.fais_xcc ul {
	margin: 0px padding : 0px;
}

.fais_xcc ul li {
	display: block;
	font-size: 12px;
	margin-bottom: 5px;
	color: #404040;
	font-size: 12px;
	text-align: right;
}

.fais_xcc ul li span {
	font-weight: bold;
}

.fais_xd {
	margin-top: 10px;
	text-align: right;
	height: 36px;
}

.fais_xdm {
	width: 141px;
	float: right;
	height: 36px;
	background: url(litscloud/images/log_43.gif) no-repeat;
	text-align: center;
	line-height: 35px;
	color: #fff;
	font-size: 14px;
	font-family: "微软雅黑";
	font-weight: bold;
}

.fais_xdm a {
	color: #fff;
	font-size: 14px;
	font-family: "微软雅黑";
	font-weight: bold;
}

.fais_xm {
	background: url(litscloud/images/log_13.gif) no-repeat left center;
	line-height: 22px;
	color: #404040;
	font-size: 12px;
	text-indent: 18px;
	float: right;
	margin-right: 0px;
	margin-top: 10px;
	border-bottom: solid 1px #f6f6f6;
}
</style>
		<!-- 解决IE6不缓存背景图片的问题-->
		<script type="text/javascript">
function set_address(c1,c2){
	alert(c1);
	alert(c2);
	alert(1232145);
	$("#delivery_addr_to").html("<span>寄送至：</span>"+c1);
	$("#delivery_addr_person").html("<span>收货人：</span>"+c2);
	$("#address_msg").html("<div class='address_cg'><p>设置成功</p></div>");
	
}
function check_out(num,price){
	//alert(num);
	//alert(price);
	num = $.trim(num);
  if( num == ''){
  	alert("请填写数量!");
  	$("#sgcount").focus();
  	return;
  }
  var regex = /^\d+$/;
  if(num == '0' ||  !regex.test(num)){
  	alert("请正确填写数量!");
  	$("#sgcount").focus();
  	return;
  }
	
	$("#sgprice_text").html(price*num);
	var delivery_price = $("#delivery_price").val();
	check_totalpay(num,price,delivery_price);
}
function  check_totalpay(num,sgprice,deliveryprice){
	alert(num);
	alert(sgprice);
	alert(deliveryprice);
	var total = num*sgprice+deliveryprice*1;
	
	$("#totalpay").html(total);
}
function get_deliveryprice(id){
	var delivery_price = 0;
	$("#delivery_pay").val(delivery_price);
	$("#delivery_price").val(delivery_price);
	var num = $("#sgcount").val();
	var price = $("#permoney").val();
	check_totalpay(num,price,delivery_price);
}

function submitorder(){
	//订单号 商品id 规格 地址 快递 留言 总价 单价 数量
	var isdelivery = $("#isdelivery").val();
	//var delivery = $('input:radio[name="radio"]:checked').val();
	var delivery = $("input:radio[name='delivery_address']:checked").val();
	alert(delivery);
	var delivery_type = $("#delivery_type").val();
	alert(isdelivery);
	if(isdelivery == '1' && delivery == undefined){
		alert("请填写收货地址!");
		return ;
	}
	
	var num = $("#sgcount").val();
	if( num == ''){
  	alert("请填写数量!");
  	$("#sgcount").focus();
  	return;
  }
  var regex = /^\d+$/;
  if(num == '0' ||  !regex.test(num)){
  	alert("请正确填写数量!");
  	$("#sgcount").focus();
  	return;
  }
  
  if(isdelivery == '1' && delivery_type == ''){
		alert("请请选择运送方式!");
		return ;
	}
	
	$("#orderform").submit();
}

</script>
	</head>
	<body>
		<div class="ly_body">
			<!--头部公用代码-->
			<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
			<!--内容开始-->
			<div class="ly_imiddle" style="margin-top: 0px;">
				<div class="ly_dh" style="height: 4px; line-height: 4px;"></div>
				<div class="ly_n_login">
					<div class="bg_t">
						当前位置：
						<a href="litscloud/ucenter/index.jsp" target="_parent">会员中心</a>>订单确认
					</div>
					<div class="bg_ping">
						<form action="litscloud/ucenter/saveorderCustomerServerC.Action"
								method="post" id="orderform" name="orderform">
						<div class="bg_ping_t">
							确认收货地址
						</div>
						<div class="bg_ping_cc">
							<div class="bg_ping_cl"></div>
							<div class="bg_ping_cr"></div>
						</div>
						<div class="bg_ping_d address_list">
							<ul>
								<c:if test="${so.isDelivery == null || so.isDelivery == 0}">
									<li>
										该商品不需要发货
									</li>
								</c:if>
								<c:forEach items="${deliverylist}" var="dd" varStatus="i">
									<li>
										<c:if test="${i.index == 0}">
											<div class="address_zhij">
												送货至
											</div>
										</c:if>
										<div class="address_list_right">
											<a href="javascript:void(0);" class="address_list_r">修改本地址</a>
											<input type="radio" name="delivery_address"
												id="delivery_address"
												onclick="set_address('${dd.netherlands }  ${dd.particularAddress}','${dd.consignee } ${dd.mobile }')"
												value="${dd.netherlands }&nbsp;&nbsp;${dd.particularAddress}&nbsp;&nbsp;(${dd.consignee }收) <em>${dd.mobile}</em>" />
											<label for="xx1" class="address_labe">
												${dd.netherlands
												}&nbsp;&nbsp;${dd.particularAddress}&nbsp;&nbsp;(${dd.consignee
												}收)
												<em>${dd.mobile}</em>
											</label>
											<c:if test="${dd.def == 1 }">
												<em class="address_moren">默认地址</em>
											</c:if>
											<!-- <a href="#" class="address_shezhi">设置默认收货地址</a> -->
										</div>
									</li>
								</c:forEach>
								<li><a href="javascript:void(0);" onclick="" title="点击新增收货地址">新增地址</a> <span id="address_msg"></span>
								</li>
							</ul>
						</div>
							<!-- 
							<div class="address_list_right">
			                  <a href="#" class="address_list_r">修改本地址</a>
			                   <input type="radio" value="xx1" name="que_address" id="xx1" /> <label for="xx1" class="address_labe">广东省 深圳市 宝安区 西乡大道F518时尚创意园F7栋201 (王海飞 收) <em>13410333355</em></label><em class="address_moren">默认地址</em><a href="#" class="address_shezhi">设置默认收货地址</a>
			                   </div>
			                   <div class="address_cg"><p>设置成功</p></div>
			                  </li>
			                   <li>
			                  <div class="address_zhij" style="display:none;">送货至</div>
			                  <div class="address_list_right">
			                  <a href="#" class="address_list_r">修改本地址</a>
			                   <input type="radio" value="xx1" name="que_address" id="xx1" /> <label for="xx1" class="address_labe">广东省 深圳市 宝安区 西乡大道F518时尚创意园F7栋201 (王海飞 收) <em>13410333355</em></label><em class="address_moren" style="display:none;">默认地址</em><a href="#" class="address_shezhi">设置默认收货地址</a>
			                   </div>
			                   <div class="address_cg" style="display:none;"><p>设置成功</p></div>
			                  </li>
			                   <li>
			                  <div class="address_zhij" style="display:none;">送货至</div>
			                  <div class="address_list_right">
			                  <a href="#" class="address_list_r">修改本地址</a>
			                   <input type="radio" value="xx1" name="que_address" id="xx1" /> <label for="xx1" class="address_labe">广东省 深圳市 宝安区 西乡大道F518时尚创意园F7栋201 (王海飞 收) <em>13410333355</em></label><em class="address_moren" style="display:none;">默认地址</em><a href="#" class="address_shezhi">设置默认收货地址</a>
			                   </div>
			                   <div class="address_cg" style="display:none;"><p>设置成功</p></div>
			                  </li>
			                </ul>     
			              </div>
				 -->
							
							
							
							<div class="bg_ping_t">
								确认订单信息
							</div>
							<div class="bg_ping_cc">
								<div class="bg_ping_cl"></div>
								<div class="bg_ping_cr"></div>
							</div>
							
								<s:token></s:token>
								<input type="hidden" name="sgid" value="${sgid }" />
								<input type="hidden" name="socode" value="${so.soNums }" />
								<input type="hidden" name="sgcode" value="${sgcode }" />
								<input type="hidden" name="spec_checkstr" value="${so.spec}" />
								<input type="hidden" id="permoney" name="permoney" value="${permoney}" />
								<input type="hidden" id="isdelivery" name="isdelivery" value="${so.isDelivery}" />
								<input type="hidden" id="delivery_price" name="delivery_price" value="0" />
								<div class="bg_ping_d">
									<table class="fais" border="0" cellpadding="0" cellspacing="0">
										<thead>
											<tr>
												<th width="35">
													商品
												</th>
												<th width="15%">
													单价（元）
												</th>
												<th width="17%">
													数量
												</th>
												<th width="15%">
													优惠方式（元）
												</th>
												<th width="18%">
													小计（元）
												</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="5" style="height: 10px;"></td>
											</tr>
											<tr class="fais_list">
												<td>
													<div class="fais_pir">
														<div class="fais_pir_l">
															<a
																	href="litscloud/web/detailOfGoods2CustomerServerC.Action?sgcode='${sgcode }'" target="_blank"><img
																	src="litscloud/images/bg_29.png" alt="xx" title="xx" />
															</a>
														</div>
														<div class="fais_pir_r">
															<h1>
																<a
																	href="litscloud/web/detailOfGoods2CustomerServerC.Action?sgcode='${sgcode }'"
																	target="_blank"></a>
															</h1>
															<h2>
																商品编号：<a
																	href="litscloud/web/detailOfGoods2CustomerServerC.Action?sgcode='${sgcode }'"
																	target="_blank">${sgcode }</a>
															</h2>
															<h3>
																<img src="litscloud/images/bg_30.png" alt="xx"
																	title="xx" />
															</h3>
															<span>规格：${so.spec}</span>
														</div>
													</div>
												</td>
												<td>
													${permoney }
												</td>
												<td>
													<input type="text" value="${so.count }" id="sgcount"
														name="sgcount" onblur="check_out(this.value,${permoney })"
														class="fais_txt" />
												</td>
												<td>
													无
												</td>
												<td class="fais_chen" style="border-right: solid 1px #fff;"
													id="sgprice_text">
													${price}
												</td>
											</tr>
											<tr class="fais_jz">
												<td colspan="2" rowspan="3"
													style="vertical-align: top; text-indent: 20px;">
													给卖家留言：
													<input type="text" value="选填：对本次交易的补充说明（建议填写已经和卖家达成一致的说明）"
														id="leave_msg" name="leave_msg" class="ly_fir" />
												</td>
												<td colspan="3" class="fais_td">
													<!-- <em class="fai_jz_r">-0.00</em>-->
													店铺优惠：
												</td>
											</tr>
											<tr class="fais_jz">
												<td colspan="3" class="fais_td">
													<em class="fai_jz_r fai_chen" id="delivery_pay">0.00</em>运送方式：
													<c:if test="${so.isDelivery == null || so.isDelivery == 0}">无需发货</c:if>
													<c:if test="${so.isDelivery == 1}">
														<select class="fais_sele" id="delivery_type"
															name="delivery_type"
															onchange="get_deliveryprice(this.id)">
															<option value="">
																请选择快递
															</option>
															<option value="卖家包快递费">
																卖家包快递费
															</option>
														</select>
													</c:if>
												</td>
											</tr>
											<tr class="fais_jz">
												<td colspan="3" class="fais_td">
													发货时间：
													<span class="fai_time">卖家承诺订单在买家付款后，尽快发货</span>
												</td>
											</tr>
											<tr>
												<td colspan="5" align="right" valign="top">
													<!-- <div class="fais_xz"><label><input type="checkbox" />信用卡分期付款</label><label><input type="checkbox" />匿名购买</label><label><input type="checkbox" />找人代付</label></div> -->
													<div style="width: 100%; overflow: hidden;">
														<div class="fais_xc">
															<div class="fais_xcc">
																<div class="fais_xcc_t">
																	实付款：
																	<span>￥</span><em class="fai_chen" id="totalpay">${mount*permoney }</em>
																</div>
																<ul>
																	<li id="delivery_addr_to">
																		<span>寄送至：</span>
																	</li>
																	<li id="delivery_addr_person">
																		<span>收货人：</span>
																	</li>
																</ul>
															</div>
														</div>
													</div>
													<div class="fais_xd">
														<div class="fais_xdm">
															<a href="javascript:void(0);" onclick="submitorder()">提交订单</a>
														</div>
													</div>
													<div style="width: 100%; overflow: hidden;">
														<div class="fais_xm">
															若价格变动，请在提交订单后联系卖家改价，并查看已买到的宝贝
														</div>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
						</div>
						</form>
					</div>
				</div>

				<div class="ly_n_weibu" style="margin-bottom: 50px;"></div>
			</div>


			<!--底部公用代码 -->
			<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
			<!-- 底部结束 -->
		</div>
	</body>
</html>
