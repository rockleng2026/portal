<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery1.6.js"></script>
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
</script>
<div class="left">
<form name="form1" id="form1" action="<%=path %>/sendmessage.do" method="post" onsubmit="return check();"">
<table width="560" height="379" border="0" align="left" cellpadding="0" cellspacing="0" class="bk1">
  <tr>
    <td height="31" colspan="2">发件箱中（带<b>*</b>号的为必填项）</td>
    </tr>
  <tr>
    <td width="80" height="31" class="topbk blue rightbk"><b>*</b>消息类型</td>
    <td width="480" class="topbk rightbk">
	    <select name="" id="typeid" onchange="judgeM()" >
	    	<option value="-1">--请选择--</option>
	    	<c:forEach items="${messlist}" var="type">
	    	   <option value="${type.messagetypeid }">${type.type }</option>
	    	</c:forEach>
	    </select>&nbsp;&nbsp;
         <select id="mesty" name="message.messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
			   <option value="-1">请选择！！</option>  
		 </select>
    </td>
    </tr>
  <tr>
    <td width="80" height="31" class="topbk blue rightbk"><b>*</b>接收人</td>
    <td width="480" class="topbk rightbk">
              <INPUT style="WIDTH: 95%" name="receiver" id="receiver"  class="biaodan_1" >
              <input type="hidden" id="users" name="users">
    </td>
    </tr>
  <tr>
    <td width="80" height="31" class="topbk blue"><b>*</b>标题</td>
    <td width="480" class="topbk rightbk">
         <INPUT style="WIDTH: 95%" name="message.titleweb" id="titleweb" class="biaodan_1">
    </td>
    </tr>
  
  <tr>
    <td width="80" height="180" class="topbk blue rightbk"><br />
      <b>*</b>消息内容</td>
    <td width="480" height="180" align="left" valign="top" class="topbk rightbk">
       <textarea name="message.messagecontent" id="msgcontent" cols="" rows="" class="biaodan_2"></textarea>
    </td>
    </tr>
  <tr>
    <td width="80" height="30" class="topbk blue rightbk">&nbsp;</td>
    <td width="480" align="left" valign="top" class="topbk rightbk">
		<input name="" type="submit" value="发送"  class="an"/>
		<input name="" type="reset"" value="重置"  class="an"/>
		<input name="" type="button" value="存草稿" class="an" />
		<input name="" type="button" value="关闭"  class="an"/>	
	</td>
    </tr>
</table>
</form>
</div>
<div class="right">
<table width="150" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="31"><span><input type="text" name="q" title="Search" class="searchinput" id="searchinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='多条件查询请用';" onfocus="if(this.value=='多条件查询请用')value='';" value="多条件查询请用" size="10"/>
<input type="image" width="20" height="0" class="searchaction" onclick="if(document.forms['search'].searchinput.value=='多条件查询请用')document.forms['search'].searchinput.value='';" alt="Search" border="0" hspace="2"/></span></td>
  </tr>
  <tr>
    <td height="31">
       <div class="yui" onclick="showemp()"><span class="da">></span>所有人员列表</div>
       <div style="height: 250px; overflow: auto;display:none; margin-left:20px;" id="allemp">
       <table width="100" border="0" cellspacing="0" cellpadding="0">
          <c:forEach items="${emplist}" var="emp" >
	           <tr height="30">
	              <td><input type="checkbox" id="${emp.id }" value="${emp.name }" onclick="checkEmp(this)" />${emp.name }</td>
	           </tr>
           </c:forEach>
       </table>
       </div>
    </td>
  </tr>
  <tr>
    <td height="31">
        <div class="yui" onclick="showdept()"><span class="da">></span>选择部门</div>
        <div style="width:100px; display:none; margin-left:20px;" id="alldept">
           <select id="seldept" onchange="deptemp()" style="width: 100px;">
               <option value="-1">--请选择--</option>
               <c:forEach items="${deptlist}" var="dept" >
                   <option value="${dept.id }">${dept.name }</option>
               </c:forEach>
           </select>
	    </div> 
    </td>
  </tr>
  <tr>
    <td height="31"><div class="yui" onclick="showempdept()"><span class="da">></span>按部门选择人员</div>
         <div style="height: 200px; overflow: auto;display:none; margin-left:20px;" id="deptEmp">
		       <table width="100" border="0" cellspacing="0" cellpadding="0" id="tabEmp">
		       </table>
	     </div>
    </td>
  </tr>
</table>
</div>