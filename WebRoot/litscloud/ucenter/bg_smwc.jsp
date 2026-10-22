<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>立云-用户后台-完成实名认证</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript">

</script>
  </head>
  
  <body>
  <div class="ly_body" align="center">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>

   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href="litscloud/ucenter/index.jsp" target="_parent">首页</a>>会员中心</div> 
          <div class="bg_c">
              <div class="bg_ct"><ul>
                <li><a href="litscloud/ucenter/index.jsp" style="background-image:url(litscloud/images/bg_01.png); color:#ffffff;">我的<br />账户</a></li>
                <li><a href="litscloud/ucenter/my_order.jsp">自助<br />管理</a></li>
              </ul></div>
              <div class="bg_cd">
                 <div class="bg_cdl"></div>
                 <div class="bg_cdc"><ul>
                   <li><a href="litscloud/ucenter/index.jsp" >个人资料</a></li>
                    
                    <li><a href="litscloud/ucenter/bg_password.jsp">修改密码</a></li>
                    
                    <li><a href="litscloud/ucenter/bg_wycz.jsp">我要充值</a></li>
                    <li><a href="litscloud/ucenter/u_zhanghu.jsp" style="background-image:url(litscloud/images/bg_06.jpg); color:#000; background-repeat:no-repeat;">账户信息</a></li>
                    <li><a href="litscloud/ucenter/bg_czjl.jsp">充值记录</a></li>
                 </ul></div>
                 <div class="bg_cdr"></div>
              </div>
          </div> 
          <div class="ly_xx">
             <div class="ly_xxt">
               <div class="ly_xxtl">个人实名认证</div>             
             </div>
             <div class="ly_rzs">
               <div class="ly_rzs_t"><img src="litscloud/images/sf_15.gif" /></div> 
               <div class="ly_rzs_e">
                  <div class="ly_rzs_et"></div>
                  <div class="ly_rzs_ec">
                     <div class="ly_rzs_ecl"><img src="litscloud/images/sf_18.gif" /></div>
                     <div class="ly_rzs_ecr">
                        <div class="ly_rzs_ecrt">您的认证审核通过！</div>
                        <div class="ly_rzs_ecrd">
                            <div class="ly_rzc_rdl"></div>
                      <div class="ly_rzc_rdc"><a href="litscloud/ucenter/index.jsp">确 &nbsp; 定</a></div>
                      <div class="ly_rzc_rdr"></div>
                        </div>
                     </div>
                  </div>
                  <div class="ly_rzs_ed"></div>
               </div> 
             </div>             
             
          </div>             
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</div>
  </body>
</html>
