<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
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
			<br/>
			
			<table   style="width:100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24" >
					<th align="center">
						项目名称：
					</th>
					<td align="left">
						<input type="text" name="pjoname"  value=""  />
					</td>
					<th align="center">
						创建人：
					</th>
					<td>
						<input type="text" name="creater"  value=""  />
					</td>
				</tr>
				<tr class="height24">
					<th align="center">
						创建时间：
					</th>
					<td>
						<input type="text" name="creattime"  value=""  />
					</td>
					<th align="center">
						标题：
					</th>
					<td>
						<input type="text" name="revertnum"  value=""  />
					</td>
				</tr>
				<tr class="height24">
				    <th align="center">
						创建时间：
					</th>
					<td colspan="3" >
						<input type="text" name="creattime"  value=""  />
					</td>
				</tr>
				<tr>
				<td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td><td valign="top"><br /></td></tr><tr class="height24">
					<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;" align="left">
						<input name="zuanquswjgbm" id="zuanquswjgbm" type="hidden"  value="" />
						<button type="button" onclick="showPage(1)" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()"  ><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="daochu()"  ><span    class=icon_xls>导出</span></button>
						<input name="daonum" value="1" type="hidden" />
					</td>
				</tr>
				
			</table>
			</table>
			</div>
			</div>
		</form>
   
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th>问题名称</th>
			 <th>所在项目</th>
			 <th>创建人</th>
			 <th>创建时间</th>
			 <th>回复次数</th>
			</tr>
			
			
			
			
			
			
			<tr>
			   <td>什么时候放假</td>
			   <td>OA项目</td>
			   <td>韩雅欣</td>
			   <td>2012-10-26</td>
			   <td>5</td>
			   
			</tr>
			
	 		<tr>
			   <td>没法现实页面信息</td>
			   <td>OA项目</td>
			   <td>胡宝林</td>
			   <td>2012-10-27</td>
			   <td>6</td>
			   
			</tr>
			<tr>
			   <td>客户反应产品问题</td>
			   <td>销售项目</td>
			   <td>胡宝林</td>
			   <td>2012-11-22</td>
			   <td>7</td>
			   
			</tr>
			<tr>
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
			  
			</tr>
			<tr>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   <td>胡宝林</td>
			   
			</tr>
			<tr>
			   <td>韩雅欣</td>
			   <td>韩雅欣</td>
			   <td>韩雅欣</td>
			   <td>韩雅欣</td>
			   <td>韩雅欣</td>
	
			</tr>	
			<tr>
			  <td colspan="7"><input type="button" onclick="nsrmx()" value="弹出层" /></td>
			</tr>	
		</table></div>
	</body>
</html>
