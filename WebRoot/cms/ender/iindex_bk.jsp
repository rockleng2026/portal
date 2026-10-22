<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
		<title>首页</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="cms/ender/css/style.css" rel="stylesheet" type="text/css" />
		<script src="cms/ender/js/jquery.js" type="text/javascript"></script>
		<script src="cms/ender/js/zzsc.js" type="text/javascript"></script>
		<script type="text/javascript" src="cms/ender/js/lrtk.js"></script>

	</head>

	<body>
		<!-- 弹层之后的遮罩背景层div -->
		<div class="tcbj" style="display: none;"></div>
		<!-- 弹层完毕 -->
		<div class="bodyer">
			<!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->

			<!-- 头部start -->
			<jsp:include page="top.jsp"></jsp:include>
			<!-- 头部end -->
			<!-- t_bod结束 -->
			<div class="t_cod">
				<!-- 热卖产品 -->
				<div class="bod_width t_cod_mar">
					<h1 class="bod_width t_cod_title">
						热卖产品
						<br />
						<span>HOT PRODUCTS</span>
					</h1>
					<div class="bod_width t_cod_x">
						<div class="t_cod_xl">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
						<div class="t_cod_xr">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
					</div>
					<!--xx -->
					<div id="zzsc">
						<a class="pre"></a>
						<div id="wai_box">
							<div class="zzsc_box">
								<ul>
									<div class="zzsc_box_left">
										<div class="zzsc_box_pad zzsc_box_left_img">
											<c:forEach  items="${syrmtj}" var="ss" begin="0" end="0" >
											<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
												target="_blank"><img src="${ss.info_imgSrc }"
													title="${ss.news.title }" alt="${ss.news.title }"  width="294" height="360"/>
											</a>
											</c:forEach>
											<!--热卖图片大小294px*356px -->
										</div>
									</div>
									<!--热卖图片大小185px*225px -->
									<div class="zzsc_box_right">
										<ol>
											<c:forEach  items="${syrmtj}" var="ss" begin="1" end="2" >
												<li class="zzsc_box_pad"
												onmouseover="this.className='zzsc_box_pad zzsc_box_h1'"
												onmouseout="this.className='zzsc_box_pad'">
												<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
													target="_blank"><img src="${ss.info_imgSrc }"
														title="${ss.news.title }" alt="${ss.news.title }"  width="185" height="225"/>
												</a>
												</li>
											</c:forEach>
											<c:forEach  items="${syrmtj}" var="ss" begin="3" end="3" >
												<li class="zzsc_box_pad zzsc_box_right_mar" >
												<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
													target="_blank"><img src="${ss.info_imgSrc }"
														title="${ss.news.title }" alt="${ss.news.title }"  width="185" height="225"/>
												</a>
												</li>
											</c:forEach>
										</ol>
										<!-- 推荐说明 -->
										<span>${syrmtjrec.temp }</span>
								</ul>
							</div>
						</div>
						<!--<a class="next"></a>-->
					</div>
					<div style="text-align: center; clear: both">
						<br />
					</div>

					<!-- xx完毕 -->
				</div>
				<!-- 热卖产品完毕 -->

				<!-- 推荐产品 -->
				<div class="bod_width t_cod_mar">
					<h1 class="bod_width t_cod_title">
						推荐产品
						<br />
						<span>RECOMMENDED PRODUCTS</span>
					</h1>
					<div class="bod_width t_cod_x">
						<div class="t_cod_xl">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
						<div class="t_cod_xr">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
					</div>
					<div class="bod_width rec_pot">
						<div class="rec_pot_l">
							<div class="rec_pot_t zzsc_box_pad">
								<c:forEach  items="${sytjcp}" var="ss" begin="0" end="0" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
										<img src="${ss.info_imgSrc }" title="${ss.news.title }" alt="${ss.news.title }" width="457" height="197"/>
										</a>	
								</c:forEach>
							</div>
							<!--推荐产品 图片大小455px*197px -->
							<div class="rec_pot_d">
								<ul>
									<li class="rec_pot_d_font">
										${sytjcprec.temp }
									</li>
									
									<li class="zzsc_box_pad">
										<c:forEach  items="${sytjcp}" var="ss" begin="1" end="1" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
											target="_blank"><img src="${ss.info_imgSrc }"  width="209" height="307"	alt="推荐产品" title="推荐产品" />
										</a>
										</c:forEach>
									</li>
									<!--推荐产品 图片大小209px*237px-->
								</ul>
							</div>
						</div>

						<!-- 右边 -->
						<div class="rec_pot_l" style="margin-right: 0px;">
							<div class="rec_pot_t zzsc_box_pad">
								<c:forEach  items="${sytjcp}" var="ss" begin="2" end="2" >
								<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank"><img
										src="${ss.info_imgSrc }" alt="推荐产品" title="推荐产品"   width="457" height="197" />
								</a>
								</c:forEach>
							</div>
							<!--推荐产品 图片大小455px*197px -->
							<div class="rec_pot_d">
								<ul>
									<c:forEach  items="${sytjcp}" var="ss" begin="3" end="3" >
									<li class="zzsc_box_pad" style="margin-right: 25px;">
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"><img
												src="${ss.info_imgSrc }" alt="推荐产品"  width="208" height="236" 
												title="推荐产品" />
										</a>
									</li>
									</c:forEach>
									<!--推荐产品 图片大小209px*237px-->
									<c:forEach  items="${sytjcp}" var="ss" begin="4" end="4" >
									<li class="zzsc_box_pad">
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"><img
												src="${ss.info_imgSrc }" alt="推荐产品毯" width="208" height="236" title="推荐产品" />
										</a>
									</li>
									</c:forEach>
									<!--推荐产品 图片大小209px*237px-->
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- 推荐产品完毕 -->

				<!-- 新品上市 -->
				<div class="bod_width t_cod_mar">
					<h1 class="bod_width t_cod_title">
						新品上市
						<br />
						<span>NEW ARRIVAL</span>
					</h1>
					<div class="bod_width t_cod_x">
						<div class="t_cod_xl">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
						<div class="t_cod_xr">
							<span><img src="cms/ender/image/ed_09.gif" alt="img" />
							</span>
						</div>
					</div>
					<div class="bod_width new_pot">
						<div class="new_pot_t">
							<div class="new_pot_tl">
								<ul>
									<li class="zzsc_box_pad">
										<c:forEach  items="${syxpss}" var="ss" begin="0" end="0" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
											target="_blank"><img src="${ss.info_imgSrc }"  
												alt="新品上市" title="新品上市"  width="210" height="156"/>
										</a>
										</c:forEach>
									</li>
									<!--新品上市 图片大小210px*156px -->
									<li class="zzsc_box_pad" style="margin: 0px;">
										<c:forEach  items="${syxpss}" var="ss" begin="1" end="1" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }"
											target="_blank"><img src="${ss.info_imgSrc }"  
												alt="新品上市" title="新品上市" width="212" height="156"/>
										</a>
										</c:forEach>
									</li>
									<!--新品上市 图片大小210px*156px -->
								</ul>
							</div>
							<div class="new_pot_tc zzsc_box_pad">
								<c:forEach  items="${syxpss}" var="ss" begin="2" end="2" >
								<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
								<img src="${ss.info_imgSrc }"  alt="新品上市" title="新品上市" width="455" height="351"/>
								</a>
								</c:forEach>
							</div>
							<!--新品上市 图片大小455px*351px -->
							<div class="new_pot_tl">
								<ul>
									<li class="zzsc_box_pad">
										<c:forEach  items="${syxpss}" var="ss" begin="3" end="3" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
										<img src="${ss.info_imgSrc }"  alt="新品上市" title="新品上市" width="210" height="156"/>
										</a>
										</c:forEach>
									</li>
									<!--新品上市 图片大小210px*156px -->
									<li style="margin: 0px; width: 218px;" class="rec_pot_d_font">
										新品上市，新鲜出炉，快来抢购，价格优惠
									</li>
								</ul>
							</div>
						</div>
						<div class="new_pot_d">
							<ul>
								<li class="zzsc_box_pad">
									<c:forEach  items="${syxpss}" var="ss" begin="4" end="4" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
										<img src="${ss.info_imgSrc }"  alt="新品上市" title="新品上市" width="210" height="156"/>
										</a>
									</c:forEach>
								</li>
								<!--新品上市 图片大小210px*156px -->
								<li class="zzsc_box_pad">
									<c:forEach  items="${syxpss}" var="ss" begin="5" end="5" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
										<img src="${ss.info_imgSrc }"  alt="新品上市" title="新品上市" width="210" height="156"/>
										</a>
									</c:forEach>
								</li>
								<!--新品上市 图片大小210px*156px -->
								<li class="new_pot_dc zzsc_box_pad">
									<c:forEach  items="${syxpss}" var="ss" begin="6" end="6" >
										<a href="cms/web/showinfowebproduct.do?cid=${ss.info_vid }" target="_blank">
										<img src="${ss.info_imgSrc }"  alt="新品上市" title="新品上市" width="454" height="156"/>
										</a>
									</c:forEach>
								</li>
								<!--新品上市 图片大小454px*156px -->
							</ul>
						</div>
					</div>
				</div>
				<!-- 新品上市完毕 -->


			</div>
			<!-- 内容输出完毕 -->
			<!-- 底部开始 -->
			<jsp:include page="bottum_index.jsp"></jsp:include>
			<!-- 底部完毕 -->
		</div>
	</body>
</html>
<!-- 在线客服代码S -->
		<script type="text/javascript" src="cms/ender/js/swt.js"></script>
		<div id="leftDIV" style="left: 0px; position: absolute; top: 870px;"></div>
		<div id="rightDIV"
			style="left: 0px; position: absolute; top: 870px; display: none">
			<img src="image/ask.png" width="162" height="577" id="EccoolAD"
				usemap="#Map" />
		</div>
		<div class="bxs" style="display: none">
			<img src="images/ask.png" width="162" height="577" border="0"
				usemap="#Map" />
			<map name="Map" id="Map">
				<area shape="rect" coords="32,40,119,128"
					href="http://wpa.qq.com/msgrd?v=3&amp;uin=861335184&amp;site=qq&amp;menu=yes"
					target="_blank" onfocus="this.blur();" />
				<area shape="rect" coords="31,134,121,220"
					href="http://wpa.qq.com/msgrd?v=3&amp;uin=2215298882&amp;site=qq&amp;menu=yes"
					target="_blank" onfocus="this.blur();" />
				<area shape="rect" coords="31,225,118,312"
					href="http://wpa.qq.com/msgrd?v=3&amp;uin=619021690&amp;site=qq&amp;menu=yes"
					target="_blank" onfocus="this.blur();" />
				<area shape="rect" coords="30,320,120,403"
					href="http://wpa.qq.com/msgrd?v=3&amp;uin=2430160232&amp;site=qq&amp;menu=yes"
					target="_blank" onfocus="this.blur();" />
				<area shape="rect" coords="33,420,121,505"
					href="http://wpa.qq.com/msgrd?v=3&amp;uin=1352453123&amp;site=qq&amp;menu=yes"
					target="_blank" onfocus="this.blur();" />
			</map>
		</div>
		<!-- 在线客服代码E -->