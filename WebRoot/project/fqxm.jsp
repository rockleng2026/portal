<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="java.text.*,java.util.Calendar"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>发起项目页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>Insert title here</title>
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/js/check/css/validationEngine.jquery.css"
			type="text/css" />
		<link rel="stylesheet"
			href="<%=request.getContextPath()%>/js/check/css/template.css"
			type="text/css" type="text/css" />


		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/handlejson.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/cascadingmenu.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/validators.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js" charset="GBK">
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js">
</script>
		<script
			src="<%=request.getContextPath()%>/js/check/js/languages/jquery.validationEngine-zh_TW.js"
			type="text/javascript" charset="GBK">
</script>
		<script
			src="<%=request.getContextPath()%>/js/check/js/jquery.validationEngine.js"
			type="text/javascript" charset="GBK">
</script>
		<LINK href="<%=request.getContextPath()%>/Css/style.css"
			type=text/css rel=stylesheet>
		<LINK href="Css/style.css" type=text/css rel=stylesheet>
    
    
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/date2.js" charset="GBK"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js"></script>
	<script language="javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
	
	<meta content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">


  </head>
  <STYLE>
BODY {
	BACKGROUND-COLOR: #fefefe;
}
.divHang {
	width: 100%;
	height: 30px;
	border-top: 1px #9CF solid;
	border-right: 1px #9CF solid;
}
.divLie {
	width: 18%;
	height: 30px;
	float: left;
	line-height: 25px;
	border-left: 1px #9CF solid;
}
.divLieInput {
	width: 90%;
	margin-top: 5px;
	border: 0px;
}
.leftwz {
	width:150px;
	height:30px;
	line-height:30px;
	border:0px;
	text-indent:25px;
}
.righttk {
	width:150px;
	height:30px;
	line-height:30px;
	border:0px;
}
.tishi {
	width:300px;
	height:30px;
	line-height:30px;
	color:#F00;
	border:0px;
}
.butt {
	width: 122px;
	height:29px;
	background:url(<%=request.getContextPath() %>/images/butt.jpg);
	background-repeat:no-repeat;
	border:0px;
	line-height:25px;
	font-size:12px;
	color:#333;
	margin-left:25px;
	cursor:pointer;
}
</STYLE>
<script type="text/javascript">
   //清空参与人员
 function qk(){
    $("#receiver").val("");
 }
 function changid(obj){
    $("#emp").attr("id","emp0");
    $("#"+obj.id).attr("id","emp");
 }
 // 添加验证
 function addCheck(){	 
	 var prjname=$("#prjname").val();
	 if(prjname.length<=0&&prjname==""){
		 $("#nameMsg").html("项目名称不能为空！");
		 return false;
     }else{
    	 $("#nameMsg").html("");
     }
     var prjmanager=$("#prjmanager").val();
     if(prjmanager==""&&prjmanager.length<=0){
    	 $("#managerMsg").html("项目负责人不能为空！");
		 return false;
     }else{
    	 $("#managerMsg").html("");
     }
     var prjtype=$("#prjtype").val();
     if(prjtype==""&&prjtype.length<=0){
    	 $("#typeMsg").html("项目类型不能为空！");
		 return false;
     }
     var begintime=$("#begintime").val();
     if(begintime==""&&begintime.length<=0){
    	 $("#beginMsg").html("项目开始时间不能为空！");
		 return false;
     }
     var yjtime=$("#yjtime").val();
     if(yjtime==""&&yjtime<=0){
    	 $("#yjMsg").html("预计时间不能为空！");
		 return false;
     }
     var receiver=$("#receiver").val();
     if(receiver==""&&receiver.length<=0){
    	 $("#cyrMsg").html("至少选择一个参与人！");
		 return false;
     }
     var fun=$("#fun").val();
     if(fun==""&&fun.length<=0){
    	 $("#functionMsg").html("请填写项目功能模块！");
		 return false;
     }
     var des=$("#des").val();
     if(des==""&&des.length<=0){
    	 $("#desMsg").html("请描述好你的项目功能！");
		 return false;
     }
     var upload=$("#upload").val();
     var uploadlen=$("#upload").val();
     if(uploadlen.length<=0){
    	 $("#fjMsg").html("请上传与项目有关的文件！");
		 return false;
     }
	 var i= upload.lastIndexOf(".");
	 upload=upload.substr(i, upload.length);
	 if(upload==".bak"||upload==".html"||upload==".jsp"||upload==".exe"||upload==".htm"){
		 $("#fjMsg").html("文件格式不正确！");
		 return false;
	 }else{
		 $("#fjMsg").html("");
	 }
 }
 	// 隐藏参与人
	 function ycry(){
		 $("#sub-dept").hide();
	 }
</script>



  <body leftmargin="0" topmargin="0" rightmargin="0" style="background-color:  white">
  <div style="display:none;position: absolute;left: 450px;top: 140px;" id="sub-dept"> </div>
  <div style=" width:100%; height:33px; background:url(<%=request.getContextPath() %>/images/header3bg.jpg); background-repeat:repeat-x; overflow:hidden; margin:0 auto;">
  <div style=" width:109px; height:33px; background:url(<%=request.getContextPath() %>/images/head3-img.jpg); background-repeat:no-repeat; margin-left:15px; text-indent:30px; line-height:38px; font-size:12px; float:left;">发起项目：</div>
</div>

<form action="<%=request.getContextPath() %>/startPrj.do" method="post" onsubmit="return addCheck();" enctype="multipart/form-data">
<div style=" width:100%; float:left;">
  <table cellSpacing=0 cellPadding=0 align=left border=0 width="600" style=" font-size:12px; margin-top:10px;">
    <tr>
      <td class="leftwz">项目名称：</td>
      <td class="righttk">
      <INPUT style="WIDTH:150px" name="project.prjname" id="prjname" value="" />
      </td>
      <td class="tishi"><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT></td>
    </tr>
    <tr>
      <td class="leftwz">项目负责人：</td>
      <td class="righttk">
        <input style="WIDTH:150px" name="project.prjmanager" id="prjmanager" value="" onclick="changid(this),completemission('showDialogWarehousing.do?mark=employee','')"/>
      </td>
      <td class="tishi"><FONT color=#ff0000>*</FONT>
      <FONT color=#ff0000 id="managerMsg"></FONT></td>
    </tr>
    <tr>
      <td class="leftwz">发起人：</td>
      <td class="righttk">
      <input name="project.startperson" value="${emp.name}" style="width:150px" readonly="readonly"/></td>
      <td class="tishi"></td>
    </tr>
    <tr>
      <td class="leftwz">项目所属部门：</td>
      <td class="righttk">
      
       <select id="" name="project.dept.id" style="WIDTH: 100px">
       <s:iterator value="deptlist" var="dept">
         <option value="<s:property value='#dept.id'/>">
           <s:property value="#dept.name"/>
         </option>
         </s:iterator>
       </select>

     </td>
      <td class="tishi"></td>
    </tr>
    <tr>
      <td class="leftwz">项目类型：</td>
      <td class="righttk">
      <input name="project.prjtype" id="prjtype" style="WIDTH: 150px"  value=""/>
      </td>
      <td class="tishi">
      <FONT color=#ff0000>*</FONT>
      <FONT color=#ff0000 id="typeMsg"></FONT></td>
    </tr>
    <tr>
      <td class="leftwz">开始时间：</td>
      <td class="righttk">
      <input style="WIDTH: 150px" name="project.begintime" id="begintime" value="" readonly="true" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" readonly="true"/></td>
      <td class="tishi"><FONT color=#ff0000>*</FONT>
      <FONT color=#ff0000 id="beginMsg"></FONT></td>
    </tr>
    <tr>
      <td class="leftwz">结束时间：</td>
      <td class="righttk">
      <input style="WIDTH: 150px" name="project.endtime" id="" value="" onclick="WdatePicker()" readonly="true" >
      </td>
      <td class="tishi"></td>
    </tr>
    <tr>
      <td class="leftwz">预计结束时间：</td>
      <td class="righttk">
      <input style="WIDTH: 150px" name="project.yjendtime" value="" id="yjtime" onfocus="ycry()"  onclick="WdatePicker()" readonly="true"></td>
      <td class="tishi"><FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="yjMsg"></FONT></td>
    </tr>
    <tr>
      <td class="leftwz">参与人员：</td>
      <td class="righttk">
      <input type="hidden" name="cyr" id="ryid" value="">
        <input type="text" style="width: 150px" name="people" id="receiver" readonly="true"/></td>
      <td class="tishi"><FONT color=#ff0000 id="cyrMsg"></FONT><input type="button"  value="清空" onclick="qk()"/></td>
    </tr>
    <tr>
      <td class="leftwz">监督领导名称：</td>
      <td class="righttk">
      <input type="text" name="project.leadname" id="emp2" onfocus="ycry()" onclick="changid(this),completemission('showDialogWarehousing.do?mark=prjemp','')" style="width: 150px"/></td>
      <td class="tishi"></td>
    </tr>
    <tr>
      <td style=" width:150px; height:80px; text-indent:25px;">项目功能：</td>
      <td colspan="2" style="height:80px;">
      <textarea id="fun" name="project.prjfunction" cols="50" rows="4" onfocus="ycry()"  value=""></textarea>
      <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="functionMsg"></FONT>
      </td>
    </tr>
    <tr>
      <td style=" width:150px; height:80px;  text-indent:25px;">项目描述：</td>
      <td colspan="2" style=" height:80px;">
      <textarea id="des" name="project.prjdes" cols="50"  onfocus="ycry()" rows="4" value=""></textarea>
      <FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="desMsg"></FONT>
      </td>
    </tr>
    <tr>
      <td colspan="3" style=" height:30px;"><br>
      
      <br></td>
    </tr>
<tr>
      <td class="leftwz">
                   上传附件:            
      </td>
      <td colspan="2" style=" height:80px;">
         <s:file name="upload" label="文件上传" size="20" id="upload" value=" " /> 
         <FONT color=#ff0000 id="fjMsg"></FONT> 
      </td>
    </tr>
  </table>
  <jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
</div>
<div style=" float:left; width:100% ; height:40px; line-height:40px;">
  <input type="submit" value="确认添加 " class="butt"/>
  <input type="reset" value=" 重  置" class="butt" />   
</div>

</form>


<script type="text/javascript">
		   $("#sub-dept").load("alldeptmessageDepartment.do");
		   $(function(){
		      $("#receiver").click(function(){
		          $("#sub-dept").show();
		      });
		       $("#specialty,#lend,#endtime").click(function(){
		          $("#sub-dept").hide();
		      });
		   })
		 </script>

    
  </body>
</html>
