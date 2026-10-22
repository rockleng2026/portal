<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />

 <div class="bg_dqt">基本资料<span class="blue"><a href="javascript:xiugai()">修改资料</a></span></div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_dqd">
                       <div class="bg_dqd_l">
                          <div class="bg_dqd_lt">
                              <div class="bg_dqd_ltt"><a href="#"><img src="litscloud/images/bg_12.png" /></a></div>
                              <div class="bg_dqd_ltd"><span class="blue"><a href="#">修改头像</a></span></div>
                          </div> 
                       </div>
                        <div class="bg_dqd_r">
                           <div class="bg_dqd_rz"><dl><dt>登陆账号：</dt><dd class="bg_zh" style="width:305px;">${customer.customerName }
<c:if test="${customer.customerfj==''||customer.customerfj==null}">(<span>未认证</span>，<a href="litscloud/ucenter/u_zhanghu.jsp">点击进行实名认证</a>) </c:if>
 <c:if test="${customer.customerfj!=''&& customer.customerfj!=null}"> (<span>实名已认证</span>)</c:if>
</dd><dt>昵 &nbsp; &nbsp; &nbsp; 称：</dt><dd>${customer.realName}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>注册时间：</dt><dd style="width:305px;">${customer.date }</dd><dt>联系人&nbsp; ：</dt><dd>${customer.businesslinkpersion}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户类型：</dt><dd style="width:305px;">${customer.customerType }</dd><dt>手机号：</dt><dd>${customer.mobilePhone }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>身份证号：</dt><dd style="width:305px;">${customer.cardid }</dd><dt>QQ号 码：</dt><dd>${customer.qq }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户传真：</dt><dd style="width:305px;">${customer.facsimile}</dd><dt>个人邮箱：</dt><dd>${customer.email}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司名称：</dt><dd style="width:305px;">${customer.customerCompany }</dd><dt>营业执照：</dt><dd>${customer.dobusinesscode }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司规模：</dt><dd style="width:305px;">${customer.companyScale }</dd><dt>公司电话：</dt><dd>${customer.phone}</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司地址：</dt><dd style="width:305px;">${customer.customerAddress }</dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>授&nbsp; 权&nbsp; 码：</dt><dd style="width:305px;">${customer.authorization}</dd></dl></div>
                        
                        
                        </div>
                        
                    </div>