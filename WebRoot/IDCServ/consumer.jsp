<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0039)http://www.ebadu.com/manager/Mydata.asp -->
<HTML>
	<HEAD>
	<style type="text/css">
	
	   #end{
	   background: #bbecef;
	   }
	   table tr td{
	      font-size: 12px;
	   }
	   
	  table tr{ 
	    height: 29px;
	   }
	
	</style>
	
	
	
		<TITLE>个人资料</TITLE>

		
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
		<script type="text/javascript" src="<%=path%>/js/cascadingmenu.js">
</script>

		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico">
		<NOSCRIPT>
			<META name=GENERATOR content="MSHTML 8.00.6001.19154">
	</HEAD>
	<BODY leftMargin=0 topMargin=0>
		</NOSCRIPT>
		<SCRIPT language=javascript>
function showcontact()
    {
        with (document.regform) {	   
        if (Contact_Type[0].checked){
            EnCard.style.display="none";
            fo1.style.display="";
             fo2.style.display="none";
            }
        else{
            EnCard.style.display="";
            fo1.style.display="none";
             fo2.style.display="";
            }
        }
    }
        
    function regpwd(){
		var user_pwd=document.getElementById('customerPassword').value;		
		user_pwd=user_pwd.replace(/\s+/g,"");
		if(user_pwd==""){
			pwd.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码不能为空！';
			return false;		
		
		}
	    else if(user_pwd.length<6 || user_pwd.length>17){
	   		//alert('用户名长度必须为6 - 16位');
			pwd.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>密码长度必须为6 - 16位！';
			return false;
	   }
	   else{
			pwd.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	        return true;
	   }
		
}
////////////////////////
function regpwd2(){
		var user_pwd=document.getElementById('u_password2').value;	
		var user_pwdup=document.getElementById('customerPassword').value;
		user_pwdup=user_pwdup.replace(/\s+/g,"");
		user_pwd=user_pwd.replace(/\s+/g,"");
	    if(user_pwdup!=user_pwd){
			pwd2.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
			return false;
	   }
	   else{
			pwd2.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	        return true;
	   }
		
}

  function realname(){
		var realName=document.getElementById('realName').value;		
		realName=realName.replace(/\s+/g,"");
		if(realName==""){
			real.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>姓名（中文）不能为空！';
			return false;		
		}
	   else{
			real.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;
}

function regsfz(){
	var user_sfz=document.getElementById('cardid').value;	
	if(user_sfz=="")
	{
			sfz.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请输入您的身份证号码！';
		   return false;
	}
	else if(isIdCardNo(user_sfz)!=true){
			sfz.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>您的身份证号码有误！';
		   return false;
	}
	else{
		sfz.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	    return true;
	}
	
} 

 function isIdCardNo(num) 
    { 
        var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1); 
        var error; 
        var varArray = new Array(); 
        var intValue; 
        var lngProduct = 0; 
        var intCheckDigit; 
        var intStrLen = num.length; 
        var idNumber = num; 
        // initialize 
        if ((intStrLen != 15) && (intStrLen != 18)) 
        { 
            return false; 
        } 
        // check and set value 
        for(i=0;i<intStrLen;i++) 
        { 
            varArray[i] = idNumber.charAt(i); 
            if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) 
            { 
                return false; 
            } 
            else if (i < 17) 
            { 
                varArray[i] = varArray[i]*factorArr[i]; 
            } 
        } 
        
        if (intStrLen == 18) 
        { 
            //check date 
            var date8 = idNumber.substring(6,14); 
            if (checkDate(date8) == false) 
            { 
                //error = "身份证中日期信息不正确！."; 
                return false; 
            } 
            // calculate the sum of the products 
            for(i=0;i<17;i++) 
            { 
                lngProduct = lngProduct + varArray[i]; 
            } 
            // calculate the check digit 
            intCheckDigit = 12 - lngProduct % 11; 
            switch (intCheckDigit) 
            { 
                case 10: 
                intCheckDigit = 'X'; 
                break; 
                case 11: 
                intCheckDigit = 0; 
                break; 
                case 12: 
                intCheckDigit = 1; 
                break; 
            } 
            // check last digit 
            if (varArray[17].toUpperCase() != intCheckDigit) 
            { 
                return false; 
            } 
       } 
       else
        {   //length is 15 
            //check date 
            var date6 = idNumber.substring(6,12); 
            if (checkDate(date6) == false) 
            { 
                //alert("身份证日期信息有误！."); 
                return false; 
            } 
        } 
        return true; 
    } 
    
    function checkDate(date) 
    { 
        return true; 
    } 
function checkempNos(){
  var pmn=$('#businesslinkpersion').val();
  var flag=0;
  $.post("checkEmployeeNumsCustomerServer.do",{"nums":pmn},function(res){
     if(res=="not"){
          document.getElementById("businesslinkpersion").value="";
         $('#errormessage').html("此员工工号不存在，请填写正确的工号.");
        flag=1;
     }else{
      $('#errormessage').html("");
     }
  });
  if(flag==0){
      return true;
  }else{
     return false;
  }
  
}
function checkFiles1(){
   var uploadFile = $("#filelj01");
   var li = $("#li1").val();
   var ca = $("#ca1").val();
   var cu = $("#cu1").val();
   if(cu==1){
       if(li!=null&&li!=""){
    
       return  true;
       }else{
       for(var j =0;j<uploadFile.length;j++){
		if(!(uploadFile[j].value != null && uploadFile[j].value != "" )){
			alert("请选择图片上传！");
			return false;
		}
    }
 
    return true;
       }
   
   }
  if(cu!=1){

     if(ca==""||ca==null){

   	for(var j =0;j<uploadFile.length;j++){
		if(!(uploadFile[j].value != null && uploadFile[j].value != "" )){
			alert("请选择图片上传！");
			return false;
		}
    }
 
    return true;
  }else{
 
  return true;
  }
  
  }
}


function checkreg(){
    
 	if(regpwd()&&regpwd2()&&regsfz()&&realname()&&checkFiles1()&&checkPhone()&&ff()){

	   document.regform.submit();	

	}
	else
	{
		alert("请检查信息是否填写完整。");
	}
}
function returndetermine()
   {
   		var authorization=document.getElementById("authorization").value;
   		if(authorization==""||authorization==null)
   		{
   			document.getElementById("authorization1").innerHTML="请输入授权码！！！";
   			
   		}
   }
   
   function checkPhone(){
      var  num=/^1[3|4|5|8][0-9]\d{4,8}$/;
      var phone=$('#mobilePhone').val();
      if(!phone){
        document.getElementById("mobilePhone1").innerHTML="请输入手机号码";
        return false;
      }else if(!num.test(phone)){
      document.getElementById("mobilePhone1").innerHTML="请输入正确格式";
      return false;
      
      }else{
      document.getElementById("mobilePhone1").innerHTML=" <span style='color: blue;'>格式正确</span>";
      return true;
      }
   
   }
   
   function ff(){
   var sel3=$('#sel3').val();
   var gj=$('#national1').val();
   if(sel3=='1'){
   if(gj=='国家'){
  return false;
   }else{
  return true;
   }
   }else{
   return true;
   }
   }
   
</SCRIPT>

  </head>
 
  <body >
  
  <jsp:include page="head.jsp"></jsp:include>
  <jsp:include page="left.jsp"></jsp:include>

    <form method="post" name="regform"
				action="<%=basePath %>editPersionDataCustomerServer.Action" >
    <h5>当前操作—>我的资料修改</h5>
   <hr/>
       <table border="0" cellpadding="2" cellspacing="2">
           <tr> 
              <td align="right">账号</td>
              <td>&nbsp;
							<INPUT value=u_modi type=hidden name=module>
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 0px solid; BORDER-LEFT: #c0c0c0 0px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 0px solid; BORDER-RIGHT: #c0c0c0 0px solid"
								value="${customer.customerName }" name="custBean.customerName" readOnly>
							<A
								href="<%=path%>/IDCServ/profile.jsp?id=${customer.customerId }"><FONT
								color=blue>设置密保</FONT>
							</A>
							<c:if test="${customer.issetmibao==1}">
								<font color="red">（已设置）</font>
							</c:if>
							<c:if test="${customer.issetmibao==0}">
								<font color="red">（未设置）</font>
							</c:if>
							 </td> 
           </tr>
           
           <tr>
           <td align="right">用户类型:</td>
           <td>&nbsp;个人用户
							<INPUT
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BORDER-TOP: 0px; BORDER-RIGHT: 0px"
								onclick="showcontact()" onblur="f1()" value="0" <c:if test="${customer.cusClass!=1 }">checked</c:if> type="radio""
								name="Contact_Type">
							&nbsp;企业用户
							<INPUT
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BORDER-TOP: 0px; BORDER-RIGHT: 0px"
								onclick="showcontact()" onblur="f2()" value="1" type="radio"  name="Contact_Type" <c:if test="${customer.cusClass==1 }">checked</c:if>></td>
           </tr>
           
                       <tr> 
              <td align="right"> 密码(修改):</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								type="password" onblur="regpwd()" id="customerPassword" value="${customer.customerPassword }">
							<font color="red">*</font>&nbsp;
							<SPAN id=pwd></SPAN> </td> 
           </tr>
           <tr> 
              <td align="right"> 确认(修改):</td>
              <td>&nbsp;
							<INPUT onblur="regpwd2()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								type="password" name="custBean.customerPassword" id="u_password2" value="${customer.customerPassword }">
							<font color="red">*</font>&nbsp;
							<SPAN id=pwd2></SPAN> </td> 
           </tr>
             <tr> 
              <td align="right"> 授权码:</td> 
              <td>&nbsp;
							<input style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" id="authorization" name="custBean.authorization" onblur="returndetermine()" type="text" value="${customer.authorization}"/>
							&nbsp;<SPAN id=authorization1 >5~~8为字符（用于验证客户是否授权给内部人员。比如:填写订单）</SPAN></td> 
           </tr>
           
            <tr> 
              <td align="right">单位(中文):</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.customerCompany" value="${customer.customerCompany }"></td> 
            
           </tr>
           
           <tr>
             <td align="right">单位(英文):</td>
             <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.customerCompanyYw" value="${customer.customerCompanyYw }"> </td> 
           </tr>
           
           <tr> 
              <td align="right">姓名(中文):</td>
              <td>&nbsp;
							<INPUT onblur="realname()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								value="${customer.realName }" name="custBean.realName" id="realName">
							<font color="red">*</font>&nbsp;
							<SPAN id=real></SPAN> </td> 
              
           </tr>
           
           <tr>
           <td align="right">姓名（拼音):</td>
           <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.realNamePinyin" value="${customer.realNamePinyin }"></td> 
           </tr>
           
          
            <tr id="se0"> 
              <td align="right"> 国家(中文):</td>
              
              <td>&nbsp;
            	 <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name="custBean.customerCountry1" >

								<option value="	${customer.customerCountry}">
											${customer.customerCountry}
											</option>
									
						
							</SELECT>
							
              
                   省份(中文):    <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name="custBean.customerProvince1"  >
									<option value="${customer.customerProvince}">
										${customer.customerProvince}
											</option>
							</SELECT>    
              
              城市(中文): &nbsp;   <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name="custBean.customerCity1" >
								
									<option value="${customer.customerCity}">
										${customer.customerCity}
									</option>
							
								
							</SELECT>  
              
               <span style="color:red; ">*</span> </td> 
             <td></td><td></td>
           </tr>
           
           
           
           
           
           
           
          
            <tr style="display:none" id="se1"> 
            <input type="hidden" id="sel3" value="0"/>
              <td align="right"> 国家(中文):</td>
              
              <td>&nbsp;
             <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name=custBean.customerCountry id="national1">

								<c:if test="${customer.customerCountry!=null}">
									<option value="${customer.customerCountry}">
										${customer.customerCountry}
									</option>
								</c:if>
								<c:if test="${customer.customerCountry==null}">
									<option value=" ">
										国家
									</option>
								</c:if>
							</SELECT>
							
              
                   省份(中文):    <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name="custBean.customerProvince" id="national2" onfocus="change1()">
								<c:if test="${customer.customerProvince!=null}">
									<option value="${customer.customerProvince}">
										${customer.customerProvince}
									</option>
								</c:if>
								<c:if test="${customer.customerProvince==null}">
									<option value=" ">
										省份、州
									</option>
								</c:if>
							</SELECT>    
              
              城市(中文): <br/> &nbsp; <SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name="custBean.customerCity" id="national3">
								<c:if test="${customer.customerCity!=null}">
									<option value="${customer.customerCity}">
										${customer.customerCity}
									</option>
								</c:if>
								<c:if test="${customer.customerCity==null}">
									<option value=" ">
										地级市、县
									</option>
							
							</SELECT>  
							
              
               <span style="color:red; ">*</span> </td> 
             <td></td><td></td>
           </tr>
        
           </c:if>
           
            <tr> 
              <td align="right">电话:</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.phone" value="${customer.phone }"> </td> 
             
           </tr>
           <tr>
            <td align="right">传真:</td>
            <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.facsimile" value="${customer.facsimile }"> </td> 
           </tr>
           
            <tr> 
              <td align="right">移动电话:</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								id="mobilePhone" onblur="checkPhone()" name="custBean.mobilePhone" value="${customer.mobilePhone }"><font color="red" id="mobilePhone1">必须填写</font>&nbsp;</td> 
             
           </tr>
           
           <tr>
            <td align="right">qq号码:</td>
            <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.qq" value="${customer.qq }"> </td> 
           </tr>
           <tr> 
              <td align="right"> 身份证:</td>
              <td>&nbsp;
							<INPUT onblur="regsfz()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.cardid" id="cardid" value="${customer.cardid }">
							&nbsp;&nbsp;
							<font color="red">必须填写</font>&nbsp;
							<SPAN id=sfz></SPAN>
							 </td> 
           </tr>
           
          
           <c:if test="${customer.cusClass!=1 }">
                <tr style="DISPLAY: none" id="EnCard" >
           </c:if>
           <c:if test="${customer.cusClass==1 }">
              <tr style="DISPLAY:block;" id="EnCard" >
           </c:if>
						<TD align="right">
							证件号码:
						</TD>
						<TD>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.dobusinesscode" value="${customer.dobusinesscode }">
							&nbsp;&nbsp;营业执照或机构代码证号码
						</TD>
					</tr>

           
           
            <tr> 
              <td align="right"> 业务负责人(填写工号):</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.businesslinkpersion" id="businesslinkpersion"
								value="${customer.businesslinkpersion }">&nbsp;&nbsp;<span id="errormessage" style="color:red;"></span></td> 
           </tr>
           <tr> 
              <td align="right"> 电子邮件人:</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.email" value="${customer.email }" name="email">
							&nbsp;&nbsp;请务必正确，否则可能不能收到密码</td> 
           </tr>
   
           <tr> 
              <td align="right">地址(中文):</td>
              <td>	&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								value="${customer.customerAddress }" name="custBean.customerAddress">
								<font color="red">必须填写</font>&nbsp;</td> 
           </tr>
           <tr> 
              <td align="right">地址(英文):</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.addressYw" value="${customer.addressYw }"></td> 
           </tr>
            <tr> 
              <td align="right">邮编:</td>
              <td>&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="custBean.zipCode" value="${customer.zipCode }">
								<font color="red">必须填写</font>&nbsp; </td> 
           </tr>
            <tr id="end"> <td colspan="4" align="center">其他质料（必填项）</td></tr>
           <tr> 
              <td align="right">备注说明 :</td>
              <td>&nbsp;
				<INPUT
					style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 380px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
				    name="custBean.userNotes" value="${customer.userNotes }"> </td> 
           </tr>
       </table>
     <div>
       <table><tr>
       <td style="width: 220px;">
       <input name="custBean.customerId" id="customerId"
									value="${customer.customerId }" type="hidden" />
       </td><td style="width: 110px;"><input type="button" value="确认" style="margin-left: 200" onclick="checkreg()"> </td>
       <td style="width: 110px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重填"></td><td style="width: 22s0px;"></td>
       </tr></table>  
         </div>  
 
       </form> 
     <font id="fo1"  <c:if test="${customer.cusClass==1  }">style="display:none "</c:if>>上传个人证件</font>
     <font id="fo2" <c:if test="${customer.cusClass!=1  }">style="display:none "</c:if>>上传营业证件</font>
     
     <input id="li1" type="hidden" value="${customer.license }">
     <input id="ca1" type="hidden" value="${customer.cardPhoto }">
     <input id="cu1" type="hidden" value="${customer.cusClass}">
	 
	     <div id="file1">
	     <jsp:include page="/IDCServ/uploadphoto.jsp"></jsp:include>
	     </div>
     
     
       <div  style="font-size: 15px; ">
      <spam>.如你在本站系统中有什么还不明白的地,请使用<a href="" >帮助留言</a>功能,我们技术人员会给你答复.</spam> 
       </div> 
      <jsp:include page="bottom.jsp"></jsp:include>

  </body>
  <script type="text/javascript">
   window.onload = function() {
	setup();
}
</script>


<script type="text/javascript">

  function f1(){
  $('#cu1').attr('value','0');
  }
  
  function f2(){
   $('#cu1').attr('value','1');
  }


   $(function(){
     
     $('#se0').click(function(){
        $('#se1').show();
        $('#se0').hide();
        $('#sel3').attr('value','1');
     });
   
   });

</script>


</html>
