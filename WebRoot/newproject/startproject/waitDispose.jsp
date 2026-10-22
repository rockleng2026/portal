<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<style type="">
		h2{
				margin-left:center;
				line-height:29px;
				
				background-color:#C1CDCD;
	
	</style>   

   
 <script> 
		function f1(){           
            var url = "<%=path%>/newproject/question_project/details.jsp";
			showWindwoButton('id','社保费分户台账','800','550',url);
		}
		
		function f2(){
            var ur2 = "<%=path%>/newproject/question_project/dispose.jsp";
			showWindwoButton('id','社保费分户台账','800','550',ur2);
		}
		
		
   </script>
		
	</head>

	<body>

                              <h2>等待解决问题</h2>
                              
      <div id="resulthight">
    	<table style="width:100%;" border="0" align="center" cellpadding="0" cellspacing="0" class="tableStyle"  id="youshuju" >
    	
           <tr  class="height24"  > <td>项目名称</td><td> 问题名称</td><td>提交人</td><td> 处理底线</td> <td>优先级</td><td>状态</td><td>操作</td></tr>
           <tr  class="height24"> <td>Android</td><td> 404</td><td>管理员</td><td> 2008-05-05</td> <td>1级</td><td>处理中</td>
   
    
    <td>
    <a href="javascript:;" onclick="f1();">详情</a> 
    <a href="javascript:;" onclick="f2();">办理</a> 
    <a href="javascript:;" onclick="f0();">进入讨论群</a>
    </td></tr>
     </table>
</div>
	</body>
</html>