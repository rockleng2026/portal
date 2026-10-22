<%@ page language="java" import="java.util.*" contentType="text/html; charset=gbk" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>">
    <title>发送公告</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>potal/js/jquery.min.js"></script>
	<script charset="utf-8" src="<%=request.getContextPath()%>/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="<%=request.getContextPath() %>/kindeditor/lang/zh_CN.js"></script>
<style>
body{width:760px; margin:0 auto; font-size:12px}
img{border:0}
ul ,ul li{ margin:0px; padding:0px; list-style:none;}
.toplv{color:#3d8a00}
.topcheng{color:#ff6500}
.tab_bg{ background-color:#f3f3f3}
.dow_top{width:750px; height:26px; background:#3c8301; padding-left:10px; float:left; line-height:26px; color:#FFFFFF; font-size:12px; font-weight:bold; overflow:hidden}
.dow_top span{float:right; padding-right:10px; padding-top:1px;}
.dow_top a{color:#FFFFFF; font-size:14px; font-weight:bold; text-decoration:none}
.xz_k {line-height:25px; overflow-y:auto; padding-left:15px;}
.xzbm{ padding-left:10px; background-color:#eafed9}
.img{ padding-top:2px;}
.tab_border{ border:1px solid #a0a0a0;}
.cheng{color:#ff6606}
.tdbgc{ background-color:#e9e9e9;}
.l{ float:left}
.r{ float:right; padding-right:15px;}
.wtab{ border:1px solid #436b22;}
.cc{ border-bottom:1px solid #a0a0a0}
.xzbmm{ padding-left:10px;}
.gb_btl{ background-color:#4FA805; font-weight:bold; color:#fff; width:48px; line-height:22px; text-align:center; float:right;margin-right:10px; border:0}
.gb_btr{ background-color:#4FA805; font-weight:bold; color:#fff; width:58px; line-height:22px; text-align:center; margin-left:10px; float:left; border:0}
</style>
  </head>
  <script type="text/javascript">
  //编辑器
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
  
  
  
  //点击通知部门的text,显示出所有部门
     function getdept(){
       $.post('deptlistnotice.do',{},function(data){
          $("#tabaa").append(data);
          $("#searchDiv").show();
       });
     }
     
     function selectDept(){
       var deptname = $("#cxbm").val();
       var value = encodeURI(deptname,"utf-8");
       $.post('deptlistnotice.do',{'deptname':value},function(data){
           $("#tabaa").html(data);
           $("#searchDiv").show();
       });
     }
     
     //清空查询部门的text
     function qk(){
       $("#cxbm").val("");
     }
   
   //显示部门层
   function showdepts(){
      $("#searchDiv").show();
   }
   //隐藏部门层
   function hidedepts(){
      $("#searchDiv").hide();
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
       $("#deptname").attr("value",dept);
       $("#deptid").attr("value",deptid);
    }
    
    
     //点击发布 
    function send(){
       var deptid = $("#deptid").val();
       form1.submit();
    }
    
    function checkFormData(){
       var tzbm = $("#deptname").val();
       if(tzbm.length<=0 && tzbm==""){
          $("#tzbm").html("请选择要通知的部门");
          return false;
       }else{
          $("#tzbm").html("");
       }
       
       var zt = $("#title").val();
       if(zt.length<=0 && zt==""){
           $("#zt").html("请填写标题");
           return false;
       }else{
           $("#zt").html("");
       }
       
       var gglx = $("#type").val();
       if(gglx==-1){
          $("#gglx").html("请选择公告类型");
          return false;
       }else{
          $("#gglx").html("");
       }
       
       editor.sync(); 
       var nr = $("#content").val();
       if(nr.length<=0 && nr==""){
          $("#nr").html("请填写公告内容");
          return false;
       }else{
          $("#nr").html("");
       }
       
       send();
    }
    
   function checkFormData2(){
       var tzbm = $("#deptname").val();
       if(tzbm.length<=0 && tzbm==""){
          $("#tzbm").html("请选择要通知的部门");
          return false;
       }else{
          $("#tzbm").html("");
       }
       
       var zt = $("#title").val();
       if(zt.length<=0 && zt==""){
           $("#zt").html("请填写标题");
           return false;
       }else{
           $("#zt").html("");
       }
       
       var gglx = $("#type").val();
       if(gglx==-1){
          $("#gglx").html("请选择公告类型");
          return false;
       }else{
          $("#gglx").html("");
       }
       
       editor.sync();
       var nr = $("#content").val();
       if(nr.length<=0 && nr==""){
          $("#nr").html("请填写公告内容");
          return false;
       }else{
          $("#nr").html("");
       }
       saveDraft();
    }
    
    //点击存草稿
    function saveDraft(){
       var deptid = $("#deptid").val();
       var t = encodeURI(encodeURI($("#title").val(),"utf-8"));
       var typeid = $("#type").val();
       var c = encodeURI(encodeURI($("#content").val(),"utf-8"));
       window.location.href="saveDraftnotice.do?deptid="+deptid+"&title="+t+"&type="+typeid+"&content="+c;
    }
    
    
    
    
    //添加附件,显示遮挡层
    function showDIV(){
       $("#noticefj").show();
    }
    
    
  </script>
  
  <script type="text/javascript">
function showid(idname){
	var isIE = (document.all) ? true : false;
	var isIE6 = isIE && ([/MSIE (\d)\.0/i.exec(navigator.userAgent)][0][1] == 6);
	var newbox=document.getElementById(idname);
	newbox.style.zIndex="9999";
	newbox.style.display="block"
	newbox.style.position = !isIE6 ? "fixed" : "absolute";
	newbox.style.top =newbox.style.left = "50%";
	newbox.style.marginTop = - newbox.offsetHeight / 2 + "px";
	newbox.style.marginLeft = - newbox.offsetWidth / 2 + "px";  
	var layer=document.createElement("div");
	layer.id="layer";
	layer.style.width=layer.style.height="100%";
	layer.style.position= !isIE6 ? "fixed" : "absolute";
	layer.style.top=layer.style.left=0;
	layer.style.backgroundColor="#000";
	layer.style.zIndex="9998";
	layer.style.opacity="0.6";
	document.body.appendChild(layer);
	var sel=document.getElementsByTagName("select");
	//隐藏下拉框
//	for(var i=0;i<sel.length;i++){        
//	sel[i].style.visibility="hidden";
//	}
	function layer_iestyle(){      
	layer.style.width=Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth)
	+ "px";
	layer.style.height= Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight) +
	"px";
	}
	function newbox_iestyle(){      
	newbox.style.marginTop = document.documentElement.scrollTop - newbox.offsetHeight / 2 + "px";
	newbox.style.marginLeft = document.documentElement.scrollLeft - newbox.offsetWidth / 2 + "px";
	}
	if(isIE){layer.style.filter ="alpha(opacity=60)";}
	if(isIE6){  
	layer_iestyle()
	newbox_iestyle();
	window.attachEvent("onscroll",function(){                              
	newbox_iestyle();
	})
	window.attachEvent("onresize",layer_iestyle)          
	}  
	layer.onclick=function(){newbox.style.display="block";layer.style.display="block";for(var i=0;i<sel.length;i++){
	sel[i].style.visibility="visible";
	}}
	}
</script>
  
  
  <body>
    <div>
<span class="toplv">您的位置</span>：首页><span class="topcheng">发布公告</span></div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="wtab">
  <tr>
    <td colspan="2"><div class="dow_top"> <span></span> 发布公告 </div></td>
  </tr>
  <tr>
  
  
  <form action="<%=request.getContextPath()%>/sendToAuditnotice.do?flg=0" method="post" id="form1" onsubmit="return checkFormData();">
    <td width="618" height="199"><table width="100%" border="0" cellspacing="8" cellpadding="5" class="tab_bg">
      <tr>
        <td width="17%" align="right">通知部门:</td>
        <td width="83%"><label for="textfield"></label>
          <input name="deptname" type="text" id="deptname" size="60" onclick="getdept()" readonly="readonly"/>
          <input type="hidden" id="deptid" name="deptid" value=""/>
          <br/>
          <font color="red" size="2">
           <span style="color:red;" id="tzbm" >
          
           </span>
           </font>
          </td>
      </tr>
      <tr>
        <td align="right">主题:</td>
        <td>
          <input name="notice.title" type="text" id="title" size="60" />
          <br/>
          <font color="red" size="2">
           <span style="color:red;" id="zt" >
          
           </span>
           </font>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><img src="<%=request.getContextPath()%>/potal/page/notice/images/bjgg_@.png" width="13" height="13" /> 
        <span class="cheng"><a href="javascript:showDIV();">添加附件</a></span>
        </td>
      </tr>
     
      <tr>
        <td align="right">公告类型:</td>
        <td><select name="notice.typeid" id="type">
          <option value="-1">请选择</option>
          <option value="1">公司公告</option>
          <option value="2">部门公告</option>
        </select>
        <br/>
        <font color="red" size="2">
           <span style="color:red;" id="gglx" >
          
           </span>
           </font>
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">正文:</td>
        <td>
           <textarea name="notice.content" id="content" class="textarea" style='width:450px;height:200px;visibility:hidden;'></textarea>
           
        <br/>
        <font color="red" size="2">
           <span style="color:red;" id="nr" >
          
           </span>
           </font>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        
        <td>
        <table width="95%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><input type="button" name="button" id="button" value="发布" onclick="checkFormData()"  class="gb_btl"/></td>
            <td><input type="button" name="button2" id="button2" value="存草稿"class="gb_btr" onclick="checkFormData2()"/></td>
          </tr>
        </table>
        
        </td>
      </tr>
    </table>
    </td>
    </form>
    
     
    <div style="display: block;">
	    <td width="20%" align="center" valign="top"><br /><table width="95%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="79%"><label for="textfield4"></label>
	         &nbsp;&nbsp; 
	         <input name="cxbm" type="text" id="cxbm"  value="" size="14" maxlength="8" onclick="qk()"/></td>
	        <td width="21%">
	        <img src="<%=request.getContextPath()%>/potal/page/notice/images/bjgg_ss.png" width="22" height="22" onclick="selectDept()" />
	        </td>
	      </tr>
	    </table>
	    <label for="textfield4"></label>
	    <br />
	    
	    <div id="searchDiv" class="searchDiv"  style="position: absolute;left: 600px;top: 80px;border-color: red; display: none;border:#89aad7 1px solid;margin-bottom: 10px;">
	  
	   <div style="width: 200px;height: 10px;background-color: #E8FFF5; z-index: 10;" align="right">
	   

	   <div style="float:right;position: absolute;left:160px;">
	     <a href="javascript:hidedepts();" style="text-decoration: none;">关闭</a>
	     </div>
	  
	   </div>
	   <div  style="overflow: scroll;z-index: 5px;background-color: #C4E1FF;width: 200px;height: 300px;">
	     
	     <table id="tabaa" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
	     </table>
	   </div>
	   </div>
	    
	    </td>
	    
    </div>
    
    
    
  </tr>
</table>




<!-- 上传附件的层 -->
<div class="wbbd" id="noticefj" style="display: none;">
<div class="rz_box">
	<div class="title" >上传附件</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="list">
     <tr>
       <td width="13%">&nbsp;</td>
       <td width="77%" align="right">
          <jsp:include page="/potal/page/notice/uploadfile.jsp"></jsp:include>
       </td>
       <td width="10%">&nbsp;</td>
     </tr>
   </table>
</div>
</div>
 
  </body>
</html>
