<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>客户服务平台</title>

		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<style type="text/css">

* {
	margin: 0;
	padding: 0
}

html {
	overflow-y: scroll
}

body {
	font-size: 12px;
	background: #fff;
	color: #333
}

ul,ol {
	list-style: none
}

a {
	text-decoration: none;
	color: #f30
}

img {
	border: none
}

.clearfix {
	zoom: 1
}

.clearfix:after {
	content: "";
	display: block;
	height: 0;
	line-height: 0;
	font-size: 0;
	visibility: hidden;
	clear: both
}

.padding_con {
	line-height: 150px;
	text-align: center
}

.hd_wrap {
	background: #333;
	border-top: 3px solid #f30;
	zoom: 1;
	height: 35px;
	line-height:35px;
	text-align:right;
}
.hd_wrap img{vertical-align:middle;}
.header,.ct_wrap,.ft_wrap {
	width: 950px;
	margin: 0 auto;
	zoom: 1
}

.ct_wrap {
	background: #e0e0e0
}

.header {
	height: 85px;
	line-height: 85px;
	color: #fff;
	border-bottom: 3px solid #f30;
	margin-bottom: -3px;
	position: relative;
	background: #333
	font-family: 'Helvetica Neue', 'Luxi Sans', 'DejaVu Sans', Tahoma, 'Hiragino Sans GB', STHeiti, 'Microsoft YaHei', Arial, sans-serif; 
	display: block;
	text-decoration: none; 
	margin: 0px; 
	padding: 2px 6px 2px 6px; 
	align:center;
	}

.content {
	margin-left: 180px;
	border-left: 1px solid #333;
	background: #fff
}

.main_col {
	float: left;
	width: 100%;
	word-wrap: break-word
}

.side_col {
	float: left;
	width: 180px;
	margin-left: -950px;
	position: relative;
	word-wrap: break-word
}

.ft_wrap {
	border-top: 2px solid #333;
	zoom: 1
}

.footer {
	text-align: center;
	padding: 10px 0
}

#wrap {
	display: block;
	bottom: 0px;
	left: 180px !important;
	position: fixed;
	text-align: left;
	color: #fff;
	background: #e5e5e5;
}

/*动态菜单*/
#vnav {
	width: 270px;
	float: left;
}

li {
	font-size: 14px;
	font-weight: bold;
	height: 20px;
	width: 145px;
	overflow: hidden;
	color: #fff;
	text-decoration: none;
	font-weight: bold;
	line-height: 1;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-box-shadow: 0 1px 3px #999;
	-webkit-box-shadow: 0 1px 3px #999;
	text-shadow: 0 -1px 1px #222;
	border-bottom: 1px solid #222;
	padding: 7px 10px 6px;
	margin-top: 5px;
	background-color: #696969;
}

li p {
	margin-top: 14px;
	font-size: 12px;
	color: #7fff00;
}

#vnav span,#vnav  a:active,#vnav  a:visited,#vnav  a:link {
	font-family: 'Helvetica Neue', 'Luxi Sans', 'DejaVu Sans', Tahoma,
		'Hiragino Sans GB', STHeiti, 'Microsoft YaHei', Arial, sans-serif;
	display: block;
	text-decoration: none;
	margin: 6px 0px 6px 0px;
	padding: 2px 0px 2px 0px;
	color: #fff;
	background-color: #000;
	border: 1px solid #696969;
}

#vnav  a:hover {
	color: #7cfc00;
	background-color: #000;
}

#vnav  span {
	color: #dcdcdc;
}
</style>
		<script type="text/javascript">
function reinitIframe() {
	var iframe = document.getElementById("win");
	try {
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		if (bHeight < 800) {
			bHeight = 800;
		}
		iframe.height = parseInt(bHeight) + 150;
	} catch (ex) {
	}
}

//window.setInterval("reinitIframe()", 200);
</script>
		<script
			src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"
			type="text/javascript"><!--mce:0--></script>
		<script src="<%=request.getContextPath()%>/js/custom.js"
			type="text/javascript"></script>
		<script src="<%=request.getContextPath()%>/js/jquery.easing.1.3.js"
			type="text/javascript">
		<!--mce:0-->
		</script>
	</head>

	<body
		onload="parent.document.all.win.height=this.document.body.scrollHeight+100;">
		<div class="hd_wrap">
		<div style="width:950px; margin:0 auto;">
		<img  src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/yh.png"
			width="22" height="22" style="border: 0px;" />
			<FONT color=#F9F9F1>用户名:</FONT>
			
			<c:if test="${customer != null}">
			<FONT color=#F9F9F1 >${customer.customerName }</FONT>
			</c:if>
			<img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/coins.png"
			width="22" height="22" style="border: 0px;" />	
			<FONT color=#F9F9F1>可用余额：</FONT>
			<span style="font-family: 'Helvetica Neue', 'Luxi Sans', 'DejaVu Sans', Tahoma, 'Hiragino Sans GB', STHeiti, 'Microsoft YaHei', Arial, sans-serif; font-size: 12px; font-weight: normal;"><FONT color=#F9F9F1 style="font-weight: bold;">***.元</FONT></span>
			<A href="<%=path%>/foreGroundFolder/customProscenium/onlinepay.jsp" target=right>充值</A>
		<a href="exitCustomerServer.Action" class="news"><FONT color=#FF0000>安全退出</FONT></a>
		</div>
			</div>
			<!-- 已登录 end -->

			<c:if test="${customer == null}">
				<!-- 未登录 start -->
				<div class="header">
					<div style="width: 990px; height: 100px;">
						<div style="float: left; width: 590px; float: left; height: 100px;">
						</div>
						<!--右边的层start-->
						<div
							style="float: left; width: 400px; float: left; height: 100px;">
							<div style="width: 400px; height: 40px;"></div>
							<div style="width: 400px; height: 30px;">
								<!--用户名start-->
								<div style="width: 100px; height: 30px; float: left;">
									<div style="float: left;">
										<img src="<%=path%>/images/dl01.gif" width="64" height="20"
											style="border: 0px;" />
									</div>
								</div>
								<!--用户名end-->
								<!--账户余额start-->
								<div style="width: 90px; height: 30px; float: left;">
									<div style="float: left;">
										<img src="<%=path%>/images/dl02.gif" width="64" height="20"
											style="border: 0px;" />
									</div>
								</div>
								<!--账户余额end-->
								<!--安全退出start-->
								<div style="width: 200px; height: 30px; float: left;">
									<div style="float: left; margin-top: 5px;">
										<a href="#">全国服务器供应商前十强</a>
									</div>
								</div>
								<!--安全退出end-->
							</div>
						</div>
						<!--右边的层end-->
					</div>
				</div>
				<!-- 未登录 end -->
			</c:if>
		</div>
		</div>
		<div class="ct_wrap">
			<div class="content clearfix">
				<div class="main_col">
					<div class="padding_con">
<iframe onload="reinitIframe();" id="win" style="border: 0px"
							frameborder="0" name="right" width="100%" height="95%"
							scrolling="no"
							src="<%=path%>/foreGroundFolder/customProscenium/customerservicer.jsp"></iframe>
					</div>
					<!-- 
					<div class="padding_con">
						</div>
					<div class="padding_con">
						不管有几个我，右边看起来总是和左边一样高
					</div>
					 -->
				</div>
				<div class="side_col">
					<div class="padding_con">
												<div id="vnav">
							<ul>
								<li>
									<A
										href="select1saleOrder.Action?userName=${customer.customerName}&deadline=suoyou"
										target=right>IDC业务管理</A>
									<p>
										虚拟主机/VPS/IDC业务单
									</p>
								</li>
								<li>
									<A href="showOrderaddCDNsaleOrderAction.Action" target=right>CDN业务管理</A>
									<p>
										CDN申请,自助配置
									</p>
								</li>
								<li>
									<A
										href="<%=path%>/foreGroundFolder/customProscenium/updatecache.jsp"
										target=right>CDN内容刷新</A>
									<p>
										刷新CDN缓存
									</p>
								</li>
								<li>
									<!-- 
									<A
										href="<%=path%>/foreGroundFolder/customProscenium/subnote.jsp"
										target=right>提交在线工单</A>
									 -->
									<A
										href="<%=path%>/gosubnoteMalfunctionDeclare.Action"
										target=right>提交在线工单</A>
									<p>
										工单限时标准化服务
									</p>
								</li>
								<li>
									<A href="selectComMalfunctionDeclare.Action" target=right>评价客服</A>
									<p>
										为客服人员的服务评分
									</p>
								</li>
								<li>
									<A
										href="selmessbyreadflag1message.Action?readflag=2&determine=2"
										target=right>系统公告通知</A>
									<p>
										业务相关信息通知,提醒
									</p>
								</li>
								<li>
									<A
										href="<%=path%>/foreGroundFolder/customProscenium/mydata.jsp"
										target=right>我的信息管理</A>
									<p>
										单位及联系人资料
									</p>
								</li>
								<li>
									<A
										href="<%=path%>/foreGroundFolder/message/customer/sendmessage.jsp"
										target=right>投诉&建议</A>
									<p>
										向主管人员投诉及提出建议
									</p>
								</li>
								<li>
									<A
										href="<%=path%>/foreGroundFolder/customProscenium/onlinepay.jsp"
										target=right>财务管理</A>
									<p>
										在线付款,财务收支
									</p>
								</li>
								<!-- 
								<li>
									<A href="goAddSale.Action"
										target=right>单据模块</A>
									<p>
										<a href="<%=path%>/orderTemplate/orderList.jsp"
										target=right>单据列表</a>
										</p>
										
									
								</li>
								 -->
								<li>
									<A href="exitCustomerServer.Action">安全退出系统</A>
									<p>
										清除登陆数据,安全退出系统
									</p>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ft_wrap">
			<div class="footer">
				CopyRight  2008-2011 by FUAO INC.
			</div>
		</div>
<!-- 
		<div id="wrap">
			<TABLE width=990px border=0 cellSpacing=0 cellPadding=0 align=center>
				<TBODY>
					<TR>
						<TD colSpan=7>
							<IMG
								src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help_top.png"
								width=998 height=11>
						</TD>
					</TR>
					<TR>
						<TD>
							<A href="javascript:void(0)" target=_blank><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_01.gif">
							</A>
						</TD>
						<TD>
							<A href="javascript:void(0)"><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_02.gif">
							</A>
						</TD>
						<TD>
							<A href="javascript:void(0)"><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_03.gif">
							</A>
						</TD>
						<TD>
							<A href="javascript:void(0)"><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_04.gif">
							</A>
						</TD>
						<TD>
							<A href="javascript:void(0)"><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_05.gif">
							</A>
						</TD>
						<TD>
							<A href="<%=path%>/foreGroundFolder/customProscenium/subnote.jsp"
								target=right><IMG border=0
									src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help01_06.gif">
							</A>
						</TD>
					</TR>
					<TR>
						<TD colSpan=6>
							<IMG
								src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/help_bottom.png"
								width=998 height=14>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</div>
		 -->
<!-- 在线客服 -->
<link rel="stylesheet" type="text/css" href="<%=path %>/Css/kfcss/css.css"/>
<link rel="stylesheet" type="text/css" href="http://127.0.0.1:8087/setup-style.css">
<script language="javascript" type="text/javascript"	src="http://127.0.0.1:8087/js/tooltips/domLib.js"></script>
<script language="javascript" type="text/javascript"	src="http://127.0.0.1:8087/js/tooltips/domTT.js"></script>
<script language="JavaScript" type="text/javascript" src="http://127.0.0.1:8087/common.js"></script>
<script language="JavaScript" type="text/javascript" src="http://127.0.0.1:8087/jivelive.jsp"></script>
<script type="text/javascript"	src="http://127.0.0.1:8087/kf2.jsp?regname=${customer.customerName }"></script>
	</body>
</html>
