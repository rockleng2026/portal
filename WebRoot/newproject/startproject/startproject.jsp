<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.getSession().removeAttribute("files");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>立项</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath() %>/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
    <jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
	<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
	<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
	<style type="text/css">
	  .tishi {
	width:300px;
	height:30px;
	line-height:30px;
	color:#F00;
	border:0px;
}
	
	</style>
  </head>
   <script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : false,
					items : [
		'fontname', 'fontsize','forecolor', '|',  'bold', 'italic', 'underline','lineheight',
		'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
		'insertunorderedlist', '|','map', 'image', 'link','source','fullscreen']
				});
			});
	
	
	  function handle(){
//		     $("#cyemp").show();
//		     var cyrid=$("#cyrid").val();
//		     var deptid = $("#bm").val();
		     $.post('getempByzgnewProject.do',{},function(data){
		          if(data!=null && data!=""){
		             $("#tab3").html(data);
		          }else{
		            $("#tab3").html("");
		          }
		          
		       });
		  }
	
	
    function hiddenDIV(){
      $("#lxsq").hide();
      $("#sq").hide();
      $("#zk").show();
    }
    
   
    function showDIV(){
      $("#lxsq").show();
      $("#sq").show();
      $("#zk").hide();
    }
  
    function hidefj(){
      $("#annex").hide();
      $("#sqfj").hide();
      $("#zkfj").show();
    }
   
    function showfj(){
      $("#annex").show();
      $("#zkfj").hide();
      $("#sqfj").show();
    }
    
   
    function hidelixiang(){
      $("#lixiang").hide();
      $("#zk").show();
      $("#sq").hide();
    }
    
    function showlixiang(){
      $("#lixiang").show();
      $("#sq").show();
      $("#zk").hide();
    }
    
    
   
    function showDepts(){
      $("#searchDiv").show();
      $("#emp").hide();
    }
    
   
    function showEmps(){
      $("#emp").show();
      $("#searchDiv").hide();
    }
    
    function hideall(){
      $("#searchDiv").hide();
      $("#emp").hide();
    }
    
    
    function hidedepts(){
      $("#searchDiv").hide();
//      $("#cyr").val("");
//      $("#cyrid").val("");
    }
    
   
    function hideemps(){
      $("#emp").hide();
    }
    
    function hidecyry(){
      $("#cyry").hide();
      $("#ry").show();
      $("#ry2").hide();
    }
    
    function showcyry(){
      $("#cyry").show();
      $("#ry").hide();
      $("#ry2").show();
    }
    
    
    
    var dept=""; 
    var deptid="";
    function checkDept(check){
      var deptname=check.value;
      var did=check.id;
       if(check.checked==true){
          dept+=deptname+",";
          deptid+=did+",";
       }else if(check.checked==false){
         dept=dept.replace(deptname+",","")
         deptid=deptid.replace(did+",","");
       }else{}
       $("#joindept").attr("value",dept);
       $("#bm").attr("value",deptid);
    }
    
   
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
      $("#look").attr("value",emp);
      $("#watcher").attr("value",empid);
    }
    
    
    
    var cyr=""; 
    var cyrid="";
    function checkCyr(check){
      var empname = check.value;
      var eid=check.id;
      if(check.checked==true){
         cyr+=empname+",";
         cyrid+=eid+",";
      }else if(check.checked==false){
        cyr=cyr.replace(empname+",","");
        cyrid=cyrid.replace(eid+",","");
      }else{
      }
      $("#cyr").attr("value",cyr);
      $("#cyrid").attr("value",cyrid);
    }
</script>

<script type="text/javascript">
  
   
   $(document).ready(
     function(){
      //emplist   $("#tab2")   
       $.post('deptlistnewProject.do',{},function(data){
          $("#tabaa").append(data);
       });
     }
   );
   
   
   function showdept2(){
//      $.post('deptlistnewProject.do',{},function(data){
          //alert(data);
//          $("#tabaa").html("");
//          $("#tabaa").html(data);
//        });
 //       $("#cyemp").show();
   }
   
   function showemp2(){
     $.post('emplistnewProject.do',{},function(data){
          $("#tab2").append(data);
       });
   }
   
  
   function loadcyry(){
     $("#cyemp").show();
     var cyrid=$("#cyrid").val();
     var deptid = $("#bm").val();
     $.post('emplistlxnewProject.do',{'deptid':deptid,'cyrid':cyrid},function(data){
          if(data!=null && data!=""){
             $("#tab3").html(data);
          }else{
            $("#tab3").html("");
          }
          
       });
       
       $("#emp").hide();
   }
   
    function closecyemp(){
      $("#cyemp").hide();
    }
   
   function checkData(){
   
   // 项目名称
     var pname = $("#cc").val();
     if(pname.length<=0 && pname==""){
       $("#xmmc").html("请填写项目名称!");
       return false;
     }else{
       $("#xmmc").html("");
     }
     
     //开始时间
     var begintime = $("#begintime").val();
     if(begintime.length<=0 && begintime==""){
        $("#kssj").html("请填写开始时间!");
        return false;
     }else{
       $("#kssj").html("");
     }
     
     //结束时间
     var endtime = $("#endtime").val();
     if(endtime.length<=0 && endtime==""){
       $("#jssj").html("请填写结束时间");
       return false;
     }else{
       $("#jssj").html("");
     }
     
     //参与部门
     var dept = $("#joindept").val();
     if(dept.length<=0 && dept==""){
       $("#cybm").html("至少要有一个参与部门!");
       return false;
     }else{
       $("#cybm").html("");
     }
     
     //项目查看人
     var xmckz = $("#look").val();
     if(xmckz.length<=0 && xmckz==""){
       $("#xmckz").html("至少要有一个查看者!");
       return false;
     }else{
       $("#xmckz").html("");
     }
     
     
     //项目描述
     editor.sync(); 
     var info = $("#content").val();
     if(info.length<=0 && info==""){
       $("#xmms").html("请填写项目描述!");
       return false;
     }else{
       $("#xmms").html("");
     }
     var obj=document.getElementsByName("iscommit");
     
     for(i=0;i<obj.length;i++){
     if(obj[i].checked==true){
     
     if(obj[i].value==1)
     {
         var topren=document.getElementById("topshenpiren1").value;
         if(topren==''||topren==null)
         {
				alert("请填写监管（审批人）");
				return false;
             }
         }
     }
     }
     //项目资金
     var qian = $("#zijing").val();
     if(qian.length<=0 && qian==""){
        $("#zijing1").html("请填写资金!");
        return false;
     }else{
       $("zijing1").html("");
     }
     
     //参与人员
     var ry = $("#cyr").val();
     if(ry.length<=0 && ry==""){
        $("#xzry").html("至少要有一个参与人");
        return false;
     }else{
        $("#xzry").html("");
     }
     //审批人
     //var isok=document.getElementById("isok").value;
     
     //消息标题
     var title = $("#title").val();
     if(title.length<=0 && title==""){
        $("#bt").html("请填写标题!");
        return false;
     }else{
        $("#bt").html("");
     }
     
     
     //消息内容
     var content = $("#messagecontent").val();
     if(content.length<=0 && content==""){
        $("#xxnr").html("请填写内容!");
        return false;
     }else{
        $("#xxnr").html("");
     }
	   editor.sync();  
	   var cont= editor.html();
	   $("#hi").val(cont);
	   form1.submit();
    
     
   }

  
   function nameblue(){
	   var cc=$("#cc").val();
	   if(cc.length>0){
	   	  $("#xmmcok").show();
	   	  $("#xmmcno").hide();
	   }
	   if(cc.length<=0){
		  $("#xmmcno").show();
		  $("#xmmcok").hide();
	   }
   }

   function begintimeblue(){
	   var begintime=$("#begintime").val();
	   var endtime=$("#endtime").val();
	   if(begintime.length>0 && endtime.length>0){
		   $("#begintimeok").show();
		   $("#begintimeno").hide();
	   }
	   if(begintime.length<=0){
		   $("#begintimeok").hide();
		   $("#begintimeno").show();
	   }
	   if(endtime.length<=0){
		   $("#begintimeok").hide();
		   $("#begintimeno").show();
	   }
   }

   function deptblue(){
	  var dept=$("#bm").val();
	  if(dept.length>0){
		  $("#cybmok").show();
		  $("#cybmno").hide();
	  }
	  if(dept.length<=0){
		  $("#cybmok").hide();
		  $("#cybmno").show();
	  }
   }

   function ckzblue(){
	   var ckz=$("#watcher").val();
	   if(ckz.length>0){
		   $("#ckzok").show();
		   $("#ckzno").hide();
	   }
	   if(ckz.length<=0){
		   $("#ckzno").show();
		   $("#ckzok").hide();
	   }
   }

   function xmmsblue(){
	   var ms=$("#hi").val();
	   if(ms.length>0){
		   $("#xmmsok").show();
		   $("#xmmsno").hide();
	   }
	   if(ms.length<=0){
		   $("#xmmsok").hide();
		   $("#xmmsno").show();
	   }
   }

   function xzryblue(){
	  var  ry=$("#cyr").val();
	  if(ry.length>0){
		  $("#xzryok").show();
		  $("#xzryno").hide();
	  }  
	  if(ry.length<=0){
		  $("#xzryno").show();
		  $("#xzryok").hide();
	  } 
   }

   function btblue(){
	   var bt=$("#title").val();
	   if(bt.length>0){
		   $("#btok").show();
		   $("#btno").hide();
	   }
	   if(bt.length<=0){
		   $("#btno").show();
		   $("#btok").hide();
	   }
	}

   function xxnrblur(){
	   var xxnr=$("#messagecontent").val();
	   if(xxnr.length>0){
		   $("#nrok").show();
		   $("#nrno").hide();
	   }
	   if(xxnr.length<=0){
		   $("#nrno").show();
		   $("#nrok").hide();
	   }
	}
   function zijingblur(){
	   var xxnr=$("#zijing").val();
	   if(xxnr.length>0){
		   $("#zijing2").show();
		   $("#zijing3").hide();
	   }
	   if(xxnr.length<=0){
		   $("#zijing3").show();
		   $("#zijing2").hide();
	   }
	}	
   function shuzi(inputname){
		var zhi=document.all(inputname).value;
			if(zhi.length>0 && isNaN(zhi)==true){
			document.all(inputname).value=zhi.substring(0,zhi.length-1);
			shuzi(inputname);
			}
	}
   function selectTop()
   {
		var topshenpiren=document.getElementById("topshenpiren").value;
		document.getElementById("topshenpiren1").value=topshenpiren;
	   }
</script>
  
  <body>
  	<hr color="#FF9224"/>
  <table class="tableStyle" id="youshuju">
  <tr>
  <th><b style="float:left;"><img src="<%=request.getContextPath()%>/icons/png/04.png" width="25" height="25"></img>立项申请(带*为必填项)</b>
      <span style="float:right;">
	   <button type="button" id="zk" onclick="showlixiang()" style="display: none;"><span class="icon_btn_down">展开</span></button>
	   <button  type="button" id="sq" onclick="hidelixiang(),hideall()" ><span  class="icon_btn_up">收起</span></button>
	  </span>
  </th>
  </tr>
  </table>
  

  <div id="lxsq" style="position: absolute;" align="center">
   <form action="<%=path %>/startnewProject.do" method="post" id="form1" name="form1" enctype="multipart/form-data">
    <div id="lixiang" style="display: block;">
    <table class="tableStyle" id="youshuju">
      <tr>
      <th  class="rightbold" width="15%">项目负责人:</th>
      <td  width="35%"> <input type="text" name="project.launcher" id="launcher" value="${emp.name}" readonly="true"/></td>
      <th  width="15%" class="rightbold">项目名称:</th>
      <td width="35%"><input type="text" name="project.projectname" id="cc" onblur="nameblue()" />
      <font color="red" size="2">*</font>
      <span style="color:red;" id="xmmc" >
         <span id="xmmcok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
         <span id="xmmcno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
      </span>
      
      </td>
      
      </tr>
      <tr>
      <th  class="rightbold">项目类别:</th>
      <td>
      <select name="type">
        <s:iterator value="typelist" var="type">
        <option value="<s:property value='#type.id'/>"><s:property value="#type.name"/></option>
        </s:iterator>
      </select></td>
      <th  class="rightbold">计划周期:</th>
      <td>
      <input type="text" name="project.begintime" class="Wdate" style="width: 90px;" id="begintime" onblur="begintimeblue()" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/><nobr>至
      <input type="text" class="Wdate" style="width: 90px;" name="project.endtime" id="endtime"  onblur="begintimeblue()" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/></nobr>
      <font color="red" size="2">*</font><font color="red" id="kssj" size="2"></font>
      <span style="color:red;" id="jssj" >
          <span id="begintimeok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
          <span id="begintimeno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
      </span>
      </td>
      </tr>
      
      <tr >
      <th  class="rightbold">参与部门:</th>
      <td>
      <input type="hidden" name="cybm" id="bm"/>
      <textarea cols="10" rows="5" name="" id="joindept" readonly="true" ></textarea>
      		<button type="button" onclick="showdept2(),showDepts()"><span class="icon_add">添加</span></button>
	        <font color="red" size="2">*</font>
	        <span style="color:red" id="cybm">
	           <span id="cybmok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
               <span id="cybmno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
	        </span>
      </td>
      <th class="rightbold">项目查看者:</th>
      <td>
      <input type="hidden" name="ckz" id="watcher"/>
      <textarea id="look" name="" cols="10" rows="5" readonly="true"></textarea>
      <button type="button" onclick="showemp2(),showEmps()"><span class="icon_add">添加</span></button>
	  <font color="red" size="2">*</font>
	  <span style="color:red;" id="xmckz">
	     <span id="ckzok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
         <span id="ckzno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
	  </span>
      </td>
      </tr>
       <tr>
      <th  class="rightbold">项目描述:</th>
      <td colspan="3">
       <input type="hidden" id="hi" name="project.projectinfo"/>
       <div onclick="hideall()">
         <textarea name="content" id="content" class="textarea" onblur="xmmsblue()"  style='width:450px;height:200px;visibility:hidden;'></textarea>
       </div>
       <font color="red" size="2">*</font>
       <span style="color:red;" id="xmms">
          <span id="xmmsok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
          <span id="xmmsno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
       </span>
      </td>
      </tr>
      
      <tr>
      <th class="rightbold">项目监管者:</th>
      <td>
        <input name="project.employee.id" type="hidden"  id="topshenpiren1" value="" />
     <!--   <input type="text" readonly="readonly" value="${approveemp.name }" />-->
     <SELECT value="this.value" id="topshenpiren" onchange="selectTop()">
     <option value="0">请选择！！</option>
     <c:forEach items="${workpositionEmployee}" var="data" >
     	<option value="${data.employee.id }">${data.employee.name }</option>
     </c:forEach>
     </SELECT>
     <br />
     <font color="red" style="font-size: 8px">需要审批:必须选择→_→（发起项目后的审批人）</font>
      </td>
      <th class="rightbold">项目资金:</th>
      <td align="left"><input type="text" name="project.money" value="" id="zijing" onblur="zijingblur()" onkeyup="shuzi('project.money')" /> 
          <font color="red" size="2">*</font>
	          <span style="color:red;" id="zijing1">
	               <span id="zijing2" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
                   <span id="zijing3" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
	          </span>
      </td>
      </tr>
      <Tr>
        <th class="rightbold">是否提交审批:</th>
        <td colspan="3">
          <input type="radio" name="iscommit" value="1" checked="checked"/>是
          <input type="radio" name="iscommit" id="isok" value="2"/>否
        </td>
      </Tr>
    </table>
    </div>
     
    <hr color="#FF9224"/>
    <div>
    <table class="tableStyle" id="youshuju">
		<tr>
		  <th ><b style="float:left;"><img src="<%=path %>/icons/png/71.png" width="25" height="25"></img>参与人员</b>
		      <span style="float:right;">
			   <button type="button" id="ry" onclick="showcyry()" style="display: none;"><span class="icon_btn_down">展开</span></button>
			   <button  type="button" id="ry2" onclick="hidecyry()" ><span  class="icon_btn_up">收起</span></button>
			  </span>
		  </th>
		</tr>
	 </table>
	 </div>
	 <div id="cyry" style="display: block;">
     <table class="tableStyle" id="youshuju"> 
	      <tr>
	        <th width="15%">选择人员:</th>
	        <td colspan="3">
	            <input type="hidden" name="joinemp" id="cyrid" value=""/>
	        	<textarea id="cyr" name="" cols="10" rows="5" readonly="true"></textarea>
	      		<button type="button" onclick="loadcyry(),closeckz()"><span class="icon_add">添加</span></button>
	      		<font color="red" size="2">*</font>
                <span style="color:red;" id="xzry">
                   <span id="xzryok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
                   <span id="xzryno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
                </span>
	        </td>
	      </tr>
	      <tr>
	        <th width="15%">消息标题:</th>
	        <td colspan="3">
	          <input type="text" name="title" id="title" onblur="btblue()"/>
	          <font color="red" size="2">*</font>
	          <span style="color:red;" id="bt">
	              <span id="btok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
                   <span id="btno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
	          </span>
	        </td>
	      </tr>
	      <tr>
	        <th width="15%">消息内容:</th>
	        <td colspan="3">
	          <textarea name="messagecontent" rows="10" cols="5" onblur="xxnrblur()" id="messagecontent"></textarea>
	          <font color="red" size="2">*</font>
	          <span style="color:red;" id="xxnr">
	               <span id="nrok" style="display:none;"><img src="<%=path %>/images/a.png"></img></span>
                   <span id="nrno" style="display:none;"><img src="<%=path %>/icons/delete.gif"></img></span>
	          </span>
	        </td>
	      </tr>
	 </table>
	 </div>
    <hr color="#FF9224"/>
    <table class="tableStyle" id="youshuju">
	</table>
    </form>
    <div>
      <div>    	
		  <b style="float:left;"><img src="<%=path %>/icons/png/52.png" width="25" height="25"></img>附件选择</b>
		      <span style="float:right;">
			   <button type="button" id="zkfj" onclick="showfj()" style="display: none;"><span class="icon_btn_down">展开</span></button>
			   <button  type="button" id="sqfj" onclick="hidefj()" ><span  class="icon_btn_up">收起</span></button>
			  </span>
	  </div>
	    <div id="annex">
	      <jsp:include page="uploadfiles.jsp" flush="true"></jsp:include>
		</div>
    </div>
    <table class="tableStyle" id="youshuju"> 
      <tr>
	      <td align="center" colspan="4" >
	      <button type="button" onclick="checkData()"><span class="icon_save">保存</span></button>
	      <button type="reset"><span class="icon_clear">重置</span></button>
	      <input type="button" value="点击" onclick="handle()"/>
	      </td>
      </tr>
      </table>
 </div>      
  

   <div id="searchDiv" class="searchDiv"  style="position: absolute;left: 350px;top: 110px;border-color: red; display: none;border:#89aad7 1px solid;margin-bottom: 10px;">
   <div style="width: 300px;height: 10px;background-color: #FFFFFF; z-index: 10;" align="right">
   <div style="float:left;font-weight:bold;">选择部门列表</div>
   <div style="float:right;position: absolute;left:160px;">
     <a href="javascript:hidedepts();" style="text-decoration: none;">关闭</a>
     </div>
   </div>
   <div  style="overflow: scroll;z-index: 5px;background-color: #d9ebf5;;width: 300px;height: 300px;">
     
     <table id="tabaa" align="left" border="1" style="border: solid 1px;border-color: white;"  width="100%">
     </table>
   </div>
   </div>
   

   <div id="emp" style="position: absolute;left: 600px;top: 200px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:left;font-weight:bold;">选择员工列表</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:hideemps();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   </div>
   
   

   <div id="cyemp" style="position: absolute;left: 480px;top: 600px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" >
     <div style="float:left;font-weight:bold;">选择员工列表</div>
     <div style="float:right;position: absolute;left:160px;"><a href="javascript:closecyemp();" style="text-decoration: none;">关闭</a></div>
   </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
     
     <table id="tab3" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   </div>
   
   
   
   
   
   
  </body>
</html>
