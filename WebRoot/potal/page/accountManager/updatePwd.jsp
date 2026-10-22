<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改密码</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<style type="text/css">
		body{ width:495px; font-size:14px;}
		.dow{width:495px; height:26px; float:left;}
		.dow_top{width:485px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
		.dow_top span{float:right; padding-right:10px; padding-top:1px;}
		.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
		.dow_nr{width:485px; border:1px solid #455c32;  float:left}
		.gb_lbt{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:15px; margin-right:auto; float:left;}
		.gb_rbt{ background-color:#4FA805; font-weight:bold; color:#fff; width:50px; line-height:25px; text-align:center; margin-left:auto; margin-right:15px; float:right}
		.yzm{ background-color:#bcbcbc; font-weight:bold; color:#000; width:50px; line-height:25px; text-align:center;}
		.font_color_lv{ color:#285a01}
		.textbox_color{ border:1px solid #fe6601;}
		.bg_bk { border:1px solid #3c8301;}
		div input{height:20px;}
		a{text-decoration: :none;}
	</style>
	<link href="<%=path %>/potal/css/index.css" type="text/css" media="screen" rel="stylesheet">

<script type="text/javascript">
    function check(){
        var uid=$("#uid").val();
        // 判断非空
        var oldpwd=$("#oldpwd").val();
        var newpwd=$("#newpwd").val();
        var surepwd=$("#surepwd").val();
        var pwd=$("#password").val();
        if(oldpwd.length<=0){
            $("#oldpwdMsg1").show();
            $("#oldpwdMsg").hide();
            $("#oldpwdMsg2").hide();
            return false;
        }
        if(oldpwd!=pwd){
            $("#info").html("输入的密码错误！");
        	$("#oldpwdMsg1").show();
            $("#oldpwdMsg").hide();
            $("#oldpwdMsg2").hide();
            return false;
        }
        if(newpwd.length<=0){
            $("#newpwdMsg1").show();
            $("#newpwdMsg2").hide();
            return false;
        }
        if(surepwd.length<=0){
            $("#surepwdMsg1").show();
            $("#surepwdMsg2").hide();
            $("#surepwdMsg").hide();
            return false;
        }
        //window.location.href="editPasswordAccountManager.do?uid="+uid+"&password="+newpwd;
        form1.action="editPasswordAccountManager.do?uid="+uid+"&password="+newpwd;
        form1.submit();
    }
    
    // 旧密码失去焦点事件验证
    function oldpwdOnfuces(){
        
    	 // 判断非空
    	var oldpwd=$("#oldpwd").val();
        if($("#oldpwd").val()==""){
            $("#info").html("不能为空！");
            $("#oldpwdMsg1").show();
            $("#oldpwdMsg").hide();
            $("#oldpwdMsg2").hide();
            return false;
        }else{
        	$("#oldpwdMsg1").hide();
            $("#oldpwdMsg2").show();
            $("#oldpwdMsg").hide();
        }
        // 判断输入的旧密码正不正确
        var pwd=$("#password").val();
        if(oldpwd!=pwd){
            $("#info").html("输入的密码错误！");
        	$("#oldpwdMsg1").show();
            $("#oldpwdMsg").hide();
            $("#oldpwdMsg2").hide();
            return false;
        }else{
        	$("#oldpwdMsg1").hide();
            $("#oldpwdMsg2").show();
            $("#oldpwdMsg").hide();
        }
    }
    
    //进行验证密码不能为中文和特殊字符
    function checkPwd(value,spanFalseID,span1,span2)
    {
	    var txt=new RegExp("[ ,\\`,\\~,\\!,\\@,\#,\\$,\\%,\\^,\\+,\\*,\\&,\\\\,\\/,\\?,\\|,\\:,\\.,\\<,\\>,\\{,\\},\\(,\\),\\',\\;,\\=,\"]");
		
		if(value!=""){	
			if(/[^\x00-\xff]/g.test(value))
			{
				$(spanFalseID).show(); 
				$(span1).hide(); 
				$(span2).hide(); 
				return false;
			}
			if(txt.test(value))
			{
				$(spanFalseID).show();
				$(span1).hide(); 
				$(span2).hide(); 
				return false;
			}
		}
		$(spanFalseID).hide();
		return true;
    }
    
    function newpwdOnfuces(spanFalseID,span1,span2){
   	 // 判断非空
       var newpwd=$("#newpwd").val();
       if(newpwd.length<=0){
           $("#newpwdMsg1").show();
           $("#newpwdMsg2").hide();
           return false;
       }else{
	       	$("#newpwdMsg1").hide();
	        $("#newpwdMsg2").show();
	        checkPwd(newpwd,spanFalseID,span1,span2);
       }
   }
   
   function surepwdOnfuces()
   {
        // 判断非空
        var surepwd=$("#surepwd").val();
        if(surepwd.length<=0){
       
            $("#surepwdMsg1").show();
            $("#surepwdMsg2").hide();
            $("#surepwdMsg").hide();
            return false;
        }
        else
        {
        	$("#surepwdMsg1").hide();
            $("#surepwdMsg2").show();
            $("#surepwdMsg").hide();
            
            var newpwd=$("#newpwd").val();
	        if(surepwd!=newpwd){
	        	$("#surepwdMsg1").hide();
	            $("#surepwdMsg2").hide();
	            $("#surepwdMsg").show();
	        }else{
	        	$("#surepwdMsg1").hide();
	            $("#surepwdMsg2").show();
	            $("#surepwdMsg").hide();
	        }
      }

    }
</script>
  </head>
  
  <body>
   <div class="dow">
<div class="dow_top">
<span><a href="javascript:yingcang();">×</a></span>
修改密码
</div>
</div>
<div class="dow">
<form action="" method="post" id="form1" name="form1">
<table style="background-color: #ffffff" width="100%" border="0" cellspacing="5" cellpadding="5" class="bg_bk">
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="20%" align="right">旧密码：</td>
    <td width="49%" align="left"><label for="textfield"></label>
    <input name="textfield" type="password" id="oldpwd" size="30" onblur="oldpwdOnfuces()" /></td>
    <td width="28%" align="left">
       <span id="oldpwdMsg"><img src="<%=path %>/potal/images/zhgl_v_l.png" width="15" height="17" />&nbsp;请输入旧密码</span>
       <span id="oldpwdMsg1" style="display: none;"><img src="<%=path %>/potal/images/zhgl_x.png" width="15" height="17" /><span id="info"></span></span>
       <span id="oldpwdMsg2" style="display: none;"><img src="<%=path %>/potal/images/zhgl_v.png" width="15" height="17" /></span>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right">新密码：</td>
    <td align="left"><input name="textfield2" id="newpwd" type="password" size="30" onblur="newpwdOnfuces('#newpwdMsg3','#newpwdMsg1','newpwdMsg2')"/></td>
    <td align="left">
       <span id="newpwdMsg1" style="display: none;"><img src="<%=path %>/potal/images/zhgl_x.png" width="15" height="17" />&nbsp;不能为空</span>
       <span id="newpwdMsg3" style="display: none;"><img src="<%=path %>/potal/images/zhgl_x.png" width="15" height="17" />不能输入中文和特殊字符</span>
       <span id="newpwdMsg2" style="display: none;"><img src="<%=path %>/potal/images/zhgl_v.png" width="15" height="17" /></span>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right">确认密码：</td>
    <td align="left"><input name="textfield3" id="surepwd" type="password" size="30" onblur="surepwdOnfuces()" /></td>
    <td align="left">
       <span id="surepwdMsg1" style="display: none;"><img src="<%=path %>/potal/images/zhgl_x.png" width="15" height="17" />&nbsp;不能为空</span>
       <span id="surepwdMsg" style="display: none;"><img src="<%=path %>/potal/images/zhgl_x.png" width="15" height="17" />&nbsp;两次输入密码不一致!</span>
       <span id="surepwdMsg2" style="display: none;"><img src="<%=path %>/potal/images/zhgl_v.png" width="15" height="17" /></span>
    </td>
  </tr>
  <tr>
    <td colspan="4" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="5">
      <tr>
        <td width="50%" align="right"><div class="gb_rbt" onclick="check()">确认</div></td>
        <td width="50%"><div class="gb_lbt" style="cursor: pointer;"  onclick="yingcang()">关闭</div></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</div>
  </body>
</html>
