<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <style type="text/css">
  dd,dl,dt{
  margin: 0px;padding: 0px; }
  </style>
    <base href="<%=basePath%>">
    
    <title>My JSP 'loggin.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
	<link href="<%=basePath%>IDCServ/css/main.css" rel="stylesheet" type="text/css" />
</head>
  <script type="text/javascript">
  	window.onload = function()
  	{
  		var message = "<%=request.getAttribute("registerActiveMessage") %>";
  		
  		if(message!='null')
  		{
  			alert(message);
  		}
  	}
  </script>

<body>
<form action="customerLoginCustomerServer.Action" method="post">
<div class="dd19">
<div class="dd1901"><img src="<%=basePath%>IDCServ/image/1.jpg" /></div>



<div class="dd18">
	<div class="dd1801">登录</div>
    <div class="dd1802">
    	<ul>
        	<li>
            	<dl>
                	<dt>用户名:</dt>
                    <dd ><input name="userid" type="text" id="userid" onFocus="this.className='input_on';this.onmouseout=''" onBlur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" onMouseMove="this.className='input_move'" onMouseOut="this.className='input_out'"/><span class="dd2005" id="s1" style="display: none">用户名不存在</span></dd>
                   
                </dl>
            </li>
            <li>
            	<dl>
                	<dt>密&nbsp;&nbsp;码:</dt>
                    <dd><input name="passwd" type="password"  class="input_out" onFocus="this.className='input_on';this.onmouseout=''" onBlur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" onMouseMove="this.className='input_move'" onMouseOut="this.className='input_out'" /></dd>
                </dl>
            </li>
            <li>
            	<dl>
                	<dt>验证码:</dt>
                	 <% String imgpath =request.getProtocol().substring(0, 4).toLowerCase()+ "://" + request.getServerName() + ":"+request.getServerPort(); %>
                    
                    <dd><input  style="width:120px;" type="text" name="ValCode"  class="inputcode_out" onFocus="this.className='inputcode_on';this.onmouseout=''" onBlur="this.className='inputcode_off';this.onmouseout=function(){this.className='inputcode_out'};" onMouseMove="this.className='inputcode_move'" onMouseOut="this.className='inputcode_out'"/>
                    <span class="dd2005" style="display:none">验证码不正确 </span>
                   </dd>
                </dl>
            </li>
            <li>
            	<dl>
                	<dt></dt>
                    <dd><IMG SRC="<%=imgpath%><%=request.getContextPath() %>/servlet/Img"></td></dd>
                </dl>
            </li>
        
        
        
            <li>
            <dl>
                	<dt></dt>
                    <dd><a style="color:#019c96; margin-right:7px;" href="<%=path%>/IDCServ/sendpass.jsp" class="wjmm">忘记密码</a>|<a style=" color:#019c96; margin:0 7px;" href='<%=path %>/IDCServ/regist.jsp' >注册</a></dd>
                </dl>	
                <div class="clear"></div>
            </li>
        </ul>
    </div>
  
    	<input type="hidden" name="aftervalue" id="aftervalue" value="beforeEmpty" />
    <div class="dd1804">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="sb1" onclick="sb1()" value=" " class="dd0705" type="submit" /></div>
</div>
</div>

  </form>
 
</body>
</html>
