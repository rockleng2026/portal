<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>激活邮件重新发送</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/default.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript"> 
if (window != top) 
top.location.href = location.href; 
</script> 
	
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
<table width="860" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
    	<table width="860" border="0" align="center" cellpadding="0" cellspacing="0">
    	</table>
        <table height="359" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="left" valign="top"><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                  	<img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_01.jpg" width="349" height="63" />
                  </td>
                </tr>
                <tr>
                  <td align="center" valign="top" background="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_bj.jpg">
                  	<table width="301" height="186" align="center" cellpadding="0" cellspacing="6">
                       <tr>
                          <td width="71" align="center" valign="middle" bgcolor="ffffff">会 员 名 <br /></td>
                          <td width="224" align="left" valign="middle" bgcolor="ffffff">
                          	<input name="userid" type="text" class="input_out" id="userid" 
                          	onFocus="this.className='input_on';this.onmouseout=''" 
                          	onBlur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" 
                          	onMouseMove="this.className='input_move'" 
                          	onMouseOut="this.className='input_out'"/>
                          </td>
                       </tr>
                        <tr>
                          <td align="center" valign="middle" bgcolor="ffffff"><br /></td>
                          <td align="left" valign="middle" bgcolor="ffffff">
                          	<input name="passwd" type="password"  class="input_out" 
                          	onFocus="this.className='input_on';this.onmouseout=''" 
                          	onBlur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" 
                          	onMouseMove="this.className='input_move'" 
                          	onMouseOut="this.className='input_out'"/>
                          </td>
                        </tr>

                        
                         <tr>
                          <td align="center" valign="middle" bgcolor="ffffff" colspan="3">
                          	<font color="red">${errorMsg == null ? "" : errorMsg }</font>
                          </td>
                        </tr>
                        <tr>
                          <td height="30" align="center" valign="middle" bgcolor="ffffff">&nbsp;</td>
                          <td height="30" align="left" valign="bottom" bgcolor="ffffff">
                          	<input type="hidden" name="aftervalue" id="aftervalue" value="beforeEmpty" />
                          	<input type='image' id="submit" src='<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl.jpg' border='0' />
                              <a href='<%=path %>/foreGroundFolder/customProscenium/register.jsp' target="_blank">
                              <img src='<%=path%>/foreGroundFolder/customProscenium/subnote_files/zc.jpg' hspace="5"border='0' />
                              </a>
                           </td>
                        </tr>
                     

                  </table>
                  
                  </td>
                  </tr>
	                <tr>
	                  <td align="center" valign="top" background="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_bj.jpg">
	                	  <img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_02.jpg" width="331" height="52" />
	                  </td>
	                </tr>
	                <tr>
	                  <td height="51" align="center" valign="middle" background="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_bj.jpg">
	                  <table width="90%" border="0" cellspacing="0" cellpadding="0">
	                    <tr>
	                      <td height="51" align="center" valign="bottom">
	                      	<a href="<%=path %>/foreGroundFolder/customProscenium/register.jsp" target="_blank">
	                         <img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/sq.jpg" width="117" height="42" border="0" />
	                        </a>
	                      </td>
	                      <td align="center" valign="middle">
	                      	<a href="#">
	                      		<img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/alipayLogin_small.png" width="117" height="26" border="0" />
	                      	</a>
	                      </td>
	                    </tr>
	                  </table>
	                  </td>
	              </tr>
	                <tr>
	                  <td>
	                  	<img src="<%=path%>/foreGroundFolder/customProscenium/subnote_files/dl_03.jpg" width="349" height="11" />
	                  </td>
	                </tr>
	            </table></td>
	          </tr>
        </table>
<div id="Footer" align="center">
	<div class="FooterL"></div>
    <div class="FooterM">
	<div class="FooterMenu">
   	<span class="Green">友情合作:</span>
   	<a href="http://www.yx30.com" target="_blank">游戏山林</a>
   	|<a href="http://www.bz169.com" target="_blank">山东联通 </a>
   	|<a href="http://www.cngidc.com/100m/" target="_blank">百独服务器租用</a>
   	|<a href="http://ehd.fuaotech.com/live.html" target="_blank">网络高清直播</a>
   	<br />
	<a href="http://www.fuaotech.com/aboutparnter.html">投资合作  </a>|
	<a href="http://www.fuaotech.com/aboutjob.html">正在招聘 </a>|
	<a href="http://www.fuaotech.com/aboutconnectus.html">联系福奥  </a>|
	&nbsp;&nbsp;&nbsp;&nbsp;2008-2011 FUAO INC.&nbsp;&nbsp;   ALL RIGHTS RESERVED. &nbsp;&nbsp; 粤ICP备05004695号 <br /> 
	<span class="Green">深圳公司:0755-33666800 深圳·宝安中心区F518时尚创意园 F7-201<br />
	山东公司:0755-33666800  山东·滨州国际大厦4层<br />
	北京公司: 010-82517828  北京·中关村硅谷电脑城 </span>
	</div></div>
    <div class="FooterR"></div>
</div>
</td>
  </tr>
</table></form>

</body>
</html>