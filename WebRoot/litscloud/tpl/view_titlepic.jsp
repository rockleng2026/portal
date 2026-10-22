<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<title>立云-图片浏览</title>
		<LINK rel=stylesheet type=text/css href="<%=path%>/litscloud/css/lrtk.css" />
		<SCRIPT type=text/javascript src="<%=path%>/litscloud/js/jquery.js"></SCRIPT>
		
	</head>
	<body style="text-align: center">

		<DIV style="HEIGHT: 560px; PADDING-TOP: 20px" class="wrap picshow">
			<!--大图轮换区-->
			<DIV id=picarea>
				<DIV
					style="MARGIN: 0px auto; WIDTH: 774px; HEIGHT: 436px; OVERFLOW: hidden">
					<DIV
						style="MARGIN: 0px auto; WIDTH: 774px; HEIGHT: 436px; OVERFLOW: hidden"
						id=bigpicarea>
						<P class=bigbtnPrev>
							<SPAN id=big_play_prev title="浏览上一图"></SPAN>
						</P>
						<c:forEach var="ss" items="${imgarra}" varStatus="i">
							<DIV id='image_xixi-0${i.index+1 }' class=image>
								<A href="javascript:void(0);"><IMG alt="" src="${ss }" />
								</A>
								<DIV class=word>
									<h3>
										aaaa
									</h3>
								</DIV>
							</DIV>
						</c:forEach>
						
						<P class=bigbtnNext>
							<SPAN id=big_play_next  title="浏览下一图"></SPAN>
						</P>
					</DIV>
				</DIV>
				<DIV id=smallpicarea>
					<DIV id=thumbs>
						<UL>
							
							<LI class="first btnPrev"  title="浏览上一图"><IMG id=play_prev src="litscloud/images/left.png"></LI>
							
							<c:forEach var="ss" items="${thumbarra}" varStatus="i">
							<LI class=slideshowItem>
								<a id='thumb_xixi-0${i.index+1 }' href="javascript:void(0);">
								<IMG src="${ss }" width=90 height=60 />
								</a>
							</LI>
							</c:forEach>
 
							<LI class="last btnNext"  title="浏览下一图">
								<IMG id=play_next src="litscloud/images/right.png" />
							</LI>
						</UL>
					</DIV>
				</DIV>
			</DIV>
			<input  type="hidden" value="${num }" id="num" />
			<SCRIPT>
			${targetstr}
			</SCRIPT>
			<SCRIPT type=text/javascript src="<%=path%>/litscloud/js/slide.js"></SCRIPT>
			</DIV>
		<!-- 只支持10以内的图片轮播 -->
	</body>
</html>