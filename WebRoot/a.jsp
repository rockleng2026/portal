<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>纳税人户型</title>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript">
		function nsrmx(){
            var url = "<%=path%>/test.jsp";
			showWindwoButton('id','社保费分户台账','800','550',url);
		}
   </script>
  </head>
  
<body onload="setdivwidth();">
		<form id="form1" name="form1" method="post" action="<%=path %>/SBHDLKAction.do?method=HDLK">	
		<div id="box2" class="box2" style='border:#89aad7 1px solid;margin-bottom: 10px;'  >
			<div class="searchDiv"  id="searchDiv" >
			<input name="daonum" value="1" type="hidden" />
			<input name="curpage" id="curpage" type="hidden" value="" />
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						纳税人流水号：
					</th>
					<td>
						<input type="text" name="nsrlsh"  value=""  />
					</td>
				</tr>
				<tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<input name="zuanquswjgbm" id="zuanquswjgbm" type="hidden"  value="" />
						<c:forEach items="${option}" var="op">
								<c:if test="${op.key==1}">
								    <button type="button" onclick="showPage(1)" ><span class="icon_find">查询</span></button>
								</c:if>
								<c:if test="${op.key==2}">
								   <button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
								</c:if>
								<c:if test="${op.key==3}">
								   <button  type="button"  onclick="daochu()"  ><span    class=icon_xls>导出</span></button>
								</c:if>
						</c:forEach>
					</td>
				</tr>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>纳税人</th>
			 <th>合计1</th>
			 <th>合计2</th>
			 <th>合计3</th>
			 <th>合计4</th>
			 <th>合计5</th>
			 <th>合计6</th>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			
	 		<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			</tr>	
			<tr>
			  <td colspan="7">
			      <c:forEach items="${option}" var="op">
						<c:if test="${op.key==4}">
						    <input type="button" onclick="nsrmx()" value="弹出层" />
						</c:if>
						<c:if test="${op.key==24}">
						<input type="button" onclick="nsrmx()" value="详细信息" />
						</c:if>
						<c:if test="${op.key==10}">
						<input type="button" onclick="nsrmx()" value="删除" />
						</c:if>
						<c:if test="${op.key==15}">
						<input type="button" onclick="nsrmx()" value="修改" />
						</c:if>
						<c:if test="${op.key==16}">
						<input type="button" onclick="nsrmx()" value="返回" />
						</c:if>
						<c:if test="${op.key==17}">
						<input type="button" onclick="nsrmx()" value="编辑" />
						</c:if>
						<c:if test="${op.key==18}">
						<input type="button" onclick="nsrmx()" value="编辑1" />
						</c:if>
						<c:if test="${op.key==19}">
						<input type="button" onclick="nsrmx()" value="编辑2" />
						</c:if>
			     </c:forEach>
			  </td>
			</tr>	
		</table></div>
	</body>
</html>
