<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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

dl,dd,dt,p,input {
	padding: 0px;
	margin: 0px;
}

.dow {
	width: 760px;
	height: 230px;
	float: left
}
.main { width:760px; margin:0}
.top_cx{width: 760px;
	margin-top:15px;
	margin-bottom:15px;
	}
.top_cx td{font-size: 12px;}
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
	border: 0px solid #455c32;
	float: left
}
.dow_nr td{font-size: 12px;}
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
	color: #5da500;
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
	border-right: 1px solid #c3c3c3;
	color: 
}

/*hongbinma */
ul  ,ul li {
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

.wzdh {
	line-height: 25px;
}

.wzls {
	color: #3b8801;
}

.wzcs {
	color: #ff6600;
}

.tab ul li {
	width: 90px;
	line-height: 25px;
	float: left;
	text-align: center;
	background-color: #E8E8E8;
	margin-left: 2px;
}

.tab ul  .active {
	background-color: #4FA805;
	color: #fff;
	font-size: 13px;
}

.tab div {
	clear: both;
	border-top: 1px solid #4FA805;
}

.gb_bt {
	background-color: #4FA805;
	font-weight: bold;
	color: #fff;
	width: 60px;
	line-height: 25px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

.msg_green {
	border: #4FA805 1px solid;
	line-height: 20px;
	background-color: #FFF;
	width: 223px;
}

.msgshow_green .c2 {
	background: url(images/c2.png) no-repeat 100px 0px;
	height: 11px;
	position: relative;
	margin-bottom: -1px;
	z-index: 1;
}

.size {
	font-size: 12px;
}

.dvr {
	float: right;
	margin-right: 5px;
}

#bgzy_bk {
	border-left: 1px solid #c3c3c3;
	border-right: 1px solid #c3c3c3;
}
</style>
		<div class="dow">
			<div class="main">
				<div class="wzdh">
					<span class="wzls">您的位置</span>：首页&gt;工作日志&gt;
					<span class="wzcs">日志管理</span>
				</div>
			</div>
			<div style="line-height: 50px;" class="top_cx">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="70%">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="right">
													选择部门
												</td>
												<td>
													<form id="form1" name="form1" method="post" action="">
														<label for="select"></label>
														<select name="select" id="select">
														<option>xxxx</option>
														<option>yyy</option>
														<option>zzzz</option>
														</select>
													</form>
												</td>
											</tr>
										</table>
									</td>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="right">
													选择员工
												</td>
												<td>
													<form id="form2" name="form2" method="post" action="">
														<label for="select2"></label>
														<select name="select2" id="select2">
														<option>xxxx</option>
														<option>yyy</option>
														<option>zzzz</option>
														</select>
													</form>
												</td>
											</tr>
										</table>
									</td>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td align="right">
													选择时间
												</td>
												<td>
													<form id="form3" name="form3" method="post" action="">
														<label for="textfield"></label>
														<input name="textfield" type="text" id="textfield"
															size="10" />
													</form>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
						<td width="30%">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="31%">
										<div class="gb_bt">
											查询
										</div>
									</td>
									<td width="41%">
										<div class="gb_bt">
											批量批阅
										</div>
									</td>
									<td width="28%">
										<div class="gb_bt">
											对比
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div class="dow_nr">
				<div class="outline tab">
					<ul>
						<li class="active">
							日志列表
						</li>
						<li>
							周志列表
						</li>
						<li>
							月志列表
						</li>
					</ul>
					<div class="content_1">

					</div>
				</div>
				<table width="100%" border="0" cellspacing="0" height="339"
					cellpadding="0" id="bgzy_bk">

					<tr>
						<td width="58" height="26" align="center" class="tc_top tc_rightb">
							选择
						</td>
						<td width="80" height="26" align="center" class="tc_top tc_rightb">
							姓名
						</td>
						<td width="54" height="26" align="center" class="tc_top tc_rightb">
							部门
						</td>
						<td width="88" height="26" align="center" class="tc_top tc_rightb">
							职位
						</td>
						<td width="136" height="26" align="center"
							class="tc_top tc_rightb">
							时间
						</td>
						<td width="113" height="26" align="center"
							class="tc_top tc_rightb">
							领导批注
						</td>
						<td width="132" height="26" align="center"
							class="tc_top tc_rightb">
							内容
						</td>
						<td width="132" align="center" class="tc_top tc_rightb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="58" height="26" align="center"
							class="tc_rightb tc_footb">
							<form id="form4" name="form4" method="post" action="">
								<input type="checkbox" name="checkbox" id="checkbox" />
								<label for="checkbox"></label>
							</form>
						</td>
						<td width="80" height="26" align="center"
							class="tc_rightb tc_footb">
							小夏
						</td>
						<td width="54" height="26" align="center"
							class="tc_rightb tc_footb">
							男
						</td>
						<td width="88" height="26" align="center"
							class="tc_rightb tc_footb">
							本科
						</td>
						<td width="136" height="26" align="center"
							class="tc_rightb tc_footb">
							13268829668
						</td>
						<td width="113" height="26" align="center"
							class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td width="132" height="26" align="center"
							class="tc_rightb tc_footb">
							业务
						</td>
						<td width="132" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="58" height="26" align="center"
							class="tc_rightb tc_footb">
							<form id="form5" name="form5" method="post" action="">
								<input type="checkbox" name="checkbox2" id="checkbox2" />
								<label for="checkbox2"></label>
							</form>
						</td>
						<td width="80" height="26" align="center"
							class="tc_rightb tc_footb">
							小夏
						</td>
						<td width="54" height="26" align="center"
							class="tc_rightb tc_footb">
							男
						</td>
						<td width="88" height="26" align="center"
							class="tc_rightb tc_footb">
							本科
						</td>
						<td width="136" height="26" align="center"
							class="tc_rightb tc_footb">
							13268829668
						</td>
						<td width="113" height="26" align="center"
							class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td width="132" height="26" align="center"
							class="tc_rightb tc_footb">
							业务
						</td>
						<td width="132" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="58" height="26" align="center"
							class="tc_rightb tc_footb">
							<form id="form6" name="form6" method="post" action="">
								<input type="checkbox" name="checkbox3" id="checkbox3" />
								<label for="checkbox3"></label>
							</form>
						</td>
						<td width="80" height="26" align="center"
							class="tc_rightb tc_footb">
							小夏
						</td>
						<td width="54" height="26" align="center"
							class="tc_rightb tc_footb">
							男
						</td>
						<td width="88" height="26" align="center"
							class="tc_rightb tc_footb">
							本科
						</td>
						<td width="136" height="26" align="center"
							class="tc_rightb tc_footb">
							13268829668
						</td>
						<td width="113" height="26" align="center"
							class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td width="132" height="26" align="center"
							class="tc_rightb tc_footb">
							业务
						</td>
						<td width="132" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td width="58" height="26" align="center"
							class="tc_rightb tc_footb">
							<form id="form7" name="form7" method="post" action="">
								<input type="checkbox" name="checkbox4" id="checkbox4" />
								<label for="checkbox4"></label>
							</form>
						</td>
						<td width="80" height="26" align="center"
							class="tc_rightb tc_footb">
							小夏
						</td>
						<td width="54" height="26" align="center"
							class="tc_rightb tc_footb">
							男
						</td>
						<td width="88" height="26" align="center"
							class="tc_rightb tc_footb">
							本科
						</td>
						<td width="136" height="26" align="center"
							class="tc_rightb tc_footb">
							13268829668
						</td>
						<td width="113" height="26" align="center"
							class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td width="132" height="26" align="center"
							class="tc_rightb tc_footb">
							业务
						</td>
						<td width="132" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<form id="form8" name="form8" method="post" action="">
								<input type="checkbox" name="checkbox5" id="checkbox5" />
								<label for="checkbox5"></label>
							</form>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							<a>查看批注</a>
						</td>
						<td height="26" align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
						<td align="center" class="tc_rightb tc_footb">
							&nbsp;
						</td>
					</tr>
					<tr>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="24%" height="31" align="left">
							<form id="form9" name="form9" method="post" action="">
								<label for="checkbox6"></label>
								<input type="checkbox" name="checkbox6" id="checkbox6" />
								全选&nbsp;&nbsp; 反选&nbsp;&nbsp; 删除
							</form>
						</td>
						<td width="76%">
							[ 共 200 条记录
							<a href="#">首页</a>
							<a href="#">上一页</a>
							<a href="#">下一页</a>
							<a href="#">尾页</a> 页数：1/30页
							<input name="" type="text" size="5" />
							条记录/页 &nbsp;&nbsp;&nbsp;&nbsp;转到
							<input name="" type="text" size="5" />
							页&nbsp;&nbsp;&nbsp;&nbsp;打印]
						</td>
					</tr>
				</table>
			</div>
		</div>
