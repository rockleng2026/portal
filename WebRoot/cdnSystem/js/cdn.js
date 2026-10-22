// JavaScript Document
$(function(){
	$("[name=del]").click(function(){
		$(this).parent().parent().remove();	
	});	
});

  //全选
		function checkAll(){
		
			$("#inputselect input:checkbox").attr("checked","checked");
		}
		
		//反选
		function inverseSelection(){
			$("#inputselect input:checkbox").removeAttr("checked");	
		}
		

	//验证 电话 手机号 身份证卡 货币、浮点 邮编 银行卡 密码 日期格式  身高 非汉字
 	function check(objStr,rules,msg)
	{
		//正则表达式
		var reg = new Object();
		reg["phone"] = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/g;  //手机号
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
		reg["age"] = /^$/;
	    reg["QQ"] = /^[1-9]\d{4,10}$/;
		reg["chuanzhen"] =/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
		
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
		regMsg["QQ"] = "QQ号码输入错误,请重新输入!";
		regMsg["chuanzhen"] = "传真输入有误！";
		
		
		if($("#"+objStr).val()=="")
		{
			
			if($("#"+objStr).next().html()=="*")
			{
				alert("此项不能为空！");	
				$("#"+objStr).focus();
			}
			
		}
		else if(rules != null && typeof(rules) == "object" && rules.length > 0 )
		{//验证规则
				for( var j=0;j<rules.length;j++ ){
					if( reg[rules[j]] == null || reg[rules[j]] == "" ){	break;}
					if( !reg[rules[j]].test($.trim($("#"+objStr).val())) ){//判断是否不匹配
						if(rules[j]=="phone" && reg['tel'].test($("#"+objStr).val())){
							break;
						}
						//msgs.html(regMsg[rules[j]]);
						alert(regMsg[rules[j]]);
						$("#"+objStr).focus();
						flag = false;
						break;
					}else {
						msgs.html("");
						flag = true;
					}
				}
			} 	
	}
	
	
	function query(obj)
	{
			var num1=/^[\u4e00-\u9fa5]+$/;  //这里进行中文的个数{1,10}
			var  num=/^[a-zA-Z ]+$/;  //这里进行英文的个数{1,20}
			//var reg  = /^\d+$/g;//匹配数字
			//alert('英文名在20位以内'+num.test(mobile)+'    中文名在10位以内'+num1.test(mobile));
			if($("#"+obj).val()=="")
			{
				alert("不能为空！");
				$("#"+obj).focus();
				return;
			}
			else if(!num1.test($("#"+obj).val())&&!num.test($("#"+obj).val()))
			{
		
			 	alert("不能包含非法字符和数字.");
				$("#"+obj).focus();
				 return;
			}
		}