<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>自动关闭层</title>
    <script language="javascript">
        function a(){
		    window.history.go(1);//回退无效
		    //自动关闭层
			 window.setTimeout("closeWindeows(true)", "100");
        }
        function closeWindeows(bool){
            if(bool){
            	history.go(-1);
            }
        } 
	</script>
   </head>
  
  <body onload="a()"> 
  <center>
  <img src="<%=request.getContextPath() %>/cms/images/happy.png"></img>
  <span style=" font-size:30px; font-weight:bold; color:#0C0;">保存成功</span>
      
  </center>
  </body>
</html>
