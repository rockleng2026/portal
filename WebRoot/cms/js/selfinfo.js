$(document).ready(function(){  
	 $('#w').window({
	       closed: true
	   });

	 $('#up').window({
	       closed: true
	   });

	 $('#rolit').window({
		   closed: true 
	 });
	});
function update(id,name,email,deptid,deptname){
	  resize();
	  $('#subs').val("修改信息");
	  $('#username').attr('value',name);
      $('#email').attr('value',email);
      $('#userid').attr('value',id);
      $("#depts").html("<option value='"+deptid+"' selected>"+deptname+"</option>");
}
function updatePwd(id,deptid){
	  resizePwd();
	  $('#subsPwd').val("提交");
	  
	  $('#useridPwd').attr('value',id);
	  $('#deptidPwd').attr('value',deptid); 
}
function checkformPwd()
{
	var newpwd=$("#newpwd1").val();
	if(newpwd==''||newpwd==null){
		$("#newpwdtest1").html("新密码不能为空。。。");
		return;
	}
	
	var isok = $("#isok").val();
	//alert(isok);
	if( isok == 1){
		$("#oldpwdtest").html("原密码错误！");
		return;
	}
	$("#newpwdtest1").html("");
	if(newpwd.length<6){
		$("#newpwdtest1").html("新密码长度不能小于6。。。");
		return;
	}
	$("#newpwdtest1").html("");
	
	var newpwd2=$("#newpwd2").val();
	if(newpwd2!=newpwd){
		$("#newpwdtest2").html("确认密码不一致。。。");
		return;
	}
	var basepath = $("#basepath").val();
	$("#newpwdtest2").html("");
	$('#uppwd').attr("action",basepath+"/cms/updatePwdAdmin.do");
	$('#uppwd').submit();
}
function checkOldPwd(uid){
	//alert(uid);
	var oldpwd=$("#oldpwd").val();
	if(oldpwd==''|| oldpwd ==null){
		$("#oldpwdtest").html("原密码不能为空。。。");
		return;
	}
	$("#oldpwdtest").html("");
	if(oldpwd.length<6){
		$("#oldpwdtest").html("原密码长度不能小于6。。。");
		return;
	}
	$("#oldpwdtest").html("");
	var basepath = $("#basepath").val();
	var url = basepath+"/cms/checkPwdAdmin.do";
	$.post(url,{userid:uid,oldpwd:oldpwd},function(data){
		//alert(data);
		if(data == 1){
			$("#oldpwdtest").html("  ok");
			$("#isok").val(0);
		}else{
		    $("#isok").val(1);
			$("#oldpwdtest").html("原密码错误");
		}
	});
}

function checkOldPwd2(uid){
	//alert("111"+uid);
	var oldpwd=$("#pwd1").val();
	if(oldpwd==''|| oldpwd ==null){
		$("#oldpwdtest").html("原密码不能为空。。。");
		return;
	}
	$("#engmsg").html("");
	if(oldpwd.length<6){
		$("#engmsg").html("原密码长度不能小于6。。。");
		return;
	}
	$("#engmsg").html("");
	var basepath = $("#basepath").val();
	var url = basepath+"/cms/checkPwdAdmin.do";
	$.post(url,{userid:uid,oldpwd:oldpwd},function(data){
		//alert(data);
		if(data == 1){
			$("#engmsg").html("  ok");
			$("#isok2").val(0);
		}else{
		    $("#isok2").val(1);
			$("#engmsg").html("原密码错误");
		}
	});
}
  function checkform()
  {
	  var username= $("#username").val();
	  if(username===''||username===null){
		  $("#clasid").html("账号不能为空！");
		  return;
	  }
	  $("#clasid").html("");
	  var email=$("#email").val();
	  if(email==''||email==null){
		  $("#tnmsg").html("邮箱不能为空！");
		  return;
	  }
	  var myreg =/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	  if(!myreg.test(email)){
		  $("#tnmsg").html("邮箱格式不正确！");
		  return;
	  }
      $("#tnmsg").html("");

	 
	  var pwd1=$("#pwd1").val();
	  var isok2=$("#isok2").val();
	  if(pwd1==''||pwd1==null){
		  $("#engmsg").html("密码不能为空！");
		  return;
	  }
	  
	  if(pwd1.length<6){
		  $("#engmsg").html("密码长度不能小于6！");
		  return;
	  }
	  
	  $("#engmsg").html("");
	  if(isok2 == 1){
		  $("#engmsg").html("你输入的密码错误！");
		  return;
	  }
	  $("#engmsg").html("");
	  var basepath = $("#basepath").val();
	  var depts=document.getElementById("depts"); 
	  var a= depts.options[depts.selectedIndex].value; 
	  if(a==-1){
		  $("#dept").html("请选择部门！");
		  return;		  
	  }
	  $("#dept").html("");
	  //var basepath = $("#basepath").val();
	  $('#ff').attr("action",basepath+"/cms/updateInfoAdmin.do");
	  $('#ff').submit();

  }
  
  function resize(){
  		 
	     $("#ff").find("input").val("");
	     $("#ff").find("span").html("");
		 $('#w').window({
			title: '添加/修改数据界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});

	}
  function resizePwd(){
	  
	     $("#uppwd").find("input").val("");
	     $("#uppwd").find("span").html("");
		 $('#up').window({
			title: '密码修改界面',
			width: 500,
			modal: true,
			shadow: false,
			closed: false,
			height: 340,
			minimizable:false,
			maximizable:false
		});
	}