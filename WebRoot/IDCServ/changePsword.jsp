<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'changePsword.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"/>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js">
</script>
	
	
	<style type="text/css">
	    #form1{
	    margin-right: 60px;
	    }
	</style>
	
<script type="text/javascript">
			
			var f=false;
			
			function checkpass(){
			 var va= $('#password').val();
			 if(!va){
			 $('#password1').html("密码不能为空"); 
			 }else{
			 
			  $('#password1').html("");
			  f=true; 
			 }
			
			}  
			
			var f1=false;
			
			function checkpass1(){
			 var va= $('#newpass1').val();
			 if(!va){
			 $('#newpass11').html("密码不能为空"); 
			 }else if(va.length < 4){
			  $('#newpass11').html("密码长度不能少于四位");
			 }else if(va.length > 20){
			  $('#newpass11').html("密码长度不能大于二十位");
			 }else{
			 $('#newpass11').html(" <font style='color: blue'>密码可以使用</font>");
			 f1=true;
			 }
			
			}
			
			
			
			var f2=false;
			
			function checkpass2(){
			 var va= $('#newpass2').val();
			 var va1= $('#newpass1').val();
			 if(!va){
			 $('#newpass21').html("密码不能为空"); 
			 }else if(va!=va1){
			  $('#newpass21').html("两次密码输入不一致");
			 }else{
			  $('#newpass21').html("<font style='color: blue'>两次密码输入一致</font>");
			 f2=true;
			 }
			
			}
	
			
	function commitp(){
	var va= $('#password').val();
	 if(!va){
			 $('#password1').html("密码不能为空"); 
			 return;  
			 }
	 var va1= $('#newpass1').val();
	 
	 if(!va1){
		$('#newpass11').html("密码不能为空");  return;
			 }else if(va1.length < 4){
		  $('#newpass11').html("密码长度不能少于四位");return;
			 }else if(va1.length > 20){
		  $('#newpass11').html("密码长度不能大于二十位"); return;
			 }else{
			 $('#newpass11').html(" <font style='color: blue'>密码可以使用</font>");
			 }
			 
			  var va2= $('#newpass2').val();
			  if(!va2){
			     $('#newpass21').html("密码不能为空");  return;
			 }else if(va2!=va1){
			$('#newpass21').html("两次密码输入不一致");return;
			 }else{
			  $('#newpass21').html("<font style='color: blue'>两次密码输入一致</font>");
			 }
	   $.post("checkpassCustomerServer.Action",{"password":va,"newpass1":va1},function(date){
	      if(date==1){ 
	       alert('密码修改失败，请重新输入!');
	       }
	       if(date==2){
	        alert('密码修改成功');
	       }
	 
	  });
	
	
	  }
	
			
</script>


  </head>
  
  <body>
  <jsp:include page="head.jsp"></jsp:include>
  <jsp:include page="left.jsp"></jsp:include>
         <form action="editpasswordCustomerServer.do" method="post">
       <div class="dd1302">
    <div class="dd1303"><span>密码管理</span><a href="javascript:;" onclick="commitp();">[确定]</a></div>
<div class="dd16">
    <ul>
      <li>
        <dl>
          <dt>我的旧密码:</dt>
          <dd>
            <input id="password" name="password"   type="password" onblur="checkpass()" /> &nbsp;<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="password1"></FONT>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
      <li>
        <dl>
          <dt>我的新密码:</dt>
          <dd>
            <input id="newpass1"  name="newpass1" type="password"  onblur="checkpass1()"/> &nbsp;<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="newpass11"></FONT>
          </dd>
          </dd>
        </dl>
        <div class="clear"></div>
       
      </li>
      
      <li>
        <dl>
          <dt>请再次输入新密码:</dt>
          <dd>
            <input id="newpass2" name="newpass2" type="password" onblur="checkpass2()"/> &nbsp;<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="newpass21"></FONT>
          </dd>
          </dd>
        </dl>
        <div class="clear"></div>
      </li>
    </ul>    
  </div>
  </div>
  </form>
<jsp:include page="bottom.jsp"></jsp:include>
  </body>
</html>
