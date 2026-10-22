<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript">
	function gotolink(url){
		$("#middle_content_div").load(url);
	}	
</script>
<ul>
	<s:if test="#session.functionChidLists.size>0">
		<s:iterator value="#session.functionChidLists" var="ch"
			status="ci">
			<s:if test="#ci.index<8">
				<s:if test="#ch.linkFunctionPage.indexOf('.jsp')!=-1">
					<li>
						<a
							href="<%=basePath%>potal/page/<s:property value="#ch.linkFunctionPage"/>"
							target="targetName"><s:property
								value="#ch.linkFunctionName" />
						</a>
					</li>
				</s:if>
				<s:else>
					<li>
						<a
							href="<%=basePath%><s:property value="#ch.linkFunctionPage"/>"
							target="targetName"><s:property
								value="#ch.linkFunctionName" />
						</a>
					</li>
				</s:else>
				<s:set value="#ci.index" var="cot" scope="request"></s:set>
			</s:if>
		</s:iterator>
		<s:iterator begin="#request.cot" step="1" end="6">
			<li>
				<a href="javascript:void(0);" /></a>
			</li>
		</s:iterator>
	</s:if>
	<s:else>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
		<li>
			<a href="javascript:void(0);" /></a>
		</li>
	</s:else>
</ul>

<div class="leftboot">
	<img src="<%=basePath%>potal/images/MM.jpg" />
	<p>
		我是
		<span>By2</span>,正在
		<span>创意设计部</span>工作,昨天得到了
		<img src="<%=basePath%>potal/images/jiang.jpg" />
		,好开心
		<img src="<%=basePath%>potal/images/xiao.jpg" />
		.”
		<span>设计源于生活，细节成就品质</span>“
	</p>
</div>

