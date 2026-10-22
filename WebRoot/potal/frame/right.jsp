<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>



<div class="slide">
	<a href="#" class="btn-slide"></a>
</div>
<div id="panel">
	<div class="rightnr" id="test">
		<div class="right">
			<span class="jstx">即时提醒</span>
			<ul>
				<li>
					<a href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">短消息</a>(
					<span><a id="hong" href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">${messagecount}</a>
						<div id="light" class="white_content">
							<iframe style="position: absolute; left: -500px;" scrolling="auto"
								frameborder="0" src="<%=path %>/writelogmessage.do" marginheight="0"
								marginwidth="0" width="766" height="442"></iframe>
							<div class="xx">
								<a href="javascript:void(0)"
									onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img
										src="<%=basePath%>potal/images/x2.jpg">
								</a>
							</div>
						</div>
					</span>)
				</li>
				<li>
					<a href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">邮件</a>(
					<span><a id="hong" href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">1</a>
						<div id="light" class="white_content">
							<iframe scrolling="no" frameborder="0" src="tanchu.html"
								marginheight="0" marginwidth="0" width="766" height="442"></iframe>
							<div class="xx">
								<a href="javascript:void(0)"
									onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img
										src="<%=basePath%>potal/images/xx.jpg">
								</a>
							</div>
						</div>
					</span>)
				</li>
				<li>
					<a href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">任务通知</a>(
					<span><a id="hong" href="javascript:void(0)"
						onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">1</a>
						<div id="light" class="white_content">
							<iframe scrolling="no" frameborder="0" src="tanchu.html"
								marginheight="0" marginwidth="0" width="766" height="462"></iframe>
							<div class="xx">
								<a href="javascript:void(0)"
									onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img
										src="<%=basePath%>potal/images/xx.jpg">
								</a>
							</div>
						</div>
					</span>)
				</li>
				<li>
					<a href="#">留言</a>(
					<span><a href="#" id="hong">0</a>
					</span>)
				</li>
				<li>
					<a href="#">待处理任务</a>(
					<span><a href="#" id="hong">0</a>
					</span>)
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
				<li>
					&nbsp;
				</li>
			</ul>
			<p>
				常用工具
			</p>
			<div class="right_2">
				<dl>
					<dd>
						<img src="<%=basePath%>potal/images/yun.gif" />
					</dd>
					<dt>
						20°C 多云 威风
					</dt>
				</dl>
			</div>
			<div class="right_2">
				<dl>
					<dd>
						<img src="<%=basePath%>potal/images/zhong.gif" />
					</dd>
					<dt>
						时间:2012-11-13 19:10
						<br />
						<span>星期:星期一</span>
					</dt>
				</dl>
			</div>
		</div>
	</div>
</div>
<div id="fade" class="black_overlay" style="overflow:auto; "></div>