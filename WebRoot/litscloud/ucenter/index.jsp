<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
			<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript"
			src="<%=request.getContextPath()%>/litscloud/js/updateCU.js"></script>
			<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCo	mmand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
  $(document).ready(function(){ 
	 //$('#userData').load("<%=request.getContextPath()%>/litscloud/ucenter/myData.jsp");
	 //document.getElementById("update").style.display="none";
	  document.getElementById("a1").className = "aBackgroundImage";
	  document.getElementById("a1").style.color= "#000000";
	  
	});

  function xiugai(){
    	tt=(new Date()).getTime();
	  $('#userData').load("<%=request.getContextPath()%>/litscloud/ucenter/bg_datscust.jsp?tt="+tt);
	  //document.getElementById("update").style.display="";
	  }

</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top.jsp"></jsp:include>
</div>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <!-- 菜单1S -->
          <jsp:include page="/litscloud/ucenter/menu_1.jsp"></jsp:include>
          <!-- 菜单1E -->
          <div class="bg_d">
             <div class="bg_dt"></div>
             <div class="bg_dc">
              <form action="litscloud/web/updateCUCustomerServerC.Action"  id="formUpdateCU" name="formUpdateCU" method="post" >
                <div id="userData" class="bg_dq">
               
 <div class="bg_dqt">基本资料<span class="blue"><a href="javascript:xiugai()">修改资料</a></span></div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_dqd">
                       <div class="bg_dqd_l">
                          <div class="bg_dqd_lt">
                              <div class="bg_dqd_ltt">
                              <c:if test="${customer.customerTX==''||customer.customerTX==null}"><img src="potal/images/sc_tt.jpg" id="imga1"  width="122" height="139" /></c:if>
                               <c:if test="${customer.customerTX!=''&&customer.customerTX!=null}"><img src="${customer.customerTX }" id="imga1"  width="122" height="139" /></c:if>
                              
                              </div>
                              <div class="bg_dqd_ltd">
                           <div class="bg_dgd_ltdt"> <span class="blue"><a onclick="updateTX()" href="javascript:void(0)">修改头像</a></span></div>  
                                         <div id="updateTX" <c:if test="${customer.customerTX!=''&&customer.customerTX!=null}">style="display:none;"</c:if>  class="bg_dgd_ltdd"> <input type="hidden" id="img1" name="img1" value="" />
                     <input  type="file" name="fileupload" size="10" id="fileupload" onchange="uploadImage11(this.value)"  />
                     	
                     	<input id="pathi" style="margin-bottom: 20px;" type="hidden" value="<%=basePath%>"><span id="imgtishi2"></span>
                            </div>  
                     
                              </div>
                          </div> 
                       </div>
                        <div class="bg_dqd_r">
                           <div class="bg_dqd_rz"><dl><dt>登陆账号：</dt><dd class="bg_zh" style="width:305px;">${customer.customerName }
<c:if test="${customer.customerfj==''||customer.customerfj==null}">(<span>未认证</span>，<a href="litscloud/ucenter/bg_smsq.jsp">点击进行实名认证</a>) </c:if>
 <c:if test="${customer.customerfj!=''&& customer.customerfj!=null}"> (<span>实名已认证</span>)</c:if>
</dd><dt>昵 称：</dt><dd>${customer.realName}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>注册时间：</dt><dd style="width:305px;">${customer.date }</dd><dt>联系人：</dt><dd>${customer.businesslinkpersion}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户类型：</dt><dd style="width:305px;">${customer.customerType }</dd><dt>手机号：</dt><dd>${customer.mobilePhone }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>身份证号：</dt><dd style="width:305px;">${customer.cardid }</dd><dt>QQ号 码：</dt><dd>${customer.qq }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户传真：</dt><dd style="width:305px;">${customer.facsimile}</dd><dt>个人邮箱：</dt><dd>${customer.email}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司名称：</dt><dd style="width:305px;">${customer.customerCompany }</dd><dt>营业执照：</dt><dd>${customer.dobusinesscode }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司规模：</dt><dd style="width:305px;">${customer.companyScale }</dd><dt>公司电话：</dt><dd>${customer.phone}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司地址：</dt><dd style="width:305px;">${customer.customerAddress }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>授&nbsp; 权&nbsp; 码：</dt><dd style="width:305px;">${customer.authorization}</dd></dl></div>
                        
                        
                        </div>
                        
                    </div>
                
                </div>
                
           </form>
                <div class="bg_dq">
                    <div class="bg_dqt">安全信息</div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_dqa">
                       <div class="bg_dqa_t">
                         <div class="bg_dqa_tl">你当前的账号安全程度</div>
                         <div class="bg_dqa_tc"><img src="litscloud/images/bg_13.png" /></div>
                         <div class="bg_dqa_tr">安全级别： <span>中</span> 继续努力</div>
                       </div> 
                       <div class="bg_dqa_d">
                           <dl>登录密码</dl>
                           <dt>安全性高的密码可以使账号更安全。建议您定期更换号码，设置一个包含字母，符号或数字钟至少两项且长度超过六位的密码。</dt>
                           <dd><a href="litscloud/ucenter/bg_password.jsp">修改</a> </dd>
                       </div>
                       <div class="bg_dqa_d">
                           <dl>手机绑定</dl>
                           <dt>你绑定的手机<span style="color:#ff6701;">${customer.mobilePhone }</span>。[您的手机为安全手机，可以找回密码，但不能用于登录]</dt>
                           <dd><c:if test="${customer.mobilePhone !=null && customer.mobilePhone!=''}"><img src="litscloud/images/bg_14.png" /> 已绑定 </c:if>
                           <c:if test="${customer.mobilePhone ==null || customer.mobilePhone ==''}"><span style="color:#999999;">未设置</span>  </c:if>
                           <a href="litscloud/ucenter/updatePhone.jsp">更换</a> </dd>
                       </div>
                       <div class="bg_dqa_d">
                           <dl>备用邮箱</dl>
                           <dt>您绑定的邮箱<span style="color:#ff6701;">${customer.email}</span></dt>
                           <dd>
                           <c:if test="${customer.email!=null && customer.email!=''}"><img src="litscloud/images/bg_14.png" /> 已绑定 </c:if>
                           <c:if test="${customer.email ==null || customer.email ==''}"><span style="color:#999999;">未设置</span> </c:if>
                           <a href="litscloud/ucenter/updateEmail.jsp">更换</a></dd>
                       </div>
                       <div class="bg_dqa_d" style="border-bottom:dashed 1px #000;">
                           <dl>授权码</dl>
                           <dt>${customer.authorization}</dt>
                           <dd>
                           <c:if test="${customer.authorization !=null && customer.authorization!=''}"><img src="litscloud/images/bg_14.png" /> 已绑定<a href="litscloud/ucenter/updateAuthorization.jsp">更换</a> </c:if>
                           <c:if test="${customer.authorization ==null || customer.authorization ==''}"><span style="color:#999999;">未设置</span> <a href="litscloud/ucenter/updateAuthorization.jsp">绑定</a> </c:if>
                           </dd>
                       </div>                     
                    </div>
                </div>
             </div>
             <div class="bg_dd"></div>
          </div>      
      </div>  
    
   </div>
<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
