<%@ page language="java" import="java.util.*,com.fuao.fajxc.vo.Department"  pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.fuao.fajxc.utilinterface.PublicMissionType"%>
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
 <div class="container" id="cpcontainer"><div class="itemtitle"><h3>/&gt;福奥科技 - 运维信息管理 </h3></div>
<br/>
<div align="left" style="width: 900" >
  <p class="flip" style="background: #92c0e2">&nbsp;</p>
  <br/>
       <div  style="2px;border-color:green; bdisplay:block"><input class="paixu"   style="width: 120;height: 18;font: bolder;" type="text" value="运维部管理"/>&nbsp;&nbsp;<font size="-1.5" id="fon" color="#2366A8" style="margin-left: 15"><img class="mouseover1"  name="tianjia" id="tianjia" src="<%=basePath%>img/jibie/+.jpg" onclick="addtypes(100)" /><a href="javascript:void(0);" onclick="addtypes(100);">增加新的运维部</a></font>  
       <br/><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/></div>
	   <input type="hidden" name="ckz" id="watcher"/><input type="hidden" name="operid"  id="operid"/><input type="hidden" id="orderids" name="orderids"/>
	   <c:forEach items="${Operationlist}" var="data" >
	      <c:if test="${data.superid==100}">
	          <div class="${data.id}" style="2px;border-color:green; bdisplay:block"><img  name="${data.id}" style="margin-left:35" class="c2" onclick="change2(this,${data.id});" src="<%=basePath%>img/jibie/---.jpg" /><img src="<%=basePath%>img/jibie/2.gif" /><input class="paixu"   style="width: 120;height: 18;font: bolder;" type="text" value="${data.name }"/>&nbsp;&nbsp;<img class="mouseover"  name="${data.id}" src="<%=basePath%>img/jibie/+.jpg" onclick="changeb(${data.id },${data.id });" />&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="seeemps(${data.id})">查看员工</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:showemp2(${data.id}),showEmps(${data.id });" ><font size="-1.5" color="#2366A8">添加或修改员工</font></a><br/><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/></div>
	        <c:forEach items="${Operationlist}" var="type1">
			            <c:if test="${data.id==type1.superid}">
								<div style="display: inline;" class="nn${data.id}" id="dd${type1.id}" style="display:none;" >
								    <img src="<%=basePath%>img/jibie/2.gif" style="margin-left:135"/><input class="paixu" id="mm${type1.id}" style="width: 120;height: 20;font: bolder;" type="text" name="${type1.name}" value="${type1.name}"  onblur="edittypes(this.value,${type1.id},this.name)"/>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="seeemps(${type1.id})">查看员工</a>
						            <font size="-1.5" color="#2366A8" style="margin-left: 150"><a href="javascript:bianji(${type1.id});" >修改运维组</a></font>&nbsp;&nbsp;&nbsp;&nbsp; 
						            <a href="javascript:del(${type1.id});" ><font size="-1.5" color="#2366A8">删除运维组</font></a>
						            <a href="javascript:showemp2(${type1.id}),showEmps(${type1.id });" ><font size="-1.5" color="#2366A8">添加或修改员工</font></a><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/>
							    
								       <c:forEach items="${Operationlist}" var="type2">
								             <c:if test="${type1.id==type2.superid}">
								                   <div style="display: inline;" class="nn${type1.id}" id="dd${type2.id}" style="display:none;" >
													    <img src="<%=basePath%>img/jibie/2.gif" style="margin-left:220"/><input class="paixu" id="mm${type2.id}" style="width: 120;height: 20;font: bolder;" type="text" name="${type2.name}" value="${type2.name}"  onblur="edittypes(this.value,${type2.id},this.name)"/>
											            <a href="javascript:bianji(${type2.id});" ><font size="-1.5" color="#2366A8" style="margin-left: 150">修改运维组</font></a>&nbsp;&nbsp;&nbsp;&nbsp; 
											            <a href="javascript:del(${type2.id});" ><font size="-1.5" color="#2366A8">删除运维组</font></a><hr size="0.2"  style="border: 3px dotted #DEEFFB;noshade" color="#DEEFFB"/>
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
				              window.location.href="getOperationsmissiontype.do";
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
				              window.location.href="getOperationsmissiontype.do";
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
   
        $("div."+c).append('<img  id="img'+c+'"  style="margin-left:135" src="<%=basePath%>img/jibie/2.gif" /><input id="in'+c+'" type="text"   style="width: 120;height: 20;font: bolder;" onblur="outboxs(100,this.value,'+c+')"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
   
   }
   
   function changec(c,n){
       
        $("div#dd"+c).append('<img  id="img'+c+'"  style="margin-left:220" src="<%=basePath%>img/jibie/2.gif" /><input id="in'+c+'" type="text"   style="width: 120;height: 20;font: bolder;" onblur="outboxs(100,this.value,'+c+')"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
   
   }
   function addtypes(c){
        $("#fon").append('<input id="in'+c+'" type="text"   style="width: 120;height: 18;font: bolder;" onblur="outboxs('+c+',this.value,'+c+')"><p style="display: inline;" id="fo'+c+'"><font color="#2366A8" size="-1">提示：若输入完成移开鼠标</font><br/></p>');
 
   }
  
   
   
   function outboxs(p,v,fid){
  
   var tname=encodeURI(v,"utf-8");
        if(v!=null && v!=""){
        $.ajax({
           type:'post',
           url:'addTypesOperationmissiontype.do',
           data:{superid:fid,typeName:tname,isflag:p},
           success:function(res){
               window.location.href="getOperationsmissiontype.do";
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
   
      function hideemps(){
      var operid=$("#operid").val();
      var empids=$("#watcher").val();
      var empnames=$("#look").val();
      var vempnames=encodeURI(empnames,"UTF-8");
      if(empids==""){
      alert("请选择员工");
       
      }else{
      $("#emp").hide();
      $.ajax({
           type:'post',
           url:'addOperationgroupsmissiontype.do',
           data:{operid:operid,empids:empids,empnames:vempnames},
           success:function(data){
               if(data==1){
               alert("添加数据成功");
               }else if(data==2){
               alert("修改数据成功");
               }else{
               alert("操作错误");
               }
           }
        });
      
      }
    } 
    function closeemps(){
       $("#emp").hide();
    }   
    function showEmps(m){
   
      $("#emp").show();
      
      
    }
    
     function showemp2(m){
     $("#operid").val(m);
     $("#tab2").html("");
     $("#look").html("");
     $.post('emplistmissiontype.do',{operid:m},function(data){
       var data1=new Array();
        	 data1=data.split(";");
          $("#tab2").append(data1[0]);
          var len=data1.length;
          var empides="";
          var empnamees="";
          if(len==3){
          empides=data1[1];
          empnamees=data1[2];
          $("#look").val(empnamees);
          var data2=new Array();
          $("#orderids").val(empides);
          data2=empides.split(",");
          var len2=data2.length;
          for(var k=0;k<len2;k++){
          var ides=data2[k];
          $("#"+ides).attr("checked","checked");
          }
          }else{
          $("#look").val("");
          $("#orderids").val("");
          }
       });
   }
	var ordernames="";
    var orderids="";
    function checkEmp(check){
      ordernames=$("#look").val();
      
      orderids=$("#orderids").val();
      var empname = check.value;
      var empeid=check.id;
      if(check.checked==true){
        ordernames+=empname+",";
        orderids+=empeid+",";
      }else if(check.checked==false){
        ordernames=ordernames.replace(empname+",","");
        orderids=orderids.replace(empeid+",","");
      }else{}
     
      $("#look").attr("value",ordernames);
       $("#orderids").attr("value",orderids);
      $("#watcher").attr("value",orderids);
    }
    
    function seeemps(id){
        $.post('seeempsmissiontype.do',{operid:id},function(data){
               if(data==0){
               alert("没有可查看的员工");
               }else{
               var len=data.length;
              // alert(len);
               var data1=data.substring(0,len-1);
               $("#slook").html(data1);
               $("#semps").show();
               }
        
        });
    
    }
    function scloseemps(){
         $("#semps").hide();
    }
	
</script >
    <div id="emp" style="position: absolute;left: 240px;top: 130px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
    <div style="width: 250px;height: 10px;background-color: #C4E1FF; z-index: 10;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;margin-left: 220"><a href="javascript:closeemps();" >关闭</a></div>
    </div>
    <div style="background-color: ;"><textarea id="look" name="look" cols="38" rows="4" readonly="readonly" style="background-color: ;"></textarea></div>
    <div style="width: 250px;height: 20px;background-color: #C4E1FF; z-index: 10;" >
     <div style="float:left;font-weight:bold;">选择员工列表</div>
     <div style="float:right;position: absolute;margin-left: 140"><a href="javascript:hideemps();" >保存</a></div>
    </div>
    <div  style="overflow: scroll;z-index: 5px;background-color: #E8FFF5;width: 250px;height: 350px;">
     <table id="tab2" align="left" border="1" style="border: solid 1px;border-color: #0A0A0A;" width="100%">
     </table>
   </div>
   </div>

 
 
  <div id="semps" style="position: absolute;left: 280px;top: 156px;border-color: red; display: none;border:#E8FFF5 1px solid;margin-bottom: 10px;">
    <div style="width: 250px;height: 15px;background-color: #C4E1FF; z-index: 10;" >
     <div style="float:left;font-weight:bold;"></div>
     <div style="float:right;position: absolute;margin-left: 220"><a href="javascript:scloseemps();" >关闭</a></div>
    </div>
    <div style="background-color:#E8FFF5 ; width: 250px;height:125px;" id="slook" ></div>
    
    
   </div> 
	
  </body>
  
</html>
