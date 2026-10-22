<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewQuestion"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<title>项目问题详情</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
		<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
		<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
    </head>
    <script type="text/javascript">
  		function onclickOpen(id,indexdemo)
  		{
			parent.location.href = "selectIdQuestionProject.do?id="+id+"&indexdemo="+indexdemo;
  	  	}
    </script>      
<body>
<form action="#" method="get">
     <div id="resulthight">
     	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	        <tr>
	           <td colspan="6" align="left">
	            	<h3>历史记录( <a href="javascript:history.go(-1)">返回列表</a>)</h3>
	           </td>
	        </tr>
	    	<tr>
	    		<th>问题名称</th>
	    		<th>提交人</th>
	    		<th>浏览次数</th>
	    		<th>回复次数</th>
	    		<th>状态</th>
	    	</tr>
	    	<% 
		    	List questionlist=(List)request.getAttribute("tempList");
		    	for(int i=0;i<questionlist.size();i++){
		    		NewQuestion newque=(NewQuestion)questionlist.get(i);
	    	%>
				<tr align="center">
					<%if(newque.getHandlestatus() ==2){ %>
						<td style="color: #F2F2F2" align="left"><a href="javascript:onclickOpen('<%=newque.getId()%>','<%=newque.getIndexdemos()%>');"><%=newque.getQuestionname() %>(已结贴)</a></td>
					<%}else if(newque.getHandlestatus() ==1){ %>
					<td align="left"><a href="javascript:onclickOpen('<%=newque.getId()%>','<%=newque.getIndexdemos()%>');"><%=newque.getQuestionname()%></a></td>
					<%} else{%>
					<td><%=newque.getQuestionname()%></td>
					<%} %>
					<td><%=newque.getEmployee().getName() %></td>
					<td><%=newque.getPid()%></td>
					<td>
						<%=newque.getTemp1()%>
					</td>
					<td>
						<%if(newque.getHandlestatus()==0){ %>未提交<%} %>
						<%if(newque.getHandlestatus()==1){ %>未反馈<%} %>
						<%if(newque.getHandlestatus()==2){ %>已反馈<%} %>
					</td>
				</tr> 
	    	<%}%>
	    	<tr>
	    		<td id="page" colspan="5" align="center"><p:pages url="historyquestionQuestionProject.do?funid=14" /></td>
	    	</tr>
	    	<tr>
			 	<td align="center" colspan="5">
			      <button type="button"  onclick="javascript:history.go(-1)"><span class="icon_close">关闭</span></button>
			    </td>
			 </tr>
	</table>
	</div>
</form>
	</body>

</html>