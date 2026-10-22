<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fuao.fajxc.vo.NewQuestion"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.fuao.fajxc.vo.Employee"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>

<html>
	<head>
	　　<title>问题列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	    <jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	    <link href="<%=request.getContextPath() %>/Css/move.css" type=text/css rel=stylesheet ></link>
		<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
	    <script charset="utf-8" src="<%=request.getContextPath() %>/kindeditor/lang/zh_CN.js"></script>

		<script language="javascript">
		// 编辑器
		var objid;
		var editor;
		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="content"]', {
				resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : false,
				items : [
	'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
	'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
	'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
			});			
		});
				// 创建问题
				<%--	废除，这个弹出层在新PORTAL页面弹出的样式不行5月18号
				function add(){           
	            var url ="<%=path%>/newproject/question_project/addquestion.jsp";  
					showWindwoButton('id','创建问题列表','800','550',"createproUIQuestionProject.do");          
				}  
				function history(){           
					showWindwoButton('id','历史记录列表','800','550',"historyquestionQuestionProject.do");          
				}  
				// 问题详情
				function details(){
					var url = "<%=path%>/newproject/question_project/details.jsp";  
					showWindwoButton('id','问题详情','800','550',url);  
				}
				--%>
				// 显示编辑器
				function showEdit(){
					$("#fd").show();
				}
				// 隐藏编辑器
				function hideEdit(){
					$("#fd").hide();
				}
				//当前人登入人的项目问题
				function findempquestion()
				{
<%--					showWindwoButton('id','个人问题列表','800','550',"findBymequestionQuestionProject.do");--%>
					window.location.href="findBymequestionQuestionProject.do";
				}
				//个人信息
				function Onedetails(obj){
					var questid3 = obj;
					var url = "findByquestionQuestionProject.do?questid3="+questid3;  
					showWindwoButton('id','问题详情','800','550',url);  
				}
				
		</script>
</head>
<body>
<div id="box2" class="box2" style='border:#89aad7 0px solid;margin-bottom: 10px;'  >
	<div class="searchDiv"  id="searchDiv" >
	<table style="width: 100%;height: 100%" border="0" align="center" cellspacing="0"　class="tableStyle"  cellpadding="0" id="youshuju" >
        
	    <tr>
	       <th align="left"><h3>一、创建问题</h3></th>
	    </tr>
		<tr>
		  <td>
			<center>
			<h2><a href='selectQuestionProject.do'  title="点击进入讨论社区" style='text-decoration: none;'>讨论社区</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="thickbox gb_bb" href='createproUIQuestionProject.do' title="点击创建项目问题" style='text-decoration: none;'>创建问题</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a  href='historyquestionQuestionProject.do' title="点击查看问题历史记录" style='text-decoration: none;'>历史记录</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' onclick='findempquestion();' title="我的问题" style='text-decoration: none;'>我的问题</a></h2></center>
			  
		  </td>
		</tr>
	</table>
</div></div>
<div id="resulthight">
<span>您现在的位置：问题模块</span>
	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
	        <tr>
	           <td colspan="6"  align="left" >
	            	<h3>待解决问题</h3>
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
	    	
	    	   <% List listquestion1 = (List)request.getAttribute("waitquestionlist");
	    	   		for(int l = 0 ;l<listquestion1.size();l++)
	    	   		{
	    	   			NewQuestion newqusetQuestion = (NewQuestion)listquestion1.get(l);
	    	   		
	    	   %>
			<tr align="center">
				
				<td align="left"><a href="selectIdQuestionProject.do?id=<%=newqusetQuestion.getId()%>&indexdemo=<%=newqusetQuestion.getIndexdemos()%>" style='text-decoration: none;'><%=newqusetQuestion.getQuestionname()%></a></td>
				<td><%=newqusetQuestion.getEmployee().getName()%></td>
				<td><%=newqusetQuestion.getLastdate()%></td>
				<td>
						<%
						 java.text.SimpleDateFormat dateFormat3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
						 Date lastdate1=dateFormat3.parse(newqusetQuestion.getLastdate());
						 Date now1=new Date();
						 long l1=lastdate1.getTime()-now1.getTime(); 
						 long day1=l1/(24*60*60*1000); 
						 if(day1>=7){%>
						 	<a href="javascript:void(0);" title="低"><img src="<%=request.getContextPath() %>/img/green.gif"></img></a>
						 <%}else if(day1>=3 && day1<7){%>
							<a href="javascript:void(0);" title="一般"> <img src="<%=request.getContextPath() %>/img/yellow.gif"></img></a>
						 <%}else if(day1<3){%>
						 	<a href="javascript:void(0);" title="高"> <img src="<%=request.getContextPath() %>/img/red.gif"></img></a>
						 <%}%>
					</td>
				<td>
						<%if(newqusetQuestion.getHandlestatus()==0){ %>未提交<%} %>
						<%if(newqusetQuestion.getHandlestatus()==1){ %>未反馈<%} %>
						<%if(newqusetQuestion.getHandlestatus()==2){ %>已反馈<%} %>
					</td>
				<td>
					<a class="thickbox gb_bb" href="findByquestionQuestionProject.do?questid3=<%=newqusetQuestion.getId()%>" style='text-decoration: none;'>详情</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="selectIdQuestionProject.do?id=<%=newqusetQuestion.getId()%>&indexdemo=<%=newqusetQuestion.getIndexdemos()%>">讨论区</a>
				</td>
			</tr>
			<% }%>
			<tr>
				<td id="page"  colspan="6" align="center"><p:pages url="QuestionListQuestionProject.do"/></td>
			</tr>
	</table>
	
	<!-- 编辑器内容 -->
	<form action="" name="" method="post">
	<div id="fd" style="display:none; filter:alpha(opacity=100);opacity:1;float: right;" >
		<table style="width:100%; text-align: center;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju"  >
		     <tr>
		        <td colspan="2" align="left"><h3>项目问题处理</h3></td>
		     </tr>
		     <tr>
		     	<th>汇报时间：</th>
		     	<td align="left"><input type="text" onclick="WdatePicker()" /></td>
		     </tr>
             <tr>
             	<th>汇报结果处理：</th>
                <td><textarea name="content" id="content" class="textarea"  style='width:450px;height:150px;'></textarea></td>
             </tr>
             <tr>
                <td align="center" colspan="2">
                   <button type="button" onclick="showCont()"><span class="icon_save">保存</span></button>
                   <button type="button" onclick="hideEdit()"><span class="icon_close">关闭</span></button>
                </td>
             </tr>
		</table>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/move.js" ></script>
	</div>
	</form>
</div>

</body>
</html>