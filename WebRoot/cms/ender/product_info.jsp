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
		<title>${product.title}</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="This is my page" />
		<link href="cms/ender/css/style2.css" rel="stylesheet" type="text/css" />
		<script src="cms/ender/js/jquery.js" type="text/javascript"></script>
		<script src="cms/ender/js/zzsc.js" type="text/javascript"></script>
		<script type="text/javascript" src="cms/ender/js/lrtk.js"></script>
		<script type="text/javascript">
function showpic(id,serail,imglength){
	//alert(serail);
	for(i=0;i<imglength;i++){
		$("#ahref"+(i+1)).removeClass("pro_trd_xuan");
	}
	$("#ahref"+serail).addClass("pro_trd_xuan");
	var imglist = $("#"+id).children("img");
	//alert( imglist[0].src);
	$('#imga1').attr('src',imglist[0].src);
}
</script>
	</head>

	<body>
		<div class="bodyer">
			<!-- bodyer整个网页的布局 里面也可以设置整个网站的背景样式 -->
			<!-- 头部 -->
			<jsp:include page="menu.jsp"></jsp:include>
			<!-- t_bod结束 -->
			<div class="p_cod">
				<div class="bod_width t_cod_mar">
					<!-- 内容开始 -->

					<div id="zzscs" class="mmx_wx">
						<c:if test="${prevpdt != null}">
							<a class="pre" href="cms/web/showinfowebproduct.do?cid=${prevpdt.cid }" title="${prevpdt.title }"></a>
						</c:if>
						<a class="list" href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${classid }" title="返回到${classname }列表页面"></a>
						<c:if test="${nextpdt != null}">
							<a class="next" href="cms/web/showinfowebproduct.do?cid=${nextpdt.cid }" title="${nextpdt.title }"></a>
						</c:if>
						<div class="pro_retun">
							<a href="cms/web/showlistwebproduct.do?match_name=webproduct&classid=${classid }" title="返回到${classname }列表页面">
								<img src="cms/ender/image/ed_41.gif" alt="xx" />
							</a>
						</div>
					</div>
					<div id="wai_box">
						<div class="zzsc_box">
							<ul>
								<li>
									<div class="bod_width pro_t">
										<div class="bod_width pro_tm">
											<!-- 产品简介左边 -->
											<div class="pro_tl">
												<div class="pro_tl_wid pro_tlt">

												</div>
												
												<div class="pro_tl_wid pro_tlc">
													<h1 class="pro_title">
														${product.title}
													</h1>
													<h2 class="pro_title2">
														${product.ftitle}
													</h2>
													<label class="pro_tlclab">
														${product.smalltext }
													</label>
												</div>
                                               <div class="pro_tl_qq">
													<a href="http://wpa.qq.com/msgrd?v=3&uin=861335184&site=qq&menu=yes" target="_blank" title="亲，点我详细咨询哦！">在线咨询</a>
												</div>
											</div>
											<!-- 产品简介右边 -->
											<div class="pro_tr">
												<div class="pro_trt">
													<c:if test="${thumblength == 0}">
														<img id="imga1" src="cms/ender/image/ed_37.jpg" alt="xx" />
													</c:if>
													<c:if test="${thumblength == 1 }">
														<img id="imga1" src="${thumbarra[0] }" alt="xx" width="450" height="450" />
													</c:if>
													<c:if test="${thumblength > 1 }">
														<img id="imga1" src="${thumbarra[0] }" alt="xx" width="450" height="450" />
													</c:if>
													
												</div>
												<div class="pro_trd">
													<ul>
														<c:choose>
														    <c:when test="${thumblength == 0}">
														      <img id="imga1" src="cms/ender/image/ed_37.jpg" title="无此图片" width="82" height="82" />
														     </c:when>
														    <c:when test="${thumblength == 1 }">
														      <c:forEach items="${thumbarra}" var="ss" begin="0" end="1" varStatus="i">
																<li id="ali-${i.index+1 }" >
																		<a href="javascript:void(0);" <c:if test='${i.index == 0 }'>class="pro_trd_xuan"</c:if> id="ahref${i.index+1 }" onclick="showpic(this.id,${i.index+1 },${thumblength })">
																			<img id="imga${i.index+1 }" src="${ss }" alt="ss" title="ss" width="82" height="82" /> <span>${namearra[i.index] }</span>
																		</a>
																</li>
																</c:forEach>
														     </c:when> 
														    <c:when test="${thumblength == 4 || thumblength > 4}">
														      <c:forEach items="${thumbarra}" var="ss" begin="0" end="3" varStatus="i">
																<li id="ali-${i.index+1 }" <c:if test='${i.index == 3 }'>class="zzsc_box_right_mar"</c:if>>
																		<a href="javascript:void(0);" <c:if test='${i.index == 0 }'>class="pro_trd_xuan"</c:if> id="ahref${i.index+1 }" onclick="showpic(this.id,${i.index+1 },${thumblength })">
																			<img id="imga${i.index+1 }" src="${ss }" alt="${namearra[i.index] }" title="${namearra[i.index] }" width="82" height="82" /> <span>${namearra[i.index] }</span>
																		</a>
																</li>
																</c:forEach>
														     </c:when>  
														   <c:otherwise>
														      <c:forEach items="${thumbarra}" var="ss" begin="0" varStatus="i">
																	<li id="ali-${i.index+1 }"
																		<c:if test='${i.index == 1 }'>class="pro_trd_xuan"</c:if>>
																		<a href="javascript:void(0);" id="ahref${i.index+1 }"
																			onclick="showpic(this.id,${i.index+1 },${thumblength })">
																			<img id="imga${i.index+1 }" src="${ss }" alt="ss"
																				title="ss" width="82" height="82" /> <span>${namearra[i.index] }</span>
																		</a>
																	</li>
																</c:forEach>
														    </c:otherwise>
														  </c:choose>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<div class="bod_width pro_d">
										<span class="pro_d_title">产品描述：</span>
										<br />
										${product.contents }
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div style="text-align: center; clear: both">
						<br />
					</div>
				</div>
			</div>
			<!-- 内容输出完毕 -->
			<!-- 底部开始 -->
			<jsp:include page="bottum.jsp"></jsp:include>
			<!-- 底部完毕 -->
		</div>
<!-- 在线客服代码S -->
<script type="text/javascript" src="cms/ender/js/swt.js"></script>
<div id="leftDIV" style="left: 0px; position: absolute; top: 870px; "></div>
<div id="rightDIV" style="left: 0px; position: absolute; top: 870px; display:none">
<img src="image/ask.png" width="162" height="577" id="EccoolAD" usemap="#Map" /> </div>
<div class="bxs" style="display:none">
<img src="images/ask.png" width="162" height="577" border="0" usemap="#Map"/>
<map name="Map" id="Map">
<area shape="rect" coords="32,40,119,128" href="http://wpa.qq.com/msgrd?v=3&amp;uin=861335184&amp;site=qq&amp;menu=yes" target="_blank" onfocus="this.blur();"/>
<area shape="rect" coords="31,134,121,220" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2215298882&amp;site=qq&amp;menu=yes" target="_blank" onfocus="this.blur();"/>
<area shape="rect" coords="31,225,118,312" href="http://wpa.qq.com/msgrd?v=3&amp;uin=619021690&amp;site=qq&amp;menu=yes" target="_blank" onfocus="this.blur();"/>
<area shape="rect" coords="30,320,120,403" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2430160232&amp;site=qq&amp;menu=yes" target="_blank" onfocus="this.blur();"/>
<area shape="rect" coords="33,420,121,505" href="http://wpa.qq.com/msgrd?v=3&amp;uin=1352453123&amp;site=qq&amp;menu=yes" target="_blank" onfocus="this.blur();"/>
</map>
</div>
<!-- 在线客服代码E -->

	</body>
</html>
