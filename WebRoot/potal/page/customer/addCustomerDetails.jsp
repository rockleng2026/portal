<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>添加客户</title>
    <script type="text/javascript" src="<%=basePath%>potal/js/jquery-1.6.min.js"></script>
    
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
         function uppeople(){
         $("#hidemp").hide();
         $("#showemp").show();
         var url="getemplistNewportalCustomer1.do";
           $.post(url,{},function(data){
          $("#showemp").html("");
           $("#showemp").append(data);
		    
		  });
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
          function closepage(){
 window.location.href="mycustomerlistNewportalCustomer1.do";
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
          
         function uppeople1(){
         $("#hidemp1").hide();
         $("#showemp1").show();
         var url="getemplistNewportalCustomer1.do";
           $.post(url,{},function(data){
          $("#showemp1").html("");
           $("#showemp1").append(data);
		    
		  });
         }
         
</script>
<body>
<div class="body" >

<div class="kh_middlebox">
<div class="kh_top">
<span><a href="javascript:removeDiv0();"><img src="<%=basePath%>potal/images/customer/xx.png" /></a></span>
客户信息新增页面
</div>
<div class="kh_nr">
<h2 class="listjs_1">
            <ul>
             <li id="wz31" class="mont1" onMouseOver="setTab2('wz3',1,2)"><a href="#">意向客户</a></li>
             <li id="wz32" class="" onMouseOver="setTab2('wz3',2,2)"><a href="#">正式客户</a></li>
            </ul>
    </h2>
	
	<div class="listjs_2" id="con1_wz3_1" style="display:block; float:left; ">
	<form method="post"  name="customerform" id="form1" action="newportaladdNewportalCustomer1.do" >
	<div class="kh_xx_1">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td width="29" rowspan="3" align="center" valign="middle" class="hs">个<br />
      人<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名</td>
    <td width="140" height="44" align="left"><input id="name1" type="text" onfocus="CheckForm(0)" onblur="CheckForm(0)" class="input_bd"   name="customerName" />
    <input type="hidden" name="customertype" value="1" id="customertypes"/>
    </td>
	
	<td width="150" height="44" align="left"><div id="scname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">身份证号</td>
    <td width="175" height="44" align="center"><input  name="cardid" type="text"  class="input_bd_2" /></td>
  </tr>
  <tr>
    <td width="65" height="44" align="right"><b class="red">*</b>移动电话</td>
    <td width="140" height="44" align="left"><input name="mobilePhone" id="phone" type="text" onfocus="CheckForm(0)" onblur="CheckForm(0)" class="input_bd" onblur="CheckFormphone(this.value)" /></td>
	<td  width="150" height="44" align="left"><div id="cphone" style="color:red;"></div></td>
    <td width="65" height="44" align="right">固定电话</td>
    <td width="175" height="44" align="center"><input name="phone" type="text"  class="input_bd_2" /></td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="45" align="right">QQ号码</td>
    <td width="140" height="45" align="left"><input name="qq" type="text" class="input_bd"  /></td>
	<td width="130" height="45" align="left"></td>
    <td width="65" height="45" align="right">个人邮箱</td>
    <td width="175" height="45" align="center"><input name="email" type="text" class="input_bd_2"  /></td>
   
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
    <td width="65" height="44" align="right"><b class="red">*</b>公司名称</td>
    <td width="140" height="44" align="left"><input id="wname1" name="customerCompany" onblur="CheckForm(0)" type="text"   class="input_bd" onfocus="CheckForm(0)"/></td>
	<td width="150" height="44" align="left"><div id="cwname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">营业执照</td>
    <td width="175" height="44" align="center"><input name="businessLicense"  type="text"  class="input_bd_2"/></td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司规模</td>
    <td width="140" height="44" align="left"><select name="companyScale"  class="input_bd" ><option value="1-50">1-50人</option><option value="1-50">51-100人</option><option value="101-500">51-100人</option><option value="500以上">500以上</option></select></td>
    <td width="150" height="44" align="left"></td>
    <td width="65" height="44" align="right">公司电话</td>
    <td width="175" height="44" align="center"><input name="companyphone" type="text"   class="input_bd_2"/></td>
    <td height="44" class="">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司地址</td>
	<td width="280" height="44" align="left" colspan="3"><input name="companyadress" type="text" class="input_bd_3" /></td>
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
    <td width="65" height="44" align="right"><b class="red">*</b>业务人员</td>
    <td width="140" height="44" align="left"><div id="hidemp"><input  name="employeeName" value="${employeeName}"  type="text" readonly="readonly"  class="input_bd" value="${employeeName}"/></div><div id="showemp" style="display: none"></div></td>
    <td width="150" height="44" align="left"><a href="javascript:uppeople();" class="gengai">更改</a></td>
    <td width="65" height="44" align="right">建立日期</td>
      <%
    
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd"); 

java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

String str_date1 = formatter.format(currentTime); //将日期时间格式化 

    
     %>
    <td width="175" height="44" align="center">
    <input type="text" name="date" class="input_bd_2" id="" value="<%=str_date1 %>" />
    </td>
    <td height="44"></td>
  </tr>
  <tr>
    <td height="44" colspan="3" align="left" valign="middle">
	<div class="khxq">
	<dl>
	<dd>客户需求</dd>
	<dt>
	  <textarea name="customerExplain" cols="" rows="" class="wbk"></textarea>
	</dt>
	</dl>
	</div>
	</td>
    <td height="44" colspan="5" align="left" valign="top">
	<div class="tjfj">
	<dl>
	<a href="javascript:showfj()"  onclick="showfj()">添加附件↓</a>&nbsp;
	
	</dl>
	</div>
	</td>
    </tr>
</table>
</div>
</form>
	
	<div class="tjan">
	
	<input name="" type="button" class="Save" onclick="CheckForm(1)" value="" /><input name="" type="button" onclick="closepage()" class="Cancel"/></div>


</div>
	</div>
	                                                                                   <!-- 正式客户-->
	
	<div class="listjs_2" id="con1_wz3_2" style="display:none; float:left;">
	<form method="post" name="customerform1" id="form2" action="newportaladdNewportalCustomer1.do" >
	<div class="kh_xx_1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td rowspan="3" align="center" valign="middle" class="hs">个<br />
      人<br />
      资<br>料</td>
    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名</td>
    <td width="140" height="44" align="left">
    <input id="vname" name="customerName" type="text"  class="input_bd"  onblur="CheckFormTwo(0)" onfocus="CheckFormTwo(0)" onblur="CheckFormTwovname('this.value')">
	<input type="hidden" name="customertype" value="3" />
	</td>
	<td width="150" height="44" align="left"><div id="cname1" style="color:red;"></div></td>
    <td width="65" height="44" align="right"><b class="red">*</b>身份证号</td>
    <td width="175" height="44" align="center"><input id="idcard"  name="cardid" type="text"   class="input_bd_2" onblur="CheckFormTwoidcard(this.value)" /></td>
	<td width="150" height="44" align="left"><div id="cidcard" style="color:red;"></div><div id="cidcard1" style="color:red;display: none"></div></td>
  </tr>
  <tr>
    <td width="65" height="44" align="right"><b class="red">*</b>移动电话</td>
    <td width="140" height="44" align="left"><input id="vphone" name="mobilePhone" onblur="CheckFormTwo(0)" type="text" onfocus="CheckFormTwo(0)"  class="input_bd" /></td>
	<td width="130" height="44" align="left"><div id="cphone1" style="color:red;"></div></td>
    <td width="65" height="44" align="right">固定电话</td>
    <td width="175" height="44" align="center"><input name="phone" type="text"  value="" class="input_bd_2"/></td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="45" align="right"><b class="red">*</b>QQ号码</td>
    <td width="140" height="45" align="left"><input id="qqq" name="qq" onblur="CheckFormTwo()" onfocus="CheckFormTwo(0)" type="text" class="input_bd" value=""/></td>
	<td  width="130" height="44" align="left"><div id="cqq" style="color:red;"></div></td>
    <td width="65" height="45" align="right"><b class="red">*</b>个人邮箱</td>
    <td width="175" height="45" align="center"><input id="email1" name="email"  type="text"  class="input_bd_2" onblur="CheckFormTwoemail(this.value)" /></td>
	 <td  width="135" height="44" align="left"><div id="cemail" style="color:red;"></div><div id="cemail1" style="color:red;display: none"></div></td>
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
    <td width="140" height="44" align="left"><input id="cname" name="customerCompany" onblur="CheckFormTwo(0)" type="text" onfocus="CheckFormTwo(0)"  class="input_bd" /></td>
	<td  width="135" height="44" align="left"><div id="ccname" style="color:red;"></div></td>
    <td width="65" height="44" align="right">营业执照</td>
    <td width="175" height="44" align="center"><input name="businessLicense" type="text"  class="input_bd_2"/></td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
    <td width="65" height="44" align="right">公司规模</td>
    <td width="140" height="44" align="left"><select name="companyScale"  class="input_bd" ><option value="1-50">1-50人</option><option value="1-50">51-100人</option><option value="101-500">51-100人</option><option value="500以上">500以上</option></select></td>
    <td width="150" height="44" align="left">&nbsp;</td>
    <td width="65" height="44" align="right">公司电话</td>
    <td width="175" height="44" align="center"><input name="companyphone" type="text" class="input_bd_2"/></td>
    <td height="44">&nbsp;</td>
  </tr>
  <tr>
   
	<td width="65" height="44" align="right"><b class="red">*</b>公司地址</td>
	<td width="280" height="44" align="left" colspan="3"><input id="address" onblur="CheckFormTwo(0)" onfocus="CheckFormTwo(0)" name="companyadress" type="text" class="input_bd_3"   /></td>
	<td><div id="caddress" style="color:red;"></div></td>
    </tr>
</table>

	</div>
	
	<div class="kh_xx_1">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">
  <tr>
    <td rowspan="2" align="center" valign="middle" class="hs">业<br />
      务<br />
      记<br>录</td>
    <td width="65" height="44" align="right"><b class="red">*</b>业务人员</td>
    <td width="140" height="44" align="left"><div id="hidemp1"><input  name="employeeName" value="${employeeName}"  type="text" readonly="readonly"  class="input_bd" value="${employeeName}"/></div><div id="showemp1" style="display: none"></div></td>
    <td width="150" height="44" align="left"><a href="javascript:uppeople1();" class="gengai">更改</a></td>
    <td width="65" height="44" align="right">建立日期</td>
    <td width="175" height="44" align="center"><input name="date"  value="<%=str_date1 %>" type="text"   class="input_bd_2"/></td>
    <td height="44"></td>
  </tr>
  <tr>
    <td height="44" colspan="3" align="left" valign="middle">
	<div class="khxq">
	<dl>
	<dd>客户需求</dd>
	<dt>
	  <textarea name="customerExplain" cols="" rows="" class="wbk"></textarea></dt>
	</dl>
	</div>
	</td>
    <td height="44" colspan="3" align="left" valign="top">
	<div class="tjfj">
	<dl>
	<a href="javascript:showfj()"  onclick="showfj()">添加附件↓</a>
	<!--  <dd>添加附件↓</dd>
	<dt><span>订单001.jpg <b class="hui">(30.95K)</b> <a href="#">删除</a></span>
	    <span>图片00.jpg <b class="hui">(30.95K)</b><strong><img src="<%=basePath%>potal/images/customer/jdt.jpg" /></strong> <a href="#">删除</a></span>
	<input type="hidden" value="暂无附件" name="customerfj"/>
	-->
	</dt>
	</dl>
	</div>
	</td>
    </tr>
    
</table>
	
	</div>
		</form>
	

	<div class="tjan">
	<input name="" type="button" class="Save" onclick="Checkform1()" value=""/><input name="" type="button" onclick="closepage()" class="Cancel"/></div>

	</div>
	
	
</div>


</div>
<div style="display: none" id="scfjc">
		 <table  border="0" cellpadding="0" cellspacing="0">
	<tr>
    <td  align="center" class="hs">附<br />
      件<br />
      资<br>料</td>
       <td height="23" width="740" >
         <!-- <jsp:include page="/potal/page/customer/uploadfiles.jsp" flush="true"></jsp:include>-->
       <!--<jsp:include page="/Basic/employee/uploadfiles.jsp"></jsp:include>-->
      <jsp:include page="/potal/page/uploadfile.jsp"></jsp:include>
       </td>
      </tr>
 
	</table>   
	</div>
</div>

</body>
</html>
