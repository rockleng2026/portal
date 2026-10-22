<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Department"  pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'newmissiontypelist.jsp' starting page</title>
   <meta http-equiv="Content-Type" content="text/html; charset=GBK">

	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/validators.js"></script>
	<link type="text/css" rel="stylesheet" href="<%=basePath%>Css/missionuse.css" />
	<script type="text/javascript">
   $(document).ready(function(){
   
    
   $("img.mouseover").mouseover(function(){
   
   $(this).after('<div  class="addp" style="display: inline;z-index:2;"  ><font size="-1" color="#FF6600">添加子模块</font></div>');
   });
     
   $("img.mouseover").mouseout(function(){
   
   $("div").remove(".addp");
   });
   
   $("input.paixu").mouseover(function(){
   $(this).css("border-color","#2366A8");
    $(this).css("color","#2366A8");
  });
   $("input.paixu").mouseout(function(){
    $(this).css("color","#333");
    $(this).css("border-color","#ccc");
    });
});

</script >
<style type="text/css">

A IMG {
	BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; BORDER-TOP: medium none; BORDER-RIGHT: medium none
}
INPUT {
	BORDER-BOTTOM: #ccc 1px solid; BORDER-LEFT: #666 1px solid; PADDING-BOTTOM: 2px; PADDING-LEFT: 2px; PADDING-RIGHT: 2px; BACKGROUND: #f9f9f9; COLOR: #333; BORDER-TOP: #666 1px solid; BORDER-RIGHT: #ccc 1px solid; PADDING-TOP: 2px; resize: none
}
 
</style>
 </head >
 <body >
 <div class="container" id="cpcontainer"><div class="itemtitle"><h3>/&gt;福奥科技 - 类型信息管理 </h3></div>
<br/>
<div align="left" style="width: 900" >
  <p class="flip" style="background: #92c0e2">&nbsp;</p>
  <br/>
       <div  style="2px;border-color:green; bdisplay:block"><input class="paixu"   style="width: 120;height: 18;font: bolder;" type="text" value="类型管理"/>&nbsp;&nbsp;<font size="-1.5" id="fon" color="#2366A8" style="margin-left: 30"><a href="javascript:void(0);" onclick="addtypes(-1);">增加新的类型</a></font>  
       <br/><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/></div>
	   <c:forEach items="${typelist}" var="data" >
	      <c:if test="${data.superid==-1}">
	          <div class="${data.id}" style="2px;border-color:green; bdisplay:block"><img  name="${data.id}" style="margin-left:35" class="c2" onclick="change2(this,${data.id});" src="<%=basePath%>img/jibie/---.jpg" /><img src="<%=basePath%>img/jibie/2.gif" /><input class="paixu"   style="width: 120;height: 18;font: bolder;" type="text" value="${data.name }"/>&nbsp;&nbsp;<img class="mouseover"  name="${data.id}" src="<%=basePath%>img/jibie/+.jpg" onclick="changeb(${data.id },${data.id });" /><br/><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/></div>
	        <c:forEach items="${typelist}" var="type1">
			            <c:if test="${data.id==type1.superid}">
								<div style="display: inline;" class="nn${data.id}" id="dd${type1.id}" style="display:none;" >
								    <img src="<%=basePath%>img/jibie/2.gif" style="margin-left:135"/><input class="paixu" id="mm${type1.id}" style="width: 120;height: 20;font: bolder;" type="text" name="${type1.name}" value="${type1.name}"  onblur="edittypes(this.value,${type1.id},this.name)"/>&nbsp;&nbsp;<img class="mouseover"  name="${data.id}" id="tianjia${type1.id}" src="<%=basePath%>img/jibie/+.jpg" onclick="changec(${type1.id },this.name)" />
						            <a href="javascript:bianji(${type1.id});" ><font size="-1.5" color="#2366A8" style="margin-left: 150">修改</font></a>&nbsp;&nbsp;&nbsp;&nbsp; 
						            <a href="javascript:del(${type1.id});" ><font size="-1.5" color="#2366A8">删除</font></a><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/>
							    
								       <c:forEach items="${typelist}" var="type2">
								             <c:if test="${type1.id==type2.superid}">
								                   <div style="display: inline;" class="nn${type1.id}" id="dd${type2.id}" style="display:none;" >
													    <img src="<%=basePath%>img/jibie/2.gif" style="margin-left:220"/><input class="paixu" id="mm${type2.id}" style="width: 120;height: 20;font: bolder;" type="text" name="${type2.name}" value="${type2.name}"  onblur="edittypes(this.value,${type2.id},this.name)"/>
											            <a href="javascript:bianji(${type2.id});" ><font size="-1.5" color="#2366A8" style="margin-left: 150">修改</font></a>&nbsp;&nbsp;&nbsp;&nbsp; 
											            <a href="javascript:del(${type2.id});" ><font size="-1.5" color="#2366A8">删除</font></a><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/>
								                   </div>
								             </c:if>
								       </c:forEach>
							    </div>
					    </c:if>
	        </c:forEach>
	      </c:if>
	   </c:forEach> 
</div>    
	  <div style="position:absolute;display:none; left:0px; top:0px;" id="tranDiv"><div style="position:absolute;left:0px; top:0px; width:100%; height:100%;background-color:#000000;filter:alpha(Opacity=30)" id="tranDivBack"> </div> <div align='center'style='position:absolute;left:0px; top:0px; width:100%; height:100%; background-color:#DEEFFB;'  id='infoDiv'></div> </div> 
	  <div id="popLayer" style="display:none">
	  <form id="formdl" name="formdl" method="post" action="">
	  <br /><font align="center" color="#666666" size="3">
	  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<b>部门职位人员表</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img  type="button" name="Submit1" class="bntccanniu" src="<%=basePath%>img/jibie/+.jpg" onclick="closeWindow();"/> <br />
	 
	    
	    
	  <p id="textp"></p>

	  
	    </form>
      </div> 
	<script type="text/javascript">
    
	
	function del(ids){
			if(confirm("确定删除吗？")==true){
			   $.ajax({
				           type:'post',
				           url:'deltypesmissiontype.do',
				           data:{typeid:ids},
				           success:function(res){
				              window.location.href="getProjectlistmissiontype.do";
				           }
               });
			 }
	}
	
    function bianji(id){
   
            $("#mm"+id).val("");
            $("#mm"+id).focus();
            
     }
	
	function edittypes(v,id,name){

	         if(v!=null && v!=""){    
	              var vname=encodeURI(v,"utf-8");
	              $.ajax({
		                   type:'post',
				           url:'edittypesmissiontype.do',
				           data:{typeid:id,typename:vname},
				           success:function(res){
				               window.location.href="getProjectlistmissiontype.do";
				          }
                  });
              }
              else{
              alert("输入不能为空");
              $("#mm"+id).val(name);
              }    
	}
  


   function change2(c,d){
   
   c.src=c.src=="<%=basePath%>img/jibie/+++.jpg"?"<%=basePath%>img/jibie/---.jpg":"<%=basePath%>img/jibie/+++.jpg";
   $("div.nn"+d).slideToggle("slow");
   
   }
   

   

  
   function changeb(c,n){
   
        $("div."+c).append('<img  id="img'+c+'"  style="margin-left:135" src="<%=basePath%>img/jibie/2.gif" /><input id="in'+c+'" type="text"   style="width: 120;height: 20;font: bolder;" onblur="outboxs('+n+',this.value,'+c+')"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
   
   }
   
   function changec(c,n){
       
        $("div#dd"+c).append('<img  id="img'+c+'"  style="margin-left:220" src="<%=basePath%>img/jibie/2.gif" /><input id="in'+c+'" type="text"   style="width: 120;height: 20;font: bolder;" onblur="outboxs('+n+',this.value,'+c+')"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
   
   }
   function addtypes(c){
        $("#fon").append('<input id="in'+c+'" type="text"   style="width: 120;height: 18;font: bolder;" onblur="outboxs('+c+',this.value,-1)"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
 
   }
  
   
   
   function outboxs(p,v,fid){
  
   var tname=encodeURI(v,"utf-8");
        if(v!=null && v!=""){
        $.ajax({
           type:'post',
           url:'addTypesmissiontype.do',
           data:{superid:fid,typeName:tname,isflag:p},
           success:function(res){
                window.location.href="getProjectlistmissiontype.do";
           }
        });
        }else{
         if(confirm("请填写内容")==false){
         
          $("img#img"+fid).remove();
       		 $("#in"+fid).remove();
       		  $("#fo"+fid).remove();
         }
        }
   }
   
     
 
   
	
	var div_width = 300;
	var div_height = 200;
	function showWindow(width,height){
	 location.href="#";width = div_width;
	 height = div_height;
	 var windowstr= document.getElementById("popLayer").innerHTML;
	 document.getElementById("infoDiv").innerHTML=windowstr; 
	 document.getElementById("infoDiv").style.left=((document.body.clientWidth-width)>0?(document.body.clientWidth-width):0)/2+"px";
	  document.getElementById("infoDiv").style.top=200+"px"; document.getElementById("infoDiv").style.zIndex=10001;
	  document.getElementById("infoDiv").style.width=width; document.getElementById("infoDiv").style.height=height;
	   document.getElementById("infoDiv").style.border="3px solid #C7E4F8";
	   document.getElementById("tranDiv").style.height=document.body.clientHeight+ "px";
	    document.getElementById("tranDiv").style.width=document.body.clientWidth+ "px"; 
	    document.getElementById("tranDiv").style.display=""; 
	    document.getElementById("tranDivBack").style.display=""; 
	    document.getElementById("tranDivBack").style.zIndex=10000;
	    document.getElementById("infoDiv").style.display=""; } 
	function closeWindow(){ document.getElementById("tranDiv").style.display="none"; 
	
	$("#textp").remove(this);
	} 
</script >
<!-- 弹出层 -->
<div id="floatDiv">
<script type="text/javascript">
function showbox(id){
	    alert(id);
		$("#TB_overlayBG").css({
			display:"block",height:$(document).height()
		});
		$(".box").css({
			left:($("body").width()-$(".box").width())/2-20+"px",
			top:($(window).height()-$(".box").height())/2+$(window).scrollTop()+"px",
			display:"block"
		});
		var tt = (new Date()).getTime();
		    var url = "getDeptPosition.do?deptid="+id+"&tt="+tt;
			$("#postionDiv").load(url);
	} 
$(function(){
	
	
	$(".close").click(function(){
		$("#TB_overlayBG").css("display","none");
		$(".box ").css("display","none");
	});
	$(".submitclick").click(function(){
	   if(addValidators2('form0')){
	   	var content  = $("#content0").val();
	   	if( content == null || content == ''){
	   		alert("请填写工作概述!");
	   		return false;
	   	}
	   	//alert(content);
	   	var reg=new RegExp("<br />","g"); 
	   	content = content.replace(reg,"\r\n");
	   	$("#workcontent0").val(content);
	   	//
	   	//var url = "xx.do?tt"+(new Date().getTime());
	   	//$.post(url,{},function(data){});
	   	 $("#form0").submit();
	   }
	});
});
</script>
<p><style type="text/css">
*{margin:0;padding:0;list-style-type:none;}
a,img{border:0;}
a{color:#5e5e5e;text-decoration:none;}
a:hover{color:#3366cc;text-decoration:underline;}
/* box */
.box{position:absolute;width:468px;left:50%;height:auto;z-index:100;background-color:#fff;border:1px #8FA4F5 solid;padding:1px;}
.box h2{height:25px;font-size:14px;background-color:#3366cc;position:relative;padding-left:10px;line-height:25px;color:#fff;}
.box h2 a{position:absolute;right:5px;font-size:12px;color:#fff;}
.box .mainlist{padding:10px;}
.box .mainlist li{height:24px;line-height:24px;}
.box .mainlist li span{margin:0 5px 0 0;font-family:"宋体";font-size:12px;font-weight:400;color:#ddd;}
#TB_overlayBG{background-color:#666;position:absolute;z-index:99;left:0;top:0;display:none;width:100%;height:100%;opacity:0.5;filter: alpha(opacity=50);-moz-opacity: 0.5;}
</style></p>
<div id="TB_overlayBG">&nbsp;</div>
<div style="display:none" class="box">
<h2>职位管理<a class="close" href="javascript:void(0)">关闭</a></h2>
<div class="mainlist" id="postionDiv">

</div>
<div>
</div>
</div>
</div>
	
	<script type="text/javascript">
		function add(id){
			var tt = (new Date()).getTime();
		    var url = "getDeptPosition.do?deptid="+id+"&tt="+tt;
			$("#postionDiv").load(url);
			$("#TB_overlayBG").css({display:"block",height:$(document).height()});
		    $(".box").css({
			left:($("body").width()-$(".box").width())-20+"px",
			top:($(window).height()-$(".box").height())+$(window).scrollTop()+"px",
			display:"block"
		   });
		}
	</script>
	
  </body>
  
</html>
