<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>立云-用户注册-邮箱验证</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	-->
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath()%>/litscloud/js/u_logonYanZheng.js"></script>
			<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
  </head>
  <script type="text/javascript">

  </script>
  <body>
    <div class="ly_body" align="center" >

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
       <div class="ly_zc">
         <div class="ly_zct">
           <div class="ly_zctl"></div> 
           <div class="ly_zctc">1</div>
           <div class="ly_zctm" style="background-image:url(<%=request.getContextPath()%>/litscloud/images/bg_36.png);"></div>
           <div class="ly_zcty" style="background-image:url(<%=request.getContextPath()%>/litscloud/images/bg_31.jpg);">2</div>
           <div class="ly_zctm"></div>
           <div class="ly_zcts"></div> 
           <div class="ly_zctw"></div>           
         </div>
        <div class="ly_zcc" >
           <div class="ly_zccl" style="color:#999;">设置账户信息</div>
           <div class="ly_zccc" style="color:#666;">验证账户信息
           	</br>本页面禁止刷新
           </div>
           <div class="ly_zccr">注册成功</div>
        </div>
        <div class="ly_zcd">
            <div class="ly_zcr">
               
                
                 <div class="">
                          <div class="">验证码：</div>
                          <div class=""><input type="text" id="suijima" name="suijima" name="bg_yzm" class="data_yzm" value="" /></div>
                    	
                        </div>    
                        <div class="" id="typediv1" >
                             <div class="bg_zhaopass2_dmt">如果一分钟内没有收到验证码，请重新获取</div>
                             <div id="daojishi1"  style="display: none" class=""><img src="litscloud/images/bg_18.png" />点击验证码发送 →_→ <INPUT TYPE= "text"" id="jump"   disabled="true" value="59" style="width: 20px" />秒后重新获取  </div>
                             <div id="daojishi2" class="">请点击<INPUT TYPE= "button"" id="" onclick="open11()"  value="发送" />获得验收码  </div>
                               <div class="bg_an">
                       
                    </div>
                    <div class="juzhong_l" style="width:165px; margin:0 auto; height:36px;">
                         <div align="center" class="bg_anlc"><a href="javascript:history.back(-1)">返回</a></div>
                         <div align="center" class="bg_anrc"><a onclick="yanZhengMa('<%=basePath %>')" href="javascript:void(0)">下一步</a></div>
                      </div>       
                </div>
                  
                <div class="ly_zcr_c"></div>
                <div class="ly_zcr_d">
                   <div class="ly_zcr_dm">
                     <div class="ly_zcr_dmt">一直没收到邮件？</div>
                     <div class="ly_zcr_dmd"><ul>
                        <li>首先检查是否在垃圾邮件中</li>
                        <li>如果还未收到 →_→请重新发送邮件</li>
                        <li>重新发送邮件，还未收到？请试试<a href="login_zc.html">更换其它邮箱</a></li>
                        <li>一直没收到？您可以<a href="login_zc.html">重新注册</a></li>
                     </ul></div>
                   </div>
                </div>
            </div>
        </div> 
        </div> 
        </div>             
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>


  </body>
</html>
<script>
	

</script>
