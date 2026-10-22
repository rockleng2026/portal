<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>IP管理</title>  
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/icon.css">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/easyui.css">
    <script type="text/javascript" src="<%=basePath%>serm/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>serm/js/jquery.easyui.min.js"></script>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>serm/css/jigui.css">
    <style> 
	<!-- 
	div.IPDiv{background:#FFFFFF; width: 230px; margin:0;   font-family:   Arial,Tahoma;   font-size:   10pt;   text-align:   center;   border-top:   2   ridge   threedshadow;   border-left:   2   ridge   threedshadow;   border-right:   2   inset   threedhighlight;   border-bottom:   2   inset   threedhighlight;}
	div.IPDiv2{background:#FFFFFF;width: 230px; margin:0;   font-family:   Arial,Tahoma;   font-size:   10pt;   text-align:   center;   border-top:   2   ridge   threedshadow;   border-left:   2   ridge   threedshadow;   border-right:   2   inset   threedhighlight;   border-bottom:   2   inset   threedhighlight;}  
	input.IPInput {width:25px;   margin:0;   font-family:   Arial,Tahoma;   font-size:   10pt;   text-align:   center;   border-width:0px;} 
	input.IPs{width:25px;   margin:0;   font-family:Arial,Tahoma;   font-size:   10pt;   text-align:   center;   border-width:0; } 
	#dis{
	  display:none;
	}
	--> 
	</style> 
    <script type="text/javascript">
			IPlikeInputStr = "";   
			IPlikeInputStr1 = "";   
			IPlikeInputStr += '请输入IP号:<div class= "IPDiv ">开始IP号: ';   
			for(i=0;i <4;i++){   
			    IPlikeInputStr += '<input  class= "IPInput"   id= "IPInputsta'+i+'"   type= "text " border="1" size= "3 "   maxlength= "3 "   onkeypress= "keyHandle() "   onkeyup= "checkInput() "> '+((i==3)   ?   ' '   :   '. ');   
			}  
			IPlikeInputStr+='</div>';
			document.write(IPlikeInputStr+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---"); 
			IPlikeInputStr1 +='<div class= "IPDiv2">结束IP号:';
			for(j=0;j<4;j++){
			 IPlikeInputStr1 +='&nbsp;&nbsp;<input type="text" class="IPs" border="1" id="Iplikeinput'+j+'" maxlength="3" onkeypress= "keyHandle() "   onkeyup= "checkInput() ">'+(j==3?'':".");
			}
			IPlikeInputStr1  += '</div>';   
			document.write(IPlikeInputStr1+'<input type="button" class="zjjf-but1" value="查询" id="sect" onclick="checkForms()">');
			function keyHandle()   {   
			    if (event.keyCode <48||event.keyCode > 57)   {   
			        event.returnValue   =   false;   
			    }   
			}   
			function checkForms(){
			   var p=0;
			   var s=0;
			  // alert("lai");
			    for(var i=0;i<4;i++){
				    if($('#IPInput'+i).val()=="" || $('#Iplikeinput'+i).val()==""){
				       p++;
				       if(p==1){
				           s++;
				           $.messager.alert("提示","IP地址不能为空","info");
				       }
				    }
			    }
			  if(s==0){
			       str1="";
			       str2="";
			       for(var j=0;j<4;j++){
			           if(j<3){
					       str1+=$('#IPInputsta'+j).val()+".";
					       str2+=$('#Iplikeinput'+j).val()+".";
				       }else{
					       str1+=$('#IPInputsta'+j).val();
					       str2+=$('#Iplikeinput'+j).val();
				       }
			       }
				   $.ajax({
				      type:"post",
				      url:"cms/show_IPselct.do",
				      data:{startIP:str1,endIP:str2},
				      success:function(res){
				          //alert(res);
				         if(res=="no")
				          {
				           $('#dis').show();
				           var mst='<font color="red" size="5">你输入的IP段目前没有可用IP，请重新填写。</font>';
				            $('#dis').hide();
				           $('#ppmt').html(mst);
				          }else{
				            $('#pms').html('');
				            $('#ppmt').html('');
				          	$('#pms').append(res);
				         	$('#dis').show();
				          }
				          
				         }
				   });
			   }
			}
			function checkInput(){   
			    if   (event.srcElement.name== "IPInputsta0 " || event.srcElement.name=="Iplikeinput0")   {   
			        if(event.srcElement.value==0&&event.srcElement.value.length==3)   {   
			            event.srcElement.value= "1";   
			            $.messager.alert("提示","请输入一个界于1和223之间的数值 ","info");   
			            event.srcElement.select();   
			        }   
			        if(event.scrElement.value> 223){   
			            event.srcElement.value= "223 ";   
			            $.messager.alert("提示","请输入一个界于1和223之间的数值 ","info");   
			            event.srcElement.select();   
			        }   
			    }   
			      
			    else   {   
			        if(event.srcElement.value> 255){   
			            event.srcElement.value= "255 ";   
			            $.messager.alert("提示","请输入一个界于0和255之间的数值 ","info");
			            event.srcElement.select();   
			        }   
			    }   
			}
			function alert(pm){
			    return  $.messager.alert("提示",pm,"info");
			}  
			$(function(){
			    $('#bu').click(function(){
			      var pm = document.getElementsByName("cheb");
			       if($('#bu').val()=="全选"){
				      $.each(pm,function(){
				         $(this).attr("checked","true");
				      });
				      $('#bu').val("取消");
			      }else{
			          $.each(pm,function(){
				        $(this).attr("checked",false);
				      });
				      $('#bu').val("全选");
			       }
			    });
			    $('#subu').click(function(){
                    var pm = document.getElementsByName("cheb");
                    var mtm="";
                    var arr = new Array();
                    $('input[name="cheb"]:checked').each(function(){
                         mtm+=$(this).val()+",";
                    }); 
                    arr = mtm.split(",");
                    if(arr[1]!=""){
	                    var indexofs = mtm.lastIndexOf(',');
	                    if(indexofs>-1){
	                    //去掉最后,
	                       mtm = mtm.substring(0,indexofs)+mtm.substring(indexofs+1,mtm.length);
	                    }
                    }
                   // alert(mtm);   
                   window.returnValue=mtm;
                   window.close();
			    });
			}); 
    </script>
  </head>
  <body>
     <div id="ppmt"></div>
    <div id="dis">
     <div id="pms" style="width:180px;height:200;margin-top:30px;overflow:auto;">
     </div>
     <input type='button' class='zjjf-but1' id='bu' value='全选'>
     <input type='button' class='zjjf-but1' id='subu' value='确定'>
     </div>
  </body>
</html>
