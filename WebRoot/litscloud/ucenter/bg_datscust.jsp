<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<link href="<%=request.getContextPath()%>/litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/litscloud/css/css.css" rel="stylesheet" type="text/css" />


 <div class="bg_dqt">修改资料<span class="blue"><a href="javascript:xiugai()">修改资料</a></span></div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    
                    <div class="bg_dqd">
                       <div class="bg_dqd_l">
                          <div class="bg_dqd_lt">
                              <div class="" style="width: 111px;height: 125px"> <c:if test="${customer.customerTX==''||customer.customerTX==null}"><img src="potal/images/sc_tt.jpg" id="imga1"  width="122" height="139" /></c:if>
                               <c:if test="${customer.customerTX!=''&&customer.customerTX!=null}"><img src="${customer.customerTX }" id="imga1"  width="122" height="139" /></c:if></div>
                              
                          </div> 
                       </div>
                      
                        <div class="bg_dqd_r">
                           <div class="bg_dqd_rz"><dl><dt>登陆账号：</dt><dd class="bg_zh" style="width:305px;"><input type="hidden" readonly="readonly" name="customerId" id="customerId" value="${customer.customerId }" /><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" readonly="readonly" name="customerName" id="customerName" value="${customer.customerName }" /><span style="color:#f00;" id="customerName1">*不能修改</span></dd><dt>昵 &nbsp; &nbsp; &nbsp; 称：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="realName" id="realName" value="${customer.realName}" /><span style="color:#f00;" id="realName1"></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>注册时间：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" readonly="readonly" name="date" id="date" value="${customer.date }" /><span style="color:#f00;" id="date1">*不能修改</span></dd><dt>联系人&nbsp; ：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" readonly="readonly" name="businesslinkpersion" id="businesslinkpersion" value="${customer.businesslinkpersion}" /><span  style="color:#f00;"  id="businesslinkpersion1">*不能修改</span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户类型：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="customerType" readonly="readonly" id="customerType" value="${customer.customerType }" /><span  style="color:#f00;" id="customerType1">*不能修改</span></dd><dt>手机号：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="mobilePhone" id="mobilePhone" value="${customer.mobilePhone }" /><span  style="color:#f00;"  id="mobilePhone1"></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>身份证号：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="cardid" id="cardid" value="${customer.cardid }" /><span  style="color:#f00;" id="cardid1"></span></dd><dt>QQ号 码：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="qq" id="qq" value="${customer.qq }" /><span  style="color:#f00;"  id="qq1" ></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>客户传真：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="facsimile" id="facsimile" value="${customer.facsimile}" /><span style="color:#f00;"  id="facsimile1" ></span></dd><dt>个人邮箱：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="email" id="email" value="${customer.email}" /><span  style="color:#f00;"  id="email1" ></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司名称：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="customerCompany" id="customerCompany" value="${customer.customerCompany }" /><span style="color:#f00;"  id="customerCompany1" ></span></dd><dt>营业执照：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="dobusinesscode" id="dobusinesscode" value="${customer.dobusinesscode }" /><span  style="color:#f00;"  id="dobusinesscode1" ></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司规模：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="companyScale" id="companyScale" value="${customer.companyScale }" /><span  style="color:#f00;"  id="companyScale1" ></span></dd><dt>公司电话：</dt><dd><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="phone" id="phone" value="${customer.phone}" /><span  style="color:#f00;"  id="phone1" ></span></dd></dl></div>
                           <div class="bg_dqd_rz"><dl><dt>公司地址：</dt><dd style="width:305px;"><input style="border: 1px solid #DCDCDC;height: 20px;width: 150px" name="customerAddress" id="customerAddress" value="${customer.customerAddress }" /><span  style="color:#f00;" id="customerAddress1" ></span></dd></dl></div>
                           <div class="bg_dqd_rz" align="center"> <input class="btn" type="button" onclick="updateCu()" value="保存" /></div>
                        
                        </div>
                        
                    </div>
<!-- 
                <div class="bg_dq">
                    <div class="bg_dqt">修改基本资料<span class="blue">返回个人信息</a></span></div>
                    <div class="bg_dqc">
                      <div class="bg_dqcl"></div>
                      <div class="bg_dqcr"></div>
                    </div>
                    <div class="bg_dqd">
                       <div class="bg_dqd_l">
                          <div class="bg_dqd_lt">
                              <div class="bg_dqd_ltt"><a href="#"><img src="images/bg_12.png" /></a></div>
                              <div class="bg_dqd_ltd"><span class="blue"><a href="/litscloud/msg/no_function.jsp">修改头像</a></span></div>
                          </div> 
                       </div>
                        <div class="bg_dqd_r">
                           <div class="bg_dqd_rs">
                             <dl>名字</dl>
                             <dt>${customer.realName }</dt>
                             <dl></dl>
                             <dd><input type="text" name="data_name" class="data_name" value="Mjeiofj" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>注册时间：</dl>
                             <dt>2013-03-22 10:12:09</dt>
                             <dl>性 &nbsp; &nbsp; &nbsp; 别：</dl>
                             <dd><input name="data_sex"  type="radio" value="男" checked="checked" /> 男 <input name="data_sex" type="radio" value="女" /> 女</dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>移动电话:</dl>
                             <dt><input type="text" name="mobilePhone" class="data_name" value="${customer.mobilePhone }" /></dt>
                             <dl>固定电话：</dl>
                             <dd><input type="text" name="phone" class="data_name" value="${customer.phone }" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>身份证号：</dl>
                             <dt><input type="text" name="data_card" class="data_name" value="43058119930612751x" /></dt>
                             <dl>QQ号 码：</dl>
                             <dd><input type="text" name="data_QQ" class="data_name" value="2178963489" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>生 &nbsp; &nbsp; &nbsp; 日：</dl>
                             <dt><input type="text" name="data_birthday" class="data_name" value="03-22" /></dt>
                             <dl>个人邮箱：</dl>
                             <dd><input type="text" name="data_maile" class="data_name" value="154512644@qq.com" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>公司名称：</dl>
                             <dt><input type="text" name="customerCompany" class="data_name" value="${customer.customerCompany }" /></dt>
                             <dl>营业执照：</dl>
                             <dd><input type="text" name="data_business" class="data_name" value="154512644" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>公司规模：</dl>
                             <dt><input type="text" name="data_scale" class="data_name" value="${customer.companyScale }" /></dt>
                             <dl>公司电话：</dl>
                             <dd><input type="text" name="companyphone" class="data_name" value="${customer.companyphone}" /></dd>
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>公司地址：</dl>
                             <dt style="width:350px;"><input type="text" name="companyadress" class="data_address" value="${customer.companyadress}" /></dt>                           
                           </div>
                           <div class="bg_dqd_rs">
                             <dl>授&nbsp; 权&nbsp; 码：</dl>
                             <dt style="width:350px;"><input type="text" name="data_code" class="data_name" value="15452156" /></dt>                           
                           </div>
                           
                        </div>
                    </div>
                    
                    <div class="bg_an">
                        <div class="bg_anc"><a href="#">保 &nbsp; 存</a></div>
                    </div>
                </div>  
                
            -->