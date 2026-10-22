<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.fuao.fajxc.vo.NewPrjtresource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
  <head>
    <title>项目消息记录表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
	<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<script type="text/javascript">
		function nsrmx(){
            var url = "<%=path%>/test.jsp";
			showWindwoButton('id','社保费分户台账','800','550',url);
		}
		function showpage()
		{
			$("#empnames").val(encodeURI($("#empname").val(),"utf-8"));
			$("#emps").val(encodeURI($("#spr").val(),"utf-8"));
			$("#remakes").val(encodeURI($("#remake").val(),"utf-8"));
			$("#form1").submit();
		}
		function showfj(name){
	  	    window.location.href="downloadTaskUpload.do?url="+name;
	     }
	function showpage1(dc)
	{
		$("#dc").val(dc);
		$("#form1").submit();
	}
   </script>
  </head>
  
<body>
	<form id="form1" name="form1" method="post" action="findbyresourceQuestionProject.do">	
		<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
		<input type="hidden" value="${idnp}" id="idnp" name="idnp" />
		<input type="hidden" value="" id="empnames"  name="empnames"/>
		<input type="hidden" value="" id="emps" name="emps"/>
		<input type="hidden" value="" id="remakes" name="remakes" />
		<input type="hidden" value="" id="dc" name="dc"/>
			<!-- 查询条件开始 -->
			<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0" cellpadding="0" id="tablesearch" >
				<tr class="height24">
					<th>
						任务执行人：
					</th>
					<td>
						<input type="text" id="empname" name="empname" value="${empname}"/>
					</td>
					<th>
					   审批人：
					</th>
					<td>
					   <input type="text" id="spr" name="spr" value="${empname1}" />
					</td>
					<th>支出金额：</th>
					<td>
					   <input type="text" id="nmoney" name="nmoney" value="${money}" />
					</td>
				</tr>
				<tr>
				   <th>支出金额时间:</th>
				   <td><input type="text" value="${begintime}" id="begin" style="width: 90px;" name="begintime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" />
				   </td>
				   <th>支出金额原因：</th>
				   <td colspan="3">
				     <input type="text"  id="remake" name="remake" value="${remake}" />
				   </td>
				</tr>
				<tr class="height24">
					<td colspan="6" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
						<button type="button" onclick="showpage();" style="CURSOR:hand;" ><span class="icon_find">查询</span></button>
						<button  type="button" onclick="resetjsp()" style="CURSOR:hand;"><span  class="icon_clear">清空</span></button>
						<button  type="button"  onclick="showpage1(1)"  style="CURSOR:hand;"><span    class=icon_xls>导出</span></button>
						<button type="button"  onclick="closeWindeows(0)" style="CURSOR:hand;"><span class="icon_close">关闭</span></button>
					</td>
				</tr>
			</table>
			</div>
		</form>
		
		<!-- 数据显示  -->
		 <div id="resulthight">
    	<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
			<tr>
			 <th colspan="8"><h3>${pro.projectname}</h3></th>
			</tr>
			
			
			<tr>
			   <td width="15%">任务名称</td>
			   <td width="10%">任务进度</td>
			   <td width="15%">任务执行人</td>
			   <td width="10%">支出金额</td>
			   <td width="10%">审批人</td>
			   <td width="10%">支出时间</td>
			   <td width="20%">使用金额原因</td>
			   <td width="10%">附件</td>
			</tr>
			<% 
				List listnp = (List) request.getAttribute("listnp");
				if(listnp != null && listnp.size()>0)
				{
					for(int n = 0; n<listnp.size();n++)
					{
						NewPrjtresource prjtresource = (NewPrjtresource)listnp.get(n);
			%>
				<tr>
					<td><%=prjtresource.getTask().getFunction().getFunctionname()%></td>
					<td><%=prjtresource.getTplan()%>%</td>
					<td><%=prjtresource.getEmpsubmit().getName()%></td>
					<td><%=prjtresource.getNmoney()%></td>
					<td><%=prjtresource.getEmp().getName()%></td>
					<td><%=prjtresource.getSubtime()%></td>
					<td align="left"  style="word-break:break-all;word-wrap:break-word"><%=prjtresource.getRemakes()%></td>
					<td><%if(prjtresource.getNfj()!=null && !prjtresource.equals("")){ %><a href="javascript:showfj('<%=prjtresource.getNfj()%>')" title="<%=prjtresource.getNfj()%>"><%if(prjtresource.getNfj().length()>10){ %><%=prjtresource.getNfj().substring(0,10)+"..."%><%}else{%><%=prjtresource.getNfj()%> <%} %></a><%} %></td>
				</tr>
				<%} %>
				<tr align="right" style="font-size: 12px;">
					<td colspan="8">总支出金额：${moneyCount} &nbsp;&nbsp;&nbsp;${message}：${sumoney}</td>
				</tr>
			<tr>
			  <td colspan="8"><pp:pages1 url="findbyresourceQuestionProject.do" param="idnp=${idnp}&openmethod=1"/></td>
			</tr>
			<%}else{ %>
			
				<tr>
					<td colspan="8">查无数据</td>
				</tr>
			<%} %>
		</table>
		</div>
</body>
</html>
