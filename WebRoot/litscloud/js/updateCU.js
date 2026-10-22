function updateCu()
{
	var customerName=document.getElementById("customerName").value;
	var realName=document.getElementById("realName").value;
	var date=document.getElementById("date").value;
	var businesslinkpersion=document.getElementById("businesslinkpersion").value;
	var customerType=document.getElementById("customerType").value;
	var mobilePhone=document.getElementById("mobilePhone").value;
	var cardid=document.getElementById("cardid").value;

	var qq=document.getElementById("qq").value;
	var email=document.getElementById("email").value;
	var facsimile=document.getElementById("facsimile").value;
	var customerCompany=document.getElementById("customerCompany").value;
	var dobusinesscode=document.getElementById("dobusinesscode").value;
	var companyScale=document.getElementById("companyScale").value;
	var phone=document.getElementById("phone").value;
	var customerAddress=document.getElementById("customerAddress").value;

	 if(realName==""||realName==null)
	{
		document.getElementById("realName1").innerHTML="*昵称不能为空";
		return false;
	}
	else if(mobilePhone==""||mobilePhone==null)
	{
		document.getElementById("mobilePhone1").innerHTML="*手机号不能为空";
		return false;
	}
	else if(!(/(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(mobilePhone)))
	{
		document.getElementById("mobilePhone1").innerHTML="*手机号格式不正确";
		return false;
	}
	var a=checkIdcard(cardid);
	if(a!="*身份证验证通过!")
	{
		document.getElementById("cardid1").innerHTML=a;
		return false;
	}
	else if(!/^[0-9]*$/.test(qq))
	{
		document.getElementById("qq1").innerHTML="*qq输入错误";
		return false;
	}
	else if(email==""||email==null)
	{
		document.getElementById("email1").innerHTML="*邮箱不能为空";
		return false
	}
	else if(!(/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(email)))
	{
		document.getElementById("email1").innerHTML="*邮箱格式错误";
		return false;
	}
	else if(customerCompany==""||customerCompany==null)
	{
		document.getElementById("customerCompany1").innerHTML="*公司名称不能为空";
		return false;
	}
	else if(dobusinesscode==""||dobusinesscode==null)
	{
		document.getElementById("dobusinesscode1").innerHTML="*营业执照不能为空";
		return false;
	}
	else if(companyScale==""||companyScale==null)
	{
		document.getElementById("companyScale1").innerHTML="*公司规模不能为空";
		return false;
	}
	else if(phone==""||phone==null)
	{
		document.getElementById("phone1").innerHTML="*公司电话不能为空";
		return false;
	}
	else if((/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/).test(phone)==false)
	{
		document.getElementById("phone1").innerHTML="*公司电话格式错误";
		return false;
	}
	else if(customerAddress==""||customerAddress==null)
	{
		document.getElementById("customerAddress1").innerHTML="*公司地址不能为空";
		return false;
	}
	$("#formUpdateCU").submit();

}

function checkIdcard(idcard){
var Errors=new Array(
"*身份证验证通过!",
"*身份证号码位数不对!",
"*身份证号码错误",
"*身份证号码校验错误!",
"*身份证地区非法!"
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
function uploadImage11(aaa) {
    var img1=$('#img1').val();

var tt=(new Date()).getTime();						  
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
				    url : "uploademp.do?tt="+tt,
					type : "POST",
					dataType : "script",
					success : function(msg) {
						if (msg.indexOf("#") > 0) {
							var data = msg.split("#");
							var pathi=$('#pathi').val();
							var va=pathi+data[1];
						   $('#imga1').attr('src',va);
						   $('#img1').attr('value',va);
						   $.post("litscloud/web/updateCUTXCustomerServerC.Action",{img:va},function(data123){
								   alert("修改头像成功");
								   document.getElementById("updateTX").style.display="none";
								
						   });
							
						} else {
						
						}
					}
				};
				$("#formUpdateCU").ajaxSubmit(options);
				return false;
			});
          }	
function updateTX()
{
	
	document.getElementById("updateTX").style.display="";
}