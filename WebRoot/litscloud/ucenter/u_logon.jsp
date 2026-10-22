<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>立云-用户注册-填写资料</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/litscloud/js/u_logon.js"></script>
		<SCRIPT language=javascript>
		/*是否为数字、字母或下划线*/   

</SCRIPT>

  </head>
  
  <body>
   <div class="ly_body" align="center">
   
   <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
       <div class="ly_zc">
         <div class="ly_zct">
           <div class="ly_zctl"></div> 
           <div class="ly_zctc">1</div>
           <div class="ly_zctm"></div>
           <div class="ly_zcty">2</div>
           <div class="ly_zctm"></div>
           <div class="ly_zcts"></div> 
           <div class="ly_zctw"></div>           
         </div>
        <div class="ly_zcc">
           <div class="ly_zccl">设置账户信息</div>
           <div class="ly_zccc">验证账户信息</div>
           <div class="ly_zccr">注册成功</div>
        </div>
         <FORM id="regform" name="regform"
							action="litscloud/web/customerRegister1CustomerServerC.Action" method="post">
        <div class="ly_zcd">
         <div class="ly_zcm">
              <div class="ly_zcm_m"></div>
              <div class="ly_zcm_b"></div>
              <div class="ly_c">
                <div class="ly_ct">
                  <div class="ly_ctl"><span>*</span>用户名称：</div>
                  <div class="ly_ctr"  align="left"><table><tr><td><INPUT align="left" onblur=reg() style="WIDTH: 240px" id=customerName
												class="lg_email" onfocus="onfuos('customerName')"
												 maxLength=10
												type=text name=customerName></td><td><SPAN id=uname></SPAN></td></tr></table></div> 
                </div>
                <div class="ly_ct">
                  <div class="ly_ctl"><span>*</span>用户密码：</div>
                  <div class="ly_ctr">
                     <div class="ly_ctr_t" align="left" ><table><tr><td><INPUT onblur=regpwd() style="WIDTH: 240px"
												id=customerPassword class=lg_email
												onfocus="onfuos('customerPassword')"
												
											
												 maxLength=15
												type=password name=customerPassword></td><td><SPAN id=pwd></SPAN></td></tr></table></div>
                     <div class="ly_ctr_d">
                     <ul><li style="background-color:#2cabee" id=strength_L>弱</li><li id=strength_M>中</li><li id=strength_H style="margin-right:0px;">强</li></ul>
                     
                     <!-- 
                      <TABLE style="DISPLAY: inline;" border=0 cellSpacing=0 
																cellPadding=1 width=120 height=2>
																<TBODY>
																	<TR align=middle bgColor=#eeeeee>
																		<TD id=strength_L bgColor=#eeeeee height="30px" width="25%">弱</TD>
																		<TD id=strength_M bgColor=#eeeeee width="29%">中</TD>
																		<TD id=strength_H bgColor=#eeeeee width="32%">强</TD>
																	</TR>
																</TBODY>
															</TABLE>
															-->
															<SPAN style="MARGIN-LEFT: 5px" id=text></SPAN>
                     </div> 
                  </div> 
                </div>
                <div class="ly_ct">
                  <div class="ly_ctl"><span>*</span>确认登录密码：</div>
                  <div class="ly_ctr" align="left"><table><tr><td><INPUT onblur=regpwd2() style="WIDTH: 240px" id=user_pwd2
												class=lg_email onfocus=""
												 type=password
												name=user_pwd2></td><td><SPAN id=pwd2></SPAN></td></tr></table></div> 
                </div>
                <div class="ly_ct">
                  <div class="ly_ctl"><span>*</span>电子邮件：</div>
                  <div class="ly_ctr" align="left"><table><tr><td><INPUT onblur=regmail() style="WIDTH: 240px" id=email
												class=lg_email onfocus="onfuos('email')" type=text name=email>
											<INPUT id=tiemail type=hidden name=tiemail value=""></td><td><SPAN id='mail'></SPAN></td></tr></table></div> 
                </div>
                
                
                <div class="ly_ct">
                  <div class="ly_ctl"></div>
                  <div class="ly_ctr">
                </div>
                <div class="ly_ct">
                  <div class="ly_ctl"><span></span>调查：</div>
                  <div class="ly_ctr" align="left"><SELECT id=user_from name=user_from>
												<OPTION selected value="">
													您是从何处得知本站
												</OPTION>
												<OPTION value=百度>
													百度
												</OPTION>
												<OPTION value=Google>
													Google
												</OPTION>
												<OPTION value=Soso>
													Soso
												</OPTION>
												<OPTION value=草根站长>
													草根站长
												</OPTION>
												<OPTION value=虚拟主机评测网>
													虚拟主机评测网
												</OPTION>
												<OPTION value=锋网源码>
													锋网源码
												</OPTION>
												<OPTION value=非凡软件站>
													非凡软件站
												</OPTION>
												<OPTION value=天空软件站>
													天空软件站
												</OPTION>
												<OPTION value=创意素材库>
													创意素材库
												</OPTION>
												<OPTION value=驱动中国>
													驱动中国
												</OPTION>
												<OPTION value=数码资源网>
													数码资源网
												</OPTION>
												<OPTION value=模板天下>
													模板天下
												</OPTION>
												<OPTION value=站酷>
													站酷
												</OPTION>
												<OPTION value=华军软件园>
													华军软件园
												</OPTION>
												<OPTION value=壹聚教程>
													壹聚教程
												</OPTION>
												<OPTION value=站长下载>
													站长下载
												</OPTION>
												<OPTION value=源码站>
													源码站
												</OPTION>
												<OPTION value=下载站>
													下载站
												</OPTION>
												<OPTION value=论坛>
													论坛
												</OPTION>
												<OPTION value=朋友介绍>
													朋友介绍
												</OPTION>
												<OPTION value=其他>
													其他
												</OPTION>
											</SELECT>
											<INPUT
												onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
												style="WIDTH: 240px" id=user_from2 class=input_out
												onfocus="this.className='input_on';this.onmouseout=''" type=text class=lg_email
												name=user_from2></div> 
                </div>
                <div class="ly_ct">
                  <div class="ly_ctl">备注说明：</div>
                  <div class="ly_ctr" align="left">
                    <INPUT
												onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
												style="WIDTH: 240px;height: 50px" id=user_notes class=lg_email
												onfocus="this.className='input_on';this.onmouseout=''"type=text
												name=user_notes>
                  </div> 
                </div>
                
              </div>
         </div>
        </div> 
        <div class="" style="margin-bottom:5px;">
                  <div class="ly_ctl"></div>
                  <div class="ly_ctr">
                    <div class="ly_ctra"><a onclick="aa()" href="javascript:void(0)">同意协议并注册</a></div>

                  </div> 
                </div>
           <div class="" style="margin-bottom:5px;">
                  <div class="ly_ctl"></div>
                  <div class="ly_ctr">
                    <span class="xieyi" style="margin-left:280px;" ><a href="javascript:void(0)">《立云网站服务协议》</a></span></div>
         
               
                </div>     
           
          
          
        </FORM>        
      </div>  
    	
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>
   
 
</div>

  </body>
</html>
