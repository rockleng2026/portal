<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>模块添加</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="./cms/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="./cms/css/icon.css">
	<script type="text/javascript" src="./cms/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript"src="./cms/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
    <style type="text/css">
      #dv1{
         display:none;
      }
      #dv2{
        display:none;
      }
    </style>
  </head>
  <script type="text/javascript">
     function checkName(){
       var modelname = document.getElementById("name");
       
       var name=$("#name").val();
       name=encodeURI(name);
       if(name=="" || name==null){
          /// modelname.focus();
           $.messager.alert("错误","请填写名称!","error");
       }else{
          $.post('cms/checkNameModel.do',
              {'model.modelname':name},
              function(data){
                if(data=="ERROR"){
                  alert("模块名称已经存在,不能重复添加!");
                  modelname.focus();
                }
              });
       }
     }
     //一级
     function checkmenu(){
        $('#dv1').hide();
        $('#dv2').hide();
       var menu='010000';
         $.ajax({
         type:"post",
         data:{"menu":menu},
         url:"cms/checkICOModel.do",
         success:function(data){
            $("#ico").val(data);
         }
       });
      }
     
     
     $(function(){
	     //二级
	     $('#menu2').click(function(){
	      $('#dv2').hide();
	      $('#dv1').show();
	      $("#ico").val("");
	     if(document.getElementById("menu").options.length==1){
	         $.ajax({
	            type:'post',
	            url:'cms/getoneMenusModel.do',
	            data:'',
	            success:function(res){
	                //加到一级
	               $.messager.alert('提示','接下来单击 " 菜单一  "  选择项目','info',function(m){ 
	                    $("#menu").append(res); 
	               });
	            },
	            error:function(){
	                $.messager.alert('读取出错了，请联系技术人员.');
	            }
	         });
	         }
	     });
	 
	    //显示二级码
	      $('#menu').change(function(){
	             var mmt = $('#menu option:selected').val();
	             //alert("mmt="+mmt);
		          $.ajax({
			            type:'post',
			            url:'cms/addTwoMenusModel.do',
			            data:{mid : mmt},
			            success:function(res){
			             $("#ico").val(res);
			            },
			            error:function(){
			                $.messager.alert('读取出错了，请联系技术人员.');
			            }
			         });
	      });
	
	     //三级
	      $('#menu3').click(function(){
	          $('#dv1').hide();
	          $('#dv2').show();
	          $("#ico").val("");
	           // alert("3");
	            if(document.getElementById("menu4").options.length==1){
	            $.ajax({
	            type:'post',
	            url:'cms/getoneMenusModel.do',
	            success:function(res){
	               //加到一级
	              $.messager.alert('提示','接下来单击  " 菜单一再单击菜单二  " 选择项目','info',function(m){
	                 $("#menu4").append(res); 
	               }); 
	            },
	            error:function(){
	                $.messager.alert('读取出错了，请联系技术人员.');
	            }
	         });
	         }
	     });
	     //显示二级
	     $('#menu4').change(function(){
	             var mmt = $('#menu4 option:selected').val();
	              $("#ico").val("");
	              $('#menu5').empty();
	              $('#menu5').append("<option value='0'>请选择</option>");;
		          $.ajax({
			            type:'post',
			            url:'cms/getoneandTwoMenusModel.do',
			            data:{mid : mmt},
			            success:function(res){
			             $('#menu5').append(res);
			            },
			            error:function(){
			                $.messager.alert('读取出错了，请联系技术人员.');
			            }
			         });
	      });
	  //显示二级码
	     $('#menu5').change(function(){
	             var mmt = $('#menu5 option:selected').val();
	             if(mmt!=0){
	             //alert("mmt="+mmt);
		          $.ajax({
			            type:'post',
			            url:'cms/addThreeMenusModel.do',
			            data:{mid : mmt},
			            success:function(res){
			             $("#ico").val(res);
			            },
			            error:function(){
			                $.messager.alert('读取出错了，请联系技术人员.');
			            }
			         });
			         }
	      });
     });
       
     function checknc(){
       var nc = $("#nc").val();
       if(nc=="mblb"){
         document.getElementById("url").value="getAllListTemplate.do";
        // document.getElementById("url").readOnly=true;
       }
       
     }
     
  </script>
  
  
  <body bgcolor="#eeeeee">
     <form action="cms/modelAddModel.do" method="post">
       <table align="center" border="0">
         <tr>
           <td>
              &nbsp;
           </td>
           <td align="right" colspan="2">模块名称:</td>
           <td>
            <input type="text" name="model.modelname" id="name" onblur="checkName()"/>
           </td>
           <td>
            <div id="modelname"></div>
           </td>
           <td>
             &nbsp;
           </td>
         </tr>
         <tr>
           <td>
              &nbsp;
           </td>
           <td align="right" colspan="2">模块昵称:</td>
            <td colspan="2">
             <input type="text" name="model.modelalias" id="nc" onblur="checknc()"/>
             <font color="red" size="2">如果URL以.do结束,昵称必须为mblb</font>
           </td>
            
         </tr>
         <tr> 
           <td>&nbsp;</td>
           <td>菜单选项:</td>
           <td colspan="3">
             <input type="button" value="只增加一级菜单" onclick="checkmenu()">
             <input type="button" value="只增加二级菜单" name="menu2" id="menu2">
             <input type="button" value="只增加三级菜单" name="menu3" id="menu3">
           </td>
         </tr>
         <tr>
           <td></td>
           <td colspan="3">
           <div id="dv1">  
                                 菜单一
             <select name="menu" id="menu">
               <option value="0">请选择</option>              
             </select>
            </div> 
            <div id="dv2">
                                菜单一&nbsp;&nbsp;&nbsp;&nbsp;
            <select name="menu4" id="menu4">
               <option value="0">请选择</option>              
             </select>                  
                                菜单 二&nbsp;&nbsp;&nbsp;&nbsp;
              <select name="menu5" id="menu5" >
               <option value="0">请选择</option>              
             </select>  
             </div>
             </td>          
         </tr>
         <tr>
           <td>
              &nbsp;
           </td>
           <td align="right" colspan="2">模块ICO:</td>
           <td colspan="2"><input type="text" name="model.modelico" id="ico" readonly="readonly"/></td>
         </tr>
         <tr>
           <td>
              &nbsp;
           </td>
           <td align="right" colspan="2">模块URL:</td>
           <td><input type="text" name="model.modelurl" id="url"/></td>
             <td>
              &nbsp;
           </td>
         </tr>
         <tr>
           <td>
              &nbsp;
           </td>  
           <td>
              &nbsp;
           </td>
           <td colspan="4" align="left"><input type="submit" value="保存" style="background-color: #eeeeee"/></td>
           <td>
              &nbsp;
           </td>
         </tr>
       
       </table>
     </form>
  </body>
</html>
