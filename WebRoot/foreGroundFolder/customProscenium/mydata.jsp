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
		<TITLE>个人资料</TITLE>

		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
		<script type="text/javascript" src="<%=path%>/js/cascadingmenu.js">
</script>

		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description
			content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
		<META name=keywords
			content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico">
		<NOSCRIPT>
			<META name=GENERATOR content="MSHTML 8.00.6001.19154">
	</HEAD>
	<BODY leftMargin=0 topMargin=0>
		<IFRAME src="subnote_files1/sa.htm"></IFRAME>
		</NOSCRIPT>
		<SCRIPT language=javascript>
function showcontact()
    {
        with (document.regform) {	   
        if (Contact_Type[0].checked){
            EnCard.style.display="none";
            }
        else{
            EnCard.style.display="";
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
	   }
		return true;
}
////////////////////////
function regpwd2(){
		var user_pwd=document.getElementById('u_password2').value;	
		var user_pwdup=document.getElementById('customerPassword').value;
		user_pwdup=user_pwdup.replace(/\s+/g,"");
		user_pwd=user_pwd.replace(/\s+/g,"");
	//	if(user_pwdup==""){
	//		pwd2.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>请先设定密码！';
	//		return false;		
		
	//	}
	//    else 
	    if(user_pwdup!=user_pwd){
			pwd2.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>两次密码不一致！';
			return false;
	   }
	   else{
			pwd2.innerHTML='<img src="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
	   }
		return true;
}

  function realname(){
		var realName=document.getElementById('realName').value;		
		realName=realName.replace(/\s+/g,"");
		if(realName==""){
			real.innerHTML='<img src="subnote_files/icon_03.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>姓名（中文）不能为空！';
			return false;		
		}
	   else{
			real.innerHTML='<img src="subnote_files/icon_01.gif" width="17" height="17"  border="0" align="absmiddle" hspace="2"/>';
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
	}
	return true;
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

function checkreg(){
	
	
	if(regpwd()&&regpwd2()&&regsfz()&&realname()){
		return true;
	}
	else
	{
		return false;
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

</SCRIPT>
		<!--[if lte IE 6]>
       <style type="text/css">
       body { behavior:url("csshover.htc"); }
       </style>
       <![endif]-->
		<!--导航代码 -->

		<TABLE style="margin-left: 0px;" border=0 cellSpacing=1 cellPadding=2
			width="800" bgColor=#cccccc align=left>
			<TBODY>
				<c:if test="${biaoshi==1}">
					<tr>
						<td colspan="5" align="center">
							<h3>
								<font color="red">请先完善个人资料，才能进行CDN订单操作</font>
							</h3>
						</td>
					</tr>
				</c:if>
				<TR bgColor=#f0f0f0>
					<TD colspan="5">
						&nbsp;当前操作-》我的资料修改
					</TD>
				</TR>
			</TBODY>
			<FORM onsubmit="return checkreg()" method=post name=regform
				action="editPersionDataCustomerServer.Action">
				<TBODY>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							<FONT color=red>注册帐号:</FONT>
						</TD>
						<TD>
							&nbsp;
							<INPUT value=u_modi type=hidden name=module>
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 0px solid; BORDER-LEFT: #c0c0c0 0px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 0px solid; BORDER-RIGHT: #c0c0c0 0px solid"
								value="${customer.customerName }" name="customerName" readOnly>
							<A
								href="<%=path%>/foreGroundFolder/customProscenium/profile.jsp?id=${customer.customerId }"><FONT
								color=blue>设置密保</FONT>
							</A>
							<c:if test="${customer.issetmibao==1}">
								<font color="red">（已设置）</font>
							</c:if>
							<c:if test="${customer.issetmibao==0}">
								<font color="red">（未设置）</font>
							</c:if>
						</TD>
						<TD width=76 align=middle>
							用户类型:
						</TD>
						<TD width=211>
							&nbsp;个人用户
							<INPUT
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BORDER-TOP: 0px; BORDER-RIGHT: 0px"
								onclick=showcontact() value=0 CHECKED type=radio
								name=Contact_Type>
							&nbsp;企业用户
							<INPUT
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BORDER-TOP: 0px; BORDER-RIGHT: 0px"
								onclick=showcontact() value=1 type=radio name=Contact_Type>
						</TD>
					</TR>


					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							密码(修改):
						</TD>
						<TD colspan="3">
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								type="password" name="customerPassword" onblur="regpwd()">
							<font color="red">*</font>&nbsp;
							<SPAN id=pwd></SPAN>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							确认(修改):
						</TD>
						<TD colspan="3">
							&nbsp;
							<INPUT onblur="regpwd2()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								type=password name=u_password2>
							<font color="red">*</font>&nbsp;
							<SPAN id=pwd2></SPAN>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							授权码：
						</TD>
						<TD colspan="3">
							&nbsp;
							<input style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid" id="authorization" name="authorization" onblur="returndetermine()" type="text" value="${customer.authorization}"/>
							&nbsp;<SPAN id=authorization1 name="authorization1">5~~8为字符（用于验证客户是否授权给内部人员。比如:填写订单）</SPAN>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							单位(中文):
						</TD>
						<TD width=182>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=customerCompany value="${customer.customerCompany }">
						</TD>
						<TD width=76 align=middle>
							单位(英文):
						</TD>
						<TD width=211>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=customerCompanyYw value="${customer.customerCompanyYw }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							姓名(中文):
						</TD>
						<TD width=350>
							&nbsp;
							<INPUT onblur="realname()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								value="${customer.realName }" name=realName>
							<font color="red">*</font>&nbsp;
							<SPAN id=real></SPAN>
						</TD>
						<TD width=76 align=middle>
							姓名(拼音):
						</TD>
						<TD width=211>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=realNamePinyin value="${customer.realNamePinyin }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							国家(中文):
						</TD>
						<TD width=182 colspan="3">
							&nbsp;
							<SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name=customerCountry id="national1">

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
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							省份(中文):
						</TD>
						<TD width=182 colspan="3">
							&nbsp;
							<SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name=customerProvince id="national2">
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
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							城市(中文):
						</TD>
						<TD width=182 colspan="3">
							&nbsp;
							<SELECT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								size=1 name=customerCity id="national3">
								<c:if test="${customer.customerCity!=null}">
									<option value="${customer.customerCity}">
										${customer.customerCity}
									</option>
								</c:if>
								<c:if test="${customer.customerCity==null}">
									<option value=" ">
										地级市、县
									</option>
								</c:if>
							</SELECT>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							电话:
						</TD>
						<TD width=182>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=phone value="${customer.phone }">
						</TD>
						<TD width=76 align=middle>
							传真:
						</TD>
						<TD width=211>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=facsimile value="${customer.facsimile }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							移动电话:
						</TD>
						<TD>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								id="mobilePhone" name=mobilePhone value="${customer.mobilePhone }"><font color="red">必须填写</font>&nbsp;
						</TD>
						<TD width=81 align=middle>
							QQ号码:
						</TD>
						<TD>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 160px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=qq value="${customer.qq }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							身 份 证:
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT onblur="regsfz()"
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=cardid value="${customer.cardid }">
							&nbsp;&nbsp;
							<font color="red">必须填写</font>&nbsp;
							<SPAN id=sfz></SPAN>
						</TD>
					</TR>
					<TR style="DISPLAY: none" id=EnCard bgColor=#ffffff>
						<TD width=81 align=middle>
							证件号码:
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=dobusinesscode>
							&nbsp;&nbsp;营业执照或机构代码证号码
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							业务联系人:
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=businesslinkpersion
								value="${customer.businesslinkpersion }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							电子邮件:
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name="email" value="${customer.email }" name=u_email>
							&nbsp;&nbsp;请务必正确，否则可能不能收到密码
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							地址(中文):
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								value="${customer.customerAddress }" name=customerAddress>
								<font color="red">必须填写</font>&nbsp;
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							地址(英文):
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=addressYw value="${customer.addressYw }">
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=81 align=middle>
							邮编:
						</TD>
						<TD colSpan=3>
							&nbsp;
							<INPUT
								style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 220px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
								name=zipCode value="${customer.zipCode }">
								<font color="red">必须填写</font>&nbsp;
						</TD>

						<TR bgColor=#f9f9f9>
							<TD height=13 colSpan=4 align=middle>
								&nbsp;其他资料(可选项)
							</TD>
						</TR>
						<TR bgColor=#ffffff>
							<TD align=middle>
								备注说明:
							</TD>
							<TD colSpan=3>
								&nbsp;
								<INPUT
									style="BORDER-BOTTOM: #c0c0c0 1px solid; BORDER-LEFT: #c0c0c0 1px solid; WIDTH: 380px; HEIGHT: 16px; FONT-SIZE: 9pt; BORDER-TOP: #c0c0c0 1px solid; BORDER-RIGHT: #c0c0c0 1px solid"
									name=userNotes value="${customer.userNotes }">
							</TD>
						</TR>
						<TR bgColor=#ffffff>
							<TD colSpan=4 align=middle>
								<input name="customerId" id="customerId"
									value="${customer.customerId }" type="hidden" />
								<P align=center>
									&nbsp;
									<INPUT class=bt value="更 新" type=submit name=ok>
									&nbsp;
									<INPUT class=bt value="重 填" type=reset name=reset>
								</P>
							</TD>
						</TR>
			</FORM>

			<TR>
				<TD bgColor=#f0f0f0 height=1 width="90%" align=middle colspan="5">
					<LI>
						如你在本站系统中有什么还不明白的地方，请使用
						<A href="http://www.ebadu.com/manager/subnote.asp"><FONT
							color=red>帮助留言</FONT>
						</A>功能，我们的技术人员会给你答复。
					</LI>
				</TD>
			</TR>
			</TBODY>
		</TABLE>
		<BR>
		<!--right end-->
		</TR>
		</TBODY>
		</TABLE>
		</TD>
		</TR>
		<!--mid end-->
		</TABLE>
		</TD>
		</TR>
		</TABLE>
		<!--foot-->
		<LINK rel=stylesheet type=text/css href="subnote_files/base.css">
	</BODY>
	<script type="text/javascript">
window.onload = function() {
	setup();
}
</script>
</HTML>
