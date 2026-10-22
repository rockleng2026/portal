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
<title>立云-用户后台-审核实名认证</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
function baocun(bp){
	$.getJSON("litscloud/web/customerNameBaocunCustomerServerC.Action",{},function(data){
		if(data==0)
		{
			location.href =bp+"litscloud/ucenter/bg_smwc.jsp"
		}
		else
		{
			alert("申请失败！！→_→ ");
		}
	
	});
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
               <div class="ly_rzs_t"><img src="litscloud/images/sf_09.gif" /></div> 
               <div class="ly_rzs_m">
                  <div class="ly_rzs_mt"><span class="blue_q"><a href="javascript:history.back(-1)">返回修改信息</a></span>审核证件前请先确认提交的信息</div> 
                  <div class="ly_rzs_mc">
                     <div class="ly_rzs_mcl"></div> 
                     <div class="ly_rzs_mcr"></div> 
                  </div> 
                  <div class="ly_rzs_d">
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">真实姓名：</div>
                       <div class="ly_rzs_dtr">${customer1.realName}</div>
                    </div>
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">身份证图片正面：</div>
                       <div class="ly_rzs_dtr">已上传<span class="blue_q"></span></div>
                    </div>
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">身份证号码：</div>
                       <div class="ly_rzs_dtr">${customer1.cardid }</div>
                    </div>
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">身份证图片反面：</div>
                       <div class="ly_rzs_dtr">已上传<span class="blue_q"></span></div>
                    </div>
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">固定电话：</div>
                       <div class="ly_rzs_dtr">${customer1.phone}</div>
                    </div>
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">身份证有效期：</div>
                       <c:if test="${customer1.cuSFZTime=='1'}" ><div class="ly_rzs_dtr">永久</div></c:if>
                       <c:if test="${customer1.cuSFZTime!='1'}" ><div class="ly_rzs_dtr">${customer1.cuSFZTime}</div></c:if>
                    </div>
                    
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">手机号码：</div>
                       <div class="ly_rzs_dtr">${customer1.mobilePhone }</div>
                    </div>
                    
                    <div class="ly_rzs_dt">
                       <div class="ly_rzs_dtl">联系地址：</div>
                       <div class="ly_rzs_dtr">${customer1.customerAddress}</div>
                    </div>
                    
                  </div>
               </div> 
               <div class="wqs" style="width:960px; margin:0 auto; height:auto;">
    <div class="wqsl" style="width:480px; float:left; height:200px;" align="center"><img style="width:200px; height:150px;"  src="${imgList[0]}" alt="" /></div>
    <div class="wqsr" style="width:480px; float:left; height:200px;" align="center"><img style="width:200px; height:150px;"  src="${imgList[1]}" alt="" /></div>
  </div>
               <!-- 
               <div style="width:960px; height:200px;" >
                       <div style="float:left;" ><img src="${imgList[0]}" alt="" /></div>
                       <div style="float:left;" ><img src="${imgList[1]}" alt="" /></div>
                    </div>
                     -->
               <div class="ly_rzs_d">
                 <div class="ly_rzs_dm">
                   <div class="ly_rzc_rdl"></div>
                      <div class="ly_rzc_rdc"><a onclick="baocun('<%=basePath%>')" href="javascript:void(0)">确认信息并审核</a></div>
                      <div class="ly_rzc_rdr">
                      </div>
                 </div> 
               </div> 
               <div class="ly_rzs_h">
                  <div class="ly_rzs_ht"></div>
                  <div class="ly_rzs_hc">
                      <div class="ly_rzs_hcm"><img src="litscloud/images/log_56.gif" /> 立云已介入审核，请耐心等待</div>
                  </div>
                  <div class="ly_rzs_hd"></div>
               </div>
             </div>             
             
          </div>             
      </div>  
    
    <div class="ly_n_weibu" style="margin-bottom:50px;"></div>  
   </div>

<!--中部E  -->
<!-- 底部S -->
	<jsp:include page="/litscloud/tpl/bottom.jsp"></jsp:include>
<!-- 底部E -->
</body>
</html>
