<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery.js"></script>
<!--[if IE 6]>
	<script type="text/javascript" src="js/pngfix.js"></script>
	<script type="text/javascript">
	DD_belatedPNG.fix('.rightnr .change i, ..rightnr, ..btn-slide, .change i.cur , .mountainbox, img');
	</script>
	<![endif]-->
<script type="text/javascript" defer="true">
function selchid(funid){
	$('#funcid').val(funid);
	$(".top ul li").each(function(){
		   $(this).removeClass("showselt");   
	 });
	document.getElementById("formid").submit();
}
function exits(){
   if(confirm("你确定要退出系统吗?")){
      location.href="closeSystemLogin.do";   
   }
}
</script>
<form action="changeShowMenuLogin.do" method="post" id="formid">
	<input type="hidden" name="funcid" id="funcid">
</form>
		<dl>
			<dd>
				你好，
				<c:out value="${userInfos.loginName}" />!
				<a href="javascript:exits();">安全退出</a><a href="<%=path %>/zhglAccountManager.do" target="targetName">帐号管理</a>
			</dd>
			<dt>
				<ul>
					<s:property value="" />
					<s:if test="#request.functionselid =='00'">
						<s:iterator value="#session.functionSupLists" var="sup"
							status="sp">
							<s:if test="#sp.index<5">
								<s:if test="#sp.index==0">
									<li class="showselt">
										<a
											href="javascript:selchid(<s:property value="#sup.functionId"/>);"><s:property
												value="#sup.linkFunctionName" />
										</a>
									</li>
								</s:if>
								<s:else>
									<li>
										<a
											href="javascript:selchid(<s:property value="#sup.functionId"/>);"><s:property
												value="#sup.linkFunctionName" />
										</a>
									</li>
								</s:else>
							</s:if>
						</s:iterator>
					</s:if>
					<s:else>
						<s:iterator value="#session.functionSupLists" var="sup"
							status="sp">
							<s:if test="#sp.index<5">
								<s:if test="#sup.functionId == #request.functionselid">
									<li class="showselt">
										<a
											href="javascript:selchid(<s:property value="#sup.functionId"/>);"><s:property
												value="#sup.linkFunctionName" />
										</a>
									</li>
								</s:if>
								<s:else>
									<li>
										<a
											href="javascript:selchid(<s:property value="#sup.functionId"/>);"><s:property
												value="#sup.linkFunctionName" />
										</a>
									</li>
								</s:else>
							</s:if>
						</s:iterator>
					</s:else>
				</ul>
				<span><form action="#" name="search">
						<table border="0" cellpadding="0" cellspacing="0"
							class="tab_search">
							<tr>
								<td>
									<input type="text" name="q" title="Search" class="searchinput"
										id="searchinput" onkeydown="if (event.keyCode==13) {}"
										onblur="if(this.value=='')value='关键字';"
										onfocus="if(this.value=='关键字')value='';" value="关键字" size="10" />
								</td>
								<td>
									<input type="image" width="21" height="17" class="searchaction"
										onclick="if(document.forms['search'].searchinput.value=='关键字')document.forms['search'].searchinput.value='';"
										alt="Search" src="<%=basePath%>potal/images/ss2.jpg"
										border="0" hspace="2" />
								</td>
							</tr>
						</table>
					</form>
				</span>
			</dt>
		</dl>