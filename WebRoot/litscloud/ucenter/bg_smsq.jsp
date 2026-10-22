<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<title>立云-用户后台-填写实名认证</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link href="litscloud/css/style.css" rel="stylesheet" type="text/css" />
<link href="litscloud/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="litscloud/js/user.js"></script>
<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
					<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		
<!-- 解决IE6不缓存背景图片的问题-->
<!--[if IE 6]>
<script type="text/javascript">
document.execCommand("BackgroundImageCache", false, true);
</script>
<![endif]-->
<script type="text/javascript">
function yanzheng(lujing)
{
	document.getElementById("tupian").src=lujing+"/servlet/Img";

} 
function xuanzhe()
{
	document.getElementById("cuSFZTime1").checked='';
}
  function uploadImage11(aaa) {
	        var img1=$('#img1').val();
	
									  
		var files=aaa;
		if(files == null || files == "")
		{
		alert("请选择要上传的文件");
		
		return;
		}
	$(document)
			.ready(
					function() {
						var options = {
						    url : "uploademp.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									var pathi=$('#pathi').val();
									var va=pathi+data[1];
								   $('#imga1').attr('src',va);
								   $('#img1').attr('value',va);
								   
									
								} else {
								
								}
							}
						};
						$("#formaddss").ajaxSubmit(options);
						return false;
					});
                  }	
  function uploadImage111(aa) {
	        var img1=$('#img11').val();
		
									  
		var files=aa;
		if(files == null || files == "")
		{
		alert("请选择要上传的文件");
		
		return;
		}
	$(document)
			.ready(
					function() {
						var options = {
						    url : "upload1emp.do",
							type : "POST",
							dataType : "script",
							success : function(msg) {
								if (msg.indexOf("#") > 0) {
									var data = msg.split("#");
									var pathi=$('#pathi').val();
									var va=pathi+data[1];
								   $('#imga11').attr('src',va);
								   $('#img11').attr('value',va);
								   
									
								} else {
								
								}
							}
						};
						$("#formaddss").ajaxSubmit(options);
						return false;
					});
                  }	
function dj()
{
	var cuSFZTime1 = document.getElementById("cuSFZTime1");
	if(cuSFZTime1.checked==true)
	{
		document.getElementById("cuSFZTime").value="永久";
	}

}
function yanzheng()
{
	var cuName=document.getElementById("cuName").value;
	var cuSFZ=document.getElementById("cuSFZ").value;
	var cuGDPhone=document.getElementById("cuGDPhone").value;
	var cuSFZTime=document.getElementById("cuSFZTime").value;
	var cuSFZTime1 = document.getElementById("cuSFZTime1");
	var cuDZ=document.getElementById("cuDZ").value;
	var ValCode=document.getElementById("ValCode").value;
	var yanzhengma=document.getElementById("yanzhengma").value;
	var img1=document.getElementById("img1").value;
	var img11=document.getElementById("img11").value;
	
	
	if(cuName==""||cuName==null)
	{
		document.getElementById("cuName1").innerHTML="用户名不能为空";
	document.getElementById("cuName1").style.color="#F00";
		return false;
	}
	else
	{
		document.getElementById("cuName1").innerHTML="";	
	}
	if(cuSFZ==""||cuSFZ==null)
	{
	document.getElementById("cuSFZ1").style.color="#F00";
		document.getElementById("cuSFZ1").innerHTML="身份证号码不能为空";
		return false;
	}
	else 
	{
		document.getElementById("cuSFZ1").innerHTML="";
	}
	
		var a=checkIdcard(cuSFZ);
		if(a!="身份证验证通过!")
		{
			document.getElementById("cuSFZ1").style.color="#F00";
			document.getElementById("cuSFZ1").innerHTML=a;
			return false;
		}
		else
		{
			document.getElementById("cuSFZ1").innerHTML="";
		}
	 if(cuGDPhone==""||cuGDPhone==null)
	{
	document.getElementById("cuGDPhone1").style.color="#F00";
		document.getElementById("cuGDPhone1").innerHTML="固定电话不能为空";
		return false;
	}
	else
	{
		document.getElementById("cuGDPhone1").style.color="#F00";
		document.getElementById("cuGDPhone1").innerHTML="固定电话不能为空";
	}
	if((/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/).test(cuGDPhone)==false)
	{
		document.getElementById("cuGDPhone1").style.color="#F00";
		document.getElementById("cuGDPhone1").innerHTML="固定电话格式不正确";
		return false;
	}
	else
	{
		document.getElementById("cuGDPhone1").innerHTML="";
	}
	 if(img11==""||img11==null)
	{
	document.getElementById("imgtishi1").style.color="#F00";
		document.getElementById("imgtishi1").innerHTML="请上传身份证正面";
	
		return false;
	}
	else if(img1==""||img1==null)
	{
		document.getElementById("imgtishi1").innerHTML="";
		document.getElementById("imgtishi2").style.color="#F00";
		document.getElementById("imgtishi2").innerHTML="请上传身份证反面";
		return false;
	}
	else{
		document.getElementById("imgtishi2").innerHTML="";
	}
	 if(cuSFZTime=="" ||cuSFZTime==null )
	{
	document.getElementById("cuSFZTime11").style.color="#F00";
		document.getElementById("cuSFZTime11").innerHTML="有效期不能为空";
		return false;
	}
	else
	{
	
		document.getElementById("cuSFZTime11").innerHTML="";
	}
	if(cuDZ==""||cuDZ==null)
	{
			document.getElementById("cuDZ1").style.color="#F00";
		document.getElementById("cuDZ1").innerHTML="地址不能为空";
		return false;
	}
	else
	{
		document.getElementById("cuDZ1").innerHTML="";
	}
	if(ValCode==""||ValCode==null)
	{
		document.getElementById("YZM1").innerHTML="验证码不能为空";
		return false;
	}
	else if(yanzhengma!=ValCode)
	{
		document.getElementById("YZM1").innerHTML="验证码错误";
		return false;
	}
	else
	{
		document.getElementById("YZM1").innerHTML="";
	}
	$("#formaddss").submit();

}     
function checkIdcard(idcard){
var Errors=new Array(
"身份证验证通过!",
"身份证号码位数不对!",
"身份证号码出生日期超出范围或含有非法字符!",
"身份证号码校验错误!",
"身份证地区非法!"
);
var area={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}


var idcard,Y,JYM;
var S,M;
var idcard_array = new Array();
idcard_array = idcard.split("");
//地区检验
if(area[parseInt(idcard.substr(0,2))]==null) return Errors[4];
//身份号码位数及格式检验
switch(idcard.length){
case 15:
if ( (parseInt(idcard.substr(6,2))+1900) % 4 == 0 || ((parseInt(idcard.substr(6,2))+1900) % 100 == 0 && (parseInt(idcard.substr(6,2))+1900) % 4 == 0 )){
ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/;//测试出生日期的合法性
} else {
ereg=/^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/;//测试出生日期的合法性
}
if(ereg.test(idcard)) return Errors[0];
else return Errors[2];
break;
case 18:
//18位身份号码检测
//出生日期的合法性检查
//闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))
//平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))
if ( parseInt(idcard.substr(6,4)) % 4 == 0 || (parseInt(idcard.substr(6,4)) % 100 == 0 && parseInt(idcard.substr(6,4))%4 == 0 )){
ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/;//闰年出生日期的合法性正则表达式
} else {
ereg=/^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/;//平年出生日期的合法性正则表达式
}
if(ereg.test(idcard)){//测试出生日期的合法性
//计算校验位
S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
+ (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
+ (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
+ (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
+ (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
+ (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
+ (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
+ parseInt(idcard_array[7]) * 1
+ parseInt(idcard_array[8]) * 6
+ parseInt(idcard_array[9]) * 3 ;
Y = S % 11;
M = "F";
JYM = "10X98765432";
M = JYM.substr(Y,1);//判断校验位
if(M == idcard_array[17]) return Errors[0]; //检测ID的校验位
else return Errors[3];
}
else return Errors[2];
break;
default:
return Errors[1];
break;
}

}


   var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
function huanyige()
{
	 var res = "";
     for(var i = 0; i < 4 ; i ++) {
         var id = Math.ceil(Math.random()*35);
         res += chars[id];
     }
   document.getElementById("yanzhengma").value=res;

}
	
</script>
</head>

<body>
<!-- 头部S -->
<div class="ly_body">
<jsp:include page="/litscloud/ucenter/top2.jsp"></jsp:include>
<!-- 头部E -->
<!-- 中部S -->
  <div class="ly_imiddle" style="margin-top:0px;">
      <div class="ly_dh" style="height:4px; line-height:4px;"></div>  
      <div class="ly_n_login">
          <div class="bg_t">当前位置：<a href=litscloud/ucenter/index.jsp" target="_parent">首页</a>>会员中心</div> 
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
             <form action="litscloud/web/customerNameCustomerServerC.Action"  id="formaddss" name="formaddss" method="post" >
             <div class="ly_rzs">
               <div class="ly_rzs_t"><img src="litscloud/images/sf_08.gif" /></div> 
               <div class="ly_rzs_c">
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>真实姓名：</div> 
                     <div class="ly_rzs_ctr"><input type="text" name="cuName" id="cuName" class="zs_name" /> <span id="cuName1" >请输入身份证上的姓名</span></div> 
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>身份证号码：</div> 
                     <div class="ly_rzs_ctr"><input type="text" name="cuSFZ" id="cuSFZ" class="zs_name" /> <span id="cuSFZ1" >请填写真实的身份证号码，身份证号码是15或18数字</span></div> 
                   </div> 
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>固定电话：</div> 
                     <div class="ly_rzs_ctr"><input type="text" name="cuGDPhone" id="cuGDPhone" class="zs_name" /> <span id="cuGDPhone1" >如：0571-99166698-0571,分机号码可不填写</span></div> 
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span></div> 
                     <div class="ly_rzs_ctr"><div>
                     
					</div></div> 
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>身份证图片正面：</div> 
                     <div class="ly_rzs_ctr">
                     <div class="ly_rzs_ctrl" style="height: 200px;width: 150px">
                       <input type="hidden" id="img11" name="img11" value="" />
                     <input  type="file" name="fileupload1" size="10" id="fileupload1" onchange="uploadImage111(this.value)"  />
                     	<img src="potal/images/sc_tt.jpg" id="imga11"  width="122" height="139" /><span id="imgtishi1"></span>
                     	
                     </div> 
                       <div class="ly_rzs_ctrr">证件必须是彩色原件电子商务版，可以是扫描件或者数码拍摄照片，
仅支持：jpg.jpeg.bmo.的图片格式，<span>图片大小不超过2M</span></div>
                     </div>
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>身份证图片反面：</div> 
                     <div class="ly_rzs_ctr">
                       <div class="ly_rzs_ctrl" style="height: 200px;width: 150px">
                       <input type="hidden" id="img1" name="img1" value="" />
                     <input  type="file" name="fileupload" size="10" id="fileupload" onchange="uploadImage11(this.value)"  />
                     	<img src="potal/images/sc_tt.jpg" id="imga1"  width="122" height="139" />
                     	<input id="pathi" style="margin-bottom: 20px;" type="hidden" value="<%=basePath%>"><span id="imgtishi2"></span>
                     </div>
                   </div>

                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>身份证有效期：</div> 
                     <div class="ly_rzs_ctr">
                     
                     <INPUT  onblur="xuanzhe()" id="cuSFZTime" name="cuSFZTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
                     <input name="yxq_sc" id="cuSFZTime1" type="radio" value="二代身份证" onclick="dj()"  style=" margin-right:5px;"/> 长期 <span id="cuSFZTime11">日期的格式为：YYYY-MM-DD 如：2013-04-08，若证件有效期为长期，请选择长期</span></div> 
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>联系地址：</div> 
                     <div class="ly_rzs_ctr"><input type="text" name="cuDZ" id="cuDZ" class="zs_name" style="width:430px;" /><span id="cuDZ1"></span></div> 
                   </div>
                   <div class="ly_rzs_ct">
                     <div class="ly_rzs_ctl"><span>*</span>验证码：</div> 
                     
                     <div class="ly_rzs_ctr"><input name="ValCode" id="ValCode"  type="text" class="login_yzm" /> <input type="text" id="yanzhengma" disabled="true" name="yanzhengma" class="data_name" style="width: 70px" value="1124"/><a onclick="huanyige()" href="javascript:void(0);">看不清，换一张</a><span id="YZM1" style="color:#f00;"></span></div> 
                   </div>
                   
               </div> 
               <div class="ly_rzs_d" align="center">
                    <input type="button" style="background-image:litscloud/images/log_05.gif" onclick="yanzheng()" value="提交"/>
                      
                 </div> 
               </div> 
               </form>
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
<script type="text/javascript">
huanyige();	
</script>
</html>

