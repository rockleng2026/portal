<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>跳转页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="x-ua-compatible" content="ie=7" />
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path %>/potal/css/commonCss.css"/>
<script type="text/javascript" src="<%=path %>/potal/js/messageJs.js">
</script>
<link rel="stylesheet" type="text/css" href="<%=path %>/potal/css/commonCss.css"/>
<script type="text/javascript">
   function showemp(){
	   $("#allemp").toggle();
   }
   function showdept(){
	   $("#alldept").toggle();
   }
   function showempdept(){
	   $("#deptEmp").toggle();
   }
   // 根据部门找到这个部门下面的员工
   function deptemp(){
	   var deptid=$("#seldept").val();
	   $.ajax({
			  type: "post",
			  url: "empBydidmessage.do",
			  data: {
				 deptid:deptid
			  },
			  success: function(data){						  
			      $("#deptEmp").show();
			      $("#tabEmp").html(data);
		      }
		});
   }

   // 得到当前选中的员工
   var emp=""; 
   var empid="";
   function checkEmp(check){
      var empname = check.value;
      var eid=check.id;
      if(check.checked==true){
         emp+=empname+",";
         empid+=eid+",";
      }else if(check.checked==false){
        emp=emp.replace(empname+",","");
        empid=empid.replace(eid+",","");
      }else{}
      $("#receiver").attr("value",emp);
      $("#users").attr("value",empid);
    }

 //根据是个人消息还是系统消息,再决定是否需要审核
   function judgeM()
   {
	    var messJudge="1";
	    var typeid=$("#typeid").val();
	    var url="judgeMmessage.do";
	    var mes=$("#mesty");
	 		mes.empty();
	    $.post(url,{messJudge:messJudge,typeid:typeid},function (data)
	    {
            if(data!=1){   
              mes.html(data);
            }
	    });
   }

   // 判断非空
   function check(){
	   var typeid= $("#typeid").val();
	   var mesty=$("#mesty").val();
	   var receiver=$("#receiver").val();
	   var titleweb=$("#titleweb").val();
	   var content=$("#msgcontent").val();
	   if(typeid==-1){
		   alert("请选择消息类型!");
		   return false;
	   }
	   if(mesty==-1){
		   alert("请选择消息类型!");
		   return false;
	   }
	   if(receiver.length<=0){
		   alert("请勾选消息接收人!");
		   return false;
	   }
	   if(titleweb.length<=0){
		   alert("请输入消息标题!");
		   return false;
	   }
	   if(content.length<=0){
		   alert("请输入消息内容!");
		   return false;
	   }
   }
// 存入草稿箱
   function caogao(){
	   var typeid= $("#typeid").val();
	   var mesty=$("#mesty").val();
	   var receiver=$("#receiver").val();
	   var titleweb=$("#titleweb").val();
	   var content=$("#msgcontent").val();
	   if(typeid==-1){
		   alert("请选择消息类型!");
		   return false;
	   }
	   if(mesty==-1){
		   alert("请选择消息类型!");
		   return false;
	   }
	   if(receiver.length<=0){
		   alert("请勾选消息接收人!");
		   return false;
	   }
	   if(titleweb.length<=0){
		   alert("请输入消息标题!");
		   return false;
	   }
	   if(content.length<=0){
		   alert("请输入消息内容!");
		   return false;
	   }	   
	   var dtitleweb=encodeURI(titleweb,"utf-8");
	   var dcontent=encodeURI(content,"utf-8");
	   var users=$("#users").val();
	   $.ajax({
			  type: "post",
			  url: "caogaomessage.do",
			  data: {
				  "typeid":typeid,
				  "mesty":mesty,
				  "titleweb":dtitleweb,
				  "content":dcontent,
				  "users":users
				  },
			  success: function(data){						  
			      alert(data);
			  }
			 });
   }
   // 快速查找人员
   function chakanemp(){
	   var empname=$("#lookemp").val();
	   empname=encodeURI(empname,"utf-8");
	   $.ajax({
			  type: "post",
			  url: "getEmpBynamemessage.do",
			  data: {
				  "empname":empname
				  },
			  success: function(data){	
			      $("#allemp").html(data);
			  }
		});
   }
   // 关闭当前层
   function gb(){
	   parent.document.getElementById('light').style.display='none';
   }
</script>
<style type="text/css">
body{width:760px; margin:0 auto; height:500px; font-size:12px}
a { text-decoration:none;}
img{border:0}
dl,dd,dt,p,input{padding:0px; margin:0px;}
.dow{width:760px; height:230px; float:left}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.dow_nr{width:758px; border:1px solid #455c32;  float:left}
.tc_form{width:750px; float:left; line-height:23px;}
.tc_form dd{width:530px; float:left; text-align:right;}
.tc_form dt{width:210px; float:left; text-align:left; padding-left:10px;}
.tc_form dt span{width:50px; float:right}
.tc_form dt span a{width:45px; float:left; text-align:center; color:#FFFFFF; text-decoration:none; height:21px; background:#519300; line-height:21px;}
.text{ height:19px; border:1px solid #b2b2b2}
.foot{padding-right:15px}
.foot a{height:24px; padding:5px; text-decoration:none; color:#000000}}
.foot a:hover{background:#5da500; color:#FFFFFF}
.tc_top{background:#7b7b7b; color:#FFFFFF}
.tc_footb{border-bottom:1px solid #c3c3c3}
.tc_footb a{text-decoration:none; color:#ff9002; }
.tc_footb a:hover{background:#5da601; float:left; width:100%; color:#FFFFFF; line-height:26px; clear:both; }
.tc_rightb{border-right:1px solid #c3c3c3}

/*hongbinma */
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
 
.foot1 {padding-right:15px}
.text1 {width:145px; height:19px; border:1px solid #b2b2b2}
.lb { height:25px; border-bottom:1px solid #295A00;}
.lb li{
text-align:center; font-size:15px;margin-top:10px; border: 1px solid #295A00; width:115px; margin-left:20px; padding:5px 5px 3px 5px; border-bottom-width:0px;   
 position:relative;  background-color:#fff; z-index:1; }
 .msg{ border:#FFDAAD 1px solid; line-height:20px; background-color:#FFFBF2}
  .msgshow .c{background:url(images/c1.png) no-repeat 100px 0px; height:7px; position:relative; margin-bottom:-1px;  z-index:1; }
.rz_box{ border-top:2px solid #4FA805;}
.main { width:760px; margin:0 auto;font-size:12px;background-color: #fff;}
.yx_bt { line-height:30px; color:#fff; font-size:14px; font-weight:bold; background-color:#295a00;}
.yx_bt span { color:#81f106;}
.yx_bt a { text-decoration:none; color:#fff;}

.y_x { line-height:30px; margin-top:5px; border-top:1px solid #eeb98d;}
.yx_top { background-color:#f4f4f6; border-right:1px solid #c7c8c0; border-bottom:1px solid #c7c8c0;}
.yx_topy { background-color:#f4f4f6; border-bottom:1px solid #c7c8c0;}
.yx_cd { border-bottom:2px solid #e0731e; color:#e1731e; font-size:16px; font-weight:bold; line-height:30px; padding-left:35px;}
.yx_cd span { font-size:12px; font-weight:normal;}
.wd_xx { font-weight:bold;}
.hui{ color:#3b393a; line-height:30px; font-size:12px;}
.hui a{color:#3b393a;}
.hui a:hover{ color:#FFF; background-color:#5da601;}
.td_bcolor{ border-bottom:1px solid #e6dcdd; border-right:1px solid #e6dcdd}
.yx_xhx { border-bottom:1px solid #e7e7e7;}
.wz_hs { color:#ff0000;}
.ss_hd { background-color:#e5e5e5; padding-left:5px;}
.tj_fj { color:#e1731c;}
.tj_fj a { color:#e1731c;}
.yx_an { background-color:#5da601; color:#fff; line-height:20px; width:50px; text-align:center;}
#l_h { line-height:25px;}
.xz_ry {padding-left:20px; line-height:20px; overflow:auto; height:100px; border:1px solid #e1dfe0; border-top-width:0px;}
.wz_cs { color:#e1731c; font-weight:bold;}
.xz_l { background-color:#e1dfe0; font-weight:bold; padding-left:5px;}
.zw_pd { padding-top:10px;}

</style>
</head>
<body>
<div class="main">
<%
  List emplist=(List) request.getAttribute("emplist");
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="yx_bt">
  <tr>
     <td width="15%" align="center"><a href="<%=path %>/writelogmessage.do"><span>写消息</span></a></td>
    <td width="17%" align="center"><a href="<%=path %>/noreadMessagemessage.do">收件箱（${messagecount}）</a></td>
    <td width="17%" align="center"><a href="<%=path %>/sendEmailmessage.do">已发送</a></td>
    <td width="17%" align="center"><a href="<%=path %>/delEmailmessage.do">已删除</a></td>
    <td width="17%" align="center"><a  href="<%=path %>/caogaoEmailmessage.do">草稿箱</a></td>
    <td width="17%" align="right"><a href="javascript:out()">x</a>&nbsp;&nbsp;</td>
  </tr>
</table>
</div>
<form name="form1" id="form1" action="<%=path %>/sendmessage.do" method="post" onsubmit="return check();"">
<div class="main">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="y_x">
  <tr>
    <td colspan="5" align="center" class="yx_top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="15%" align="right"><span class="wz_hs">*</span>&nbsp;消息类型：</td>
    <td width="55%" align="left"><label>
      <select name="message.messagetypeBySendertype.messagetypeid" id="typeid" onchange="judgeM()" >
	    	<option value="-1">--请选择--</option>
	    	<c:forEach items="${messlist}" var="type">
	    	   <option <c:if test="${type.messagetypeid==message.messagetypeBySendertype.messagetypeid }">selected</c:if> value="${type.messagetypeid }">${type.type }</option>
	    	</c:forEach>
	    </select>&nbsp;&nbsp;
	    <c:if test="${not empty message}">
	        <select id="mesty" name="message.messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
			   <option value="${message.messagetypeByMessagetype.messagetypeid }">${message.messagetypeByMessagetype.type }</option>  
		    </select>
	    </c:if>
	    <c:if test="${empty message}">
	         <select id="mesty" name="message.messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
				   <option value="-1">请选择！！</option>  
			 </select>
	   </c:if>
    </label></td>
    <td width="30%" rowspan="7" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="l_h">
      <tr>
        <td align="left"><label>
          <input type="text" name="textfield" id="lookemp" value="" onkeyup="chakanemp()" />
        </label></td>
      </tr>
      <tr>
        <td align="left" class="xz_l"  onclick="showemp()"><span class="wz_cs">∨</span>&nbsp;所有人员列表</td>
      </tr>
      <tr>
        <td align="left"><div class="xz_ry"  id="allemp">
        <ul>
           <c:forEach items="${emplist}" var="emp" >
          	  <li><label><input type="checkbox" id="${emp.id }" value="${emp.name }" onclick="checkEmp(this)" />${emp.name }</label></li>
           </c:forEach>
        </ul>
        </div>
        </td>
      </tr>
      <tr>
        <td align="left" class="xz_l" onclick="showdept()"><span class="wz_cs">∨</span>&nbsp;选择部门</td>
      </tr>
      <tr>
        <td align="left"><div id="alldept">
        	<select id="seldept" onchange="deptemp()" style="width: 100px;">
               <option value="-1">--请选择--</option>
               <c:forEach items="${deptlist}" var="dept" >
                   <option value="${dept.id }">${dept.name }</option>
               </c:forEach>
            </select>
        </div></td>
      </tr>
      <tr>
        <td align="left" class="xz_l" onclick="showempdept()"><span class="wz_cs">∨</span>&nbsp;按部门选择人员</td>
      </tr>
      <tr>
        <td align="left">
		<div class="xz_ry" id="deptEmp">
		       <table width="100" border="0" cellspacing="0" cellpadding="0" id="tabEmp">
		       </table>
	     </div>
	     </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="right"><span class="wz_hs">*</span>&nbsp;收件人：</td>
    <td align="left"><label>
      <input type="text"  name="receiver" id="receiver"  size="53" value="${empstr}"/>
      <input type="hidden" id="users" name="users" value="${empstrid }">
    </label></td>
    </tr>
  <tr>
    <td align="right"><span class="wz_hs">*</span>&nbsp;主题：</td>
    <td align="left"><label>
      <input type="text"  name="message.titleweb" id="titleweb" size="53" value="${message.titleweb }" />
    </label></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="left" class="tj_fj"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="6%"><img src="<%=path %>/potal/images/xtb_scfj.jpg" width="24" height="20" /></td>
          <td width="94%">添加附件 </td>
        </tr>
      </table></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="left" class="ss_hd">文件名.jsp &nbsp;&nbsp;正在上传 &nbsp;&nbsp;<a href="#">删除</a></td>
    </tr>
  <tr>
    <td align="right" valign="top" class="zw_pd">
	<span class="wz_hs">*</span>&nbsp;正文：</td>
    <td align="left"><label>
      <textarea name="message.messagecontent" id="msgcontent" cols="53" rows="6">${message.messagecontent}</textarea>
    </label></td>
    </tr>
  <tr>  
    <td>&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15%"> <input type="submit" class="gb_bt" value="发送"> </td>
        <td width="15%"> <input type="reset" class="gb_bt" value="重置"> </td>
        <td width="15%" > <input type="button" class="gb_bt" onclick="caogao()" value="存草稿"> </td>
        <td width="15%"> <input type="button" class="gb_bt" onclick="gb()" value="关闭"> </td>
        <td width="40%">&nbsp;</td>
      </tr>
    </table></td>
    </tr>
</table>
</td>
    </tr>
</table>
</div>
</form>
</body>