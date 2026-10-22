<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>修改客户</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/coverComment.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery-1.6.min.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/new.js"></script>
<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/index.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>potal/css/style.css" />
<script type="text/javascript" src="<%=basePath%>potal/js/options.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/check.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/tuodong.js"></script>
<script type="text/javascript" src="<%=basePath%>potal/js/jquery.js"></script>
</head>
<script type="text/javascript">
         
         function changetypeid(){
         $("#changetype").hide();
          $("#customertypes").val(3);
         }
          function xzfj(fj){
     window.location.href="download1TaskUpload.do?url="+fj;
 }
           function closepage(){
 window.location.href="mycustomerlistNewportalCustomer1.do";
 }
  function delfj(a,id){
  
      $.ajax({
	        type:'post',
	        url:'delfjNewportalCustomer1.do',
	        data:{custidcard:id,delnr:a},
	        success:function(res){
	        location.reload();
	     			
	        	
	        }
	  });
  
  
  
  
  }
 function showfj(){
  
      document.getElementById("scfjc").style.display="block"; 
   
  }
   function showfj1(){
  
  
   document.getElementById("scfjc1").style.display="block"; 
  }
  function hidescfj(){
  document.getElementById("scfjc").style.display="none"; 
  // document.getElementById("scfjc1").style.display="none"; 
  }
</script>
<body style="overflow-x:hidden">
<div  >

<div class="kh_middlebox">
<div class="kh_top">
<span><a href="javascript:removeDiv0();"><img src="<%=basePath%>potal/images/customer/xx.png" /></a></span>
正式客户信息修改页面
</div>
<div >
<h2 class="listjs_1">
            <ul>
             <li id="wz31" class="mont1" "><a href="#">
                               正式客户
             </a></li>
            </ul>
    </h2>
	<form method="post" id="form4"  name="customerform" action="newportalupdataNewportalCustomer1.do?customerid=${customer.customerId}" >
	<div class="listjs_2" id="con1_wz3_1" style="display:block; float:left; ">
	
	<div class="kh_xx_1">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
	
  <tr>
    <td width="29" rowspan="3" align="center" valign="middle" class="hs">个<br />
      人<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名</td>
    <td width="140" height="44" align="left"><input id="vname" type="text"  onblur="CheckFormTwo(0)" class="input_bd" value="${customer.realName }" onfocus="CheckFormTwo(0)"  name="customerName" />
    <input type="hidden" name="customertype" value="3" id="customertypes"/>
    <input type="hidden" name="customerid" value="${customer.realName}">
    </td>
	
	<td width="150" height="44" align="left"><div id="scname" style="color:red;"></div></td>
    <td width="65" height="44" align="right"><b class="red">*</b>身份证号</td>
    <td width="175" height="44" align="center"><input id="idcard" name="cardid" type="text" onfocus="CheckFormTwo(0)"  value="${customer.cardid }" onblur="CheckFormTwoidcard1(this.value,'${customer.cardid }')"   class="input_bd_2" /></td>
    <td width="150" height="44" align="left"><div id="cidcard" style="color:red;"></div><div id="cidcard1" style="color:red;display: none">验证成功</div></td>
    </td>
  </tr>
  <tr>
    <td width="65" height="44" align="right"><b class="red">*</b>移动电话</td>
    <td width="140" height="44" align="left"><input name="mobilePhone" id="vphone" onblur="CheckFormTwo(0)" onfocus="CheckFormTwo(0)"   type="text" value="${customer.mobilePhone }" class="input_bd"  /></td>
	<td width="130" height="44" align="left"><div id="cphone1" style="color:red;"></div></td>
    <td width="65" height="44" align="right">固定电话</td>
    <td width="175" height="44" align="center"><input name="phone" type="text" value="${customer.phone }" class="input_bd_2" /></td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="45" align="right"><b class="red">*</b>QQ号码</td>
    <td width="140" height="45" align="left"><input name="qq" id="qqq" value="${customer.qq }" onblur="CheckFormTwo(0)" onfocus="CheckFormTwo(0)"  type="text" class="input_bd" /></td>
<td  width="130" height="44" align="left"><div id="cqq" style="color:red;"></div></td>
    <td width="65" height="45" align="right"><b class="red">*</b>个人邮箱</td>
    <td width="175" height="45" align="center"><input name="email"  id="email1"  value="${customer.email }" onfocus="CheckFormTwo(0)"  onblur="CheckFormTwoemail1(this.value,'${customer.email }')" type="text" class="input_bd_2"  /></td>
  	 <td  width="135" height="44" align="left"><div id="cemail" style="color:red;"></div><div id="cemail1" style="color:red;display: none">验证成功</div></td>
  </tr>
</table>

	</div>
	
	<div class="kh_xx_1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td rowspan="3" align="center" valign="middle" class="hs">公<br />
      司<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>公司名称</td>
    <td width="140" height="44" align="left"><input id="cname" name="customerCompany" onfocus="CheckFormTwo(0)"  onblur="CheckFormTwo(0)" value="${customer.customerCompany}" type="text"   class="input_bd"/></td>
	<td  width="135" height="44" align="left"><div id="ccname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">营业执照</td>
    <td width="175" height="44" align="center"><input name="businessLicense" value="${customer.license}"  type="text"  class="input_bd_2"/></td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司规模</td>
    <td width="140" height="44" align="left">${customer.companyScale}人</td>
    <td width="150" height="44" align="left"></td>
    <td width="65" height="44" align="right">公司电话</td>
    <td width="175" height="44" align="center"><input name="companyphone" type="text"  value="${customer.companyphone}"    class="input_bd_2"/></td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right"><b class="red">*</b>公司地址</td>
	<td width="280" height="44" align="left" colspan="3"><input name="companyadress" onblur="CheckFormTwo(0)" onfocus="CheckFormTwo(0)"  id="address"  value="${customer.companyadress}"  type="text" class="input_bd_3" /></td>
	<td><div id="caddress" style="color:red;"></div></td>
	 </tr>
</table>

	</div>
	<div >
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td width="29" rowspan="2" align="center" valign="middle" class="hs">业<br />
      务<br />
      记<br>
      录</td>
    <td width="65" height="44" align="right"><b class="red">*</b>业务人员</td>
    <td width="140" height="44" align="left"><div id="hidemp"><input name="empid" type="hidden" value="${customer.employee.id}"/><input  name="employeeName" value="${customer.employee.name}"  type="text" readonly="readonly"  class="input_bd" value="${employeeName}"/></div><div id="showemp" style="display: none"></div></td>
    <td width="150" height="44" align="left"><!-- <a href="javascript:uppeople();" class="gengai">更改</a></td> -->
    <td width="65" height="44" align="right">建立日期</td>
    <td width="175" height="44" align="center">
    <input type="text" name="date" value="${customer.date}" class="input_bd_2" id="date" />
    </td>
    <td height="44"></td>
  </tr>
  
  <tr>
    <td height="44" colspan="3" align="left" valign="middle">
	<div class="khxq">
	<dl>
	<dd>客户需求</dd>
	<dt>
	  <textarea name="customerExplain" cols="" rows="" class="wbk">${customer.customerexplain}</textarea>
	</dt>
	</dl>

	</div>
	</td>
			
    <td height="44" colspan="3" align="left" valign="top">
	<div class="tjfj">
	<dl>
	<a onclick="showfj()">添加附件↓</a>
	 <c:if test="${customer.customerfj==null}">
       　　　　暂无附件
    </c:if>
	<c:if test="${customer.customerfj!=null}">
     <c:forTokens items="${customer.customerfj}" delims="," var="fjlb">
		<span>附件<img src="<%=basePath%>potal/images/customer/xqc.jpg" /><b class="hui"></b><span><a href="javascript:xzfj('${fjlb}')" onclick="xzfj('${fjlb}')" >预览下载</a>&nbsp;&nbsp;<a href="javascript:delfj('${fjlb}',${customer.customerId})" onclick="delfj('${fjlb}',${customer.customerId})">删除<a/></span></P>
	</c:forTokens>
	</c:if>
	</dl>

	</div>
	</td>
    </tr>
    	    </form>
    	  <tr ><td height="33" valign="middle" colspan="4" align="right" ><input name="" type="submit" class="Save"  onclick="Checkform2()" value="" /></td><td colspan="4" valign="middle" align="left">	<input name="" type="button" onclick="closepage()"  class="Cancel"/></td></tr>
    	
    <tr><td colspan="8" width="140">
    	<div style="display: none" id="scfjc">
		 <table  border="0" cellpadding="0" cellspacing="0">
	<tr>
    <td  align="center"  class="hs">附<br />
      件<br />
      资<br>料</td>
       <td height="23" width="740" align="top" valign="top" >
        
      <jsp:include page="/potal/page/uploadfile.jsp"></jsp:include>
      
       </td>
      </tr>
 
	</table>   
    
	</div>
    
    
    </td></tr>
  </table>
  
  <br/>
  <br/>

</div>
</div>
	 

	</div>
	
	</div>
	
</body>
</html>
