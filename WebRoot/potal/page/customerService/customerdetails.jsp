<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>查看客户详情</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<SCRIPT type="text/javascript">
	
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
	</SCRIPT>
</head>

<body>
<div class="body" >

<div class="kh_middlebox">
<div class="kh_top">
<span><a href="javascript:removeDiv0();"><img src="<%=basePath%>potal/images/customer/xx.png" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>
<c:if test="${customertypeid==1}">意向客户</c:if><c:if test="${customertypeid==3}">正式客户</c:if>信息页面
</div>
<div class="kh_nr1">
<h2 class="listjs_1">
            <ul>
             <li id="wz31" class="mont1" ><a href="#">
             <c:if test="${customertypeid==1}">意向客户</c:if>
             <c:if test="${customertypeid==3}">正式客户</c:if>
             </a></li>
            </ul>
    </h2>
	
	<div class="listjs_2" id="con1_wz3_1" style="display:block; float:left; ">
	<form method="post"  name="customerform" action="newportalupdataNewportalCustomer1.do" >
	<div class="kh_xx_1">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td width="29" rowspan="3" align="center" valign="middle" class="hs">个<br />
      人<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名:</td>
    <td width="140" height="44" align="left">${customer.realName }
    <input type="hidden" name="customertype" value="1" id="customertypes"/>
    <input type="hidden" name="customerid" value="${customer.customerId}">
    </td>
	
	<td width="150" height="44" align="left"><div id="scname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">身份证号:</td>
    <td width="175" height="44" align="left">${customer.cardid }</td>
    
  </tr>
  <tr>
    <td width="65" height="44" align="right"><b class="red">*</b>移动电话:</td>
    <td width="140" height="44" align="left">${customer.mobilePhone }</td>
	<td  width="150" height="44" align="left"><div id="cphone" style="color:red;"></div></td>
    <td width="65" height="44" align="right">固定电话:</td>
    <td width="175" height="44" align="left">${customer.phone }</td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="45" align="right">QQ      号码:</td>
    <td width="140" height="45" align="left">${customer.qq }</td>
	<td width="130" height="45" align="left"></td>
    <td width="65" height="45" align="right">个人邮箱:</td>
    <td width="175" height="45" align="left">${customer.email } </td>
   
	 <td height="45"></td>
  </tr>
</table>

	</div>
	
	<div class="kh_xx_1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td rowspan="3" align="center" valign="middle" class="hs">公<br />
      司<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>公司名称:</td>
    <td width="140" height="44" align="left">${customer.customerCompany}</td>
	<td width="150" height="44" align="left"><div id="cwname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">营业执照:</td>
    <td width="175" height="44" align="left">${customer.license}</td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司规模:</td>
    <td width="140" height="44" align="left">${customer.companyScale}人</td>
    <td width="150" height="44" align="left"></td>
    <td width="65" height="44" align="right">公司电话:</td>
    <td width="175" height="44" align="left">${customer.companyphone}</td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司地址:</td>
	<td width="280" height="44" align="left" colspan="3">${customer.companyadress}</td>
	 </tr>
</table>

	</div>
	<div class="kh_xx_1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td width="29" rowspan="2" align="center" valign="middle" class="hs">业<br />
      务<br />
      记<br>
      录</td>
    <td width="65" height="44" align="right"><b class="red">*</b>业务人员:</td>
    <td width="140" height="44" align="left">${customer.employee.name}</td>
    <td width="150" height="44" align="left"></td>
    <td width="240" height="44" align="left" colspan="2">&nbsp;&nbsp;建立日期:${customer.date}</td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td height="44" colspan="3" align="left" valign="top">
	<div class="khxq">
	&nbsp;&nbsp;客户需求:
	<dl>
	<dd></dd>
	<dt>
	  ${customer.customerexplain}
	</dt>
	</dl>
	</div>
	</td>
    <td height="44" colspan="3" align="left" valign="top">
	<div class="tjfj">
	&nbsp;&nbsp;附件信息:
	<dl>

	<c:if test="${customer.customerfj==null}">
       　暂无附件
    </c:if>
	<c:if test="${customer.customerfj!=null}">
     <c:forTokens items="${customer.customerfj}" delims="," var="fjlb">
	<span>附件<img src="<%=basePath%>potal/images/customer/xqc.jpg" /><b class="hui"></b><span><a href="javascript:xzfj('${fjlb}')" onclick="xzfj('${fjlb}')" >预览下载</a>&nbsp;&nbsp;<a href="javascript:delfj('${fjlb}',${customer.customerId})" onclick="delfj('${fjlb}',${customer.customerId})">删除</a></span></P>
	</c:forTokens>
	</c:if>
	</dl>
	</div>
	</td>
    </tr>
</table>

	</div>
	
  	<div class="tjan"><img onclick="removeDiv0()" src="<%=basePath%>potal/images/33333.jpg"/><!-- <input name="" type="button" onclick="removeDiv0()" value="关闭" class="Cancel"/> --></div>
</form>
	</div>
	
                                                                                   
	
	
</div>

</div>
</div>
</body>
</html>
