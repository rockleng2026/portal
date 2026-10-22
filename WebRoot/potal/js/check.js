

var re=/^[\u4e00-\u9fa5]{1,10}$/; //中文验证

//手机号验证
var reg0 = /^13\d{5,9}$/; 
var reg1 = /^153\d{4,8}$/; 
var reg4 = /^151\d{4,8}$/; 
var reg2 = /^159\d{4,8}$/; 
var reg3 = /^0\d{10,11}$/; 
var reg51 = /^187\d{4,8}$/; 
var reg61 = /^186\d{4,8}$/; 
var reg71 = /^158\d{4,8}$/; 
var my = false; 

var regex = /^[1-9]\d{16}(\d|x|X)$/;//身份证验证

var reg4 = /^[1-9]\d{4,8}$/;//qq验证

var reg5 = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;//邮箱验证

function CheckFormphone(phone){
	
	
}

function CheckFormwname(wname){
	
}


function CheckFormname(name){
	
	
}

var idcardzt="0";

function Checkform1(){
       

var vname = document.getElementById("vname").value;
var vphone = document.getElementById("vphone").value;
var cname = document.getElementById("cname").value;
var idcard = document.getElementById("idcard").value;
var qq = document.getElementById("qqq").value;

var email = document.getElementById("email1").value;
var address = document.getElementById("address").value;
if(email!="" && idcard!="" && address!="" && vphone!="" &&  cname!="" && vname!=""){
	if($("#cemail1").html()=="验证成功" && $("#cidcard1").html()=="验证成功"){
		$("#form2").submit();
	}
}
}
function Checkform2(){
    

	var vname = document.getElementById("vname").value;
	var vphone = document.getElementById("vphone").value;
	var cname = document.getElementById("cname").value;
	var idcard = document.getElementById("idcard").value;
	var qq = document.getElementById("qqq").value;

	var email = document.getElementById("email1").value;
	var address = document.getElementById("address").value;
	if(email!="" && idcard!="" && address!="" && vphone!="" &&  cname!="" && vname!=""){
		if($("#cemail1").html()=="验证成功" && $("#cidcard1").html()=="验证成功"){
			$("#form4").submit();
		}
	}
	}
 
function CheckForm(a){
	
var name = $("#name1").val();
var phone =$("#phone").val();
var wname =$("#wname1").val();
if(name == "" || name == null){
    $('#scname').html("");
	$('#scname').addClass("gth");
    $('#scname').append('<img src="potal/images/zhgl_v_l.png"/>客户姓名不能为空');
	return;
 }else{
	 $('#scname').html("");
		$('#scname').removeClass("gth");
	    $('#scname').html("<img src='potal/images/zhgl_v.png'>");
 }

if(phone == "" || phone == null){
	$("#cphone").html(""); 
	$('#cphone').addClass("gth");
	$("#cphone").html("<img src='potal/images/zhgl_v_l.png'>移动电话不能为空");
	return;
}else if (phone != ""){ 
	if (reg0.test(phone))my=true; 
	if (reg1.test(phone))my=true; 
	if (reg2.test(phone))my=true; 
	if (reg3.test(phone))my=true; 
	if (reg4.test(phone))my=true; 
	if (reg51.test(phone))my=true; 
	if (reg61.test(phone))my=true; 
	if (reg71.test(phone))my=true; 
	if (!my){ 
		$('#cphone').html("");
		$("#cphone").removeClass("gth");
		$("#cphone").removeClass("zqgg2");
		$("#cphone").addClass("chexx");
		$("#cphone").html("<img src='potal/images/cwxx.jpg'>请正确输入移动电话"); 
		return; 
		}else{
		$('#cphone').html("");
		$("#cphone").removeClass("gth");
		$("#cphone").addClass("zqgg2");
		$("#cphone").html("<img src='potal/images/zhgl_v.png'>"); 
		}
	}
if(wname == "" || wname == null ){
	$("#cwname").html("");
	$('#cwname').addClass("gth");
	$("#cwname").html("<img src='potal/images/zhgl_v_l.png'>公司名称不能为空");
	return;
}
else if(!re.test(wname)){
	$('#cwname').html("");
	$("#cwname").removeClass("gth");
	$("#cwname").removeClass("zqgg2");
	$("#cwname").addClass("chexx");
	$("#cwname").html("<img src='potal/images/cwxx.jpg'>请正确输入公司名称");
	return;
}else{
	$('#cwname').html("");
	$("#cwname").removeClass("gth");
	$("#cwname").addClass("zqgg2");
	$("#cwname").html("<img src='potal/images/zhgl_v.png'>");
}	
 if(a==1){
		$("#form1").submit();
 }
		}

function CheckFormTwovname(vname){
	
	
	
}
function CheckFormTwovphone(vphone){
	
	
}
function CheckFormTwocname(cname){
	
	
	
}

function CheckFormTwoidcard(idcard){
	if(idcard == "" || idcard == null){
		$('#cidcard').html("");
		$('#cidcard').addClass("gth");
		$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>身份证号不能为空");
		
		
		return;
	}
	else if(regex.test(idcard)){
		$.ajax({
	        type:'post',
	        url:'chackidcardNewportalCustomer1.do',
	        data:{custidcard:idcard},
	        success:function(res){
	     
	        	if(res=="1"){
	        		$("#cidcard1").html("");
	        		$('#cidcard').html("");
	        		$("#cidcard").removeClass("gth");
	        		$("#cidcard").addClass("zqgg2");
	        		$("#cidcard").html("<img src='potal/images/cwxx.jpg'>此身份证已被使用");
	        		idcardzt="1";	      
	        		return;
	        	}else{
	        		$('#cidcard').html("");
	        		$("#cidcard1").html();
	        		$("#cidcard").removeClass("gth");
	        		$("#cidcard").addClass("zqgg2");
	        		$("#cidcard").html("<img src='potal/images/zhgl_v.png'>");
	        		$("#cidcard1").html("验证成功");
	        		idcardzt="";
	        	}        
	        }
	  });
		
		
	}else{
		$('#cidcard').html("");
		$("#cidcard").removeClass("gth");
		$("#cidcard").removeClass("zqgg2");
		$("#cidcard").addClass("chexx");
		$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>请正确输入身份证号");
		
		return;
	}

	
	
	
}
function CheckFormTwoidcard1(idcard,a){
	if(idcard==a){
		return;
	}
	if(idcard == "" || idcard == null){
		$('#cidcard').html("");
		$('#cidcard').addClass("gth");
		$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>身份证号不能为空");
		
		
		return;
	}
	else if(regex.test(idcard)){
		$.ajax({
	        type:'post',
	        url:'chackidcardNewportalCustomer1.do',
	        data:{custidcard:idcard},
	        success:function(res){
	     
	        	if(res=="1"){
	        		$("#cidcard1").html("");
	        		$('#cidcard').html("");
	        		$("#cidcard").removeClass("gth");
	        		$("#cidcard").addClass("zqgg2");
	        		$("#cidcard").html("<img src='potal/images/cwxx.jpg'>此身份证已被使用");
	        		idcardzt="1";	      
	        		return;
	        	}else{
	        		$('#cidcard').html("");
	        		$("#cidcard1").html();
	        		$("#cidcard").removeClass("gth");
	        		$("#cidcard").addClass("zqgg2");
	        		$("#cidcard").html("<img src='potal/images/zhgl_v.png'>");
	        		$("#cidcard1").html("验证成功");
	        		idcardzt="";
	        	}        
	        }
	  });
		
		
	}else{
		$('#cidcard').html("");
		$("#cidcard").removeClass("gth");
		$("#cidcard").removeClass("zqgg2");
		$("#cidcard").addClass("chexx");
		$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>请正确输入身份证号");
		
		return;
	}

	
	
	
}
function CheckFormTwoqq(qq){
	
	
	
}
function CheckFormTwoemail(email){
	if(email == "" || email == null ){
		$("#cemail").html("");
		$('#cemail').addClass("gth");
		$("#cemail").html("<img src='potal/images/zhgl_v_l.png'>个人邮箱不能为空");
		return;
	}
	else if(reg5.test(email)){
		$.ajax({
	        type:'post',
	        url:'chackemailNewportalCustomer1.do',
	        data:{custidcard:email},
	        success:function(res){
	     
	        	if(res=="1"){
	        		$('#cemail1').html("");
	        		$('#cemail').html("");
	        		$("#cemail").removeClass("gth");
	        		$("#cemail").addClass("zqgg2");
	        		$("#cemail").html("<img src='potal/images/cwxx.jpg'>此邮箱已被使用");
	        		idcardzt="1";	      
	        		return;
	        	}else{
	        		$('#cemail1').html("");
	        		$('#cemail').html("");
	        		$("#cemail").removeClass("gth");
	        		$("#cemail").addClass("zqgg2");
	        		$("#cemail").html("<img src='potal/images/zhgl_v.png'>");
	        		$('#cemail1').html("验证成功");
	        		idcardzt="";
	        	}        
	        }
	  });
		
	}else{
		$('#cemail').html("");
		$("#cemail").removeClass("gth");
		$("#cemail").removeClass("zqgg2");
		$("#cemail").addClass("chexx");
		$("#cemail").html("<img src='potal/images/cwxx.jpg'>请正确输入个人邮箱");
		return;
		
	}	

	
	
	
}
function CheckFormTwoemail1(email,email1){
	if(email==email1){
		return;
	}
	if(email == "" || email == null ){
		$("#cemail").html("");
		$('#cemail').addClass("gth");
		$("#cemail").html("<img src='potal/images/zhgl_v_l.png'>个人邮箱不能为空");
		return;
	}
	else if(reg5.test(email)){
		$.ajax({
	        type:'post',
	        url:'chackemailNewportalCustomer1.do',
	        data:{custidcard:email},
	        success:function(res){
	     
	        	if(res=="1"){
	        		$('#cemail1').html("");
	        		$('#cemail').html("");
	        		$("#cemail").removeClass("gth");
	        		$("#cemail").addClass("zqgg2");
	        		$("#cemail").html("<img src='potal/images/cwxx.jpg'>此邮箱已被使用");
	        		idcardzt="1";	      
	        		return;
	        	}else{
	        		$('#cemail1').html("");
	        		$('#cemail').html("");
	        		$("#cemail").removeClass("gth");
	        		$("#cemail").addClass("zqgg2");
	        		$("#cemail").html("<img src='potal/images/zhgl_v.png'>");
	        		$('#cemail1').html("验证成功");
	        		idcardzt="";
	        	}        
	        }
	  });
		
	}else{
		$('#cemail').html("");
		$("#cemail").removeClass("gth");
		$("#cemail").removeClass("zqgg2");
		$("#cemail").addClass("chexx");
		$("#cemail").html("<img src='potal/images/cwxx.jpg'>请正确输入个人邮箱");
		return;
		
	}	

	
	
	
}
function CheckFormTwoaddress(address){
	
	
	
	
	
}
var bollon=true;
var bollon1=true;
			
function CheckFormTwo(x){
	var a=x;
var vname = document.getElementById("vname").value;
var vphone = document.getElementById("vphone").value;
var cname = document.getElementById("cname").value;
var idcard = document.getElementById("idcard").value;
var qq = document.getElementById("qqq").value;

var email = document.getElementById("email1").value;
var address = document.getElementById("address").value;

	
if(vname != "" && vname != null ){
	$('#cname1').html("");
	$("#cname1").removeClass("gth");
	$("#cname1").addClass("zqgg2");
	$("#cname1").html("<img src='potal/images/zhgl_v.png'>");
}	 
else{
	$("#cname1").html("");
	$('#cname1').addClass("gth");
	$("#cname1").html("<img src='potal/images/zhgl_v_l.png'>客户姓名不能为空");
	return;
	
}
if(vphone == "" || vphone == null){
	$("#cphone1").html("");
	$('#cphone1').addClass("gth");
	$("#cphone1").html("<img src='potal/images/zhgl_v_l.png'>移动电话不能为空");
	return;
}else if (vphone != ""){ 
	if (reg0.test(vphone))my=true; 
	if (reg1.test(vphone))my=true; 
	if (reg2.test(vphone))my=true; 
	if (reg3.test(vphone))my=true; 
	if (reg4.test(vphone))my=true; 
	if (reg51.test(vphone))my=true; 
	if (reg61.test(vphone))my=true; 
	if (reg71.test(vphone))my=true; 
	if (!my){ 
		$('#cphone1').html("");
		$("#cphone1").removeClass("gth");
		$("#cphone1").removeClass("zqgg2");
		$("#cphone1").addClass("chexx");
		$("#cphone1").html("<img src='potal/images/zhgl_v_l.png'>请正确输入移动电话"); 
		return; 
		}else{
		$('#cphone1').html("");
		$("#cphone1").removeClass("gth");
		$("#cphone1").addClass("zqgg2");
		$("#cphone1").html("<img src='potal/images/zhgl_v.png'>"); 
		}
	}

if(idcard == "" || idcard == null){
	$('#cidcard').html("");
	$('#cidcard').addClass("gth");
	$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>身份证号不能为空");
	
	
	return;
}



if(qq == "" || qq == null ){
	$("#cqq").html("");
	$('#cqq').addClass("gth");
	$("#cqq").html("<img src='potal/images/zhgl_v_l.png'>qq号码不能为空");
	return;
}
else if(reg4.test(qq)){
	$('#cqq').html("");
	$("#cqq").removeClass("gth");
	$("#cqq").addClass("zqgg2");
	$("#cqq").html("<img src='potal/images/zhgl_v.png'>");
}else{
	$('#cqq').html("");
	$("#cqq").removeClass("gth");
	$("#cqq").removeClass("zqgg2");
	$("#cqq").addClass("chexx");
	$("#cqq").html("<img src='potal/images/cwxx.jpg'>请正确输入qq号码");
	return;
	
}

if(email == "" || email == null ){
	$("#cemail").html("");
	$('#cemail').addClass("gth");
	$("#cemail").html("<img src='potal/images/zhgl_v_l.png'>个人邮箱不能为空");
	return;
}
if(cname == "" || cname == null ){
	$("#ccname").html("");
	$('#ccname').addClass("gth");
	$("#ccname").html("<img src='potal/images/zhgl_v_l.png'>公司名称不能为空");
	return;
}
else if(!re.test(cname)){
	$('#ccname').html("");
	$("#ccname").removeClass("gth");
	$("#ccname").removeClass("zqgg2");
	$("#ccname").addClass("chexx");
	$("#ccname").html("<img src='potal/images/cwxx.jpg'>请正确输入公司名称");
	return;
}else{
	$('#ccname').html("");
	$("#ccname").removeClass("gth");
	$("#ccname").addClass("zqgg2");
	$("#ccname").html("<img src='potal/images/zhgl_v.png'>");
}


if(address == "" || address == null ){
	$("#caddress").html("");
	$('#caddress').addClass("gth");
	$("#caddress").html("<img src='potal/images/zhgl_v_l.png'>公司地址不能为空");
	return;
}else{
	$('#caddress').html("");
	$("#caddress").removeClass("gth");
	$("#caddress").addClass("zqgg2");
	$("#caddress").html("<img src='potal/images/zhgl_v.png'>");
	
}
	
	}
function CheckFormTwo1(x){
	var a=x;
var vname = document.getElementById("vname").value;
var vphone = document.getElementById("vphone").value;
var cname = document.getElementById("cname").value;
var idcard = document.getElementById("idcard").value;
var qq = document.getElementById("qqq").value;

var email = document.getElementById("email1").value;
var address = document.getElementById("address").value;

	
if(vname != "" && vname != null ){
	$('#cname1').html("");
	$("#cname1").removeClass("gth");
	$("#cname1").addClass("zqgg2");
	$("#cname1").html("<img src='potal/images/zhgl_v.png'>");
}	 
else{
	$("#cname1").html("");
	$('#cname1').addClass("gth");
	$("#cname1").html("<img src='potal/images/zhgl_v_l.png'>客户姓名不能为空");
	return;
	
}
if(vphone == "" || vphone == null){
	$("#cphone1").html("");
	$('#cphone1').addClass("gth");
	$("#cphone1").html("<img src='potal/images/zhgl_v_l.png'>移动电话不能为空");
	return;
}else if (vphone != ""){ 
	if (reg0.test(vphone))my=true; 
	if (reg1.test(vphone))my=true; 
	if (reg2.test(vphone))my=true; 
	if (reg3.test(vphone))my=true; 
	if (reg4.test(vphone))my=true; 
	if (reg51.test(vphone))my=true; 
	if (reg61.test(vphone))my=true; 
	if (reg71.test(vphone))my=true; 
	if (!my){ 
		$('#cphone1').html("");
		$("#cphone1").removeClass("gth");
		$("#cphone1").removeClass("zqgg2");
		$("#cphone1").addClass("chexx");
		$("#cphone1").html("<img src='potal/images/zhgl_v_l.jpg'>请正确输入移动电话"); 
		return; 
		}else{
		$('#cphone1').html("");
		$("#cphone1").removeClass("gth");
		$("#cphone1").addClass("zqgg2");
		$("#cphone1").html("<img src='potal/images/zhgl_v.png'>"); 
		}
	}


if(idcard == "" || idcard == null){
	$('#cidcard').html("");
	$('#cidcard').addClass("gth");
	$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>身份证号不能为空");
	
	
	return;
}
else if(regex.test(idcard)){

		
	        
	        
}else{
	$('#cidcard').html("");
	$("#cidcard").removeClass("gth");
	$("#cidcard").removeClass("zqgg2");
	$("#cidcard").addClass("chexx");
	$("#cidcard").html("<img src='potal/images/zhgl_v_l.png'>请正确输入身份证号");
	
	return;
}


if(qq == "" || qq == null ){
	$("#cqq").html("");
	$('#cqq').addClass("gth");
	$("#cqq").html("<img src='potal/images/zhgl_v_l.png'>qq号码不能为空");
	return;
}
else if(reg4.test(qq)){
	$('#cqq').html("");
	$("#cqq").removeClass("gth");
	$("#cqq").addClass("zqgg2");
	$("#cqq").html("<img src='potal/images/zhgl_v.png'>");
}else{
	$('#cqq').html("");
	$("#cqq").removeClass("gth");
	$("#cqq").removeClass("zqgg2");
	$("#cqq").addClass("chexx");
	$("#cqq").html("<img src='potal/images/cwxx.jpg'>请正确输入qq号码");
	return;
	
}
if(email == "" || email == null ){
	$("#cemail").html("");
	$('#cemail').addClass("gth");
	$("#cemail").html("<img src='potal/images/zhgl_v_l.png'>个人邮箱不能为空");
	return;
}
else if(reg5.test(email)){

	
}else{
	$('#cemail').html("");
	$("#cemail").removeClass("gth");
	$("#cemail").removeClass("zqgg2");
	$("#cemail").addClass("chexx");
	$("#cemail").html("<img src='potal/images/cwxx.jpg'>请正确输入个人邮箱");
	return;
	
}	

if(cname == "" || cname == null ){
	$("#ccname").html("");
	$('#ccname').addClass("gth");
	$("#ccname").html("<img src='potal/images/zhgl_v_l.png'>公司名称不能为空");
	return;
}
else if(!re.test(cname)){
	$('#ccname').html("");
	$("#ccname").removeClass("gth");
	$("#ccname").removeClass("zqgg2");
	$("#ccname").addClass("chexx");
	$("#ccname").html("<img src='potal/images/cwxx.jpg'>请正确输入公司名称");
	return;
}else{
	$('#ccname').html("");
	$("#ccname").removeClass("gth");
	$("#ccname").addClass("zqgg2");
	$("#ccname").html("<img src='potal/images/zhgl_v.png'>");
}


if(address == "" || address == null ){
	$("#caddress").html("");
	$('#caddress').addClass("gth");
	$("#caddress").html("<img src='potal/images/zhgl_v_l.png'>公司地址不能为空");
	return;
}else{
	$('#caddress').html("");
	$("#caddress").removeClass("gth");
	$("#caddress").addClass("zqgg2");
	$("#caddress").html("<img src='potal/images/zhgl_v.png'>");
	
}
	
	if(a==1){
		
	
		
$("#form4").submit();
		
	
		
	}
		
		}