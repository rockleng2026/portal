
var flag=false;

//添加时验证
function addValidators()
{
	flag = window.confirm("是否确认提交？");
	var mark = $("#is").val();
	if(mark=='1'){
		return false;
	}	
	if(!flag){
		return false;
		
	}
	var reqired = $("input");
	for(var i = 0;i<reqired.length;i++){
		if(reqired[i].id != null && reqired[i].id != "" && reqired[i].id != "pageValidateCode" && reqired[i].type == "text"){
			$("#"+reqired[i].id).trigger("blur");
			if(!flag){
				$("#"+reqired[i].id).focus();
				return false;
			}
		}
	}
	
	var reqired1 = $("select");
	for(var i = 0;i<reqired1.length;i++){
		if(reqired1[i].id != null && reqired1[i].id != "" && reqired1[i].id != "pageValidateCode" && reqired1[i].type == "select-one"){
			$("#"+reqired1[i].id).trigger("blur");
			if(!flag){
				$("#"+reqired1[i].id).focus();
				return false;
			}
		}
	}
	
	return true;
}
function addValidators2(formid)
{
	
	//alert(formid);
	flag = window.confirm("是否确认提交？");
	var mark = $("#is").val();
	if(mark=='1'){
		return false;
	}	
	if(!flag){
		return false;
		
	}
	//var reqired = $("input");
	
	var reqired = $("#"+formid+"  :input");
	//alert(reqired.length);
	for(var i = 0;i<reqired.length;i++){
		if(reqired[i].id != null && reqired[i].id != "" && reqired[i].id != "pageValidateCode" && (reqired[i].type == "text"  || reqired[i].type == "select-one" )){
			//alert(reqired[i].id);
			$("#"+reqired[i].id).trigger("blur");
			//alert(reqired[i].id+"--"+flag);
			if(!flag){
				$("#"+reqired[i].id).focus();
				return false;
			}
		}
	}
	return true;
}







//验证
function checkValueByRules(objOrId,rules,msg){
	
	//正则表达式
	var reg = new Object();
	reg["phone"] = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;//手机号
	reg["tel"] = /(\d{3}-)?\d{8}|(\d{4}-)(\d{7})/g;//电话
	reg["cardno"] = /\d{17}[\d|x|X]|\d{15}/g;//身份证卡
	reg["cn"] =   /[^\x00-\xff]+/g;//匹配中文
	reg["en_num"] = /[\w]/g;//匹配英文和数字
	reg["num"] = /^\d+$/g;//匹配数字
	//reg["zip"] = /^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/; //邮编
	reg["zip"] = /^[1-9][0-9]{5}$/;//邮编
	reg["money"] = reg["float"] = /^-?\d*\.?\d+$/; //货币、浮点型    
	reg["email"] = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;  ///^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/  QQ邮箱验证不了，已经修改好了
	reg["birth"] = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
	reg["password"] = /^[a-zA-Z-0-9]{1}[a-zA-Z0-9_\$\.]{5,15}$/;
	reg["depNum"] =/^(\d{3})$/;   //匹配只有三位数字
	reg["bandcard"]=/^(\d{19})|(\d{16})$/g;    //匹配银行卡号
	
	//提示语			
	
	var regMsg = new Object();
	regMsg["phone"] = "您输入的手机或电话有误，请重新输入！";
	regMsg["tel"] = "您输入的电话号码有误，请重新输入！";
	regMsg["cardno"] = "您输入的身份证号码有误，请重新输入！";
	regMsg["cn"] = "您输入的非汉字，请重新输入！";
	regMsg["en_num"] = "您输入的非英语或数字，请重新输入！";
	regMsg["num"] = "请输入整数";
	regMsg["zip"] = "您输入的邮编不正确，请重新输入！";
	regMsg["float"] = "您输入的数字数据有误，请重新输入！";
	regMsg["money"] = "您输入的货币格式数据有误，请重新输入！";
	regMsg["email"] = "您输入的电子邮箱有误，请重新输入！";
	regMsg["birth"] = "您输入的日期格式有误，请重新输入！";
	regMsg["password"] = "必须是6-16位的数字、字母以及$_小数点组成";
	regMsg["depNum"]="您输入的部门编号格式有误（例：140、130），请重新输入！";
	regMsg["bandcard"] = "您输入的银行卡账号有误，请重新输入！";
	regMsg["gatheringName"] ="你输入的收款名称有误!";
	regMsg["bankName"] = "你输入的开户行有误";
	regMsg["payerName"] = "你输入的付款人有误";
	
	
	var msgs=$("#"+msg);
	//alert(msgs);
	var obj = null;//声明对象句柄
	var isObj = false;
	if(typeof(objOrId) == "string" )	{
		obj = $("#"+objOrId);
	}else if(typeof(objOrId) == "object"){
		obj = $(objOrId);
		isObj = true;
	}
	
	if(obj != null ){
		var value = obj.val();//获取输入框的值
		//alert(value);
		if(value == null || value == "" ){//判断是否空值
			if(!isObj){
				msgs.html("该项不能为空！");
				flag = false;
				return false;//若空值则返回
			}else{
				msgs.html("");
				flag=true;
			}
		} else if(rules != null && typeof(rules) == "object" && rules.length > 0 ){//验证规则
			for( var j=0;j<rules.length;j++ ){
				if( reg[rules[j]] == null || reg[rules[j]] == "" ){	break;}
				
				if( !reg[rules[j]].test($.trim(value)) ){//判断是否不匹配
				    //alert(rules[j]+"--"+reg[rules[j]]);
					if(rules[j]=="phone" && reg['tel'].test(value)){
						break;
					}
					msgs.html(regMsg[rules[j]]);
					flag = false;
					break;
				}else {
					msgs.html("");
					flag = true;
				}
			}
		} else {
			msgs.html("");
			flag = true;
		}
	}
	
	if(rules.toString().indexOf(".do") != -1 && rules !='' && rules != null)
	{
		var name = $("#"+objOrId).val();
		//alert("name"+name);
		
		var url = rules;
		//alert(url);
		//alert(name);
//		name = encodeURIComponent(name)
		name = encodeURI(encodeURI(name));
		//alert(name);
		 var method = 'POST';
		 
		$.ajax({
          type: method,
          async:false,
          url: url,
          data: "name="+name,
          //data: "name="+name,
          success: function(date) {
            if(date == "1")
			{
				msgs.html("<font color='#F73809'>该项已经存在</font>");
				$("#is").val("1");
				flag = true;
				$("#"+objOrId).focus();
			}else if(date == 2){
				msgs.html("<font color='#F73809'>输入不合法</font>");
				$("#is").val("1");
				flag = true;
				$("#"+objOrId).focus();
			}else{
				msgs.html("<font color='#1AE61A'>该项可以添加</font>");
			}
      }
       });
		//$.post(url,{name:encodeURIComponent(name)},
		//		function(date){
		//	if(date == 1)
		//	{
		//		msgs.html("名称已经存在");
		//		$("#is").val("1");
		//		flag = true;
		//		$("#"+objOrId).focus();
		//	}
		//		}
		//		);
	}
	
}
//验证
function checkValueByRules2(objOrId,rules,msg){
	
	//正则表达式
	var reg = new Object();
	reg["phone"] = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;//手机号
	reg["tel"] = /(\d{3}-)?\d{8}|(\d{4}-)(\d{7})/g;//电话
	reg["cardno"] = /\d{17}[\d|x|X]|\d{15}/g;//身份证卡
	reg["cn"] =   /[^\x00-\xff]+/g;//匹配中文
	reg["en_num"] = /[\w]/g;//匹配英文和数字
	reg["num"] = /^\d+$/g;//匹配数字
	reg["zip"] = /^[1-9]\d{5}$/; //邮编
	reg["money"] = reg["float"] = /^-?\d*\.?\d+$/; //货币、浮点型    
	reg["email"] = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;  ///^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/  QQ邮箱验证不了，已经修改好了
	reg["birth"] = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
	reg["password"] = /^[a-zA-Z-0-9]{1}[a-zA-Z0-9_\$\.]{5,15}$/;
	reg["depNum"] =/^(\d{3})$/;   //匹配只有三位数字
	reg["bandcard"]=/^(\d{19})|(\d{16})$/g;    //匹配银行卡号
	
	//提示语			
	
	var regMsg = new Object();
	regMsg["phone"] = "您输入的手机或电话有误，请重新输入！";
	regMsg["tel"] = "您输入的电话号码有误，请重新输入！";
	regMsg["cardno"] = "您输入的身份证号码有误，请重新输入！";
	regMsg["cn"] = "您输入的非汉字，请重新输入！";
	regMsg["en_num"] = "您输入的非英语或数字，请重新输入！";
	regMsg["num"] = "请输入整数";
	regMsg["zip"] = "您输入的邮编不正确，请重新输入！";
	regMsg["float"] = "您输入的数字数据有误，请重新输入！";
	regMsg["money"] = "您输入的货币格式数据有误，请重新输入！";
	regMsg["email"] = "您输入的电子邮箱有误，请重新输入！";
	regMsg["birth"] = "您输入的日期格式有误，请重新输入！";
	regMsg["password"] = "必须是6-16位的数字、字母以及$_小数点组成";
	regMsg["depNum"]="您输入的部门编号格式有误（例：140、130），请重新输入！";
	regMsg["bandcard"] = "您输入的银行卡账号有误，请重新输入！";
	
	var msgs=$("#"+msg);
	//alert(msgs);
	var obj = null;//声明对象句柄
	var isObj = false;
	if(typeof(objOrId) == "string" )	{
		obj = $("#"+objOrId);
	}else if(typeof(objOrId) == "object"){
		obj = $(objOrId);
		isObj = true;
	}
	
	if(obj != null ){
		var value = obj.val();//获取输入框的值
		if(value == null || value == "" ){//判断是否空值
			if(!isObj){
				msgs.html("该项不能为空！");
				flag = false;
				return false;//若空值则返回
			}else{
				msgs.html("");
				flag=true;
			}
		} else if(rules != null && typeof(rules) == "object" && rules.length > 0 ){//验证规则
			for( var j=0;j<rules.length;j++ ){
				if( reg[rules[j]] == null || reg[rules[j]] == "" ){	break;}
				if( !reg[rules[j]].test($.trim(value)) ){//判断是否不匹配
					if(rules[j]=="phone" && reg['tel'].test(value)){
						break;
					}
					msgs.html(regMsg[rules[j]]);
					flag = false;
					break;
				}else {
					msgs.html("");
					flag = true;
				}
			}
		} else {
			msgs.html("");
			flag = true;
		}
	}
	
	if(rules.toString().indexOf(".do") != -1 && rules !='' && rules != null)
	{
		var name = $("#"+objOrId).val();
		//alert("name"+name);
		
		var url = rules;
		//alert(url);
		//alert(name);
//		name = encodeURIComponent(name)
		name = encodeURI(encodeURI(name));
		//alert(name);
		 var method = 'POST';
		 
		$.ajax({
          type: method,
          async:false,
          url: url,
          data: "name="+name,
          //data: "name="+name,
          success: function(date) {
            if(date == "1")
			{
				msgs.html("<font color='#F73809'>该项已经存在</font>");
				$("#is").val("1");
				flag = false;
				$("#"+objOrId).focus();
			}else if(date == 2){
				msgs.html("<font color='#F73809'>输入不合法</font>");
				$("#is").val("1");
				flag = false;
				$("#"+objOrId).focus();
			}else{
				msgs.html("<font color='#1AE61A'>该项可以添加</font>");
				flag = true;
			}
      }
       });
		//$.post(url,{name:encodeURIComponent(name)},
		//		function(date){
		//	if(date == 1)
		//	{
		//		msgs.html("名称已经存在");
		//		$("#is").val("1");
		//		flag = true;
		//		$("#"+objOrId).focus();
		//	}
		//		}
		//		);
	}
	
	
}
function checkValueByRules3(objOrId,rules){
	
	//正则表达式
	var reg = new Object();
	reg["phone"] = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;//手机号
	reg["tel"] = /(\d{3}-)?\d{8}|(\d{4}-)(\d{7})/g;//电话
	reg["cardno"] = /\d{17}[\d|x|X]|\d{15}/g;//身份证卡
	reg["cn"] =   /[^\x00-\xff]+/g;//匹配中文
	reg["en_num"] = /[\w]/g;//匹配英文和数字
	reg["num"] = /^\d+$/g;//匹配数字
	reg["zip"] = /^[1-9]\d{5}$/; //邮编
	reg["money"] = reg["float"] = /^-?\d*\.?\d+$/; //货币、浮点型    
	reg["email"] = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;  ///^[a-z]([a-z0-9])+@([a-z0-9])+[\.][a-z]{2,3}$/  QQ邮箱验证不了，已经修改好了
	reg["birth"] = /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
	reg["password"] = /^[a-zA-Z-0-9]{1}[a-zA-Z0-9_\$\.]{5,15}$/;
	reg["depNum"] =/^(\d{3})$/;   //匹配只有三位数字
	reg["bandcard"]=/^(\d{19})|(\d{16})$/g;    //匹配银行卡号
	
	//提示语			
	
	var regMsg = new Object();
	regMsg["phone"] = "您输入的手机或电话有误，请重新输入！";
	regMsg["tel"] = "您输入的电话号码有误，请重新输入！";
	regMsg["cardno"] = "您输入的身份证号码有误，请重新输入！";
	regMsg["cn"] = "您输入的非汉字，请重新输入！";
	regMsg["en_num"] = "您输入的非英语或数字，请重新输入！";
	regMsg["num"] = "请输入整数";
	regMsg["zip"] = "您输入的邮编不正确，请重新输入！";
	regMsg["float"] = "您输入的数字数据有误，请重新输入！";
	regMsg["money"] = "您输入的货币格式数据有误，请重新输入！";
	regMsg["email"] = "您输入的电子邮箱有误，请重新输入！";
	regMsg["birth"] = "您输入的日期格式有误，请重新输入！";
	regMsg["password"] = "必须是6-16位的数字、字母以及$_小数点组成";
	regMsg["depNum"]="您输入的部门编号格式有误（例：140、130），请重新输入！";
	regMsg["bandcard"] = "您输入的银行卡账号有误，请重新输入！";
	

	//alert(msgs);
	var obj = null;//声明对象句柄
	var isObj = false;
	if(typeof(objOrId) == "string" )	{
		obj = $("#"+objOrId);
	}else if(typeof(objOrId) == "object"){
		obj = $(objOrId);
		isObj = true;
	}
	
	if(obj != null ){
		var value = obj.val();//获取输入框的值
		if(value == null || value == "" ){//判断是否空值
			if(!isObj){
				alert("该项不能为空！");
				flag = false;
				return false;//若空值则返回
			}else{
				
				flag=true;
			}
		} else if(rules != null && typeof(rules) == "object" && rules.length > 0 ){//验证规则
			for( var j=0;j<rules.length;j++ ){
				if( reg[rules[j]] == null || reg[rules[j]] == "" ){	break;}
				if( !reg[rules[j]].test($.trim(value)) ){//判断是否不匹配
					if(rules[j]=="phone" && reg['tel'].test(value)){
						break;
					}
					alert(regMsg[rules[j]]);
					flag = false;
					break;
				}else {
					
					flag = true;
				}
			}
		} else {
			
			flag = true;
		}
	}
	
	if(rules.toString().indexOf(".do") != -1 && rules !='' && rules != null)
	{
		var name = $("#"+objOrId).val();
		//alert("name"+name);
		
		var url = rules;
		//alert(url);
		//alert(name);
//		name = encodeURIComponent(name)
		name = encodeURI(encodeURI(name));
		//alert(name);
		 var method = 'POST';
		 
		$.ajax({
          type: method,
          async:false,
          url: url,
          data: "name="+name,
          //data: "name="+name,
          success: function(date) {
            if(date == "1")
			{
				alert("<font color='#F73809'>该项已经存在</font>");
				
				flag = false;
				$("#"+objOrId).focus();
			}else if(date == 2){
				alert("<font color='#F73809'>输入不合法</font>");
				
				flag = false;
				$("#"+objOrId).focus();
			}else{
				alert("<font color='#1AE61A'>该项可以添加</font>");
				flag = true;
			}
      }
       });
		//$.post(url,{name:encodeURIComponent(name)},
		//		function(date){
		//	if(date == 1)
		//	{
		//		msgs.html("名称已经存在");
		//		$("#is").val("1");
		//		flag = true;
		//		$("#"+objOrId).focus();
		//	}
		//		}
		//		);
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
function checkToOrder()
{
	if(!addValidators())
	{
		return false;
	}
	
	var model = document.getElementsByName("model");
	var modelArray = new Array();
	
	for(var i=0;i<model.length;i++)
	{
		modelArray[i] = model[i].value;
	}
	
	if(modelArray.length>0)
	{
		for(var j=0;j<modelArray.length;j++)
		{
			if(modelArray[j]=="")
			{
				alert("请选择订单中的商品！");
				return false;
			}
		}
	}
	else
	{
		return true;
	}
}




//客户姓名验证
var flag1=false;
function checkcustomerName(){
$('#customerName1').html("");  
var  num=/^[a-zA-Z ]{1,20}$/;
var num1=/^[\u4e00-\u9fa5]{1,10}$/; 
var sname=1;
	var mobile=$("#realName").val(); 
	if(!mobile){
		flag1=false;
	$('#customerName1').html("姓名不能为空");return;
	}
	if(!num1.test(mobile)&&!num.test(mobile)){
		flag1=false;
	$('#customerName1').html("不能包含非法字符和数字，中文名在10位以内，英文名在20位以内");return;
	}else{
	//格式正确 检查是否存在用户名
	
		$.post("checkNameCustomer.do",{"customerName":mobile,"sname":sname},function(data){
			if(data){
				$('#customerName1').html("<span style='color: blue;'>您输入的用户名可以使用</span>");
				flag1=true;
			}else{
				$('#customerName1').html("用户名被占用");
				flag1=false;
			}
		},"json");
	}	
}
//客户手机失去交点事件 
var flag2=false;
function blurPhone(){
$('#mobilePhone1').html("");  
var  num=/^1[3|4|5|8][0-9]\d{4,8}$/;
	var mobile=$("#mobilePhone").val(); 
	if(!mobile){
		flag2=false;
	$('#mobilePhone1').html("手机号码不能为空");return;
	}
	if(!num.test(mobile)){
		flag2=false;
	$('#mobilePhone1').html("手机号码格式不正确");return;
	}else{
		$('#mobilePhone1').html("<span style='color: blue;'>输入的手机号正确</span>");
		flag2=true;
	}	
}

//验证邮箱
var flag3=false;
function checkemail(){
$('#email1').html("");  
var sname=3
var  num=/\b(^['_A-Za-z0-9-]+(\.['_A-Za-z0-9-]+)*@([A-Za-z0-9-])+(\.[A-Za-z0-9-]+)*((\.[A-Za-z0-9]{2,})|(\.[A-Za-z0-9]{2,}\.[A-Za-z0-9]{2,}))$)\b/;
	var mobile=$("#email").val(); 
	if(!mobile){
		flag3=false;
	$('#email1').html("邮箱不能为空");return;
	}
	if(!num.test(mobile)){
		flag3=false;
	$('#email1').html("邮箱格式不正确");return;
	}else{
		$.post("checkNameCustomer.do",{"customerName":mobile,"sname":sname},function(data){
			if(data){
				$('#email1').html("<span style='color: blue;'>邮箱可以使用</span>");
				flag3=true;
			}else{
				flag3=false;
				$('#email1').html("邮箱被占用");
			}
		},"json");
	}	
}

//邮编验证
var flag4=false;
function checkZipCode(){
    $('#zipCode1').html("");  
    
    var  num=/^[1-9][0-9]{5}$/;

	var mobile=$("#zipCode").val(); 
	if(!mobile){
		flag4=false;
	$('#zipCode1').html("邮编不能为空");return;
	}
	if(!num.test(mobile)){
		flag4=false;
	$('#zipCode1').html("邮编格式不正确");return;
	}else{
		$('#zipCode1').html("<span style='color: blue;'>邮编格式正确</span>");
		flag4=true;
	}	
}





//检查身份证  email
var flag4=false;
function checkCards(){
  var num1=/^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\d{3}(x|X))|(\d{4}))$/;
 var sname=2;
$('#cardid3').html("");
 var txt= $('#cardid').val();
  if(txt==""||txt==null){
	  flag4=false;
  $('#cardid3').html("身份证号码不能为空");
 return;
  }else if(!num1.test(txt)){
  $('#cardid3').html("你输入的格式不正确");
  flag4=false;
    return;
 }else{
	 $.post("checkNameCustomer.do",{"customerName":txt,"sname":sname},function(data){
			if(data){
				$('#cardid3').html("<span style='color: blue;'>身份证号码可以使用</span>");
				flag4=true;
			}else{
				flag4=false;
				$('#cardid3').html("身份证被占用");
			}
		},"json");
    
 }
}

function checkCards1(){
	  var num1=/^((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\d{3}(x|X))|(\d{4}))$/;
	 var sname=2;
	
	 var txt= $('#shenFenZhengHaoMa').val();
	  if(txt==""||txt==null){
		  flag4=false;
	  alert("身份证号码不能为空");
	 return;
	  }else if(!num1.test(txt)){
	  alert("你输入的格式不正确");
	  flag4=false;
	    return;
	 }else{
		 $.post("checkNameemp.do",{"empname":txt,"sname":sname},function(data){
				if(data){
					alert("<span style='color: blue;'>身份证号码可以使用</span>");
					flag4=true;
				}else{
					flag4=false;
					alert("身份证被占用");
				}
			},"json");
	    
	 }
	}

//var flag5=false;
function checkfirm(){

	var valu=$('#customerCompany').val();
	if(valu==""||valu==null){
		//flag5=false;
		$('#customerCompany').attr('value',"暂无");		
	}else{
		//flag5=true;
	}
	
}

function checkaddres(){
	//$('#customerAddress').attr('value',"");
	var valu=$('#customerAddress').val();
	if(valu==""||valu==null){
		//flag=false;
		$('#customerAddress').attr('value',"暂无");		
	}else{
		//flag=true;
	}
	
}
//deptSelect  select
var flag5 =false;
function  checkdep(){
	  if($("#deptSelect").val()==""){
		  $('#deptSelect1').html("该项还未选择"); 
	  }else{
		  flag5=true;
		  $('#deptSelect1').html("<span style='color: blue;'>已选择</span>"); 
	  }
	
	
}
var regex = /^[1-9]\d{16}(\d|x|X)$/;//身份证验证



var reg5 = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;//邮箱验证

function CheckFormTwoidcard(idcard){
	if(idcard == "" || idcard == null){
		alert("身份证号不能为空");
		
		
		return;
	}
	else if(regex.test(idcard)){
		$.ajax({
	        type:'post',
	        url:'checkNameemp.do',
	        data:{empname:idcard},
	        success:function(res){
	     
	        	if(res=="1"){
	        		alert("此身份证已被使用");
	        		$("#sfj").val(0);
	        		return;
	        	}else{
	        		$("#sfj").val(1);
	        	}        
	        }
	  });
		
		
	}else{
		alert("请正确输入身份证号");
		$("#sfj").val(0);
		return;
	}

	
	
	
}
function CheckFormTwoempno(idcard){
	alert(idcard);
	if(idcard == "" || idcard == null){
		alert("员工号不能为空");
		
		
		return;
	}
	else {
		$.ajax({
	        type:'post',
	        url:'checkEmpnoemp.do',
	        data:{empname:idcard},
	        success:function(res){
	     
	        	if(res=="1"){
	        		alert("员工号已被使用");
	        		      
	        		return;
	        	}else{
	        		$("#ygh").val(1);
	        	}        
	        }
	  });
		
		
	}

	
	
	
}


function CheckFormTwoemail(email){
	if(email == "" || email == null ){
		alert("个人邮箱不能为空");
		return;
	}
	else if(reg5.test(email)){
		$.ajax({
	        type:'post',
	        url:'checkName1emp.do',
	        data:{empname:email},
	        success:function(res){
	     
	        	if(res=="1"){
	        		alert("此邮箱已被使用");
	        		$("#yxdz").val(0);
	        		return;
	        	}else{
	        		$("#yxdz").val(1);
	        	}        
	        }
	  });
		
	}else{
		alert("请正确输入个人邮箱");
		$("#yxdz").val(0);
		return;
		
	}	

	
	
	
}
function  checkempno(a,b){
	if(a!=b){
		
		
		CheckFormTwoempno(b);
		
	}
	
	
	
}
function checkemail(a,b){
if(a!=b){
		
		
	CheckFormTwoemail(b);
		
	}
	
}
function checkeidcard(a,b){
	if(a!=b){
			
			
		 CheckFormTwoidcard(b);
			
		}
		
	}


function addValidators1(){
  if($("#realName").val()==""){
	  $('#customerName1').html("姓名不能为空"); 
  };
  
  if($("#deptSelect").val()==""){
	  $('#deptSelect1').html("该项还未选择"); 
  }
  
  
  if($("#mobilePhone").val()==""){
	  $('#mobilePhone1').html("手机号码不能为空");
  };
  if($("#email").val()==""){
	  $('#email1').html("邮箱不能为空");
  };
  if($("#zipCode").val()==""){
	  $('#zipCode1').html("邮编不能为空");
  };
  if($('#cardid').val()==""){
	  $('#cardid3').html("身份证号码不能为空");
  };
  if($('#customerCompany').val()==""){
	  $('#customerCompany').attr('value',"暂无");
  };
  if($('#customerAddress').val()==""){
	  $('#customerAddress').attr('value',"暂无");
  }
	
	return   flag1 &&  flag2 && flag3 && flag4 && flag5;
 flag = window.confirm("是否确认提交？");
}