<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="css/index.css" />

<link type="text/css" rel="stylesheet" href="css/style.css" />
<script type="text/javascript" src="images/date2.js" charset="utf-8"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/System/V2Customer/js/options.js"></script>

<title>客户添加</title>
                                                                                                                                                                                                                                                                                                 96

<script type="text/javascript">
// 意向客户   验证
	function checkcustomerName(b)
	{	
		if($(b).val()=="")
		{
			$("#customernamefalseprompt").css("display","block");
		}
		else
		{
			$("#customernamefalseprompt").css("display","none");
		}
	}
	
	function checkPhone(b)
	{	
		if($(b).val()=="")
		{
			$("#phonefalseprompt").css("display","block");
		}
		else
		{
			$("#phonefalseprompt").css("display","none");
		}
	}
	
	function checkCompany(b)
	{	
		if($(b).val()=="")
		{
			$("#companynamefalseprompt").css("display","block");
		}
		else
		{
			$("#companynamefalseprompt").css("display","none");
		}
	}
	
	function checkBusinessname(b)
	{	
		if($(b).val()=="")
		{
			$("#change").css("display","none");
			$("#bussinessnamefalseprompt").css("display","block");
		}
		else
		{
			$("#change").css("display","block");
			$("#bussinessnamefalseprompt").css("display","none");
		}
	}
	
	function checkAll()
	{
		if($("#customername").val()=="")
		{
			$("#customername").focus();
			$("#customernamefalseprompt").css("display","block");
			return false;
		}
		else if($("#phone").val()=="")
		{
			$("#phone").focus();
			$("#phonefalseprompt").css("display","block");
			return false;
		}
		else if($("#company").val()=="")
		{
			$("#company").focus();
			$("#companynamefalseprompt").css("display","block");
			return false;
		}
		else if($("#bussinessname").val()=="")
		{
			$("#bussinessname").focus();
			$("#change").css("display","none");
			$("#bussinessnamefalseprompt").css("display","block");
			return false;
		}
		else
		{
			return true;
		}
	}
	
	// 验证正式客户
	function checkcustomerName1(b)
	{	
		if($(b).val()=="")
		{
			$("#customername1falseprompt").css("display","block");
		}
		else
		{
			$("#customername1falseprompt").css("display","none");
		}
	}
	
	function checkPhone1(b)
	{	alert(2);
		if($(b).val()=="")
		{
			$("#phone1falseprompt").css("display","block");
		}
		else
		{
			$("#phone1falseprompt").css("display","none");
		}
	}
	
	function checkIdentity1(b)
	{	
		if($(b).val()=="")
		{
			$("#identity1falseprompt").css("display","block");
		}
		else
		{
			$("#identity1falseprompt").css("display","none");
		}
	}
	
	function checkEmail(b)
	{	
		if($(b).val()=="")
		{
			$("#emailfalseprompt").css("display","block");
		}
		else
		{
			$("#emailfalseprompt").css("display","none");
		}
	}
	
	function checkQQ(b)
	{	
		if($(b).val()=="")
		{
			$("#QQfalseprompt1").css("display","block");
		}
		else
		{
			$("#QQfalseprompt1").css("display","none");
		}
	}
	
	function checkAddress(b)
	{	
		if($(b).val()=="")
		{
			$("#address1falseprompt").css("display","block");
		}
		else
		{
			$("#address1falseprompt").css("display","none");
		}
	}
	
	function checkCompany1(b)
	{	
		if($(b).val()=="")
		{
			$("#companyname1falseprompt").css("display","block");
		}
		else
		{
			$("#companyname1falseprompt").css("display","none");
		}
	}
	
	function checkBusinessname1(b)
	{	
		if($(b).val()=="")
		{
			$("#change1").css("display","none");
			$("#bussinessname1falseprompt").css("display","block");
		}
		else
		{
			$("#change1").css("display","block");
			$("#bussinessname1falseprompt").css("display","none");
		}
	}
	
	function checkAll1()
	{
		if($("#customername1").val()=="")
		{
			$("#customername1").focus();
			$("#customername1falseprompt").css("display","block");
			return false;
		}
		else if($("#identity1").val()=="")
		{
			$("#identity1").focus();
			$("#identity1falseprompt").css("display","block");
			return false;
		}
		else if($("#phone1").val()=="")
		{
			$("#phone1").focus();
			$("#phone1falseprompt").css("display","block");
			return false;
		}
		else if($("#QQ").val()=="")
		{
			$("#QQ").focus();
			$("#QQfalseprompt1").css("display","block");
			return false;
		}
		else if($("#email1").val()=="")
		{
			$("#email1").focus();
			$("#emailfalseprompt").css("display","block");
			return false;
		}
		else if($("#company1").val()=="")
		{
			$("#company1").focus();
			$("#companyname1falseprompt").css("display","block");
			return false;
		}
		else if($("#address1").val()=="")
		{
			$("#address1").focus();
			$("#address1falseprompt").css("display","block");
			return false;
		}
		else if($("#bussinessname1").val()=="")
		{
			$("#bussinessname1").focus();
			$("#change1").css("display","none");
			$("#bussinessname1falseprompt").css("display","block");
			return false;
		}
		else
		{
			return true;
		}
	}
	
</script>




</head>



<body>

<!--[if IE 6]>

<script type="text/javascript" src="js/pngfix.js"></script>

<script type="text/javascript">

DD_belatedPNG.fix('.rightnr .change i, ..rightnr, ..btn-slide, .change i.cur , .mountainbox, img');

</script>

<![endif]-->

<div class="body">

<div class="top">

<dl>

<dd>你好，冷志勇!<a href="#">安全退出</a><a href="#">帐号管理</a></dd>

<dt>

<ul>

<li id="dlbj"><a href="#">办公桌面</a></li>

<li class="hover2"><a href="#">进销存管理</a></li>

<li class="hover2"><a href="#">综合管理</a></li>

<li class="hover2"><a href="#">商品管理</a></li>

<li class="hover2"><a href="#">客服中心</a></li>

</ul>

<span><form action="#" name="search">

<table border="0" cellpadding="0" cellspacing="0" class="tab_search">

<tr>

<td>

<input type="text" name="q" title="Search" class="searchinput" id="searchinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='关键字';" onfocus="if(this.value=='关键字')value='';" value="关键字" size="10"/>

</td>

<td>

<input type="image" width="21" height="17" class="searchaction" onclick="if(document.forms['search'].searchinput.value=='关键字')document.forms['search'].searchinput.value='';" alt="Search" src="images/ss2.jpg" border="0" hspace="2"/>

</td>

</tr>

</table>

</form></span>

</dt>



</dl>



</div>

<div class="topx"></div>

<div class="contentbox">

<div class="content">

<div class="leftbox">

<ul>

<li><a href="#">档案管理</a></li>

<li><a href="#">申报管理</a></li>

<li><a href="#">任务管理</a></li>

<li><a href="#">日程记事</a></li>

<li><a href="#">合同管理</a></li>

<li><a href="#">工作日志</a></li>

<li><a href="#">站内通讯</a></li>

<li><a href="#">系统管理</a></li></ul>



<div class="leftboot">

<img src="images/MM.jpg" />

<p>我是<span>By2</span>,正在<span>创意设计部</span>工作,昨天得到了<img src="images/jiang.jpg" />,好开心<img src="images/xiao.jpg" />.”<span>设计源于生活，细节成就品质</span>“</p>

</div>

</ul>

</div>

<div class="kh_middlebox">

<div class="kh_top">

<span><a href="#">×</a></span>

客户信息修改页面

</div>

<div class="kh_nr">

<h2 class="listjs_1">

            <ul>

             <li id="wz31" class="mont1" onclick="setTab2('wz3',1,2)"><a href="#">意向客户</a></li>

             <li id="wz32" class="" onclick="setTab2('wz3',2,2)"><a href="#">正式客户</a></li>

            </ul>

    </h2>

	<div class="listjs_2" id="con1_wz3_1" style="display:block;">
	
<form action="" onsubmit="return  checkAll()">

	<div class="kh_xx_1">

	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">

  <tr>

    <td width="29" rowspan="3" align="center" valign="middle" class="hs">个<br />

      人<br />

      资<br>料</td>

    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名</td>

    <td width="140" height="44" align="left"><input type="text" id="customername" class="input_bd" onblur="checkcustomerName(this)" value=""/></td><!--  background:url(../images/cwxx.jpg) no-repeat 0px 5px;-->

    <td width="150" height="44" align="left" >
    	<span  id="customernamefalseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>&nbsp;请正确输入您的姓名</span>
    </td>

    <td width="65" height="44" align="right">身份证号</td>

    <td width="175" height="44" align="center"><input name="" type="text"  class="input_bd_2" value=""/></td>

    <td height="44"><a href="#"><img src="images/zxzs.jpg"/></a></td>

  </tr>

  <tr>

    <td width="65" height="44" align="right"><b class="red">*</b>移动电话</td>

    <td width="135" height="44" align="left"><input type="text" id="phone" class="input_bd" value="" onblur="checkPhone(this)" /></td>

    <td width="150" height="44" align="left" >
	    <span  id="phonefalseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
	    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
	    	请正确输入您的电话号码</span>
    
   </td>

    <td width="65" height="44" align="right">固定电话</td>

    <td width="175" height="44" align="center"><input name="" type="text"  class="input_bd_2" value=""/></td>

    <td height="44">&nbsp;</td>

  </tr>

  <tr>

    <td width="65" height="45" align="right">QQ号码</td>

    <td width="140" height="45" align="left"><input name="" type="text" class="input_bd" value=""/></td>

    <td width="130" height="45" align="left"></td>

    <td width="65" height="45" align="right">个人邮箱</td>

    <td width="175" height="45" align="center"><input name="" type="text" class="input_bd_2" value="" /></td>

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

    <td width="140" height="44" align="left"><input name="" type="text" id="company" value="" onblur="checkCompany(this)"  class="input_bd"/></td>

    <td width="150" height="44" align="left" >
    	<span  id="companynamefalseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请正确输入您的公司名称</span>
   	</td>

    <td width="65" height="44" align="right">营业执照</td>

    <td width="175" height="44" align="center"><input name="" value="" type="text"  class="input_bd_2"/></td>

    <td height="44" class="">&nbsp;</td>

  </tr>

  <tr>

    <td width="65" height="44" align="right">公司规模</td>

    <td width="140" height="44" align="left"><input name="" type="text" value="" class="input_bd" /></td>

    <td width="150" height="44" align="left"></td>

    <td width="65" height="44" align="right">公司电话</td>

    <td width="175" height="44" align="center"><input name="" type="text" value=""  class="input_bd_2"/></td>

    <td height="44" class="">&nbsp;</td>

  </tr>

  <tr>

    <td height="45" colspan="6"><div class="gsdz">

	<dl>

	<dd>公司地址</dd>

	<dt><input name="" type="text" class="input_bd_3" value=""/></dt>

	</dl>

	</div></td>

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

    <td width="140" height="44" align="left"><input name="" type="text" id="bussinessname" class="input_bd" value="" onblur="checkBusinessname(this)"/></td>

    <td width="150" height="44" align="left">
    	<a href="更改业务人员弹层.html" class="gengai" target="_blank" id="change">更改</a>
    	<span  id="bussinessnamefalseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请正确输入您的业务人员</span>
    </td>

    <td width="65" height="44" align="right">建立日期</td>

    <td width="175" height="44" align="center"><input name="" type="text"  class="input_bd_2" value="2013-11-06"/></td>

    <td height="44"></td>

  </tr>

  <tr>

    <td height="44" colspan="3" align="left" valign="middle">

	<div class="khxq">

	<dl>

	<dd>客户需求</dd>

	<dt>

	  <textarea name="" cols="" rows="" class="wbk">希望公司有更多的优惠</textarea>

	</dt>

	</dl>

	</div>

	</td>

    <td height="44" colspan="3" align="left" valign="top">

	<div class="tjfj">

	<dl>

	<dd>添加附件↓</dd>

	<dt>

	<span>订单001.jpg <b class="hui">(30.95K)</b> <a href="#">删除</a></span>

	    <span>图片00.jpg <b class="hui">(30.95K)</b><strong><img src="images/jdt.jpg" /></strong> <a href="#">删除</a></span>

	</dt>

	</dl>

	</div>

	</td>

    </tr>

</table>



	</div>

	

<div class="tjan"><input name="" type="submit" class="Save" value="" /><input name="" type="button"  class="Cancel"/></div>

	</div>
</form>
	

	<div class="listjs_2" id="con1_wz3_2" style="display:none; ">
	
<form action="" onsubmit="return checkAll1()">

	<div class="kh_xx_1">

	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="133">

  <tr>

    <td rowspan="3" align="center" valign="middle" class="hs">个<br />

      人<br />

      资<br>料</td>

    <td width="65" height="44" align="right"><b class="red">*</b>客户姓名</td>

    <td width="140" height="44" align="left"><input name="customername" id="customername1" type="text" onblur="checkcustomerName1(this)" value="" class="input_bd"/></td>

    <td width="150" height="44" align="left" >
  		<span  id="customername1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请正确输入您的姓名
   			
   			</span>  
    </td>

    <td width="65" height="44" align="right"><b class="red">*</b>身份证号</td>

    <td width="175" height="44" align="center"><input name="identity" type="text" id="identity1" value="" class="input_bd_2" onblur="checkIdentity1(this)"/></td>

    <td height="44">
  		<span  id="identity1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			您输入的身份证号有误</span>
    </td>

  </tr>

  <tr>

    <td width="65" height="44" align="right"><b class="red">*</b>移动电话</td>

    <td width="140" height="44" align="left"><input name="" type="text" value="" id="phone1" onblur="checkPhone1(this)" class="input_bd" /></td>

    <td width="135" height="44" align="left" >
  		<span  id="phone1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			 请正确输入您的电话号码</span>  
    </td>

    <td width="65" height="44" align="right">固定电话</td>

    <td width="175" height="44" align="center"><input name="" type="text"  value="" class="input_bd_2"/></td>

    <td height="44">&nbsp;</td>

  </tr>

  <tr>

    <td width="65" height="45" align="right"><b class="red">*</b> QQ&nbsp;号码</td>

    <td width="140" height="45" align="left"><input name="" type="text" value="" id="QQ" class="input_bd" onclick="checkQQ(this)"/></td>

    <td width="130" height="45" align="left">
  		<span  id="QQfalseprompt1" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请输入常用的QQ</span>    
    </td>

    <td width="65" height="45" align="right"><b class="red">*</b>个人邮箱</td>

    <td width="175" height="45" align="center"><input name="" value="" id="email1" onblur="checkEmail(this)" type="text" class="input_bd_2" /></td>

    <td height="45" width="150">
  			  <span  id="emailfalseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请正确输入您的常用邮箱</span>  
    </td>

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

    <td width="140" height="44" align="left"><input name="" type="text" value="" id="company1" onblur="checkCompany1(this)"  class="input_bd"/></td>

    <td width="150" height="44" align="left" >
  			   <span  id="companyname1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>请正确输入您的公司名称</span>  
   			
   	</td>

    <td width="65" height="44" align="right">营业执照</td>

    <td width="175" height="44" align="center"><input name="" value="" type="text"  class="input_bd_2"/></td>

    <td height="44">&nbsp;</td>

  </tr>

  <tr>

    <td width="65" height="44" align="right">公司规模</td>

    <td width="140" height="44" align="left"><input name="" type="text" value="" class="input_bd" /></td>

    <td width="150" height="44" align="left">&nbsp;</td>

    <td width="65" height="44" align="right">公司电话</td>

    <td width="175" height="44" align="center"><input name="" type="text" value=""  class="input_bd_2"/></td>

    <td height="44">&nbsp;</td>

  </tr>

  <tr>

    <td height="45" colspan="6"><div class="gsdz">

	<dl>

	<dd><b class="red">*</b>公司地址</dd>

	<dt width="100%"><p><input name="" type="text" id="address1" class="input_bd_3" id="address1" onblur="checkAddress(this)" value=""/></p>
	    <span  id="address1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    		<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   			请您输入公司详细的地址
   			</span> 
   		 </dt>

	

	</dl>

	

	</div></td>

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

    <td width="140" height="44" align="left"><input name="" type="text" value=""  class="input_bd" id="bussinessname1" onblur="checkBusinessname1(this)"/></td>

    <td width="150" height="44" align="left"><a href="更改业务人员弹层.html" target="_blank" class="gengai" id="change1">更改</a>
    	<span  id="bussinessname1falseprompt" width="150"  align="left" height="44"  style="display:none;  color:#FF0000;">
    	<img src="<%=request.getContextPath()%>/System/V2Customer/images/cwxx.jpg" style="margin-left: 0" width="10px;"/>
   		请您输入业务人员
   			</span> 
    </td>

    <td width="65" height="44" align="right">建立日期</td>

    <td width="175" height="44" align="center"><input name="" type="text" value=""  class="input_bd_2"/></td>

    <td height="44"></td>

  </tr>

  <tr>

    <td height="44" colspan="3" align="left" valign="middle">

	<div class="khxq">

	<dl>

	<dd>客户需求</dd>

	<dt>

	  <textarea name="" cols="" rows="" class="wbk">希望公司有更多的优惠</textarea></dt>

	</dl>

	</div>

	</td>

    <td height="44" colspan="3" align="left" valign="top">

	<div class="tjfj">

	<dl>

	<dd>添加附件↓</dd>

	<dt><span>订单001.jpg <b class="hui">(30.95K)</b> <a href="#">删除</a></span>

	    <span>图片00.jpg <b class="hui">(30.95K)</b><strong><img src="images/jdt.jpg" /></strong> <a href="#">删除</a></span>

	</dt>

	</dl>

	</div>

	</td>

    </tr>

</table>



	</div>

	<div class="tjan"><input name="" type="submit" class="Save" value=""/><input name="" type="button"  class="Cancel"/></div>

	</div>

	</form>

</div>



</div>

</div>



<div class="rightbox">

<div class="slide"><a href="#" class="btn-slide">展开</a></div>

<div id="panel">

<div class="rightnr"  id="test">

<div class="right">

<span class="jstx">即时提醒</span>

<ul>

<li><a href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">短消息</a>(<span><a id="hong" href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">2</a>

<div id="light" class="white_content">

		<iframe style="position:absolute; left:-500px;" scrolling="no" frameborder="0" src="tanchu.html" marginheight="0" marginwidth="0" width="766" height="442"></iframe>

<div class="xx">

<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img src="images/xx.jpg"></a></div>

</div></span>)</li>

<li><a href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">邮件</a>(<span><a id="hong" href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">1</a>

<div id="light" class="white_content">

		<iframe scrolling="no" frameborder="0" src="tanchu.html" marginheight="0" marginwidth="0" width="766" height="442"></iframe>

<div class="xx">

<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img src="images/xx.jpg"></a></div>

</div></span>)</li>

<li><a href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">任务通知</a>(<span><a id="hong" href="javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">1</a>

<div id="light" class="white_content">

		<iframe scrolling="no" frameborder="0" src="tanchu.html" marginheight="0" marginwidth="0" width="766" height="442"></iframe>

<div class="xx">

<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"><img src="images/xx.jpg"></a></div>

</div></span>)</li>

<li><a href="#">留言</a>(<span><a href="#" id="hong">0</a></span>)</li>

<li><a href="#">待处理任务</a>(<span><a href="#" id="hong">0</a></span>)</li>

<li>&nbsp;</li>

<li>&nbsp;</li>

<li>&nbsp;</li>

</ul>

<p>常用工具</p>

<div class="right_2">

<dl><dd><img src="images/yun.gif" /></dd>

<dt>20°C 多云 威风</dt></dl>

</div>

<div class="right_2">

<dl>

<dd><img src="images/zhong.gif" /></dd>

<dt>时间:2012-11-13 19:10

<br /><span>星期:星期一</span></dt>

</dl>

</div>

</div>

</div>

</div>





</div>







</div>

<div class="dibu"></div>

</div>

<div class="dibuxia"></div>

<script type="text/javascript" src="js/tuodong.js"></script>

<script type="text/javascript" src="js/jquery.js"></script>



<script type="text/javascript">

$(document).ready(function(){



	$(".btn-slide").click(function(){

		$("#panel").slideToggle("slow");

		$(this).toggleClass("active"); return false;

	});

	

	 

});

</script>

</body>

</html>