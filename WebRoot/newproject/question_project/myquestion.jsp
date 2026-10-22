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
  //修改 showWindwoButton
  <%--
	function updatequest(obj)
	{
		var questid = obj;
		var url = "updatequestionQuestionProject.do?questids="+questid;
		showWindwoButton('id1','修改问题列表','800','550',url);
	}
	--%>
	//删除
	function delquuestion(obj)
	{
		var questid1 = obj;
		$.ajax({
			type:"POST",
			url:"delquestionQuestionProject.do",
			data:{
				"questid1":questid1
			},
			success:function(data)
			{
				if(data =="1")
				{
					alert("删除成功!");
					window.location.href="findBymequestionQuestionProject.do";
				}else
				{
					alert("删除问题失败");
				}
			}
		});
	}
	
	
	function uploadstate(obj)
	{
		var questid2 = obj;
		$.ajax({
			type:"POST",
			url:"uploadstateQuestionProject.do",
			data:{
				"questid2":questid2
			},
			success:function(data)
			{
				if(data == "1")
				{
					alert("提交成功!");
					window.location.href = "QuestionListQuestionProject.do" ;
				}
				if(data == "2")
				{
					alert("提交失败!");
				}
			}
		});
	}

	//个人信息 这个弹出层在新PORTAL页面弹出的样式不行
	<%--
	function Onedetails(obj){
		var questid3 = obj;
		var url = "findByquestionQuestionProject.do?questid3="+questid3;  
		showWindwoButton('id','问题详情','800','550',url);  
	}
	--%>
	function selectBy()
	{
		var qname = encodeURI($("#qname").val(),"utf-8");
		$("#hidename1").val(qname);
		form1.action="<%=path%>/findBymequestionQuestionProject.do";
		form1.submit();
	}
    </script>      
<body>
<form action="" method="post" id="form1" name="form1">
<input type="hidden" value="" name="hidename1" id="hidename1"/>
<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
	<div class="searchDiv"  id="searchDiv" >
	<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0"　class="tableStyle"  cellpadding="0" id="youshuju" >
	    <tr>
	       <th align="left">问题名称：</th>
	       <td>
				<input type="text" id="qname" name="qname" value="${titlename}" />
		   </td>
	    
			   <th>截止时间:</th>
			   <td><input type="text" id="begin" style="width: 90px;" name="creattime" value="${startTime}" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${begintime}" />
			                    至<input type="text" id="end" value="${endTime}" style="width: 90px;" name="endTime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${endtime}" />
			        <font color="red" size="2">*</font><font color="red" id="time" size="2"></font>
			   </td>
		</tr>
		<tr class="height24">
			<td colspan="8" style="padding-top: 4px;padding-bottom: 4px;text-align: center;">
				<button type="button" onclick="selectBy();" ><span class="icon_find">查询</span></button>
				<button  type="button" onclick="resetjsp();"  ><span  class="icon_clear">清空</span></button>
			</td>
		</tr>
	</table>
</div></div>
     <div id="resulthight">
     <span>您现在的位置：<a href="QuestionListQuestionProject.do">问题模块</a>>>我的问题</span>
     	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	        <tr>
	           <td colspan="6" align="left">
	            	<h3>我的问题</h3>
	           </td>
	        </tr>
	    	<tr>
	    		<th>问题名称</th>
	    		<th>提交人</th>
	    		<th>截止时间</th>
	    		<th>优先级</th>
	    		<th>状态</th>
	    		<th>操作</th>
	    	</tr>
	    	<% 
		    	List questionlist=(List)request.getAttribute("questionlist");
	    		if(questionlist.size()>0 && questionlist!=null)
	    		{
			    	for(int i=0;i<questionlist.size();i++){
			    		NewQuestion newque=(NewQuestion)questionlist.get(i);
	    	%>
				<tr align="center">
					<%if(newque.getHandlestatus() ==2){ %>
					<td style="color: #F2F2F2" align="left"><a href="selectIdQuestionProject.do?id=<%=newque.getId()%>&indexdemo=<%=newque.getIndexdemos()%>"><%=newque.getQuestionname() %>(已结贴)</a></td>
					<%}else if(newque.getHandlestatus() ==1){ %>
					<td align="left"><a href="selectIdQuestionProject.do?id=<%=newque.getId()%>&indexdemo=<%=newque.getIndexdemos()%>"><%=newque.getQuestionname()%></a></td>
					<%} else{%>
					<td align="left"><%=newque.getQuestionname()%></td>
					<%} %>
					<td><%=newque.getEmployee().getName()%></td>
					<td><%=newque.getLastdate() %></td>
					<td>
						<%
						 java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
						 Date lastdate=dateFormat2.parse(newque.getLastdate());
						 Date now=new Date();
						 long l=lastdate.getTime()-now.getTime(); 
						 long day=l/(24*60*60*1000); 
						 if(day>=7){%>
						 	<a href="javascript:void(0);" title="低"><img src="<%=request.getContextPath() %>/img/green.gif"></img></a>
						 <%}else if(day>=3 && day<7){%>
							<a href="javascript:void(0);" title="一般"> <img src="<%=request.getContextPath() %>/img/yellow.gif"></img></a>
						 <%}else if(day<3){%>
						 	<a href="javascript:void(0);" title="高"> <img src="<%=request.getContextPath() %>/img/red.gif"></img></a>
						 <%}%>
					</td>
					<td>
						<%if(newque.getHandlestatus()==0){ %>未提交<%} %>
						<%if(newque.getHandlestatus()==1){ %>未反馈<%} %>
						<%if(newque.getHandlestatus()==2){ %>已反馈<%} %>
					</td>
					<td>
						<a class="thickbox gb_bb" href="findByquestionQuestionProject.do?questid3=<%=newque.getId()%>" style='text-decoration: none;'>详情</a>
					   <%if(newque.getHandlestatus()==0){%>
						<a  href='#' onclick='uploadstate(<%=newque.getId()%>)' style='text-decoration: none;'>提交</a> 
						<a class="thickbox gb_bb" href="updatequestionQuestionProject.do?questids=<%=newque.getId()%>" style='text-decoration: none;'>修改</a> 
						<a href='#' onclick='delquuestion(<%=newque.getId()%>)' style='text-decoration: none;'>删除</a>
						<%}else if(newque.getHandlestatus() !=0){ %>
						  <a href="selectIdQuestionProject.do?id=<%=newque.getId()%>&indexdemo=<%=newque.getIndexdemos()%>">讨论区</a>
						<%} else {%>
							
						<%} %>
					</td>
				</tr> 
	    	<%}%>
	    	<tr>
	    		<td id="page" colspan="7" align="center"><p:pages url="findBymequestionQuestionProject.do?funid=14" /></td>
	    	</tr>
	    	<%} else{%>
	    		<tr>
	    			<td colspan="7" align="center">查无数据</td>
	    		</tr>
	    	<%} %>
	</table>
	</div>
</form>
	</body>

</html>