<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
	<!--window对象-->
	<head>
		<title>处理问题</title>
	</head>
          
<body style="font-size:30px;">
  
   <h4> 项目问题处理</h4>
  <form action="form_action.asp" method="get">



  <table border="1" cellpadding="0" cellspacing="0">

   <tr><td>
       汇报时间：</td><td><input type="text" size="45" value="1990-01-01"/> 
   </td></tr>
   <tr><td>
  结果处理汇报：</td><td><textarea  rows="10" cols="40"> xx 问题已经解决</textarea > 
</td><tr/>
  </table>
  
    <input name="name" value="确定" type="submit"/>
 <input name="name" value="取消" type="reset"/>
  </form>


	</body>
</html>